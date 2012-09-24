From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC/PATCH v2 3/3] mmc: sdhci: add asynchronous interrupt support
Date: Mon, 24 Sep 2012 11:55:40 +0200
Message-ID: <CAPDyKFoO1kRKFFGESdrNh1fdAcO1Jp4PnkMnkDgqmaafEvApfA@mail.gmail.com>
References: <1348196867-15145-1-git-send-email-keyuan.liu@gmail.com>
	<1348196867-15145-4-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:51041 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab2IXJzl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Sep 2012 05:55:41 -0400
Received: by weyt9 with SMTP id t9so93134wey.19
        for <linux-mmc@vger.kernel.org>; Mon, 24 Sep 2012 02:55:40 -0700 (PDT)
In-Reply-To: <1348196867-15145-4-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

On 21 September 2012 05:07, Kevin Liu <keyuan.liu@gmail.com> wrote:
> From: Kevin Liu <kliu5@marvell.com>
>
> If host support asynchronous interrupt and sdio device has enabled it,
> then enable/disable asynchronous interrupt on host when enable/disable
> sdio irq.
>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |   15 +++++++++++++++
>  drivers/mmc/host/sdhci.h |    2 ++
>  2 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e01536a..cd74009 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1634,6 +1634,8 @@ static int sdhci_get_ro(struct mmc_host *mmc)
>
>  static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
>  {
> +       u16 ctrl;
> +
>         if (host->flags & SDHCI_DEVICE_DEAD)
>                 goto out;
>
> @@ -1642,6 +1644,15 @@ static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
>         else
>                 host->flags &= ~SDHCI_SDIO_IRQ_ENABLED;
>
> +       if (mmc_card_async_int(host->mmc->card)) {
> +               ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +               if (enable)
> +                       ctrl |= SDHCI_CTRL_ASYNC_INT_ENABLE;
> +               else
> +                       ctrl &= ~SDHCI_CTRL_ASYNC_INT_ENABLE;
> +               sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +       }
> +
>         /* SDIO IRQ will be enabled as appropriate in runtime resume */
>         if (host->runtime_suspended)
>                 goto out;
> @@ -2952,6 +2963,10 @@ int sdhci_add_host(struct sdhci_host *host)
>         else
>                 mmc->power_notify_type = MMC_HOST_PW_NOTIFY_NONE;
>
> +       /* Does the host support async int? */
> +       if (caps[0] & SDHCI_CAN_ASYNC_INT)
> +               mmc->caps2 |= MMC_CAP2_ASYNC_INT;
> +
>         /* Initial value for re-tuning timer count */
>         host->tuning_count = (caps[1] & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
>                               SDHCI_RETUNING_TIMER_COUNT_SHIFT;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 5eb27bf..f9de65e 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -167,6 +167,7 @@
>  #define   SDHCI_CTRL_DRV_TYPE_D                0x0030
>  #define  SDHCI_CTRL_EXEC_TUNING                0x0040
>  #define  SDHCI_CTRL_TUNED_CLK          0x0080
> +#define  SDHCI_CTRL_ASYNC_INT_ENABLE   0x4000
>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE  0x8000
>
>  #define SDHCI_CAPABILITIES     0x40
> @@ -187,6 +188,7 @@
>  #define  SDHCI_CAN_VDD_300     0x02000000
>  #define  SDHCI_CAN_VDD_180     0x04000000
>  #define  SDHCI_CAN_64BIT       0x10000000
> +#define  SDHCI_CAN_ASYNC_INT   0x20000000
>
>  #define  SDHCI_SUPPORT_SDR50   0x00000001
>  #define  SDHCI_SUPPORT_SDR104  0x00000002
> --
> 1.7.0.4
>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Ulf Hansson
