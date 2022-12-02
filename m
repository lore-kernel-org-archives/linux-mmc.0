Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AE1C4332F
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 03:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiLBDOA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Dec 2022 22:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiLBDN6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2022 22:13:58 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78980D49DB
        for <linux-mmc@vger.kernel.org>; Thu,  1 Dec 2022 19:13:57 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id k5so3690052pjo.5
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2022 19:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ym9YTdhefXOHHkd3Jf4XxEyW1/V8EXozYna2j5niSpo=;
        b=PDjsxCWo+qZ79bbBq4qHpmcDxR9sR3rSO23hLyzgQHSTrzDIOvnMZBnQcYP00pnFuz
         6Q0tJqxg+6Rd9XG3zv3fOj8ww1c99qYnNB3mGBO9T8IRGx4ZryIK9m3atpCrJxfBP99t
         w7M4y0AQzJTZF3yKEy7YbCubW3Td4Pv85SuxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ym9YTdhefXOHHkd3Jf4XxEyW1/V8EXozYna2j5niSpo=;
        b=vR/K+WS5dm54LnXpAbvgWSksa0ZWqnqQZM1qRnMvsSJwkC5oneaqXg0wEUOKva8Dg1
         OxoeRvLMCDIqqc34Ge22ZK7GNSTf1e1HdVEPNWkUa3UaFPDZZ6LVU0D7AOnS5Z5FqIcF
         RbLrSO44F7vV1SKQ2WanMnIksqsBG+OgN57NG7oVAGnAnFTxuWUHQmpVujZrbzRDGNJT
         SDLuOtGRKL052fr4jmoRUaKxM0FihQneq2l928nRlFbeSgmV1i0eDeV+C6mRZH/gQgSN
         2FLc2o4dewhKXdJ/Pd64DXM9yD6jPSzH8RNrbAEznnCC3XWrBtzzwmVbeU2Fe4WAUbG/
         IMIw==
X-Gm-Message-State: ANoB5plaQLWnSTOyzLXGRjNoBuSGYsOusgB0i6WZBZgCruPRei8Fq7+P
        GLSXjigN8gmA4vOSy5OVvcbP9g==
X-Google-Smtp-Source: AA0mqf5ZYpxHSgY7GvM3UxFAtjuVFa98HNtyC+pVpnUKJeJ++FHDcyWIP/eOqg/y+5EE3Fc0EqnAow==
X-Received: by 2002:a17:902:dacd:b0:189:6889:c30a with SMTP id q13-20020a170902dacd00b001896889c30amr34384066plx.6.1669950836835;
        Thu, 01 Dec 2022 19:13:56 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id jx24-20020a17090b46d800b00213202d77d9sm3708410pjb.43.2022.12.01.19.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 19:13:56 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 3/8] mmc: sdhci-pxav2: add register workaround for PXA168 silicon bug
Date:   Thu,  1 Dec 2022 19:13:25 -0800
Message-Id: <20221202031330.94130-4-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221202031330.94130-1-doug@schmorgal.com>
References: <20221202031330.94130-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The PXA168 has a documented silicon bug that results in a data abort
exception when accessing the SDHCI_HOST_VERSION register on SDH2 and
SDH4 through a 16-bit read. Implement the workaround described in the
errata, which performs a 32-bit read from a lower address instead. This
is safe to use on all four SDH peripherals.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 2f9fa0ecbddd..0a16098b963f 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -80,6 +80,15 @@ static void pxav2_reset(struct sdhci_host *host, u8 mask)
 	}
 }
 
+static u16 pxav1_readw(struct sdhci_host *host, int reg)
+{
+	/* Workaround for data abort exception on SDH2 and SDH4 on PXA168 */
+	if (reg == SDHCI_HOST_VERSION)
+		return readl(host->ioaddr + SDHCI_HOST_VERSION - 2) >> 16;
+
+	return readw(host->ioaddr + reg);
+}
+
 static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
 {
 	u8 ctrl;
@@ -102,6 +111,7 @@ static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
 }
 
 static const struct sdhci_ops pxav1_sdhci_ops = {
+	.read_w        = pxav1_readw,
 	.set_clock     = sdhci_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width = pxav2_mmc_set_bus_width,
-- 
2.34.1

