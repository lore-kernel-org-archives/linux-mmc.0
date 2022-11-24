Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9757AC4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Nov 2022 17:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiKXRHI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Nov 2022 12:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKXRHH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2022 12:07:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DE52B1BB
        for <linux-mmc@vger.kernel.org>; Thu, 24 Nov 2022 09:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669309626; x=1700845626;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JM3Mi71bsfUnuHsn3xYCaao1iAtiQHwUMtPrmlfnKm0=;
  b=G/qvuCVi+EQOv68/7HhwPfy2PjoY7A5kIn7CCqjiwhvm5AL6jPuN9+0S
   7z0cxwo0G3xl+u0ook5rMefpB9fnN19NtOZaEJVtbLj5ch0sH7QgHI2n+
   mW9nlJSu0SJLtLOX3E242+/m7+VcdKYEisR8OOmQpiTBSGVY8PVg44G1z
   RzogbC1VzPhAg7XCdIdWY/5wnUoR6ACIH6Mu6jAml8FvARmFF/N/st2l0
   dH9iJM3zMqcjchTUvrO6N70lPvpQU64yBiDn3IVJH5hcbL4gO7wRbXrAi
   tbz/SfJaSOg26pkdTI6n6Xq7ew2bG27VId4G3SmSgov22dIlpOXZ9oalx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="314374145"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="314374145"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 09:07:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="971313013"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="971313013"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.33.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 09:07:00 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sarthak Garg <quic_sartgarg@quicinc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Prabu Thangamuthu <prabu.t@synopsys.com>,
        Manjunath M B <manjumb@synopsys.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>,
        Wenchao Chen <wenchao.chen@unisoc.com>,
        Chevron Li <chevron.li@bayhubtech.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 0/4] mmc: sdhci: Fix voltage switch delay
Date:   Thu, 24 Nov 2022 19:06:45 +0200
Message-Id: <20221124170649.63851-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi

Here is a fix for the voltage switch delay issue raised here:

  https://lore.kernel.org/linux-mmc/20221117094859.20582-1-quic_sartgarg@quicinc.com/

Plus some subsequent tidy-ups.


Adrian Hunter (4):
      mmc: sdhci: Fix voltage switch delay
      mmc: sdhci: Avoid unnecessary re-configuration
      mmc: sdhci: Avoid unnecessary ->set_clock()
      mmc: sdhci: Enable card clock instead of ->set_clock()

 drivers/mmc/host/sdhci.c | 91 +++++++++++++++++++++++++++++++-----------------
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 61 insertions(+), 32 deletions(-)


Regards
Adrian
