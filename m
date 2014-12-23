From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC PATCH 0/5]mmc: Soft Command queue implementation for eMMC5.1
 device
Date: Tue, 23 Dec 2014 11:39:43 +0900
Message-ID: <5498D5EF.2070502@samsung.com>
References: <20141219080442.GA3775@intel.com> <5497A44D.6030000@samsung.com>
 <17296D9F8FF2234F831FC3DF505A87A911BB4398@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:34881 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbaLWCjq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Dec 2014 21:39:46 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NH000KY1KQ8Z040@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 23 Dec 2014 11:39:44 +0900 (KST)
In-reply-to: <17296D9F8FF2234F831FC3DF505A87A911BB4398@shsmsx102.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi, Dong.

On 12/23/2014 11:30 AM, Dong, Chuanxiao wrote:
> Hi Jaehoon,
> 
> It is in a draft eMMC5.1 spec. I believe the official eMMC5.1 spec will be released soon.

Thanks~.I want to see the eMMC5.1 spec. :)
I will test this feature with my board.

Best Regards,
Jaehoon Chung

> 
> Thanks
> Chuanxiao
> 
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org
>> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Jaehoon Chung
>> Sent: Monday, December 22, 2014 12:56 PM
>> To: Dong, Chuanxiao; linux-mmc@vger.kernel.org
>> Subject: Re: [RFC PATCH 0/5]mmc: Soft Command queue implementation for
>> eMMC5.1 device
>>
>> Hi, Chuanxiao.
>>
>> Was it published for the eMMC5.1 spec?
>>
>> Best Regards,
>> Jaehoon Chung
>>
>> On 12/19/2014 05:04 PM, Chuanxiao Dong wrote:
>>> Hello,
>>>
>>> Seems community already have some implementation for the eMMC5.1
>>> device command queue feature, but that require the eMMC host
>>> controller to support CMDQ. In my platform, I don't have this kind of
>>> eMMC host controller but I have a Samsung eMMC5.1 device which can
>> support the Command queue.
>>>
>>> With this limitation, I have to let eMMC host controller to manually
>>> send the CMD44/45/13/46/47. So in this way, more commands are needed
>>> for an I/O request, more interrupts/schedule are needed in driver.
>>>
>>> Even this way have some more software overhead, but it can still use
>>> the eMMC5.1 device Command queue feature. After test with the iozone
>> command:
>>> "iozone -zec -t 4 -i0 -i2 -F iozonefile1 iozonefile2 iozonefile3
>>> iozonefile4 -+n -I -r 4k -s 500m -O -R -+r -+D" to test random
>>> performance, I saw a performance improvment for random read on my
>> eMMC5.1 device:
>>>
>>> 		Random read
>>> SW CMDQ:	5544.6
>>> Normal Read:	3993.05
>>>
>>> So I want to send this serial patches as RFC patch for reviewing
>>>
>>>
>>> Chuanxiao Dong (5):
>>>   mmc: replace sbc to precmd and add postcmd
>>>   mmc: host: add runtime PM for host class dev
>>>   mmc: queue: change mqrq_cur and mqrq_pre to mq qdepth
>>>   mmc: core: add support for CMDQ feature in MMC Core stack
>>>   mmc: sdhci: add SW CMDQ support for CHT SDHCI host
>>>
>>>  drivers/mmc/card/block.c      |  538
>> ++++++++++++++++++++++++++++++++++++++---
>>>  drivers/mmc/card/queue.c      |  213 ++++++++--------
>>>  drivers/mmc/card/queue.h      |   14 +-
>>>  drivers/mmc/core/core.c       |   78 +++++-
>>>  drivers/mmc/core/host.c       |   14 ++
>>>  drivers/mmc/core/mmc.c        |   43 +++-
>>>  drivers/mmc/host/dw_mmc.c     |    8 +-
>>>  drivers/mmc/host/mmci.c       |   14 +-
>>>  drivers/mmc/host/omap_hsmmc.c |   18 +-
>>>  drivers/mmc/host/sdhci-acpi.c |    1 -
>>>  drivers/mmc/host/sdhci-pci.c  |    1 -
>>>  drivers/mmc/host/sdhci.c      |  137 +++++++++--
>>>  include/linux/mmc/card.h      |    3 +
>>>  include/linux/mmc/core.h      |    5 +-
>>>  include/linux/mmc/host.h      |    5 +
>>>  include/linux/mmc/mmc.h       |   21 ++
>>>  include/linux/mmc/pm.h        |    1 +
>>>  include/linux/mmc/sdhci.h     |    1 +
>>>  18 files changed, 909 insertions(+), 206 deletions(-)
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the body
>> of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
> 

