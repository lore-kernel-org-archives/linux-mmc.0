From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-s3c: Enable runtime power management
Date: Tue, 06 Mar 2012 15:40:07 +0900
Message-ID: <4F55B147.6010304@samsung.com>
References: <4F51697C.40408@samsung.com>
 <1330735602-22409-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1330735602-22409-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4F549A0A.5020402@samsung.com>
 <20120305115209.GA3224@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:8758 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418Ab2CFGkN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Mar 2012 01:40:13 -0500
In-reply-to: <20120305115209.GA3224@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
 
On 03/05/2012 08:52 PM, Mark Brown wrote:

> On Mon, Mar 05, 2012 at 07:48:42PM +0900, Jaehoon Chung wrote:
>> On 03/03/2012 09:46 AM, Mark Brown wrote:
> 
>>> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> 
>> Could you explain why use 50ms? 
> 
> It's essentially a random number, some other devices use the same one.
> We're just trying to avoid suspending between back to back requests.
> 
>>> +	pm_runtime_use_autosuspend(&pdev->dev);
>>> +	pm_suspend_ignore_children(&pdev->dev, 1);
> 
>> Is there reason that ignore_children use to set the true?
> 
> So that we can suspend the host without having to have the MMC card
> suspended (the host suspend is not visible to the card).
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


