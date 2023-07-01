

def dec_to_hex(dec_num):
    '''
    10진수를 16진수로 변환하는 함수

    :param dec_num:
    int타입 10진수 숫자
    :return:
    str타입 16진수 문자열
    '''

    hex_digit = list("0123456789abcdef")
    ret = ""
    while dec_num:
        ret = hex_digit[dec_num%16] + ret
        dec_num //= 16
    return "0x"+ret


if __name__=="__main__":
    for i in range(10,300,10):
        print(dec_to_hex(i), "%#x"%i)
