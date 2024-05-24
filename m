Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com [209.85.128.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D8C3EA9B
	for <linux-mmc@vger.kernel.org>; Fri, 24 May 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575283; cv=none; b=uxMsWdrD4DS4BQFvlZ6F0wjcePrsBb+rMDJSPuhuhODv5oBtq8c/S8kJEiiIApHxS9+ywzoOGZyxvwwHKqWcx6D3bOlxBtnX2fjZk/7oEWLynCp8qBIuPoHJReC8npyUoeA5kB0pqiL77Z7JIt96LInMsa3n1rNm4eswUXZKP5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575283; c=relaxed/simple;
	bh=5nrl5uVGiAQbueZrACpZq8a6cFbZpWvV3c8a8/I60FE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o82zp4B8I0G7svkYLzRpQdeXYM7gQnhaAWfLYgwO4u4SDbW6hQRWtWYrT8Npl30f7WSNd35msl44oXCegukFtdcIVt6CZN/Qq4k2JLzDV7VTZb+gC50oZ2pYvBCj+3jP94t2YFrpIsV8ztJwwEDF0fd4+WvNkYC2LZhazfvjAF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=M65Q5Uek; arc=none smtp.client-ip=209.85.128.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="M65Q5Uek"
Received: by mail-wm1-f100.google.com with SMTP id 5b1f17b1804b1-42016c8daa7so67093605e9.2
        for <linux-mmc@vger.kernel.org>; Fri, 24 May 2024 11:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575277; x=1717180077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsDDNY/QwJvf47dmHC7PRu5uL7JEaRYA48sLf9OqOOY=;
        b=M65Q5UekziG+lHvXQ/hI4nw4upU5bbNJVfgaHqEmGJLfmLg/wnt5OLrm1bsxi3HXHe
         hMi+LCte6mD6ONooYUmb9MJGl6n3IO0se3b14h68fuMTOAqkPm2JK3TWzOvNuHEVa8Md
         vNqC01pAGWD0D4ZY7ILTvYgxGTLmHYTdqM0IhIQwdzsEb5KbMbI0I/NQ7QIQaRlqERmf
         LNPrD7IrxfR6TeGLsMCnZfRaym/deOUkUAGgaKZvovawuN3PG3YHcKVtAWzw/TNDMOv/
         4VSeuFQ2ODyw0fdTrGMkIbOvFA2AsMEfAVghVKJwElD2ONrMLZVAmj+yW2wwG43+xpzg
         jhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575277; x=1717180077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsDDNY/QwJvf47dmHC7PRu5uL7JEaRYA48sLf9OqOOY=;
        b=oOW1HYkhvW9LecbDRIoc3x7XkDlcsYzQc2eWBR3kRjgdbRr/elaJywgRoywkEGuTWO
         q9GKBsRkhch3i/ZTJnlgD/HG9yJ2WqcJL1mG1yhZimWXBum3nwHOIG0gRpteAOouJKKZ
         t6QGYuvNc29JvFmJiPrsnti3f8K1FS34lmPXohTpSZZ7mCgW09LcWK/+qTZdAxhI3Yz8
         MDKmPUfSJ3RB+qEnXIn/65EXWTlJY9/lZJV53YQIJnrIPvdT9ZhKko6LQh8fhbLYqEz5
         5Ri1+2jNRjzU1PGZnqiTD2vfVUUM5Ii0NRCPy2HTI9r1Gfelm9o3twu2FXNdS71Eo9j3
         xbbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbzE1171AkZm8MbM+TYiue/zERLubIZB44gw56Mqy+ERO80JiT+vrzaLPkPsDy3ewirpXWjc+039g/1Kr8vGD5ZqNWThBS/p2h
X-Gm-Message-State: AOJu0YwvhCP4OoLiim8VxtlShjQgbCbqeizF5JIOO8wfQHmtfBCrXGv0
	8lIDc+fnDqkqjnR3L9dWFfzKiPS8KEC6Kh6kTUYa6FPUuKr6Kzwrbpv4MreE1OazHLEd/RSyKVr
	3VqN2yNHB/haCNj3XoJD8uShLsz56tOKD
X-Google-Smtp-Source: AGHT+IEXHyAwczg+VXo+M67fY0mVhzt5oPk36AjtQ9lYPMdZoLz7U9U+HdeHdCJz5d472HFdCSVQwmE4fQK0
X-Received: by 2002:a05:600c:3106:b0:420:29dd:84d5 with SMTP id 5b1f17b1804b1-421089ebf63mr23274805e9.5.1716575277312;
        Fri, 24 May 2024 11:27:57 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-4210a964067sm979275e9.31.2024.05.24.11.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:57 -0700 (PDT)
X-Relaying-Domain: raspberrypi.com
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mmc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-sound@vger.kernel.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH 10/18] dmaengine: bcm2835: Add backwards compatible handling until clients updated
Date: Fri, 24 May 2024 19:26:54 +0100
Message-Id: <20240524182702.1317935-11-dave.stevenson@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
References: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcm2835-dma has been (incorrectly) expecting dma addresses to be
passed in, not CPU physical addresses.

In order to fix this up, add temporary handling of clients still
passing in dma addresses until they are fixed up.
This will be reverted once all clients have been fixed.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index ef1d95bae84e..9531c0b82071 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -283,9 +283,23 @@ static int bcm2835_dma_map_slave_addr(struct dma_chan *chan,
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_dma_chan_map *map = &c->map;
 
-	map->addr = dev_addr;
+	if ((dev_addr & 0xfe000000ULL) == 0x7e000000ULL) {
+		/*
+		 * Address is already in the 0x7e... peripherals range.
+		 * Assume this is an old client that hasn't been updated to
+		 * correctly pass a cpu phys_addr to the DMA subsystem.
+		 */
+		map->addr = dev_addr;
 
-	return 0;
+		return 0;
+	}
+
+	/*
+	 * This path will be updated to handle new clients, but currently should
+	 * never be used.
+	 */
+
+	return -EINVAL;
 }
 
 static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
-- 
2.34.1

