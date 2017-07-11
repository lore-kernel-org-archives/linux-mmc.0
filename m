From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: mmc: fix switch to 1V8 for hs400es mode
Date: Tue, 11 Jul 2017 08:38:57 +0800
Message-ID: <ebe80597-2f95-1e08-937a-255153bfb3fb@rock-chips.com>
References: <1499418535-10161-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:57618 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbdGKAiu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jul 2017 20:38:50 -0400
In-Reply-To: <1499418535-10161-1-git-send-email-haibo.chen@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>, ulf.hansson@linaro.org
Cc: shawn.lin@rock-chips.com, stable@vger.kernel.org, dianders@chromium.org, linux-mmc@vger.kernel.org

Hi Haibo,

On 2017/7/7 17:08, Haibo Chen wrote:
> Change the default err value to -EINVAL, otherwise signal voltage
> will not change to 1V8 if card or controller only support 1V8 for
> HS400ES mode.
> 

This description is misleading as hs400(es) must be running under
1.8v vqmmc. But the patch itself is correct.

> Fixes: commit 1720d3545b77 ("mmc: core: switch to 1V8 or 1V2 for hs400es mode")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>   drivers/mmc/core/mmc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 92c6167..336a950 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1289,7 +1289,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>   static int mmc_select_hs400es(struct mmc_card *card)
>   {
>   	struct mmc_host *host = card->host;
> -	int err = 0;
> +	int err = -EINVAL;
>   	u8 val;
>   
>   	if (!(host->caps & MMC_CAP_8_BIT_DATA)) {
> 

