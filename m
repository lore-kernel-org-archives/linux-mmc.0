From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 4/4] mmc: dw-mmc: remove complier warning
Date: Tue, 20 Nov 2012 10:40:26 +0900
Message-ID: <50AADF8A.2080804@samsung.com>
References: <509B6ED5.6070101@samsung.com> <50AA24B1.8050303@imgtec.com>
 <50AA2BD0.90200@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:39635 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778Ab2KTBka (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 20:40:30 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MDR003D2JBD1N70@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 20 Nov 2012 10:40:28 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MDR00GMFJBFF220@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 20 Nov 2012 10:40:28 +0900 (KST)
In-reply-to: <50AA2BD0.90200@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>

Hi James,

This patch has already merged with Arnd's patch.
He also sent the same patch.

Best Regards,
Jaehoon Chung

On 11/19/2012 09:53 PM, James Hogan wrote:
> On 19/11/12 12:23, James Hogan wrote:
>> On 08/11/12 08:35, Jaehoon Chung wrote:
>>> drivers/mmc/host/dw_mmc.c: In function 'dw_mci_prepare_command':
>>> drivers/mmc/host/dw_mmc.c:256:37: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]
>>> drivers/mmc/host/dw_mmc.c: In function 'dw_mci_set_ios':
>>> drivers/mmc/host/dw_mmc.c:805:37: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]
>>> drivers/mmc/host/dw_mmc.c: In function 'dw_mci_init_slot':
>>> drivers/mmc/host/dw_mmc.c:1849:37: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]
>>> drivers/mmc/host/dw_mmc.c: In function 'dw_mci_parse_dt':
>>> drivers/mmc/host/dw_mmc.c:2049:37: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]
>>> drivers/mmc/host/dw_mmc.c: In function 'dw_mci_probe':
>>> drivers/mmc/host/dw_mmc.c:2095:37: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]
>>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>
>> Acked-by: James Hogan <james.hogan@imgtec.com>
> 
> Chris: Is it okay to get this patch into v3.7?
> 
> Thanks
> James
> 
> 

