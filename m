Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C205C433E3
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 13:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BA720738
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 13:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Z/1Jlk7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgHYNqK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:46:10 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:40528 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgHYNp6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Aug 2020 09:45:58 -0400
IronPort-SDR: kDSN0DkYWghQWgQQkhZGvNtgXF/NABg78EzK4u2OZtqgeHwO06ZQsN2Qu0sk1HHyix1x+LUn+T
 LUm4qvzMRbkE8grGO7DJ5xpsrRUSrr0JY7DjFGRBSfwg/VL2uOIRbxBVEQ6qu0xaNyflxmA5QK
 VBAxv80SCTBVZ2l/rHeU1DhWJn7qeEoIv0LjMXzWNgmpWyxHtgofKRAyA/g3LYAMQzTUHq4Doc
 hzRFmEV9EUAlx22LNB2vzqEsnbCd5Xpb3fTmGGQTEkoeiyHPAPD1H8IAhyki0nb6PZWh0ni3K9
 TdY=
X-IronPort-AV: E=Sophos;i="5.76,352,1592863200"; 
   d="scan'208";a="13592259"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 25 Aug 2020 15:45:34 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 25 Aug 2020 15:45:34 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 25 Aug 2020 15:45:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598363134; x=1629899134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Kf6ual87ynJDYkTPylmWVOktoJJ6W4UH22mbaq4n/Kc=;
  b=Z/1Jlk7MXlCJplMtcnE+rXN7G13o8aSYcEhQIJLODmj1oBpKALnGpTGt
   qupiHrbqX+h1Az+Fn20ppLOqoTJ61/G0kvN5BLkyS5ZGP/nR8qiBt4yuZ
   rDjGSkKXiesZ7JQy3jE1uprJiGowiTbZ05RXAnMpxOoeyimjK03OTBNwT
   lGXhnqTM5M+5IE2UkcSZJSF3wEpGckzkffCtECo3PkOEdJwjwxtvjQAj7
   Y9lZS2lXPoXqqSLyx2SWIk/JAOqvQRSyaEcGLMS81zO6P4jUu0E2GKwV+
   xCT8V0gpI2Y4ADTJcr6++xIxejdMNoISBo2SeOnvfFyVSm2o2oSQdDxs8
   g==;
IronPort-SDR: o4ujDa1t/5pkBVSaxybA6FMbxtryVjsnmPDVhisg3nsc6fTMJ90Spp+Lz8RtRS+Kmz5ZEl6IJM
 xCr/1D02Z66cj3RH50oYvXpZ/cPV8voDvxBxncTzSihynY3me2Buyd8Sak0cQxflM9jjqqD6mH
 51aPPh7YO0VUQSv+aZnd7mRaGOaGq5kZvrphSdIGgd2BsyBI+5Wnu+TPHs+deBM7hgA10LuL9E
 bej6jK8oOj05TO/0K6aJgcFI95h2Ia8pArSKiAat/9OC7Dpv8RSIvGIqcWQiHb0ibeDtlHE6+k
 SOk=
X-IronPort-AV: E=Sophos;i="5.76,352,1592863200"; 
   d="scan'208";a="13592258"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 25 Aug 2020 15:45:34 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id AF250280070;
        Tue, 25 Aug 2020 15:45:34 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH mmc-next v3 2/2] mmc: allow setting slot index via device tree alias
Date:   Tue, 25 Aug 2020 15:44:41 +0200
Message-Id: <20200825134441.17537-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825134441.17537-1-matthias.schiffer@ew.tq-group.com>
References: <20200825134441.17537-1-matthias.schiffer@ew.tq-group.com>
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

This is a rebased and slightly cleaned up version of
https://www.spinics.net/lists/linux-mmc/msg26588.html .

Based-on-patch-by: Sascha Hauer <s.hauer@pengutronix.de>
Link: https://lkml.org/lkml/2020/8/5/194
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

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

