From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix DDR mode support.
Date: Fri, 5 Aug 2011 11:20:42 +0100
Message-ID: <CAFbHwiT3p3pSC1q4xQRYkLzSG7tPuGLXB4KKwC-8HWMmtF+fhA@mail.gmail.com>
References: <1312515303-17169-1-git-send-email-tgih.jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:63984 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967Ab1HEKUn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Aug 2011 06:20:43 -0400
In-Reply-To: <1312515303-17169-1-git-send-email-tgih.jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-kernel@vger.kernel.org

On Fri, Aug 5, 2011 at 4:35 AM, Seungwon Jeon <tgih.jun@samsung.com> wr=
ote:
> Host driver can't get a hint of DDR mode through ios->ddr flag anymor=
e.
> ios->timing is currently used to inform DDR mode as a substitute.
> And capability of MMC_CAP_MMC_HIGHSPEED is added for DDR support.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index d65511e..b412a1d 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -699,7 +699,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, =
struct mmc_ios *ios)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* DDR mode set */
> - =A0 =A0 =A0 if (ios->ddr) {
> + =A0 =A0 =A0 if (ios->timing =3D=3D MMC_TIMING_UHS_DDR50) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regs =3D mci_readl(slot->host, UHS_REG=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regs |=3D (0x1 << slot->id) << 16;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mci_writel(slot->host, UHS_REG, regs);
> @@ -1646,7 +1646,7 @@ static int __init dw_mci_init_slot(struct dw_mc=
i *host, unsigned int id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP=
_4_BIT_DATA;
>
> =A0 =A0 =A0 =A0if (host->pdata->quirks & DW_MCI_QUIRK_HIGHSPEED)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SD_HIGHSPEED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SD_HIGHSPEED | M=
MC_CAP_MMC_HIGHSPEED;
>
> =A0#ifdef CONFIG_MMC_DW_IDMAC
> =A0 =A0 =A0 =A0mmc->max_segs =3D host->ring_size;
> --
> 1.7.0.4

Acked-by: Will Newton <will.newton@imgtec.com>
