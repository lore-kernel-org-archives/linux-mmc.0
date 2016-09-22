From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/5] mmc: core: changes frequency to hs_max_dtr when
 selecting hs400es
Date: Thu, 22 Sep 2016 11:38:35 +0200
Message-ID: <CAPDyKFoHxSpFurgV9swN3MCTWUinPFNUHSzxgyKj+K3iqkGSbA@mail.gmail.com>
References: <1474422233-29355-1-git-send-email-shawn.lin@rock-chips.com> <1474422233-29355-4-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38327 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbcIVJii (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2016 05:38:38 -0400
Received: by mail-wm0-f41.google.com with SMTP id l132so137600530wmf.1
        for <linux-mmc@vger.kernel.org>; Thu, 22 Sep 2016 02:38:37 -0700 (PDT)
In-Reply-To: <1474422233-29355-4-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

On 21 September 2016 at 03:43, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Per JESD84-B51 P69, Host need to change frequency to <=52MHz after
> setting HS_TIMING to 0x1, and host may changes frequency to <= 200MHz
> after setting HS_TIMING to 0x3. It seems there is no difference if
> we don't change frequency to <= 52MHz as f_init is already less than
> 52MHz. But actually it does make difference. When doing compatibility
> test we see failures for some eMMC devices without changing the
> frequency to hs_max_dtr. And let's read the spec again, we could see
> that "Host may changes frequency to 200MHz" implies that it's not
> mandatory. But the "Host need to change frequency to <= 52MHz" implies
> that we should do this.

I don't get this. Are you saying that f_init > 52 MHz? That should not
be impossible, right!?

So either the core has changed the clock rate by mistake at some other
execution path, or the host driver didn't set the correct clock rate
the first time when invoked via mmc_power_up()?

Kind regards
Uffe

>
> Reported-by: Xiao Yao <xiaoyao@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/mmc/core/mmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 3163bb9..989d37e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1282,6 +1282,8 @@ static int mmc_select_hs400es(struct mmc_card *card)
>         if (err)
>                 goto out_err;
>
> +       mmc_set_clock(host, card->ext_csd.hs_max_dtr);
> +
>         err = mmc_switch_status(card);
>         if (err)
>                 goto out_err;
> --
> 2.3.7
>
>
