Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2B2257B
	for <linux-mmc@vger.kernel.org>; Sat, 27 Jan 2024 00:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314820; cv=none; b=d2oIAqx0gGSBlg1dCUjKqFAM1e44Zq2Asn7kqRyaZEPPprzlltbNv8RdHRPGzHiW5cSqX2DW11BF3NR/YEyzya8GdtztUN0wV3vFFOeur2JocM0TQy7PkLt/04HFik9pTJZo1tCFu8TPlomc8py+XLphoXMZX/3PqzojwOV+Jm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314820; c=relaxed/simple;
	bh=E9ziAqKRF7avg+9XAu41DqCMnZeKd+R+sbDJSS4jrKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uMMphE5gPK/KgHOTEil/TUH3ekWyFVM6SElpx8bkf9EhKajdZOvX6IsuI6tVraw1iRWTDf3NIxrTkexDyVuw/G8erJ5mL2Xu1doFPMLDry6Kbn70rZxhBnCLWMhnwZgtZADu4RskeNrEA4V5skTjBXNgYQn/X8OrM3T0zKdEpqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=emnVVWLe; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="emnVVWLe"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5101f2dfdadso1743403e87.2
        for <linux-mmc@vger.kernel.org>; Fri, 26 Jan 2024 16:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706314814; x=1706919614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5SahCLN1505rQ5cLqj1DAZZAA4U+IFMjOwfguXW3/Y=;
        b=emnVVWLeg/3uw0D7kDOuch6/gCpWAf6ndV4K4LdzZ0euGS/eUBi3wm0zFBLkkWZhcs
         2s21lonvVDaMr2EZNprRN/VRd7ta7FYKfBkniU2TnjMpQKEXjoFTeh86V0Bk7Xq0Vv2y
         WVug8eifCUjXeVoZbOyREIVijrrWUe8iUC0x9vPvFjn8lyMQ1nnwFMJHkEaYSqt06kyR
         AW5VPt1C6h1PjU1M7+aAu4oYxHysvUB0DASsvX2Ue/aW2Qpp3WpI3jRJvzl/OQc/nH8L
         Y9tzy2YuqBL1EWbUs7vxVWX5PzYO1xlNzGykYl7KmI818V0ZKZcHunSjIL2wwfwzTA9f
         Zw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706314814; x=1706919614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5SahCLN1505rQ5cLqj1DAZZAA4U+IFMjOwfguXW3/Y=;
        b=sdKo3NS1XHMu+kXSF1IduI4vE3CvrZyIGii9mwUs6nyZMyxSjGjSuWOeFMK1YOW6y3
         3FfgawBWfQJlcxSnoL0vz9A1KISrwQ50IkZljWviuBCYOHBUz6lIM7ksT720XuymuUtx
         0g5QWFnJ5Drf9ARWNW6rLN1qJ4q773VEItgR6bdpDXQDicA5GFbNz78pcIXtdi9GoQjX
         s7JoVx55LhFzGOgK+dNW0jLNzV4U8wUYcvjmWTKp+RwFaXIwhcaCN9IQZqihyFdEvveJ
         aPBToQzYweW/UCRpaLVJcxYn1lztGsUHs+LW/dtBCdW8oj3RsYYG70vnjEfBYJ0vEPaw
         QEOg==
X-Gm-Message-State: AOJu0YwGpVTN+EVaV1oGKmsjO3ZbUP/KCjpfl5gflGI5qPip+b3saRNJ
	s/fJ6xrP75PTiK5o29UDzqttIqESYYzQw0BgkIqIXJGBnz6Ec8meeaLmIro0c3w=
X-Google-Smtp-Source: AGHT+IFc5/iBp3Z+YfgOFibaw+mJcjoLiqn1ysw4Wwecz9Q0A3UtJBPMsKwdVvx3H7ibywtjZio/1w==
X-Received: by 2002:a05:6512:3b0e:b0:50e:b23c:e37 with SMTP id f14-20020a0565123b0e00b0050eb23c0e37mr373430lfv.48.1706314813988;
        Fri, 26 Jan 2024 16:20:13 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id x25-20020a19f619000000b0050e7f5cffa6sm325226lfe.273.2024.01.26.16.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 16:20:12 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 27 Jan 2024 01:19:49 +0100
Subject: [PATCH v2 2/9] mmc: moxart-mmc: Factor out moxart_use_dma() helper
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240127-mmc-proper-kmap-v2-2-d8e732aa97d1@linaro.org>
References: <20240127-mmc-proper-kmap-v2-0-d8e732aa97d1@linaro.org>
In-Reply-To: <20240127-mmc-proper-kmap-v2-0-d8e732aa97d1@linaro.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
 Ming Lei <ming.lei@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Angelo Dureghello <angelo.dureghello@timesys.com>
Cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The same code is in two places and we will add a third place.
Break this out into its own function.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/moxart-mmc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 5cfdd3a86e54..d12d7d79b19c 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -254,6 +254,11 @@ static void moxart_dma_complete(void *param)
 	complete(&host->dma_complete);
 }
 
+static bool moxart_use_dma(struct moxart_host *host)
+{
+	return (host->data_len > host->fifo_width) && host->have_dma;
+}
+
 static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
 {
 	u32 len, dir_slave;
@@ -375,7 +380,7 @@ static void moxart_prepare_data(struct moxart_host *host)
 	if (data->flags & MMC_DATA_WRITE)
 		datactrl |= DCR_DATA_WRITE;
 
-	if ((host->data_len > host->fifo_width) && host->have_dma)
+	if (moxart_use_dma(host))
 		datactrl |= DCR_DMA_EN;
 
 	writel(DCR_DATA_FIFO_RESET, host->base + REG_DATA_CONTROL);
@@ -407,7 +412,7 @@ static void moxart_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	moxart_send_command(host, host->mrq->cmd);
 
 	if (mrq->cmd->data) {
-		if ((host->data_len > host->fifo_width) && host->have_dma) {
+		if (moxart_use_dma(host)) {
 
 			writel(CARD_CHANGE, host->base + REG_INTERRUPT_MASK);
 

-- 
2.34.1

