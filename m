From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH V2 0/3] Clearify code paths for how to modify the power register
Date: Mon, 24 Oct 2011 15:28:45 +0200
Message-ID: <1319462928-14892-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:58391 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932563Ab1JXN3e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 09:29:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>

In the set_ios function there has been a mess of how the power register
can be modified. One part, especially strange was related to the use of 
the vdd_handler.

V2 changes:
	-Rebased to remove dependency to other patch serie for mmci called
	"mmc: mmci: Improvements and bugfixes for SDIO".
	-Fixed minor review comments.

Sebastian Rasmussen (1):
  mmc: mmci: Put power register deviations in variant data

Ulf Hansson (2):
  mmc: mmci: Provide option to configure bus signal direction
  mmc: mmci: Change vdd_handler to a generic ios_handler

 arch/arm/mach-ux500/board-mop500-sdi.c |   21 +++++--------
 drivers/mmc/host/mmci.c                |   49 ++++++++++++++++++++++++++-----
 drivers/mmc/host/mmci.h                |   10 ------
 include/linux/amba/mmci.h              |   22 ++++++++++++--
 4 files changed, 68 insertions(+), 34 deletions(-)

-- 
1.7.5.4

