From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 01/12] mmc: sdhci: add support for SD Host Controller 3.0
Date: Fri, 18 Feb 2011 11:06:14 -0800
Message-ID: <4AD32D83-E4DD-4677-9B7C-C582D50B1792@marvell.com>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
 <201102181408.35946.arnd@arndb.de>
 <6C03668EAF45B747AF947A1603D1B300DCED195D@SAUSEXMBP01.amd.com>
 <201102181640.16398.arnd@arndb.de>
 <F099B2A7-9E9B-4E33-A1D7-2C975A1A3BAB@marvell.com>
 <6C03668EAF45B747AF947A1603D1B300DCED1BCC@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:46669 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751458Ab1BRTG4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 18 Feb 2011 14:06:56 -0500
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300DCED1BCC@SAUSEXMBP01.amd.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: Zhangfei Gao <zhangfei.gao@gmail.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>, Nicolas Pitre <nico@fluxnic.net>


On Feb 18, 2011, at 9:17 AM, Nath, Arindam wrote:

> Hi Philip,
> 
> 
>> -----Original Message-----
>> From: Philip Rakity [mailto:prakity@marvell.com]
>> Sent: Friday, February 18, 2011 9:19 PM
>> To: Nath, Arindam
>> Cc: Zhangfei Gao; Chris Ball; linux-mmc@vger.kernel.org; Su, Henry; Lu,
>> Aaron; anath.amd@gmail.com; Nicolas Pitre
>> Subject: [PATCH 01/12] mmc: sdhci: add support for SD Host Controller
>> 3.0
>> 
>> 
>> Arindam,
>> 
>> Could you look at making (Tuning)  CMD19 part of the sdhc.ci driver?
>> It flow is part of the Host Controller and Physical layer specs.
> 
> There are two main reasons for exposing the callback of tuning procedure from sdhci.c:
> 
> 1. The tuning procedure is part of UHS-I initialization sequence as described in Physical Layer Spec v3.01. Since the UHS-I init sequence takes places inside sd.c, so I thought it better to place it there instead.

understand -- I think it should be in the driver as part of the init sequence.  Once you have some code I can prototype this.  We can do it offline.

> 2. In future, if we need to add support for UHS-I sequence for sdio cards too, we can use the same callback from sdhci.c without any modifications.
> 

SDIO is not a problem  -- almost follows same code sequence.  I have this almost working.

> I am open to suggestions.
> 
> Regards,
> Arindam
> 

