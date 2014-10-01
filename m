From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH 0/5] mmc: Miscellaneous fixes for SDHCI and MMC core
Date: Wed, 1 Oct 2014 07:14:06 -0500
Message-ID: <1412165651-2652-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:62088 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbaJAMO6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Oct 2014 08:14:58 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-03.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1XZIo5-0001fk-1U from Andrew_Gabbasov@mentor.com
	for linux-mmc@vger.kernel.org; Wed, 01 Oct 2014 05:14:57 -0700
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Andrew Gabbasov (5):
  mmc: sdhci: Balance vmmc regulator_disable()
  mmc: sdhci: fix error conditions for controller reset
  mmc: core: Initialize SET_BLOCK_COUNT request fields
  mmc: core: Add debug message for SET_BLOCK_COUNT result
  mmc: core: Fix error paths and messages in mmc_init_card

 drivers/mmc/core/core.c  | 12 ++++++++++++
 drivers/mmc/core/mmc.c   | 16 ++++++++--------
 drivers/mmc/host/sdhci.c | 10 ++++------
 3 files changed, 24 insertions(+), 14 deletions(-)

-- 
2.1.0

