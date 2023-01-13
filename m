Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670E2C54EBD
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Jan 2023 11:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbjAMLLG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Jan 2023 06:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240890AbjAMLKR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2023 06:10:17 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A18F6E
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2023 03:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673607656; x=1705143656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zaHociYB0QKxVlKBlSd1bKhqV0y1GCdavM8LWIOx4eU=;
  b=W1w499pJ6Hu99CG6Tvqfdi0EpzY760pD6hGnVJINw3D1ttVr20VpvCbH
   Tg7MWcJc3xBOP9HKt44BmJipSfS4AFGZW8yXZbrL27G3wj+xBmOlJhR3o
   hF/DK/SASzb/qhgvaZBQWHCuwpEjejjjTi41JyewuwvY9PtvXBd5YfslY
   9NJXsZKMSOpf3nXxc2AMFhZIDrNqxFq3XA5WIMJ8ljaZEWz7iYuw6XOAr
   SYNxcTmsBvIp2TcQaIUbOIUju+Q+umZTzzhd+U0HTc22B5aV/W/dcl5UB
   YYIRZsjf1sufDmWVkR9ZD6D4krPEKAuehPhSJehPuHEUAZWC6dkkhW/Y6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="322668412"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="322668412"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:00:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="690472696"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="690472696"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.38.178])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:00:51 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>, Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Marek Vasut <marex@denx.de>, linux-mmc@vger.kernel.org
Subject: [PATCH 6/6] mmc: sdhci: Remove SDHCI_QUIRK_MISSING_CAPS
Date:   Fri, 13 Jan 2023 13:00:11 +0200
Message-Id: <20230113110011.129835-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113110011.129835-1-adrian.hunter@intel.com>
References: <20230113110011.129835-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Now that it is no longer used, remove SDHCI_QUIRK_MISSING_CAPS.

Note, from now on, __sdhci_read_caps() should be used to provide missing
capability flags.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 3 ---
 drivers/mmc/host/sdhci.h | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f3af1bd0f7b9..3241916141d7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4121,9 +4121,6 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
 	v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
 
-	if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
-		return;
-
 	if (caps) {
 		host->caps = *caps;
 	} else {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 605eaee805f7..f4f2085c274c 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -423,8 +423,6 @@ struct sdhci_host {
 #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
 /* Controller cannot support End Attribute in NOP ADMA descriptor */
 #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
-/* Controller is missing device caps. Use caps provided by host */
-#define SDHCI_QUIRK_MISSING_CAPS			(1<<27)
 /* Controller uses Auto CMD12 command to stop the transfer */
 #define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
 /* Controller doesn't have HISPD bit field in HI-SPEED SD card */
-- 
2.34.1

