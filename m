Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF37AC2BBCF
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 03:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB4E423A77
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 03:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732665AbgLRDz3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Dec 2020 22:55:29 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37819 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726789AbgLRDz2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2020 22:55:28 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 945275C0115;
        Thu, 17 Dec 2020 22:54:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 17 Dec 2020 22:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Q1FwOOJn9VJrF
        xg4mu6zSOR772E69sWYabsnaXN/CgI=; b=dqc7UpKHs8arqoIaKPwepMkO+ZqbE
        74vwIesaPS2J60ELgm9Ggg65Q2TqpZ8RRU+X1nWN6cO6SvAF3xrZWNnmwsD+wO46
        BKeGZ3roRDy31zwvBR/zJsVn1l1YQYMEEIEAxwpYjRlQ7k22GabHkBGOA7CNGNRm
        IT/VnGwSBuiZedloqDNkYzjTE2gWgdqsqymFk7vSgF/OYc9vQixDt1nM62qDNrWw
        jSaSg7EPx4UYGaTvFl/2o3zFeS8PqAbQ0SkKTh5naXCkaXKnmuQhD/2BTChqvM+v
        Kae7/kjWdlaq6IaHoUTO5rRgq0TlrniKNZbFemuHGnkeHoDKKo26cmQdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Q1FwOOJn9VJrFxg4mu6zSOR772E69sWYabsnaXN/CgI=; b=OF9XOxZu
        oR7r0fVEWhGVNhedSC1BYAJ2Ao/7t+R3BhpwgG0uHJh7pZnMpvYc2gvFWGU4IwIP
        O2pzwG0fbseOrBS1w7xkoXOjTNVhJoY5g/8CZSSQwYjUd8mKnKgBgNchqcXwHcOH
        a65GluG3jdSqET6HKsRmgFMunLPfKJ5zVRVjYCfNiZUxqzqsnkktWV9gtHqohLiu
        kCkBD7RoQSLhSYaA5cNM+iDObA4ha2UJFPFsiGlzUVvFcd/9ZDhsc7XDOKO1IIy8
        3Cq0Xy2+b4KGRuxTAYH2qV0PpcIRhuD5PSfkSj+cdr+FZypZCGNtlUimRmwzjgUo
        OkV3pDQoAgDECQ==
X-ME-Sender: <xms:9ifcX0VYLMr2iNvgyeYI2JwFnGD5PzgfWmz9IWdSaVK92xEpe8tDbg>
    <xme:9ifcX4mvwWk4SH3hNWvVu-4dA6DJ5uJnJHoxpkm0pV6SPLiO0ic-8faq475AWpFvr
    FKsDmpcq0sgYtzDeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudelhedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppeduvddtrddvtddrjeejrddvuddu
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomheprghnug
    hrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:9ifcX4Yr2aIX74Y4E0BRqCyxdU2yZCQq3hrV2Ss2R1-neenPwm2RXg>
    <xmx:9ifcXzVY_QtRceW-p9oyO7cz8zz9jVSaHGHL4zRBKuew7l8EpHv_Og>
    <xmx:9ifcX-nwPTvKnYJRPRsMwld2SQvkYJ6QxKyaZylFUhc2nOcEdCKyVg>
    <xmx:9ifcXwUuCjqhnib2hOw04Nxhl_om-cRQAkkqi8Zkm8KvGlUiv-uWAw>
Received: from localhost.localdomain (unknown [120.20.77.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id E5FF7108005B;
        Thu, 17 Dec 2020 22:54:25 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v6 6/6] ARM: dts: rainier: Add eMMC clock phase compensation
Date:   Fri, 18 Dec 2020 14:23:38 +1030
Message-Id: <20201218035338.1130849-7-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201218035338.1130849-1-andrew@aj.id.au>
References: <20201218035338.1130849-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Determined by scope measurements at speed.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
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

