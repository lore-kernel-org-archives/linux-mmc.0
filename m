From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: core: try 1.8v signling in ddr mode if host and device
Date: Fri, 15 Aug 2014 10:34:29 +0200
Message-ID: <CAPDyKFpigfMvzV6t3f2C-hcvKgfa_jErSH=xLCqN4xG4X6zJ7w@mail.gmail.com>
References: <20140815032806.GA19745@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34088 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbaHOIea (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Aug 2014 04:34:30 -0400
Received: by mail-qg0-f54.google.com with SMTP id z60so2005543qgd.27
        for <linux-mmc@vger.kernel.org>; Fri, 15 Aug 2014 01:34:29 -0700 (PDT)
In-Reply-To: <20140815032806.GA19745@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, chris@printf.org

On 15 August 2014 05:28, Chuanxiao Dong <chuanxiao.dong@intel.com> wrote:
> Even (e)MMC card can support 3.3v to 1.2v vccq in DDR, but not all
> host controller can support this, like some of the SDHCI host
> which connect to an eMMC device. Some of these host controller
> still needs to use 1.8v vccq for supporting DDR mode.
>
> So the sequence will be:
> if (host and device can both support 1.2v IO)
>         use 1.2v IO;
> else if (host and device can both support 1.8v IO)
>         use 1.8v IO;
> so if host and device can only support 3.3v IO, this is the last choice.
>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>

This looks good to me! But before I queue it for 3.18 I would
appreciate if we could get some help in testing this for some various
platforms, that support MMC DDR.

Kind regards
Uffe

> ---
> Changelog V2:
>      - For (e)MMC device switching to DDR mode, try 1.2v singaling first. Then
>      try 1.8v. If 1.2v and 1.8v are both not supported, use the default
>
> Changelog V3:
>      - continue to try 1.8v/3.3v vccq if there is IO voltage switching failure
>
>  drivers/mmc/core/mmc.c |   34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 793c6f7..8d69671 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -988,19 +988,35 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>          * 1.8V vccq at 3.3V core voltage (vcc) is not required
>          * in the JEDEC spec for DDR.
>          *
> -        * Do not force change in vccq since we are obviously
> -        * working and no change to vccq is needed.
> +        * Even (e)MMC card can support 3.3v to 1.2v vccq, but not all
> +        * host controller can support this, like some of the SDHCI
> +        * controller which connect to an eMMC device. Some of these
> +        * host controller still needs to use 1.8v vccq for supporting
> +        * DDR mode.
> +        *
> +        * So the sequence will be:
> +        * if (host and device can both support 1.2v IO)
> +        *      use 1.2v IO;
> +        * else if (host and device can both support 1.8v IO)
> +        *      use 1.8v IO;
> +        * so if host and device can only support 3.3v IO, this is the
> +        * last choice.
>          *
>          * WARNING: eMMC rules are NOT the same as SD DDR
>          */
> -       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_1_2V) {
> -               err = __mmc_set_signal_voltage(host,
> -                               MMC_SIGNAL_VOLTAGE_120);
> -               if (err)
> -                       return err;
> -       }
> +       err = -EINVAL;
> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_1_2V)
> +               err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
>
> -       mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
> +       if (err && (card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_1_8V))
> +               err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
> +
> +       /* make sure vccq is 3.3v after switching disaster */
> +       if (err)
> +               err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
> +
> +       if (!err)
> +               mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
>
>         return err;
>  }
> --
> 1.7.10.4
>
