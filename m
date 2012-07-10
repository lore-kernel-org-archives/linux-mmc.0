From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v8 1/2] mmc: add packed command feature of eMMC4.5
Date: Tue, 10 Jul 2012 03:33:55 -0400
Message-ID: <87mx38qdcs.fsf@octavius.laptop.org>
References: <006801cd55b0$314960f0$93dc22d0$%jun@samsung.com>
	<87y5msqhxy.fsf@octavius.laptop.org>
	<fc0bbbfabb899fd68e522b843b668041.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50054 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174Ab2GJHeD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Jul 2012 03:34:03 -0400
In-Reply-To: <fc0bbbfabb899fd68e522b843b668041.squirrel@www.codeaurora.org>
	(merez@codeaurora.org's message of "Mon, 9 Jul 2012 23:23:52 -0700
	(PDT)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, 'Subhash Jadavani' <subhashj@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>, 'Saugata Das' <saugata.das@linaro.org>, 'Namjae Jeon' <linkinjeon@gmail.com>

Hi,

On Tue, Jul 10 2012, merez@codeaurora.org wrote:
>> Sorry, I don't have a copy of the eMMC 4.5 spec -- is PACKED_EVENT_EN
>> a one-time programmable fuse on the eMMC, like BKOPS_ENABLE was?
>
> No, it's not.

Excellent, thanks.

I've pushed both v8 patches to mmc-next.  Before pushing it up to Linus,
I'd like to get a better idea of the variety of performances differences
seen using packed writes -- has it been tried on devices from multiple
eMMC vendors, and multiple host controller vendors?  Can we try to build
up a quick table of results, with a standard test like iozone, to check
that we've got decent test coverage?  Seungwon suggests using:

iozone -az -i0 -I -s 10m -f /target/test -e

I'm also worried about how much code this is adding, but I agree that
it's worth it if the performance benefits are as described.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
