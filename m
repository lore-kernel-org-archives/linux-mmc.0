Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3000C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 13:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795E961930
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 13:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhCVNiH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 09:38:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57176 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhCVNhy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Mar 2021 09:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616420274; x=1647956274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t/DXKWpQXaxw6CxRe4hbgo5MFUB8rwUKH45I5giLmoQ=;
  b=KnLTrQZt46owMQLbBPqV/FalL+GOznAA0n9HA0k0pZ/6CxjfPhO9DEJr
   8xwFy8MDZ57uOq3p0pbjKgoA4O3rlofyg7ZXGlNGC5AWO3P/USsnbsB7/
   osdoi8/uWLEzfBcafhiacC3CWStZMBpMASm3aNo60RchtV9wH5Bu/3mUi
   TwjaFBxvuzL87IijJ8nnY0v8OXs2AfWqfWDMHpV5q76W/ReOx0ztinKix
   U8ZOD3VaJcCOXGl2grXdw1uMk3vdf+EPn0y12MPLQwEfu8qzZlmljPs6U
   ukUrTzPEHKxB/d18q34aBvN6blUKPE2NtFjTgUSDZw9xCYf3R/9wTUUI0
   A==;
IronPort-SDR: 1SJ3r80m6Q6joNykuzlhGds8qEASG5MJX+SbNebsrv/CxSd5IFetg/NBdp9N02bsNd1jm1qkvt
 b2FNFBCkXM7PQYyZuZxuVjiXmgg7TpE7xzZy6o7SNXN11QG2TBRNXEZL3HF47lH/gr00LDlEa5
 ESwngzcANQq/cOA6GcgsaycCIAfm02QJnV7i7y7E8sKRyxEhlMsgrYu92VCx3q7h6JYLBXbSpy
 oNGSB4ppDyHAmwgs01rvLibAH9mECZHG+LVMywoAu0Vt/prfgPwsG0oC7toNBJua8w4TlbqW+4
 RuE=
X-IronPort-AV: E=Sophos;i="5.81,269,1610380800"; 
   d="scan'208";a="167184356"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2021 21:37:52 +0800
IronPort-SDR: rs9E5qquxFNu3a0Go1bQrYDBAi9NuZ+Gjmi/mXdoC86CG1AMrq0Zb0/QKX5f5fILdRiSYdeu/q
 g9IgoYjsy5QoFMv+X0ZSIZmUXsNAWrq3O9hN9o6tvIcqArQhnJyQsRPfIE1SAuMtvXs5rE/0ao
 VIuWpKEBM1p8EacimgQ3ZRIUrjsKlXQGrOXoSBN9g+uJ2aspipd9lrGMJCw6GiH2vFt+sdFKw3
 XfGLf7TZbg3h/ClZbFvtMsHeMOZzjW+fQJ5ySNkhhhs84ITZfVb5rRj7d2yD8B6zNbFNkN20XA
 +cjGDiFyR/qf/WTQsyRPX8aM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 06:18:21 -0700
IronPort-SDR: PxW9nuiZ7KDBZF2jVI2d0GeIeoWRVIkygl9u/a2SiEFR5zLIQdbeOV6vN3eHVZgCjRs6KTczOJ
 1/wSisd9udjYsjBnfgYRoXbUmB4LQAQKJ9E/po0yzDamEJV68viXxNciFUZsH5f1p4EQjl2Ym0
 p4wDQDmA3huDnLebGOeBvKd5Cny7qtLloxRN5jtQcy5RDIvnxRelqyGW2Qa7YeP4iuUJyxlphm
 VcndSU3MD/iAl9HAQJYgrZ7fq17jV8DTzh6+s3w0yHvIjzrhvPJckkXNuUYCgkpgcuGgZ+xqgt
 P1U=
WDCIronportException: Internal
Received: from bxygm33.sdcorp.global.sandisk.com ([10.0.231.247])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Mar 2021 06:37:47 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 2/2] mmc: block: Update ext_csd.cache_ctrl if it was written
Date:   Mon, 22 Mar 2021 15:36:45 +0200
Message-Id: <20210322133645.4901-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322133645.4901-1-avri.altman@wdc.com>
References: <20210322133645.4901-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The cache function can be turned ON and OFF by writing to the CACHE_CTRL
byte (EXT_CSD byte [33]).  However,  card->ext_csd.cache_ctrl is only
set on init if cache size > 0.

Fix that by explicitly setting ext_csd.cache_ctrl on ext-csd write.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index a93c66aa91db..4c816d001ac1 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -571,6 +571,14 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 		main_md->part_curr = value & EXT_CSD_PART_CONFIG_ACC_MASK;
 	}
 
+	/* Make sure to update CACHE_CTRL in case it was changed */
+	if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_CACHE_CTRL) &&
+	    (cmd.opcode == MMC_SWITCH)) {
+		u8 value = MMC_EXTRACT_VALUE_FROM_ARG(cmd.arg) & 1;
+
+		card->ext_csd.cache_ctrl = value;
+	}
+
 	/*
 	 * According to the SD specs, some commands require a delay after
 	 * issuing the command.
-- 
2.25.1

