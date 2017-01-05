From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: revise the reset path in runtime resume
Date: Thu, 05 Jan 2017 10:20:52 +0900
Message-ID: <55367081-6471-bc41-5311-37306395a926@samsung.com>
References: <CGME20170104125151epcas3p379dc2dcca22bfa5d20fba3f0cb0729a8@epcas3p3.samsung.com>
 <1483534293-6192-1-git-send-email-xzy.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:46630 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933960AbdAEBVF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jan 2017 20:21:05 -0500
In-reply-to: <1483534293-6192-1-git-send-email-xzy.xu@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ziyuan Xu <xzy.xu@rock-chips.com>, ulf.hansson@linaro.org, shawn.lin@rock-chips.com
Cc: linux-mmc@vger.kernel.org, randy.li@rock-chips.com, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org

Hi, 

On 01/04/2017 09:51 PM, Ziyuan Xu wrote:
> Immediately after reset, issue the command which sets
> update_clock_register_only bit, the card clock will restart. Revise
> dw_mci_ctrl_reset to dw_mci_reset, which has wrapped this sequence.
> 
> The patch fixes commit e9ed8835e990 ("mmc: dw_mmc: add runtime PM
> callback"). MMC_PM_KEEP_POWEP is disabled for SD card and eMMC slots, so
> that they have no chance to invoke dw_mci_setup_bus for update clock
> behaviour. Let's consummate it.
> 
> Reported-by: Randy Li <randy.li@rock-chips.com>
> Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>

Doesn't it need Shawn's Signed-off tag?

Best Regards,
Jaehoon Chung

> 
> ---
> 
> Changes in v2:
> - update the commit message
> - use dw_mci_reset instead of dw_mci_ctrl_reset
> 
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index b44306b..ed63237 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3324,7 +3324,7 @@ int dw_mci_runtime_resume(struct device *dev)
>  	if (ret)
>  		goto err;
>  
> -	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
> +	if (!dw_mci_reset(host)) {
>  		clk_disable_unprepare(host->ciu_clk);
>  		ret = -ENODEV;
>  		goto err;
> 

