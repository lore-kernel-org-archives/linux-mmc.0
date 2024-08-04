Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4CD139D1A;
	Sun,  4 Aug 2024 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722793475; cv=none; b=WOib50Fxd2l2uBNZ17Ql9bO7Y/fBxdW6klv13XniOySHZmFR3pfKgPcqu+huSuCAGfFJ7rNSgSrZbjOtU5jrKHvbPPNy9nmBpKBGqkyB2kNH8uEsqJZWh8TkTawa5HDPz4wDnSa3rQY25U1wgYm5VA/GwG+uSyQWY2aRwzCJasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722793475; c=relaxed/simple;
	bh=P6tl98PPpFGrbbFj5w75g3BxJxNbMlbPQduy4dlyBE0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rj4F61L/aQ1/7yxEJBXG7nA7pKg6eKbfwoiVLdwlIty9J3Iw6pTPOp7GBplKdoGwMsnj9dvYfIxtzpPLt5z+q96AS/pmqtzVbgZiXqsP/mroTYLhl4mzbsrmbQ/da0brk3zLnyNfRHv4hhrt1wfB3YMg+GWKL6nfw63OxWveMmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnCwZQEM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnCwZQEM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42809d6e719so67802645e9.3;
        Sun, 04 Aug 2024 10:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722793472; x=1723398272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJElgdSeo7tFBhUWI5Y2VGkmcaarTUGB2bJhxj7nOts=;
        b=OnCwZQEM08v/Zujyjcil9c/frULNyHyWxpWQDLCNM4L5fEqQaL+6EkVzl5H1RtJezm
         +WIeOJ1+NoHPh3mdLIX4Hm1NK9qFCB8Rfq9aMbFkV5LY4Eo02AZPsnoNPuv1t08tAz4S
         TU6wNvnLKQ7pKWYTx19cHc0mu4D4oORoNtcb1IaOz9211dnEwAly0MmilvHr6j/UjIJY
         8T/DnC+xKbfGW7YRpf6Vi2B5vfoM3QgHFDLJNcJ3jvMDW3fFK/Asle28W3WRh3v4d/is
         WhjCzDhmQpt8OxjsnqETwCnAjDzsVnIfoYTFisQJyX30XQ5Y5Cas0VNxCqVzz3SulLEY
         SfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722793472; x=1723398272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJElgdSeo7tFBhUWI5Y2VGkmcaarTUGB2bJhxj7nOts=;
        b=AHH6eEB8JexnN4lv/3SunAg0+KfVXMdjdU46YcnQagfdo6nSMEi+GqqbkMSHlS+S3E
         3ABRQEDEs2XUTzdW4pjqTgqx6dmR1OIzWKXUfDHPCoFh0qC0c73ewZ75VKtw/rKaRUHj
         Eo52Evh33MgWcuoUIwRqUwBFqfJvO/TDUwC8YRyE96ii4ChgmoJ494h1r2UVVjp/K+Lk
         IO7nL820vBx6iG4+NIxlDwLHdZ0YYWPStKJsk3J+uvDeePtdnml7UEc6/lZp0iAdGOp8
         0gSvTLVHcg2CgTMhLEtQDhHbF5SFyYUNnji8aPq5RzvLdLazJGV6FNPVQOZ+s1hgM3dx
         EI9w==
X-Forwarded-Encrypted: i=1; AJvYcCVBr/DBCiYdGfClDIkhS9ceKKKRFsBc0Vw8kM9235iOYJ1Ggq0m9OhyPhtVLc6GU9GIynZ0jk7aniG7N8qCP6pN/LaKcO/ugfih9UAWPQhy9eugIiB2GMLNmEEBuGdcc0PROf1cdcB5clLRFBCh7TIl/IPRQSpIVHZQudWlDzCEnqH5xw==
X-Gm-Message-State: AOJu0YwdPruq8kXBrSZI67VLq8M4/sFv3gCAtxxWthgYFbSSjjtBZ2iH
	/mUesmgbUHZFDI0V8uPAw2aquYPntAJwRUM21UvDLJVJpJY/Q2jA
X-Google-Smtp-Source: AGHT+IF6h/dGDHwUKaeJf81/S6Xw4YXN06iaLrsJ+xyLkFLlhqRSyGV1A+2MwoRSks+8BuECDOiQtg==
X-Received: by 2002:a05:600c:470e:b0:426:59fe:ac2d with SMTP id 5b1f17b1804b1-428e6b9369bmr73165125e9.32.1722793472007;
        Sun, 04 Aug 2024 10:44:32 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e0357asm109530485e9.12.2024.08.04.10.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 10:44:31 -0700 (PDT)
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v2 2/6] nvme: assign of_node to nvme device
Date: Sun,  4 Aug 2024 19:44:06 +0200
Message-ID: <20240804174414.18171-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804174414.18171-1-ansuelsmth@gmail.com>
References: <20240804174414.18171-1-ansuelsmth@gmail.com>
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
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 053d5b4909cd..344523274d1b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/backing-dev.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/pr.h>
@@ -4651,6 +4652,7 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 	nvme_hwmon_exit(ctrl);
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
+	of_node_put(ctrl->device->of_node);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
 	nvme_put_ctrl(ctrl);
 }
@@ -4771,6 +4773,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	else
 		ctrl->device->groups = nvme_dev_attr_groups;
 	ctrl->device->release = nvme_free_ctrl;
+	ctrl->device->of_node = of_get_compatible_child(ctrl->dev->of_node,
+							"nvme-card");
 	dev_set_drvdata(ctrl->device, ctrl);
 
 	return ret;
-- 
2.45.2

