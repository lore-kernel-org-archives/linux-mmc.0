Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E882C433E9
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 15:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4FEA22BED
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 15:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbhAKPwG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jan 2021 10:52:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:23990 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbhAKPwG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 11 Jan 2021 10:52:06 -0500
IronPort-SDR: 9ShUlQiRPqp+dc1+yLFE9mswyfs9XK55dQO916s0EFSEQiblExWweglc2RbzxSoeA7L03MesGn
 LxkbMMFpNtNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="157661817"
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="157661817"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 07:51:25 -0800
IronPort-SDR: hZ4+4ClOm4f31FJNmSGuxdBG9gLJpq/NKQDYC3UKJu/pBKRGstY1OzTpvhf8wapc+2g8VE1cVM
 U0OkpjaFVPeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="404152351"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jan 2021 07:51:23 -0800
From:   Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To:     ulf.hansson@linaro.org, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     adrian.hunter@intel.com, andriy.shevchenko@intel.com,
        muhammad.husaini.zulkifli@intel.com
Subject: [PATCH v1 0/2] mmc: sdhci-of-arasan: Fixed kernel-doc format warning
Date:   Mon, 11 Jan 2021 23:49:59 +0800
Message-Id: <20210111155001.12307-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

This patch series are to fix the kernel-doc format warning when using kernel-doc
script tool and to change code style of mapping the syscon field for readability
and consistency.

Kindly help to review this patch set.

Thanks.

Muhammad Husaini Zulkifli (2):
  mmc: sdhci-of-arasan: Fixed kernel-doc format warning
  mmc: sdhci-of-arasan: Change code style of mapping the syscon field

 drivers/mmc/host/sdhci-of-arasan.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--
2.17.1

