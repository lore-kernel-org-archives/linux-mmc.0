Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EE7C433E6
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 04:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D30B92068E
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 04:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="uqyTCtGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIBEGj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 00:06:39 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:39745 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgIBEGi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2020 00:06:38 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3F9A3806B5;
        Wed,  2 Sep 2020 16:06:34 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1599019594;
        bh=3JxEo6eTNBffOXernCImWkcLf0bwrfPKkskdwQJ2GQU=;
        h=From:To:Cc:Subject:Date;
        b=uqyTCtGbTgbN0aD5X5aILm0y1BRT8VLE67aIkwDSRu85zh1km/rBKEbsL/KkhWAEe
         YJVb1gslU8Lz8VkJmvnqYwOHLzyJsPMg8dSFBj8xjHEbMS5JSfLwekyzXSApjkiYT1
         3G3T9I8/7+mUAUf/8QyoJkqGaDc7gKfVdsNn/yCQB6P9RF3DOZ8UfmeKjk2iauxH2H
         rzttQYLc5wXfwk08zQZMihajuSh0D229g5fJYKfGynfq+ur0Zu2NVhX3CnT4jljjf1
         kGUYREvcquO2QJB23d11BZ4Tw6wkrj6q5dHAwxi+P8fARb0lamYJIU/EQw+RVAHYiO
         +LAGWZ+tcPd+A==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f4f1a480000>; Wed, 02 Sep 2020 16:06:34 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 704EF13EEBA;
        Wed,  2 Sep 2020 16:06:31 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id BCC59280060; Wed,  2 Sep 2020 16:06:31 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] mmc: sdhci-of-esdhc: Don't walk device-tree on every interrupt
Date:   Wed,  2 Sep 2020 16:06:23 +1200
Message-Id: <20200902040623.17509-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Commit b214fe592ab7 ("mmc: sdhci-of-esdhc: add erratum eSDHC7 support")
added code to check for a specific compatible string in the device-tree
on every esdhc interrupt. We know that if it's present the compatible
string will be found on the sdhc host. Instead of walking the
device-tree, go directly to the sdhc host's device and use
of_device_is_compatible().

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

I found this in passing while trying to track down another issue using ft=
race.
I found it odd that I was seeing a lot of calls to __of_device_is_compati=
ble()
coming from esdhc_irq() (the fact that this interrupt is going off on my =
board
is also odd, but that's a different story).

 drivers/mmc/host/sdhci-of-esdhc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-o=
f-esdhc.c
index 7c73d243dc6c..11c8c522d623 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1177,10 +1177,11 @@ static void esdhc_set_uhs_signaling(struct sdhci_=
host *host,
=20
 static u32 esdhc_irq(struct sdhci_host *host, u32 intmask)
 {
+	struct device *dev =3D mmc_dev(host->mmc);
+	struct device_node *np =3D dev->of_node;
 	u32 command;
=20
-	if (of_find_compatible_node(NULL, NULL,
-				"fsl,p2020-esdhc")) {
+	if (of_device_is_compatible(np, "fsl,p2020-esdhc")) {
 		command =3D SDHCI_GET_CMD(sdhci_readw(host,
 					SDHCI_COMMAND));
 		if (command =3D=3D MMC_WRITE_MULTIPLE_BLOCK &&
--=20
2.28.0

