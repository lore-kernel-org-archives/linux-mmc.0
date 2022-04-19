Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3149C4321E
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Apr 2022 02:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345161AbiDSCtG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Apr 2022 22:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345176AbiDSCtC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2022 22:49:02 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CCA222A2
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2022 19:46:18 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2E3142C0775;
        Tue, 19 Apr 2022 02:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1650336376;
        bh=IapzqfmOH6ZkWiJ7DCEzdYzOLcumquaJvcJruZwLsXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GvZ5/lQvZqhDBAHHKorwLnPovC7yXOMlGZeb68nez7MOyvuf2xlEt+okvQC0AXH/x
         e9B7OOHiLWuFIv+QPA5OHmJ3yI31G/8kJac8TMbUTxIdvxiBQF8YyJxa2HhZfCVT4w
         1HQcbJdsJ1+9LUJe9abSYa1lKGXWQ0Jrje2jubw1Mwj6xVER7X7qvlwIUf5WCW36Q9
         pfc9EOX10grEqHGPxxgbZfDmdDjGU6qKkmrpfeDndoa40lXPjvFni9ql6LoXSvEKdm
         5gineOesOJ6rX+zIIJ8OmrfcZI3iwv1sA0R63q4PdRXjVew1vGZP+LWJ2H6RWk9CkF
         Mev6UeOsuMGrA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B625e22780000>; Tue, 19 Apr 2022 14:46:16 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 0C35713EE37;
        Tue, 19 Apr 2022 14:46:16 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 666612A2679; Tue, 19 Apr 2022 14:46:14 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, adrian.hunter@intel.com,
        nico@fluxnic.net
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 2/4] ARM: dts: dove: Update sdio-host node names to match schema
Date:   Tue, 19 Apr 2022 14:46:09 +1200
Message-Id: <20220419024611.1327525-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419024611.1327525-1-chris.packham@alliedtelesis.co.nz>
References: <20220419024611.1327525-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=RL7N4Lq+ c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=z0gMJWrwH1QA:10 a=9fF3QZy3S0T7Ev_h1A0A:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Update the node names of the sdio-host@ interfaces to be mmc@ to match
the node name enforced by the mmc-controller.yaml schema.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - None

 arch/arm/boot/dts/dove.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 89e0bdaf3a85..d81562eac7aa 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -337,7 +337,7 @@ channel1 {
 				};
 			};
=20
-			sdio1: sdio-host@90000 {
+			sdio1: mmc@90000 {
 				compatible =3D "marvell,dove-sdhci";
 				reg =3D <0x90000 0x100>;
 				interrupts =3D <36>, <38>;
@@ -380,7 +380,7 @@ ethphy: ethernet-phy {
 				};
 			};
=20
-			sdio0: sdio-host@92000 {
+			sdio0: mmc@92000 {
 				compatible =3D "marvell,dove-sdhci";
 				reg =3D <0x92000 0x100>;
 				interrupts =3D <35>, <37>;
--=20
2.35.1

