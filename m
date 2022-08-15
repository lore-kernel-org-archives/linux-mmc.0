Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3432FC00140
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Aug 2022 10:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiHOK70 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Aug 2022 06:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiHOK7U (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2022 06:59:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251FF17ABE
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 03:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660561160; x=1692097160;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cxFhGBOJsmCKHKIqllvCqaNNwS3Y0fDQbyO+BoLgcNw=;
  b=abuQQroC/+ACxJqVFwyjLwVqX4tvOkHiuBQ4BEmEY58xpP/Vo8bv3QN2
   +FiJCHt51mVi8lwiypjC3FJBuHgcueip4HD4QJFq0p9ZV4X+pUsZdvMOv
   KBLOHorojlLkvVmcoDZAUjIoiG8X9ZTwZws1R19+ZooyqPil0GhxUJkd7
   yZfEGLRjkRjOqZeYmQ3F8dKsofYZNi0eui0YKEVHZ7WZkMFTA+Tn5ZcNy
   1rjNNp9o1Gfhr4BZG8q/0F5gaT3aQyLUAujWYvX9UGWuYmPwTXmg4kB0g
   XVPtCQAFF6kJgKah79IPhs4MeWujVf2WY2i/kA0D6M5RDH0ioyzXw7kXo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="290689059"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="290689059"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 03:59:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="603149063"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.50.166])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 03:59:18 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc: sdhci: Update MAINTAINERS Maintained -> Supported
Date:   Mon, 15 Aug 2022 13:59:05 +0300
Message-Id: <20220815105905.65188-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Currently, status is "Supported" not "Maintained" for SDHCI and CQHCI.
Amend MAINTAINERS accordingly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f679152bdbad..4f804357f3a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7414,7 +7414,7 @@ M:	Adrian Hunter <adrian.hunter@intel.com>
 M:	Ritesh Harjani <riteshh@codeaurora.org>
 M:	Asutosh Das <asutoshd@codeaurora.org>
 L:	linux-mmc@vger.kernel.org
-S:	Maintained
+S:	Supported
 F:	drivers/mmc/host/cqhci*
 
 EMULEX 10Gbps iSCSI - OneConnect DRIVER
@@ -17995,7 +17995,7 @@ F:	drivers/mmc/host/sdhci-brcmstb*
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) DRIVER
 M:	Adrian Hunter <adrian.hunter@intel.com>
 L:	linux-mmc@vger.kernel.org
-S:	Maintained
+S:	Supported
 F:	drivers/mmc/host/sdhci*
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
-- 
2.25.1

