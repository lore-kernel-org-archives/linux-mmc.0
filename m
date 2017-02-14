From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 00/18] mmc: meson-gx: code and performance improvements
Date: Tue, 14 Feb 2017 21:05:16 +0100
Message-ID: <74c3a06c-d972-1e70-fb22-744df8ef31d9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36616 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbdBNUH3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2017 15:07:29 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so5221026wmd.3
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2017 12:07:28 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

This patch series includes several improvements and boosted the
read performance from 13 MB/s to 32 MB/s (at 60MHz clock rate)
on a Odroid C2 with a 128GB eMMC module.

Higher frequencies needed tuning in my case. With some hacked
test tuning I reached 52 MB/s at 200MHz.
With a 8GB card 200MHz were stable out of the box, but with
less performacne.

Heiner Kallweit (18):
  mmc: meson-gx: set segment host parameters
  mmc: meson-gx: remove code for unsupported CMD23
  mmc: meson-gx: explicitely call stop command for multi-block commands only
  mmc: meson-gx: improve meson_mmc_start_cmd
  mmc: meson-gx: eliminate struct sd_emmc_data
  mmc: meson-gx: simplify bounce buffer setting in meson_mmc_start_cmd
  mmc: meson-gx: check return value of sg_copy_[from,to]_buffer
  mmc: meson-gx: make two functions return void
  mmc: meson-gx: change interrupt name
  mmc: meson-gx: remove unused members irq, ocr_mask from struct meson_host
  mmc: meson-gx: remove unneeded variable in meson_mmc_clk_init
  mmc: meson-gx: remove member parent_mux from struct meson_host
  mmc: meson-gx: remove unneeded meson_mmc_clk_set in meson_mmc_clk_init
  mmc: meson-gx: remove unneeded devm_kstrdup in meson_mmc_clk_init
  mmc: meson-gx: improve initial configuration
  mmc: meson-gx: improve response reading and sending stop command
  mmc: meson-gx: remove member mrq from struct meson_host
  mmc: meson-gx: move handling of one case from threaded handler to main irq

 drivers/mmc/host/meson-gx-mmc.c | 241 ++++++++++++++++------------------------
 1 file changed, 97 insertions(+), 144 deletions(-)

-- 
2.11.1

