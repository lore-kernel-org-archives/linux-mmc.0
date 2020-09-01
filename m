Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B596C433E6
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 08:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 644EB2071B
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 08:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Jfr9Cnwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgIAIuc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:50:32 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:47171 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgIAIu3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 1 Sep 2020 04:50:29 -0400
IronPort-SDR: DntSZN5tGB4ASbg9nzfAw3YQJ+xIADwOOiv8/XVySIDrLfh5tTFgosz8kEAdlCfr6fzrCV1dlP
 75cOHyv5u6tc/HdHQaNlonF7HeXlZ969m0/Mm2Ue5roqmdKFdujlzuRL5kXUDzqAIVFr7S1r/t
 d3b2hM7o+gJ1gNnQNuD2bVEjg4MOeFyKIrNWoT9HlwtsuXMPzP610wqX5ifuUqFM4KMbiwXlPM
 JYGRR8VoEDIrQNA/wVQycQGoVx7wP34pWI1ZuvLijGSgp988YFAZF8ywz++IBuBEpg/UvwNviv
 aRQ=
X-IronPort-AV: E=Sophos;i="5.76,378,1592863200"; 
   d="scan'208";a="13677468"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 01 Sep 2020 10:50:24 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 01 Sep 2020 10:50:24 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 01 Sep 2020 10:50:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598950224; x=1630486224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=F5d5x7a68Mh3YNvlXxZUiOS79u4ypZUgcPmdt4Ds/hM=;
  b=Jfr9CnwhvSf8sZxF/3/Vs+H0zhwmemAYQ65ebSxF2O7DzCeT7QDAmYaK
   cmRjZbexmBj7iAYyVgMVpPyrkCXAkKldPe4DpZyAOV0RuLkSSgfmZ9h95
   V2dej/ypB/+d8qIOpybuknyLx+HfDQeR8ClX3+37yWS4zj3aTcvrP5T69
   irRM/Z+NSXO2S0j46t3AoeTOVM7DOKAVXeDrzLuIBB4mzkCt4d0tolpv4
   xPqGSxgni94SfQ3/sOexluOflGk5WLvahY15VJmpoxqdCSjApziRYV2AK
   +mls7Nn67JpPs5dW+Eo2ssu+9qWG5rVYnmrFMGeIohYO816jDzvIuVVNZ
   A==;
IronPort-SDR: Z5fhJvCA+6HsG/4wH70+J6SxeVrpPa7O/CKZwE4AJxSOAc2ZTTh+OG/e6IRFaMtW12XqGi6Nwt
 PQdYMec6xxfMrCaVrUa4ow0jOJaj2OM59kGwh4m5ouTbMPK6PDCGARW3LGdoICio4HvSJHF1Tt
 472M5ejoQ3Mv3hcUFDTl1VMsG/cdZZCa5bs7EcnWIwzMo0LT9bjwHRrGK/7xXSp1vI+llFi1nS
 A8XEBfa1+CXFb5pTSLJrL3u2/sqMbb8Zwj8ypcveduU8Zh/pi1MOBAl6UMcHTc8t23P1mnXGgY
 jkU=
X-IronPort-AV: E=Sophos;i="5.76,378,1592863200"; 
   d="scan'208";a="13677467"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Sep 2020 10:50:24 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 3C04E280070;
        Tue,  1 Sep 2020 10:50:24 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH mmc-next v4 2/2] mmc: allow setting slot index via device tree alias
Date:   Tue,  1 Sep 2020 10:50:04 +0200
Message-Id: <20200901085004.2512-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901085004.2512-1-matthias.schiffer@ew.tq-group.com>
References: <20200901085004.2512-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As with GPIO, UART and others, allow specifying the device index via the
aliases node in the device tree.

On embedded devices, there is often a combination of removable (e.g.
SD card) and non-removable MMC devices (e.g. eMMC).
Therefore the index might change depending on

* host of removable device
* removable card present or not

This makes it difficult to hardcode the root device, if it is on the
non-removable device. E.g. if SD card is present eMMC will be mmcblk1,
if SD card is not present at boot, eMMC will be mmcblk0.

Alternative solutions like PARTUUIDs do not cover the case where multiple
mmcblk devices contain the same image. This is a common issue on devices
that can boot both from eMMC (for regular boot) and SD cards (as a
temporary boot medium for development). When a firmware image is
installed to eMMC after a test boot via SD card, there will be no
reliable way to refer to a specific device using (PART)UUIDs oder
LABELs.

The demand for this feature has led to multiple attempts to implement
it, dating back at least to 2012 (see
https://www.spinics.net/lists/linux-mmc/msg26586.html for a previous
discussion from 2014).

All indices defined in the aliases node will be reserved for use by the
respective MMC device, moving the indices of devices that don't have an
alias up into the non-reserved range. If the aliases node is not found,
the driver will act as before.

This is a rebased and cleaned up version of
https://www.spinics.net/lists/linux-mmc/msg26588.html .

Based-on-patch-by: Sascha Hauer <s.hauer@pengutronix.de>
Link: https://lkml.org/lkml/2020/8/5/194
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v4:
- minor adjustments to commit message

v3:
- remove unneeded mmcblock changes
- remove most helper functions to simplify code
- extended commit message

v2:
- fix missing symbols for modular mmcblock



 drivers/mmc/core/host.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index c8fae6611b73..96b2ca1f1b06 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -376,6 +376,20 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
 }
 EXPORT_SYMBOL(mmc_of_parse_voltage);
 
+/**
+ * mmc_first_nonreserved_index() - get the first index that is not reserved
+ */
+static int mmc_first_nonreserved_index(void)
+{
+	int max;
+
+	max = of_alias_get_highest_id("mmc");
+	if (max < 0)
+		return 0;
+
+	return max + 1;
+}
+
 /**
  *	mmc_alloc_host - initialise the per-host structure.
  *	@extra: sizeof private data structure
@@ -387,6 +401,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 {
 	int err;
 	struct mmc_host *host;
+	int alias_id, min_idx, max_idx;
 
 	host = kzalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
 	if (!host)
@@ -395,7 +410,16 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	/* scanning will be enabled when we're ready */
 	host->rescan_disable = 1;
 
-	err = ida_simple_get(&mmc_host_ida, 0, 0, GFP_KERNEL);
+	alias_id = of_alias_get_id(dev->of_node, "mmc");
+	if (alias_id >= 0) {
+		min_idx = alias_id;
+		max_idx = alias_id + 1;
+	} else {
+		min_idx = mmc_first_nonreserved_index();
+		max_idx = 0;
+	}
+
+	err = ida_simple_get(&mmc_host_ida, min_idx, max_idx, GFP_KERNEL);
 	if (err < 0) {
 		kfree(host);
 		return NULL;
-- 
2.17.1

