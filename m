Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9232F1F5859;
	Tue, 18 Feb 2025 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904530; cv=none; b=tsZPHyzESHiL85sIXXe4YqEIn71BbnUxZouU1XJM4E3vcW6BaKV5V4LD1ze4kutA7pClYulqFNq2Vef6GayjMBYEpaI5B4LBy2H0cwebYkoxLiIEeqsjHIKllMg8p5Q1ArzQIWyjdkcxF1j4mk7VUNFEYHA1xdcmndWNTQhpvao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904530; c=relaxed/simple;
	bh=BzQwL6YQQNTYsgvAYKFO1zeGbFnGDhA1HDzmJYmBXvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mmsKeKosi1HSXc/B8ajVSQEbJ9ljpN5Z+8RCNokjOVsX8+t9G961s1zteYyAOm4N2/Yxs+OnECFWg4mZWP8cP9ZGRrsJ1efzmPDCJsbGyWuUMtGijUMcMuXC/PRSa6RR6FoUXxj/FT14VMuk0WmH2wgG0VaFEOLuUB4IWlbjaBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ee96fI/P; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ee96fI/P"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D8F3D25E18;
	Tue, 18 Feb 2025 19:48:46 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xhzeHVZjEg3j; Tue, 18 Feb 2025 19:48:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1739904522; bh=BzQwL6YQQNTYsgvAYKFO1zeGbFnGDhA1HDzmJYmBXvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ee96fI/Phlp524d00l8jBYvxsOxZ6w6uoQadF4AZgWOjw3GnpBGEjU5NqvLxjv6b1
	 i6GXQtDwgKqzzNrrHW0QpAJLv6iD1JtmCcAI3po/E70COogmRJrAG+NAqls/pyCOH9
	 isCZ9pTOyFGxdrsXvA3YjoF0nSPpVW8aO9QrmsLk+RFHjDfPer6Npqhb522w6AuWGO
	 hdWpHDTVqo5jjvTY0AlyToWNbiI324vORQLWf3xx37e3kep/56UAhHlyBuPWVYDRBs
	 LMOndg/++8gFTfQaGzyrfNNkTbRgTul2u8JB7n+16eArLiEXq7unc24AjvNtHb3zIx
	 y/i3U/+QXB2Og==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Wed, 19 Feb 2025 00:17:48 +0530
Subject: [PATCH v2 2/3] mmc: dw_mmc: add a quirk for accessing 64-bit FIFOs
 in two halves
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-exynos7870-mmc-v2-2-b4255a3e39ed@disroot.org>
References: <20250219-exynos7870-mmc-v2-0-b4255a3e39ed@disroot.org>
In-Reply-To: <20250219-exynos7870-mmc-v2-0-b4255a3e39ed@disroot.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739904507; l=5212;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=BzQwL6YQQNTYsgvAYKFO1zeGbFnGDhA1HDzmJYmBXvs=;
 b=wZPInEMV2Q1x7ZaITUQdT0Rjy+RAgj17gTaoiCzL5BRH+R6DIIx/eoYdtMTVcL3nXsze+s/I0
 cRc5wCmXXhxD9vQqxFaiTBRUG4u5hCujHhLoZehNGeconPns5iyXtd2
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

In certain DW MMC implementations (such as in some Exynos7870
controllers), 64-bit read/write is not allowed from a 64-bit FIFO.
Add a quirk which facilitates accessing the 64-bit FIFO registers in two
32-bit halves.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mmc/host/dw_mmc.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/dw_mmc.h | 27 ++++++++++++++
 2 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3cbda98d08d28722d16ba2e855342249ac878ad3..74f224647bf1ed3c5ca83b573594f8c6843dd1e4 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2579,6 +2579,91 @@ static void dw_mci_pull_data64(struct dw_mci *host, void *buf, int cnt)
 	}
 }
 
+static void dw_mci_push_data64_32(struct dw_mci *host, void *buf, int cnt)
+{
+	struct mmc_data *data = host->data;
+	int init_cnt = cnt;
+
+	/* try and push anything in the part_buf */
+	if (unlikely(host->part_buf_count)) {
+		int len = dw_mci_push_part_bytes(host, buf, cnt);
+
+		buf += len;
+		cnt -= len;
+
+		if (host->part_buf_count == 8) {
+			mci_fifo_l_writeq(host->fifo_reg, host->part_buf);
+			host->part_buf_count = 0;
+		}
+	}
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	if (unlikely((unsigned long)buf & 0x7)) {
+		while (cnt >= 8) {
+			u64 aligned_buf[16];
+			int len = min(cnt & -8, (int)sizeof(aligned_buf));
+			int items = len >> 3;
+			int i;
+			/* memcpy from input buffer into aligned buffer */
+			memcpy(aligned_buf, buf, len);
+			buf += len;
+			cnt -= len;
+			/* push data from aligned buffer into fifo */
+			for (i = 0; i < items; ++i)
+				mci_fifo_l_writeq(host->fifo_reg, aligned_buf[i]);
+		}
+	} else
+#endif
+	{
+		u64 *pdata = buf;
+
+		for (; cnt >= 8; cnt -= 8)
+			mci_fifo_l_writeq(host->fifo_reg, *pdata++);
+		buf = pdata;
+	}
+	/* put anything remaining in the part_buf */
+	if (cnt) {
+		dw_mci_set_part_bytes(host, buf, cnt);
+		/* Push data if we have reached the expected data length */
+		if ((data->bytes_xfered + init_cnt) ==
+		    (data->blksz * data->blocks))
+			mci_fifo_l_writeq(host->fifo_reg, host->part_buf);
+	}
+}
+
+static void dw_mci_pull_data64_32(struct dw_mci *host, void *buf, int cnt)
+{
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	if (unlikely((unsigned long)buf & 0x7)) {
+		while (cnt >= 8) {
+			/* pull data from fifo into aligned buffer */
+			u64 aligned_buf[16];
+			int len = min(cnt & -8, (int)sizeof(aligned_buf));
+			int items = len >> 3;
+			int i;
+
+			for (i = 0; i < items; ++i)
+				aligned_buf[i] = mci_fifo_l_readq(host->fifo_reg);
+
+			/* memcpy from aligned buffer into output buffer */
+			memcpy(buf, aligned_buf, len);
+			buf += len;
+			cnt -= len;
+		}
+	} else
+#endif
+	{
+		u64 *pdata = buf;
+
+		for (; cnt >= 8; cnt -= 8)
+			*pdata++ = mci_fifo_l_readq(host->fifo_reg);
+		buf = pdata;
+	}
+	if (cnt) {
+		host->part_buf = mci_fifo_l_readq(host->fifo_reg);
+		dw_mci_pull_final_bytes(host, buf, cnt);
+	}
+}
+
 static void dw_mci_pull_data(struct dw_mci *host, void *buf, int cnt)
 {
 	int len;
@@ -3379,8 +3464,13 @@ int dw_mci_probe(struct dw_mci *host)
 		width = 16;
 		host->data_shift = 1;
 	} else if (i == 2) {
-		host->push_data = dw_mci_push_data64;
-		host->pull_data = dw_mci_pull_data64;
+		if ((host->quirks & DW_MMC_QUIRK_FIFO64_32)) {
+			host->push_data = dw_mci_push_data64_32;
+			host->pull_data = dw_mci_pull_data64_32;
+		} else {
+			host->push_data = dw_mci_push_data64;
+			host->pull_data = dw_mci_pull_data64;
+		}
 		width = 64;
 		host->data_shift = 3;
 	} else {
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 6447b916990dcd9ce91fca46e38985054d7e9612..5463392dc8110541c4fed74d600ab88dbd0faf7d 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -281,6 +281,8 @@ struct dw_mci_board {
 
 /* Support for longer data read timeout */
 #define DW_MMC_QUIRK_EXTENDED_TMOUT            BIT(0)
+/* Force 32-bit access to the FIFO */
+#define DW_MMC_QUIRK_FIFO64_32                 BIT(1)
 
 #define DW_MMC_240A		0x240a
 #define DW_MMC_280A		0x280a
@@ -472,6 +474,31 @@ struct dw_mci_board {
 #define mci_fifo_writel(__value, __reg)	__raw_writel(__reg, __value)
 #define mci_fifo_writeq(__value, __reg)	__raw_writeq(__reg, __value)
 
+/*
+ * Some dw_mmc devices have 64-bit FIFOs, but expect them to be
+ * accessed using two 32-bit accesses. If such controller is used
+ * with a 64-bit kernel, this has to be done explicitly.
+ */
+static inline u64 mci_fifo_l_readq(void __iomem *addr)
+{
+	u64 ans;
+	u32 proxy[2];
+
+	proxy[0] = mci_fifo_readl(addr);
+	proxy[1] = mci_fifo_readl(addr + 4);
+	memcpy(&ans, proxy, 8);
+	return ans;
+}
+
+static inline void mci_fifo_l_writeq(void __iomem *addr, u64 value)
+{
+	u32 proxy[2];
+
+	memcpy(proxy, &value, 8);
+	mci_fifo_writel(addr, proxy[0]);
+	mci_fifo_writel(addr + 4, proxy[1]);
+}
+
 /* Register access macros */
 #define mci_readl(dev, reg)			\
 	readl_relaxed((dev)->regs + SDMMC_##reg)

-- 
2.48.1

