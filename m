Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00197C2BB3F
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Dec 2020 14:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45B321D46
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Dec 2020 14:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgLGO2F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Dec 2020 09:28:05 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47485 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727162AbgLGO2F (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Dec 2020 09:28:05 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8BF085C016D;
        Mon,  7 Dec 2020 09:26:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 07 Dec 2020 09:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=R9UFuHjtAK1qQ
        YI8cmha4Thpo1402hfejrmvtlGfR4Y=; b=QEkimx7HDJZ+IdrzB2b+g1CaF61st
        5NUPY0JxfA2xDmdNhq/XdQn1gUt70WSuqyvJA7p/IUrPZJwz711GERDm1bZdTt0T
        VX3rDZsypDoZBBheimOIwcetdhHJOtm/ug7kMHco/Iiu76vrVndza7hDpLC3Msxc
        DqO9nK4ZRJ/RbkTGvilDlANONIJ3IyBdYaZMnaRAkIQ/NPdpwxkvHR0jPOobCKvC
        fW4oyYC65zXUzGxFIoyfnn1SKbpoPtbhRx90+9X09RJTll7bnZ2l6O3GLZarvHYm
        paR2pEjKqMnNt3Jae/QaTodaHaGTftCgqMjbDudwdAGVF6snXZrzWh20w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=R9UFuHjtAK1qQYI8cmha4Thpo1402hfejrmvtlGfR4Y=; b=F2eQNWp3
        pxSaft5+Elh4+p6w4zEHfDw6Cxh1Zt+HxWJyLefzP+sfoma64UvUiHUVBmFNSt/Q
        ysdQqwN761NxDaP4H9OwX81EPbRVTPdpJ/taEjkdzLA9H0y2CrR15df4iemeZtLJ
        ilS9NWWm5ppna+qxlyzUjEV+3dEarJ0KCNWqpc2jYN/kG25TBv+nLoO8cNvicqvY
        gY59M4wZXeZQ0uiTaBRzPuJRc2r65W/e9uoXeBUS6Cbsn0x0kbIohbbvmcNsnNvp
        HGRX3rI/s9+FzzxCc3T6SetUy/y6V2IKK76J4fQ+YISGOBLXJIViN+29iEF6RQCS
        u86w6PO5z59/OA==
X-ME-Sender: <xms:mDvOXxiXF6QF1T_lUT8DE5_OItakU_HeH4rMv625YECaRPjM-bveKQ>
    <xme:mDvOX_qXfwUg-W4jvBX9r9d9Cp2qp9MW5hURe0wu5zPqCFhi7wq3CWrzYXZrVmXI_
    yCltLEupkTvi_GiYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejgedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppedvtdefrdehjedrvddtkedrudeg
    ieenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
    gurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:mDvOXxFJKJInuPhMszZBmlswRc0HyMtXc7kd2FMeQY3tODJDaVolKQ>
    <xmx:mDvOX5lq9rriKrTQNT5BCIXH0nkcIYx7OcSZVzfxo0KbnYTrns8oyA>
    <xmx:mDvOX8lch9rVhFw2fMp6HLoVMbM-BX95YynewduAq6bxeLEtpEjX_w>
    <xmx:mDvOX-U4QquBcnIP2gfsqmqfWBsvl1yYAcdfjOTR6nFY4V0FrYA9Cg>
Received: from localhost.localdomain (203-57-208-146.dyn.iinet.net.au [203.57.208.146])
        by mail.messagingengine.com (Postfix) with ESMTPA id 217CE1080063;
        Mon,  7 Dec 2020 09:26:28 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v4 6/6] ARM: dts: rainier: Add eMMC clock phase compensation
Date:   Tue,  8 Dec 2020 00:55:56 +1030
Message-Id: <20201207142556.2045481-7-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201207142556.2045481-1-andrew@aj.id.au>
References: <20201207142556.2045481-1-andrew@aj.id.au>
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

