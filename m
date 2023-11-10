Return-Path: <linux-mmc+bounces-1-linux-mmc=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37A4C05021
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Nov 2023 17:47:07 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F900281252
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Nov 2023 17:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4403A268;
	Fri, 10 Nov 2023 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c5xfLzwu"
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AB22231E
	for <linux-mmc@vger.kernel.org>; Fri, 10 Nov 2023 17:46:30 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2989E7DB9
	for <linux-mmc@vger.kernel.org>; Thu,  9 Nov 2023 22:51:13 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-421ae930545so3508281cf.0
        for <linux-mmc@vger.kernel.org>; Thu, 09 Nov 2023 22:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699599072; x=1700203872; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xY9e61NSBd34WKgwLiextVdIl1pEHWCBao7kYEHaYbc=;
        b=c5xfLzwukrMfaL4QkPmGsRC5Pds0mvQuCyrigOCwOT9e5Ycdk3WGzTQbmNjElJvY6K
         a7sT3K98D7+zs8IuQE64XG4LWgg5b0GaVQUEtYUwNciazzzdzv93ZT6TEY9voSlckUNs
         wbLllWB2zUvtmXB6cUIhWYmu4BNeqt7dRP/uLUmKqBMtvpPPLlcUN0oIzS7lwjI40VA+
         TxDwj2v1V1nFUSjTPKQ26pdxixK/ejPDmI6KhFCZHor2MOLihEv9LoUO8fR/pE7sC6xm
         YLmYB3zof215O7mDBA7dgipw/9vRmP6A5IPqgHSoH7Yo7G8lNnAjcszMTdqOed4raoPu
         dYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699599072; x=1700203872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY9e61NSBd34WKgwLiextVdIl1pEHWCBao7kYEHaYbc=;
        b=K8Wl14iRO1SUN1er66aBMOrutQ9plV+n7fmY3v2ssq1jIb6AvOqrrCLCKF+mpfMrN+
         +WVf2mnOaDNc76TbS7DQ6Z0Blugq4tE98Gx28Lq7djmQURbtySQcDfoFXUuVwY1uP57s
         c8nHa5UsPTrDY8+iRwt5ZUVJUvCCuMqBZ3VpjnQuj+0lLX/21GWe2ns0rwwrKsksV6N5
         zKlD+9VkemONLADWGcFeVKM42hnbAjiW9Em45Vmy2AoGHmOpBPEeKE5OW17u9su3RqeB
         f2xfyJ9UJmqj0PVPrHQ1ZM6ZKUhrso6SPAyYjykXv+knzJZc+XigKyq6NoUdWqJijB8J
         Qjzw==
X-Gm-Message-State: AOJu0YxoqezgtH4k076byjhp7VKZV4rLVjYAXK9oXZHLfaIMbeRCb4kw
	OTUkTIs/giOmEmL61NjHffNk9YRMcS1uUl4YV2wA0Q==
X-Google-Smtp-Source: AGHT+IGXmrfa4qbmD8PufQBo8ECvg8/RA13eLrik89guDJz1lWQRgT5GoM06ddfpEcVwZ1Qo931DgQ==
X-Received: by 2002:a17:902:8c92:b0:1ca:8b90:1cbd with SMTP id t18-20020a1709028c9200b001ca8b901cbdmr6854012plo.0.1699594952706;
        Thu, 09 Nov 2023 21:42:32 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2071:4479:98b8:cc69])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001b8a00d4f7asm4498845plb.9.2023.11.09.21.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 21:42:32 -0800 (PST)
From: Drew Fustini <dfustini@baylibre.com>
Date: Thu, 09 Nov 2023 21:41:14 -0800
Subject: [PATCH v5 4/7] riscv: defconfig: Enable mmc and dma drivers for
 T-Head TH1520
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-th1520-mmc-v5-4-018bd039cf17@baylibre.com>
References: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
In-Reply-To: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 Conor Dooley <conor@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699594943; l=915;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=ht5Rt9iMCRM1t5yThjxoCTbuOVz3OXmRTAYLzzfd3/s=;
 b=81YrMX/6Pup0Mk4t9Mpny542tULxqVs1k+13xNQqBbmGqkaQgZCsQjsJdqcuxcUGHQdm9Sdy0
 DormnbG2KwrClt9J1tjQHZ3FwqQMqAeqmWYK1a5r2HceKW/UQkdU9DC
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

Enable the mmc controller driver and dma controller driver needed for
T-Head TH1520 based boards, like the LicheePi 4A and BeagleV-Ahead, to
boot from eMMC storage.

Reviewed-by: Guo Ren <guoren@kernel.org>
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


