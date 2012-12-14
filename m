From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 0/2] mmc: mmci: Update regulator support
Date: Fri, 14 Dec 2012 15:30:27 +0100
Message-ID: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:55002 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753579Ab2LNObJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 09:31:09 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

In this patchset the mmci driver is converted to use the new
mmc_regulator_get_supply API for handling regulators and OCR
mask.

On top of that we are taking the first step of moving away
from using the platform callback, ios_handler, to be more
DT compliant.

Lee Jones (1):
  mmc: mmci: Move ios_handler functionality into the driver

Ulf Hansson (1):
  mmc: mmci: Convert to use mmc_regulator_get_supply

 drivers/mmc/host/mmci.c |   63 +++++++++++++++--------------------------------
 drivers/mmc/host/mmci.h |    1 -
 2 files changed, 20 insertions(+), 44 deletions(-)

-- 
1.7.10

