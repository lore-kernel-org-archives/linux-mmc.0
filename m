From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix dependency on indirect header inclusion
Date: Sat, 24 Aug 2013 22:51:04 -0400
Message-ID: <8761uutrdz.fsf@octavius.laptop.org>
References: <1373548145-3833-1-git-send-email-balbi@ti.com>
	<520E5382.1090408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40664 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754894Ab3HYCvL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Aug 2013 22:51:11 -0400
In-Reply-To: <520E5382.1090408@ti.com> (Balaji T. K.'s message of "Fri, 16 Aug
	2013 21:59:54 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, a-bindra@ti.com, Tony Lindgren <tony@atomide.com>, ezequiel.garcia@free-electrons.com, nm@ti.com

Hi,

On Fri, Aug 16 2013, Balaji T K wrote:
> On Thursday 11 July 2013 06:39 PM, Felipe Balbi wrote:
>> omap_hsmmc.c depends on <linux/sizes.h> being
>> included indirectly by another header. Once we
>> enable COMPILE_TEST for this driver, we might
>> compile under architectures which won't include
>> <linux/sizes.h> for us. In fact, one such case
>> is x86.
>>
>> In order to prevent compile breakages, let's
>> explicitly include <linux/sizes.h>
>>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> ---
>>
>> This should be applied before
>> http://marc.info/?l=linux-omap&m=137347241524118&w=2
>> in order to maintain bisectability.
> Thanks Felipe
>
> Acked-by: Balaji T K <balajitk@ti.com>

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
