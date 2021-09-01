Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87D7C4320E
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Sep 2021 09:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABCBF61057
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Sep 2021 09:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243541AbhIAJUq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Sep 2021 05:20:46 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34309 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243537AbhIAJUp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Sep 2021 05:20:45 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3534E5C023F;
        Wed,  1 Sep 2021 05:19:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 01 Sep 2021 05:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=wy2XVbAWMA69q
        zCJ8ybmycuy16YtyBZYcQTDiigV6PQ=; b=V/69tWz4xwwgWlHfN5xvM3pdVtgl9
        swyVkly0D0MHlVyyRbEQh4NpcVE2QeWrrxP1IkzpYCO7TkaFirFuiZ7yjZrWI1UP
        JOlEFIA2KlTWLb4+eejcA+K/4AONU+JhnCOTRk+A2au9TsKwnejVFXYrRzCYx3D8
        jV+8O1A2USgEjUaXIo+jAwep69tsjRK19rvIY0lRHRQiPnrUZSpvLO+epYBddORr
        GB5PYkOo6cd5UiofUDplXWKu2ajLUf8Y/j6rAcCQOdh8wjjOfGt8Ev2rwL9F+zIS
        SrH3IuPb6Jchq46PbAvUqJDtEK1dSUtesM2r95XAe3oFqzOe77TJPnPBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=wy2XVbAWMA69qzCJ8ybmycuy16YtyBZYcQTDiigV6PQ=; b=jXYmF0wQ
        acCNuuwCaBLktO9Zc062Vy1w2FeVUaKkcLIAz8xWw/FrbLTxo/JH2Q3N8xsVnYQG
        kn+oD5hcThIUHbvRpLGySOt7faoiXl6L6+fDNynxFlhlkRmcpjVAn7VbFyUDTjX4
        TnnXrx2obkM5MRz8zdou6b9LXh0q2efZ1RORlv3GppOdBgFikzX+RVOh9N7zYVOC
        xGusGKXTpw1kIOJDXEb8HZZMkADOE0ntJtmzRNQGQBPeWls2C4mlKClF16RZO4aZ
        DWtmn2gFs5/mnXteWhwvasrL/IMxPPn8mF2XZ9eNQEFpDXJqobCm+L5fYA8C7Vy3
        7YHrx0bl6x+G5Q==
X-ME-Sender: <xms:tUUvYVM8SrzFFZbHWW91rVAj86ymwzREVQA_Z4RrXRP8JZJK9fQqRA>
    <xme:tUUvYX9dSLwdrAanjycCfp2yHXjXQivJT3A6LQ4frFSov4hbRn8P2BcVx9cUZi__z
    HoRDOK097sMXoOrkzA>
X-ME-Received: <xmr:tUUvYURBRHmLrjKTa3XFvmGdl_WBZNqDjJ2Y4oKu4Xz8Tf63Xi08JU4pX_4Dljrltvi1MJD9O3b_1P5PZ49yaZLoJr_htYhnBZ-T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvfedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    govehorghsthgrlhdqhfeguddvqddtvdculdduhedtmdenucfjughrpefhvffufffkofgj
    fhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrg
    igihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeevjeeijedtvefg
    fffgjeeugffguedtleetkeegteeufedtuddttdfgfffhgfeuffenucffohhmrghinhepug
    gvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghm
    pehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:tUUvYRtORlyAhzbx8NsBfyJNSRBXyq0FyxLTAxI3ZYVLdIsZcysnCg>
    <xmx:tUUvYddHQxt7XkHVviSnANkggxNvZKYx9rHAPV7UyDds6c0BWKulzA>
    <xmx:tUUvYd1cSzuFJvvAFnD3D2oWwFoT0qUqNsDpleFxRmeTQqFCFWIfIA>
    <xmx:tUUvYcwCVp3OSZVlEjNp9jPS37JkZWlXRM-v3bnRmxVeMwFHwiWWKQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 05:19:48 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 30/52] dt-bindings: mmc: Convert MMC Card binding to a schema
Date:   Wed,  1 Sep 2021 11:18:30 +0200
Message-Id: <20210901091852.479202-31-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901091852.479202-1-maxime@cerno.tech>
References: <20210901091852.479202-1-maxime@cerno.tech>
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

Changes from v1:
  - Fixed additionalProperties
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
index 000000000000..b17d454442b3
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
+additionalProperties: false
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

