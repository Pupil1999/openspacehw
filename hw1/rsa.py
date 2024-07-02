from Crypto.PublicKey import RSA
from Crypto.Signature import pkcs1_15
from Crypto.Hash import SHA256

if __name__ == '__main__':
    # Generate RSA key pair
    key = RSA.generate(2048)
    private_key = key.export_key()
    public_key = key.publickey().export_key()

    nonce = 0
    nickname = "Bimarwin"
    signature: any

    # Get the hash val started with four zero, which is to be signed.
    while True:
        msg = (nickname + str(nonce)).encode('utf-8')
        hasher = SHA256.new(msg)
        hash_val = hasher.hexdigest()

        if hash_val[0:1] == '0':
            print("The message to be signed is: " + hash_val)

            # Generate the signature of the message under RSA signature
            signature = pkcs1_15.new(key).sign(hasher)
            break
        else:
            nonce += 1

    # Verifying the signature of the message with the public key.
    try:
        pkcs1_15.new(key.public_key()).verify(hasher, signature)
        print("Valid signature!")
    except (ValueError, TypeError):
        print("Invalid signature!")