From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v4 1/7] mmc: dw_mmc: use the mmc_of_parse() instead of
 local parser
Date: Fri, 07 Mar 2014 00:02:16 +0900
Message-ID: <002901cf394d$10880b50$319821f0$%jun@samsung.com>
References: <5313EAB9.7010001@gmail.com> <531808DA.5070306@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:22655 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbaCFPCT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Mar 2014 10:02:19 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N2000M8VSFTXCB0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 07 Mar 2014 00:02:17 +0900 (KST)
In-reply-to: <531808DA.5070306@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>

On Thu, March 06, 2014, Jaehoon Chung wrote:
> Dear, All.
> 
> Do you have any other comment for this patchset?
> I have tested with exynos4/5 board. it's working fine.(eMMC/SD)
> 
> If it needs to change more, let me know, plz.
> 
> Best Regards,
> Jaehoon Chung
> 
> On 03/03/2014 11:36 AM, Jaehoon Chung wrote:
> > mmc_of_parse() have been already parsed the general capability.
> > Didn't need to use the local parser.
> >
> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Thank you for changes.

I add my ack on all patches including V4's others.

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon


