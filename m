From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH mmc 0/4] Cleanup fixes for tmio_mmc
Date: Mon, 27 Apr 2015 00:00:20 +0100
Message-ID: <1430089220.5802.17.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:34112 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbbDZXA0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Apr 2015 19:00:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk

Ian, these are some of your fixes for tmio_mmc that didn't make it
upstream yet, plus an update to MAINTAINERS.  Assuming you're still
intending to maintain it, please can you ack these?

Ben.

Ben Hutchings (1):
  MAINTAINERS: Update Ian Molton's address for tmio_mmc driver

Ian Molton (3):
  mmc: TMIO: Ensure MFD cell is disabled on probe error path
  mmc: TMIO: Fix I/O mapping leak on error using devm_ioremap()
  mmc: TMIO: Use devm_request_irq()

 MAINTAINERS                     |    2 +-
 drivers/mmc/host/tmio_mmc.c     |   10 ++++++----
 drivers/mmc/host/tmio_mmc_pio.c |    5 ++---
 3 files changed, 9 insertions(+), 8 deletions(-)

-- 
1.7.10.4



