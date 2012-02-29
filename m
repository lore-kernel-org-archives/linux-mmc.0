From: Chris Ball <cjb@laptop.org>
Subject: Re: atmel-mci causing oops?
Date: Wed, 29 Feb 2012 12:35:52 -0500
Message-ID: <m2linlo83r.fsf@bob.laptop.org>
References: <20120229173115.GA23529@ldesroches-Latitude-E6320>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57074 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030904Ab2B2Rg2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Feb 2012 12:36:28 -0500
In-Reply-To: <20120229173115.GA23529@ldesroches-Latitude-E6320> (Ludovic
	Desroches's message of "Wed, 29 Feb 2012 18:31:15 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc@vger.kernel.org, "Ferre, Nicolas" <nicolas.ferre@atmel.com>, plagnioj@jcrosoft.com, me@danielpalmer.co.uk, linux-arm-kernel@lists.infradead.org

Hi Ludovic,

On Wed, Feb 29 2012, Ludovic Desroches wrote:
> You can find the two patches into the mmc-next tree of Chris:
> http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=43df92914ea0623893bcb801791d5d2be2f5e015
> http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=9cfa4030ea90f2fc204532975a824b987433f6dd
>
> By the way, Chris, is it possible to put these patches as a fix for 3.3
> kernel? Without them we will have this oops each time someone would use
> mmc without a DMA Controller or if it is impossible to get a dma channel.

Will do, thanks.  Should they go to 3.2-stable, too?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
