From: Daniel Palmer <me@danielpalmer.co.uk>
Subject: Re: atmel-mci causing oops?
Date: Mon, 27 Feb 2012 11:20:27 +0900
Message-ID: <201202271120.27763.me@danielpalmer.co.uk>
References: <201202270949.23934.me@danielpalmer.co.uk> <4F4AE100.6030604@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tomato.cardboardbox.org.uk ([174.143.157.65]:52429 "EHLO
	tomato.cardboardbox.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753639Ab2B0CUg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 Feb 2012 21:20:36 -0500
In-Reply-To: <4F4AE100.6030604@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org

On Monday, February 27, 2012 10:48:48 AM Jaehoon Chung wrote:

> > [    1.700000] atmel_mci atmel_mci.1: version: 0x410
> > [    1.710000] atmel_mci atmel_mci.1: using DMA
> > [    1.710000] atmel_mci atmel_mci.1: DMA not available, using PIO
> > [    1.730000] atmel_mci atmel_mci.1: Atmel MCI controller at 0xfffd0000
> > irq 29, 1 slots
> > [    1.740000] Waiting 1sec before mounting root device...
> 
> Root device(eMMC) didn't initialize?
> i think good that use the "rootwait" at bootloader
> 

>From what I can tell, the kernel tries to mount root (which is an SD card 
connected to one of the atmel_mci's) and when it goes to do a PIO read it 
(according to the address in the leaf register) causes an oops. The bootloader 
loads the kernel from the same SD card, so I don't think there is a hardware 
issue.

Cheers,

Daniel
