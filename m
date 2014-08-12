From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: use 1.8v signling in ddr mode for some special host
Date: Tue, 12 Aug 2014 15:21:17 +0200
Message-ID: <CAPDyKFozfn62tkFQkzXC19pVXeGruH-K=eaz3756xk-q3hDQ6w@mail.gmail.com>
References: <20140801060816.GA3172@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:47554 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbaHLNVS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Aug 2014 09:21:18 -0400
Received: by mail-qa0-f47.google.com with SMTP id i13so8848304qae.34
        for <linux-mmc@vger.kernel.org>; Tue, 12 Aug 2014 06:21:17 -0700 (PDT)
In-Reply-To: <20140801060816.GA3172@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, chris@printf.org, Yunpeng Gao <yunpeng.gao@intel.com>

On 1 August 2014 08:08, Chuanxiao Dong <chuanxiao.dong@intel.com> wrote:
> Even eMMC card can support 3.3v to 1.2v vccq in DDR, but not all
> host controller can support this, like some of the SDHCI host
> which connect to an eMMC device. Some of these host controller
> still needs to use 1.8v vccq for supporting DDR mode.
>
> If a host controller cannot support 3.3v for DDR, try 1.8v.
>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
> ---
>  drivers/mmc/core/mmc.c   |   19 +++++++++++++++++++
>  include/linux/mmc/host.h |    1 +
>  2 files changed, 20 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 793c6f7..13a5b24 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1000,6 +1000,25 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>                         return err;
>         }
>
> +       /*
> +        * Even eMMC card can support 3.3v to 1.2v vccq, but not all
> +        * host controller can support this, like some of the SDHCI
> +        * controller which connect to an eMMC device. Some of these
> +        * host controller still needs to use 1.8v vccq for supporting
> +        * DDR mode.
> +        *
> +        * If a host controller cannot support 3.3v for DDR, try 1.8v
> +        */
> +       if (unlikely(host->caps2 & MMC_CAP2_NO_3_3V_DDR)) {
> +               if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_8V) {
> +                       err = __mmc_set_signal_voltage(host,
> +                                       MMC_SIGNAL_VOLTAGE_180);
> +                       if (err)
> +                               return err;
> +               } else
> +                       return -EOPNOTSUPP;
> +       }

I am wondering if we could try an another approach while changing
signal voltage for (e)MMC. Simply start by trying with 1.2V, then 1.8V
and then 3.3V. Obviously we shouldn't try with something that isn't
supported, which card->mmc_avail_type tells us about.

I realize that it will mean a change in behaviour and depending on how
hosts are handling signal voltage, this is a bit uncertain if it would
work. Still I feel it would be the right approach. Can we give at
shot?

Kind regards
Uffe
