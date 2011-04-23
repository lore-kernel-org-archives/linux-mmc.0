From: Chris Ball <cjb@laptop.org>
Subject: Re: CMD23 plumbing and support patchset.
Date: Fri, 22 Apr 2011 22:51:32 -0400
Message-ID: <m3y631wuh7.fsf@pullcord.laptop.org>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
	<1302950458-1969-1-git-send-email-andreiw@motorola.com>
	<m3pqogbcoa.fsf@pullcord.laptop.org>
	<BANLkTik99XdFSsb7cjX0YoYHRA2d+Vn_yg@mail.gmail.com>
	<BANLkTikDNNso=TBF-BiewTFTFeHqe1WDhw@mail.gmail.com>
	<BANLkTi=Vj0p-=d0YLR=vk2CdSxH2GVz1+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43379 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752955Ab1DWCrk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2011 22:47:40 -0400
In-Reply-To: <BANLkTi=Vj0p-=d0YLR=vk2CdSxH2GVz1+A@mail.gmail.com> (Andrei
	Warkentin's message of "Thu, 21 Apr 2011 22:53:00 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com

Hi,

On Thu, Apr 21 2011, Andrei Warkentin wrote:
>>> Can you give me the manufacturing date? This is pretty interesting.
>>>
>>> You can see an improvement even if you do something like time block
>>> writes (O_DIRECT | O_SYNC, of course). But after all synthetic tests I
>>> measured the time it took to do 40000 SQLite insertions and saw
>>> something like 30% improvement.
>>>
>>
>> And you're trying this on SDHCI I presume, right?
>
> Is this on the same board as the other log you sent? Controller is
> SDHCI-PXA? If you give me  /sys/block/mmcblk0/device/date,
> I'll investigate why this improvement isn't helping you out.

Yeah, sdhci-pxa:

[root@localhost olpc]# cat /sys/block/mmcblk0/device/date
10/2010

Want to give me a benchmark script so that we can compare speeds
directly?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
