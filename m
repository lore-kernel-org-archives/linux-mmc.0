Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633015;
	b=EDZAfQZaZ/mLJ1FHIaD/H7NfETCc4i1E4sqnFKYOqKNmWvZg64pwJ4mSnzgYd70Ep2Wk
	 oXV7UJ8nKV9ub2B/bjEIubv52wXontIhLPUtv0xqHqwejB5mYh2230pJnZ7ne5FzzAOFw
	 PepIwevx9ekfwmST9Bhv4LpgpeCQbyz/CooLyxmg2+RfHrQDbnUtESI1e19gogtXdi4q0
	 zInQ7/Wx3LD2prWUN6lnorCRIDhS4z5rOJESdAp1hGIuD5sExCI6c+lKdQKrgPWisdeEF
	 a0skNk4Eu6WDlDtvuQahUBFvBJA1+kBIjtuLVKgwuJB/9YQ8B2d21SxZUHydkR7bWyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=1nOqDeZUOqhBqrS+LB1gpt8pjUJMSW9vWxZMjrz4Bh8=;
	b=v8fSUI4Daf92yP7crldeXWzbH63z+Hk75VBY/7d8SECeTBd/5T5r1hpab72CcFlIF3rw
	 2Ioiv2BhbzNRhG8pLhl0RtwfUEan3qixNTdKc5u+RclwNePev3xl+C1gY3lxt3Wr669gE
	 gPZrZIPwGk8d6lZ9/EhgaSmX0Y8JCjXaOGaLUMP81wOn4X7E2pIJXBZp/eW0b0OM/6QMP
	 YqOJyQHGTKaoQqrolFhTVjX4Dr05wEJ8lGCd/r2Uq2Gf8dybr7blu1aSKoe6GrMjNn3tI
	 C2dPV5NGfz28HlSobF/P8mZqrqROWhM0pShufZt91M5CQzoOZxydBGvuUcaPHQTCXHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yh1hp4t2;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA78606A880
	for <linux-mmc@vger.kernel.org>; Sat, 14 Nov 2026 05:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBA78606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yh1hp4t2
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e977109392so9508065ad.0
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 21:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794633014; x=1795237814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1nOqDeZUOqhBqrS+LB1gpt8pjUJMSW9vWxZMjrz4Bh8=;
        b=yh1hp4t2DegKtyYrrcbFLiy0CLz48yPtTOaEnGgIgpZ7Gy9WmfiMZ2Z7ES6KE2ZsqX
         ehQE/b4D16iaViJ35WmGFBGiXMWQsIuW3h2I2B7SaxQSpUVjx7Rk0rsqMcIbLvK8aiMH
         fnp/RTlnBMiwkj3XInl3oAmVrOeGsdmC93GnCWbmzAfmPbq7Z7Jz6ZXCl0+PNCDlEWTR
         ueVFWiGCzb8bVCDrhPCdsAl6nDwGDjMLM2rZdQwC2yt3SpLkPEuZBSNe1dUBVP0qBOJQ
         xx7tJUp8Lemvx0QtjYTQQ9oi6H46byRYAoDeSqNvm58tOIxr/mQHyq+Lwcy9n9I7var4
         ysNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794633014; x=1795237814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1nOqDeZUOqhBqrS+LB1gpt8pjUJMSW9vWxZMjrz4Bh8=;
        b=nQtWlqfZyq/uif37MkYk4nZw54wMcH+CfDSpWIf2uWHl20NCIJ+cOEMtvUr+3Hqwod
         CcWMSrTwjTFOdV3yGr8ZyWz2Y8ZqE25ZKTc+lK+JIjYMDwg+fiCELJGNXucFYk9SZ0Gj
         fZyivBfHPtSn3dXf/Eh9mIOdUH3oAJ2jUNO4FVMTEks/7Ee02CI2LcZIKM3ERvqBTEMV
         z3QzQU56sLbVZr8azgmBT8Env02OAUuUW+mCdYeG5uaTl35qK3s9ZW+AVvwZXXNd82/U
         foMecrbdItXT6G4MRxOWNLQda6+/335k20opPvyC2jUxVCl5h9ZMsRkOCtvrN1Z6E/Lj
         UJ4g==
X-Gm-Message-State: APuU4Z+Gfm7t4x0OTzCvrnRYgTXSjokp+qVfZOxhIOmEEpllGJDhQwfj
	0vManLsZpvthh/Wmm1mDZi1tUnaf18BUl5Fm9/b8Zeq55CqjlWt2QNNt
X-Gm-Gg: AYBFou3EB21NI9+CfztPvS5f2/NeHw6NKyf8lX1Q/yvuyEd1TNTcnamuvYJgQzVx0I8
	JK6Fdw+e5uTxQn5i4FV7UMJcK08gxYK3LzV4hDKLtN/HiO84ufRkBPigyyGY0rkgazKPHpr8WI/
	0Nq1aqwN7j13vqZjEEnmjOQewDDoaWpgWd+Opwie+1HFSfSEvd+vriSOgGQbWGOysN+NmiXkSqU
	VLQWMrV3XXj2pcoDEQsDJjpyQL7c37OSVsNgbKIISa4UEEgA3Jfu6G5yshwfTwcC+c4+oGgD8X7
	v2FtWpqd+T8a28aOiciPQ9OiT36xOm/wOAAfJECZmuCmKY0plZLfiJ+8cV9BPU/hpjPe5uZHRf3
	109/ylMwBHaxPe3xTJVhLkwqy0UvpKcXz4m6imWxXGQOdtCtB8e3zFIXxz0tz4khY535Jb9bNaq
	obz+J7i5IXW2wpmxTHzGOdx57ueAY+wftAp0TE0q4Rny6G8/Cso5Gq9WilslYftTtxmppMvGAGr
	V8skB5gefzbpI/5CXFkZ0IxcLRjJyHhP8C+a0R5dlIDhJz2jd04oDVPz1/oAM95rtcKRAgzFzU4
	uUdXytbH5Vy9SDA49fxuOzyn+fx3QHMQTnWqOxU0Qix85duXJx84
X-Received: by 2002:a17:903:2410:b0:2ed:1ca2:ea68 with SMTP id d9443c01a7336-2ee0dca8be1mr43759235ad.49.1794633014214;
        Fri, 13 Nov 2026 21:10:14 -0800 (PST)
Received: from fedora.lan ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7e4e47sm17849025ad.38.2026.11.13.21.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 21:10:13 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	John Garry <john.garry@linux.dev>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Eric Anholt <eric@anholt.net>,
	Stefan Wahren <wahrenst@gmx.net>,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH] mmc: bcm2835: restore scatterlist after DMA setup failure
Date: Fri, 13 Nov 2026 23:10:11 -0600
Message-ID: <20261114051011.275554-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The DMA preparation path shortens the final scatterlist entry
to reserve space for FIFO drain words.

If DMA mapping or descriptor preparation fails, the request
falls back to PIO, but the shortened scatterlist entry is left
unchanged. Restore its original length and clear drain_words
before returning to the fallback path.

Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")
Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 drivers/mmc/host/bcm2835.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index efd1903c3ccd..49a975e984df 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -449,6 +449,8 @@ static
 void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
 {
 	int sg_len, dir_data, dir_slave;
+	struct scatterlist *trimmed_sg = NULL;
+	unsigned int original_len = 0;
 	struct dma_async_tx_descriptor *desc = NULL;
 	struct dma_chan *dma_chan;
 
@@ -480,6 +482,8 @@ void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
 		for_each_sg(data->sg, sg, data->sg_len, i) {
 			if (sg_is_last(sg)) {
 				WARN_ON(sg->length < len);
+				trimmed_sg = sg;
+				original_len = sg->length;
 				sg->length -= len;
 				host->drain_page = sg_page(sg);
 				host->drain_offset = sg->offset + sg->length;
@@ -495,14 +499,21 @@ void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
 				     &host->dma_cfg_tx);
 
 	sg_len = dma_map_sg(host->dma_dev, data->sg, data->sg_len, dir_data);
-	if (!sg_len)
+	if (!sg_len) {
+		if (trimmed_sg)
+			trimmed_sg->length = original_len;
+		host->drain_words = 0;
 		return;
+	}
 
 	desc = dmaengine_prep_slave_sg(dma_chan, data->sg, sg_len, dir_slave,
 				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
 	if (!desc) {
 		dma_unmap_sg(host->dma_dev, data->sg, data->sg_len, dir_data);
+		if (trimmed_sg)
+			trimmed_sg->length = original_len;
+		host->drain_words = 0;
 		return;
 	}
 
-- 
2.56.0

