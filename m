From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc: update clock after ctrl reset in runtime
 resume
Date: Tue, 3 Jan 2017 14:59:03 +0800
Message-ID: <5e789711-b5de-5564-4538-a89d9ed9ca05@rock-chips.com>
References: <1483425987-21805-1-git-send-email-xzy.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:55183 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757161AbdACG7p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jan 2017 01:59:45 -0500
In-Reply-To: <1483425987-21805-1-git-send-email-xzy.xu@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ziyuan Xu <xzy.xu@rock-chips.com>, ulf.hansson@linaro.org, jh80.chung@samsung.com
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, randy.li@rock-chips.com, linux-rockchip@lists.infradead.org

Hi Ziyuan,

On 2017/1/3 14:46, Ziyuan Xu wrote:
> Immediately after reset, issue the command which sets
> update_clock_register_only bit, the card clock will restart.
>
> MMC_PM_KEEP_POWER is disabled for SD card and eMMC slots, so that they
> have no chance to invoke dw_mci_setup_bus for update clock behaviour.
> Let's consummate it.
>
> Fixes: e9ed883 ("mmc: dw_mmc: add runtime PM callback")
> Reported-by: Randy Li <randy.li@rock-chips.com>
> Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index b44306b..71715b4 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3357,6 +3357,8 @@ int dw_mci_runtime_resume(struct device *dev)
>  		if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
>  			dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
>  			dw_mci_setup_bus(slot, true);
> +		} else {
> +			mci_send_cmd(slot, SDMMC_CMD_UPD_CLK, 0);
>  		}
>  	}

Thanks for sending this, but I think the better fix we talked about
offlist may be...

--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3324,7 +3324,7 @@ int dw_mci_runtime_resume(struct device *dev)
         if (ret)
                 goto err;

-       if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
+       if (!dw_mci_reset(host)) {
                 clk_disable_unprepare(host->ciu_clk);
                 ret = -ENODEV;
                 goto err;


otherwise there still some unhandled cases once the reset is failure.

>
>


-- 
Best Regards
Shawn Lin

