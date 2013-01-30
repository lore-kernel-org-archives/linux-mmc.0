From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: MAINTAINERS: change omap_hsmmc maintenance
 to orphan
Date: Wed, 30 Jan 2013 22:22:11 +0530
Message-ID: <51094FBB.7050503@ti.com>
References: <1358343026-17198-1-git-send-email-svenkatr@gmail.com> <8738xl8020.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50562 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753737Ab3A3QwT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Jan 2013 11:52:19 -0500
In-Reply-To: <8738xl8020.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Venkatraman S <svenkatr@gmail.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

On Tuesday 29 January 2013 03:03 AM, Chris Ball wrote:
> Hi,
>
> On Wed, Jan 16 2013, Venkatraman S wrote:
>> The specified email id is no longer in service.
>> Update the OMAP HSMMC entry from the MAINTAINERS file as I will
>> no longer be able to maintain this driver.
>>
>> Signed-off-by: Venkatraman S <svenkatr@gmail.com>
>> ---
>>   MAINTAINERS |    4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cd5b31f..95778e1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5499,10 +5499,8 @@ S:	Maintained
>>   F:	drivers/mmc/host/omap.c
>>
>>   OMAP HS MMC SUPPORT
>> -M:	Venkatraman S <svenkatr@ti.com>
>> -L:	linux-mmc@vger.kernel.org
>>   L:	linux-omap@vger.kernel.org
>> -S:	Maintained
>> +S:	Orphan
>>   F:	drivers/mmc/host/omap_hsmmc.c
>>
>>   OMAP RANDOM NUMBER GENERATOR SUPPORT
>
> Thanks for your work on omap_hsmmc, Venkat!
>
> Is anyone else interested in taking up maintenance of omap_hsmmc?

Hi Chris,
I am interested in maintaining omap_hsmmc,
Please add me as Maintainer and Thanks Venkat for his support

From: Balaji T K <balajitk@ti.com>
Subject: [PATCH] mmc: omap_hsmmc: MAINTAINERS: update

Update Maintainer email for omap_hsmmc,
as Venkatraman will no longer be able to maintain omap_hsmmc driver.

Signed-off-by: Venkatraman S <svenkatr@gmail.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
  MAINTAINERS |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux2/MAINTAINERS
===================================================================
--- linux2.orig/MAINTAINERS	2013-01-30 22:12:51.449322930 +0530
+++ linux2/MAINTAINERS	2013-01-30 22:21:22.412224531 +0530
@@ -5454,7 +5454,7 @@ S:	Maintained
  F:	drivers/mmc/host/omap.c

  OMAP HS MMC SUPPORT
-M:	Venkatraman S <svenkatr@ti.com>
+M:	Balaji T K <balajitk@ti.com>
  L:	linux-mmc@vger.kernel.org
  L:	linux-omap@vger.kernel.org
  S:	Maintained
>
> - Chris.
>
