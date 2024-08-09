Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F6716D4DE;
	Fri,  9 Aug 2024 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723244553; cv=none; b=onrGaZ1/35JCfx61v1Mulh7YhALT3TkqpLTGAE8d1SBBkJvl9wXEkIdjJqvZXt9e+FJ6RnQyC+ah0dexwNr2zjUnV2o4WRsVvzVH2K2S3Q0ptZnppK7ZLI+N1c/wlwmHXq+2+Uv7/rh0AqlKMnkLYjmXGlh3v/rbTeF9uXyb3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723244553; c=relaxed/simple;
	bh=P6tl98PPpFGrbbFj5w75g3BxJxNbMlbPQduy4dlyBE0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZsYuIh1jTD25c3LBIMkaX3HMRuCIdoVMg4IGqLJ2Qdy+DWSvmryicsH9wCggdVQg9E16Q3SOMigb8psFFvpU4KNyRPgkSrs0OkjaDeA2GbThdeQ6qrm0H7xaTX5I3Hps/XQaEDwNZtfgm6z9p7E/UM/fpb6/eOgu3Vwzm+PO3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQ5STpiI; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ5STpiI"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f189a2a7f8so26297691fa.2;
        Fri, 09 Aug 2024 16:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723244550; x=1723849350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJElgdSeo7tFBhUWI5Y2VGkmcaarTUGB2bJhxj7nOts=;
        b=aQ5STpiI548Jc6P+Ykfxfrd7T2wEL7ep3oRoMId3cGoTfmdBzjYlQa5afQHxy1AVCA
         yBn61oVL+ZkmAZe+nDWsCSd5jRWLNV4c26jfrYO3y1x2H/YGOmzmCZflKfCo+BpvGmAz
         d5oZbbhgKRHzmAvfqoKQr00GnZS1fhFpmh/t6oDFVJp5LgA7Jnmw9DGAexf4GlYmXFXH
         1Ba3cp4CZeUxXkf7IiKDFX/oJcSYU6nrC+bmq9sHm7ZvemiFifcSBxBBeVVcCumEvSZ6
         HqXtAX417uuL0nKGNMyrCvWUFm89gUaRlwRIZ45eXiI6c7LMooVp2TLt6eH8D4syTzkt
         umnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723244550; x=1723849350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJElgdSeo7tFBhUWI5Y2VGkmcaarTUGB2bJhxj7nOts=;
        b=U0z+IcQU8u4/+WDrlfUILFdmjjnUlnfrQPQndlniEzOi+MgcliRskJJJDgSG9SgsST
         Tta/K3jg+1r/84sySxpKYt4wJ4xLn7G3AtQ4KnqfILTLxDhMw+sdXGiDMuMHsoN/v95f
         Nd0cNHU9oBNQP21O+d/l4bNIihji+0eweUUAFbspanqU1JpqvJRdy9O50TEt5y6wGVTJ
         P3WWXo88JRUz8DiZUocmyNKo+caix7sGw2SjVifm+S6U2W3QB4+T2ZLIBL4VItPeYNsz
         Qu5unEn2d9S6ypLd0PpnfpF6XSpSCMM17jd63pYobayWf5as7UCOeLZWtpF4BwpX4MNG
         nMFw==
X-Forwarded-Encrypted: i=1; AJvYcCVLqFebroocQ8dsiwM3c2R5OhS978/a1/xX+/f+20b+esLW1Z9iv2egBNu+xlfSXFy3owcE4loVjb0aPu73OGuIzKP5VVqysWgVfszkWzxYeRikI6LDEW8qCzoldvTV72A0JOqpkkDpKk2DbrUYhiEKHbpFK73LUOEiRT/i/LYDgxcPAQ==
X-Gm-Message-State: AOJu0YyeW6/+TYCUHJHXv0i2LszujbCTbe2QhjccbkXC3lUO43hS6OC9
	om5OWDCLET0mU1whl9Sy2ctjfnKjuiQFmHXWIcX+s76iJ/sDVrKYaIry5g==
X-Google-Smtp-Source: AGHT+IEgI2zjmdRYRlZuFS3JMcj18YcXEyrI/y4EefxeFqU02qwA4OQ98srTe294d8hiQpQ1tz2BoQ==
X-Received: by 2002:a2e:98cd:0:b0:2ef:216c:c97 with SMTP id 38308e7fff4ca-2f1a6c65834mr20972061fa.19.1723244549573;
        Fri, 09 Aug 2024 16:02:29 -0700 (PDT)
Received: from localhost.localdomain (host-87-10-253-138.retail.telecomitalia.it. [87.10.253.138])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429c75044a8sm7987485e9.9.2024.08.09.16.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:02:29 -0700 (PDT)
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
	Saravana Kannan <saravanak@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v4 2/7] nvme: assign of_node to nvme device
Date: Fri,  9 Aug 2024 19:21:00 +0200
Message-ID: <20240809172106.25892-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809172106.25892-1-ansuelsmth@gmail.com>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
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

