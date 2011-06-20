From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 0/3] Improve MMC error handling (3rd rev)
Date: Mon, 20 Jun 2011 20:09:45 +0100
Message-ID: <20110620190945.GK26089@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59156 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755595Ab1FTTKF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 15:10:05 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

This is the third revision of my improvements to the MMC block
device error handling, which makes error handling more robust
and permits MMC/SD to continue working in the presence of
not-quite-perfect setups.

Without this, my Versatile Express tends to fail to mount its rootfs
on SD.  With this, it can successfully read and write data from the
card in the presence of FIFO overruns and underruns, and also sensibly
recover from command channel errors.

There is more to come, but this is the "safer" bits of the improvements.

 drivers/mmc/card/block.c |  279 ++++++++++++++++++++++++++++++++++-----------
 include/linux/mmc/mmc.h  |   10 ++
 2 files changed, 221 insertions(+), 68 deletions(-)

