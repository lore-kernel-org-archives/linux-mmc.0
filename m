From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: [PATCH v1 0/3] SDIO fixes
Date: Tue,  4 Dec 2012 17:06:17 +0530
Message-ID: <1354620980-23764-1-git-send-email-subhashj@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:52436 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab2LDLgc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Dec 2012 06:36:32 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Subhash Jadavani <subhashj@codeaurora.org>

This patch-series is having 1 fix for SDIO resume and 2 fixes related
to SDIO3.0 card detection

Subhash Jadavani (2):
  mmc: sdio: fix resume failure
  mmc: sdio: print correct UHS mode during card detection

Sujit Reddy Thumma (1):
  mmc: sdio: Fix SDIO 3.0 UHS-I initialization sequence

 drivers/mmc/core/sdio.c  |   33 ++++++++++++++++++++-------------
 include/linux/mmc/host.h |    8 ++++++++
 2 files changed, 28 insertions(+), 13 deletions(-)

-- 
--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

