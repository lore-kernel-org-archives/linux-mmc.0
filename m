From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: mmc0: Invalid maximum block size, assuming 512 bytes
Date: Tue, 2 Feb 2016 10:58:56 +0200
Message-ID: <56B06FD0.6000109@intel.com>
References: <569E575A.5070401@free.fr> <569EE03F.9090008@rock-chips.com>
 <56A0F2A1.3060805@free.fr> <56A18EFE.6000900@rock-chips.com>
 <56A1D791.9010803@free.fr> <56AFCEE0.1090005@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45380 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962AbcBBJDJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 2 Feb 2016 04:03:09 -0500
In-Reply-To: <56AFCEE0.1090005@free.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mason <slash.tmp@free.fr>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Suman Tripathi <stripathi@apm.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Frias <sf84@laposte.net>

On 01/02/16 23:32, Mason wrote:
> On 22/01/2016 08:17, Mason wrote:
> 
>> On 22/01/2016 03:07, Shawn Lin wrote:
>>
>>> On 2016/1/21 23:00, Mason wrote:
>>>
>>>> So that means I have to write code in
>>>> drivers/mmc/host/sdhci-of-arasan.c correct?
>>>
>>> It depends. If you think 512 block size if okay for you, leave it alone.
>>> Otherwise, add it in drivers/mmc/host/sdhci-of-arasan.c :)
>>
>> When I measured the read/write throughput to an attached
>> SD card, I got around 16 MB/s, and I thought raising the
>> block size might help with throughput?
>>
>> I'll test and report back.
> 
> Haven't had time to test yet, but I wanted to ask experienced
> folks what to expect when raising the block size from 512 to
> 2048 bytes?

mmc block driver sets block size to 512.

What you are looking at is maximum block size.  SDIO uses bigger block
sizes, so it is useful for that.


