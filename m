From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v4 0/4] mmc: atmel-mci: cleanup and probe deferring
Date: Mon, 1 Dec 2014 15:35:05 +0100
Message-ID: <1417444509-15501-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:51925 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776AbaLAOfM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Dec 2014 09:35:12 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, nicolas.ferre@atmel.com, arnd@arndb.de, Ludovic Desroches <ludovic.desroches@atmel.com>

Hi Ulf,

Same as previous series, based on your next branch, and no errors with
checkpatch so let me know if you still have troubles to apply my patches.

Changes from v3:
- keep __init/__exit attributes for atmci_init/exit
- remove useless variable in atmci_configure_dma function

Ludovic Desroches (4):
  mmc: atmel-mci: remove useless DMA stuff for non-dt devices
  mmc: atmel-mci: remove __init/__exit attributes
  mmc: atmel-mci: stop using specific initcall
  mmc: atmel-mci: use probe deferring if dma controller is not ready yet

 drivers/mmc/host/atmel-mci.c | 76 ++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 48 deletions(-)

-- 
2.0.3

