From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] Support Mobile Storage controller Interface
Date: Thu, 06 Jan 2011 14:14:17 +0900
Message-ID: <00da01cbad60$96c10950$c4431bf0$%kim@samsung.com>
References: <00c401cbad49$fca5c010$f5f14030$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:51861 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab1AFFOn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jan 2011 00:14:43 -0500
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LEL00FZJ5821YB0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 06 Jan 2011 14:14:27 +0900 (KST)
Received: from DOKGENEKIM02 ([12.23.103.104])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LEL0061R582ZH@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 06 Jan 2011 14:14:27 +0900 (KST)
In-reply-to: <00c401cbad49$fca5c010$f5f14030$%kim@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, kyungmin.park@samsung.com, prakity@marvell.com, afleming@gmail.com, akpm@linux-foundation.org, hyuk1.lee@samsung.com, jh0801.jung@samsung.com, chaos.youn@samsung.com, 'Sangbeom Kim' <sbkim73@samsung.com>

Jaehoon Chung wrote:
>
> I tried to use mobile storage with sdhci-controller, but bit controlling
is
> too many different
> So need Mobile Storage controller.
> 
> I tested only 8-bit buswidth. It's working well...i think performance
> didn't ensure yet.
> It should be add DDR feature.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/Kconfig  |   12 +
>  drivers/mmc/host/Makefile |    1 +
>  drivers/mmc/host/mshci.c  | 1499
> +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/mshci.h  |  364 +++++++++++
>  4 files changed, 1876 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mmc/host/mshci.c
>  create mode 100644 drivers/mmc/host/mshci.h
> 
(Cc'ed regarding engineer in my team)

Wow, almost same driver is in my team's git tree except
author(MODULE_AUTHOR) and small fix.
(git://git.kernel.org/pub/scm/linux/kernel/git/kki_ap/linux-2.6-samsung.git)

Both have same comments...and in addition, same typo!!! :-(

Actually, we had a plan to submit it, this driver is under test on board and
we still fixing this now.

I would welcome MMC maintainer, Chris' response(or any other response) about
this.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

