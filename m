From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [RFC/PATCH v2 0/3] mmc: sdio: add asynchronous interrupt support
Date: Fri, 21 Sep 2012 11:07:44 +0800
Message-ID: <1348196867-15145-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:51639 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932414Ab2IUDMb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Sep 2012 23:12:31 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com


This patchset add asynchronous interrupt support for both sdio device and sdhci host.

changelog v1 -> v2:
        - add mmc_card_set_async_int()/mmc_card_async_int()
        - delete async_int bit in cccr structure

Kevin Liu (3):
mmc: sdio: correct the name of SDIO_CCCR_IF[5] to avoid confusion
mmc: sdio: add asynchronous interrupt support on device
mmc: sdhci: add asynchronous interrupt support

 drivers/mmc/core/sdio.c  |   24 ++++++++++++++++++++----
 drivers/mmc/host/sdhci.c |   15 +++++++++++++++
 drivers/mmc/host/sdhci.h |    2 ++
 include/linux/mmc/card.h |    3 +++
 include/linux/mmc/host.h |    1 +
 include/linux/mmc/sdio.h |    7 +++++--
 6 files changed, 46 insertions(+), 6 deletions(-)
