Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29789C433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 01:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E7C23A51
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 01:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgLHB23 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Dec 2020 20:28:29 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37517 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbgLHB23 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Dec 2020 20:28:29 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 80C025C02DC;
        Mon,  7 Dec 2020 20:26:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 07 Dec 2020 20:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=3IBtn55EkJHpw
        BMNVFMzrRkc/Dri1oJfvyFIx80EIec=; b=HOrKkGGU54aa/nR35X9Kj8yXMJCeY
        IjXXO3jbZYGYbVCKSznAHCAWhyIqM8fMu+oKLIZAIvwo73DLj9csrjBYMkr8z/S3
        eFH4D3YpFl2Ylksy0gj9hmGq777TUiODgEvW1nyf4ivDpcExAvI7rwIxVY2MHhxQ
        N7QZ3nkyBuwANVO/mrvYoEHGiul7S0LU75PBPo/56ZjVUl1r+c9KvF5SpndhmQXO
        FgofsZ9yEFWgOlmJR68Cxmhd9LkCrRijALCKHxV4cGO7obq51jwRzlx552hXvd+7
        b6BrHHXpPhEDoJsNsT3LQOy7ddrQWj3ydp6MhDuoj3qyd3z5D1q+gbEUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=3IBtn55EkJHpwBMNVFMzrRkc/Dri1oJfvyFIx80EIec=; b=QMc5W5vY
        r57m19gNrpmhHrPrUz5LGCyIjKgJdarW2fhKH4MuzhVdsJbR6ZpuP6DoBe6VWk0w
        tHMgZ/fWibbAWhKbxFFOPIgLVvx3k/jEk0Z/bhd3E3xc07fbf3yLZR0k+iiL8Ghm
        WJhlq+45iBV5xqQXIdKGeoiYtQAdIELkC+2Vsh9X8Q/L3lJBi0iOuaELvPDm/hGu
        f1BWaaW0r45AgtlpaIHMYQCBHxmFn6wooZq42aE1e7fPnmMSU7CyVMY9BpCyDM+n
        8L6uS7rkF5CMy5tnPi+i5H9hyg2gJEoMznN0lrtOix8vthaVOZLn3c7pAxgUD3zl
        wobmF0LLqnCZnQ==
X-ME-Sender: <xms:V9bOX5oQxsWQecY4LuvHV44cyL4I5f4tj6EUWn8KV5lwxB1ZP9WBUA>
    <xme:V9bOX7qJLUroLK-lii7oqm0_wamsUWvH45vRDVvduSd8xUt63GNjemOxWPfdm-tig
    qDz_FuBQrGhxGBZcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejhedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppedvtdefrdehjedrvddtkedrudeg
    ieenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
    gurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:V9bOX2MY-blarMJSvNaLBheeK6dbEkDENeAb6PTjpTtwONvTQYdN6A>
    <xmx:V9bOX07AH5VqmKVK5NJT0lOqwMBDEhhppZ8jC85zODMYVb2Ok4rbxg>
    <xmx:V9bOX465di3pGdsmwovGNyKD2VJzqz1zuSe6xrN9w5qO1JvgOV4wcw>
    <xmx:V9bOX3b2VEsLnmkMkIkvraBBtKGBfUncR2a31ckdn4-Y9rmgZ6hBlg>
Received: from localhost.localdomain (203-57-208-146.dyn.iinet.net.au [203.57.208.146])
        by mail.messagingengine.com (Postfix) with ESMTPA id 09B38108005B;
        Mon,  7 Dec 2020 20:26:43 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v5 5/6] MAINTAINERS: Add entry for the ASPEED SD/MMC driver
Date:   Tue,  8 Dec 2020 11:56:14 +1030
Message-Id: <20201208012615.2717412-6-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201208012615.2717412-1-andrew@aj.id.au>
References: <20201208012615.2717412-1-andrew@aj.id.au>
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

