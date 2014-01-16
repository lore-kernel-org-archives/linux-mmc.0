From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 6/7] mmc: dw_mmc: clarify DDR timing mode between SD-UHS
 and eMMC
Date: Thu, 16 Jan 2014 11:37:54 +0100
Message-ID: <CAPDyKFp9d+JfXB0NqqTx2UsPVaN_uujaLgAWQVHUZ_WmenqpAA@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<002401cf11fb$ce4c3cc0$6ae4b640$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:48607 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbaAPKhy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2014 05:37:54 -0500
Received: by mail-qa0-f42.google.com with SMTP id k4so1980820qaq.29
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2014 02:37:54 -0800 (PST)
In-Reply-To: <002401cf11fb$ce4c3cc0$6ae4b640$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 15 January 2014 15:12, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Replaced UHS_DDR50 with MMC_DDR52. And MMC_CAP_UHS_DDR50
> is removed because of non-implementation of UHS signaling.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/host/dw_mmc-exynos.c |    3 +--
>  drivers/mmc/host/dw_mmc.c        |    2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 3423c5e..b5a36b1 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -386,8 +386,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
>
>  /* Common capabilities of Exynos4/Exynos5 SoC */
>  static unsigned long exynos_dwmmc_caps[4] = {
> -       MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR |
> -               MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
> +       MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
>         MMC_CAP_CMD23,
>         MMC_CAP_CMD23,
>         MMC_CAP_CMD23,
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a776f24..99390bb 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -962,7 +962,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         regs = mci_readl(slot->host, UHS_REG);
>
>         /* DDR mode set */
> -       if (ios->timing == MMC_TIMING_UHS_DDR50)
> +       if (ios->timing == MMC_TIMING_MMC_DDR52)
>                 regs |= ((0x1 << slot->id) << 16);
>         else
>                 regs &= ~((0x1 << slot->id) << 16);
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
