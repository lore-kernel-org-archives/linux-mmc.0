From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: atmel-mci causing oops?
Date: Mon, 27 Feb 2012 11:47:10 +0900
Message-ID: <4F4AEEAE.10404@samsung.com>
References: <201202270949.23934.me@danielpalmer.co.uk>
 <4F4AE100.6030604@samsung.com> <201202271120.27763.me@danielpalmer.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:58651 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab2B0CrM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Feb 2012 21:47:12 -0500
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0M01002C06E2NTF0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 27 Feb 2012 11:47:10 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0M0100H526EMV230@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 27 Feb 2012 11:47:10 +0900 (KST)
In-reply-to: <201202271120.27763.me@danielpalmer.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Palmer <me@danielpalmer.co.uk>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org

On 02/27/2012 11:20 AM, Daniel Palmer wrote:

> On Monday, February 27, 2012 10:48:48 AM Jaehoon Chung wrote:
> 
>>> [    1.700000] atmel_mci atmel_mci.1: version: 0x410
>>> [    1.710000] atmel_mci atmel_mci.1: using DMA
>>> [    1.710000] atmel_mci atmel_mci.1: DMA not available, using PIO
>>> [    1.730000] atmel_mci atmel_mci.1: Atmel MCI controller at 0xfffd0000
>>> irq 29, 1 slots
>>> [    1.740000] Waiting 1sec before mounting root device...
>>
>> Root device(eMMC) didn't initialize?
>> i think good that use the "rootwait" at bootloader
>>
> 
>>From what I can tell, the kernel tries to mount root (which is an SD card 
> connected to one of the atmel_mci's) and when it goes to do a PIO read it 
> (according to the address in the leaf register) causes an oops. The bootloader 
> loads the kernel from the same SD card, so I don't think there is a hardware 
> issue.

Hi Daniel.

"Wating 1sec before mounting root device".
That message can see when root device didn't initialize.
Because root device can't find, waiting 1sec for root device.
(Maybe your bootloader should be set to "rootdelay=1")

after just 1ms, try to mount root device. 
But root device didn't find, then should be occurred the NULL pointer dereference.

This should be one of problem.

Best Regards,
Jaehoon Chung

> 
> Cheers,
> 
> Daniel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


