Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EF1C4361B
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Dec 2020 14:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B01621D46
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Dec 2020 14:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgLGO1p (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Dec 2020 09:27:45 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42867 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727018AbgLGO1p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Dec 2020 09:27:45 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B9695C0106;
        Mon,  7 Dec 2020 09:26:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 07 Dec 2020 09:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=3IBtn55EkJHpw
        BMNVFMzrRkc/Dri1oJfvyFIx80EIec=; b=HKGlpZwgfkD+3mI4G6pHi4YYxLKiv
        a2gxRrHz3kWnMZLiCAfzmtdfj5O3VxnbqlZyHZbpc9+shNer5IUs9dfODfDbDwqU
        Lo3cLt4PrERWoH6NO1r4yc8q9y3nlP6IlYKb7XVMWtvRlI4L1gY/4U4yZ2IZ6Y9R
        ZrDsweyEgh6upeOQMPWCuKMy9CdUASw3KKJuYVzaTiy9lwIZCcMcIUJaXdlh+nhQ
        oQogx0TZxmjYwcsrAzLsrR4UPMbPb+h9OMINEzdpBcPxx23KMeC0R8AcWf+8/bsc
        7gYWDWSJQ4LkY8WHbrHtlEvrF0hRyH5LwfVtCcrv1ZVnlNcunSS0vSPUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=3IBtn55EkJHpwBMNVFMzrRkc/Dri1oJfvyFIx80EIec=; b=ejjyHRBw
        q/OEzNxYnwNv3XHwPA90+tNsXTZub7YDKSsf8k7EzkVV6P6NNa+e4DJ+seGfTKaF
        L18QPCS0ZDGPT3qh2mgupwsTDFwF7JTfgaJLr4tDD4ZiacEClA0mlJQOms6qnv2f
        OehKlw/HR/N35n4+UOw7D5xdMPVmILeLkyWTD/mPrR/YeklJ88bTUuwnvPGEbgoM
        D1IJG6NGGp8hEyTcxPsMHv3Nm9/kaDfpvS4/aSkNeAkjtMe1Tc3GTY0eu5njUlv5
        +na1FXVFQH4ewXzt14qrvm/+zg+5GWLfqaUiAflDhGXevMwrkyu6cyXaAdh2t9SW
        ZGwXnjkOkTBYYw==
X-ME-Sender: <xms:lDvOXyC3qVhuqURbhlF4d7_aGpObGPrbVQN4sUsn3KK2e7YEB3lMVQ>
    <xme:lDvOX1XGA0s5MOb0DQiU2SY94LM0b9vR2kLVRPmwARXPh3UTO3SQLaupUEZ-n-mnc
    7kAZxAISPEKuA8wTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejgedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppedvtdefrdehjedrvddtkedrudeg
    ieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
    gurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:lDvOX26B-X7JWIyz0NYtHR588UJRKZPchluDWPXLPM8a_bsLLV4QJw>
    <xmx:lDvOX2D0G4vVmkHnRXi6-KLwAIhGRQxwADcMsM5zeCS3R8aU1uuaeg>
    <xmx:lDvOX7D0sItBSAJe36oaO5Zkqno1nrRn_y4bhclpwa2z1-zgxSyrlA>
    <xmx:lDvOX1Kz4QjMg2abqf7mBZEUFKSHTauOc56G45XZ0ZpFAO_aT68nBw>
Received: from localhost.localdomain (203-57-208-146.dyn.iinet.net.au [203.57.208.146])
        by mail.messagingengine.com (Postfix) with ESMTPA id C71CE108005B;
        Mon,  7 Dec 2020 09:26:24 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v4 5/6] MAINTAINERS: Add entry for the ASPEED SD/MMC driver
Date:   Tue,  8 Dec 2020 00:55:55 +1030
Message-Id: <20201207142556.2045481-6-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201207142556.2045481-1-andrew@aj.id.au>
References: <20201207142556.2045481-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add myself as the maintainer.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e451dcce054f..eae4322aae67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2826,6 +2826,15 @@ F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.
 F:	drivers/irqchip/irq-aspeed-scu-ic.c
 F:	include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
 
+ASPEED SD/MMC DRIVER
+M:	Andrew Jeffery <andrew@aj.id.au>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
+L:	linux-mmc@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
+F:	drivers/mmc/host/sdhci-of-aspeed*
+
 ASPEED VIDEO ENGINE DRIVER
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-media@vger.kernel.org
-- 
2.27.0

