Return-Path: <linux-mmc+bounces-3-linux-mmc=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7029C04A95
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Nov 2023 17:47:10 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6271AB21336
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Nov 2023 17:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0B23A26F;
	Fri, 10 Nov 2023 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BeGcmYAZ"
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD81031A9E
	for <linux-mmc@vger.kernel.org>; Fri, 10 Nov 2023 17:46:32 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363CB7D83
	for <linux-mmc@vger.kernel.org>; Thu,  9 Nov 2023 22:43:06 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6bee11456baso1587786b3a.1
        for <linux-mmc@vger.kernel.org>; Thu, 09 Nov 2023 22:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699598585; x=1700203385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uci5Rd8hU8lrREOeKMYxmj/9fXU4uXy75tEQ4ik3o2A=;
        b=BeGcmYAZp8vECCpGIn1r9BpM0co1GSQZza9R/GC+yY/3IrIEKQzQLNFsx7p8dyD8zE
         FicTB4v94cAukEFg6B1CogYmCD7LhY+RrnrkWKHkXwcssB8HuovzCgHMzmyaYbTr4bRW
         ieu3bYS9yfw3AMMIC5YDtypxpQJndGqvedTuX68Sb1geNGxC6LHq7fQF6BWHy9fi7CTK
         cNgT9m7Kn8G8zC5UU+8Tdz7Ed+hb6/uXaD7LhBR5XPB3Bn/2waexPzwEMd6vhcug0I3M
         jhlxRACBG0AGc/nDvhKfPZNcfmOKEFgq0EkEGYjZv8V9AoRTQFkb+WZxE5tAzr93GYGK
         RrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598585; x=1700203385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uci5Rd8hU8lrREOeKMYxmj/9fXU4uXy75tEQ4ik3o2A=;
        b=Pd0aLAxY2hhRWkoY8mdhBQzBbEUA1vq5GfhZeQWsNeSE4l+kU8JTAwt6PQON8n+xPI
         KaM5jEW8yVcnChBRQiP24kY7kSRgFFZ/WMEHW/bsIZVcS2ccaMwBoQmjdc5FP5NaBO/W
         rL+webV4criYW2jneHjJFzQtumJvGX6QkCCKzRiIUI5xVg4YfMHYd5FZdqUDnKeoAkVP
         2YWUuotj+X7w0DTCaVVemkFSLEVYimx9lU0SYHbIHEZoNmoz6UPyrL79NGszCeyKYadp
         Tl+a+ZxUhLEK52c65e1NnGpUEV6HjLBhxLGwe1fTzYHm3Zeh9dZUMwRnfmohIF8ve/03
         2W2g==
X-Gm-Message-State: AOJu0Ywl/flfgsXmPZZd+xzHzhmHvwQApNwQG6ZYCP9fvhL6vHySoRkZ
	jDPT0tBDfyrw47oRKCaYbY6IgR+IyNgyhZoPedFgUw==
X-Google-Smtp-Source: AGHT+IEm6KXk26L3ye2gZwOvNYVy1AjnP5ci3hCfE3ga9E1mFtlkQmutISdGpl9sbvobplDpccZsqw==
X-Received: by 2002:a17:902:d506:b0:1cc:3825:7ba2 with SMTP id b6-20020a170902d50600b001cc38257ba2mr8168039plg.4.1699594949041;
        Thu, 09 Nov 2023 21:42:29 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2071:4479:98b8:cc69])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001b8a00d4f7asm4498845plb.9.2023.11.09.21.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 21:42:28 -0800 (PST)
From: Drew Fustini <dfustini@baylibre.com>
Date: Thu, 09 Nov 2023 21:41:12 -0800
Subject: [PATCH v5 2/7] mmc: sdhci: add __sdhci_execute_tuning() to header
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-th1520-mmc-v5-2-018bd039cf17@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699594943; l=2108;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=vV7D9g0JyI+aykknduEYFaEeV4K8xwyLfp1qBkgVUvA=;
 b=wiXFL4D9Q3411BhcGKUB1ePUooVyFCo6lIXJGCjVRVhgVo/MthWkxzFvbNGGV91mDj8tIZhb9
 3ad00+5H/oQC96F88xLLDDeHjyQTU7R4MEvXiEmQLL2+zlo1saaRuND
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

Expose __sdhci_execute_tuning() so that it can be called from the
mmc host controller drivers.

In the sdhci-of-dwcmshc driver, sdhci_dwcmshc_th1520_ops sets
platform_execute_tuning to th1520_execute_tuning(). That function has
to manipulate phy registers before tuning can be performed. To avoid
copying the code verbatim from __sdhci_execute_tuning() into
th1520_execute_tuning(), make it possible for __sdhci_execute_tuning()
to be called from sdhci-of-dwcmshc.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ff41aa56564e..c79f73459915 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2841,7 +2841,7 @@ void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 }
 EXPORT_SYMBOL_GPL(sdhci_send_tuning);
 
-static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
+int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
 	int i;
 
@@ -2879,6 +2879,7 @@ static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 	sdhci_reset_tuning(host);
 	return -EAGAIN;
 }
+EXPORT_SYMBOL_GPL(__sdhci_execute_tuning);
 
 int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f219bdea8f28..a20864fc0641 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -793,6 +793,7 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
 int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
+int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode);
 void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);

-- 
2.34.1


