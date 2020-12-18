Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0104CC4361B
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 03:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF3123A7A
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 03:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732709AbgLRDzt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Dec 2020 22:55:49 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49953 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732108AbgLRDzt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2020 22:55:49 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 71C3C5C010D;
        Thu, 17 Dec 2020 22:54:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 17 Dec 2020 22:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=3IBtn55EkJHpw
        BMNVFMzrRkc/Dri1oJfvyFIx80EIec=; b=I599+f2ishGKydUibrqBNovepABuc
        Klh68PJWbwbq/NchtlJvvkqhhsL+KbS7LKOIHaVMjoXqA2GZiDMBJ1lqVMz2jcye
        Ho2HEs9bj3jHFwbwnIYXXVs+4To+VeO28JzsmrGd+QlOjo/nVAPFqgJDiVqhpEkT
        l6JtRsRgE1oOfpjrPdj/BW/tV4dhLqVJf4T8jtXLPKgErxj1oEGR7t/mK9wUoBjS
        bbWlmOwo9YKo02PhbOl+sxQwFJMOM1PmupgbbQnRM5zqTAqcx765y2BPyvW8htuN
        j6+Iu9wU2VZVSuFyWT+rrBRDg9XV57Gb2YW9QCkRVKravRUIicfmEje6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=3IBtn55EkJHpwBMNVFMzrRkc/Dri1oJfvyFIx80EIec=; b=No0JzjlS
        VUq20GiuVnRLf97riXOVRZ/jmJXwEQfL/5F6LSAS0l4JxiMMEpwvAFqc5c6lZotL
        JnIjyCSzMOS4QPUEevFMabkPObLQViCYAT4RjU1QQyqQzsrHNcCILM5uHstppJ2z
        9UoS5bJBbcrdj1zAvG8zEzOU6tK74UY3GzlCNXPhXw1TsWTzjwEfB3hEEe7aIutV
        ii/oImwla6tCOCiCsMHx19bzZ0m1hH6lTi90WK5U87f7jmgM3PANY58ZfFJU9DP9
        9EhFCoBTqeMjLQSVmP2Csp8l+7a3ASXHZKC1/PIeqpXSygRsDnMyBWakaCGtCQQi
        YZr08Cv1GRKPTw==
X-ME-Sender: <xms:8SfcX5-yN8e5rHjpWXjYZAWst__-QkM5q3os6tQgY9r3HUL-vVXxJw>
    <xme:8SfcX9sDvLG7l4lRVsdENjOnBZKVYi5CzUdsAq5HFT6L5LV5cPn9WEBp9cas8PPyu
    5_8GkIb01NIP5hfpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudelhedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppeduvddtrddvtddrjeejrddvuddu
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomheprghnug
    hrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:8SfcX3C-yAfXDFKu9P-vx0dDr3CrkNwJtlhnCiEVEO7ae25UAfRORw>
    <xmx:8SfcX9chtZ9rdU_rSm4RXFrCY7l2gqVk7G3f6Ys2_uX86ezkN0TIzg>
    <xmx:8SfcX-NW_pwVdRhMof2QNIW6IADVj4TY7KjGOQztKFDvtGZQCZH4Uw>
    <xmx:8SfcX9c6ampYPqY846-4cqnK-tzlbDfkHo8RdraBByFbtiYnQIxzxg>
Received: from localhost.localdomain (unknown [120.20.77.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id B02D4108005B;
        Thu, 17 Dec 2020 22:54:18 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v6 5/6] MAINTAINERS: Add entry for the ASPEED SD/MMC driver
Date:   Fri, 18 Dec 2020 14:23:37 +1030
Message-Id: <20201218035338.1130849-6-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201218035338.1130849-1-andrew@aj.id.au>
References: <20201218035338.1130849-1-andrew@aj.id.au>
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

