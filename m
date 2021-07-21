Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F117C12002
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 14:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595F961248
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 14:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbhGUNYn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 09:24:43 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47101 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238104AbhGUNYn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 09:24:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id CACDF5C021E;
        Wed, 21 Jul 2021 10:05:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 21 Jul 2021 10:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=S04MF6zj1+jSv
        KvaEdcEwrJ4APQiKSx1kQMnQoAg/P8=; b=J/HdFRdSo+bJMZEVf1c54acEvY9VL
        ZQiL+0sAs7tIUGj3ikf8M93aLT3kkq7c5DZrmDp25whCjI7Ix+f/glwPfPf9k9nw
        wcbwJIqhZGhVxQ4V9O43lcZhnfhb3rp75mHYu74/kAazMLmwjnfkJKmBpYxUOj3R
        eHIEZcEgBl2wcps0gN841atTI+Ev762aHcJQjYPDdgrKCJv3pHZaTtmqSHRCT6Xv
        DJJL/dKDb76uhOz7BwtOW/5oV8coSmjgdyb+EgtqxEBv5NrM3nJA8zq3PQeHNHGZ
        NyFoRrsEljax89KDdlRpzWMYTXrx9Ti5/4SEE59Tl53HuoAz/SX4OGTjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=S04MF6zj1+jSvKvaEdcEwrJ4APQiKSx1kQMnQoAg/P8=; b=fsKrrieS
        /wCJniDV5D0/tY9No/yMv0sz7vyrsVZzfEIt8txYUXr7iSycf9EphNl/XUc1chEL
        EqSltFg5WZGCCyARU/EcZfbK75WKHITkmdsQ5Vlbvd6iqRQJG78Zjdht/ShA8Sfd
        CduJZDD7xrZKNloISFPZQ21nB/BrMu4ZPtAZzy1gP4UfBOuI426plKampM7MmAh/
        i0ULMsEXxGaEImbGc8OsK5Z40/rvaXYGaB9QM515WgKIEQ/raEDeVh2DHdpoeWYh
        i6kR88n2FpnmYrfa+8ALIV7v+/t7jZVvd9x91eT3mTmmCSCuYERUN0mrvlNO+Kd5
        XTNLGe1nBdNFYw==
X-ME-Sender: <xms:nyn4YDPn5k9r3uaq6M71fnPwe0yiXIA62-ZKnCHHo2VTaMNHqE5Bkw>
    <xme:nyn4YN9eAh53evaQ8V__El0zehU7UePxTKGmlNXBxnkexy3J3ZN-U0wcKaiD-rTL3
    dA67JtHMFG-fZyQA44>
X-ME-Received: <xmr:nyn4YCQXM7cFQfkux-0lgeKrd7knSJda0kOlX58UCQpSGlpBDbAca9lYMhcml9Ufx1gCYx-wdjUq7KFDw-a-Bpb-Pq6bwLVlf5Y0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfeeggdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    evohgrshhtrghlqdfhgeduvddqtddvucdludehtddmnecujfgurhephffvufffkffojghf
    ggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgi
    himhgvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvghrnhepveejieejtdevgfff
    gfejuefggfeutdelteekgeetueeftddutddtgfffhffgueffnecuffhomhgrihhnpeguvg
    hvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:nyn4YHuenrmef8d_k63iXbxY9dE9g_jzyT-F3kLvThQRSTgxFlGtQg>
    <xmx:nyn4YLfAk4qHxfDW08cg46xnDFEBMC-P2cppqqYTz7AtLlXIBbT5SQ>
    <xmx:nyn4YD0UqJsDrhXN2VrkqjV_9zvsGmHqSSIIwhkI-8Ei5ykMNjrwNw>
    <xmx:nyn4YKwQJh5EgDtMH7CWUvu3UFYlYBKERuEMKNaRjtAExykqQUws4Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jul 2021 10:05:19 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 25/54] dt-bindings: mmc: Convert MMC Card binding to a schema
Date:   Wed, 21 Jul 2021 16:03:55 +0200
Message-Id: <20210721140424.725744-26-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210721140424.725744-1-maxime@cerno.tech>
References: <20210721140424.725744-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

MMC Cards can have an optional Device Tree binding to add
non-discoverable properties.

Now that we have the DT validation in place, let's convert the device
tree bindings for that driver over to a YAML schema.

Some of these properties were already described in the MMC controller
binding, even though they are not generic and do not apply to any
device, so we took the occasion to fix this.

Cc: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 .../devicetree/bindings/mmc/mmc-card.txt      | 30 ------------
 .../devicetree/bindings/mmc/mmc-card.yaml     | 48 +++++++++++++++++++
 .../bindings/mmc/mmc-controller.yaml          |  6 ---
 3 files changed, 48 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-card.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-card.yaml

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.txt b/Documentation/devicetree/bindings/mmc/mmc-card.txt
deleted file mode 100644
index 8d2d71758907..000000000000
--- a/Documentation/devicetree/bindings/mmc/mmc-card.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-mmc-card / eMMC bindings
-------------------------
-
-This documents describes the devicetree bindings for a mmc-host controller
-child node describing a mmc-card / an eMMC, see "Use of Function subnodes"
-in mmc.txt
-
-Required properties:
--compatible : Must be "mmc-card"
--reg        : Must be <0>
-
-Optional properties:
--broken-hpi : Use this to indicate that the mmc-card has a broken hpi
-              implementation, and that hpi should not be used
-
-Example:
-
-&mmc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins_a>;
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <8>;
-	non-removable;
-
-	mmccard: mmccard@0 {
-		reg = <0>;
-		compatible = "mmc-card";
-		broken-hpi;
-	};
-};
diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
new file mode 100644
index 000000000000..aefdd8748b72
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/mmc-card.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MMC Card / eMMC Generic Device Tree Bindings
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+description: |
+  This documents describes the devicetree bindings for a mmc-host controller
+  child node describing a mmc-card / an eMMC.
+
+properties:
+  compatible:
+    const: mmc-card
+
+  reg:
+    const: 0
+
+  broken-hpi:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Use this to indicate that the mmc-card has a broken hpi
+      implementation, and that hpi should not be used.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: true
+
+examples:
+  - |
+    mmc {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        card@0 {
+            compatible = "mmc-card";
+            reg = <0>;
+            broken-hpi;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 25ac8e200970..513f3c8758aa 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -333,12 +333,6 @@ patternProperties:
               subnode describes. A value of 0 denotes the memory SD
               function, values from 1 to 7 denote the SDIO functions.
 
-      broken-hpi:
-        $ref: /schemas/types.yaml#/definitions/flag
-        description:
-          Use this to indicate that the mmc-card has a broken hpi
-          implementation, and that hpi should not be used.
-
     required:
       - reg
 
-- 
2.31.1

