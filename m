From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH 0/6] SD/MMC driver for MX25/35/51
Date: Wed, 13 Oct 2010 11:28:15 +0200
Message-ID: <8762x6xx00.fsf@lechat.rtp-net.org>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
	<87aamjxe00.fsf@lechat.rtp-net.org> <4CB56A88.2040101@eukrea.com>
	<20101013082930.GA11286@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lechat.rtp-net.org ([88.191.19.38]:40254 "EHLO
	lechat.rtp-net.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab0JMJTD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Oct 2010 05:19:03 -0400
In-Reply-To: <20101013082930.GA11286@pengutronix.de> (Wolfram Sang's message of "Wed\, 13 Oct 2010 10\:29\:30 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, Zhu Richard-R65037 <r65037@freescale.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Wolfram Sang <w.sang@pengutronix.de> writes:

Hi,

> On Wed, Oct 13, 2010 at 10:15:04AM +0200, Eric B=C3=A9nard wrote:
>
>> >I've tried it on a efika mx (to2 version) and I've a problem with t=
he
>> >write-protect. It's on a GPIO and I don't see any way to configure =
the
>> >esdhc-imx driver to use it. Any idea on how it should be done ?
>> >
>> it's actually not yet supported by the driver. There is a wp_gpio in
>> struct esdhc_platform_data (arch/arm/plat-mxc/include/mach/esdhc.h)
>> but it's not yet used by the driver.
>
> It's all prepared. I finally will have a look into it today.

oh, great. I was thinking about doing it but I'll wait for your patches
then. I'm sure I need support for WP on GPIO but I may also need suppor=
t
for CD on GPIO so I'll be happy to test any patch you have.


Thanks,
Arnaud
