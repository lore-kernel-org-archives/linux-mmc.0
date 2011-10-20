From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: A question on IOCTL interface for MMC
Date: Thu, 20 Oct 2011 09:18:14 +0200
Message-ID: <5263525.D4yqBTjgWh@wuerfel>
References: <CANYdXnqDYn5-zehsJ9ibviJ7FoofcY=YLUqrROoK8k53v-czNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:59293 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab1JUQwy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2011 12:52:54 -0400
In-Reply-To: <CANYdXnqDYn5-zehsJ9ibviJ7FoofcY=YLUqrROoK8k53v-czNA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Chris Ball <cjb@laptop.org>, J Freyensee <james_p_freyensee@linux.intel.com>, John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org

On Thursday 20 October 2011 10:39:00 Shashidhar Hiremath wrote:
>   I am planning to use the existing IOCTL interface for SD/MMC present
> in the kernel.
>   Since, the IOCTL interface expects a read/write flag , and the MMC
> IOCTL is actually an interface to block layer I feel without modifying
> the block layer for the support of non-read write commands ,I may not
> be able to test the non-read/write commands through the IOCTL
> interface .
> Is there a way of doing this without modifying block layer ?

Hi Shashidhar,

I think there is actually no problem here at all. The block layer simply
passes the ioctl command number and argument to the driver, which can
do anything with it.

What functionality are you actually looking for?

	Arnd
