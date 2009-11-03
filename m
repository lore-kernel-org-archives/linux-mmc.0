From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 00/11] Sort out sdio_uart - stage two
Date: Tue, 03 Nov 2009 14:17:08 +0000
Message-ID: <20091103141525.31032.45206.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55390 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750741AbZKCOad (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Nov 2009 09:30:33 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nico@cam.org

With the bugs Nicolas reported hopefully now nailed.
---

Alan Cox (10):
      sdio_uart: add modem functionality
      sdio_uart: Fix the locking on "func" for new code
      sdio_uart: Style fixes
      sdio_uart: Use kfifo instead of the messy circ stuff
      sdio_uart: Fix termios handling
      sdio_uart: Switch to the open/close helpers
      sdio_uart: Move the open lock
      sdio_uart: refcount the tty objects
      sdio_uart: use tty_port
      tty_port: Move hupcl handling

Nicolas Pitre (1):
      sdio_uart: Fix oops caused by the previous changeset


 drivers/char/tty_port.c      |   13 +
 drivers/mmc/card/sdio_uart.c |  392 ++++++++++++++++++++++++------------------
 2 files changed, 233 insertions(+), 172 deletions(-)

-- 
"The IETF already has more than enough RFCs that codify the obvious, make
stupidity illegal, support truth, justice, and the IETF way, and generally
demonstrate the author is a brilliant and valuable Contributor to The
Standards Process." -- Vernon Schryver

