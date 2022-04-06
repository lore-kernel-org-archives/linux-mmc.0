Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6AAC433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Apr 2022 23:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbiDFXjX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Apr 2022 19:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbiDFXjT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2022 19:39:19 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84271FF23A
        for <linux-mmc@vger.kernel.org>; Wed,  6 Apr 2022 16:37:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id z16so3919533pfh.3
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2022 16:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vwEJdK6mP4HLwzlF0NPpDB80vAiIJPOce5ra0JhLa38=;
        b=GlwNdB8zBVCXaFx26HpKx7WELFJMmt4kNuhMN8vvHeN5vX0zCQdLS3NJDz8Fn5CnHW
         3xeqY1ZBMDisFyF4etaO1RPGXFVSlD8jEj2q1YJ3qTyZ1S2gizpIv5zBXI+afVoYmVUP
         Ko4jbM0TFMXDMw8zydt1oduC4mvUu9q7FExp1ZVzvm4wdcFWJJ0LV46x0JzoFEJ1zcgW
         MV8/FqqM20hcX0EwicLISB+WCDT8k4wl6u8qEPs+7VZEAhCyVqBEy58v2s+igTNztzXd
         z7Da+eVH7UfNXRSFD574IS0YzwbxtFXX3YBUIDv/vN5fRZSmMxrvWla9q2U5jvwa90yi
         RyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vwEJdK6mP4HLwzlF0NPpDB80vAiIJPOce5ra0JhLa38=;
        b=I+W5djjPnVFoB36SBwnfM1r6Q0C9CqOTbc7PPKcoz0+lj1nHzJuIupTiZf3HwSwlHw
         pN0W6I3e3Tyt9aR1PLAJWPTxwbPFO0J4ANtRfmpaMOVikj84b8tqzn5vQh/KWxbT7Lxy
         fJZtn6u5x/6vcW1oZDJN+Rgp5dPHXKpz0jSlvjuckQqgyYZ6PHGjm/6XV1fHLYva/yyg
         awJ8v/z6qQ+Fe7scOkB2vhojX959Jr77zRiL1N4eRS6LzqwVkLMI0Jx/H7PBcw/eXCdr
         AGaoC7qMUAKe7Nk2/eSe4rj2h0wwHfMrfhsEaiaUqxZQiiriyf6PivekWd722CBTP3dn
         pl6w==
X-Gm-Message-State: AOAM533eJCiPD6ZRUErNQTwQne8Mhxf0CjKAQarcm1RSB0+yvTH1Bk8O
        rFNwEVWAvooerajsEoHozL7zvA==
X-Google-Smtp-Source: ABdhPJyxcbTU9ZBcO9y89jqsqr4/jfNurjGIi6t4DNl6SvL7WcLDdfJNS9GAdP8Mq6nLARE8qXq19A==
X-Received: by 2002:a65:57cc:0:b0:384:3370:e161 with SMTP id q12-20020a6557cc000000b003843370e161mr8998868pgr.364.1649288235387;
        Wed, 06 Apr 2022 16:37:15 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm6903667pjl.39.2022.04.06.16.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 16:37:14 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] MAINTAINERS: Add entry for PENSANDO
Date:   Wed,  6 Apr 2022 16:36:43 -0700
Message-Id: <20220406233648.21644-7-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406233648.21644-1-brad@pensando.io>
References: <20220406233648.21644-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add entry for PENSANDO maintainer and files

Signed-off-by: Brad Larson <brad@pensando.io>
---
Change from V3:
- Change Maintained to Supported

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4cb7fd127e68..456d50921b3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2509,6 +2509,13 @@ S:	Maintained
 W:	http://hackndev.com
 F:	arch/arm/mach-pxa/palmz72.*
 
+ARM/PENSANDO ARM64 ARCHITECTURE
+M:	Brad Larson <brad@pensando.io>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/*/pensando*
+F:	arch/arm64/boot/dts/pensando/
+
 ARM/PLEB SUPPORT
 M:	Peter Chubb <pleb@gelato.unsw.edu.au>
 S:	Maintained
-- 
2.17.1

