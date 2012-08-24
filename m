From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 4/5] mmc: dw-mmc: add the header file for exynos specific
 code.
Date: Fri, 24 Aug 2012 18:35:46 +0900
Message-ID: <50374AF2.60706@samsung.com>
References: <503614A7.3050004@samsung.com>
 <CAFbHwiRjhRmX3C-KgkC59F7c7EK4ivf4U2oCFfRtV5=EpLtSXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:9265 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756351Ab2HXJgF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Aug 2012 05:36:05 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9900H6M6N35WZ0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 24 Aug 2012 18:36:03 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M99004K46O35C90@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 24 Aug 2012 18:36:03 +0900 (KST)
In-reply-to: <CAFbHwiRjhRmX3C-KgkC59F7c7EK4ivf4U2oCFfRtV5=EpLtSXw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

Hi Will

On 08/24/2012 06:29 PM, Will Newton wrote:
> On Thu, Aug 23, 2012 at 12:31 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> 
> Hi Jaehoon,
> 
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  include/linux/mmc/exynos-dw_mmc.h |   55 +++++++++++++++++++++++++++++++++++++
>>  1 files changed, 55 insertions(+), 0 deletions(-)
>>  create mode 100644 include/linux/mmc/exynos-dw_mmc.h
> 
> What is the purpose of adding this header file if it is not included
> anywhere? Is there a patch missing from the series?
I will send to add the patch in the next version.
This header should be included into board file related with exynos4 or exynos5.
Thank you for comment.

Best Regards,
Jaehoon Chung
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

