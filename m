From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/3] dw_mmc: support mmc power control with regulator
Date: Thu, 17 Mar 2011 19:23:01 +0900
Message-ID: <4D81E105.7060501@samsung.com>
References: <4D670F0E.7000800@samsung.com>
 <AANLkTi=4_BanAR4+Sq4AKy6fwHptsyR41b66FP_-ETjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:28468 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881Ab1CQKqb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2011 06:46:31 -0400
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LI700B8O67DY210@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 17 Mar 2011 19:23:37 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LI700EOL67EAU@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 17 Mar 2011 19:23:38 +0900 (KST)
In-reply-to: <AANLkTi=4_BanAR4+Sq4AKy6fwHptsyR41b66FP_-ETjQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Chris..

I want to know this patch..

Regard,
Jaehoon Chung

Will Newton wrote:
> On Fri, Feb 25, 2011 at 2:08 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> This patch is applied the power control with regulator.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c  |   25 +++++++++++++++++++++++++
>>  include/linux/mmc/dw_mmc.h |    2 ++
>>  2 files changed, 27 insertions(+), 0 deletions(-)
> 
> This looks ok from an mmc point of view. I'm not that familiar with
> the regulator API however, so it would be good to get a review from
> someone who is.
> 
> Acked-by: Will Newton <will.newton@imgtec.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

