From: <ludovic.desroches@atmel.com>
Subject: [PATCH] mmc: atmel-mci: fix burst/chunk size modification
Date: Wed, 16 May 2012 16:00:37 +0200
Message-ID: <1337176838-24111-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:57261 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174Ab2EPOBC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 May 2012 10:01:02 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com

This patch requires the following set of patches from slave-dma/next:

1dd1ea8 dmaengine: at_hdmac: take maxburst from slave configuration
b409ebf dmaengine: at_hdmac: remove ATC_DEFAULT_CTRLA constant
b89a9cb dmaengine: at_hdmac: remove some at_dma_slave comments


Regards

Ludovic

