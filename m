Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05ADC4361B
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 03:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F0064F09
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 03:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhCDDoJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 22:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbhCDDn7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Mar 2021 22:43:59 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE46C0613F0
        for <linux-mmc@vger.kernel.org>; Wed,  3 Mar 2021 19:42:32 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id p21so17975947pgl.12
        for <linux-mmc@vger.kernel.org>; Wed, 03 Mar 2021 19:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hFDDuuLCKMVUPK4LrKSbpDVOykG8ODUpVOe4CV5ias0=;
        b=1opUXAsn2Kt8qlhlTkZuka8cdGg9pcFuMg87cVSygAl2xQ5X0EAshUWlvWYCdUXMp5
         AWhfN/NOGbE+AQh5ijSGOHHg3jjyH0fd4VMghuOm4V7uABp0spgfMvnIDwKRUAX869G/
         W56G2VbCRO4OEYFtODPVNbJjZh6mwMdU0ouuqzzVtGYppmVCCfeGoIO6RsLHVQHkLkNK
         1ZxI+fVL/wfF2uDsCHOF+HI/Pmd+UC/fXWbqWyKw/AcAenGrPGOFQ9s1JRoC3rGsGD9/
         Rok3iMUTJpkyj69iIt3abyN9gQAvOf7PIDT2Ax8l10B9yQWwO1UJZxh67pP+3qHp+l+d
         kX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hFDDuuLCKMVUPK4LrKSbpDVOykG8ODUpVOe4CV5ias0=;
        b=hXP3himfYNBFfGELgWLQ6WnpgCBSn7hLyPnvpYqZwdXyLy79KV/h0FNKAubilDm+X8
         fHrVrepg9pO5oqK+nwp0tcoSd2GfILIJ0Cy6zMaJiySv9ILjtv5vNznfVk1B4KoQZ5ES
         OlO5fqgLB+/FR7+xGL9GYNvAyUr0hLDzKXtJEEwAi9tN2W7lbmYXrq7Rs1L9KIJ2lSpd
         1D4eFRX0fgwtCfCvGTfIvqQQW89ZhGyoTz3XkJnXe1rDXFhEQ0VAGOuFdhi5SG9js8UD
         mQDN8RM4jCxsX/PhDpbFf2zKZdc+L/p8RDwzZKWLpAHlcEXhZmiMYogirmMGrNrA61lq
         EfVg==
X-Gm-Message-State: AOAM531v+vewefG7XwJKAZ+XYBmqwGY/bqzakL3jIOk279l9EsA4nRpM
        CMtVLbKOU2fcuftrUdLXMCQE5w==
X-Google-Smtp-Source: ABdhPJzLtFoQNkM8z+nPvDTwYRktUQTeKXYN+F/VF6vpP4GvYQVlLQkPZGGit0J8TlMHm+yaO6XMow==
X-Received: by 2002:aa7:8c0f:0:b029:1ed:4d05:218c with SMTP id c15-20020aa78c0f0000b02901ed4d05218cmr2256407pfd.21.1614829352253;
        Wed, 03 Mar 2021 19:42:32 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id h17sm2403989pfc.211.2021.03.03.19.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 19:42:31 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] arm64: Add config for Pensando SoC platforms
Date:   Wed,  3 Mar 2021 19:41:39 -0800
Message-Id: <20210304034141.7062-7-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304034141.7062-1-brad@pensando.io>
References: <20210304034141.7062-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add ARCH_PENSANDO configuration option for Pensando SoC
based platforms.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index cdfd5fed457f..803e7cf1df55 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -210,6 +210,11 @@ config ARCH_MXC
 	  This enables support for the ARMv8 based SoCs in the
 	  NXP i.MX family.
 
+config ARCH_PENSANDO
+	bool "Pensando Platforms"
+	help
+	  This enables support for the ARMv8 based Pensando chipsets
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.17.1

