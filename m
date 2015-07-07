From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v2 0/2] mmc: omap_hsmmc: omap_hsmmc_set_power cleanup
Date: Tue,  7 Jul 2015 20:38:42 +0200
Message-ID: <1436294324-18666-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38558 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933172AbbGGSiu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jul 2015 14:38:50 -0400
Received: by wibdq8 with SMTP id dq8so191592421wib.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jul 2015 11:38:48 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andreas Fenkart <afenkart@gmail.com>

v2:
- add empty omap_hsmmc_set_power in case CONFIG_REGULATOR is undefined

Andreas Fenkart (2):
  mmc: omap_hsmmc: call omap_hsmmc_set_power directly
  mmc: omap_hsmmc: regulator automatically released by devm

 drivers/mmc/host/omap_hsmmc.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

-- 
2.1.4

