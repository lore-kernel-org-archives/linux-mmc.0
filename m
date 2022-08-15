Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290ACC00140
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Aug 2022 07:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240631AbiHOHdh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Aug 2022 03:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiHOHdg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2022 03:33:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C52183AD
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 00:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660548816; x=1692084816;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GRzDk7P/rnoIceF/i+gqKBptbF+/4qf+daHO9Q0nzzg=;
  b=mVMMC69tS6Ll+K5sv/RAA19JFtBtheWsFLJSnawJr/pe/TCo3m/gkWj1
   bC8kcQM0rOjgHhbQqscW2CjgkpeXqjGhkHR9x95zpUNAMFV23K1nIzWL7
   5jBea7Ab60xIeojWvpg+0vtlqSEZ06FKPy7Y//up9tAwLcmxHuM4qEiEl
   /cKTfgK6Ly+qHp7qRhTnIar6A6EbsRCg688gpoKrQaJozWSA8/j/IonIc
   LqGJGpuIlizqhklUwUe++jX+hVYfIFke4Uj5Zzw+hOGWjJeUq9f0LsfMS
   FiIQ8ZY7hHX+TfN9iRpLoVzOUUWA3PaBkqNPN/bfTgqC1cH6N9gRq/4ok
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="290663298"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="290663298"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 00:33:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="603108059"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.50.166])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 00:33:33 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Seunghui Lee <sh043.lee@samsung.com>,
        DooHyun Hwang <dh0421.hwang@samsung.com>
Subject: [PATCH 0/2] mmc: sd: Fix inconsistent sd3_bus_mode with failed voltage switch
Date:   Mon, 15 Aug 2022 10:33:19 +0300
Message-Id: <20220815073321.63382-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi

Here are 2 SD card fixes prompted by the following email thread:

	https://lore.kernel.org/linux-mmc/20220721055924.9043-1-sh043.lee@samsung.com/T/#u


Adrian Hunter (2):
      mmc: sd: Fix 1.8V workaround branch
      mmc: sd: Fix inconsistent sd3_bus_mode with failed voltage switch

 drivers/mmc/core/sd.c | 46 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)


Regards
Adrian
