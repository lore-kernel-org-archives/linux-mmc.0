From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 0/2] mmc: mmci: Bugfixes for SDIO
Date: Mon, 24 Oct 2011 15:50:41 +0200
Message-ID: <1319464243-16638-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:46090 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932641Ab1JXNu4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 09:50:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>

This patchserie fixes some SDIO related issues for the mmci host driver.

Previously these patches were included in the patch serie called
"mmc: mmci: Improvements and bugfixes for SDIO", which now has been
split up.

Stefan Nilsson XK (1):
  mmc: mmci: Fix incorrect handling of HW flow control for SDIO

Ulf Hansson (1):
  mmc: mmci: Prepare for SDIO before setting up DMA job

 drivers/mmc/host/mmci.c |   50 ++++++++++++++++++++++++++--------------------
 1 files changed, 28 insertions(+), 22 deletions(-)

-- 
1.7.5.4

