From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [patch 5/8] mmc: fix hang if card was removed during suspend
 and unsafe resume was enabled
Date: Thu, 11 Feb 2010 18:39:43 +0200
Message-ID: <1265906383.9788.2.camel@maxim-laptop>
References: <201002102156.o1ALudbX001270@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:39331 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756127Ab0BKQjx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Feb 2010 11:39:53 -0500
Received: by fxm7 with SMTP id 7so1420536fxm.28
        for <linux-mmc@vger.kernel.org>; Thu, 11 Feb 2010 08:39:51 -0800 (PST)
In-Reply-To: <201002102156.o1ALudbX001270@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, dwmw2@infradead.org, ext-jorg.2.schummer@nokia.com, linux-mmc@vger.kernel.org, nico@fluxnic.net, rjw@sisk.pl, stable@kernel.org

On Wed, 2010-02-10 at 13:56 -0800, akpm@linux-foundation.org wrote: 
> From: Maxim Levitsky <maximlevitsky@gmail.com>
> 
> Presently the following operations lead to a hang:
> 
> -> Have a kernel with CONFIG_MMC_UNSAFE_RESUME
> -> Insert MMC/SD card
> -> Suspend/hibernate the system
> -> While system is hibernated/suspended pull the card off
> -> Resume the system
> -> Hang

I would like to withdraw this patch.
Although it fixes the case of CONFIG_MMC_UNSAFE_RESUME=y
it doesn't fix the case of CONFIG_MMC_UNSAFE_RESUME=n

It is more like a workaround for real problem, problem that del_gendisk
hangs when it is called while userspace is frozen.
I bet that this is a regression.

Best regards,
Maxim Levitsky

