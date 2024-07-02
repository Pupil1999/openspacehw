from Crypto.Hash import SHA256
import time

if __name__ == '__main__':
    nonce = 0
    nickname = "Bimarwin"

    while True:
        start_time = time.time()
        msg = (nickname + str(nonce)).encode('utf-8')
        digest = SHA256.new(msg).hexdigest()
        
        if digest[0:4] == '0000':
            end_time = time.time()
            cost_time = end_time - start_time
            print(("The digest mined with FOUR zero after {:.8f} seconds at the begining is " + digest).format(cost_time))
            break
        else:
            nonce += 1

    nonce = 0
    start_time = time.time()
    while True:
        msg = (nickname + str(nonce)).encode('utf-8')
        digest = SHA256.new(msg).hexdigest()

        if digest[0:5] == '00000':
            end_time = time.time()
            cost_time = end_time - start_time
            print(("The digest mined with FIVE zero after {:.8f} seconds at the begining is " + digest).format(cost_time))
            break
        else:
            nonce += 1