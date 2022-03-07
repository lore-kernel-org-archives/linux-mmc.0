Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C705C433FE
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Mar 2022 14:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243261AbiCGOfi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Mar 2022 09:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243260AbiCGOfi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2022 09:35:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 099DC7D031;
        Mon,  7 Mar 2022 06:34:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB98CED1;
        Mon,  7 Mar 2022 06:34:42 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.196.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD7A53F66F;
        Mon,  7 Mar 2022 06:34:40 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        George Hilliard <thirtythreeforty@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 07/14] dt-bindings: mmc: sunxi: add Allwinner F1c100s compatible
Date:   Mon,  7 Mar 2022 14:34:14 +0000
Message-Id: <20220307143421.1106209-8-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307143421.1106209-1-andre.przywara@arm.com>
References: <20220307143421.1106209-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jesse Taube <mr.bossman075@gmail.com>

The Allwinner F1C100 series contains two MMC controller blocks. From
comparing the data sheets, they seem to be compatible with the one used
in the Allwinner A20: the register layout is the same, and they use the
same separate sample and output clocks design.
The only difference is the missing reset line in the A20 version, but
both the binding and the Linux driver make this optional, so it's still
a fit.

Add the new SoC specific name and require it to be paired with the A20
fallback name, as this is all the driver needs to care about.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
index 4f62ad6ce50c..76137132500d 100644
--- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
@@ -55,6 +55,9 @@ properties:
       - items:
           - const: allwinner,sun50i-h616-mmc
           - const: allwinner,sun50i-a100-mmc
+      - items:
+          - const: allwinner,suniv-f1c100s-mmc
+          - const: allwinner,sun7i-a20-mmc
 
   reg:
     maxItems: 1
-- 
2.25.1

