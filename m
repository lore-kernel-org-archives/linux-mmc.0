From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: mach-moxart: platform port for MOXA ART SoC
Date: Mon, 18 Mar 2013 15:03:49 +0000
Message-ID: <201303181503.49491.arnd@arndb.de>
References: <CACmBeS1NLFUYHBOVL28aCCzRrgXYGPZF9t3qj6AdcgaMkrPGoQ@mail.gmail.com> <201303151125.53999.arnd@arndb.de> <CACmBeS3aXs9vhc5ZYPbz5bjsYsSa6EzM12H4uPv706x0zU_5iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51906 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab3CRPD7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Mar 2013 11:03:59 -0400
In-Reply-To: <CACmBeS3aXs9vhc5ZYPbz5bjsYsSa6EzM12H4uPv706x0zU_5iw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jonas Jensen <jonas.jensen@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Daniel Mack <zonque@gmail.com>, linux@arm.linux.org.uk, linux-mmc@vger.kernel.org, jirislaby@gmail.com, linux-kernel@vger.kernel.org

On Sunday 17 March 2013, Jonas Jensen wrote:
> Thank you for the feedback.
> 
> Some of the changes are sure to be a challenge for me, but I want to
> move this forward, and having a list helps.
> 
> 3.2.40 is as far as it'll go right now, nothing prints to UART
> starting with 3.3.8 (last tested, it's somewhere around there).
> 
> I have been advised to enable early_printk (by landley on freenode IRC #edev).

Yes, that is a good idea. I would also suggest that you don't try to port
all the code at once a few kernel versions at a time, but that you instead
move straight to the latest kernel, and basically start a new port one driver
at a time. Take one of the newer ports (highbank, virt, bcm, ...) as examples.

Since most of the code is now in drivers/ directories rather than arch/arm,
you can actually start getting stuff upstream before you have completed all
of it. If you have questions, I recommend asking on the #armlinux channel
on freenode, or here on the mailing list.

	Arnd
