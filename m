From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 0/4] mmc: core and queue cleanups
Date: Fri, 13 Apr 2012 17:54:10 +0530
Message-ID: <1334319854-5989-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44981 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816Ab2DMMYi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 13 Apr 2012 08:24:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Venkatraman S <svenkatr@ti.com>

	The first 3 are straight forward / trivial fixes.
The last one is a functional change on how HPI should be invoked
on the card. This is required for my future foreground HPI series
that'll follow.

Also available at git://github.com/svenkatr/linux.git my/mmc/cleanups-v2

Venkatraman S (4):
  mmc: queue: rename mmc_request function
  mmc: include cd-gpio.h in the source file
  mmc: queue: remove redundant memsets
  mmc: core: Send HPI only till it is successful

 drivers/mmc/card/queue.c   |    6 ++----
 drivers/mmc/core/cd-gpio.c |    1 +
 drivers/mmc/core/core.c    |   34 ++++++++++++++++++----------------
 3 files changed, 21 insertions(+), 20 deletions(-)

-- 
1.7.10.rc2

