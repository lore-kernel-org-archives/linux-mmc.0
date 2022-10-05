Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2885BC433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Oct 2022 10:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJEKUO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Oct 2022 06:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiJEKUM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2022 06:20:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7902BE0F
        for <linux-mmc@vger.kernel.org>; Wed,  5 Oct 2022 03:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664965211; x=1696501211;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=scSpjR0Pvyv7oXdaR1nPAmZwR9CVGbolNzaHC5kzmHY=;
  b=cyMj8zorexVHbWu9XaSRUana5unqJE/B7YPpVo5GxuZrqaxk06XUkOOO
   21r0SEvSWTFWtg60nKvcK1ZA5Lr07VII2cqBk+ZxpVFbe0YZJq+Qx3lwc
   kdORWRiuoQlL+Au6c5YrYkGMs5+uhsr+WTa/lpFpi40PiAN++Aa5QdZOJ
   2EiMtf1Wwf6jhB+sGwKOrChstA3o8io8xcRvJ+Vw3NlSGXSeTQTvdp/Y9
   7f/r4g65mu6sSyd87gK5y4R97D+vwfATpxQoE1nByQyQAIlPQo3GavACe
   CsJAm1Jf7MQLEUdHVf3JAVQRL7nfUsENgcWh5jbXO7QCMq5zW+tbfvTGG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304110405"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="304110405"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:11 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728605902"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="728605902"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:09 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 00/14] mmc: Replace kmap_atomic() with kmap_local_page()
Date:   Wed,  5 Oct 2022 13:19:37 +0300
Message-Id: <20221005101951.3165-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi

Here are patches primarily aimed at replacing kmap_atomic() with
kmap_local_page().

kmap_local_page() is equivalent to kmap_atomic() except that it does not
disable page faults or preemption. Where possible kmap_local_page() is
preferred to kmap_atomic() - refer kernel highmem documentation.

In these cases, there is no need to disable page faults or preemption, so
kmap_atomic() is replaced with kmap_local_page(), and, correspondingly,
kunmap_atomic() with kunmap_local().

That work raised the question of why local_irq_{save,restore}() was being
used with k[un]map_atomic().  It turns out to be for legacy reasons that
have gone away.

A long time ago the kmap_atomic API required a slot to be provided which
risked the possibility that other code might use the same slot at the
same time. Disabling interrupts prevented the possibility of an interrupt
handler doing that. However, that went away with
commit 3e4d3af501cc ("mm: stack based kmap_atomic()").

The work is mostly divided into separate patches, to enable separate review
for driver reviewers and to enable separate reverts if necessary.


Adrian Hunter (14):
      mmc: sdhci: Remove local_irq_{save,restore}() around k[un]map_atomic()
      mmc: sdhci: Remove local_irq_{save,restore}() around sg_miter_{next,stop}()
      mmc: sdhci: Replace kmap_atomic() with kmap_local_page()
      mmc: bcm2835: Remove local_irq_{save,restore}() around k[un]map_atomic()
      mmc: bcm2835: Remove local_irq_{save,restore}() around sg_miter_{next,stop}()
      mmc: bcm2835: Replace kmap_atomic() with kmap_local_page()
      mmc: mmc_test: Remove local_irq_{save,restore}() around sg_copy_{from,to}_buffer()
      mmc: tifm_sd: Remove local_irq_{save,restore}() around tifm_sd_transfer_data()
      mmc: tifm_sd: Remove local_irq_{save,restore}() around tifm_sd_bounce_block()
      mmc: tifm_sd: Replace kmap_atomic() with kmap_local_page()
      mmc: tmio_mmc_core: Remove local_irq_{save,restore}() around k[un]map_atomic()
      mmc: tmio_mmc_core: Replace kmap_atomic() with kmap_local_page()
      mmc: au1xmmc: Replace kmap_atomic() with kmap_local_page()
      mmc: wbsd: Replace kmap_atomic() with kmap_local_page()

 drivers/mmc/core/mmc_test.c              |  5 -----
 drivers/mmc/host/au1xmmc.c               |  8 ++++----
 drivers/mmc/host/bcm2835.c               | 12 ++----------
 drivers/mmc/host/renesas_sdhi_sys_dmac.c |  5 ++---
 drivers/mmc/host/sdhci.c                 | 30 ++++++++----------------------
 drivers/mmc/host/tifm_sd.c               | 28 ++++++++++------------------
 drivers/mmc/host/tmio_mmc.h              | 11 ++++-------
 drivers/mmc/host/tmio_mmc_core.c         | 10 ++++------
 drivers/mmc/host/wbsd.c                  | 10 +++++-----
 9 files changed, 39 insertions(+), 80 deletions(-)


Regards
Adrian
