From: David Cohen <david.a.cohen@linux.intel.com>
Subject: [RFC/PATCH 0/2] mmc: sdhci: Workaround Intel Merrifield issue for HS200
Date: Tue, 29 Oct 2013 10:58:25 -0700
Message-ID: <1383069507-27574-1-git-send-email-david.a.cohen@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53415 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758604Ab3J2RyU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 29 Oct 2013 13:54:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, adrian.hunter@intel.com, gregkh@linuxfoundation.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, chuanxiao.dong@intel.com, David Cohen <david.a.cohen@linux.intel.com>

Hi,

SDHCI used to work well on Intel Merrifield until this patch was applied:

commit 156e14b126ffb6f040bc6f1aff3c51077e42a744
Author: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Date:   Wed Jun 12 08:16:38 2013 +0200

    mmc: sdhci: fix caps2 for HS200
    
    Although the HC supports HS200 (eMMC) the caps2 are always zero; this
    means there's no way to use the super speed mode (when init the card).
    
    If the HC support SDR104, for SD3.0, so it also supports HS200 for eMMC
    and this patch just sets the MMC_CAP2_HS200 in the host caps2 field.

Looks like there is a hw issue with unknown root cause so far.

Is it acceptable to have the quirk I'm proposing to workaround the issue?

Br, David Cohen

---
David Cohen (2):
  mmc: sdhci: add quirk for broken HS200 support
  mmc: sdhci-pci: add broken HS200 quirk for Intel Merrifield

 drivers/mmc/host/sdhci-pci.c | 1 +
 drivers/mmc/host/sdhci.c     | 3 ++-
 include/linux/mmc/sdhci.h    | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

-- 
1.8.4.rc3

