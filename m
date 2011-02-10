From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/11] MMC DMA-API/dmaengine fixups
Date: Thu, 10 Feb 2011 16:06:12 +0100
Message-ID: <1297350372-725-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:53476 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756413Ab1BJPtL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 10:49:11 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>

This patch series fixes a number of DMA-API and dmaengine issues
that we encountered while working with the recent changes to the
MMCI/PL180 driver. It'd be bad to leave bad examples around like
this.

It's hard for me to regression-compile this let alone test these
so ACK:s from maintainers would be welcome.

 drivers/mmc/host/atmel-mci.c |   19 ++++++++-------
 drivers/mmc/host/sh_mmcif.c  |   52 ++++++++++++++++++-----------------------
 drivers/mmc/host/tmio_mmc.c  |   36 +++++++++-------------------
 3 files changed, 45 insertions(+), 62 deletions(-)

Linus Walleij <linus.walleij@linaro.org>
