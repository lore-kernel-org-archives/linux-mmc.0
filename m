Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49EEC433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 01:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD5F23A52
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 01:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgLHB2J (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Dec 2020 20:28:09 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52939 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgLHB2J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Dec 2020 20:28:09 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 862C25C01C2;
        Mon,  7 Dec 2020 20:26:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 07 Dec 2020 20:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=R9UFuHjtAK1qQ
        YI8cmha4Thpo1402hfejrmvtlGfR4Y=; b=CB4B5WBpU5PRnXh6D5dJU0njXoZ6L
        tUXluZyWKu+xmDzAl8s1iQc0jcIVinmfbvQdwDizxvm6CPcmsNl/4r/lsThRnQ8m
        fuw5DF0aU1A/TEDkQTfEXpg0I1FctmODsXqgjWYSJmoSCi0XtB96TSkuAr4w/Jn0
        KnndiOVgtHXOmzr1sXeaUJh3mTDViEENUkxKGDyn9IUIKRH5RFZ/O1MxoaX4t8By
        edWp34YMkFqozlw6SoIfjMsDEduKoz8y0wigzN8ngYFI8QStqfRgHSjgD7h797Tq
        H1lZg98rg+HHl0MDonM3B8rRMC7/iSGtdZM6gy8zqGClnOYZR/l6oG2hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=R9UFuHjtAK1qQYI8cmha4Thpo1402hfejrmvtlGfR4Y=; b=rnqoeTLi
        r4PnuJaD/397smYmsTkLYT3t3UBVMyQMZ/zU+Tph0w7lMvN3NfRBEsMrcFKVxo+I
        iXw4a1UyuipUU0SuqPAG0tkGplRKmtSnHHE7kQ3vxapaNCzGUr775F9tX3csxopc
        2lpqFPFfgPcZYaTyNzDapBEnSvQEZasjnMlOkHACLSuKm2O0Uj3ExLabQYdmd5VB
        p+lKwOM2r0nKX63qQUR5kmhqvAzxfTROmf7KZg42BheeExIuVchyu4H63303kptw
        aOup8k8UMS+CwQux0PMB90Dca5oI4zkS9n5879bP40MAXi0hMVK+eH1yXYFnYj8z
        3L0+M7UUDatKWg==
X-ME-Sender: <xms:W9bOX9ou9hefyOvzn3e4_sXUbmZqb580zlYmTdTABlvDB-p5aVCI5w>
    <xme:W9bOX_rq1-bSW9yiLqY59P0lLFZ8kByIUvoZyx3kEdRHUntrTUVY5RfMvahk-09qn
    az1-MpcRmd8qDsUsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejhedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppedvtdefrdehjedrvddtkedrudeg
    ieenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
    gurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:W9bOX6MA5KiyQxjPr2tryr71LYy0UTEt6aeKSxyScBkQErPcOP90Bg>
    <xmx:W9bOX44jzvZYxVHOXYkAPCE9oldodWnkXAUPYiievg5BzgwatIluKw>
    <xmx:W9bOX8574nAlS1Lqve19-5F1OT_aJr1HOYyu2rIMdJOL_Qm_41J48w>
    <xmx:W9bOX7YnWng6L6RYUlGEX2KBQjg8xaSdjwIvi6vMQ2_TotI8MsoGCw>
Received: from localhost.localdomain (203-57-208-146.dyn.iinet.net.au [203.57.208.146])
        by mail.messagingengine.com (Postfix) with ESMTPA id 073701080063;
        Mon,  7 Dec 2020 20:26:47 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v5 6/6] ARM: dts: rainier: Add eMMC clock phase compensation
Date:   Tue,  8 Dec 2020 11:56:15 +1030
Message-Id: <20201208012615.2717412-7-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201208012615.2717412-1-andrew@aj.id.au>
References: <20201208012615.2717412-1-andrew@aj.id.au>
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

