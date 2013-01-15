From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC PATCH] MAINTAINERS: Add an orphaned entry for the dw_mmc
 driver.
Date: Tue, 15 Jan 2013 11:07:46 +0900
Message-ID: <50F4B9F2.3090104@samsung.com>
References: <CAFbHwiRX19Zm=O2dNZrbTDGZxnXDOx0zJ3pvTkfC1q8m5DBFug@mail.gmail.com>
 <87wqvjmxt6.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [203.254.224.24] ([203.254.224.24]:46304 "EHLO
	mailout1.samsung.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1757234Ab3AOCI6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Jan 2013 21:08:58 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MGN003A49X60X60@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 15 Jan 2013 11:08:27 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MGN003SJ9Y2UE00@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 15 Jan 2013 11:08:27 +0900 (KST)
In-reply-to: <87wqvjmxt6.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Will Newton <will.newton@gmail.com>, linux-mmc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, James Hogan <james.hogan@imgtec.com>

Hi All,

I have interesting to maintain "dw_mmc" driver.

Best Regards,
Jaehoon Chung

On 01/12/2013 02:31 AM, Chris Ball wrote:
> Hi,
> 
> On Fri, Jan 11 2013, Will Newton wrote:
>> I submitted this driver but will shortly no longer have access
>> to hardware that uses it. The driver is quite widely used so
>> there may be someone out there that feels strongly enough to
>> step up and maintain it.
>> ---
>>  MAINTAINERS |    6 ++++++
>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f940e81..88329bc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6558,6 +6558,12 @@ F:	include/linux/dw_dmac.h
>>  F:	drivers/dma/dw_dmac_regs.h
>>  F:	drivers/dma/dw_dmac.c
>>
>> +SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER
>> +L:	linux-mmc@vger.kernel.org
>> +S:	Orphaned
>> +F:	include/linux/mmc/dw_mmc.h
>> +F:	drivers/mmc/host/dw_mmc*
>> +
>>  TIMEKEEPING, NTP
>>  M:	John Stultz <johnstul@us.ibm.com>
>>  M:	Thomas Gleixner <tglx@linutronix.de>
> 
> Thanks for your work on the driver, Will!  I'm CC'ing some recent
> committers so they can volunteer to take over if they're interested.
> 
> - Chris.
> 

