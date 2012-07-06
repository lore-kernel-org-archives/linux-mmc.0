From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v9] mmc: support BKOPS feature for eMMC
Date: Fri, 06 Jul 2012 12:47:45 -0400
Message-ID: <874npkx2dq.fsf@octavius.laptop.org>
References: <4FD1821D.4070603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43337 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757857Ab2GFQsE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 6 Jul 2012 12:48:04 -0400
In-Reply-To: <4FD1821D.4070603@samsung.com> (Jaehoon Chung's message of "Fri,
	08 Jun 2012 13:39:57 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Maya Erez <merez@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>

Hi,

On Fri, Jun 08 2012, Jaehoon Chung wrote:
> Enable eMMC background operations (BKOPS) feature.
>
> If URGENT_BKOPS is set after a response, note that BKOPS
> are required. After all I/O requests are finished, run
> BKOPS if required. Should read/write operations be requested
> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
> and then service the request.
> If BKOPS-STATUS is upper than LEVEL2, need to check until clear
> the BKOPS-STATUS vaule. 
>
> If you want to enable this feature, set MMC_CAP2_BKOPS.
> And if you want to set the BKOPS_EN bit in ext_csd register,
> use the MMC_CAP2_INIT_BKOPS.
[..]
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 0707d22..d23caf2 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -238,6 +238,8 @@ struct mmc_host {
>  #define MMC_CAP2_BROKEN_VOLTAGE	(1 << 7)	/* Use the broken voltage */
>  #define MMC_CAP2_DETECT_ON_ERR	(1 << 8)	/* On I/O err check card removal */
>  #define MMC_CAP2_HC_ERASE_SZ	(1 << 9)	/* High-capacity erase size */
> +#define MMC_CAP2_INIT_BKOPS	(1 << 10)	/* To enable BKOPS */
> +#define MMC_CAP2_BKOPS		(1 << 11)	/* BKOPS supported */

Can we have a better explanation of how these capabilities are supposed
to be used, and why it's necessary to have two of them?  Why would you
set one but not the other?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
