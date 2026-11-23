Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445637;
	b=dKpAP5uCT4SXYuDsAExYFBDf0xH6UB5DFtjX7bUroVoGdjIrcH9zKnlaZUtKJWeH2oJ7
	 loSnBQPFoCZ+zCjyPqiVyz+RruXjDmY9wwO8ij0ugWY1GdVdFq64Je7nwXI7vcNTQYzY7
	 ZdBhaEvBvdrW0L2xVbHZx/+5Kl2ynFjVkZUYMlLtgg5skjnZtImkm3EgjnOEEu7gqtX2o
	 Day2vQqkyz1NTDzJi6VCUFHgIM12vk/MFA3FPQHD5EhofEzvcR/gUbzcMoZYDxn0ivcoZ
	 6GbFvuJFLc95nevSJTF3K0nTFpUy0wvrz6F6a2Ieh9PvF9db0ziKJlTKi/l49zCnglg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gcDUe7weJJYMrvTg7gVHHmg7tsUoApLJH7Q2bv9KvGA=;
	b=NdVQG/QVp7HKl7YqkX/gNZP5fgWO6WvWdBfAEnd3FcIBD0b3uveebUfl02r0p8dnX33U
	 XOI4tH3TNM2YOWFk69cx2PnItOgqsJhBSNNHUlInApR9jg3c5vjz6xg/Z8o5TWDW1dWRf
	 E2qYKcOT0K0ErdMBmF5gN9hAsAxJDv87raF15Dfq3ekcHG2lx0y42emNqofCHjA1rLAep
	 Rhu+PShWMU6a5rfmjkOQoGmVYeyA3WGEr0wk/NwLUmps1iPTi5zfXkMLxOTPh1WgVcCK2
	 CHAvYFedCt5ci8k+UgWwTmlg2Xfkh7glySCv+9g3cA64q4WGIslkWE8zUzwkKHKu5DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=CDqXCh9g;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1983A60A6F4E
	for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2026 14:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1983A60A6F4E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=CDqXCh9g
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so19055595e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2026 06:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795445635; x=1796050435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gcDUe7weJJYMrvTg7gVHHmg7tsUoApLJH7Q2bv9KvGA=;
        b=CDqXCh9g3gBn7Gqu7xnGzzahRm9GSKxuyxZ6SM9HRNndQ1marzSteyv9gBCp+opb88
         HgZXD+ENDEWRoaevbhwd8sePn8YCn9cIpKL74Vn9lG0vWUde6lQq8dffrKtyuQoIY7h2
         Lgvj9aMfhJMriO4fyWX5nHqygFAr1qCiygqgwJzbw2NAx3lY6HBBXX0anWHxSrjnFt5J
         8NDRGwZ2cDjME4rPp+tPaUwZUdNf8qndp5tfZnI5HM77ZOenh3ZoNQ3iKJDNLcVOPSvZ
         DwuRkG9TIgX67/6L58XuzqkB8So/KHrLKEw/kHbp+CEpNZarHD/NfHKqrf/OK5dJ2D1M
         /i3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445635; x=1796050435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gcDUe7weJJYMrvTg7gVHHmg7tsUoApLJH7Q2bv9KvGA=;
        b=JyDj49XFVlcKhR/m5s1AahIO33wwhMvi6Yt74WPErX4rChyUAB+bc9BYh4frZIIlaO
         x+HkUy4QtiMaFNg+FnZ6jUEisQDiE4y9z6YjPtEY1RB0HOnovNrUzKvu1WPIGpVf0c2K
         f8BMePfZPn84mu4TXX5F29XKjSU6I9YBvJvuA9xSb+12K4KvbCbXwioHKW3Gn2DJenCz
         U9cL/x6kwHcguLJxkWQSzOVyjCtuOHQ0SaN9q7iyoCClmsAPfIJzT6t2X/OhpM9LuKfm
         6hMnmdU5p+2vjD+swiNevs8YyjOxVN8wsUuob9Le2fGjPnJJDb+sU/jCcfOVktTUBrxF
         zt7A==
X-Forwarded-Encrypted: i=1; AL+hErGwrh2sq2SIJ9hf5PrsFKBzIGKXqPe9JmuA0sjNGW5lAp8AewHUGTEIyUiM1iKNUOn8GE9+fLd53nE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/64XxyNNowgvcXPBTKEUwWyBOdYyx89dvFEwqEZwPRXxH+2fiT
	Kg2LCYxP1dgS4c8u2fHTEnl3H9hTTmcA/+Ctp8jeJ19VmXnAzQfefAV6GJySTU2qWq8=
X-Gm-Gg: AZFdTZfP2Eu/VpQwHZtXqohalTOI7ZYCfVbWBrMgymvb/zXpsjXsLcACQ1M9WzIyEE+
	pxZJ+SQlCCs/XQUcjPe8pli9q1OevIFtvkIVXO9ysEafpHhq4uuxdIe+ivvkdij5jio47fcavNm
	zxM/yziYDY9bsigyoVm1IqEkEKPIfdUMbkLIj8NoX9e5xbsoKBTz547bra2TpYE0OKDRGo3oBOM
	zloemjuu3OfHBb8O3E+i0g/qNGwu5q9yKhx6Bwdg8riRVoLZS9SvFswZJKlOwMFxxHXLB7PCgmM
	VCxhXaXxe2l7elNOH5vSs5d9DokTy0NPciyMRI0xG89239E1WHbNuDo1onTXmeQNLLe1kw9ftGw
	xoSP5eLOZH4j8zbvlL+jLcQuD27Kl/q3wlZ1WWJ76KmPrWnA2Fo7vWg0FetWZgRJIeCuQ953Rg4
	z+Mn9Btso1X0KKviVi2QScjWvqfEfOI0EXKUBRz/f2eX5znJ2bTR1iDEEW2HshWvvAr8w0aa5y1
	kjZzY17HGl57iG99eFeeOq4D+jB6zmBYm86E7WfIoJHK0X9WNJW7ArzRt5EakQ77KD1mLEU/A79
	fZpOmfS0Hv599eV7y8Lalm3btoE=
X-Received: by 2002:a05:600c:1c1b:b0:4bb:87be:c138 with SMTP id 5b1f17b1804b1-4bb8893e021mr265842135e9.32.1795445635536;
        Mon, 23 Nov 2026 06:53:55 -0800 (PST)
Received: from localhost ([82.192.120.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm340088765e9.10.2026.11.23.06.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:53:55 -0800 (PST)
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
Subject: [PATCH v3 16/28] mmc: bcm2835: Pass the CPU physical address of SDDATA to the DMA engine
Date: Mon, 23 Nov 2026 15:56:54 +0100
Message-ID: <20261123145728.29082-17-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261123145728.29082-1-andrea.porta@suse.com>
References: <20261123145728.29082-1-andrea.porta@suse.com>
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

