From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v8] mmc: support BKOPS feature for eMMC
Date: Fri, 11 May 2012 14:38:26 +0900
Message-ID: <4FACA5D2.3050706@samsung.com>
References: <4FABC495.8060708@samsung.com>
 <aa38953dd272014cd1c4d014ce9d15bd.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:40453 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755344Ab2EKFiv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 May 2012 01:38:51 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M3U00KMHFO3O320@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 11 May 2012 14:38:50 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M3U000ULFOPOMB0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 11 May 2012 14:38:50 +0900 (KST)
In-reply-to: <aa38953dd272014cd1c4d014ce9d15bd.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kdorfman@codeaurora.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>

Hi Konstantin.

On 05/10/2012 11:46 PM, kdorfman@codeaurora.org wrote:

> Hi Jaehoon,
> I see 2 issues with new patch:
> 1. New code starts BKOPS always with waiting for BUSY. (see comment below
> in the code)
> 2. Runtime suspend (mmc_suspend_host) do not checks that BKOPS is in
> progress,
> this means, that CMD5 (slee) will fail.

You're right. it needs to check in progress.
I will add them.

> 
> 
> In your previous patch (v7) was code:
> 
> -	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> +	cmd.flags = MMC_CMD_AC;
> +	if (index == EXT_CSD_BKOPS_START &&
> +	    card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LEVEL_2)
> +		cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
> +	else
> +		cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
> 
> When level of raw_bkops_status is not critical, the host controller flags
> used
> without waiting for BUSY line release. This means, that mmc queue thread
> will continue
> to fetch requests while BKOPS still running on the card.
> Without this code, BKOPS will always be blocking till BKOPS done and using
> HPI for interrupt BKOPS on
> new request is not need.
> Why you removed this code?

You're right. it's my mistake. Actually i modified to use with __mmc_switch().
As I remember, maybe you mentioned this point. right?
So i tried to use based on your review. it's missing in this patch.

Thank you for your comment. any other comments?
If you have others, let me know, plz.

Best Regards,
Jaehoon Chung

> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


