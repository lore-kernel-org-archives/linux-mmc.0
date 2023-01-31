Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6828C636CD
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Jan 2023 08:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjAaI5q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 Jan 2023 03:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjAaI5c (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2023 03:57:32 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151804C35
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2023 00:53:06 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n13so2774541wmr.4
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2023 00:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eTF5rD6gkolgmHukeO2r/oDk9G5LzTxiKluNHsAFP+A=;
        b=alSpDnMHw0cEqnhPCpqCHM/X0NSIZCQhE7Wd8A0DBHakCRPi9fKL3PJU0h6YFva/D5
         pJZiDSkKp3jD26RBiw2zmMuAniEeABMY+o5Jjhr/vDfPHcSrrHkyDm31vJJHbVkJl5Al
         AAZQC8gZZeih/WN0oUH7gDAnfy3rYs6dCOaQ8D15qlwtDZL3AZyoFC2PETLpIPQag8nK
         LoosCsmGGiKWlILNlBl2UABBqjsIGxCvwFTsK7drYWaoNkDD8YlU+XNJ3gUhvOHyFaY4
         jlAu6iwIQGwDNaCrOCxzzDmxbDuyUvpxipE2+0kMwFy5XmwdjC9ec0Yu12wqJ4UUFFHE
         EqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTF5rD6gkolgmHukeO2r/oDk9G5LzTxiKluNHsAFP+A=;
        b=Q5XAGMe4ngaZnIxPnOsBW2e1JNVcDJ0TlitEOh9vHFuzd39fRuMn8NEoSif3N5rLEl
         ljq485xNsD8O1ZaxiWnu9QusEGEhfOOSzEwI/JkNEaOb/rGdB8aqjZJzsxm4nWLQ/aSA
         TqaG3cO5MgOwrYYBvgFBLO2rQyW3TaLx1xy1XORWeknYM6+CVfqChbbS0eG6kBVruKAk
         +5/Ubx0U50YllPz+L5QWqKMYMB78S3wA3JaPJZD+vBpcughXY+BFbwj4MAlFKS5Zazt5
         aXn4wfxXFmQD2X4DvkoEClM3blhI9Gy4iPnx8Q0l/3uWmEFrBwL93lJ61SsLExqNNFLu
         2p+A==
X-Gm-Message-State: AFqh2kpaGBvO8Io0DDcSzK7biMUe5gQgRIDJ8qNb3BWChJcTfXpZG2dv
        YTRU5YSnsZkMQh1F5KwreAX4s7u3uls3IUkE
X-Google-Smtp-Source: AMrXdXsCoFX4Cpz/JNFAY22qYBvCcwNYUMMDkfyZUYctEP0//4rG2F64f3VrMrQl+GecMPdUzhqVsw==
X-Received: by 2002:a05:6402:49:b0:49e:33ce:144d with SMTP id f9-20020a056402004900b0049e33ce144dmr139117756edu.37.1675155142981;
        Tue, 31 Jan 2023 00:52:22 -0800 (PST)
Received: from fedora.. ([85.235.10.72])
        by smtp.gmail.com with ESMTPSA id cm17-20020a0564020c9100b004a21263bbaasm6189976edb.49.2023.01.31.00.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 00:52:22 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH] memstick: core: Imply IOSCHED_BFQ
Date:   Tue, 31 Jan 2023 09:52:20 +0100
Message-Id: <20230131085220.1038241-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If we enable the memory stick block layer, use Kconfig to imply
the BFQ I/O scheduler.

As all memstick devices are single-queue, this is the scheduler that
users want so let's be helpful and make sure it gets
default-selected into a manual kernel configuration. It will still
need to be enabled at runtime (usually with udev scripts).

Cc: linux-block@vger.kernel.org
Cc: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/memstick/core/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memstick/core/Kconfig b/drivers/memstick/core/Kconfig
index 08192fd70eb4..50fa0711da9d 100644
--- a/drivers/memstick/core/Kconfig
+++ b/drivers/memstick/core/Kconfig
@@ -20,6 +20,7 @@ config MEMSTICK_UNSAFE_RESUME
 config MSPRO_BLOCK
 	tristate "MemoryStick Pro block device driver"
 	depends on BLOCK
+	imply IOSCHED_BFQ
 	help
 	  Say Y here to enable the MemoryStick Pro block device driver
 	  support. This provides a block device driver, which you can use
@@ -29,6 +30,7 @@ config MSPRO_BLOCK
 config MS_BLOCK
 	tristate "MemoryStick Standard device driver"
 	depends on BLOCK
+	imply IOSCHED_BFQ
 	help
 	  Say Y here to enable the MemoryStick Standard device driver
 	  support. This provides a block device driver, which you can use
-- 
2.34.1

