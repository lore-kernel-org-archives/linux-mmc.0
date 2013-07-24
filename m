From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [RFC 0/2] Set mmc(blk)X with DT alias
Date: Wed, 24 Jul 2013 11:09:31 +0200
Message-ID: <1374656973-16250-1-git-send-email-s.trumtrar@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56692 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab3GXJJw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Jul 2013 05:09:52 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, devicetree@vger.kernel.org, kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>

Hi!

Embedded devices often use multiple SD/MMC devices as boot/rootfs disks.
Some of them are removable, some not. If the removable cards are not
present, but are probed before the non-removable ones, the indexing
scheme changes. This makes it harder to hard-code the rootfs in the
cmdline.

First solution I came up with was the alias-node in DT.
I guess my implementation is pretty hacky and ugly, but you can get lost
pretty fast in the whole mmc stack.
For example, the second patch should use "card->host->index" instead of parsing
the alias again, I guess. I'm not sure why it currently doesn't though.

So, if there is a better place or solution to specify a reliable ordering
of mmc devices, please let me hear it.

Thanks,
Steffen


Steffen Trumtrar (2):
  mmc: block: allow setting name_idx via devicetree
  mmc: host: allow setting index via devicetree

 drivers/mmc/card/block.c | 7 ++++++-
 drivers/mmc/core/host.c  | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
1.8.3.2

