Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7272E49A5
	for <linux-mmc@vger.kernel.org>; Thu,  3 Jul 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542073; cv=none; b=IEf+ySUJ7yDocM6iNuM0nV2jWnMcisPAYmEWGYBHkA+6mGH+aPrJOUPcCbL9e5TO+953DBmG0obX+aSgqKUai5fQDAT7lKRcDs6GlZL/qKBurOjCWGJNT4MmABCQ4NbIToRai9x+yAxusMxlLZoqqReurCx/V9tDVBgHV0IpK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542073; c=relaxed/simple;
	bh=X1Oyr9vFTxLX3A2BuvfxXazNPEQYM31gD4YJTucU+Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMUj0eDdzaJtPIwThhF5BzalJEb5IKMrs525hB2e7MfDbZxSDtLaL+U9e7d6bZ5Dyn9DbNG8fO4PIbLbRJK6MgWqIW2U6j1/vohmefIIMOMk+ML5SCoUAF1Fwuqj14FYsE6e6TSxaLI1GjXrPzrlex3PKoRQkpbit20dC0YGLB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NWaPrfeM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NWaPrfeM"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae360b6249fso1074324366b.1
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jul 2025 04:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1751542070; x=1752146870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTGALKZoVheypQ1QT5i2+A3Y7/0VfJ5YTQvSLmEPSq0=;
        b=NWaPrfeMNu6lzcL6odLfZsNPLmYpVaPVg30El2x0eGSaccOcXkGqo1EdMEBm1zC5GI
         UWaqm6d88selempizMTQdl90luJ/o+HoxhIRBcnWkeaVoOAWZ5OPgM2yecuG97Pr3HJk
         qS96Ys4Ra3HzmYQX/1A68bF3kcz0O6hpK2bGHsmMkmPhgrbC18rNVDAvvopGIFVsu/1D
         LZHIOwrOvbHodHlqKABBqMCqB/qUr4Ndf25U9wWhGVeY6W8qK6Zb1JmladgI6A9GLm8M
         hHIviZwE4iTBFIbTFTNuii2SNcEwqd8Jb01yMnVWxLifPGewD6MrP5QTZ1wX5YqjBED6
         GrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751542070; x=1752146870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTGALKZoVheypQ1QT5i2+A3Y7/0VfJ5YTQvSLmEPSq0=;
        b=D+o6/9WZqy0hgn2FKZsSoPodqMXn0WwtR7BIi0vHqYEqK8zr2ydR0jLnrpmGJWT03z
         G+xiq0mM6awXvryltAc6V2Z5RzNoIFk0eSMlvJMc7Qtz24gdWzB4OWr5ZL7381P9ikIe
         tZ0qvuNPEiGLUVWvKAeojJURPIPOOpsm4sm56k+xKFxMKHy9L1SeNYFi+OPSjaEUD93F
         DVG6EWJNyMt5seo0mievbdzh3mnkMpqjam/kudIj8vGv4mWgrkHmT9LmSB2mgkDSZ8s/
         kIcK2Lr5cu2MQowU5wCqAh0fb22TclmdmTztYMAArhYLuVWTZQjwRUgzf/V0J7c+Vopp
         XtVg==
X-Forwarded-Encrypted: i=1; AJvYcCW7jCGt4I2xU8LB+O5ZAZDjVIr/8Vpj5Fdn6RM8+7XJ41ZVdzUqj9Tl09sV/VLxINyIlrCb0QYRB4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGlZ+Yk4bS3t6R/c1hSOfoRI/5GLljg3vtL2DSb4yLBxUtURI8
	9FP8s5eHc/wkvIOYYXfI4bbSylRY/F19y1FwltLly/cTPuTJvczI/LomIMx3pnCUkR0=
X-Gm-Gg: ASbGnctqCjpUuN4I+TLP0jRGUQsj8Yx5NoTpHBKOhLVFksVwFpjOJ9wGDGuLIoiFyca
	MBDyLE9EcmFGLkRaDu+yrn/wm6frUoymhmjr9S98/8RGTusUhKHLUMSt1ujts9M4ReACTSrXjGd
	6PZPTGj0uD6/LiwAy1vmcujIw/Txwu1RUNKcPS63vCyvYeP0XWqNM4jnK5uh6Rtv0SgX77RqoFm
	+KdFydPxI6TNpZTvwVK5+7yi4ghVKrtL9HbXBAqmyMolNen9uor9CKp6tsRuF0z/wQf7BAvmdfd
	1yDAokBpGGcArOnr8fCgfcmIJ5ihpWUG8Pu5Fo6rS+UtD5GiYOHnKYj9SjGrUgFMGUUT1daF2+5
	SWd9Kj5EuZz/IDbw=
X-Google-Smtp-Source: AGHT+IFkYQwbGErnKmAXbXp56IWazGm9DvxurIRdNCD1GAvBXxqd+zW8SE1e2XD1WudHDmEIZdYoAw==
X-Received: by 2002:a17:907:1ca7:b0:ae3:6b52:f7dd with SMTP id a640c23a62f3a-ae3c2d69de4mr612468566b.46.1751542069470;
        Thu, 03 Jul 2025 04:27:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a75fsm1247016966b.67.2025.07.03.04.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:27:49 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: linux@armlinux.org.uk,
	gregkh@linuxfoundation.org,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	rafael@kernel.org,
	dakr@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org,
	mathieu.poirier@linaro.org,
	vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	broonie@kernel.org,
	robh@kernel.org,
	jirislaby@kernel.org,
	saravanak@google.com,
	jic23@kernel.org,
	dmitry.torokhov@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	bhelgaas@google.com,
	geert@linux-m68k.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	fabrizio.castro.jz@renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 2/3] PM: domains: Detach on device_unbind_cleanup()
Date: Thu,  3 Jul 2025 14:27:07 +0300
Message-ID: <20250703112708.1621607-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703112708.1621607-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250703112708.1621607-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The dev_pm_domain_attach() function is typically used in bus code alongside
dev_pm_domain_detach(), often following patterns like:

static int bus_probe(struct device *_dev)
{
    struct bus_driver *drv = to_bus_driver(dev->driver);
    struct bus_device *dev = to_bus_device(_dev);
    int ret;

    // ...

    ret = dev_pm_domain_attach(_dev, true);
    if (ret)
        return ret;

    if (drv->probe)
        ret = drv->probe(dev);

    // ...
}

static void bus_remove(struct device *_dev)
{
    struct bus_driver *drv = to_bus_driver(dev->driver);
    struct bus_device *dev = to_bus_device(_dev);

    if (drv->remove)
        drv->remove(dev);
    dev_pm_domain_detach(_dev);
}

When the driver's probe function uses devres-managed resources that depend
on the power domain state, those resources are released later during
device_unbind_cleanup().

Releasing devres-managed resources that depend on the power domain state
after detaching the device from its PM domain can cause failures.

For example, if the driver uses devm_pm_runtime_enable() in its probe
function, and the device's clocks are managed by the PM domain, then
during removal the runtime PM is disabled in device_unbind_cleanup() after
the clocks have been removed from the PM domain. It may happen that the
devm_pm_runtime_enable() action causes the device to be runtime-resumed.
If the driver specific runtime PM APIs access registers directly, this
will lead to accessing device registers without clocks being enabled.
Similar issues may occur with other devres actions that access device
registers.

Add detach_power_off member to struct dev_pm_info, to be used later in
device_unbind_cleanup() as the power_off argument for
dev_pm_domain_detach(). This is a preparatory step toward removing
dev_pm_domain_detach() calls from bus remove functions. Since the current
PM domain detach functions (genpd_dev_pm_detach() and acpi_dev_pm_detach())
already set dev->pm_domain = NULL, there should be no issues with bus
drivers that still call dev_pm_domain_detach() in their remove functions.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- added flags argument to dev_pm_domain_attach_attach()
- added description for struct dev_pm_info::detach_power_off;
  @Rafael: I kept the detach_power_off flag outside of CONFIG_PM as it
  is used unconditionally in device_unbind_cleanup()

Changes in v4:
- save dev->power.detach_power_off in dev_pm_domain_attach() and use
  it in device_unbind_cleanup() when detaching
- adjusted patch description

Changes in v3:
- dropped devm_pm_domain_detach_off(), devm_pm_domain_detach_on()
  and use a single function devm_pm_domain_detach()

Changes in v2:
- none; this patch is new

 drivers/base/dd.c           | 2 ++
 drivers/base/power/common.c | 3 +++
 include/linux/pm.h          | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index b526e0e0f52d..13ab98e033ea 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -25,6 +25,7 @@
 #include <linux/kthread.h>
 #include <linux/wait.h>
 #include <linux/async.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/slab.h>
@@ -552,6 +553,7 @@ static void device_unbind_cleanup(struct device *dev)
 	dev->dma_range_map = NULL;
 	device_set_driver(dev, NULL);
 	dev_set_drvdata(dev, NULL);
+	dev_pm_domain_detach(dev, dev->power.detach_power_off);
 	if (dev->pm_domain && dev->pm_domain->dismiss)
 		dev->pm_domain->dismiss(dev);
 	pm_runtime_reinit(dev);
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index fecb85fa85ac..6ecf9ce4a4e6 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -111,6 +111,9 @@ int dev_pm_domain_attach(struct device *dev, u32 flags)
 	if (!ret)
 		ret = genpd_dev_pm_attach(dev);
 
+	if (dev->pm_domain)
+		dev->power.detach_power_off = !!(flags & PD_FLAG_DETACH_POWER_OFF);
+
 	return ret < 0 ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index f0bd8fbae4f2..be824dfc8577 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -720,6 +720,7 @@ struct dev_pm_info {
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	void (*set_latency_tolerance)(struct device *, s32);
 	struct dev_pm_qos	*qos;
+	bool			detach_power_off:1;	/* Owned by the driver core */
 };
 
 extern int dev_pm_get_subsys_data(struct device *dev);
-- 
2.43.0

