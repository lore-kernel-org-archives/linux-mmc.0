From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] Move the judgement of timeout into
 mmc_switch_status_error()
Date: Thu, 24 Dec 2015 18:24:31 +0900
Message-ID: <567BB9CF.3090301@samsung.com>
References: <008f01d13e2b$4a2a3150$de7e93f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:57111 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933368AbbLXJYm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Dec 2015 04:24:42 -0500
In-reply-to: <008f01d13e2b$4a2a3150$de7e93f0$@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?EUC-KR?B?wOW/tcH4?= <yj84.jang@samsung.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: js07.lee@samsung.com, =?EUC-KR?B?J8DMsaTIoyc=?= <demon.lee@samsung.com>

Hi,

Before send the patch at mailing list, you need to make the patch as ma=
inline style.
Maybe..maintainer should not review this patch.

Refer to "Linux kernel coding style" and "submitting Patches".
Also set  your email environment. (Documentation/email-clients.txt)

Best Regards,
Jaehoon Chung

On 12/24/2015 06:13 PM, =C0=E5=BF=B5=C1=F8 wrote:
>>From bc1e491b29d9199f16c6e002a69f9377677b93af Mon Sep 17 00:00:00 200=
1
>=20
> From: "yj84.jang" <yj84.jang@samsung.com>
>=20
> Date: Wed, 16 Dec 2015 08:52:47 +0900
>=20
> Subject: [PATCH] Move the judgement of timeout into
> mmc_switch_status_error()
>=20
> =20
>=20
> __mmc_switch() is possible to misjudge error.
>=20
> =20
>=20
> Although jiffies was overed timeout,=20
>=20
> the chance about "R1_CURRENT_STATE(status) !=3D R1_STATE_PRG" is exis=
ts.=20
>=20
> In other words, Successful completion of CMD6 with timeout error.
>=20
> =20
>=20
> Kernel expects failure of __mmc_switch,
>=20
> but card is completed CMD6 in this case.
>=20
> It makes mismatch status between mmc subsystem and mmc card.
>=20
> =20
>=20
> Especially, in case of partition switch,
>=20
> If timeout occurs with normal status of CMD13 response unfortunatley,=
=20
>=20
> "main_md->curr" will not be set, even card switched successfully.
>=20
> =20
>=20
> Checking state of mmc card is needed when judging an timeout error,=20
>=20
> if it is just timeout or timeout with error.
>=20
> =20
>=20
> Signed-off-by: yj84.jang <yj84.jang@samsung.com>
>=20
> ---
>=20
> drivers/mmc/core/mmc_ops.c |    5 +++--
>=20
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> =20
>=20
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>=20
> index 1f44426..033f475 100644
>=20
> --- a/drivers/mmc/core/mmc_ops.c
>=20
> +++ b/drivers/mmc/core/mmc_ops.c
>=20
> @@ -456,6 +456,8 @@ int mmc_switch_status_error(struct mmc_host *host=
, u32
> status)
>=20
>                     if (status & R1_SPI_ILLEGAL_COMMAND)
>=20
>                                return -EBADMSG;
>=20
>          } else {
>=20
> +                   if (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG)
>=20
> +                              return -ETIMEDOUT;
>=20
>                     if (status & 0xFDFFA000)
>=20
>                                pr_warn("%s: unexpected status %#x aft=
er
> switch\n",
>=20
>                                          mmc_hostname(host), status);
>=20
> @@ -568,8 +570,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u=
8
> index, u8 value,
>=20
>                     if (time_after(jiffies, timeout)) {
>=20
>                                pr_err("%s: Card stuck in programming =
state!
> %s\n",
>=20
>                                          mmc_hostname(host), __func__=
);
>=20
> -                               err =3D -ETIMEDOUT;
>=20
> -                               goto out;
>=20
> +                              break;
>=20
>                     }
>=20
>          } while (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG);
>=20
> =20
>=20

