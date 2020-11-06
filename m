Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0870AC388F2
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 04:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD4DC206F7
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 04:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgKFEJx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 23:09:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:11272 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgKFEJx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 5 Nov 2020 23:09:53 -0500
IronPort-SDR: 67LTcUb1Zq66gqps6s022dD/8VAddIchjH6/iSgNhcpcPLMJ1eX5kcGvNxyHH38T6gVAKTs7sx
 Z6Ujz9Eed2FA==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="166909025"
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="166909025"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 20:09:53 -0800
IronPort-SDR: eGzh6tBujj5MVGz3eSBhDq6BauetNzAEZtA3HYwGKln6iiie7cqIblj8sp0lKR+6hgK3hRty3h
 C4PaSV/Ix5vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="354560662"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by fmsmga004.fm.intel.com with ESMTP; 05 Nov 2020 20:09:51 -0800
From:   muhammad.husaini.zulkifli@intel.com
To:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     adrian.hunter@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, david.e.box@linux.intel.com
Subject: [PATCH v1 0/1] mmc: sdhci-of-arasan: Specify .clk_ops for Keem Bay SOC
Date:   Fri,  6 Nov 2020 20:09:32 +0800
Message-Id: <20201106120933.7190-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Hi.

This patch declares the .clk_ops for Keem Bay SOC due to the
introduction of new clock operations handling.

This was tested with Keem Bay evaluation module board.

Kindly help to review it.

Thank you.

Muhammad Husaini Zulkifli (1):
  mmc: sdhci-of-arasan: Specify .clk_ops for Keem Bay SOC

 drivers/mmc/host/sdhci-of-arasan.c | 3 +++
 1 file changed, 3 insertions(+)

--
2.17.1

