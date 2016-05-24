From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: use default speed of the eMMC
Date: Tue, 24 May 2016 18:41:34 +0900
Message-ID: <574421CE.4080503@samsung.com>
References: <CGME20160524090753epcas1p125c06a036988b476840c79048cb45428@epcas1p1.samsung.com>
 <CA+pahgdUP3Zam-cSeW8fJR9AmiUo2_Ok_uDHqWTgwvzCGC58+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:48299 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbcEXJlg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 May 2016 05:41:36 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O7O0265JDLAET90@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 24 May 2016 18:41:34 +0900 (KST)
In-reply-to: <CA+pahgdUP3Zam-cSeW8fJR9AmiUo2_Ok_uDHqWTgwvzCGC58+g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?7J6l66+87Jqw?= <huskey27@gmail.com>, linux-mmc@vger.kernel.org

Hi,

On 05/24/2016 06:07 PM, =EC=9E=A5=EB=AF=BC=EC=9A=B0 wrote:
> Dear linux-mmc.
>=20
> Hello, I'm Minwoo Jang.
>=20
> I have a question about using default speed of the eMMC.
>=20
> When default speed is used, mmc_select_bus_width() is never called.
>=20
> So, eMMC can not be set 4 bit or 8 bit bus width, I think.
>=20
> Please, give me your opinions on the following diff codes.

In mmc_select_timing(), timing should be set to MMC_TIMING_HS or others=
=2E
Then mmc_select_bus_width() should be entered.

Best Regards,
Jaehoon Chung

>=20
> Thank you.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>=20
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 94b4462..3b1cc4d 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -952,6 +952,8 @@ static int mmc_select_bus_width(struct mmc_card *=
card)
>=20
>                 if (!err) {
>                         err =3D bus_width;
> +                       pr_warn("%s: switch to bus width %d\n",
> +                               mmc_hostname(host), (1 << bus_width))=
;
>                         break;
>                 } else {
>                         pr_warn("%s: switch to bus width %d failed\n"=
,
> @@ -1500,6 +1502,14 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
>                         if (err)
>                                 goto err;
>                 }
> +       } else {
> +               /* Select the bus width for normal speed mode */
> +               err =3D mmc_select_bus_width(card);
> +               if (IS_ERR_VALUE(err)) {
> +                       pr_warn("%s: Selecting bus width failed\n",
> +                               mmc_hostname(card->host));
> +                       goto err;
> +               }
>         }
>=20
> Best regards,
>=20
> MW Jang.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20

