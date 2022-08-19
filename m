Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792E1C32772
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Aug 2022 21:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352222AbiHSVLA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348895AbiHSVKq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Aug 2022 17:10:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8787EE095B
        for <linux-mmc@vger.kernel.org>; Fri, 19 Aug 2022 14:10:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s11so7032309edd.13
        for <linux-mmc@vger.kernel.org>; Fri, 19 Aug 2022 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:content-language:cc:to:from
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=NBYnEE+ZcGcA5nR0OncsdiejmoJcs4SXrksqg8rn0TE=;
        b=EiyN8qkZuhsNuDJ+RsVJv9zoP1v86cPewj3dCCdAj0WYbrTz3IirRHornfoKHN2EX1
         RblJRqealF3qlKnPECTIwKWZZ/zDWPFp3ltvIqug1U99zKehBLyIfmijWjGfsoKf/rlr
         PwCNSiAbveAo1fecac9NSaBqZ0DR5MX51x3PMTOl+LVh4E2UISSLNP694xM6XfZBtlVu
         jfBiCPlbCjMBKKvsRB5VJFePvicx5pS0XrEWAl61WlC9Np9Fxn/0tiehNp+8gWSOV25i
         m0Kgl4NlEDFPmR4XnHYZNzeV57bqLO+Hp6BTcwZO/4YrlDwH8F1Jx7p1Q1pJbuaiSneT
         76FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:content-language:cc:to:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=NBYnEE+ZcGcA5nR0OncsdiejmoJcs4SXrksqg8rn0TE=;
        b=ijEcpvNnmsdlNn7U5v6kFEIwCH4ld5ny2tRFQaShwzJgefpr6Yg/tZeOSKFKKAO7sY
         BxPknbLRKFJUgKwU+3W/F7DhKt2c/zz4UhVjubVhGw6ij1Xk4wfjoGJYj3taMzHr4PzE
         MyQ2vsHQQnvACyo6fon14SIWgPSP52AmV64sCMFMDhvaGrzYZ42vuoNtkEF+VYTtNOpF
         SqR3KtLeUCo+I+rd3nddfFdaua8gW6jcf/bm3i9qcjJbNzxAMAdTU6a1PWHVHkwJFlyX
         loags4UB5WjFlgaHnJWUDIYq279+TDuShhdFgST9V6w+5+4qHnDAA0l8/4/lVScOVj4Q
         GFbA==
X-Gm-Message-State: ACgBeo3LBS7+dwOUorFVZofpXSh8JtLUG6BQJ04VPD4TL7aM8sMM2cxl
        if+g2CIgY+Z/KmBqol3Y3YCN7vHQ+4g=
X-Google-Smtp-Source: AA6agR4VpzpXQDagnJncbtzN+KhdcC2/IhTNEsoqKtJlpg0z+zwnqYF71XvfVTe656IzmITn63iZjw==
X-Received: by 2002:a05:6402:10cc:b0:446:491f:d6dd with SMTP id p12-20020a05640210cc00b00446491fd6ddmr3105505edu.360.1660943443774;
        Fri, 19 Aug 2022 14:10:43 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c5ac:3600:6819:de7b:5db7:493? (dynamic-2a01-0c23-c5ac-3600-6819-de7b-5db7-0493.c23.pool.telefonica.de. [2a01:c23:c5ac:3600:6819:de7b:5db7:493])
        by smtp.googlemail.com with ESMTPSA id r10-20020a17090609ca00b007317ad372c0sm2785649eje.20.2022.08.19.14.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 14:10:42 -0700 (PDT)
Message-ID: <b94b7f5b-1095-33a5-b1a0-20a6e2281bce@gmail.com>
Date:   Fri, 19 Aug 2022 23:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Language: en-US
Subject: [PATCH v2 0/2] mmc: meson-gx: add SDIO interrupt support
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add SDIO interrupt support. Successfully tested on a S905X4-based
system (V3 register layout) with a BRCM4334 SDIO wifi module
(brcmfmac driver). The implementation also considers the potential
race discussed in [0].

[0] https://lore.kernel.org/linux-arm-kernel/CAPDyKFoJDhjLkajBHgW3zHasvYYri77NQoDpiW-BpKgkdjtOyg@mail.gmail.com/

v2:
- use new SDIO interrupt API

Heiner Kallweit (2):
  mmc: meson-gx: adjust and revive constant IRQ_EN_MASK
  mmc: meson-gx: add SDIO interrupt support

 drivers/mmc/host/meson-gx-mmc.c | 90 ++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 19 deletions(-)

-- 
2.37.2

