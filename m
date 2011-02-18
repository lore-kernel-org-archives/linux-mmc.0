From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 01/12] mmc: sdhci: add support for SD Host Controller 3.0
Date: Fri, 18 Feb 2011 11:08:50 -0800
Message-ID: <64C8576A-387E-44FB-A2E8-45033B5F9088@marvell.com>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
 <201102181408.35946.arnd@arndb.de>
 <6C03668EAF45B747AF947A1603D1B300DCED195D@SAUSEXMBP01.amd.com>
 <201102181640.16398.arnd@arndb.de>
 <F099B2A7-9E9B-4E33-A1D7-2C975A1A3BAB@marvell.com>
 <6C03668EAF45B747AF947A1603D1B300DCED1BCC@SAUSEXMBP01.amd.com>
 <alpine.LFD.2.00.1102181352090.14920@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:51343 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751458Ab1BRTKu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 18 Feb 2011 14:10:50 -0500
In-Reply-To: <alpine.LFD.2.00.1102181352090.14920@xanadu.home>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: "Nath, Arindam" <Arindam.Nath@amd.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>


Thanks Nico 

Anindam,  Lets follow Nico advise -- please ignore my last post on moving it into the host driver.

Philip

On Feb 18, 2011, at 10:55 AM, Nicolas Pitre wrote:

> On Fri, 18 Feb 2011, Nath, Arindam wrote:
> 
>> Hi Philip,
>> 
>> 
>>> -----Original Message-----
>>> From: Philip Rakity [mailto:prakity@marvell.com]
>>> Sent: Friday, February 18, 2011 9:19 PM
>>> To: Nath, Arindam
>>> Cc: Zhangfei Gao; Chris Ball; linux-mmc@vger.kernel.org; Su, Henry; Lu,
>>> Aaron; anath.amd@gmail.com; Nicolas Pitre
>>> Subject: [PATCH 01/12] mmc: sdhci: add support for SD Host Controller
>>> 3.0
>>> 
>>> 
>>> Arindam,
>>> 
>>> Could you look at making (Tuning)  CMD19 part of the sdhc.ci driver?
>>> It flow is part of the Host Controller and Physical layer specs.
> 
> Still, if this is something that is common to all host controllers then 
> it should live in the core code.  The host controller driver should be 
> as dumb as possible and try to be command agnostic.
> 
>> There are two main reasons for exposing the callback of tuning procedure from sdhci.c:
>> 
>> 1. The tuning procedure is part of UHS-I initialization sequence as described in Physical Layer Spec v3.01. Since the UHS-I init sequence takes places inside sd.c, so I thought it better to place it there instead.
>> 2. In future, if we need to add support for UHS-I sequence for sdio cards too, we can use the same callback from sdhci.c without any modifications.
> 
> And this won't have to be duplicated in all the host controller drivers.
> 
> 
> Nicolas

