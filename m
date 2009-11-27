From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/03] mmc: A few trivial changes for tmio-mmc
Date: Fri, 27 Nov 2009 13:59:56 +0900
Message-ID: <20091127045956.15251.84958.sendpatchset@rxone.opensource.se>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:64977 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbZK0FFX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Nov 2009 00:05:23 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ian@mnementh.co.uk, lethal@linux-sh.org, philipp.zabel@gmail.com, pierre@ossman.eu, Magnus Damm <magnus.damm@gmail.com>, akpm@linux-foundation.org

mmc: A few trivial changes for tmio-mmc 

[PATCH 01/03] mmc: Let tmio-mmc use dev_name() with request_irq()
[PATCH 02/03] mmc: Remove const from tmio-mmc platform data V2
[PATCH 03/03] mmc: Balance tmio-mmc cell enable()/disable() calls

These patches contain a few trivial changes for the tmio-mmc driver.
Nothing out of the ordinary. Tested together with the sh_mobile_sdhi
mfd driver on a sh7724 Ecovec board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/mmc/host/tmio_mmc.c |   12 +++++++++---
 include/linux/mfd/tmio.h    |    2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)
