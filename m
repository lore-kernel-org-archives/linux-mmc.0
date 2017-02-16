From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 0/9] mmc: meson-gx: series with smaller improvements
Date: Thu, 16 Feb 2017 20:38:29 +0100
Message-ID: <cf116046-75ff-48ad-6b61-5a67228ce728@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34027 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932694AbdBPTnD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2017 14:43:03 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so4696356wmi.1
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2017 11:43:02 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

v2 of the series is limited to smaller refactorings w/o functional changes.

Heiner Kallweit (9):
  mmc: meson-gx: simplify bounce buffer setting in meson_mmc_start_cmd
  mmc: meson-gx: make two functions return void
  mmc: meson-gx: remove unused members irq, ocr_mask from struct meson_host
  mmc: meson-gx: remove unneeded variable in meson_mmc_clk_init
  mmc: meson-gx: remove member parent_mux from struct meson_host
  mmc: meson-gx: remove unneeded meson_mmc_clk_set in meson_mmc_clk_init
  mmc: meson-gx: remove unneeded devm_kstrdup in meson_mmc_clk_init
  mmc: meson-gx: improve initial configuration
  mmc: meson-gx: remove member mrq from struct meson_host

 drivers/mmc/host/meson-gx-mmc.c | 119 +++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 76 deletions(-)

-- 
2.11.1

