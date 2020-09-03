Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB93EC433E2
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 01:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 348B2206E7
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 01:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="klyZE/Bj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgICBUj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 21:20:39 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:40952 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgICBUg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2020 21:20:36 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EB6A984487;
        Thu,  3 Sep 2020 13:20:30 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1599096030;
        bh=ZcX7TAd0fNPu0z2dBLatCyLAmXlOHgvmAtrIUZg0cdE=;
        h=From:To:Cc:Subject:Date;
        b=klyZE/Bjgl6xmEAD/lbHNYkNhyn3Hj4V1NjZevgr2oKO6gRKV/hE1JQdU6UJH3fDS
         rSe3dV3xu0qKSDtlAJOvmufsBokG0EgxB1gyqfQBmEd37SnuuE0KO/2+iKwXGe4Yfh
         X8gLZhHAmeSdEvDXhmz+awnoyze5rFoUvl6zwHXqy61bwDygUxsj0mbIPkE7AS+4l1
         JBero81gxM+bVzuhAbmkDKGNfd+4UYOzUErfWIcE/CyEOZ17nUQmFiz96Z+iYQXnEY
         Z0nuDGPhLqq9rxuPW2hmcpZP6yex23yTY+xmDXEKOAgc6Qt8KG6mzlqfOp7s5RWgRs
         iNpc5CYkH5TRA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f5044dc0000>; Thu, 03 Sep 2020 13:20:28 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id DF61D13EEB7;
        Thu,  3 Sep 2020 13:20:29 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 9EDC0280060; Thu,  3 Sep 2020 13:20:30 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org, yinbo.zhu@nxp.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2] mmc: sdhci-of-esdhc: Don't walk device-tree on every interrupt
Date:   Thu,  3 Sep 2020 13:20:29 +1200
Message-Id: <20200903012029.25673-1-chris.packham@alliedtelesis.co.nz>
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
on every esdhc interrupat. Instead of doing this record the quirk in
struct sdhci_esdhc and lookup the struct in esdhc_irq.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
I found this in passing while trying to track down another issue using ft=
race.
I found it odd that I was seeing a lot of calls to __of_device_is_compati=
ble()
coming from esdhc_irq() (the fact that this interrupt is going off on my =
board
is also odd, but that's a different story).

Changes in v2:
- add quirk_trans_complete_erratum to struct sdhci_esdhc so all the dt ha=
ndling
  is taken care of in esdhc_init.

 drivers/mmc/host/sdhci-of-esdhc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-o=
f-esdhc.c
index 7c73d243dc6c..45881b309956 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -81,6 +81,7 @@ struct sdhci_esdhc {
 	bool quirk_tuning_erratum_type2;
 	bool quirk_ignore_data_inhibit;
 	bool quirk_delay_before_data_reset;
+	bool quirk_trans_complete_erratum;
 	bool in_sw_tuning;
 	unsigned int peripheral_clock;
 	const struct esdhc_clk_fixup *clk_fixup;
@@ -1177,10 +1178,11 @@ static void esdhc_set_uhs_signaling(struct sdhci_=
host *host,
=20
 static u32 esdhc_irq(struct sdhci_host *host, u32 intmask)
 {
+	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
+	struct sdhci_esdhc *esdhc =3D sdhci_pltfm_priv(pltfm_host);
 	u32 command;
=20
-	if (of_find_compatible_node(NULL, NULL,
-				"fsl,p2020-esdhc")) {
+	if (esdhc->quirk_trans_complete_erratum) {
 		command =3D SDHCI_GET_CMD(sdhci_readw(host,
 					SDHCI_COMMAND));
 		if (command =3D=3D MMC_WRITE_MULTIPLE_BLOCK &&
@@ -1334,8 +1336,10 @@ static void esdhc_init(struct platform_device *pde=
v, struct sdhci_host *host)
 		esdhc->clk_fixup =3D match->data;
 	np =3D pdev->dev.of_node;
=20
-	if (of_device_is_compatible(np, "fsl,p2020-esdhc"))
+	if (of_device_is_compatible(np, "fsl,p2020-esdhc")) {
 		esdhc->quirk_delay_before_data_reset =3D true;
+		esdhc->quirk_trans_complete_erratum =3D true;
+	}
=20
 	clk =3D of_clk_get(np, 0);
 	if (!IS_ERR(clk)) {
--=20
2.28.0

