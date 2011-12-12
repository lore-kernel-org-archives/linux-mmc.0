From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 0/5] mmc: mmci: Improvements and bugfixes for SDIO
Date: Mon, 12 Dec 2011 16:36:02 +0100
Message-ID: <1323704167-10247-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:44278 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751026Ab1LLPgd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Dec 2011 10:36:33 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>

This patchserie is based upon the below stated patchserie:
mmc: mmci: Improved PM support, cleanup and bugfixes

These patches are all related to the SDIO support. Some patches will
anyway effect the code execution path for non-SDIO and more important
also the "hotpath" for all PIO read transfers. The intent is to try
to affect as little as possible.

Per Forlin (1):
  mmc: mmci: Add constraints on alignment for SDIO

Stefan Nilsson XK (1):
  mmc: mmci: Fix PIO read for small SDIO packets

Ulf Hansson (3):
  mmc: mmci: Prepare for SDIO before setting up DMA job
  mmc: mmci: Fix incorrect handling of HW flow control for SDIO
  mmc: mmci: Support any block sizes for ux500v2 variant

 drivers/mmc/host/mmci.c |  120 +++++++++++++++++++++++++++++++++++-----------
 drivers/mmc/host/mmci.h |    7 +++
 2 files changed, 98 insertions(+), 29 deletions(-)

-- 
1.7.5.4

