Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F19DC43381
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 03:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E3A2389A
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 03:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbhANDQy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 22:16:54 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34707 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbhANDQx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 22:16:53 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6B6715C01F0;
        Wed, 13 Jan 2021 22:15:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 13 Jan 2021 22:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=3IBtn55EkJHpw
        BMNVFMzrRkc/Dri1oJfvyFIx80EIec=; b=ahH+rH2KDaPSO7H+bl1pbfOK1DsCC
        0vpFHookOMVM468MK2Uzy380aBvm6qKpD6IqCauZN6ubKlxVT0vwRhFfAZobI4/d
        GftvqCKhCzy17bCejzkCX+x9eGewn0lInxfdLwqIbrY8O3MUJQGvhPB9SEUuK8Zd
        GPKnvJKxoG/RmAQ8ONGVOgOmVshCxiBGKHNZR1DdPquuwqKC2mG7sL9/tdpeoQSp
        AakED7sFOwYzFTMy6ktARrfN4FDctj3iBO7NJMcqG3dBlL/6UMNSfTPKOZ9DuzOy
        JL2f7VUqPfBVhY5T4FJla1ioDfUVOg9OjuOGoM5vdOZ14Rm0eeO2r6eTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=3IBtn55EkJHpwBMNVFMzrRkc/Dri1oJfvyFIx80EIec=; b=qOXDJQ6P
        bDu7UQIQxMcS4SkIkF0+Oj6qbTgdnKMjd5/RMyOtxW8BKynNlbKtxsBdVVUFGTO6
        7PGK/rqWFvOAbZqvAT3bULE9EI4AgffUEhOZs4kZXH9huBlJBfhUPS+1Mn5Jsfjo
        xmh3jfeWg3UhqCUxdaN8CqVnFX63wJrXGn0n4lPuvGtIqKhyQe5lUlzfjkNaKdUQ
        A9Y0Ryd3L0E2LOy1wXBEpdpt02ZV21hnjWoRpoNBxY1tFCDuMG8SBPeW8EK2B42E
        CDZitG75ONX7PhqZylAsIgm+P8Uk58OGZLmFuEzzxjnW56l7It9yPoeca0EBw5Bn
        KvJq82hSTmUkjQ==
X-ME-Sender: <xms:N7f_X8RAbDGeY4xIZotZFILIzb4BD5r5xkIYIu-c2dLSI1nz9AxAbQ>
    <xme:N7f_X5zH7UFE84NTqgUqQ9ls8-VPso54psh34RSi6_pW_4g-II_x0JcHgGNWlJBwd
    3h7GIt1tuE61_oSHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtdeggdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucggtffrrghtthgvrhhnpeejgfdvveehteekveeggeellefgleette
    ejffelffdvudduveeiffegteelvefhteenucfkphepuddukedrvddutddrudejfedrgeek
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomheprghnug
    hrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:N7f_X519xPZt7gEx5auJem1hi8yq5x6r-A-lKiP5yl82N1-6eg8XLQ>
    <xmx:N7f_XwD2I9Le4Ah1o_adgBJkxQnLGN75IjfPawqhEIkMmkuYV7g2wQ>
    <xmx:N7f_X1iCl8ypBDPVq1pM2v3HI3AKi1YLAfZB81bDXeGhwficNjT5-w>
    <xmx:N7f_X9hwCH43KQ5atBSJaIfI7z8XuyiX7NIR6lkc7dSJUMCAHawimA>
Received: from localhost.localdomain (ppp118-210-173-48.adl-adc-lon-bras34.tpg.internode.on.net [118.210.173.48])
        by mail.messagingengine.com (Postfix) with ESMTPA id F07F224005D;
        Wed, 13 Jan 2021 22:14:59 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v7 5/6] MAINTAINERS: Add entry for the ASPEED SD/MMC driver
Date:   Thu, 14 Jan 2021 13:44:32 +1030
Message-Id: <20210114031433.2388532-6-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210114031433.2388532-1-andrew@aj.id.au>
References: <20210114031433.2388532-1-andrew@aj.id.au>
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

