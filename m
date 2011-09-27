From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 0/4] mmc: mmci: Improvements and bugfixes for SDIO
Date: Tue, 27 Sep 2011 09:45:17 +0200
Message-ID: <1317109517-17869-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:51657 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751480Ab1I0HqF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2011 03:46:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>

This patchserie fixes a couple of SDIO related issues for the mmci host
driver. The intention is to keep each patch small and to have one patch
for one problem. It might makes sence to squash some of the patches, but
I leave this for discussion.

Stefan Nilsson XK (3):
  mmc: mmci: Bugfix in pio read for small packets
  mmc: mmci: Support non-power-of-two block sizes for ux500v2 variant
  mmc: mmci: Fix incorrect handling of HW flow control for SDIO

Ulf Hansson (1):
  mmc: mmci: Prepare for SDIO before setting up DMA job

 drivers/mmc/host/mmci.c |   78 ++++++++++++++++++++++++++++++++---------------
 1 files changed, 53 insertions(+), 25 deletions(-)

-- 
1.7.5.4
