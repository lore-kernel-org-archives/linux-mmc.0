From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: remove not using parameter in struct mmc_ios
Date: Thu, 11 Aug 2011 17:40:53 -0400
Message-ID: <m2bovvpqxm.fsf@bob.laptop.org>
References: <4E3FA81C.1000702@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35985 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754203Ab1HKVk7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Aug 2011 17:40:59 -0400
In-Reply-To: <4E3FA81C.1000702@samsung.com> (Jaehoon Chung's message of "Mon,
	08 Aug 2011 18:10:52 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>

Hi Jaehoon,

On Mon, Aug 08 2011, Jaehoon Chung wrote:
> This patch is removed ddr parameter in struct mmc_ios.
>
> If applied Seungwon's Patch([PATCH] mmc: dw_mmc: Fix DDR mode
> support.), no more used.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  include/linux/mmc/host.h |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 0f83858..1d09562 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -56,8 +56,6 @@ struct mmc_ios {
>  #define MMC_TIMING_UHS_SDR104	4
>  #define MMC_TIMING_UHS_DDR50	5
>  
> -	unsigned char	ddr;			/* dual data rate used */
> -
>  #define MMC_SDR_MODE		0
>  #define MMC_1_2V_DDR_MODE	1
>  #define MMC_1_8V_DDR_MODE	2

Thanks, pushed to mmc-next for 3.1.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
