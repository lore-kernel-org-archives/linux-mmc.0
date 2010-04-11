From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: [PATCH 0/2] [RESEND] Add ADMA support to s3c64xx SDHCI controller
Date: Sun, 11 Apr 2010 17:22:40 +0200
Message-ID: <j2mb2e8f9f71004110822i87318cbbr98d3b3fdbf86b96e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:61240 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab0DKPXC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Apr 2010 11:23:02 -0400
Received: by bwz19 with SMTP id 19so24362bwz.21
        for <linux-mmc@vger.kernel.org>; Sun, 11 Apr 2010 08:23:00 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, sdhci-devel@lists.ossman.eu
Cc: Thomas Abraham <thomas.ab@samsung.com>, Ben Dooks <ben-linux@fluff.org>, kgene.kim@samsung.com

This is a resend of the following patches, rebased against 2.6.34-rc3:

Thomas Abraham (2):
  s3c6410: Add new quirk in sdhci driver and update ADMA descriptor
    build.
  s3c6410: Enable ADMA feature in 6410 sdhci controller.

 drivers/mmc/host/sdhci-s3c.c |    7 +------
 drivers/mmc/host/sdhci.c     |   20 +++++++++++++++-----
 drivers/mmc/host/sdhci.h     |    2 ++
 3 files changed, 18 insertions(+), 11 deletions(-)

---
Maurus Cuelenaere
