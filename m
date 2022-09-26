Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3424AC07E9D
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Sep 2022 19:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIZTUt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiIZTUk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Sep 2022 15:20:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078C867CAD
        for <linux-mmc@vger.kernel.org>; Mon, 26 Sep 2022 12:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664220040; x=1695756040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LYdsmvR2QKZoDzrRtOuwcQwbtA8ox0NfsL98IyuKGQc=;
  b=baLOiO7xNOcIMkZQMpKLSmzOqdpDemZWTPzW+M+EqzgbFiy0KLOi+YK8
   05K0iWijW6ISPHGtJIj4+B5PiOr65yFH0vJRFvEzz3I4Z4XVrNBGvIDuC
   TRTDZUfGQjlOG1rNRsd8pfTRnphU9Sopt1Wu+JmzXi+Be/wsSK683CSmp
   FbTTnwblq9zd8BZgtDZBlutiP9AmS2NKZ21kwk8FrMONO3oCqoD8yaxAW
   ofv0dbHfUT1W13A+KuIIuKkZhj25EL8TpsLj7fLf64tg61egNWwJPRnZs
   AFoKjzL6twtHb0ydqtyaFkr9VTF/xPU2XEQ5Szh3WED9GA0P//WFL9j7C
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="298717881"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="298717881"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 12:20:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="796455541"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="796455541"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.121])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 12:20:36 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     pshete@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        anrao@nvidia.com, smangipudi@nvidia.com, kyarlagadda@nvidia.com
Subject: [PATCH 0/4] mmc: sdhci: Tidy reset handling
Date:   Mon, 26 Sep 2022 22:20:18 +0300
Message-Id: <20220926192022.85660-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi

When reviewing the patch "mmc: sdhci-tegra: Issue CMD and DAT resets
together" currently on the mailing list:

https://lore.kernel.org/linux-mmc/20220926094906.14537-3-pshete@nvidia.com/

it seemed like some small tidy up was needed first.  Hence these patches.

In particular, patch 4 "mmc: sdhci: Centralize CMD and DATA reset handling"
should enable the proposed quirk from the sdhci-tegra patch to be
implemented in a more consistent way.


Adrian Hunter (4):
      mmc: sdhci: Separate out sdhci_reset_for_all()
      mmc: sdhci: Remove misleading comment about resets
      mmc: sdhci: Get rid of SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS
      mmc: sdhci: Centralize CMD and DATA reset handling

 drivers/mmc/host/sdhci-pci-core.c | 23 ++++++++++-
 drivers/mmc/host/sdhci.c          | 84 ++++++++++++++++++++++++---------------
 drivers/mmc/host/sdhci.h          |  2 -
 3 files changed, 73 insertions(+), 36 deletions(-)


Regards
Adrian
