From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC/PATCH]: mmc: card/core: support password locked cards
Date: Mon, 27 May 2013 17:28:37 +0200
Message-ID: <201305271728.37770.arnd@arndb.de>
References: <3B0B2667-A242-4337-96EC-3925AB4EC18F@turczak.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58185 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929Ab3E0P2u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 May 2013 11:28:50 -0400
In-Reply-To: <3B0B2667-A242-4337-96EC-3925AB4EC18F@turczak.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Turczak <peter@turczak.de>
Cc: Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org

On Monday 27 May 2013, Peter Turczak wrote:
> 
> Therefore I propose to add a basic support for locked cards in the 
> kernel. The user space applications might take care of unlocking the
> card afterwards. When a card has been unlocked it stays unlocked
> until cycling it, reset commands won't lock it again.

Seems reasonable to me.
 
> My questions are:
> 1. Should a card that is locked be visible via /dev/mmcblkX? 
>  I think it should be, in order to be able to issue an unlock command

Agreed

> 2. What should read/write operations return on a locked card EPERM, EACCESS
> or something else?

I would have said EIO, but I don't have a strong opinion.

> 3. Should locking/unlocking be done via a special ioctl command, as the
> card needs to be rescanned anyways? 

I'd say we should use the generic ioctl unless it doesn't work. I would
not object an unlock ioctl either if other people think that's a good
idea.

> 4. How to cleanly initiate a rescan from userspace if answer to 3 is no? 
> Currently I issue a reset command to the card which forces to kernel to 
> fail issuing CMD13 and therefore reinitialize it, not too nice honestly.

Adding a rescan ioctl would have other possible applications, so that
seems better than a special unlock ioctl.

	Arnd
