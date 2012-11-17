From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v6 07/14] mmc: host: adjust uhs timing value
Date: Sat, 17 Nov 2012 17:01:04 -0500
Message-ID: <878v9z99en.fsf@octavius.laptop.org>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
	<1350471893-29633-8-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48168 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273Ab2KQWB4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 17 Nov 2012 17:01:56 -0500
In-Reply-To: <1350471893-29633-8-git-send-email-keyuan.liu@gmail.com> (Kevin
	Liu's message of "Wed, 17 Oct 2012 19:04:46 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

Hi,

On Wed, Oct 17 2012, Kevin Liu wrote:
> From: Kevin Liu <kliu5@marvell.com>
>
> Both of MMC_TIMING_LEGACY and MMC_TIMING_UHS_SDR12 are defined
> to 0. And ios->timing is set to MMC_TIMING_LEGACY during power up.
> But set_ios can't distinguish these two timing if host support
> spec 3.0. Just adjust timing values to be different can resolve
> this issue without any other impact.
>
> Reviewed By: Girish K S <girish.shivananjappa@linaro.org>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> ---
>  include/linux/mmc/host.h |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 7abb0e1..8f5f6c0 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -53,12 +53,12 @@ struct mmc_ios {
>  #define MMC_TIMING_LEGACY	0
>  #define MMC_TIMING_MMC_HS	1
>  #define MMC_TIMING_SD_HS	2
> -#define MMC_TIMING_UHS_SDR12	MMC_TIMING_LEGACY
> -#define MMC_TIMING_UHS_SDR25	MMC_TIMING_SD_HS
> -#define MMC_TIMING_UHS_SDR50	3
> -#define MMC_TIMING_UHS_SDR104	4
> -#define MMC_TIMING_UHS_DDR50	5
> -#define MMC_TIMING_MMC_HS200	6
> +#define MMC_TIMING_UHS_SDR12	3
> +#define MMC_TIMING_UHS_SDR25	4
> +#define MMC_TIMING_UHS_SDR50	5
> +#define MMC_TIMING_UHS_SDR104	6
> +#define MMC_TIMING_UHS_DDR50	7
> +#define MMC_TIMING_MMC_HS200	8
>  
>  #define MMC_SDR_MODE		0
>  #define MMC_1_2V_DDR_MODE	1

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
