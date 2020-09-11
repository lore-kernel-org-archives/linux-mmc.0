Return-Path: <SRS0=SgEP=CU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D002C43461
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 07:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14A920829
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 07:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="iS1elgHb";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TvMKmdw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgIKHpo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:45:44 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:42671 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbgIKHpd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Sep 2020 03:45:33 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C29E1C38;
        Fri, 11 Sep 2020 03:45:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 11 Sep 2020 03:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=wCrir7Nj5a6Sf
        jiU7ykDZoyQRg2FmImk7NG1eiROHdc=; b=iS1elgHbtQSPnOb33kz9zoK+IaPsq
        UCE2uaZnMVrKLnayOH4az+rcut4AO7S4jCewIwt0f1Ng4mZTlVNJRXIdxPKQ9PYQ
        pQ9GeVjDld2ergKtlGSgpYs52JXObYv0kHMe3bvCZjivugoEX5ATZxEK0SCs8WuD
        blUeQ1UZZPA0ZsLG/HxYQj1i0p4OXWTyeuRe0F3HOX2EFOzc2O7zXXMeyHsWYqju
        mniSv6d6Ycp01dS2FqYW3YdC1l5ZKcU1cUnFgrAoipm5m/Omh0HKo7t0tCfGy3wt
        PpkEGhBklJeBXm4dQmRxzFBIx9US53HlX9zcNBh4XLjKrSf8LveFWUVHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=wCrir7Nj5a6SfjiU7ykDZoyQRg2FmImk7NG1eiROHdc=; b=TvMKmdw9
        DVeVOIGMluHTvnEZSqDjcmgxs1wlp3p5okgKRnA47slWJddjIzDLCO87JxT07zNl
        DdNgZHi+zPJsXVDUoPBsCwCA9XIDd6qNkqgmQvF/hJDtcSDLAiRd7MckCQt86nVC
        48R96nUF+6KBMdjXdyQGTmTeaog/5GTtAoOVIhwf/ri5dPvm7WVtIsEPsuOquIdR
        IlfQaPT77Q1M1rwngI2589HsAKMNbFWS8QTIvut4drtSw0aPpCC+PU1eftUPNJWN
        ZuOoPGdZUiZmPY4e4fUQSIG9Wq5MX8GGI/tftMSQh5Xj2eeSmJ1uIOyu5/4w+6v0
        Kgt1czQxRnc6eg==
X-ME-Sender: <xms:HCtbX1XNQJvO-ODfsNth057vjEoDIymWKZJ5nkWtYGyyUL69BzV-SA>
    <xme:HCtbX1nnY5shKT2eegAWAt7c6Ns4LUBj0p1XutlufqDnpLm3q5fHKqa4opH-tUHVt
    Opj2nykNN9GwHSG6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehkedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfies
    rghjrdhiugdrrghuqeenucggtffrrghtthgvrhhnpeejgfdvveehteekveeggeellefgle
    etteejffelffdvudduveeiffegteelvefhteenucfkphepudegrddvrddutdelrdekheen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurh
    gvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:HCtbXxbPz1aWdHxXNN9GA3OtP2pbVqrdKSBg0jHcpQamTOIK-radfA>
    <xmx:HCtbX4VctOuaEhBnAoHGqfPm3AVkgGcAzi8DtHpx5EgR2QczZSl9iw>
    <xmx:HCtbX_mmykPnTIB5XApdjSTY1uB4rbfpLQgjaPBlT65UtyiOyyeqmQ>
    <xmx:HCtbX4Dy2mrbSEgiadwJ9QeLLynofN80aAQ-z7Wp7AIaRa_61U68DA>
Received: from mistburn.lan (ppp14-2-109-85.adl-apt-pir-bras32.tpg.internode.on.net [14.2.109.85])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7725B3064685;
        Fri, 11 Sep 2020 03:45:29 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org, joel@jms.id.au,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt: bindings: mmc: Add phase control properties for the Aspeed SDHCI
Date:   Fri, 11 Sep 2020 17:14:50 +0930
Message-Id: <20200911074452.3148259-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200911074452.3148259-1-andrew@aj.id.au>
References: <20200911074452.3148259-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add properties to control the phase delay for input and output data.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
index 987b287f3bff..d7b605968c8a 100644
--- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
@@ -61,6 +61,14 @@ patternProperties:
       sdhci,auto-cmd12:
         type: boolean
         description: Specifies that controller should use auto CMD12
+      "aspeed,input-phase":
+        $ref: '/schemas/types.yaml#/definitions/uint32'
+        description:
+          The input phase delay value.
+      "aspeed,output-phase":
+        $ref: '/schemas/types.yaml#/definitions/uint32'
+        description:
+          The output phase delay value.
     required:
       - compatible
       - reg
-- 
2.25.1

