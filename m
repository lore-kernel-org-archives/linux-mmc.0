From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: MMC retry mechanism
Date: Mon, 07 Sep 2009 10:17:32 +0300
Message-ID: <4AA4B38C.6060202@nokia.com>
References: <011c01ca2dac$2de779d0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25943 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbZIGHRi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Sep 2009 03:17:38 -0400
In-Reply-To: <011c01ca2dac$2de779d0$544ff780@am.dhcp.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Madhusudhan wrote:
> Hi Adrian,
> 
> With respect to the below commit, It looks like currently the retry
> mechanism only handles the READ path.
> 
> I wonder could a similar retry logic feasible for the WRITE path?
> 
> Regards,
> Madhu

>From my point of view, writes should never fail.  In theory, the MMC
should have enough reserved blocks to cover bad blocks for the
expected lifetime of the device.  It should then be just copying
and remapping to avoid having to return write errors.

Of course, a lot of cards probably don't do that right.  However,
I think maybe the block layer already retries failed writes.

> 
>  
> 
> commit 6a79e391df295bd7c2aa1309ea5031f361c197fd
> Author: Adrian Hunter <ext-adrian.hunter@nokia.com>
> Date:   Wed Dec 31 18:21:17 2008 +0100
> 
>  
> 
>     mmc_block: ensure all sectors that do not have errors are read
> 
>     If a card encounters an ECC error while reading a sector it will
> 
>     timeout.  Instead of reporting the entire I/O request as having
> 
>     an error, redo the I/O one sector at a time so that all readable
> 
>     sectors are provided to the upper layers.
> 
>  
> 
>     Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>
> 
>     Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> 
> 

