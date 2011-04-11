From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: Extends card quicks with MMC/SD quirks matching the CID.
Date: Mon, 11 Apr 2011 17:50:27 -0400
Message-ID: <m3sjto8nks.fsf@pullcord.laptop.org>
References: <m339lobj8j.fsf@pullcord.laptop.org>
	<1302559335-9998-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36332 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756165Ab1DKVpe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Apr 2011 17:45:34 -0400
In-Reply-To: <1302559335-9998-1-git-send-email-andreiw@motorola.com> (Andrei
	Warkentin's message of "Mon, 11 Apr 2011 17:02:15 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>

Hi,

On Mon, Apr 11 2011, Andrei Warkentin wrote:
> From: Chris Ball <cjb@laptop.org>
>
> The current mechanism is SDIO-only. This allows us to create
> function-specific quirks, without creating messy Kconfig dependencies,
> or polluting core/ with function-specific code.
>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>

Thanks, pushed to mmc-next for .40 with Arnd's ACK.  (And with you as
patch author, not me.)

I made a mistake in not noticing that your later RFC patchset includes
(the same version of) this patch -- are you happy with adding block
quirks on top of this later, and merging this patch for now?

(Ohad, heads-up that I've rebased your wl1271 SDIO quirks onto this
patchset; there should be no behavior change, but just in case.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
