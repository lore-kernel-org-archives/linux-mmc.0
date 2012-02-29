From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: atmel-mci causing oops?
Date: Wed, 29 Feb 2012 18:31:15 +0100
Message-ID: <20120229173115.GA23529@ldesroches-Latitude-E6320>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:53571 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab2B2Rb5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Feb 2012 12:31:57 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: "Ferre, Nicolas" <nicolas.ferre@atmel.com>, plagnioj@jcrosoft.com, cjb@laptop.org, me@danielpalmer.co.uk, linux-arm-kernel@lists.infradead.org

Hello Daniel,

Sorry to break the thread, I have just suscribed to the linux-mmc mailing
list.

> 
> Hi all,
> 
> Looking for some ideas here.. 
> 
> I don't seem to be able to get a better output of the oops (I have debugging 
> info etc turned on in the config :/). Anyhow, I have 3.1 running with a SAM9G45 
> based board and I'm trying to get 3.3rc5 running. The only differences from 
> mainline are a board file with the devices for the board and some memory stuff 
> because of it's two separate chunks of memory. This all worked fine in 3.1.
> 
> The oops happens here:
> include/linux/scatterlist.h:99
> 
> and the leaf register points to:
> drivers/mmc/host/atmel-mci.c:1802
> 
> The only difference I can really see now is that atmel-mci seems to be using 
> PIO but with 3.1 it was apparently using DMA.
> 
> The complete output from boot is attached below. Please CC me as I'm not on 
> the list.
> 
> Cheers,
> 
> Daniel
> 

This issue is known and I have sent some patches to correct it. The problem
comes from the fact that we set some callbacks too early. If the mmc has the
dma feature, we set the callbacks without checking if we can have a dma
channel.

So typically you are in this case: mmc can use dma but you don't have a DMA
controller.

You can find the two patches into the mmc-next tree of Chris:
http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=43df92914ea0623893bcb801791d5d2be2f5e015
http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=9cfa4030ea90f2fc204532975a824b987433f6dd

By the way, Chris, is it possible to put these patches as a fix for 3.3
kernel? Without them we will have this oops each time someone would use
mmc without a DMA Controller or if it is impossible to get a dma channel.


Regards

Ludovic
