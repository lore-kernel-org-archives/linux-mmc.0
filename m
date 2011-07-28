From: Tony Lin <tony.lin@freescale.com>
Subject: [PATCH v2 0/1] ARM: mxc: fix card interrupt losing issue on freescale eSDHC
Date: Thu, 28 Jul 2011 15:15:59 +0800
Message-ID: <1311837360-16179-1-git-send-email-tony.lin@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:56880
	"EHLO VA3EHSOBE010.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750782Ab1G1HKQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jul 2011 03:10:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org

the patch provides a workaround for eSDHC to avoid missing the card interrupt

changes since V1
* fix some comments typo
* V2 patch is based on Chris Ball's tree, mmc-next branch

Tony Lin (1):
  ARM: mxc: fix card interrupt losing issue on freescale eSDHC

 drivers/mmc/host/sdhci-esdhc-imx.c |   44 +++++++++++++++++++++++++++--------
 1 files changed, 34 insertions(+), 10 deletions(-)


