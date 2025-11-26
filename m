Received: from mail-m49229.qiye.163.com (mail-m49229.qiye.163.com [45.254.49.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8983595D
	for <linux-mmc@vger.kernel.org>; Wed, 26 Nov 2025 00:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764116153; cv=none; b=g7Wf6Hq4mFOtZixNUGU/FHVG2eacmZaKKIZokbu6k8CKDsOD0sD48dgi5ZkyWJAl6cidhIB3edwJYLv7sBgqvUr+JGvtXP1hBFJhjvlXvGf9hHtBMp87A8/NPmzYK3PixCr+yb7FGt+DZ/24lfEDHVl8YtRjji0yF5oghkjsmoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764116153; c=relaxed/simple;
	bh=PhQnpPpMINUvfdzdA0o4ZAe6V/F8FJhFaMwCT6X45oA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JdyxddlIi8rSwPMuDF3aHsLuLDA7nRZSa0m87ODCRSoq9PQ26czjNq0/LdqLaUPV1VP+gR1zeZycw5cv5+BTbvBERF2RVyiLW3MBGRIhFmb0M9h83dN6p+pA8wWS8PZ/f/rBiLZLa5lLWYj4wnjwtDSXwgjdWCXWvVDUcSvdyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jnt1wznX; arc=none smtp.client-ip=45.254.49.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jnt1wznX"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ae3412fc;
	Wed, 26 Nov 2025 08:15:39 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 02/13] mmc: dw_mmc: add dw_mci_prepare_desc() for both of 32bit and 64bit DMA
Date: Wed, 26 Nov 2025 08:14:42 +0800
Message-Id: <1764116093-5430-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
References: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9abd840f7209cckunme6f559504dcf71
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxhPQ1ZPHRpCQh5DT0gdSxhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=jnt1wznXjroPDwjnP0uA34oO7J95agBVDcpXlNqi796QRQWsVIRbK+xx+7qZVmwO3w3TgzgycOkaOFF00guEqOuDri8Dn56ZRrC4GMyFQyjpqMigl47wA4mvBz2qn8gS2xeTjDH51tL/vQgaoSlAevrirWnHOa1e8n6lNfcBn3Q=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=xBaTvlLo6J2qicV0eIsmkU+X+OXXhRlA8bcN/5kNKDk=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

dw_mci_prepare_desc64() and dw_mci_prepare_desc32() duplicate a lot of
code, add a new dw_mci_prepare_desc() to save the bits.

No functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2:
- Fix sparse warning

 drivers/mmc/host/dw_mmc.c | 155 +++++++++++++++-------------------------------
 1 file changed, 49 insertions(+), 106 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9e74b67..2d81d021 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -575,16 +575,19 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 	return 0;
 }
 
-static inline int dw_mci_prepare_desc64(struct dw_mci *host,
-					 struct mmc_data *data,
-					 unsigned int sg_len)
+static inline int dw_mci_prepare_desc(struct dw_mci *host, struct mmc_data *data,
+				      unsigned int sg_len, bool is_64bit)
 {
 	unsigned int desc_len;
-	struct idmac_desc_64addr *desc_first, *desc_last, *desc;
-	u32 val;
-	int i;
+	struct idmac_desc *desc_first, *desc_last, *desc;
+	struct idmac_desc_64addr *desc64_first, *desc64_last, *desc64;
+	u32 val, des0;
+	int i, err;
 
-	desc_first = desc_last = desc = host->sg_cpu;
+	if (is_64bit)
+		desc64_first = desc64_last = desc64 = host->sg_cpu;
+	else
+		desc_first = desc_last = desc = host->sg_cpu;
 
 	for (i = 0; i < sg_len; i++) {
 		unsigned int length = sg_dma_len(&data->sg[i]);
@@ -603,113 +606,57 @@ static inline int dw_mci_prepare_desc64(struct dw_mci *host,
 			 * isn't still owned by IDMAC as IDMAC's write
 			 * ops and CPU's read ops are asynchronous.
 			 */
-			if (readl_poll_timeout_atomic(&desc->des0, val,
-						!(val & IDMAC_DES0_OWN),
-						10, 100 * USEC_PER_MSEC))
+			if (is_64bit)
+				err = readl_poll_timeout_atomic(&desc64->des0, val,
+					IDMAC_OWN_CLR64(val), 10, 100 * USEC_PER_MSEC);
+			else
+				err = readl_poll_timeout_atomic(&desc->des0, val,
+					IDMAC_OWN_CLR64(val), 10, 100 * USEC_PER_MSEC);
+			if (err)
 				goto err_own_bit;
 
-			/*
-			 * Set the OWN bit and disable interrupts
-			 * for this descriptor
-			 */
-			desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC |
-						IDMAC_DES0_CH;
-
-			/* Buffer length */
-			IDMAC_64ADDR_SET_BUFFER1_SIZE(desc, desc_len);
-
-			/* Physical address to DMA to/from */
-			desc->des4 = mem_addr & 0xffffffff;
-			desc->des5 = mem_addr >> 32;
-
-			/* Update physical address for the next desc */
-			mem_addr += desc_len;
-
-			/* Save pointer to the last descriptor */
-			desc_last = desc;
-		}
-	}
-
-	/* Set first descriptor */
-	desc_first->des0 |= IDMAC_DES0_FD;
-
-	/* Set last descriptor */
-	desc_last->des0 &= ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
-	desc_last->des0 |= IDMAC_DES0_LD;
-
-	return 0;
-err_own_bit:
-	/* restore the descriptor chain as it's polluted */
-	dev_dbg(host->dev, "descriptor is still owned by IDMAC.\n");
-	memset(host->sg_cpu, 0, DESC_RING_BUF_SZ);
-	dw_mci_idmac_init(host);
-	return -EINVAL;
-}
-
-
-static inline int dw_mci_prepare_desc32(struct dw_mci *host,
-					 struct mmc_data *data,
-					 unsigned int sg_len)
-{
-	unsigned int desc_len;
-	struct idmac_desc *desc_first, *desc_last, *desc;
-	u32 val;
-	int i;
-
-	desc_first = desc_last = desc = host->sg_cpu;
-
-	for (i = 0; i < sg_len; i++) {
-		unsigned int length = sg_dma_len(&data->sg[i]);
-
-		u32 mem_addr = sg_dma_address(&data->sg[i]);
-
-		for ( ; length ; desc++) {
-			desc_len = (length <= DW_MCI_DESC_DATA_LENGTH) ?
-				   length : DW_MCI_DESC_DATA_LENGTH;
-
-			length -= desc_len;
-
-			/*
-			 * Wait for the former clear OWN bit operation
-			 * of IDMAC to make sure that this descriptor
-			 * isn't still owned by IDMAC as IDMAC's write
-			 * ops and CPU's read ops are asynchronous.
-			 */
-			if (readl_poll_timeout_atomic(&desc->des0, val,
-						      IDMAC_OWN_CLR64(val),
-						      10,
-						      100 * USEC_PER_MSEC))
-				goto err_own_bit;
+			des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC | IDMAC_DES0_CH;
+			if (is_64bit)
+				desc64->des0 = des0;
+			else
+				desc->des0 = cpu_to_le32(des0);
 
 			/*
-			 * Set the OWN bit and disable interrupts
-			 * for this descriptor
+			 * 1. Set OWN bit and disable interrupts for this descriptor
+			 * 2. Set Buffer length
+			 * Set physical address to DMA to/from
 			 */
-			desc->des0 = cpu_to_le32(IDMAC_DES0_OWN |
-						 IDMAC_DES0_DIC |
-						 IDMAC_DES0_CH);
-
-			/* Buffer length */
-			IDMAC_SET_BUFFER1_SIZE(desc, desc_len);
-
-			/* Physical address to DMA to/from */
-			desc->des2 = cpu_to_le32(mem_addr);
+			if (is_64bit) {
+				desc64->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC | IDMAC_DES0_CH;
+				IDMAC_64ADDR_SET_BUFFER1_SIZE(desc64, desc_len);
+				desc64->des4 = mem_addr & 0xffffffff;
+				desc64->des5 = mem_addr >> 32;
+			} else {
+				IDMAC_SET_BUFFER1_SIZE(desc, desc_len);
+				desc->des2 = cpu_to_le32(mem_addr);
+			}
 
 			/* Update physical address for the next desc */
 			mem_addr += desc_len;
 
 			/* Save pointer to the last descriptor */
-			desc_last = desc;
+			if (is_64bit)
+				desc64_last = desc64;
+			else
+				desc_last = desc;
 		}
 	}
 
-	/* Set first descriptor */
-	desc_first->des0 |= cpu_to_le32(IDMAC_DES0_FD);
-
-	/* Set last descriptor */
-	desc_last->des0 &= cpu_to_le32(~(IDMAC_DES0_CH |
-				       IDMAC_DES0_DIC));
-	desc_last->des0 |= cpu_to_le32(IDMAC_DES0_LD);
+	/* Set the first descriptor and the last descriptor */
+	if (is_64bit) {
+		desc64_first->des0 |= IDMAC_DES0_FD;
+		desc64_last->des0 &= ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
+		desc64_last->des0 |= IDMAC_DES0_LD;
+	} else {
+		desc_first->des0 |= cpu_to_le32(IDMAC_DES0_FD);
+		desc_last->des0 &= cpu_to_le32(~(IDMAC_DES0_CH | IDMAC_DES0_DIC));
+		desc_last->des0 |= cpu_to_le32(IDMAC_DES0_LD);
+	}
 
 	return 0;
 err_own_bit:
@@ -725,11 +672,7 @@ static int dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
 	u32 temp;
 	int ret;
 
-	if (host->dma_64bit_address == 1)
-		ret = dw_mci_prepare_desc64(host, host->data, sg_len);
-	else
-		ret = dw_mci_prepare_desc32(host, host->data, sg_len);
-
+	ret = dw_mci_prepare_desc(host, host->data, sg_len, host->dma_64bit_address);
 	if (ret)
 		goto out;
 
-- 
2.7.4

