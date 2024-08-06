Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69EA1C3F2C;
	Tue,  6 Aug 2024 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944493; cv=none; b=N8roDKo0EDHum8QCwnSgex9CyONs1a2MVpXVXzHZ5v/v4XVUmT7TJ+MZPzqtIdcOO0hXdVGAIt9LxRyv2JtFRwIgFGFSXF5E/3xpqfnNr8MpmMxMYRJwmrtN1slqV8Ne7YUsmwz3cdbnbsKbDLeMiUFv2clw+wuAOhA19jHROgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944493; c=relaxed/simple;
	bh=P6tl98PPpFGrbbFj5w75g3BxJxNbMlbPQduy4dlyBE0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mT9xtADyxo+rSieiy+/iGEANAfliY8MplwjCrbrdOyZTq6PRQFNQOpuuK6ZRJle9tAW6fsSaGimp+KyhDtkywctQFYsrO23VZY66Cumnmq9JbVEMZ+8kCZPnPSOQnCtBAkFnkE9oPvfbjpIhSGQZ+D6GPbcbQJQHj23l+fFrqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlsxkO35; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlsxkO35"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so3160305e9.2;
        Tue, 06 Aug 2024 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722944490; x=1723549290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJElgdSeo7tFBhUWI5Y2VGkmcaarTUGB2bJhxj7nOts=;
        b=IlsxkO35R39MJI3q2cdhscPqaXtUIF8NJR9IKamgR+h+NkdpvrpY5+ZE9Lx4rDAbK8
         MiStfcMssn/tW432x2crwMHx98OSHGTLnpEPDCdpdXXcF9PxiK5OyhjF2cV9ZAwFZpFA
         l3KKscn0YpeMhLlHGtz/U/psVFoSZdWnwRu4UbwgE2CJDF2NXRMiRaEK3fKmPcKCEExD
         1gXoTcg0fbLZov3LZT4M6wnIp1+4DKD5H5DPY6EzWlHeSpbJr39yDJYMHjhMNZcUGjIx
         RVfYMAuzr/dfqfC+s9mZou4q5GRAgvM18R3EVw+4HQaoUB91tPQGdD7CeH658RiZL+F+
         AIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944490; x=1723549290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJElgdSeo7tFBhUWI5Y2VGkmcaarTUGB2bJhxj7nOts=;
        b=A4e5fhDYv/8cWPNDs4oCRIquAUcL83cwVtPxqgfAmxbipCBLsE9/1MrHnPun+yjiYI
         SyaNsH4jZzk4opbvu6wrMnKqISHGEspZPqThwPL21dWt3i0kEe0gcvMxVFcTV+ZMw36L
         Ylx9rRX0uzIMopP5RpHI2Ih/AR1dNRxl/exZVXyrmj87s+i0D2nJ2K4mHZoMgQhpMakp
         Fi0XcU/3AblAbE20tGq0oR3U5KKKnLBHv4IiI1nqLPr4VSahnoNSAiGoGWZVk7nJvSnW
         0bdqRKXp5qpAbHF39UxCiNgDnadAb2it43i1pQgI76A8YYHVmo/NspcWtZvptHxqy+ok
         Odcg==
X-Forwarded-Encrypted: i=1; AJvYcCVq6T+roemixXKMJXh4Q0i1LqFKDSkQX6e0d8QQiVMu0KR5Y1wUxSxhxFCuVnLUUBklBsGBno7hZgc5ci/9LximnrFKnRYOwLWGEO9UG5znIC2raEwKpn6AhEsJZVD1t072sDTx4ypaw3YnC79S84YOmHkcaMJekKqh54du536F6cm1jA==
X-Gm-Message-State: AOJu0Yw+dHxoM5W6m3E3PwNMJk2AZ1rGQuC8740woqWdywOOBv+xgY5F
	S8ZSfK2UOilqU/5gXiYGTKAQc6e7U+h0ByQWOo2ftk+kzHHAroif
X-Google-Smtp-Source: AGHT+IHsLBFQO+J/lS62zM2qc6hKgOhyDSFxfwIUq3wJKk0pA9FyD5Jiwj6/3xBLV/JtPtreeeXWCw==
X-Received: by 2002:a05:600c:4e87:b0:426:60b8:d8ba with SMTP id 5b1f17b1804b1-428e6b7cab3mr105454325e9.28.1722944490056;
        Tue, 06 Aug 2024 04:41:30 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e7cce6sm176105845e9.31.2024.08.06.04.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:41:29 -0700 (PDT)
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
Subject: [PATCH v3 2/6] nvme: assign of_node to nvme device
Date: Tue,  6 Aug 2024 13:41:12 +0200
Message-ID: <20240806114118.17198-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806114118.17198-1-ansuelsmth@gmail.com>
References: <20240806114118.17198-1-ansuelsmth@gmail.com>
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

