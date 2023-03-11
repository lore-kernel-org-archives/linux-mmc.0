Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5A8C6FD1C
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Mar 2023 18:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCKSW2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Mar 2023 13:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCKSWZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Mar 2023 13:22:25 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534986904B
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 10:21:41 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bp27so458678lfb.6
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 10:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678558876;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fW/DwA4q8yKtERRs9xU/rZtvMzehwEtMWVT+wwuBm4=;
        b=g1JGmGYdvB9HebBmdZAUW/LbhHVVgEwwjVms5PxY2tex39jpuj1NgJy5SApNueGoQI
         HCwzU83VKixpwKUZidJ3EDCPV5RT6h1O8YF0O2lVWrNShmRDjBI8HqprPVHP6JhFtAFn
         Yzy9UEb5a2tAXLKPrXlsxqYx5wcJ5qp8ZihjqB6vEmQEG2dFdluMpEhp1DcYSNJ+bo+C
         A+jMSj3666Ta3RP2um9o8ryWc6Y2c4/tqI+6nW8llP6eaCsBfP6fvPv+5nlnhJntrRQz
         P+04FfC+ojs3kIqaJb/WA2lQK5NA6P+k3Ot7CegRnei5vwKufCxgK9IA6kU1XhTlLvVW
         N01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678558876;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fW/DwA4q8yKtERRs9xU/rZtvMzehwEtMWVT+wwuBm4=;
        b=Cx+AYQHTDS8FQuT+diax2WJGTTwhrkycF+aYTM0o424LvfI4QCRTaE7LRWk0nczQ8N
         Jg9m38whp93FH2RWvlU7t5xXjydUiOlBeuCDNyRUrM4O/7fOax3LY8K1wyhCi+Hx4jbA
         sBeSP4qSkphpMQARPxpluMo/Q4fVMUa0oNo/tSu0zeTwBu/2RAGq1flozVW4PDI4cEmu
         6081LB2qBrBlp1vHZyyAih77eZnWqsmcmVRiEobmqZUTffZ0k9cURgetWquBnePMLoMH
         s06daq1fJCJr42sFOUMq6rPqyTjO8EXW0UBKfeCZ5FSeM06dTPXvAtoK1lku094dh3j7
         19Kw==
X-Gm-Message-State: AO0yUKXtT6jjoCDUPWT3A4qA6SjrFCEUF9EjzWq5QwWFpHCKBuNpt75V
        HglXvvdH7f7yJ1c1XHRVvE/dK74FIp6uXOQz+AM=
X-Google-Smtp-Source: AK7set+HqqPm79lPZ0uRYMHOGw4avh3m7bwn5YUMNln5TNYwe3vfQ2vWFN48iBoSubVlB0HuQC8TbA==
X-Received: by 2002:a19:f013:0:b0:4db:1b97:13 with SMTP id p19-20020a19f013000000b004db1b970013mr7628257lfc.54.1678558876165;
        Sat, 11 Mar 2023 10:21:16 -0800 (PST)
Received: from 0000-cover-letter.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id v19-20020a197413000000b004dc12a7e03bsm381624lfe.222.2023.03.11.10.21.15
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 10:21:15 -0800 (PST)
Message-Id: <1678558770.495747-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sat, 11 Mar 2023 21:15:38 +0300
Subject: [PATCH v2 0/2] mmc: dw_mmc: fix DW MMC cores with 32-bit bus on 64-bit Linux systems
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DesignWare MMC cores have a configurable data bus width of either 16, 32,
or 64 bytes. It is possible, and some vendors actually do it, to ship a
DW MMC core configured for 32-bit data bus within a 64-bit SoC. In this
case the kernel will attempt 64-bit (readq) accesses to certain 64-bit MMIO
registers, while the core will expect pairs of 32-bit accesses.

It seems that currently the only register for which the kernel performs
64-bit accesses is the FIFO. The symptom is that the DW MMC core never
receives a read on the second half of the register, does not register the
datum as being read, and thus not advancing its internal FIFO pointer,
breaking further reads. It also seems that this FIFO is only used for small
(less than 16 bytes) transfers, which probably means that only some SDIO
cards are affected.

Sergey Lisov (2):
  dt-bindings: synopsys-dw-mshc-common: add "fifo-access-32bit" property
  mmc: dw_mmc: add an option to force 32-bit access to 64-bit FIFO

 .../bindings/mmc/synopsys-dw-mshc-common.yaml |   7 +
 drivers/mmc/host/dw_mmc.c                     | 125 +++++++++++++++++-
 drivers/mmc/host/dw_mmc.h                     |   2 +
 3 files changed, 132 insertions(+), 2 deletions(-)

-- 
2.38.3


