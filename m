From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 0/4] mmc: mmci: Add support for UHS cards
Date: Wed, 15 May 2013 11:40:18 +0200
Message-ID: <1368610823-14113-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:37461 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758803Ab3EOJl4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 May 2013 05:41:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

UHS cards in mode SDR12|25 operates at 1.8V I/O voltage. This patchset
adds support to handle the corresponding voltage switch from the default
2.7-3.6 I/O voltage to 1.8V.

The first patch, "Fixup regulator handling for vqmmc" has recently been
sent as a separate patch, since it is a pure bugfix. Nevertheless this
patchset depends on this patch, thus I decided to fold it here as well.

Host capabilities for SDR12 and SDR25 needs to be set to enable support,
but that will be handled outside this patchset.

Ulf Hansson (4):
  mmc: mmci: Fixup regulator handling for vqmmc
  mmc: mmci: Support signal voltage switch for UHS cards
  mmc: mmci: Cache MMCIDATACTRL register
  mmc: mmci: Add card_busy function to improve UHS card support

 drivers/mmc/host/mmci.c |   94 +++++++++++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/mmci.h |    4 ++
 2 files changed, 90 insertions(+), 8 deletions(-)

-- 
1.7.10

