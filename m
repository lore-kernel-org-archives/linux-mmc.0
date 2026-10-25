Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792937086;
	b=lSG37SEsjmIUtaH4BfQdTDHbY2/tPNXGt6bsSRlAD4OQU7jHvVtm+XxLiPqgtVPeg2yV
	 pt4ups/buMIuaLmld4m8064dAS9Jx9KxveuhtIEXJEOdS7nrw86eLrXiMJYDpy4LKVGqL
	 lo5iQOPVIoOW6DYDYdu39o+3EN9K6YdWMfyWmhSY4KIKDj77laTpgT+HMd8h5/Up/HMT5
	 7fCPyD6MyEQtB7+/GsGu6KAD6o2GzoEBQyWHPF0zf/Tu1tFDo5w8xlIZSPpA8pSfcKmlP
	 K0rCosJIBR1y8crRYqtN1JEUUJtomCaJez5Im2S0w/4GQAd7PJ13JUCGWEdy8br8C3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792937086;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1ylJOrV4RVdNm4kQ38Gy4IYON4GIqfukuZd5CNvB1e4=;
	b=kVU3DRTCAUzNp0JivKUo5SZb2ctzXhJVtWuUKtOOTMWM8VSzd7+QDGTK3K78ZMqeIkEI
	 Iw+UAwsD4ORJYBWiMOMubIgZOC6AhXunLkX66loK2iDdVv7VN7FwpCywtGAlhgNsH9X0d
	 qP2bKNMTx+iYxQ1jDVM4D/F+HWlLh6kepwba5FgF5R/qA1nuBkdhmgKXkfzgaaG/gAn26
	 veHu0R1CEff6mCqkypAJoS94vlIy4fL8pr0+EgdgPangmJfanbnV4RkgKafVKo5k7U3v0
	 T2ANnl/1FDRJ954OfR/K+X4mebm0R6YRaZbkM74KhIPQccbtAwrLO4FEFi+d4gJQp+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=yZNzDZqC;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCEA606A328
	for <linux-mmc@vger.kernel.org>; Sun, 25 Oct 2026 14:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDCEA606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=yZNzDZqC
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so3203465e9.3
        for <linux-mmc@vger.kernel.org>; Sun, 25 Oct 2026 07:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792937083; x=1793541883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ylJOrV4RVdNm4kQ38Gy4IYON4GIqfukuZd5CNvB1e4=;
        b=yZNzDZqCcrbtezTrAhcE8PxbaYEc9T+6wfov//qGCLX/v/uSOauXZw8acQqDQjRzlw
         k69GUNBc+LW889A0Di2V8ynOfc5Jhli+DEbQNbEnaKFUO7do3Z45PIxEGIDUl52GgRDd
         kK4XdH9ANzpbVQ81DIv4gmhLOrbERqrsui7dNnshDtn/+LnBulUwaOePfqi8nGKuMzef
         fAT0mjv7/OtKggxWgX1Z/uYQYYOcol+7mDOd7shQjB10CBeki0pJVnm5Eoym9p56E0nU
         8zH4/fIjSkCKybtBvliG/B0kaUu+QVdc3ITCtNQiZVlHahS9jdpPVpAvgyvr1V/kSsgh
         ME2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792937083; x=1793541883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ylJOrV4RVdNm4kQ38Gy4IYON4GIqfukuZd5CNvB1e4=;
        b=knTPNZ6mxfCnrh0Xkip4yz4ar2NxeWLUG60FCmboqDUF0k1L84TqXb34TV6Vq/sTIT
         fRjhowZoHh5mfHMyW6Gdm/Fu6LQtPH+y79GPdnr5Dp/ULTjzcKclt3ABWhHYOARp0+tF
         Le9kHSH3QlBTY3j3djN8pIR3LANxm2LPaboKKFxGElE+2oQpQ08rVOIFyiGV5qe/uqdP
         HvZy77/myX/lBgV61YOBQmOcMMwBN4RHJXoY61WEZxH/g3HNF6HrnVq2+C4mns8X3Unr
         bgvCsEwRgkwhyAK5jnL8X9Vrm1BYGW+serBJwI9UKu1Ctm/u8X5JDHG8pp6GMK9Nd+Ed
         zGaQ==
X-Forwarded-Encrypted: i=1; AKwUvBzx1cjRjwK8+JXGxi7upDuRHx7rucV6JRKpP5DeE9FHaSh+3DQOqXGGg+VESL8yXuibZrCR5JYwwIw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJT2KM+SvPmbiUJwvjZNQ/nmpUlp+ic0y6J+d6tjcmI5DzBdkLp
	hLQNz7hLzJwhg0KP3muCnzu7Nk8jxZ4lns/rYuud4zR/FIE0wctua8P/uGGPaEO0vpE=
X-Gm-Gg: AYBFou2c6YFhFliuxmwmDtDhJ41MzMKn3rd8Acmy/kF8gWogjDwhhknqUJiXejzcWPK
	okney126q65ZEGuuLLdyw+iFgTZyclKaav+1EQKsCD8brwHGjZc1sCZrnYp+Ya1hMOypta/TZvz
	WnJ4+csErYZH5T+kcbp1AVYlHyny5w9wwZd2j7NEUxIy5QmVuS/CQrlg9po7jBL8SMQZX8Oz6Rs
	CGsoC2XXATl3ku5tV7EMsgWNXA6q/CxQf7hqgEu62TYLCWxXtXDla28fNSuh4kzzJBiQFBKK27G
	8qdpL8bLVhRzUOScs2nRHqm/I/mQBF7aZrI10eVxtnYywarrDDE6sxRvcikucpKDkDvShygmw4y
	lzSyRCsyhSDjizW7NCUZLw8R+jKbBe68jYojhbNbAlynxysbjJTw6viDph48Qzz3SZm7Xivu2z6
	1UNuxex5YhfTj0nvQfXqPvvMdeal+2rK5jguhIohN9ItNYM8/DdLmZg9inaJmnSadXrMXqHkCle
	fJpZLVIfb5QEdBnzFi+Yk6kdvTygYgHuFUn40AzXB0wsMRuv8qxGzBKIpm+Ucb+V793mXBbPeKm
	6pOC4fxaKvF9eLNSyeH/93z1PAk/chXDBuKDM48fVv7mhAWpTnWeBV5l1KpacMFjEpbVG0e8xZE
	MVy66/6CVm9BKtEI7btE=
X-Received: by 2002:a05:600c:6095:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a35ac7f0d2mr62913685e9.9.1792937083243;
        Sun, 25 Oct 2026 07:04:43 -0700 (PDT)
Received: from localhost.localdomain (2a01cb060184ad00bcfbae5efa3e0f0b.ipv6.abo.wanadoo.fr. [2a01:cb06:184:ad00:bcfb:ae5e:fa3e:f0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a574088sm112317695e9.9.2026.10.25.07.04.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 07:04:42 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH RFC 2/2] mmc: jz4740: Use the integrated DMA controller on the X1600
Date: Sun, 25 Oct 2026 15:03:25 +0100
Message-ID: <20261025140325.73204-3-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025140325.73204-1-olivier@mgcrea.io>
References: <20261025140325.73204-1-olivier@mgcrea.io>
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

From the JZ4780 on, the MSC has a DMA controller of its own, which walks
a chain of descriptors (next, address, length, command) and is selected
with DMA_SEL clear in DMAC. The X1600 has no request lines from its MSCs
to the system DMA controller (Ingenic's own kernel uses the integrated
controller), so the driver fell back to PIO there, which takes the CPU
for every word.

Use the integrated controller on the X1600 when the device tree gives no
DMA channels: one descriptor per scatterlist segment, up to 64 KiB each,
started right after the command. Buffers that aren't word-aligned,
transfers under a block and segments that end inside a block still go
through PIO.

A write is complete once the transfer is done, as before. A read needs
its last words in memory, and on the X1600 no flag the driver polls says
so: DMA_DATA_DONE never came, even unmasked, and DMAEND is only flagged
while unmasked. So a read is done when the DMA address has reached the
end of the last segment with nothing left of it, or on DMAEND.

On the HiBy R1 (X1600, an SDHC card at 50 MHz, 4-bit), reads go from 17.3
to 22.5 MB/s and writes from 13.9 to 18.2 MB/s, with the CPU free; as a
USB mass storage gadget, writes from a computer from 4.4 to 10.7 MB/s.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 drivers/mmc/host/jz4740_mmc.c | 182 ++++++++++++++++++++++++++++++++--
 1 file changed, 171 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 6a3c26b7c82d..300ad2a01b17 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -24,6 +24,7 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/scatterlist.h>
+#include <linux/sizes.h>
 
 #include <asm/cacheflush.h>
 
@@ -45,6 +46,9 @@
 #define JZ_REG_MMC_TXFIFO	0x3C
 #define JZ_REG_MMC_LPM		0x40
 #define JZ_REG_MMC_DMAC		0x44
+#define JZ_REG_MMC_DMANDA	0x48
+#define JZ_REG_MMC_DMADA	0x4C
+#define JZ_REG_MMC_DMALEN	0x50
 
 #define JZ_MMC_STRPCL_EXIT_MULTIPLE BIT(7)
 #define JZ_MMC_STRPCL_EXIT_TRANSFER BIT(6)
@@ -93,6 +97,7 @@
 #define JZ_MMC_CMDAT_RSP_R2 2
 #define JZ_MMC_CMDAT_RSP_R3 3
 
+#define JZ_MMC_IRQ_DMAEND BIT(16)
 #define JZ_MMC_IRQ_SDIO BIT(7)
 #define JZ_MMC_IRQ_TXFIFO_WR_REQ BIT(6)
 #define JZ_MMC_IRQ_RXFIFO_RD_REQ BIT(5)
@@ -103,6 +108,15 @@
 #define JZ_MMC_DMAC_DMA_SEL BIT(1)
 #define JZ_MMC_DMAC_DMA_EN BIT(0)
 
+/*
+ * A descriptor of the integrated DMA controller; dcmd bits. LINK set fetches
+ * the next descriptor, as the X1600 manual's MSC_DMACMD table says (its
+ * descriptor section says the opposite).
+ */
+#define JZ_MMC_DESC_LINK BIT(0)
+#define JZ_MMC_DESC_ENDI BIT(1)
+#define JZ_MMC_DESC_MAX_LEN SZ_64K
+
 #define	JZ_MMC_LPM_DRV_RISING BIT(31)
 #define	JZ_MMC_LPM_DRV_RISING_QTR_PHASE_DLY BIT(31)
 #define	JZ_MMC_LPM_DRV_RISING_1NS_DLY BIT(30)
@@ -118,6 +132,7 @@ enum jz4740_mmc_version {
 	JZ_MMC_JZ4760,
 	JZ_MMC_JZ4780,
 	JZ_MMC_X1000,
+	JZ_MMC_X1600,
 };
 
 enum jz4740_mmc_state {
@@ -140,6 +155,13 @@ enum jz4740_mmc_state {
  * COOKIE_MAPPED: the request was mapped in the irq handler,
  * and should be unmapped before mmc_request_done is called..
  */
+struct jz4740_mmc_desc {
+	__le32 next;
+	__le32 addr;
+	__le32 len;
+	__le32 cmd;
+};
+
 enum jz4780_cookie {
 	COOKIE_UNMAPPED = 0,
 	COOKIE_PREMAPPED,
@@ -179,6 +201,18 @@ struct jz4740_mmc_host {
 	struct dma_chan *dma_tx;
 	bool use_dma;
 
+	/*
+	 * The integrated DMA controller, used on the X1600, whose MSCs have no
+	 * request lines to the system DMA controller; idma_active is set for a
+	 * request it carries.
+	 */
+	bool use_idma;
+	bool idma_active;
+	struct jz4740_mmc_desc *descs;
+	dma_addr_t descs_dma;
+	/* Where the integrated DMA's address ends up when it is done */
+	u32 idma_end;
+
 /* The DMA trigger level is 8 words, that is to say, the DMA read
  * trigger is when data words in MSC_RXFIFO is >= 8 and the DMA write
  * trigger is when data words in MSC_TXFIFO is < 8.
@@ -283,13 +317,22 @@ static inline struct dma_chan *jz4740_mmc_get_dma_chan(struct jz4740_mmc_host *h
 		return host->dma_tx;
 }
 
+/* The device that maps buffers: the DMA engine's, or ours for the integrated one */
+static struct device *jz4740_mmc_dma_dev(struct jz4740_mmc_host *host,
+					 struct mmc_data *data)
+{
+	if (host->use_idma)
+		return mmc_dev(host->mmc);
+
+	return jz4740_mmc_get_dma_chan(host, data)->device->dev;
+}
+
 static void jz4740_mmc_dma_unmap(struct jz4740_mmc_host *host,
 				 struct mmc_data *data)
 {
-	struct dma_chan *chan = jz4740_mmc_get_dma_chan(host, data);
 	enum dma_data_direction dir = mmc_get_dma_dir(data);
 
-	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, dir);
+	dma_unmap_sg(jz4740_mmc_dma_dev(host, data), data->sg, data->sg_len, dir);
 	data->host_cookie = COOKIE_UNMAPPED;
 }
 
@@ -300,17 +343,14 @@ static int jz4740_mmc_prepare_dma_data(struct jz4740_mmc_host *host,
 				       struct mmc_data *data,
 				       int cookie)
 {
-	struct dma_chan *chan = jz4740_mmc_get_dma_chan(host, data);
 	enum dma_data_direction dir = mmc_get_dma_dir(data);
 	unsigned int sg_count;
 
 	if (data->host_cookie == COOKIE_PREMAPPED)
 		return data->sg_count;
 
-	sg_count = dma_map_sg(chan->device->dev,
-			data->sg,
-			data->sg_len,
-			dir);
+	sg_count = dma_map_sg(jz4740_mmc_dma_dev(host, data), data->sg,
+			      data->sg_len, dir);
 
 	if (!sg_count) {
 		dev_err(mmc_dev(host->mmc),
@@ -371,13 +411,101 @@ static int jz4740_mmc_start_dma_transfer(struct jz4740_mmc_host *host,
 	return -ENOMEM;
 }
 
+/*
+ * The integrated DMA controller moves whole words from word-aligned
+ * addresses; other buffers (none the block layer hands us) go through PIO.
+ * So do transfers under a block, which are the card's registers read while
+ * it is set up: on the X1600 such a read through the DMA sometimes never
+ * raised DATA_TRAN_DONE although all of it had been moved, and the setup
+ * started over after each 5 s timeout. And so do segments that end inside
+ * a block: SDIO writes that brcmfmac glued together from several frames
+ * timed out and left the bus dead, while the same writes went through PIO.
+ */
+static bool jz4740_mmc_idma_can(struct jz4740_mmc_host *host,
+				struct mmc_data *data)
+{
+	struct scatterlist *sg;
+	int i;
+
+	if (!host->use_idma || data->blocks * data->blksz < 512)
+		return false;
+
+	for_each_sg(data->sg, sg, data->sg_len, i)
+		if ((sg->offset | sg->length) & 3 || sg->length % data->blksz)
+			return false;
+
+	return true;
+}
+
+/* Maps the request's buffers and chains one descriptor per segment */
+static int jz4740_mmc_idma_prepare(struct jz4740_mmc_host *host,
+				   struct mmc_data *data)
+{
+	struct scatterlist *sg;
+	int i, sg_count;
+
+	sg_count = jz4740_mmc_prepare_dma_data(host, data, COOKIE_MAPPED);
+	if (sg_count < 0)
+		return sg_count;
+
+	for_each_sg(data->sg, sg, sg_count, i) {
+		struct jz4740_mmc_desc *desc = &host->descs[i];
+		bool last = i == sg_count - 1;
+
+		desc->next = cpu_to_le32(last ? 0 : host->descs_dma + (i + 1) * sizeof(*desc));
+		desc->addr = cpu_to_le32(sg_dma_address(sg));
+		desc->len = cpu_to_le32(sg_dma_len(sg));
+		desc->cmd = cpu_to_le32(last ? JZ_MMC_DESC_ENDI : JZ_MMC_DESC_LINK);
+		if (last)
+			host->idma_end = sg_dma_address(sg) + sg_dma_len(sg);
+	}
+	/* The descriptors are coherent memory; order them before the start */
+	wmb();
+
+	return 0;
+}
+
+/*
+ * The card's data is in (DATA_TRAN_DONE); wait for the integrated DMA to
+ * have written the last of it to memory. On the X1600 DMA_DATA_DONE (bit
+ * 31) didn't come, even unmasked, and DMAEND is only flagged while
+ * unmasked, which the polling here doesn't do. So it is done when the
+ * address has reached the end of the last segment with nothing left of it,
+ * or on DMAEND.
+ */
+static bool jz4740_mmc_idma_read_done(struct jz4740_mmc_host *host)
+{
+	if (jz4740_mmc_read_irq_reg(host) & JZ_MMC_IRQ_DMAEND)
+		return true;
+
+	return readl(host->base + JZ_REG_MMC_DMADA) == host->idma_end &&
+	       readl(host->base + JZ_REG_MMC_DMALEN) == 0;
+}
+
+static void jz4740_mmc_idma_wait_read(struct jz4740_mmc_host *host,
+				      struct mmc_data *data)
+{
+	unsigned int timeout = 10000;
+
+	while (!jz4740_mmc_idma_read_done(host) && --timeout)
+		udelay(1);
+
+	if (!timeout && !data->error) {
+		dev_err(mmc_dev(host->mmc), "DMA did not finish a read\n");
+		data->error = -EIO;
+	}
+}
+
 static void jz4740_mmc_pre_request(struct mmc_host *mmc,
 				   struct mmc_request *mrq)
 {
 	struct jz4740_mmc_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
 
-	if (!host->use_dma)
+	if (host->use_idma && !jz4740_mmc_idma_can(host, data))
+		return;
+
+	if (!host->use_dma && !host->use_idma)
 		return;
 
 	data->host_cookie = COOKIE_UNMAPPED;
@@ -395,7 +523,7 @@ static void jz4740_mmc_post_request(struct mmc_host *mmc,
 	if (data && data->host_cookie != COOKIE_UNMAPPED)
 		jz4740_mmc_dma_unmap(host, data);
 
-	if (err) {
+	if (err && host->use_dma) {
 		struct dma_chan *chan = jz4740_mmc_get_dma_chan(host, data);
 
 		dmaengine_terminate_all(chan);
@@ -462,6 +590,11 @@ static void jz4740_mmc_request_done(struct jz4740_mmc_host *host)
 	data = req->data;
 	host->req = NULL;
 
+	if (host->idma_active) {
+		writel(0, host->base + JZ_REG_MMC_DMAC);
+		host->idma_active = false;
+	}
+
 	if (data && data->host_cookie == COOKIE_MAPPED)
 		jz4740_mmc_dma_unmap(host, data);
 	mmc_request_done(host->mmc, req);
@@ -680,6 +813,7 @@ static void jz4740_mmc_send_command(struct jz4740_mmc_host *host,
 	struct mmc_command *cmd)
 {
 	uint32_t cmdat = host->cmdat;
+	bool idma = false;
 
 	host->cmdat &= ~JZ_MMC_CMDAT_INIT;
 	jz4740_mmc_clock_disable(host);
@@ -726,6 +860,11 @@ static void jz4740_mmc_send_command(struct jz4740_mmc_host *host,
 			}
 		} else if (host->version >= JZ_MMC_JZ4780) {
 			writel(0, host->base + JZ_REG_MMC_DMAC);
+			idma = jz4740_mmc_idma_can(host, cmd->data) &&
+			       !jz4740_mmc_idma_prepare(host, cmd->data);
+			if (idma)
+				writel(host->descs_dma, host->base + JZ_REG_MMC_DMANDA);
+			host->idma_active = idma;
 		}
 
 		writew(cmd->data->blksz, host->base + JZ_REG_MMC_BLKLEN);
@@ -737,6 +876,10 @@ static void jz4740_mmc_send_command(struct jz4740_mmc_host *host,
 	writel(cmdat, host->base + JZ_REG_MMC_CMDAT);
 
 	jz4740_mmc_clock_enable(host, 1);
+
+	/* Started after the command, as Ingenic's own drivers do */
+	if (idma)
+		writel(JZ_MMC_DMAC_DMA_EN, host->base + JZ_REG_MMC_DMAC);
 }
 
 static void jz_mmc_prepare_data_transfer(struct jz4740_mmc_host *host)
@@ -786,6 +929,9 @@ static irqreturn_t jz_mmc_irq_worker(int irq, void *devid)
 			 */
 			timeout = jz4740_mmc_start_dma_transfer(host, data);
 			data->bytes_xfered = data->blocks * data->blksz;
+		} else if (host->idma_active) {
+			/* Running since the command started */
+			data->bytes_xfered = data->blocks * data->blksz;
 		} else if (data->flags & MMC_DATA_READ)
 			/* Use PIO if DMA is not enabled.
 			 * Data transfer direction was defined before
@@ -812,6 +958,9 @@ static irqreturn_t jz_mmc_irq_worker(int irq, void *devid)
 		fallthrough;
 
 	case JZ4740_MMC_STATE_SEND_STOP:
+		if (host->idma_active && (data->flags & MMC_DATA_READ))
+			jz4740_mmc_idma_wait_read(host, data);
+
 		if (!req->stop)
 			break;
 
@@ -850,7 +999,8 @@ static irqreturn_t jz_mmc_irq(int irq, void *devid)
 	irq_reg &= ~host->irq_mask;
 
 	tmp &= ~(JZ_MMC_IRQ_TXFIFO_WR_REQ | JZ_MMC_IRQ_RXFIFO_RD_REQ |
-		JZ_MMC_IRQ_PRG_DONE | JZ_MMC_IRQ_DATA_TRAN_DONE);
+		JZ_MMC_IRQ_PRG_DONE | JZ_MMC_IRQ_DATA_TRAN_DONE |
+		JZ_MMC_IRQ_DMAEND);
 
 	if (tmp != irq_reg)
 		jz4740_mmc_write_irq_reg(host, tmp & ~irq_reg);
@@ -1033,6 +1183,7 @@ static const struct of_device_id jz4740_mmc_of_match[] = {
 	{ .compatible = "ingenic,jz4775-mmc", .data = (void *) JZ_MMC_JZ4780 },
 	{ .compatible = "ingenic,jz4780-mmc", .data = (void *) JZ_MMC_JZ4780 },
 	{ .compatible = "ingenic,x1000-mmc", .data = (void *) JZ_MMC_X1000 },
+	{ .compatible = "ingenic,x1600-mmc", .data = (void *)JZ_MMC_X1600 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4740_mmc_of_match);
@@ -1123,6 +1274,15 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 		goto err_free_irq;
 	host->use_dma = !ret;
 
+	if (!host->use_dma && host->version >= JZ_MMC_X1600) {
+		host->descs = dmam_alloc_coherent(&pdev->dev,
+						  mmc->max_segs * sizeof(*host->descs),
+						  &host->descs_dma, GFP_KERNEL);
+		host->use_idma = !!host->descs;
+		if (host->use_idma)
+			mmc->max_seg_size = JZ_MMC_DESC_MAX_LEN;
+	}
+
 	platform_set_drvdata(pdev, host);
 	ret = mmc_add_host(mmc);
 
@@ -1133,7 +1293,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	dev_info(&pdev->dev, "Ingenic SD/MMC card driver registered\n");
 
 	dev_info(&pdev->dev, "Using %s, %d-bit mode\n",
-		 host->use_dma ? "DMA" : "PIO",
+		 host->use_dma ? "DMA" : host->use_idma ? "integrated DMA" : "PIO",
 		 (mmc->caps & MMC_CAP_8_BIT_DATA) ? 8 :
 		 ((mmc->caps & MMC_CAP_4_BIT_DATA) ? 4 : 1));
 
-- 
2.39.5

