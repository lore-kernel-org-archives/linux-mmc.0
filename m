From: Peter Turczak <peter@turczak.de>
Subject: Re: [RFC/PATCH V2]: mmc: card/core: support password locked cards
Date: Mon, 3 Jun 2013 15:42:36 +0200
Message-ID: <3BE74EF9-464E-4585-A471-F29B9F7D7E59@turczak.de>
References: <3B0B2667-A242-4337-96EC-3925AB4EC18F@turczak.de> <201305271728.37770.arnd@arndb.de>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from netconsequence.de ([85.214.40.104]:54037 "EHLO
	mx.netconsequence.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306Ab3FCNmi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jun 2013 09:42:38 -0400
In-Reply-To: <201305271728.37770.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Peter Turczak <peter@turczak.de>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

Thanks Arnd for the input.

I've prepared a RFC-Version of the patch.

I'm not quite happy calling mmc_sd_resume() from the rescan ioctl. Unfortunately the rescan needed it twofold:
1. Force the SD layer to reread scr, ssr, etc. by somehow reaching mmc_sd_setup_card()
2. Remove GENHD_FL_NO_PART_SCAN from the disks flags and trigger a ioctl BLKRRPART on the block device. Which I would prefer to happen within the kernel.

Either one should introduce a flag in the mmc_card struct that forces a rescan of the sd card or even remove it completely and probe it again. Or there should be a command like mmc_card_reinit() which restarts mmc_sd_setup_card() along the way.
What is your opinion?

Regards,
  Peter