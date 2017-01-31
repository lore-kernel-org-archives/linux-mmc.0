From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 1/4] dt-bindings: Add binding for brcm,bcm2835-sdhost.
Date: Tue, 31 Jan 2017 10:40:00 -0800
Message-ID: <87zii7m5tr.fsf@eliezer.anholt.net>
References: <1485516989-1072-1-git-send-email-kraxel@redhat.com> <1485516989-1072-2-git-send-email-kraxel@redhat.com> <2012885435.15821.1485812279271@email.1und1.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2012885435.15821.1485812279271-7tX72C7vayboQLBSYMtkGA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> writes:

>> Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> hat am 27. Januar 2017 um 12:36 geschr=
ieben:
>>=20
>>=20
>> From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
>>=20
>> This is the other SD controller on the platform, which can be swapped
>> to the role of SD card host using pin muxing.
>
> AFAIK the SDHOST controller isn't able to handle SDIO. Maybe we should me=
ntion this in the binding document.

The binding should be documentation of the binding.  I'd love to see
more explanation in the mmc/host/bcm2835.c, though.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAliQ2gAACgkQtdYpNtH8
nujbtA/+N1294o4WGpS97F9LW4hvN9AJ6cjvnj4lHhbxrFymvQs6YKKIJuNwy9qF
EtaotTkmkmcn8aMh1c69VyB6oMnBpIMdb8l4JqLFll/n7tpY0IYumqEwzjhWtgwj
QWABbdwXLccVvAg3dDBE4y43AXU2YmB/briHH6uTh72O6nASiPu/yyXUhyhQb2ue
d0tAhikKzA8CVBJVder9Y5Dh7b/odieupVx4p4Ek5+UXp53JNwcIN9MjSSIjDE/x
9sLgz3vO6FeVBIXrmgrIJ+H0xUS6toMS4SdA7EZCNSlsXLSblRwYcigQ3J9d03LB
aLR1s9haYxgOV62mzRONVpgZB4g8bB/6VfgGKioLWVipRfX8YLgl7mjXlDgLr3Kd
gFEwRIyq7k1BCcRrdYOb55HL8PGx10lenKdcjCjo/HNFfQmwfQeo054UgaqZB72Q
hHhVyC2KtF5kwuDLMlMioX5pdJwhmsuiF8X/fjkjSbDZeGwrwWQ8jEoXr+naNwo4
nHyS9blhuGxB7OoNZG0BKrB0yOit3ygAzaEVr7EHkLI7qc4rMZZH+lKGdA6n7N1F
tZCdzfWYMDzBWz9fipenKmFfWA9MypWpyWfRmE4bx/oT5jEgdFHeJdkr7u4wSUJy
FNKMarnzTe07ifthZcV9g0bHv73xZj/LzDnXHC44rbJlEdBg/IM=
=J+dQ
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
