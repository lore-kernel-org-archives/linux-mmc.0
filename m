Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064D8C43219
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Apr 2022 23:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbiDFXjn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Apr 2022 19:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237991AbiDFXjT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2022 19:39:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7634A1FF42D
        for <linux-mmc@vger.kernel.org>; Wed,  6 Apr 2022 16:37:17 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n18so3358937plg.5
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2022 16:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MgwUzux9l9MfjkfiPyLThjf7TEJ7a+1kv720LXWdL0c=;
        b=h3rzaO/ehbfZ3kl2FGqKxW6CKni734T3jpG3x+dhqbWIx0ekxvMJytn06tsYtavlKS
         p7odvwy7v3WOQFdQ+vTa6dwdAxbRBySInSfsw4+BBw6Xok7WEWgHy7uuYd4mkVKhJI3A
         QYge0VgdY5Ua0NStPSbitgP35D1VdCR1LWosIfyACxiSrcYRr/4TBTjBGpFXZNF7PHAN
         ZgDm6vBGthjIXGD7vnJZhMg1USt7k6pniK5j4hENo9d8uyBLlAVJiXOlkyUrAH4dVzGw
         qST0RXzc1ZnJqNsu9iRuwPVHItUL0EN323XjyJzmygDPKZZuVOZjk7ULU1eLwL71oShJ
         iOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MgwUzux9l9MfjkfiPyLThjf7TEJ7a+1kv720LXWdL0c=;
        b=uebDR6HX08WvZvayhxrKJRmI9IwGWY6V/jDX21lAkC4ltg6txw8FaeBfaHJqmARM5+
         g+Fy5r1DVxM16NOFOWoKmMlYcdObBSKUmgf4eRCpCKqdcVsZpBuU52SHh1qmFeEwc9PQ
         JCrNMTT7TLMpE/1nwDMMV3N3VXbbACAPui+FBbhnjF4SYW6IJ7WJkU4Yvv81sJQ1NaFt
         oKKGSJNxKjnkdviL4W0xtY7JSPmBjAOjZzzumqrcJirUnlfrAPPfKJcEWToVxBHjEDeb
         F+6yGbncV6mulB+2eLR9+areBoK51xV/peDjeVlsSgZ5twDuEB2a4B1g4wbepGpzh4qq
         XFww==
X-Gm-Message-State: AOAM530Y977E/pt/u2yfQUB0pyk7XrEJabKpeurBSKsj5LWkjTwl5cKs
        j1HER+IubFlclNM6uvFlR/F6Cw==
X-Google-Smtp-Source: ABdhPJzBI/AgQUtI42LRmJQIG6o/7UZtBtE27V6Ss9Y15BjgUkXheWJ0cSmnrjtHxtCg+5UlMXWc5Q==
X-Received: by 2002:a17:90b:1642:b0:1c6:c6d0:fbfa with SMTP id il2-20020a17090b164200b001c6c6d0fbfamr12403634pjb.218.1649288237042;
        Wed, 06 Apr 2022 16:37:17 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm6903667pjl.39.2022.04.06.16.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 16:37:16 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] arm64: Add config for Pensando SoC platforms
Date:   Wed,  6 Apr 2022 16:36:44 -0700
Message-Id: <20220406233648.21644-8-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406233648.21644-1-brad@pensando.io>
References: <20220406233648.21644-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add ARCH_PENSANDO configuration option for Pensando SoC
based platforms.

Signed-off-by: Brad Larson <brad@pensando.io>
---
Change from V3:
- Fix a typo on interface max speed

 arch/arm64/Kconfig.platforms | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 30b123cde02c..e3b5557e1049 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -203,6 +203,18 @@ config ARCH_MXC
 	  This enables support for the ARMv8 based SoCs in the
 	  NXP i.MX family.
 
+config ARCH_PENSANDO
+	bool "Pensando Platforms"
+	help
+	  This enables support for the ARMv8 based Pensando SoC
+	  family to include the Elba SoC.
+
+	  Pensando SoCs support a range of Distributed Services
+	  Cards in PCIe format installed into servers.  The Elba
+	  SoC includes 16 A-72 CPU cores, 144 programmable P4
+	  cores for a minimal latency/jitter datapath, and network
+	  interfaces up to 200 Gb/s.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.17.1

