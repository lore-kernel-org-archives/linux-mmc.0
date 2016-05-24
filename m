From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v5 4/5] mmc: debugfs: add HS400 enhanced strobe description
Date: Tue, 24 May 2016 19:20:23 +0900
Message-ID: <57442AE7.5090403@samsung.com>
References: <1463976789-29618-1-git-send-email-shawn.lin@rock-chips.com>
 <CGME20160523041529epcas1p18362d70632f97a1e0ba15189276a916e@epcas1p1.samsung.com>
 <1463976844-29821-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49360 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbcEXKU7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 May 2016 06:20:59 -0400
In-reply-to: <1463976844-29821-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org

On 05/23/2016 01:14 PM, Shawn Lin wrote:
> We introduce HS400 with enhanced strobe function, so we need
> to add it for debug show.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Tested-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mmc/core/debugfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 9382a57..51d7c38 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -148,7 +148,9 @@ static int mmc_ios_show(struct seq_file *s, void *data)
>  		str = "mmc HS200";
>  		break;
>  	case MMC_TIMING_MMC_HS400:
> -		str = "mmc HS400";
> +		mmc_card_hs400es(host->card) ?
> +			(str = "mmc HS400 enhanced strobe") :
> +			(str = "mmc HS400");
>  		break;
>  	default:
>  		str = "invalid";
> 

