From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/3] mmc: meson-gx: fixes for v4.14
Date: Mon,  2 Oct 2017 14:27:40 +0200
Message-ID: <20171002122743.32334-1-jbrunet@baylibre.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:49469 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbdJBM1v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Oct 2017 08:27:51 -0400
Received: by mail-wr0-f175.google.com with SMTP id p10so1967457wrc.6
        for <linux-mmc@vger.kernel.org>; Mon, 02 Oct 2017 05:27:50 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Heiner Kallweit <hkallweit1@gmail.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

This patchset fixes the issues reported by Heiner [0] with the odroid-c2.
In a nutshell, this series does the following:

* Make sure the mmc clock rate is not set higher than what is requested
* Reset the tuning values on mmc power cycle instead of POWER_ON
* Add tuning of the tx phase to the tuning function.

This fixes the problem seen on the odroid-c2, both for hs200 and hs400.
To check for regression, this series has also been tested on the gxl
libretech-cc

Ulf, could you please pick this as fixes for v4.14 ?

[0]: https://lkml.kernel.org/r/e2171288-84ef-82db-2efc-300935e6c062@gmail.com

Jerome Brunet (3):
  mmc: meson-gx: make sure the clock is rounded down
  mmc: meson-gx: fix rx phase reset
  mmc: meson-gx: include tx phase in the tuning process

 drivers/mmc/host/meson-gx-mmc.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

-- 
2.13.5

