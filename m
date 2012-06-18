From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH 1/5 v2] mmc: bfin_sdh: limit mmc DMA segment len to 1 for bf518.
Date: Mon, 18 Jun 2012 14:31:26 +0800
Message-ID: <CAJxxZ0OARrRmYZZcwSSi-hEEb6B39wOTA26WT1gtfWfipR+=3A@mail.gmail.com>
References: <1339665743-7947-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38974 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608Ab2FRGb2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jun 2012 02:31:28 -0400
In-Reply-To: <1339665743-7947-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

Hi Chris,

Could you please comment on the patches for blackfin SD controller driv=
er?

Thanks

Sonic

On Thu, Jun 14, 2012 at 5:22 PM, Sonic Zhang <sonic.adi@gmail.com> wrot=
e:
> From: Sonic Zhang <sonic.zhang@analog.com>
>
> bf518 RSI dma doesn't work in array mode.
>
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
> =A0drivers/mmc/host/bfin_sdh.c | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.=
c
> index 0366617..fd25b0c 100644
> --- a/drivers/mmc/host/bfin_sdh.c
> +++ b/drivers/mmc/host/bfin_sdh.c
> @@ -469,7 +469,11 @@ static int __devinit sdh_probe(struct platform_d=
evice *pdev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0mmc->ops =3D &sdh_ops;
> +#if defined(CONFIG_BF54x)
> =A0 =A0 =A0 =A0mmc->max_segs =3D 32;
> +#elif defined(CONFIG_BF51x)
> + =A0 =A0 =A0 mmc->max_segs =3D 1;
> +#endif
> =A0 =A0 =A0 =A0mmc->max_seg_size =3D 1 << 16;
> =A0 =A0 =A0 =A0mmc->max_blk_size =3D 1 << 11;
> =A0 =A0 =A0 =A0mmc->max_blk_count =3D 1 << 11;
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
