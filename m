From: Scott Branden <sbranden@broadcom.com>
Subject: [PATCH 0/1] sdhci-bcm2835: added quirk and removed udelay in write ops
Date: Tue, 14 Oct 2014 19:01:51 -0700
Message-ID: <1413338512-14546-1-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:46288 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831AbaJOCB6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Oct 2014 22:01:58 -0400
In-Reply-To: <Scott Branden <sbranden@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Peter Griffin <peter.griffin@linaro.org>
Cc: Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, Scott Branden <sbranden@broadcom.com>

This patch contains driver cleanup of sdhci-bcm2835.
Please note that this has not actually been tested on bcm2835 yet.
Testing comes from other devices with the same sdhci controller.

This patch is being put out for testing and acceptance on the 2835.
Please test and comment.

Scott Branden (1):
  mmc: sdhci-bcm2835: added quirk and removed udelay in write ops

 drivers/mmc/host/sdhci-bcm2835.c |  139 ++++++++++++++++++--------------------
 1 file changed, 66 insertions(+), 73 deletions(-)

-- 
1.7.9.5

