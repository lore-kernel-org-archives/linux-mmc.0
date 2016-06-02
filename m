From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 32/32] mmc: bcm2835: Import bcm2835-mmc and switch to it
Date: Thu, 02 Jun 2016 11:18:52 -0700
Message-ID: <87oa7j314j.fsf@eliezer.anholt.net>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com> <1464817421-8519-33-git-send-email-kraxel@redhat.com> <e16936ee-3b0d-3798-72e0-8969c2c1a309@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e16936ee-3b0d-3798-72e0-8969c2c1a309-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "open list:MULTIMEDIA CARD MMC, SECURE DIGITAL SD AND..." <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "moderated list:ARM PORT" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> writes:

> Hi Gerd,
>
> Am 01.06.2016 um 23:43 schrieb Gerd Hoffmann:
>> From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
>>
>> With this we can get wifi (brcmfmac) to probe.  Without it we're stuck
>> with timeouts from sdio.c when it tries to set the bus width to 4.
>
> adding a new MMC driver to fix a wifi issue is really weird.
>
> Beside that there are already two MMC drivers (sdhci-bcm2835.c and
> sdhci-iproc.c) in the Kernel which are compatible to BCM2835. Why should
> we add two new ones?

Despite the fact that this is my commit, I don't think it should be
merged.  We should figure out why sdhci-iproc.c isn't working, instead.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXUHiMAAoJELXWKTbR/J7oczcQALF1iMnuNsooDo+vFxr/NzFS
uEcTV7Dxhs6fN14seO2TWzlfz7dE+o+n5727VAQ2xfX7gxM2JTf5xKvkk6d0tf9E
16wGW23DfElDwX7GXZ4kthLTNCl2xtXyiadXTDrje3qXFmG4KU7Ikvg7/FCrrL7P
eeaIju3SxCu+LlDVrZViD/gtk7DfpWnft8XSRxTiYguisHqC5e+pneQKvp6jS8aP
QEw1gJA8ii3zFvftPA1tPnxNgTsqkG84prMJrhzaroHDHe33lmpCdNBny5KSTxV6
c+oFC1r0Er5AvPody9Rte7d+00o7vf224Vo7QrvUFlSusjdmiKJr9aYrAjcwxAXI
7fa9cU8A9piP9PdGEPh4lek4QHzYwh0bLH2pKKCN3ZqsVlZfeq2V21MDW/A74/Pw
eWkhWc2f7vBExVbuaep2uw25B24BJpV3zZno6XgYlo9Vk0jaNGbnWPyoDSZnmICb
W8VB11OwydDgNBPo31zJLXjM06fWqCIkzmZrgS4rmzjRTGRpiA15iRVSOKatk5w7
9pyrUZWjMJ/TZPh4kZ4rcQimMOHkCU0jLdopXW+M0SEA9zmu7Pd2IBj75MVDqwsy
5NOhR3XP02X4cKnwEY8ePDkYHB0atpUgi6x70GvP6q4jMNepCtb/JcdP77TRZ0Kw
rQBCM7c2W6q+0niukefG
=1XZI
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
