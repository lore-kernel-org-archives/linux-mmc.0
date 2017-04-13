From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 0/2] Cavium MMC driver smatch fixes
Date: Thu, 13 Apr 2017 14:10:49 +0200
Message-ID: <20170413121051.10507-1-jglauber@cavium.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33717 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbdDMMLO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Apr 2017 08:11:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, "Steven J . Hill" <steven.hill@cavium.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Glauber <jglauber@cavium.com>

Hi Ulf,

here are two cosmetical changes for the reported smatch errors.

Jan Glauber (2):
  mmc: cavium: Remove redundant pointer check
  mmc: cavium: Check pointer before de-reference

 drivers/mmc/host/cavium.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.9.0.rc0.21.g7777322

