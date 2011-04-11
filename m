From: Chris Ball <cjb@laptop.org>
Subject: Re: [patchv3 4/4] MMC: MMC boot partitions support.
Date: Mon, 11 Apr 2011 19:20:31 -0400
Message-ID: <m34o648jeo.fsf@pullcord.laptop.org>
References: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
	<1302556424-21951-4-git-send-email-andreiw@motorola.com>
	<m3oc4c8n3b.fsf@pullcord.laptop.org>
	<BANLkTimAFUnodvc2yBs-Bj=DnSpmZN7BwA@mail.gmail.com>
	<m3ei588m3t.fsf@pullcord.laptop.org>
	<BANLkTinHodYLMMA0=JJ1z_kX8jQm1P=akA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40891 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849Ab1DKXPh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Apr 2011 19:15:37 -0400
In-Reply-To: <BANLkTinHodYLMMA0=JJ1z_kX8jQm1P=akA@mail.gmail.com> (Andrei
	Warkentin's message of "Mon, 11 Apr 2011 17:18:49 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, arnd@arndb.de

Hi Andrei,

On Mon, Apr 11 2011, Andrei Warkentin wrote:
> Ok, great! Will do.

Great, thanks.  I've just merged:

mmc: quirks: Extends card quirks with MMC/SD quirks matching the CID.
[patchv3 1/4] MMC: Rename erase_timeout to cmd_timeout_ms.
[patchv3 2/4] MMC: SDHCI R1B command handling + MMC_CAP_ERASE.
[patchv3 3/4] MMC: Allow setting CMD timeout for CMD6 (SWITCH).
[patchv4 1/2] MMC: block.c cleanup for host claim/release.
[patchv4 2/2] MMC: MMC boot partitions support.
[PATCH 1/2] MMC: Support for block quirks.
 ^ this had a merge conflict with the partitions patch, easily resolved.
[PATCH 2/2] MMC: Fix erase/trim for certain SanDisk cards.

in that order, and will push out to mmc-next for .40 after a little
testing.  Let me know if anything's been missed or applied in the wrong
order there.

Thanks very much,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
