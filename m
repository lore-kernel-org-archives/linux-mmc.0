Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D392C5519F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 04:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5756424654
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 04:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgKREBl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Nov 2020 23:01:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:19158 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgKREBl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Nov 2020 23:01:41 -0500
IronPort-SDR: P5IjeJXG5pjBAYUylq4T4hliwez8kR2aWycaZ5qEtFpRIQJRDVS1pV5g1iHAo2UA4zRS4IhLd8
 rgkSepi3oHZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150331100"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150331100"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 20:01:41 -0800
IronPort-SDR: 6vJUf//vebMVtUeILcWmUDdVmJrhrvwvbjcp/2kSIS5MqbZ1CqQQwGJdjXVmW/ZgmInoR0IWFF
 V+oFasbYBp1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="310441537"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by fmsmga008.fm.intel.com with ESMTP; 17 Nov 2020 20:01:39 -0800
From:   muhammad.husaini.zulkifli@intel.com
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     adrian.hunter@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, david.e.box@linux.intel.com
Subject: [PATCH v2 0/1] mmc: sdhci-of-arasan: Fix clock registration fail for Keem Bay SOC
Date:   Wed, 18 Nov 2020 20:01:19 +0800
Message-Id: <20201118120120.24908-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Hi.

This patch specify clock operations handlers for Keem Bay SOC devices
due to the introduction of new clock operations handling.

Tested with Keem Bay evaluation module board.

Kindly help to review it.

Thank you.

Changes since v1:
- Update the commit message to better reflect what goes on

Muhammad Husaini Zulkifli (1):
  mmc: sdhci-of-arasan: Fix clock registration fail for Keem Bay SOC

 drivers/mmc/host/sdhci-of-arasan.c | 3 +++
 1 file changed, 3 insertions(+)

--
2.17.1

