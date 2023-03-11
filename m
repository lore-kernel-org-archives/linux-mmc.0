Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CA5C6FD1C
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Mar 2023 15:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjCKP1B (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Mar 2023 10:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKP1B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Mar 2023 10:27:01 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B77E682F
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 07:26:59 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id by8so8365457ljb.7
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 07:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678548418;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwysB/HxtkhvD1Lkzv8uYufq7BInyVs0XV9o2nsB4rY=;
        b=lwv1mHiu6n0sB8CodtHQZOqMm+nZYre7S8WQVGretjuKymstVv9/h3F9I6TQqicur4
         Dyk/pl18HtUNHcVC8fF9kMkw/SLe37Ms1x4QnrJy8o4QUr7gsbIcO59paMjB7vy9ZR0g
         5C/uBkW8WPhKHybKkiG20UWFwxBD7fHobmYU5h1uzU6Ovorz/f6xRsL888XEifLg0Ptx
         fHFwpu+evOe1MtIXplQOsNsgeUS9ucb4R2EDXmYdT3ZHedKhbfMX5gpbYbBLLo3zmHIi
         JW6XYkwkEim62v22mUy9qkJZARZdY2w0C1FBlGfKPHP3WY3cZoqpU4yeYiVioyq7HvzB
         G0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678548418;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwysB/HxtkhvD1Lkzv8uYufq7BInyVs0XV9o2nsB4rY=;
        b=NY/27p5zxAGh/q0TRyPdob+SIHvUfg/r5CziueOlbXvA0w4GstY5vPY8XqR54sCEiq
         lAkzHPZ5CzTUcjDVXUsq4kgoCQXMUo4/hv3DTVZZH1VrJ+S7cdSWaqTkm1SJ3Kbs7E9q
         rBs0vdLXQ6D+/uliki+u+fwBrW+T1h4ICZ6DS8CL1DREwyWCpexjtJ/n+Mgsnva7YBar
         qlHzv4VcsUGsOW3GB5p7Zj6Mo9LfKtC4oBCSCfmlmsPYndLxPzKHvDhRtyUvDkRrSURw
         4bLIxu+EGsKqUoAM9QwNSiwZVYXNBmH22nwWR4ocO1UcZfQu2RMiKgXaR2n3W1YllQS3
         JaaQ==
X-Gm-Message-State: AO0yUKW/xJe8VCE0q5HbTlAXA+nJEg9uTv1SVf5v3DoKPpdoi9e33fV/
        P3pxtfB0y/pW8yAKRQkAE72y1o5hFensMMj/AYg=
X-Google-Smtp-Source: AK7set+pAYNxya/uKTldNKWP1EZx4nWH66j8wyCQe/8zmQxB2bDgl25Pd8XMqNa9FQfTEnVurLtTVg==
X-Received: by 2002:a2e:730c:0:b0:290:6fa7:605a with SMTP id o12-20020a2e730c000000b002906fa7605amr8702266ljc.45.1678548417909;
        Sat, 11 Mar 2023 07:26:57 -0800 (PST)
Received: from 0000-cover-letter.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id o20-20020a056512051400b004db4fa67bf1sm344696lfb.157.2023.03.11.07.26.57
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 07:26:57 -0800 (PST)
Message-Id: <1678548256.0817535-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sat, 11 Mar 2023 18:23:00 +0300
Subject: [PATCH 0/2] dw_mmc: fix DW MMC cores with 32-bit bus on 64-bit Linux systems
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DesignWare MMC cores have a configurable data bus width of either 16, 32, or 64
bytes. It is possible, and some vendors actually do it, to ship a DW MMC core
configured for 32-bit data bus within a 64-bit SoC. In this case the kernel
will attempt 64-bit (readq) accesses to certain 64-bit MMIO registers, while
the core will expect pairs of 32-bit accesses.

It seems that currently the only register for which the kernel performs 64-bit
accesses is the FIFO. The symptom is that the DW MMC core never receives a read
on the second half of the register, does not register the datum as being read,
and thus not advancing its internal FIFO pointer, breaking further reads. It
also seems that this FIFO is only used for small (less than 16 bytes)
transfers, which probably means that only some SDIO cards are affected.

Sergey Lisov (2):
  devicetree: synopsys-dw-mshc-common: add "fifo-access-32bit" property
  dw_mmc: add an option to force 32-bit accesses to 64-bit device
    registers

 .../bindings/mmc/synopsys-dw-mshc-common.yaml |   6 +
 drivers/mmc/host/dw_mmc.c                     | 125 +++++++++++++++++-
 drivers/mmc/host/dw_mmc.h                     |   2 +
 3 files changed, 131 insertions(+), 2 deletions(-)

-- 
2.38.3


