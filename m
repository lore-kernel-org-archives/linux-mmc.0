From: Eddie Cai <eddie.cai.linux@gmail.com>
Subject: Re: [PATCH v5 2/2] mmc: dw_mmc: force setup bus if active slots exist
Date: Mon, 13 Feb 2017 14:32:36 +0800
Message-ID: <CAJrj+DOcdpQ8EQLv=bMberrbmO3QmKj=kHWDOdjQmoonryhk3Q@mail.gmail.com>
References: <1484276362-44984-1-git-send-email-shawn.lin@rock-chips.com> <1484276362-44984-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33417 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdBMGci (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2017 01:32:38 -0500
In-Reply-To: <1484276362-44984-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, sgilles@math.umd.edu, linux-mmc@vger.kernel.org, Ziyuan Xu <xzy.xu@rock-chips.com>, Randy Li <randy.li@rock-chips.com>, stable@vger.kernel.org, linux-rockchip@lists.infradead.org

Hi Heiko

I guess you may lost this patch. We need it to prevent crash when boot
up RK3288.

2017-01-13 10:59 GMT+08:00 Shawn Lin <shawn.lin@rock-chips.com>:
> From: Ziyuan Xu <xzy.xu@rock-chips.com>
>
> It's necessary to setup bus if any slots are present.
> - update clock after ctrl reset
> - if the host has genpd node, we can guarantee the clock is
>   available before starting request. Otherwies, the clock register
>   is reset once power off the pd, and host can't output the active
>   clock during communication.
>
> Fixes: e9ed8835e990 ("mmc: dw_mmc: add runtime PM callback")
> Fixes: df9bcc2bc0a1 ("mmc: dw_mmc: add missing codes for runtime resume")
> cc: <stable@vger.kernel.org>
> Reported-by: Randy Li <randy.li@rock-chips.com>
> Reported-by: S. Gilles <sgilles@math.umd.edu>
> Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> ---
>
> Changes in v5:
> - rebase in order to skip spamming log
>
> Changes in v4:
> - update commit message
> - fix SD host rpm resume can't work
>
> Changes in v3:
> - only reset host with active slot.
>
> Changes in v2:
> - update the commit message
> - use dw_mci_reset instead of dw_mci_ctrl_reset
>
>  drivers/mmc/host/dw_mmc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index dc58ec3..0914d53 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3367,10 +3367,11 @@ int dw_mci_runtime_resume(struct device *dev)
>
>                 if (!slot)
>                         continue;
> -               if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
> +               if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
>                         dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
> -                       dw_mci_setup_bus(slot, true, true);
> -               }
> +
> +               /* Force setup bus to guarantee available clock output */
> +               dw_mci_setup_bus(slot, true, true);
>         }
>
>         /* Now that slots are all setup, we can enable card detect */
> --
> 1.9.1
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
