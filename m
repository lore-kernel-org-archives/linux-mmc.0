From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v3 0/4] mmc: atmel-mci: cleanup and probe deferring
Date: Fri, 28 Nov 2014 15:08:02 +0100
Message-ID: <1417183686-31481-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:48079 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbaK1OII (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Nov 2014 09:08:08 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, nicolas.ferre@atmel.com, arnd@arndb.de, Ludovic Desroches <ludovic.desroches@atmel.com>

Hi Ulf,

I have rebased my series on your next branch but I didn't have any conflict and
a warning on the whole series with checkpatch so please tell me if something
goes wrong.

Regards

Ludovic

Ludovic Desroches (4):
  mmc: atmel-mci: remove useless DMA stuff for non-dt devices
  mmc: atmel-mci: remove __init/__exit attributes
  mmc: atmel-mci: stop using specific initcall
  mmc: atmel-mci: use probe deferring if dma controller is not ready yet

 drivers/mmc/host/atmel-mci.c | 76 +++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 47 deletions(-)

-- 
2.0.3

