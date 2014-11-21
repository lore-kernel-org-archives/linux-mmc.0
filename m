From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v2 0/4] mmc: atmel-mci: cleanup and probe deferring
Date: Fri, 21 Nov 2014 16:33:34 +0100
Message-ID: <1416584018-8561-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:48858 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376AbaKUPdk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Nov 2014 10:33:40 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, chris@printf.net, nicolas.ferre@atmel.com, arnd@arndb.de, Ludovic Desroches <ludovic.desroches@atmel.com>

Hi,

Some cleanup to introduce probe deferring if dma controller is not probed.

The purpose of this second version is to have the __init/__exit attributes
removal in a patch that can be backported into stable kernels.

Ludovic Desroches (4):
  mmc: atmel-mci: remove useless DMA stuff for non-dt devices
  mmc: atmel-mci: remove __init/__exit attributes
  mmc: atmel-mci: stop using specific initcall
  mmc: atmel-mci: use probe deferring if dma controller is not ready yet

 drivers/mmc/host/atmel-mci.c | 75 ++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 45 deletions(-)

-- 
2.0.3

