Return-Path: <SRS0=Im6a=45=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2357FC10DCE
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 14:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002C120716
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 14:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgCLOZu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:25:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:41667 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727498AbgCLOZu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Mar 2020 10:25:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 07:25:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="266348375"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by fmsmga004.fm.intel.com with ESMTP; 12 Mar 2020 07:25:47 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Kyungmin Seo <kyungmin.seo@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH RFC 0/3] mmc: core: Do not change frequency before switch from HS400
Date:   Thu, 12 Mar 2020 16:24:58 +0200
Message-Id: <20200312142501.9868-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi

Patches to improve mmc_hs400_to_hs200() as discussed here:

	https://lore.kernel.org/linux-mmc/d355ac11-21d6-e8f7-d03f-65c55e10aea2@intel.com/


Adrian Hunter (3):
      mmc: core: Try harder if transfer mode switch fails
      mmc: core: Do not check CRC response for switch from HS400 to HS200
      mmc: core: Do not change frequency before switch from HS400

 drivers/mmc/core/mmc.c     | 41 ++++++++++++++++++++++++-----------------
 drivers/mmc/core/mmc_ops.c | 13 +++++++++++--
 drivers/mmc/core/mmc_ops.h |  2 +-
 3 files changed, 36 insertions(+), 20 deletions(-)


Regards
Adrian
