From: "Felipe F. Tonello" <eu@felipetonello.com>
Subject: [PATCH 0/2] Added set_power handler to mmc sdhci host
Date: Wed, 22 May 2013 10:47:10 -0700
Message-ID: <1369244832-23868-1-git-send-email-eu@felipetonello.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:37171 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159Ab3EVRr5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 May 2013 13:47:57 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so3129552oag.11
        for <linux-mmc@vger.kernel.org>; Wed, 22 May 2013 10:47:56 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, cjb@laptop.org, arnd@arndb.de, linux-kernel@vger.kernel.org, "Felipe F. Tonello" <eu@felipetonello.com>

From: "Felipe F. Tonello" <eu@felipetonello.com>

This set_power handler is useful for modules that need to be turned off when
the mmc host turns off.

Felipe F. Tonello (2):
  mmc: sdhci: Added set_power sdhci_ops handler.
  mmc: sdhci-s3c: Added set_power handler to platdata

 drivers/mmc/host/sdhci-s3c.c                | 8 ++++++++
 drivers/mmc/host/sdhci.c                    | 8 ++++++++
 drivers/mmc/host/sdhci.h                    | 1 +
 include/linux/platform_data/mmc-sdhci-s3c.h | 1 +
 4 files changed, 18 insertions(+)

-- 
1.8.1.4

