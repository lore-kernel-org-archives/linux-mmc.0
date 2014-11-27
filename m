From: Angelo Dureghello <angelo@sysam.it>
Subject: Re: [PATCH] mmc: davinci_mmc: add warnings for edma failures
Date: Thu, 27 Nov 2014 11:18:48 +0100
Message-ID: <5476FA88.6070105@sysam.it>
References: <546FD21C.7010208@sysam.it> <CAPDyKFrBgv9OTzwNfiOSn58Ai7QTbrZm4pKgLrzrM1MgD4=zAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sysam.it ([5.39.81.93]:38057 "EHLO mail.sysam.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753346AbaK0KTe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Nov 2014 05:19:34 -0500
In-Reply-To: <CAPDyKFrBgv9OTzwNfiOSn58Ai7QTbrZm4pKgLrzrM1MgD4=zAA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Hi Uffe,

many hanks for the reply,

 >> Add warnings in case the edma engine driver fails to allocate slots or
 >> channels requested from the davinci_mmc driver.
 >>
 >> Some ti-davinci based boards (i.e. board-da850-evm.c) are asking for
 >> some reserved chans / slots at board init stage. Later, the mmc driver
 >> results in a silent locked state.
 >
 > So why does davinci_acquire_dma_channels() succeed then? Isn't that
 > real problem you should be looking into?

i explain with more details,

my custom am1808 board initialization, based on 
arch/arm/mach-davinci/board-da850-evm.c, reserves some dma chans / slots 
for the audio at
early boot.

While on kernel 3.5.1 mmc was working properly, moving to kernel
3.17.0, due to the dma-engine wrapper introduction (to be selected
into menuconfig), the mmc host driver locks silently. System cannot
even "reboot" after the failed attempt to reserve the dma slots.

I hardly found out the reason due to missing of clear warnings.

So there is nothing to fix in any other place. Simply, i am suggesting
a more visible warning so the driver, instead of lock-up silently,
throws a problem.

Feel free to add or discard the patch, as you can see it is nothing 
functional.

Regards,
Angelo



