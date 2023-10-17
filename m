Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D07CDB474
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Oct 2023 20:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjJQUpZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Oct 2023 16:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344424AbjJQUpY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Oct 2023 16:45:24 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A603EF0
        for <linux-mmc@vger.kernel.org>; Tue, 17 Oct 2023 13:45:22 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5aa481d53e5so2917580a12.1
        for <linux-mmc@vger.kernel.org>; Tue, 17 Oct 2023 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697575522; x=1698180322; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l++Rbeq1YJ0LFMw4HKx/yirX8siQghzI93qQn3u3z5E=;
        b=O41QGRQrrEn5Bz/20z5yWLS8Tz2bNmcoxrp5BHoDLhilCumn/bet7OaIN/Ys/EGpqk
         ntEKFlTRlc4vri3sgiw8XTMtYHUl9EqhwrvIaDzgRkJXmSKEq4GlkMffsmuC/Zc9vA7K
         IJrzJ38FJZGtALlJFB7ZAcADQ2etVXHNw64UzJgPn3tcGGuJ2D85V7YGoPqgxnFDgl9e
         nkATW6F4erlkVou4XITC//ycyl+1dPMB4RsB42giBgX3RoKTM+rV/pjx1bpYLamOBlML
         Hq5n3Bmaiwo4Jz16tEee26lYDgrGSPDuBM2IJNwkeisRNTsFHaeN8aiGwHmWynrwAv9V
         SSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697575522; x=1698180322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l++Rbeq1YJ0LFMw4HKx/yirX8siQghzI93qQn3u3z5E=;
        b=pgxMSsGhy5o5HNpVXD3lnomLWFsO1dQVPfEaPzDbjbZrUwDQgx+PbwTvWjXQMM8BUU
         bEuZQ6mTGH4eu5qsWFqmEcyr0H5FqZd6pFqcnTqU4cyxQQX8vdw+CB5rZVhzQvCQ3smk
         WIpGlh1ky51cxogtDtsn9owz3NRkoyJdCizfIeUiyzXU96As2QJT1C/AZNOJVQhI+wh7
         pPKlvZHeGq+uVUD8Gw76bruYKIrWbLkwvYa+PE0Jp67Kd3b9lDSn/YI90XpQ9R6AMgJh
         1M8J/Dl9EhtfOCd4QgJ0INkZ3OiBg70bwkcrgUHW5jkcdE3EQFQd9ZHb6kIbhLRhZAR2
         dgsA==
X-Gm-Message-State: AOJu0YytwbHLtAy/46mya5gQdA6sMNkY//x0oOm8m+dXEWqzcpWFKy6p
        gdhuhR9hmjapDO8apxCBPEjgHQ==
X-Google-Smtp-Source: AGHT+IH2HIA6RrygyCLHn+pnH/xzYDgYUhE7gBrRmb+swqKkRH2PL2gIr28xi6sn4VY6/H8Hua8htQ==
X-Received: by 2002:a17:90b:1097:b0:27d:24d6:7343 with SMTP id gj23-20020a17090b109700b0027d24d67343mr3378879pjb.19.1697575522030;
        Tue, 17 Oct 2023 13:45:22 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:51d6:dcd6:63ef:52e9])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090a6b8300b0027b168cb011sm1906553pjj.56.2023.10.17.13.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:45:21 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Tue, 17 Oct 2023 13:43:48 -0700
Subject: [PATCH v2 2/7] mmc: sdhci: add __sdhci_execute_tuning() to header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231017-th1520-mmc-v2-2-4678c8cc4048@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697575515; l=2057;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=O0pl7kPWnknxTc+1ciCix3vi2PmSyK8UTzQqhv8rZP0=;
 b=c6MNN19+LVa+YXw8BVIwdqx0H9tnKqK0U5fbdhUSgz7AcvpDWhHyDwOlUig3M0ucf+4RwI6E4
 UqlGbcLac7HAbSsrCd3MB60tM6ZE9sf10n3goXEu6+eNFsYQiMZJghN
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Expose __sdhci_execute_tuning() so that it can be called from the
mmc host controller drivers.

In the sdhci-of-dwcmshc driver, sdhci_dwcmshc_th1520_ops sets
platform_execute_tuning to th1520_execute_tuning(). That function has
to manipulate phy registers before tuning can be performed. To avoid
copying the code verbatim from __sdhci_execute_tuning() into
th1520_execute_tuning(), make it possible for __sdhci_execute_tuning()
to be called from sdhci-of-dwcmshc.

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

