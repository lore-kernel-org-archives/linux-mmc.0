From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v4 0/10] mmc: meson-gx: series with smaller improvements
Date: Fri, 3 Mar 2017 20:49:33 +0100
Message-ID: <62912f3d-2307-cfff-3c69-c8b8ffaeb474@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33815 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbdCCTuJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Mar 2017 14:50:09 -0500
Received: by mail-wm0-f65.google.com with SMTP id m70so4666106wma.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 Mar 2017 11:50:08 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

New series is limited to smaller refactorings w/o functional changes.

Heiner Kallweit (10):
  mmc: meson-gx: simplify bounce buffer setting in meson_mmc_start_cmd
  mmc: meson-gx: make two functions return void
  mmc: meson-gx: remove unused members irq, ocr_mask from struct meson_host
  mmc: meson-gx: remove unneeded variable in meson_mmc_clk_init
  mmc: meson-gx: remove member parent_mux from struct meson_host
  mmc: meson-gx: remove unneeded meson_mmc_clk_set in meson_mmc_clk_init
  mmc: meson-gx: remove unneeded devm_kstrdup in meson_mmc_clk_init
  mmc: meson-gx: improve initial configuration
  mmc: meson-gx: remove member mrq from struct meson_host
  mmc: meson-gx: replace magic timeout numbers with constants

 drivers/mmc/host/meson-gx-mmc.c | 126 ++++++++++++++++------------------------
 1 file changed, 50 insertions(+), 76 deletions(-)

-- 
2.11.1


