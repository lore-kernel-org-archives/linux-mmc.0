Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EABC63798
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 06:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C94F120756
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 06:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Alh0lgjk";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h/xw1DKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgKWGav (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 01:30:51 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54897 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725287AbgKWGav (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2020 01:30:51 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4BC025C00E1;
        Mon, 23 Nov 2020 01:30:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 23 Nov 2020 01:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=R9UFuHjtAK1qQ
        YI8cmha4Thpo1402hfejrmvtlGfR4Y=; b=Alh0lgjkO4bfrp7qVq4o+Ca9an7iM
        vJtnZ8NskadtMFu6Y24s0BYZKg9yF0CSpPPf1bg5LKiSCkdP5/bgYgiIvkjnrhwk
        wwouJxfJa0zWnJfDUTpUvG08IxTieZBsYdcl052WH4jjSBeG25l01oHIrzdVx/eQ
        AbWUZPLgq4f8sG43Jmx0KpijObnhdOQbUxQvdV6HbVbD6ZzVi/mW7vfkO6FnJKJc
        c+FSArxgDKyR4dOtR6GJzEYA/EX9lU0fGKr7y+PrJG8igABbxcha077ROxgmOA84
        EafBP2O83bFYtM+4Ct+mnIVXSv86MdRb/qQBudXkooVJte2HICn0Bfazw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=R9UFuHjtAK1qQYI8cmha4Thpo1402hfejrmvtlGfR4Y=; b=h/xw1DKA
        h13Fzmqm89P65yyArRzLOKysgizzUezLkDIBHBbpKikxuT2I+XXDTEreuQCzPicq
        /c9HxPz79tHM073l00IpB5cDAhKrdIqC2JUAOc8L6efA6g5duALgweCWhMCtgj1A
        uhfhtQFvJJT56ozYKZ/HklAI1x0LT7VrL54YzUfPNAZ7SQrhAGinHvSBp9dpvLfS
        np2TgeTBN0C9rFjLWA4JK5u+OvFzmtI5QR0QxVf2mxs1Q24vH9TrbBnigo/CxZSf
        yA1kz6hdAnkyBo4cAMa31+Cd8kK587vbn/Cpw6GxU098Xz8+cDGlyeqNuwR7JKNU
        99be9d8lpeSmRw==
X-ME-Sender: <xms:Gle7Xx5YR4ENmBGQkqahZLmlnvZ4MkrGJXNwXLs30ErVv7R7N3JFXw>
    <xme:Gle7X-6UKayXpW8JEbtuXCrnc9CRaeNfEeBufCzH2FKygvfDj0XzX3yCmAyuKGysC
    ON1rhsZ2hCqmlnA4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeghedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppedvtdefrdehjedrvddtkedrudeg
    ieenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
    gurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:Gle7X4eVSlCxgKDRcOMc4DnP9U1IBqcez-0L5fY2KT24pS3sie2ptw>
    <xmx:Gle7X6JgcGHDd1qYUP-tWtCZG3-JxLDLAhqjw4yWoUIizvr9FYl7NA>
    <xmx:Gle7X1J1RkF1Pa6zRotcEVia-MebtTcCVU6fO4kDY0fyKBr3hr_nIQ>
    <xmx:Gle7X6o2-rfpMnwBPE5_mpEa8Oo6wByVsRDbE3IWDdz_81xlGVCSHQ>
Received: from localhost.localdomain (203-57-208-146.dyn.iinet.net.au [203.57.208.146])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1B13E3064AA7;
        Mon, 23 Nov 2020 01:30:45 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     robh+dt@kernel.org, joel@jms.id.au, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ryan_chen@aspeedtech.com
Subject: [PATCH v3 3/3] ARM: dts: rainier: Add eMMC clock phase compensation
Date:   Mon, 23 Nov 2020 17:00:04 +1030
Message-Id: <20201123063004.337345-4-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201123063004.337345-1-andrew@aj.id.au>
References: <20201123063004.337345-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Determined by scope measurements at speed.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 21ae880c7530..ab8d37d49f30 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -186,6 +186,7 @@ &pinctrl_emmc_default {
 
 &emmc {
 	status = "okay";
+	clk-phase-mmc-hs200 = <180>, <180>;
 };
 
 &fsim0 {
-- 
2.27.0

