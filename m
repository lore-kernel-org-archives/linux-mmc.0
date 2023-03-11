Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C971C61DA4
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Mar 2023 13:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjCKNXz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Mar 2023 08:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCKNXy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Mar 2023 08:23:54 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155196A9ED
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 05:23:53 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g17so10190026lfv.4
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 05:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678541031;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwysB/HxtkhvD1Lkzv8uYufq7BInyVs0XV9o2nsB4rY=;
        b=NuG58f3cRADqBWcVG7wpFgwgKqoLMrPfWJkg0QHtRaa2ysVNFKGN+AgolsSoaPvZPl
         N8k3psW8jHXxayDrxXj+pgRC2gCZIbCIhWrwizdpq8zr5YYtpk8XayxJPiOZKGXNAx+V
         I8NTDqoPM6vhLKPbFb0NkFUbFeFMl0+3nvQsa08zIiMUzqfvSWGMuhlADM7u9rjuCX3i
         HLfrWmRg4Gk4wvYNdHNRGZ8/BmkTBmjv5mEcrulCNeu+6onIJXk0jOBTQpq6K85Ij4Rz
         elSjZj0plbpzOf+rsqxNuJTxbYj770z+kHDPx6dAUgOSwmmrpLI+Hu+UMraIYAHUNS2p
         HBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678541031;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwysB/HxtkhvD1Lkzv8uYufq7BInyVs0XV9o2nsB4rY=;
        b=gEhe+ZIxFqprzAxMLufShFxVjGBTERuVUls1iSEoPVTET/hAH2thlY++IL2EfXJSdt
         PkhWAFo05Nxuon1fz+l8tr3J3JB3x9vjZCtoWRJ+cnb7TnKb0PKuFy/9/EMeYA/bVcso
         ts1XqFjMNpg53Nl0IOUD01qdkSgplPPh8fb/HBhy9EmPpPoYMpq6IgDRk+VYOfVGS1Y9
         7tFPWDZmehOa1xvjgmVtDEyEsaJDkscEtFBvSJHPcJaJH7tq0lSl7Q8IaK0JHJaR3Whs
         EfzphrmlrxJm5ZBXm+BEReEGdq+pbm0HZEoXy6spYwrrcfGjmOLYeBkA1f4D1/JOVG6C
         tm5w==
X-Gm-Message-State: AO0yUKUe944fvfCO37IKirlteb2AGIqkHKi1hlypqSnxgpTXzsur6po4
        dYAPNntIdnXcobLzi6ZFnyW72bA9n0uH00wrE7s=
X-Google-Smtp-Source: AK7set/PUzhx0cSbJv5/62FOZ3tZapjTIRa1Bs2pUVgS1kzRjMCE+uUlcfiUSm1/8/Ls8dU0FoyI+w==
X-Received: by 2002:ac2:4899:0:b0:4db:2977:508f with SMTP id x25-20020ac24899000000b004db2977508fmr7539738lfc.68.1678541030882;
        Sat, 11 Mar 2023 05:23:50 -0800 (PST)
Received: from 0000-cover-letter.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id x5-20020a19f605000000b004cb3a55feacsm321840lfe.100.2023.03.11.05.23.50
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 05:23:50 -0800 (PST)
Message-ID: <640c80e6.190a0220.1a905.0b2c@mx.google.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sat, 11 Mar 2023 15:54:59 +0300
Subject: [PATCH 0/2] *** SUBJECT HERE ***
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


