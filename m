Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781A5CDB483
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Oct 2023 20:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344500AbjJQUpl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Oct 2023 16:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344457AbjJQUph (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Oct 2023 16:45:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BA3102
        for <linux-mmc@vger.kernel.org>; Tue, 17 Oct 2023 13:45:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c8a1541233so39439595ad.1
        for <linux-mmc@vger.kernel.org>; Tue, 17 Oct 2023 13:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697575526; x=1698180326; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BmxulcCPkSniZYdQWfk9xRMqLpea0NZ1oqzxL0OgN4=;
        b=KGeC/cFx0Q/6/SnPUIHq9+SIEAtEu9QtHJKWj5UWX8LXd0Nh3G0KoZevUYMm5qw32p
         nLDClYH4stj1c97CHl3bLTLtYX0hh/HNo4C/iL4/AINH96jts5CDbeGDX4MGqxfv2d1S
         1dNMgcoM1McKaz7LqzjYQCGSOOMp6ghx9Ib9xfGmh1TQXu+QnL2LuttgxdXujF7/7DUI
         n8EMUYoQWStjXAHLASctILAmVf25d/W5MEn1Da2cqRfh5vQeDElrD1O0q+2DbuXdeRdW
         pENXat6mDIklDzqifBsfcQRv/APIBbE5nKczxf0q9Gbe75KCBRuEB+4HR1/b8jZfS3Vv
         Eacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697575526; x=1698180326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BmxulcCPkSniZYdQWfk9xRMqLpea0NZ1oqzxL0OgN4=;
        b=EKuJyc8aJ8gi0Df97lDktgxX0bsuMXWuxNkzBDNu9/M9FdPul7FK8jP52vNvz3Hw4h
         iIIt0IAPdcIG3PV1RN5h56ZTRYRZ6QFRZ2B2b8Nkj23QOcg4hWTbTzgZldvBAyndK1NK
         4cORO6B5L9kz8TrH+eMqOAKx7yIhXqWkNAYXYVyTRK6R6vZu/3qsKxFPO1XcLBjx9oLc
         eXXoegdn6rTAIp4fufDkGlrx7xIMbuyQ1P3HkygRdTZ6M5GiXhlieZbf9CF70iihsUrk
         DNNYGkX2LgZjNAcUt35YnjF3muAw4GxpjDhHIWq8bTUermqOJfYnngSy82RHBh4pvrDQ
         cleg==
X-Gm-Message-State: AOJu0Yyj6SU3/1AcjBHnpUPOCw+epm1rsgMVnw1FvPVC/zzPW1cq5vKy
        CmaTLToPj/A8GYpwSvhgGkF8oQ==
X-Google-Smtp-Source: AGHT+IEzzNmgIZ8zis35YXLxguwj5DngT1258LdDb627amXgp9c4UUvS9r5IPBtrYpPwBsm5Y/h7PQ==
X-Received: by 2002:a17:90b:2501:b0:27d:7666:9596 with SMTP id ns1-20020a17090b250100b0027d76669596mr3072562pjb.11.1697575526448;
        Tue, 17 Oct 2023 13:45:26 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:51d6:dcd6:63ef:52e9])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090a6b8300b0027b168cb011sm1906553pjj.56.2023.10.17.13.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:45:26 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Tue, 17 Oct 2023 13:43:50 -0700
Subject: [PATCH v2 4/7] riscv: defconfig: Enable mmc and dma drivers for
 T-Head TH1520
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231017-th1520-mmc-v2-4-4678c8cc4048@baylibre.com>
References: <20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com>
In-Reply-To: <20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697575515; l=873;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=1b6E7IcYPcGUX3CsWI9slySNkcpgVBWsbFODn/9h1s4=;
 b=35sRMPw4jZ4wGRrdg+DGS4oNB75lU2OE/PvljPF/GCaThFBcZGUoTrJbIi4kNmE714EcWRq9I
 FUKF7Fv4YiNB82HJ4GGaDCbqEs6wY44RXyc+Euh+2yVdj6gHQDyUizS
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Enable the mmc controller driver and dma controller driver needed for
T-Head TH1520 based boards, like the LicheePi 4A and BeagleV-Ahead, to
boot from eMMC storage.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ab86ec3b9eab..c5a8583236d0 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -168,12 +168,14 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_CADENCE=y
+CONFIG_MMC_SDHCI_OF_DWCMSHC=y
 CONFIG_MMC_SPI=y
 CONFIG_MMC_SUNXI=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_SUN6I=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
+CONFIG_DW_AXI_DMAC=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y

-- 
2.34.1

