From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/6] mmc: meson-gx: further smaller refactorings
Date: Wed, 22 Mar 2017 22:16:40 +0100
Message-ID: <8bf58a83-d8d7-615c-c89b-87a62a3c9c40@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34654 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbdCVVQ4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Mar 2017 17:16:56 -0400
Received: by mail-wm0-f68.google.com with SMTP id u132so12974083wmg.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Mar 2017 14:16:55 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Before we come to the functional changes here one more series with
smaller refactorings.

Heiner Kallweit (6):
  mmc: meson-gx: remove unneeded configuration bit resets
  mmc: meson-gx: replace cmd->data in meson_mmc_start_cmd
  mmc: meson-gx: improve variable usage in meson_mmc_start_cmd
  mmc: meson-gx: improve response reading
  mmc: meson-gx: improve setting data->bytes_xfered
  mmc: meson-gx: simplify setting timeout configuration parameters

 drivers/mmc/host/meson-gx-mmc.c | 104 ++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 57 deletions(-)

-- 
2.12.0

