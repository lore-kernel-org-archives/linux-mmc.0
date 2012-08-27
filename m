From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 00/10] Assorted MMC / OMAP HSMMC patches
Date: Mon, 27 Aug 2012 19:02:11 -0400
Message-ID: <87y5l0x7kc.fsf@octavius.laptop.org>
References: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
	<20120821104330.GS10347@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33729 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754793Ab2H0XCQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Aug 2012 19:02:16 -0400
In-Reply-To: <20120821104330.GS10347@arwen.pp.htv.fi> (Felipe Balbi's message
	of "Tue, 21 Aug 2012 13:43:31 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: balbi@ti.com
Cc: Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, balajitk@ti.com, vishp@ti.com

Hi,

On Tue, Aug 21 2012, Felipe Balbi wrote:
> On Sat, Aug 18, 2012 at 12:22:20AM +0530, Venkatraman S wrote:
>> Essentially, a lot of cleanups leading up to adding a new
>> feature for OMAP HSMMC. The idea is to convert to the use
>> of software timer instead of IP timer for timekeeping, due
>> to the limitations of the counting range of the IP timer.
>> 
>> Also added myself as OMAP HSMMC maintainer.
>> 
>> Patch 9/10 is in draft state and needs more testing.
>> 
>> These patches are also available at
>>   git://github.com/svenkatr/linux.git my/mmc/3.6/hrtimer_updates
>
> other than the small comments I had to patch 9, this series looks very
> good:
>
> Acked-by: Felipe Balbi <balbi@ti.com>

Thanks -- I've pushed everything except 9/10 to mmc-next for 3.7.
Venkat, please resubmit patch 9 individually whenever you're ready.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
