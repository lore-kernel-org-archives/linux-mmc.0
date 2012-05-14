From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fixed sdio interrupt mask bit setting bug
Date: Mon, 14 May 2012 14:24:51 +0530
Message-ID: <CANYdXnqKV5sk1utmrK8wyrhgU4WQ-PJyuegUzr=GzDy-6Gnquw@mail.gmail.com>
References: <002901cd31ac$fb410250$f1c306f0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:58968 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab2ENIyw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 May 2012 04:54:52 -0400
Received: by gglu4 with SMTP id u4so2886395ggl.19
        for <linux-mmc@vger.kernel.org>; Mon, 14 May 2012 01:54:51 -0700 (PDT)
In-Reply-To: <002901cd31ac$fb410250$f1c306f0$%kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyoungil Kim <ki0351.kim@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kukjin Kim <kgene.kim@samsung.com>

I agree with you, looks like a bug that got introduced with SDIO suppor=
t.

acked-by Shashidhar Hiremath <shashidharh@vayavyalabs.com>

On Mon, May 14, 2012 at 2:08 PM, Kyoungil Kim <ki0351.kim@samsung.com> =
wrote:
> The sdio interrupt mask bits are arranged in [31:16].
> (1 << SDMMC_INT_SDIO(slot->id))) does 16 bits left shift twice.
> So this patch changes to do 16 bits left shift only one time.
>
> Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
> ---
> =C2=A0drivers/mmc/host/dw_mmc.c | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 1532357..9bbf45f 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -857,10 +857,10 @@ static void dw_mci_enable_sdio_irq(struct mmc_h=
ost *mmc, int enb)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int_mask =3D mci_readl(host, INTMASK);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (enb) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mci_writel(hos=
t, INTMASK,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(int_mask | (1 << SDMMC_INT_SDIO(slot->id))));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(int_mask | SDMMC_INT_SDIO(slot->id)));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mci_writel(hos=
t, INTMASK,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(int_mask & ~(1 << SDMMC_INT_SDIO(slot->id))));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(int_mask & ~SDMMC_INT_SDIO(slot->id)));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml



--=20
cheers,
Shashidhar Hiremath
