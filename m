From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 3/3] dw_mmc: add quirks unreliable detect and capabilities
Date: Thu, 17 Mar 2011 19:22:08 +0900
Message-ID: <4D81E0D0.6030709@samsung.com>
References: <4D670F0F.6050003@samsung.com>
 <AANLkTikfOPtu+oecirTTxrgtaJb_uv+77U1aXuW8STV2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:17965 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554Ab1CQKWr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2011 06:22:47 -0400
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LI7005ER65X2910@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 17 Mar 2011 19:22:45 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LI70082I65X8A@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 17 Mar 2011 19:22:45 +0900 (KST)
In-reply-to: <AANLkTikfOPtu+oecirTTxrgtaJb_uv+77U1aXuW8STV2@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Chris..

I want to know your opinion..

Regards,
Jaehoon Chung

Will Newton wrote:
> On Fri, Feb 25, 2011 at 2:08 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> This patch added quirks and capabilities in platdata.
>>
>> Some card didn't use the CDn pin. In that case, We assume card inserted,
>> then the card initialized or not.
>> And Some board need other capabilities. So added capabilities in board platdata.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c  |   10 ++++++++--
>>  include/linux/mmc/dw_mmc.h |   10 +++++++---
>>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> Acked-by: Will Newton <will.newton@imgtec.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

