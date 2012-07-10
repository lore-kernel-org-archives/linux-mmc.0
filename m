From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] mmc: core: Prevent eMMC VCC supply to be cut from late init
Date: Tue, 10 Jul 2012 20:49:04 +0530
Message-ID: <CAGxe1ZEnVNLs=sh3kB4w8nvvbGuqowwz9pDtwAdCGLm-M+dKuQ@mail.gmail.com>
References: <1336572926-21013-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:49799 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab2GJPTG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jul 2012 11:19:06 -0400
Received: by qadb17 with SMTP id b17so2428208qad.19
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jul 2012 08:19:04 -0700 (PDT)
In-Reply-To: <1336572926-21013-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jasi Brar <jassisinghbrar@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

On 9 May 2012 19:45, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> For eMMC cards that has been initialized from a bootloader,
> the VCC voltage supply must not be cut in an uncontrolled
> manner, without first sending SLEEP or POWEROFF_NOTIFY.
>
> The regulator_init_complete late initcall, may cut the VCC
> regulator if it's reference counter is zero. To be able to
> prevent the regulator from being cut, mmc_start_host, which
> should execute at device init and thus before late init,
> calls mmc_power_up. Then the host driver is able to increase
> the reference to the regulator.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/core.c |   18 +++++++++++++++---
>  1 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index ba821fe..0b6141d 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -42,6 +42,7 @@
>  #include "sdio_ops.h"
>
>  static struct workqueue_struct *workqueue;
> +static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
>
>  /*
>   * Enabling software CRCs on the data blocks can be a significant (30%)
> @@ -1157,6 +1158,9 @@ static void mmc_power_up(struct mmc_host *host)
>  {
>         int bit;
>
> +       if (host->ios.power_mode == MMC_POWER_ON)
> +               return;
> +
>         mmc_host_clk_hold(host);
>
>         /* If ocr is set, we use it */
> @@ -1199,6 +1203,10 @@ static void mmc_power_up(struct mmc_host *host)
>  void mmc_power_off(struct mmc_host *host)
>  {
>         int err = 0;
> +
> +       if (host->ios.power_mode == MMC_POWER_OFF)
> +               return;
> +
>         mmc_host_clk_hold(host);
>
>         host->ios.clock = 0;
> @@ -2005,7 +2013,6 @@ EXPORT_SYMBOL(mmc_detect_card_removed);
>
>  void mmc_rescan(struct work_struct *work)
>  {
> -       static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
>         struct mmc_host *host =
>                 container_of(work, struct mmc_host, detect.work);
>         int i;
> @@ -2044,8 +2051,12 @@ void mmc_rescan(struct work_struct *work)
>          */
>         mmc_bus_put(host);
>
> -       if (host->ops->get_cd && host->ops->get_cd(host) == 0)
> +       if (host->ops->get_cd && host->ops->get_cd(host) == 0) {
> +               mmc_claim_host(host);
> +               mmc_power_off(host);
> +               mmc_release_host(host);
>                 goto out;
> +       }
>
>         mmc_claim_host(host);
>         for (i = 0; i < ARRAY_SIZE(freqs); i++) {
> @@ -2063,7 +2074,8 @@ void mmc_rescan(struct work_struct *work)
>
>  void mmc_start_host(struct mmc_host *host)
>  {
> -       mmc_power_off(host);
> +       host->f_init = max(freqs[0], host->f_min);
> +       mmc_power_up(host);
>         mmc_detect_change(host, 0);
>  }
>
sorry to comment late on this.
This patch breaks the card detect with the designware host controller.
Anybody using the same host controller please let me know.
The problem is caused by the power_up call from the mmc_start_host
function. If i comment this powerup then card detect is fine
> --
> 1.7.9
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
