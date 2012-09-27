From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 12/15] mmc: core: add new 1.8v flag for mmc
Date: Thu, 27 Sep 2012 11:41:20 +0200
Message-ID: <CAPDyKFoMJrunn1WSiif84xbTzp+4ssZV8WdqsrC6FyUtdZC6bw@mail.gmail.com>
References: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
	<1348659527-4200-13-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43347 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab2I0JlV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Sep 2012 05:41:21 -0400
Received: by weyt9 with SMTP id t9so499496wey.19
        for <linux-mmc@vger.kernel.org>; Thu, 27 Sep 2012 02:41:20 -0700 (PDT)
In-Reply-To: <1348659527-4200-13-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Johan Rudholm <johan.rudholm@stericsson.com>

Hi Kevin,

On 26 September 2012 13:38, Kevin Liu <keyuan.liu@gmail.com> wrote:
> From: Kevin Liu <kliu5@marvell.com>
>
> Mmc does NOT have special sequence requirements for 1.8v
> signal voltage setting compared to sd and sdio.
> Add a new 1.8v flag for mmc so as to use the same
> start_signal_voltage_switch interface.

This problem is protocol issue and should not be solved in the host
driver. We have more issues for signal_voltage switch as well.

Please have a look at Johan Rudholms patches:
[PATCH v2 1/2] mmc: core: Proper signal voltage switch
[PATCH v2 2/2] mmc: core: Power cycle card on voltage switch fail


>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> ---
>  drivers/mmc/core/mmc.c   |    3 ++-
>  include/linux/mmc/host.h |    1 +
>  2 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 7509de1..3aa7f14 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -758,7 +758,8 @@ static int mmc_select_hs200(struct mmc_card *card)
>
>         if (err && card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_8V &&
>                         host->caps2 & MMC_CAP2_HS200_1_8V_SDR)
> -               err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180, 0);
> +               err = mmc_set_signal_voltage(host,
> +                       MMC_SIGNAL_VOLTAGE_MMC_180, 0);
>
>         /* If fails try again during next card power cycle */
>         if (err)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 0ee92d2..d9ab286 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -71,6 +71,7 @@ struct mmc_ios {
>  #define MMC_SIGNAL_VOLTAGE_330 0
>  #define MMC_SIGNAL_VOLTAGE_180 1
>  #define MMC_SIGNAL_VOLTAGE_120 2
> +#define MMC_SIGNAL_VOLTAGE_MMC_180     3
>
>         unsigned char   drv_type;               /* driver type (A, B, C, D) */
>
> --
> 1.7.0.4
>

Kind regards
Ulf Hansson
