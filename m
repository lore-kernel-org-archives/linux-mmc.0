From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v2 0/3] mmc: cavium: bug fixes for 4.12
Date: Mon, 22 May 2017 13:09:18 +0200
Message-ID: <20170522110921.15395-1-jglauber@cavium.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36518 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753736AbdEVLJi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2017 07:09:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Glauber <jglauber@cavium.com>

Changes to v1:
- Fixed platform device leak, apply fix also to Octeon driver
- Use mmc_regulator_get_supply

Jan Glauber (3):
  mmc: cavium: Prevent crash with incomplete DT
  of/platform: Make of_platform_device_destroy globally visible
  mmc: cavium: Fix probing race with regulator

 drivers/mmc/host/cavium-octeon.c   | 11 ++++++++++-
 drivers/mmc/host/cavium-thunderx.c |  6 ++++++
 drivers/mmc/host/cavium.c          | 25 ++++++++++---------------
 drivers/of/platform.c              |  3 ++-
 include/linux/of_platform.h        |  1 +
 5 files changed, 29 insertions(+), 17 deletions(-)

-- 
2.9.0.rc0.21.g7777322

