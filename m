Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730657;
	b=UzYLai1nXhd+BwRIVSD3WSaMmRfHPJLqh8kznEIGZHKYSdOvZ5KcTXAg0TLd2y+WKdk/
	 G9eTBe0kDqSApXQfTx57Rs0oaIgQVtz/6u06S0bLE0Ms8JZKldEddx+4vM3FLHYNAE1bF
	 5OlLawmsvzff/1vS3AdFHCPXIWBLSRRsBKTz/QNLGYgHo1x5QhQRxtebEOahdXqkq+Psi
	 V++iV4kcO1F+KrUXdKKAezShYJPCpD6ncd93onB1D8oujq78Z56Uxdfrvu7UVurkWHgLY
	 pAHTdtL705+H7PIsZh1PPAvNljpkg4PvHyYMDT06SHPxJ5CPLsneWIBePG/fYltxjCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rYT7p8+zm03NFYU5ZsNb8qxdeF22ftPPPmoAm+D/1Kk=;
	b=YFpn172EfFUTuOj9IvWpQ6hOuHSLA8z0/UHN/47S3zZBXsE+c2/gJGLMy6XhIBCTf8fI
	 4G8BqfUFkZzM9NwAZvovPVM4Gru6CKlnHkpyylKxuGhEyyhrTUe+hTWpSG2cVdH86IMxe
	 IuD2GxV/uEKlX8AIou0RSwJWuG8BGgXlrJfyDX6xclchAuv+7rTpjK9bgzbWUdMkRbop5
	 wsQ2KnMgiyd3A0WH9XroUdBVZvfTPg2Gw/idTBdrWtyiTgt7DMvI8Nd1tW7qEsHUg9LT8
	 7HzkMUMh1gQIQvnEYpkoxgJNb7Ttiu4856j5O45enX3iCENPNLXXqoOGe2gTOhjMhNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CVZmUfFg;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49C606A338
	for <linux-mmc@vger.kernel.org>; Tue,  3 Nov 2026 18:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED49C606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CVZmUfFg
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so40944715e9.3
        for <linux-mmc@vger.kernel.org>; Tue, 03 Nov 2026 10:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793730654; x=1794335454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rYT7p8+zm03NFYU5ZsNb8qxdeF22ftPPPmoAm+D/1Kk=;
        b=CVZmUfFgLXtSRJzMH98OfgikTs87Dlkg7bLFH0ntsmAPv1k4SezDKS2kINt9Vq++SK
         7bbZ/s37QXfui59bHjUcwoNF/sWQ1QVLXLA15/BGLFrWtxXYH5NGKnatFSijvejU0gVg
         9vUhefrzVc2x2CHVaDk/eTMt+CMTGytd9Aah095+odugYxu48IuRMBBUKJPxzxf0zSss
         tCJme8MH8C74vgC0Y5KXe+b5wHw4Q4ph7R9v4/qntUl9VRym3Zx4FmqMEP9R2iNtU/RP
         a97Jc+jY7nhx8JGA2bDBF2lwW7GhFCJvlgO+G/Voi4KD8RHf8liI66GnkinvLxPxRmVz
         zPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730654; x=1794335454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rYT7p8+zm03NFYU5ZsNb8qxdeF22ftPPPmoAm+D/1Kk=;
        b=IyakBKDD4k7gFL1dl21MGq28u8dcXddvLgXofEv98Zs07F73pj8aBgvtEuqGPaYwH1
         3Hj0Te+D+lU/8NRiJ1HykXU3uS1SuVHKCiQCcBR6BHPSFTR5jxoDAOiOmAaCBFD2fDRa
         nioPVb/9ot42eR/JT1HxdlXYqOziRWzkmKsnj718VvUYLP3ljZ0l3tVFnd7+c8vZKzLN
         gTjJP5pbr1eISzQiXi+3EzJTuIyRpPRilPFN+RWK4QX/pgRHPi4Z2vpBefF4AVBojlNc
         FYePfXsyqgrS2tDqsDfDiU0tEwchudjLF9AyR1HtZYayhe7d/3EFmV6Yjs1wRnK5kjvK
         8RXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfaVXlUH7tORZXaMkg/OOmH6Ohig0ZjQtZvLO0lmZmzltUIurCVypjQXliD2yWjfqOX7NHRoSVlYA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/82RmuAejr+y+ZIImdAdJtRR+gHPH6x/XnePEFEJ+d7o3BI3rl
	i9ccApBECBYzbMu15V61oU2WGrnMudJMdE8BC0jC/230y6vN09flB0ej
X-Gm-Gg: AYBFou0dx9BysMBaYzoKcN0HMHn/bFxKHkHnizU0Wy8ztLM8yaET0tZUw9nRStQnHUc
	42zAC8kQUpN/mytwyjEl9r1o3AiHZFWROVK2wJFkraT5NAzQ0jlYytqcpcyrWaDIpDcELv2V4HT
	SDijEdUolXCQ7RBz4PADZmxeaja857yYxvx6IzC5vuci800gCLJ7ANrUy3Uz9WhLsumbnDXdNDN
	fSg5mxM6+yYzkgtIsNPec8PRpVh4WLe+ZuQdixqMpw3/R2L0aEZm9pLg7Qhs4IXB0lZVYESSNvd
	Vk0JFL2B9hJpRD86LW1WKvf/0aXeaLx0bhNRg3gTkHwR61f2ICVCn2BNvFJT6vvsQvQwOFA1v9x
	59xpsmt3OGiAXeVqly8i9rv5XS5JI9OqNycOAXSdw9eHHT/xPN59PEVrCWR6hhCD+zQO5Tv/M0r
	dLM4NJNJ6MJ4yVCwNPU6gf0+jB/6kd1tiQnIE5m/7UfsP18BM5vLWMFsZF9UkT22VuvgjcbheRF
	AwAGApFVkbh1nfiEEZWhHG6JpLLx/Q786O3nQ4IyhtDXHYGICBJmSNNUEydtbtJk+efGQ71pS/T
	3HJ2VPBTyifo3WxFVp5uXdvI81mJqa2HpoxCyRXPefqA2fW42FdUzyfOBjAiRiotCKe5OVkPxnO
	Tu6yQ/qKdOUCIArkiv5i5pz/xr8WEEV7xareNVqq6I3diTIa7iBDMzaNT2w6yaIq8D4Zp34lfzX
	3xOEhVJjCvyhiU7NcTa3QQrgWc7bhehMfJdh1498JnhAsL7nOwrOdGEZ84+vX7kg/78BUi036Jj
	8zmSVuw1NlPeqzisdj0AcmFDIGdt1JGzSIj0w8tqwk16n3C1Q==
X-Received: by 2002:a05:600c:19c9:b0:4a1:7c7d:8881 with SMTP id 5b1f17b1804b1-4ac182dcb6fmr314872025e9.13.1793730654277;
        Tue, 03 Nov 2026 10:30:54 -0800 (PST)
Received: from jernej-laptop (194-152-27-116.dynamic.telemach.net. [194.152.27.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab00ff3dsm146339785e9.14.2026.11.03.10.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:30:53 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Anfernee Cao <anferneemelokc5@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 3/4] mmc: sunxi: Build IDMA descriptors from mapped SG list
Date: Tue,  3 Nov 2026 19:30:29 +0100
Message-ID: <20261103183030.81078-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103183030.81078-1-jernej.skrabec@gmail.com>
References: <20261103183030.81078-1-jernej.skrabec@gmail.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_map_sg() may merge scatterlist entries and returns the number of
resulting DMA segments. The DMA API requires using only that many
segments, with sg_dma_address() and sg_dma_len() (see
Documentation/core-api/dma-api.rst).

The driver instead builds one descriptor per original entry and uses
its CPU side length. Build the descriptors from the mapped segments
instead, and split segments longer than one descriptor can handle.
This can't overflow the descriptor table, as each original entry fits
into a single descriptor.

Also check the alignment of the mapped segments, and unmap the
scatterlist when it is misaligned instead of leaking the mapping.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/mmc/host/sunxi-mmc.c | 91 +++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 479420071c2d..b875ef4c2b79 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -356,36 +356,49 @@ static int sunxi_mmc_init_host(struct sunxi_mmc_host *host)
 }
 
 static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
-				    struct mmc_data *data)
+				     struct mmc_data *data, int nents)
 {
 	struct sunxi_idma_des *pdes = (struct sunxi_idma_des *)host->sg_cpu;
 	dma_addr_t next_desc = host->sg_dma;
-	int i, max_len = (1 << host->cfg->idma_des_size_bits);
-
-	for (i = 0; i < data->sg_len; i++) {
-		pdes[i].config = cpu_to_le32(SDXC_IDMAC_DES0_CH |
-					     SDXC_IDMAC_DES0_OWN |
-					     SDXC_IDMAC_DES0_DIC);
-
-		if (data->sg[i].length == max_len)
-			pdes[i].buf_size = 0; /* 0 == max_len */
-		else
-			pdes[i].buf_size = cpu_to_le32(data->sg[i].length);
-
-		next_desc += sizeof(struct sunxi_idma_des);
-		pdes[i].buf_addr_ptr1 =
-			cpu_to_le32(sg_dma_address(&data->sg[i]) >>
-				    host->cfg->idma_des_shift);
-		pdes[i].buf_addr_ptr2 =
-			cpu_to_le32(next_desc >>
-				    host->cfg->idma_des_shift);
+	unsigned int max_len = 1 << host->cfg->idma_des_size_bits;
+	unsigned int i, d = 0;
+	struct scatterlist *sg;
+
+	/* dma_map_sg() may merge entries beyond the descriptor size. */
+	for_each_sg(data->sg, sg, nents, i) {
+		dma_addr_t addr = sg_dma_address(sg);
+		unsigned int len = sg_dma_len(sg);
+
+		while (len) {
+			unsigned int chunk = min(len, max_len);
+
+			pdes[d].config = cpu_to_le32(SDXC_IDMAC_DES0_CH |
+						     SDXC_IDMAC_DES0_OWN |
+						     SDXC_IDMAC_DES0_DIC);
+
+			if (chunk == max_len)
+				pdes[d].buf_size = 0; /* 0 == max_len */
+			else
+				pdes[d].buf_size = cpu_to_le32(chunk);
+
+			next_desc += sizeof(struct sunxi_idma_des);
+			pdes[d].buf_addr_ptr1 =
+				cpu_to_le32(addr >> host->cfg->idma_des_shift);
+			pdes[d].buf_addr_ptr2 =
+				cpu_to_le32(next_desc >>
+					    host->cfg->idma_des_shift);
+
+			addr += chunk;
+			len -= chunk;
+			d++;
+		}
 	}
 
 	pdes[0].config |= cpu_to_le32(SDXC_IDMAC_DES0_FD);
-	pdes[i - 1].config |= cpu_to_le32(SDXC_IDMAC_DES0_LD |
+	pdes[d - 1].config |= cpu_to_le32(SDXC_IDMAC_DES0_LD |
 					  SDXC_IDMAC_DES0_ER);
-	pdes[i - 1].config &= cpu_to_le32(~SDXC_IDMAC_DES0_DIC);
-	pdes[i - 1].buf_addr_ptr2 = 0;
+	pdes[d - 1].config &= cpu_to_le32(~SDXC_IDMAC_DES0_DIC);
+	pdes[d - 1].buf_addr_ptr2 = 0;
 
 	/*
 	 * Avoid the io-store starting the idmac hitting io-mem before the
@@ -397,7 +410,7 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
 static int sunxi_mmc_map_dma(struct sunxi_mmc_host *host,
 			     struct mmc_data *data)
 {
-	u32 i, dma_len;
+	int i, dma_len;
 	struct scatterlist *sg;
 
 	dma_len = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
@@ -407,24 +420,28 @@ static int sunxi_mmc_map_dma(struct sunxi_mmc_host *host,
 		return -ENOMEM;
 	}
 
-	for_each_sg(data->sg, sg, data->sg_len, i) {
-		if (sg->offset & 3 || sg->length & 3) {
+	for_each_sg(data->sg, sg, dma_len, i) {
+		dma_addr_t addr = sg_dma_address(sg);
+
+		if (addr & 3 || sg_dma_len(sg) & 3) {
 			dev_err(mmc_dev(host->mmc),
-				"unaligned scatterlist: os %x length %d\n",
-				sg->offset, sg->length);
+				"unaligned DMA segment: address %pad length %u\n",
+				&addr, sg_dma_len(sg));
+			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
+				     data->sg_len, mmc_get_dma_dir(data));
 			return -EINVAL;
 		}
 	}
 
-	return 0;
+	return dma_len;
 }
 
 static void sunxi_mmc_start_dma(struct sunxi_mmc_host *host,
-				struct mmc_data *data)
+				struct mmc_data *data, int nents)
 {
 	u32 rval;
 
-	sunxi_mmc_init_idma_des(host, data);
+	sunxi_mmc_init_idma_des(host, data, nents);
 
 	rval = mmc_readl(host, REG_GCTRL);
 	rval |= SDXC_DMA_ENABLE_BIT;
@@ -1016,7 +1033,7 @@ static void sunxi_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	u32 imask = SDXC_INTERRUPT_ERROR_BIT;
 	u32 cmd_val = SDXC_START | (cmd->opcode & 0x3f);
 	bool wait_dma = host->wait_dma;
-	int ret;
+	int nents = 0;
 
 	/* Check for set_ios errors (should never happen) */
 	if (host->ferror) {
@@ -1026,11 +1043,11 @@ static void sunxi_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	}
 
 	if (data) {
-		ret = sunxi_mmc_map_dma(host, data);
-		if (ret < 0) {
+		nents = sunxi_mmc_map_dma(host, data);
+		if (nents < 0) {
 			dev_err(mmc_dev(mmc), "map DMA failed\n");
-			cmd->error = ret;
-			data->error = ret;
+			cmd->error = nents;
+			data->error = nents;
 			mmc_request_done(mmc, mrq);
 			return;
 		}
@@ -1091,7 +1108,7 @@ static void sunxi_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (data) {
 		mmc_writel(host, REG_BLKSZ, data->blksz);
 		mmc_writel(host, REG_BCNTR, data->blksz * data->blocks);
-		sunxi_mmc_start_dma(host, data);
+		sunxi_mmc_start_dma(host, data, nents);
 	}
 
 	host->mrq = mrq;
-- 
2.43.0

