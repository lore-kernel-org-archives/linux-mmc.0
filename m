From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/3] mmc: tmio: Use modern PM ops
Date: Tue,  5 Nov 2013 13:10:00 +0100
Message-ID: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:61297 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab3KEMKK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Nov 2013 07:10:10 -0500
Received: by mail-wi0-f182.google.com with SMTP id ez12so1951152wid.9
        for <linux-mmc@vger.kernel.org>; Tue, 05 Nov 2013 04:10:09 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

This patchset converts tmio and sh_mobile_sdhi to use the modern PM ops.

Ulf Hansson (3):
  mmc: sh_mobile_sdhi: Use modern PM macros to define pm callbacks
  mmc: tmio_mmc: Convert from legacy to modern PM ops
  mmc: tmio: Adapt to proper PM configs for exported functions

 drivers/mmc/host/sh_mobile_sdhi.c |    8 ++++----
 drivers/mmc/host/tmio_mmc.c       |   32 ++++++++++++++++++--------------
 drivers/mmc/host/tmio_mmc.h       |    7 +++----
 drivers/mmc/host/tmio_mmc_pio.c   |    7 ++++---
 4 files changed, 29 insertions(+), 25 deletions(-)

-- 
1.7.9.5

