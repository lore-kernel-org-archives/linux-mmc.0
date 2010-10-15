From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH 0/6] SD/MMC driver for MX25/35/51
Date: Fri, 15 Oct 2010 23:20:41 +0200
Message-ID: <87fww7up92.fsf@lechat.rtp-net.org>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
	<87aamjxe00.fsf@lechat.rtp-net.org> <4CB56A88.2040101@eukrea.com>
	<20101013082930.GA11286@pengutronix.de>
	<8762x6xx00.fsf@lechat.rtp-net.org>
	<20101015102534.GA4276@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lechat.rtp-net.org ([88.191.19.38]:32770 "EHLO
	lechat.rtp-net.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932336Ab0JOVTw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Oct 2010 17:19:52 -0400
In-Reply-To: <20101015102534.GA4276@pengutronix.de> (Wolfram Sang's message of "Fri\, 15 Oct 2010 12\:25\:34 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, Zhu Richard-R65037 <r65037@freescale.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Wolfram Sang <w.sang@pengutronix.de> writes:

Hi,

> On Wed, Oct 13, 2010 at 11:28:15AM +0200, Arnaud Patard wrote:
>
>> >> it's actually not yet supported by the driver. There is a wp_gpio in
>> >> struct esdhc_platform_data (arch/arm/plat-mxc/include/mach/esdhc.h)
>> >> but it's not yet used by the driver.
>> >
>> > It's all prepared. I finally will have a look into it today.
>> 
>> oh, great. I was thinking about doing it but I'll wait for your patches
>> then. I'm sure I need support for WP on GPIO but I may also need support
>> for CD on GPIO so I'll be happy to test any patch you have.
>
> Just to keep you updated: Got a bit distracted again but I hope to
> finish it on Saturday. Looks like a patch for the gpiolib is also
> needed...

ok. Take your time. It turns out that the infos I had were a bit
misleading. I've been told the mmc driver was using some gpios and the
gpios are GPIO_1_0/1_1 and GPIO_1_7/1_8... which are in fact the esdhc1
and esdhc2 CD and WP. 

This means :
- with proper iomux configuration, WP detection is working fine
- I should still be able to test WP on GPIO

Thanks,
Arnaud
