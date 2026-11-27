Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781946;
	b=gOwGYI4KNq1ldzeXINIhMuHDrMETUOgsilBKLATopzAvWIDw6yLnasMjuk3dRvj4Rr09
	 FJdoVb8MJsGhkUIRvNJJZPf4yBABVCNe8yvxS7/ynftR48/9f5Xv2NjoI9ya6m9Vs0dkA
	 BsiWaORWZkO+Yr0/gDgsdAUgyYUB9cHtA1TlaVzROQG1PkTyZvLJVFDucP5CY28pvlpFW
	 8Ozg8IWzcQLRnZzEC+gjz9DK+Nnj91spM1WkwwbNKg1+NxytrJ3TM8uN7h2zZQR4t9Vqv
	 /1ApEXdlLFbDKfuvf16TtK6b0dkueMa3ZW35AQRM+LnuYPwdIOytLvpIovSBkwSzfxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gcDUe7weJJYMrvTg7gVHHmg7tsUoApLJH7Q2bv9KvGA=;
	b=Y2QRG3kRLI3zpDXaBv9jDQc9nUlQApJ1GtlBppYH66aZ3CeBpy/4Xm9gu6ulmkxCyVsM
	 aP2/TdEx7Rr9AirtNTfioKUO4uAZNsj8DdkWKxjeGPY8xRG950I5ioaXCt3NM/s8l4c7G
	 Y/JtZqyTNFvvkaGdb8yVBmr66JMfmnJqEMtZ7Sw4va+HSZlxPjAgegbaQZB4eSQdz8NLE
	 vjXjmqV24n3cmv96OTWQ37GYwBnOW5TFoR8xSnzcqK0yVn5ZMPCKrxR2lUazH7X76Y1yb
	 kkAhlu87fCL8UuKANyEcS8mhyg3ejBMzyRu3SpsgjrdZXQgR4fZeIoKiqOY8qwGpyAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=LlfDG8Yy;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604160A260B
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 12:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D604160A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=LlfDG8Yy
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb9d8e8e90so51695355e9.3
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 04:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795781944; x=1796386744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gcDUe7weJJYMrvTg7gVHHmg7tsUoApLJH7Q2bv9KvGA=;
        b=LlfDG8Yybx7d37cHaAKtJuCuShAmNgy6eWz/R2KOTm7I9hXGIXKi0sotFty3knaimi
         HHrLuLUb5LzIr+Jds4OpxTFmx2Hd+YW1Q8x/F9l6mQrhRKaWy7JNHREl9cMkwfxvdk9R
         sypRCT9yjLx9cVwWn3LrI4/hdXhUbltxjBeEYeVINpc4Cpv7xOiyD8T1JgBbQXxXSdFg
         8vRKdVm+OsVMbrZXM/p9QWru4RkckRMx7uuR7znUSLyZpuyzyO8oJEd+wteYJ2N6mi0Q
         vcQ8jBTpOAMvCizu64UdHAT/AkLBPIulPoWJ4NUlm9BCX2cw5RfbKdXS4I4Wyfp9jOTp
         CHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795781944; x=1796386744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gcDUe7weJJYMrvTg7gVHHmg7tsUoApLJH7Q2bv9KvGA=;
        b=GhWAZeImNIhlRMO9HR/hD/LqqcymX3s7B2mH2G0+nFmYZYj4sY2rEjP9sbuIL5uq1L
         f7ffk4GDiIh8lv8++32dd0UGelfGqXKbGQ75qCOqARQXPVytsQWG8P5DnXdizqf1vBUD
         D0AkVcS+WABcid+FZXVT8IP1WXmzevVFPvGXGnkdJ4IO2wHHxEFaTY3f06JFKhvYt8Cy
         iKdCrj5pJhJzvRHj2KStlFMecQPSAh+hLf0w2Kxoe6DLnVu6i668wJiVEw5iTibiW2rL
         A3kX97N1f8q7TwXobAKg/Fi9OhSFo2JQzl542z8AQbEe32D1i69FHd9xK74xgRtyaWmg
         rEzg==
X-Forwarded-Encrypted: i=1; AL+hErGSGFrd4NMcT4hTzi5IS+8SF8Zgd4JI6Qix9L8B6cNlaYm+fWCY5UHrFsNWFyjO+eP7OC5tiufPGlU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lCT0vxfSX/mXA4Szt4ktyGRFcGGwuwxKbS7gcV4LWdBNfiT91
	xgpGRzyF+awvYFQbmndku9bFWmkj334NXBaH2G4hlIr8yXRSx8XIpAzwL4tXGwtpmIo=
X-Gm-Gg: AZFdTZcv9HqIlKwf+C04+m+ZOT1ap7NbtA7DpxUVP5JruTxwDCG8zWqLnDZXDJ6mWvY
	PFFD15XAhGudXCPW/SbH/3s4385ZgQOZTznXHZwLBwBP8zReG1QP7+Qp5+ca7BM6jQm/ruM6vw3
	qXza+tN3radC0ziqNtl778e3fvR5Z+Kx92Glak3p5qSXpGDDiffP85AbL6uGICNTzOofuhuZFaK
	fDq9jxHrKJk7YazqhU1A0nzXb6xkN9p9jUlypxfFZM8NgzSD7xZFIbrsFsm1ycSej0kH8W8SUdO
	9dBfwh+LClPNLSdBQnh+5fNNiPNOd6zkNIyhe3DpGG+KK89BjZSdXMS9M5O/jshkXgKEAzfw+++
	8HGEpDda7PCfcwrNjb23OjQWO3yVajvhQCUDZigk4SqKh18XL+wy87tTqoG4ICRq1Rgmah3/5R3
	xUMtjbsxZRq/Cxyy+z/LrAc5hpXTo7oNky3spZq+i5sGy1Qwcw/qbMbdRJps/wujtKAsQryhiaa
	+t/oHXmaYdH6SPZF2bC2JCSV1zNmkR9uzPi/YWHEflXtpvXJNuWsibydVBcpZs4Ob3EZvpfSkvv
	k2GSj+wmug8AcmBNg3Y+FmcZx7ooMg==
X-Received: by 2002:a05:600c:5246:b0:4a7:9006:b176 with SMTP id 5b1f17b1804b1-4bb887fe892mr524524725e9.7.1795781944276;
        Fri, 27 Nov 2026 04:19:04 -0800 (PST)
Received: from localhost ([195.94.148.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849247asm702530165e9.7.2026.11.27.04.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 04:19:02 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Dom Cobley <popcornmix@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrea della Porta <andrea.porta@suse.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH v4 16/28] mmc: bcm2835: Pass the CPU physical address of SDDATA to the DMA engine
Date: Fri, 27 Nov 2026 13:22:06 +0100
Message-ID: <20261127122236.4976-17-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261127122236.4976-1-andrea.porta@suse.com>
References: <20261127122236.4976-1-andrea.porta@suse.com>
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

The addresses in struct dma_slave_config are CPU physical addresses, and
the DMA controller driver is responsible for translating them into its
own view of the bus. The driver instead reads the untranslated address
out of its reg property, which only happens to be what the BCM2835 DMA
controller expects because the DMA engine driver used the address
verbatim.

Now that the DMA engine driver translates slave addresses itself, use the
CPU physical address of the register resource, which also gets rid of
the open coded parsing of the DT node.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/mmc/host/bcm2835.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index efd1903c3ccd..cea7b2b6d2f0 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -38,7 +38,6 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/scatterlist.h>
@@ -147,7 +146,7 @@ struct bcm2835_host {
 	struct mutex		mutex;
 
 	void __iomem		*ioaddr;
-	u32			phys_addr;
+	phys_addr_t		phys_addr;
 
 	struct clk		*clk;
 	struct platform_device	*pdev;
@@ -1369,7 +1368,7 @@ static int bcm2835_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct bcm2835_host *host;
 	struct mmc_host *mmc;
-	const __be32 *regaddr_p;
+	struct resource *res;
 	int ret;
 
 	dev_dbg(dev, "%s\n", __func__);
@@ -1382,23 +1381,14 @@ static int bcm2835_probe(struct platform_device *pdev)
 	host->pdev = pdev;
 	spin_lock_init(&host->lock);
 
-	host->ioaddr = devm_platform_ioremap_resource(pdev, 0);
+	host->ioaddr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(host->ioaddr)) {
 		ret = PTR_ERR(host->ioaddr);
 		goto err;
 	}
 
-	/* Parse OF address directly to get the physical address for
-	 * DMA to our registers.
-	 */
-	regaddr_p = of_get_address(pdev->dev.of_node, 0, NULL, NULL);
-	if (!regaddr_p) {
-		dev_err(dev, "Can't get phys address\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	host->phys_addr = be32_to_cpup(regaddr_p);
+	/* the DMA engine translates the address into its own view of the bus */
+	host->phys_addr = res->start;
 
 	host->dma_chan = NULL;
 	host->dma_desc = NULL;
-- 
2.51.0

