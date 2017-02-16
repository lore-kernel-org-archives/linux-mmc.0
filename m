From: =?UTF-8?q?Micha=C5=82=20Zegan?= <webczat@webczatnet.pl>
Subject: [PATCH 0/2] mmc: meson-gx: fix module unloading
Date: Thu, 16 Feb 2017 15:52:20 +0100
Message-ID: <20170216145222.1577-1-webczat@webczatnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from webczatnet.pl ([91.121.100.5]:59910 "EHLO webczatnet.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755128AbdBPOwt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Feb 2017 09:52:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Micha=C5=82=20Zegan?= <webczat@webczatnet.pl>

This patch contains fixes for the meson-gx-mmc driver, that allow the module to be unloaded correctly.
Before trying to unload the module caused kernel warnings.

Michał Zegan (2):
  mmc: meson-gx: prevent cfg_div_clk from being disabled on init
  mmc: meson-gx: remove mmc host on device removal

 drivers/mmc/host/meson-gx-mmc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.11.0

