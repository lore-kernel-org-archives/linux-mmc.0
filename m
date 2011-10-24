From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 0/2] mmc: mmci: Improvements for SDIO
Date: Mon, 24 Oct 2011 16:33:18 +0200
Message-ID: <1319466800-19884-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:50746 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932589Ab1JXO4K (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 10:56:10 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>

For the ux500v2 variant of the PL18x block, non power of two block
sizes are now supported.

In addition constraints on buffer alignments is needed since access to the
PL18x FIFO must be done on a 4-byte aligned manner. Moreover to be able to
use DMA for buffers with not 32 bytes aligned sg element lengths, DMAREQCTL
must enabled.

Per Forlin (1):
  mmc: mmci: add constraints on alignment for SDIO

Stefan Nilsson XK (1):
  mmc: mmci: Support non-power-of-two block sizes for ux500v2 variant

 drivers/mmc/host/mmci.c |   56 +++++++++++++++++++++++++++++++++++++++++------
 drivers/mmc/host/mmci.h |    7 ++++++
 2 files changed, 56 insertions(+), 7 deletions(-)

-- 
1.7.5.4

