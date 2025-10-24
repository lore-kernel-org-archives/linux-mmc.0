Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CF5305E24
	for <linux-mmc@vger.kernel.org>; Fri, 24 Oct 2025 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295259; cv=none; b=QkFIy3807yAAIFBXbdldq+uIr7dSThaXI/rJqzHSziuVK8Q6ssSqTuttZAtqesBzjKrCGyqlySNy3lENlkF8tvjBLL1bgsbFPv5ZwoDBo0L44grFY/17C6+ftY8E5UXecxwB4mMXrVHlD7G00zGOGSVxSLWrjLHlNlJ+2FLWcyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295259; c=relaxed/simple;
	bh=B7xgl3RP6gTgFk/aAJqRetM/dnMeClNGbVxvp+14Yuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z+QDm1KmakLJViieXVVebrX5cP+PbAWzdT+6AlGlQvb8E+UhhZpBgOTlRlZMProLLVpopTGK+vud8MGijzixuo6prbW3kRxecnK0G9Ex/I6BesXPgE94VPoa7D0aL/Qt1bATAEwJsEgl/cfh8diTKtj2SaS85TKYtsXZyQ6mvRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t7bQn6Rr; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t7bQn6Rr"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-591c9934e0cso2598546e87.0
        for <linux-mmc@vger.kernel.org>; Fri, 24 Oct 2025 01:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761295256; x=1761900056; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PXJW3n3etM05j9RI0cvZZLfNZoThbUxXAjQHh0dGK4w=;
        b=t7bQn6RrXKmo2LCAXENaT2NpuxBfjrJzNSUaeKPokxnjaX2QUv6pyEnZrUomYBSJh0
         xdqaDHtHuF+pOBJlbaZ9e+c9T0JFjKmIPRvn9Uci8ilMZDc2WWnpfQTq5goRenSFUqO4
         bDmM3mmptnQiq7Yx0Z5YxOHAkzTRAglZ/zV0AaU7bCVMpwrBVFfSbZWj9JimlaTOYe43
         lkGzWPT82tfZryh3edZAiq45PQPgaFNh/RaloZZHsjDJCQqJ/dZoObKU4AH8xfqy2fmz
         U0QuBDy4K+KdyE+xCtR0rVg2jQJ+VO9u2Jk9ln2zklG2NANZMZOOZtPH2ckQO/vsSu2G
         w7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295256; x=1761900056;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXJW3n3etM05j9RI0cvZZLfNZoThbUxXAjQHh0dGK4w=;
        b=r/NRPIXJec5lh8k+Etu2jOaPRQ1BApXHURBFy3Bsi7IQf/bFkPbLpEnCAuUvvJch7n
         8TGyW+uwWn6W1hf6B5/TsyTxkXTDOZzY/t2jC4CErOr1iD788Hpu1ppGKCPFTZyW4typ
         Q2mbcZ0LRxRYdNj0Jxvx173zpRqzfX+1m0rxgoUSNFtePIXhHSH0e57X3bcuxwsGXudk
         62pORZsY07yq8AiOwI4Fqfvu/C1oJTMqOE4nVx7UHgWafI7gL69/LCe5qV1Xo5GSw4Ei
         BQmDAJndNBrDEABJrSHRYXJj/Y+cn7N3acs/+5FRt1a2ggIWfkzyI4le1F4a8XzpkpTq
         dvIg==
X-Gm-Message-State: AOJu0YxBLyKTMWD86hGBAQ4lyD5hruLBdyuYn3Sne044H1rt1cXOxiPX
	Pik1nUzBAmSGvZslqZ4fRfThKkR0iPAVPov3CG7ct/XISDsvwLwfDoluBscJZkkn+8g=
X-Gm-Gg: ASbGncvezzLn5Zm6Hs0EDA0MZnFraeeU6AO6O5z6R7bj309XhialaXi4XXmqsjtqIHh
	8r2PWyr+bAOzm2t0zlJzWkybxXIzIhDUE2UtrEsByFllIDCj9dk3aMnEXA8tPPuXqL21GMea/a2
	4Hc/U1a4b4Jn7RjFrORDw02UREiSofKArna2yNw917mZb6/rp1Ej4chCmAW49YFsyjWx2dhq1RQ
	W6OCaU0fnpsQqdjZQficWq27NUWS6EWz2j7ArjmVarj4mwFevrogRJ07sr8z93fPmzVLWPnHmaq
	UXAICwL84QMhnG5rVxkIhnpuR+15WF9tyUn5PfgjbjvFMx/fXx4jE/pP3X6r/gYDqSSUTkkC9oi
	SsQvkDeO10mSPNz3MIaPxr5waqHghY1w/GY/ObL/7KE/hctvssfntR6Z44Wty/SqU9GH3pTjJPa
	VmcNA2Hh0gPagjW1QG+mPzuw==
X-Google-Smtp-Source: AGHT+IHZrVDU8LWymqgag5IlKymZCkYIFqwlXx+W2dwjEo7kWQLBkeDvba3FKuiZyFglheFWRSwmnA==
X-Received: by 2002:a05:6512:3ca4:b0:592:fc9c:7ad0 with SMTP id 2adb3069b0e04-592fc9c7b59mr508102e87.21.1761295255684;
        Fri, 24 Oct 2025 01:40:55 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4cd20b7sm1457958e87.31.2025.10.24.01.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:40:55 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 24 Oct 2025 10:40:55 +0200
Subject: [PATCH] mmc: sdhci: Disable bounce buffer on SDIO
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-sdhci-bb-regression-v1-1-b57a3d4dbc9f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJY7+2gC/x2MQQqAMAzAviI9W3DFifoV8aCzbr2otCCC+Henx
 0CSG4xV2KAvblA+xWTfMriygJCmLTLKkhmoIu8qqtGWFATnGZWjsn0+TtS0RME3nXeQy0N5leu
 /DuPzvCt8xRNlAAAA
X-Change-ID: 20251024-sdhci-bb-regression-a26822c56951
To: Michael Garofalo <officialtechflashyt@gmail.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, stable@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

As reported by Michael Garofalo, the b43 WLAN driver request
a strict 64 byte block size because of FIFO limitations.

When the bounce buffer is active, all requests will be coalesced
into bigger (up to 64KB) chunks, which breaks SDIO.

Fix this by checking if we are using an SDIO card, and in that
case do not use the bounce buffer.

Link: https://lore.kernel.org/linux-mmc/20251006013700.2272166-1-officialTechflashYT@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/sdhci.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ac7e11f37af71fa5a70eb579fd812227b9347f83..c349e5b507b63a5ee9a9dcb08ac95cae6b3d7075 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -650,6 +650,21 @@ static void sdhci_transfer_pio(struct sdhci_host *host)
 	DBG("PIO transfer complete.\n");
 }
 
+static bool sdhci_use_bounce_buffer(struct sdhci_host *host)
+{
+	/*
+	 * Don't bounce SDIO messages: these need the block size
+	 * to be strictly respected (FIFOs in the device).
+	 */
+	if (mmc_card_sdio(host->mmc->card))
+		return false;
+
+	if (host->bounce_buffer)
+		return true;
+
+	return false;
+}
+
 static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 				  struct mmc_data *data, int cookie)
 {
@@ -663,7 +678,7 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 		return data->sg_count;
 
 	/* Bounce write requests to the bounce buffer */
-	if (host->bounce_buffer) {
+	if (sdhci_use_bounce_buffer(host)) {
 		unsigned int length = data->blksz * data->blocks;
 
 		if (length > host->bounce_buffer_size) {
@@ -890,7 +905,7 @@ static void sdhci_set_adma_addr(struct sdhci_host *host, dma_addr_t addr)
 
 static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
 {
-	if (host->bounce_buffer)
+	if (sdhci_use_bounce_buffer(host))
 		return host->bounce_addr;
 	else
 		return sg_dma_address(host->data->sg);
@@ -3030,7 +3045,7 @@ static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
 	 * for that we would need two bounce buffers since one buffer is
 	 * in flight when this is getting called.
 	 */
-	if (host->flags & SDHCI_REQ_USE_DMA && !host->bounce_buffer)
+	if (host->flags & SDHCI_REQ_USE_DMA && !sdhci_use_bounce_buffer(host))
 		sdhci_pre_dma_transfer(host, mrq->data, COOKIE_PRE_MAPPED);
 }
 
@@ -3104,7 +3119,7 @@ void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq)
 	struct mmc_data *data = mrq->data;
 
 	if (data && data->host_cookie == COOKIE_MAPPED) {
-		if (host->bounce_buffer) {
+		if (sdhci_use_bounce_buffer(host)) {
 			/*
 			 * On reads, copy the bounced data into the
 			 * sglist

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251024-sdhci-bb-regression-a26822c56951

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

