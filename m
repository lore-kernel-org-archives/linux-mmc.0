From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC/PATCH 3/3] mmc: sdhci: add asynchronous interrupt support
Date: Wed, 19 Sep 2012 17:56:03 +0200
Message-ID: <CAPDyKFqcX7kv2hc7bbpNFBLQzE2T7BGqysrJjns7vN_MEWzppw@mail.gmail.com>
References: <1348024372-32073-1-git-send-email-keyuan.liu@gmail.com>
	<1348024372-32073-4-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:56090 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756364Ab2ISP5A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Sep 2012 11:57:00 -0400
Received: by wibhi8 with SMTP id hi8so5770710wib.1
        for <linux-mmc@vger.kernel.org>; Wed, 19 Sep 2012 08:56:59 -0700 (PDT)
In-Reply-To: <1348024372-32073-4-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

Hi Kevin,

On 19 September 2012 05:12, Kevin Liu <keyuan.liu@gmail.com> wrote:
> From: Kevin Liu <kliu5@marvell.com>
>
> If host support asynchronous interrupt and sdio device has enabled it,
> then enable/disable asynchronous interrupt on host when enable/disable
> sdio irq.
>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |   16 ++++++++++++++++
>  drivers/mmc/host/sdhci.h |    2 ++
>  2 files changed, 18 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0e15c79..f6136e2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1575,6 +1575,8 @@ static int sdhci_get_ro(struct mmc_host *mmc)
>
>  static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
>  {
> +       u16 ctrl;
> +
>         if (host->flags & SDHCI_DEVICE_DEAD)
>                 goto out;
>
> @@ -1583,6 +1585,16 @@ static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
>         else
>                 host->flags &= ~SDHCI_SDIO_IRQ_ENABLED;
>
> +       if ((host->mmc->caps2 & MMC_CAP2_ASYNC_INT) &&
> +               (host->mmc->card->cccr.async_int)) {

It is a quite special card bit value you are checking for. Can you be
sure that the cccr struct exist here?

Maybe it could be a good idea to implement something similar as for
example mmc_card_highspeed | mmc_card_set_highspeed functions.
Thus add a new card state, which is set accordingly when this bit is
set and instead check for this state here. In this case you would not
have to check the caps2 here, since that is already done by the
protocol layer.

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
> @@ -2895,6 +2907,10 @@ int sdhci_add_host(struct sdhci_host *host)
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
> index 97653ea..2e89dac 100644
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Ulf Hansson
