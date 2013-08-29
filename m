From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [RFC V3 0/4] dw_mmc platform specific private data and SMU init
Date: Thu, 29 Aug 2013 16:12:34 +0900
Message-ID: <000401cea487$22820690$678613b0$%jun@samsung.com>
References: <1377691731-7226-1-git-send-email-yuvaraj.cd@samsung.com>
 <521EBA6D.2070900@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:14670 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777Ab3H2HMg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2013 03:12:36 -0400
In-reply-to: <521EBA6D.2070900@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Yuvaraj Kumar C D' <yuvaraj.cd@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, ks.giri@samsung.com, t.figa@samsung.com, alim.akhtar@samsung.com, 'Yuvaraj Kumar C D' <yuvaraj.cd@samsung.com>

On Thursday, August 29, 2013, Jaehoon Chung wrote:
> Hi Yuvaraj,
> 
> I have tested on Exynos4 series.
> I didn't test for SMU feature. If Seungwon could test or review and confirm this patch,
> then looks good to me.
> 
> With exynos4 series,
> Tested-by: Jaehoon Chung <jh80.chung@samsung.com>

Just now, this series looks good to me.
But direct access for SMU concerning (4/4, exynos: configure SMU in exynos5420') 
will be removed in driver before long.
I will sort your patches with the pending others.

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon

> 
> Best Regards.
> Jaehoon Chung
> 
> On 08/28/2013 09:08 PM, Yuvaraj Kumar C D wrote:
> > changes from V2:
> > 	1.dropped the bypass-smu quirk
> > 		mmc: dw_mmc: exynos: configure SMU in exynos5420.
> > 	2.Changed the subject line for this patch
> > 	  add a quirk for SMU -> configure SMU in exynos5420
> >
> > 	mmc: dw_mmc: exynos: configure SMU in exynos5420
> > 	was earlier
> > 	mmc: dw_mmc: exynos: add a quirk for SMU.
> >
> > changes from V1:
> > 	1.Added a new RFC patch
> > 		mmc: dw_mmc: socfpga: move socfpga private init
> > 	2.Avoid code duplication in
> > 		mmc: dw_mmc: exynos: add a quirk for SMU.
> >
> > Yuvaraj Kumar C D (4):
> >   mmc: dw_mmc: exynos: move the exynos private init
> >   mmc: dw_mmc: socfpga: move socfpga private init
> >   mmc: dw_mmc: move the platform specific init call
> >   mmc: dw_mmc: exynos: configure SMU in exynos5420.
> >
> >  drivers/mmc/host/dw_mmc-exynos.c  |   56 +++++++++++++++++++++++++++----------
> >  drivers/mmc/host/dw_mmc-pltfm.c   |    7 -----
> >  drivers/mmc/host/dw_mmc-socfpga.c |   29 ++++++++++---------
> >  drivers/mmc/host/dw_mmc.c         |    9 ++++++
> >  4 files changed, 65 insertions(+), 36 deletions(-)
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

