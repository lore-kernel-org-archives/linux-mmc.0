From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] Support Mobile Storage controller Interface
Date: Thu, 06 Jan 2011 14:28:46 +0900
Message-ID: <4D25530E.5030408@samsung.com>
References: <00c401cbad49$fca5c010$f5f14030$%kim@samsung.com>
 <00da01cbad60$96c10950$c4431bf0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:60630 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab1AFF26 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jan 2011 00:28:58 -0500
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LEL00FR45W81YC0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 06 Jan 2011 14:28:56 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LEL00D535W8N4@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 06 Jan 2011 14:28:56 +0900 (KST)
In-reply-to: <00da01cbad60$96c10950$c4431bf0$%kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, kyungmin.park@samsung.com, prakity@marvell.com, afleming@gmail.com, akpm@linux-foundation.org, hyuk1.lee@samsung.com, jh0801.jung@samsung.com, chaos.youn@samsung.com, 'Sangbeom Kim' <sbkim73@samsung.com>

Dear Kukjin Kim

i resent mshci patch..not this version.. 
you want..i would remove this patch..

If i resend the other patch...maybe something should present same thing.
because based-on sdhci.c and DWC mobile storage spec..

i will resend the next week..

Thank you for your opinion and sorry Mr.Kim

Thanks.
Jaehoon Chung

Kukjin Kim wrote:
> Jaehoon Chung wrote:
>> I tried to use mobile storage with sdhci-controller, but bit controlling
> is
>> too many different
>> So need Mobile Storage controller.
>>
>> I tested only 8-bit buswidth. It's working well...i think performance
>> didn't ensure yet.
>> It should be add DDR feature.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/host/Kconfig  |   12 +
>>  drivers/mmc/host/Makefile |    1 +
>>  drivers/mmc/host/mshci.c  | 1499
>> +++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/mmc/host/mshci.h  |  364 +++++++++++
>>  4 files changed, 1876 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/mmc/host/mshci.c
>>  create mode 100644 drivers/mmc/host/mshci.h
>>
> (Cc'ed regarding engineer in my team)
> 
> Wow, almost same driver is in my team's git tree except
> author(MODULE_AUTHOR) and small fix.
> (git://git.kernel.org/pub/scm/linux/kernel/git/kki_ap/linux-2.6-samsung.git)
> 
> Both have same comments...and in addition, same typo!!! :-(
> 
> Actually, we had a plan to submit it, this driver is under test on board and
> we still fixing this now.
> 
> I would welcome MMC maintainer, Chris' response(or any other response) about
> this.
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

