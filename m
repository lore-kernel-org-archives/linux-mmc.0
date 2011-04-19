From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patchv3 2/5] MMC: Use CMD23 for multiblock transfers when we can.
Date: Tue, 19 Apr 2011 09:39:19 +0200
Message-ID: <201104190939.19905.arnd@arndb.de>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com> <201104171923.31039.arnd@arndb.de> <BANLkTimErvCyAOVW=DgHvRqDZg9EF9QKeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55885 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab1DSHjW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2011 03:39:22 -0400
In-Reply-To: <BANLkTimErvCyAOVW=DgHvRqDZg9EF9QKeg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com, cjb@laptop.org

On Tuesday 19 April 2011, Andrei Warkentin wrote:

> So maybe this should be a blacklist for known bad cards. And the
> entire support should be a "default-N" compile option for MMCs (not
> SDs). That way someone who just does an "make oldconfig" will see
> "CONFIG_MMC_BLK_CMD23 - I/O performance improvement for newer eMMC
> cards, may cause degradation on older cards". What do you think?

I'm not sure if I understand the distinction between MMC and SD
here. Do you suggest we always enable it for SD but make it compile-time
selected for MMC?

I generally argue against compile time options. A distribution
integrator needs to choose a reasonable default, and giving them
an option makes it possible to get it wrong.

I believe the best way would be trying to warn people against
regressions while going forward with this enabled unconditionally,
unless we hear back from people that actually got regressions.

We could perhaps key enabling the feature by the production date
on the card, so it only gets turned on for new cards.

	Arnd
