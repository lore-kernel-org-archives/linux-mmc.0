Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FE22E4994
	for <linux-mmc@vger.kernel.org>; Thu,  3 Jul 2025 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542076; cv=none; b=CVtQz16Z+TuZsZZ8ylt2S4EavoMd+PFXDnxyPboHJDUIXMHBaa1Wz34EhJ30wK4adHvHBIVWg9R2ojiIFBO5nk1db8HDoyKe5+FK0uJjSYnlKlXoCvTyDq92BHrkWSvuBIubn26BPxNQCIWxekjIgy0V03gK4I8cRYG6TDJPyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542076; c=relaxed/simple;
	bh=dKp9sNBVKhCMWq2ozbMkBemUSa+iPERmFu+4dZggoQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnoqtqOpzwcraTeiQ3/ER12EiV5XwljlY9jrdp8MvtMo9HQ+hSuXguEJRsVsO3ACAagWZE1fivWr2U/w1xKC/3qYMu3XKPhkHRLeP3sd1ksreeLVUTC9badKt9DJuqkqIBGQohoPYL6lRBfdgTx213K1u0QTLtpKnI3c7QbnuKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cxqeRkAm; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cxqeRkAm"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so1388522766b.2
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jul 2025 04:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1751542072; x=1752146872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amy1aSEWJFLjdFKle4TRafGT1dI6FK2dRgoWrJhpEoE=;
        b=cxqeRkAmo+uhAkoMMQwvBP/akaaA+fW/9V9vZNVm2+J3NsvGJPkfzEQDkhNz6BvmOh
         3sy7SDwTPiykFPgHxFKqPDV70lgxb9VitxB2zID8UhJEFqbjSr6/beF1A+paHxzJLbV2
         fCsPFX0X2dXVHFISOIdTo8bHJzzw2i/2PWJU1fYLb+tV1f0mIKR8nnHFEOgX2m69aacR
         NgtAX6hIBrFtiKatkSlnHgVieJORSNq7h/WbY5fRfJUzCPYMt6OG0G9qmrBkr2OuIoFH
         BjAsSdZRFHbIo+yxKwu60qLSEiRdqqKoSmqYbWC/MXA7Fwv6q3tItqmJmsLAJS2Nzb1K
         iL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751542072; x=1752146872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amy1aSEWJFLjdFKle4TRafGT1dI6FK2dRgoWrJhpEoE=;
        b=e9rOT6oN8TI1BBIS4By36d/PamJZAwwLrJ+qFVZ2Sew/ldV9B7d2LdbhzwBwMCm9Tk
         c6QJ+to4Va1LvLpvI1WjS9int3tO6Bxvc9aXcA0tDmSO07nqMuYm06jduyHoQF5oSeel
         BHy93X8Ew7wvARM+n5UeFgm9cAb16zkeu03sFQ1bJ2nY0CAnAMF69Z5ycx6AqYt2VAyZ
         lHdMZlm+8h4GELb1IXmWrPbIiPU4S5i4tu4A4buDj/NdLBthOMKBkmmP6SMf1EJThXhQ
         Gv+qJgt6R2cnjkd4/wosT+zg1/wxAG1Q3wuHT35hNP98iyz/INFjxhjcar2l0C/GHFhW
         mMsg==
X-Forwarded-Encrypted: i=1; AJvYcCVR+Ile29M4SMDIxzT8tM7daIzIfUnqHSQ1eDBZ2qBgur6A3RSfaZGcxsMYlzEHOglrnL8Q7rXr9KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YycR8/d2lrySMTUqCCxzmb/MNQnpGekAjaOnPc1f7wEUU8YPyEV
	nnQIb/XYOXtGYHAm+f1PdTDmjz+XEd2kUKArv8NS3Hy5ado+R6RCjUFGLy9kMU5qKCU=
X-Gm-Gg: ASbGncvhUOvtm2up12N/9izyxp6aetRZt2ty99EjvAx+Bvb2Lb6few6T2KA9KPFJbgr
	MEWaACYoWdrNyhBNVCv+zYYQjDyomuRw+65mQ6sTGYjGbAW5YG7+dvUgQNBpYQM1Cs80Nq2ANJO
	fSFsfBa+Fn4QMHgaxVBnWI9Q0BsXCtAUF+fvSO6fBH1DNulyavaU8v42NGhqZ0ClvA553wcBbPU
	HPjlkqtq35TZuMuC4zEZ/TV9GM4Px+CXXSoX2WrufQYFBbBsAGqt/KB6hD6f8RHJLTeWv48jb+P
	WMXbVwip7cVb92iE6EdqP8sm1X1IqKtnMkHWKYbcggWiQl43W945qHPtAyVeOaXdBVOehhPJxBv
	wlsUBiJTJXnvgGmk=
X-Google-Smtp-Source: AGHT+IGtvsJyDMQsLfUDl9utWzUCxFT2n50ILIV0XhgAq1dND93ylmRMS+yE9TxwtIdCeTyEpsNdFg==
X-Received: by 2002:a17:907:d644:b0:ae3:cd73:efde with SMTP id a640c23a62f3a-ae3d8b1b1d4mr273821366b.44.1751542072208;
        Thu, 03 Jul 2025 04:27:52 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a75fsm1247016966b.67.2025.07.03.04.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:27:51 -0700 (PDT)
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
Subject: [PATCH v5 3/3] driver core: platform: Drop dev_pm_domain_detach() call
Date: Thu,  3 Jul 2025 14:27:08 +0300
Message-ID: <20250703112708.1621607-4-claudiu.beznea.uj@bp.renesas.com>
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

On the Renesas RZ/G3S (and other Renesas SoCs, e.g., RZ/G2{L, LC, UL}),
clocks are managed through PM domains. These PM domains, registered on
behalf of the clock controller driver, are configured with
GENPD_FLAG_PM_CLK. In most of the Renesas drivers used by RZ SoCs, the
clocks are enabled/disabled using runtime PM APIs. The power domains may
also have power_on/power_off support implemented. After the device PM
domain is powered off any CPU accesses to these domains leads to system
aborts.

During probe, devices are attached to the PM domain controlling their
clocks and power. Similarly, during removal, devices are detached from the
PM domain.

The detachment call stack is as follows:

device_driver_detach() ->
  device_release_driver_internal() ->
    __device_release_driver() ->
      device_remove() ->
        platform_remove() ->
          dev_pm_domain_detach()

During driver unbind, after the device is detached from its PM domain,
the device_unbind_cleanup() function is called, which subsequently invokes
devres_release_all(). This function handles devres resource cleanup.

If runtime PM is enabled in driver probe via devm_pm_runtime_enable(), the
cleanup process triggers the action or reset function for disabling runtime
PM. This function is pm_runtime_disable_action(), which leads to the
following call stack of interest when called:

pm_runtime_disable_action() ->
  pm_runtime_dont_use_autosuspend() ->
    __pm_runtime_use_autosuspend() ->
      update_autosuspend() ->
        rpm_idle()

The rpm_idle() function attempts to resume the device at runtime. However,
at the point it is called, the device is no longer part of a PM domain
(which manages clocks and power states). If the driver implements its own
runtime PM APIs for specific functionalities - such as the rzg2l_adc
driver - while also relying on the power domain subsystem for power
management, rpm_idle() will invoke the driver's runtime PM API. However,
since the device is no longer part of a PM domain at this point, the PM
domain's runtime PM APIs will not be called. This leads to system aborts on
Renesas SoCs.

Another identified case is when a subsystem performs various cleanups
using device_unbind_cleanup(), calling driver-specific APIs in the process.
A known example is the thermal subsystem, which may call driver-specific
APIs to disable the thermal device. The relevant call stack in this case
is:

device_driver_detach() ->
  device_release_driver_internal() ->
    device_unbind_cleanup() ->
      devres_release_all() ->
        devm_thermal_of_zone_release() ->
          thermal_zone_device_disable() ->
            thermal_zone_device_set_mode() ->
              struct thermal_zone_device_ops::change_mode()

At the moment the driver-specific change_mode() API is called, the device
is no longer part of its PM domain. Accessing its registers without proper
power management leads to system aborts.

Drop the call to dev_pm_domain_detach() from the platform bus remove
function and rely on the newly introduced call in device_unbind_cleanup().
This ensures the same effect, but the call now occurs after all
driver-specific devres resources have been freed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- dropped tab in the call traces from patch description
- used PD_FLAG_ATTACH_POWER_ON, PD_FLAG_DETACH_POWER_OFF

Changes in v4:
- dropped devm_pm_domain_attach() approach
- adjusted patch description to reflect this

Changes in v3:
- adjusted the call to devm_pm_domain_attach() as it now gets
  2 parameters

Changes in v2:
- dropped the devres group open/close approach and use
  devm_pm_domain_attach()
- adjusted patch description to reflect the new approach

 drivers/base/platform.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index df1ec34fdf56..09450349cf32 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1396,15 +1396,13 @@ static int platform_probe(struct device *_dev)
 	if (ret < 0)
 		return ret;
 
-	ret = dev_pm_domain_attach(_dev, PD_FLAG_ATTACH_POWER_ON);
+	ret = dev_pm_domain_attach(_dev, PD_FLAG_ATTACH_POWER_ON |
+					 PD_FLAG_DETACH_POWER_OFF);
 	if (ret)
 		goto out;
 
-	if (drv->probe) {
+	if (drv->probe)
 		ret = drv->probe(dev);
-		if (ret)
-			dev_pm_domain_detach(_dev, true);
-	}
 
 out:
 	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
@@ -1422,7 +1420,6 @@ static void platform_remove(struct device *_dev)
 
 	if (drv->remove)
 		drv->remove(dev);
-	dev_pm_domain_detach(_dev, true);
 }
 
 static void platform_shutdown(struct device *_dev)
-- 
2.43.0

