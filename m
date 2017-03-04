From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v5 0/10] mmc: meson-gx: series with smaller improvements
Date: Sat, 4 Mar 2017 13:17:55 +0100
Message-ID: <a76c3483-2c86-85c1-446e-f2522bd28aa8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36544 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdCDMSM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Mar 2017 07:18:12 -0500
Received: by mail-wm0-f54.google.com with SMTP id n11so32964959wma.1
        for <linux-mmc@vger.kernel.org>; Sat, 04 Mar 2017 04:18:11 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

New series is limited to smaller refactorings w/o functional changes.

v5:
- fix a hang caused by patch "improve initial configuration"

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

 drivers/mmc/host/meson-gx-mmc.c | 120 ++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 73 deletions(-)

-- 
2.12.0


