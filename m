Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B33BB21;
	Sun,  4 Aug 2024 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722771721; cv=none; b=MPEhiKzBVAsa3Hzkwn6QQOYubeCQOsae9/2ivTIqWneES6SQvMm9EZ0+H1AAbTwSrFM3oCRcqO83aaWikuTyfd8jorm3AFQ/SIFi3BcDYjVcYn8B61GvDZl74KDw9kc7TE5m+Vg9iGXhg4bqQNo4ZiAKXvCbxavr9WQjTKee748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722771721; c=relaxed/simple;
	bh=VlA2x6zajbAExdNLQZ27s1DAMyMaLYUCzuAivJVFa1o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPt/43baAD/2D/sCppe1az5a3ekV1XWIuhfF8almVwtdVX0VEIuMYkZE2YIAvbzzw9BfPG7Rdthg7ALFuQaVdTDvC+ihS8XIpqdS3NNzDAwVGLbXzsHzbxdhUpU7U/e86C7awWdZkevOLlUNGS8ZS51o5p5oox0bEY9ApSKNDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5Hc/vaK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5Hc/vaK"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3687fd09251so5116457f8f.0;
        Sun, 04 Aug 2024 04:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722771718; x=1723376518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOfQ6PranLoD+iROjXBHWVrWUAE8K7cRNQ5h3Vwmujo=;
        b=g5Hc/vaKU3g8VUAg5FfSfHdaJMBKogpUuSBwRx4NCCyD4jq9C9/xR7V1LeggL22tk9
         paLJ/H0S8r7qbezfMa02v4Qgm24DM3PBW7objd+fIatb14/DIvwUXu8ec6XO0MvD6Na7
         JcFTbsYYYp4YqVYtlbAHj0acIqiNxk0FCVAZ7c86TYbm7ju48t3A/jYWXoFqpPJyoRfP
         PfUK1QeaeRUgl2fvEHLshzBG+HcCZ6Oo8TUo69siW3uZJ7ShrzssdNJLt8LAnub0YiIF
         gBhNH1WydgvCDZSRYaD45zpIHkWsT3Kl0v4VWl4gZ2sC7QmGQB34jjI6kbTzojcLc7bo
         JOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722771718; x=1723376518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOfQ6PranLoD+iROjXBHWVrWUAE8K7cRNQ5h3Vwmujo=;
        b=UUPrveV/hlB1P635Lei6JA0GciumOqdPkdw2a2mXAsdCLXuTaKVy4Nv7vVn48XTetB
         VKGe+GaSGNUMCjtaz39sAOCIU/BwWUMdw+64oI9aOmjsqPsJrJRwTd3x2gaYfzaHTvmW
         n+kbsW8mIdc3MyH/sO2PK5d0j5CNtTHSESerf3tpq2CoNKiP1vE13hVHGNZJIAvdRUca
         +HJerZzwGeFoqpMebkwfcJeCnNA456q4GKAxcrakkjcavN244YkTfO1QFNM41Zc/EY/m
         b49Ko3/mIYkkc4B4HDr/4RVr9SSfhC02wvH8+DKu6KDBFmytYzwvb8lJxl3cosIGt4GO
         R+sg==
X-Forwarded-Encrypted: i=1; AJvYcCV5ss2szaZcLqv3IEM7mLnJbW5dwm1iRTeeOauNveK0us0e82kLl4Bh+oN1TCiUduxVPtewuLZYifDQeSdKCi+5Wng2K56XAlq0QOZkSewGzirMtRRc66fCNhA+x0cMaExG3iZDJC0MXtFXN04mIgrS1DOaP9Xz8CHEZNV4AQE+bx9fSQ==
X-Gm-Message-State: AOJu0Yx1R1vo2bkFHI0WjJM05NiTdVLi9tbi1MzdDL23ahBy6cslyFg8
	50BVKyzZvpLMdnIApmZOTevYWxZizuVEX6Zqd4WbvC7gFOlrb2FR
X-Google-Smtp-Source: AGHT+IGmBqLkmUPrb6PVyJ646RbotoYKt7rhCLpvhXazgn9MYHBkQIQkseu8qxI4YXnyXjeT1VIzkA==
X-Received: by 2002:a05:6000:a8b:b0:368:327c:372b with SMTP id ffacd0b85a97d-36bbc0dcf5fmr6441035f8f.19.1722771718267;
        Sun, 04 Aug 2024 04:41:58 -0700 (PDT)
Received: from localhost.localdomain ([109.52.148.115])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36bbd01eff1sm6635130f8f.44.2024.08.04.04.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 04:41:58 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/6] nvme: assign of_node to nvme device
Date: Sun,  4 Aug 2024 13:41:02 +0200
Message-ID: <20240804114108.1893-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804114108.1893-1-ansuelsmth@gmail.com>
References: <20240804114108.1893-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for a dedicated node for a nvme card. This will be a
subnode of the nvme controller node that will have the "nvme-card"
compatible.

This follow a similar implementation done for mmc where the specific mmc
card have a dedicated of_node.

This can be used for scenario where block2mtd module is used to declare
partition in DT and block2mtd is called on the root block of the nvme
card, permitting the usage of fixed-partition parser or alternative
ones.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 053d5b4909cd..b9553bb8fade 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4651,6 +4651,7 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 	nvme_hwmon_exit(ctrl);
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
+	of_node_put(ctrl->device->of_node);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
 	nvme_put_ctrl(ctrl);
 }
@@ -4771,6 +4772,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	else
 		ctrl->device->groups = nvme_dev_attr_groups;
 	ctrl->device->release = nvme_free_ctrl;
+	ctrl->device->of_node = of_get_compatible_child(ctrl->dev->of_node,
+							"nvme-card");
 	dev_set_drvdata(ctrl->device, ctrl);
 
 	return ret;
-- 
2.45.2

