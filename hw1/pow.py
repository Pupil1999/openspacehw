from Crypto.Hash import SHA256
import time

if __name__ == '__main__':
    nonce = 0
    nickname = "Bimarwin"

    while True:
        start_time = time.time()
        msg = (nickname + str(nonce)).encode('utf-8')
        digest = SHA256.new(msg).hexdigest()
        
        # 十六进制的一个0相当于二进制的4个零
        if digest[0] == '0':
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

        # 2进制开头5个零的数字其16进制形式的第一个字母是0，第二个字母的十进制值小于8
        if digest[0] == '0':
            if int(digest[1], 16) < 8:
                end_time = time.time()
                cost_time = end_time - start_time
                print(("The digest mined with FIVE zero after {:.8f} seconds at the begining is " + digest).format(cost_time))
                break
            else:
                nonce += 1
        else:
            nonce += 1