From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Thu, 31 Mar 2011 13:01:11 +0200
Message-ID: <201103311301.12053.arnd@arndb.de>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com> <m3zkoc2ne4.fsf@pullcord.laptop.org> <AANLkTinmVNGpmjLNB31nuBke+LD+jJ8AbwNGp14tH+d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64617 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab1CaLBX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Mar 2011 07:01:23 -0400
In-Reply-To: <AANLkTinmVNGpmjLNB31nuBke+LD+jJ8AbwNGp14tH+d2@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Thursday 31 March 2011, Andrei Warkentin wrote:
> Well, there are less esoteric ways of turning something into a
> paperweight =). No, the whole point of adding the device partition
> support is so you don't have to go through hoops to read and write
> them.

Agreed.

> The scenario where it matters (embedded Linux devices booting through
> boot partitions) are such, that if you went through sufficient hoops
> to get root access, and can build and boot a kernel to enable these
> options for that device, then you must know what you're doing, and a
> warning message in the Kconfig help is sufficient. The generic case of
> people sticking cards into a PCI SDHCI controller under Ubuntu is such
> that you can do no real damage.

One possible way of dealing with this would be to make the boot partition
a character device instead of a block device. That would still allow
you to overwrite it, but make it very obvious that you cannot mount or
partition it.

On the other hand, it would be a rather esoteric interface, since the
hardware is still fundamentally block based, we just use it in a different
way.

	Arnd
