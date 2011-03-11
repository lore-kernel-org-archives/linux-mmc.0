From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] Exynos4: Add HSMMC channel 4 support
Date: Fri, 11 Mar 2011 12:45:59 +0900
Message-ID: <00e801cbdf9e$d934e3e0$8b9eaba0$%kim@samsung.com>
References: <20110308025340.GA25712@july>
 <00d601cbdf94$59254640$0b6fd2c0$%kim@samsung.com>
 <AANLkTimk+GPkxrDx0zG3rMam9OCz9sCL+2n4_c8KwLye@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:26075 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab1CKDq1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2011 22:46:27 -0500
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LHV00FE4JSTUPB0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 11 Mar 2011 12:46:05 +0900 (KST)
Received: from DOKGENEKIM02 ([12.23.103.104])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LHV0034AJST67@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 11 Mar 2011 12:46:05 +0900 (KST)
In-reply-to: <AANLkTimk+GPkxrDx0zG3rMam9OCz9sCL+2n4_c8KwLye@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Kyungmin Park' <kmpark@infradead.org>
Cc: jh80.chung@samsung.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Kyungmin Park wrote:
> 
> On Fri, Mar 11, 2011 at 11:30 AM, Kukjin Kim <kgene.kim@samsung.com>
wrote:
> > Kyungmin Park wrote:
> >>
> >> From: Kyungmin Park <kyungmin.park@samsung.com>
> >>
> >> Exynos4 has the DesignWare Host controller at channel 4.
> >>
> > Yeah, Exynos4210 has it but it can be happened problem when used your
> > approach later.
> > Because, we can't assume hsmmc4 to be used for dw_mmc on other SoCs.
> >
> > I mean, other file, eg., dev-dwmmc.c or dev-dwmci.c should be added for
its
> > platform devices.
> 
> Who's opinions? Please Cc the proper person at LSI. I want to listen
> his opinions.
> 
It's mine.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

