From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/2] mmc: rtsx_pci: Enable support for erase/discard/trim requests
Date: Wed, 27 Jul 2016 14:25:36 +0200
Message-ID: <1469622338-11158-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33826 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131AbcG0MZx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 08:25:53 -0400
Received: by mail-lf0-f52.google.com with SMTP id l69so26124860lfg.1
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 05:25:52 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Micky Ching <micky_ching@realsil.com.cn>, Wei WANG <wei_wang@realsil.com.cn>, Roger Tseng <rogerable@realtek.com>, Mauro Santos <registo.mailling@gmail.com>, Baolin Wang <baolin.wang@linaro.org>

To enable the rtsx_pci driver to support erase/discard/trim, it needs to manage
timeouts for R1B responses according to the expecations from the mmc core. Fix
this and then enable MMC_CAP_ERASE.

Ulf Hansson (2):
  mmc: rtsx_pci: Use the provided busy timeout from the mmc core
  mmc: rtsx_pci: Enable MMC_CAP_ERASE to allow erase/discard/trim
    requests

 drivers/mmc/host/rtsx_pci_sdmmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1

