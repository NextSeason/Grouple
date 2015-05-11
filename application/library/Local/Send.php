<?php

namespace Local;

Class Send {
    static public function shortMessage() {
    }

    static public function email( $addresses, $params  ) {
        $mail = new PHPMailer();

        $mail->isSMTP();
        $mail->Host = 'smtp.163.com';
        $mail->SMTPAuth = true;
        $mail->Username = 'kelcb@163.com';
        $mail->Password = 'Mr.LvChengbin324';
        $mail->SMTPSecure = 'tls';

        $mail->From = 'kelcb@163.com';
        $mail->FromName = 'LvChengbin';


        foreach( $addresses as $address ) {
            $mail->addAddress( $address[ 0 ], $address[ 1 ] );
        }

        foreach( $params as $key => $value ) {
            $mail->$key = $value;
        }

        $mail->Subject = $subject;
        $mail->Body = $body;

        if( !$mail->send() ) return false;

        return true;
    }
}
