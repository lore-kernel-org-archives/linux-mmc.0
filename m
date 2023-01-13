Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8381EC54EBE
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Jan 2023 11:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241264AbjAMLKw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Jan 2023 06:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbjAMLKG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2023 06:10:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2BB77D00
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2023 03:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673607634; x=1705143634;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PhUkN5oucAg/07QwPkqu0Gym4V2o+lKjNBj00duXY4Y=;
  b=PeqWWa4xG9fX8V1NZj7phc7XRrlJPo/khT8+OrM1wT9QdiSy6x2fAcNt
   ZlI9Cn5U1q4gLT07iDBGRe+/C39zsb4jGDZmxkCQLU2NGN8ZCsHufxI3U
   ek6V360gP8iRnuXQHUQwH3JB1N9wdfBtONvEAk51fQX/YhtCq2ZL9OPjs
   frOkk1sqciHYEU6EFGqhWlmTJZp902bjcxgYcVDDcoaWdTM3gbBg2J4g4
   r5mhdjr6ISEOMyXqhoq/ovXrpv+N8TO8pblyU2Ali20+C8QDd5+fkG9n8
   /1pDTCa1VmgRbSLle4KZcoKdVGi3WPIy9SYwrwQOstepBz7P4um0/npBT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="322668271"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="322668271"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:00:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="690471609"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="690471609"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.38.178])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:00:29 -0800
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
Subject: [PATCH 0/6] mmc: sdhci: Remove SDHCI_QUIRK_MISSING_CAPS
Date:   Fri, 13 Jan 2023 13:00:05 +0200
Message-Id: <20230113110011.129835-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi

This patch set is to remove SDHCI_QUIRK_MISSING_CAPS.

SDHCI_QUIRK_MISSING_CAPS is not needed because __sdhci_read_caps() can be
called instead.

__sdhci_read_caps() is also called from sdhci_setup_host() via
sdhci_read_caps(), however only the first call to __sdhci_read_caps() does
anything because after that host->read_caps has been set to true.

Note, __sdhci_read_caps() does more than just set host->caps, such as do a
reset, so calling __sdhci_read_caps() earlier could have unforeseen
side-effects. However code flow has been reviewed with that in mind.


Adrian Hunter (6):
      mmc: sdhci-pci: Replace SDHCI_QUIRK_MISSING_CAPS for Ricoh controller
      mmc: sdhci-brcmstb: Replace SDHCI_QUIRK_MISSING_CAPS
      mmc: sdhci-sprd: Replace SDHCI_QUIRK_MISSING_CAPS
      mmc: sdhci-pxav3: Replace SDHCI_QUIRK_MISSING_CAPS
      mmc: sdhci-iproc: Replace SDHCI_QUIRK_MISSING_CAPS
      mmc: sdhci: Remove SDHCI_QUIRK_MISSING_CAPS

 drivers/mmc/host/sdhci-brcmstb.c  |  4 +---
 drivers/mmc/host/sdhci-iproc.c    | 14 ++++++++------
 drivers/mmc/host/sdhci-pci-core.c |  8 +++++---
 drivers/mmc/host/sdhci-pxav3.c    |  4 +---
 drivers/mmc/host/sdhci-sprd.c     |  6 ++----
 drivers/mmc/host/sdhci.c          |  3 ---
 drivers/mmc/host/sdhci.h          |  2 --
 7 files changed, 17 insertions(+), 24 deletions(-)


Regards
Adrian
