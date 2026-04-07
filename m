Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95CD397E9F
	for <linux-mmc@vger.kernel.org>; Tue,  7 Apr 2026 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564150; cv=none; b=KwZF7sACm6A8B+AJOCb9ELc+/spI/ldy9LGW4kvUAWU5UBDluykGvdHs9orl3sJrKkxW8PnB+7bSx1EPm7y/u5r2M3wxOy5jUdF28vYOJw+oP/0WI/7LSE9pVPP9/LqT08SdMjjAKRslAvj8DYsqNogn9a7/8nBZgotVPUJEEKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564150; c=relaxed/simple;
	bh=duNC7fAgfP+/WtJJ2whf9/kofDBWeD1leV6uWxOseYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cnHOX1xeFK0ISAIVIWBOL1lA/5e9sb+kj9oRIxu9VBrT2NnN+NxTBdUcuGswJNRRl0okDazCECQLhzBSVx3eIp6xxmoR4WvjGztLMQYzX6PXmAEN388GeE2rulL3bunXSZbe6dMgHbBt/niMfqVMnMPF6kiLl5071MjuJEWB4xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V7nJUwal; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7nJUwal"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a2beddab48so4885746e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Apr 2026 05:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775564146; x=1776168946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I+WojEMYC6/0fW7pAb7QL78xV/89mZ067SHdrUCnECw=;
        b=V7nJUwalXWGJmrQDcjs4i4+al/K/wo3o/6zz7HHVTXtCuotEV/BatJvQ2yzNd5eoUD
         vEGj5wTT9T59/M/8A/YKspayGYl8hLT973hvVdyfrk9AYy5LFeK5mHjWwbiYgb1OJMSp
         n80usi2sz1mr+E2QPIxTnWZ6pwY3Ab+fEKMByeJR5Ixuxez+V8fXyZKBrP2uJXV9hvcx
         vpxCQxRbnX9N9VFu5IAbqNYtDOeuMs9YwoDyPxfh1P4MnUD3yhgdQvAVS4++y3R0W4Fl
         +5nPcW6j0X+bzzgEwY69vV7MeV9yC6bg8UKSs0sd1Rx+su0pV8E1jqKzLUwr65DeuVUg
         3VRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775564146; x=1776168946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+WojEMYC6/0fW7pAb7QL78xV/89mZ067SHdrUCnECw=;
        b=NDclh4BxaNvpVFcfo6H7d1fp+F7/GFX/r++I+I/hxKfVWvogw0f8y15RgeO61h+peE
         zqmRQPoCqPHtZkfzdFjUa8A6Y1ifmoV10EhjkJW6yGjF/BAEvuqnLqwfryAb52wZKzLR
         IIwZySflefmPteb7tE68RfcJSwN/sOs5lhN4k1qevIEA6F1CtulinIsvozSl83F0AT7a
         /bWF+HmxcYFjAtJvY3QIDjud5MKfV5XsbMsg7/s6qS+1HCRe2eRrDfNxwn9vzcAB5aJv
         yOrByhjrLgBxW8nx4e6h2vHyCF2gpVX4UEYoK24Ar4K5IhD8VXlTZ4k8sSLRZyPMiEM6
         ruZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHUJc6g2xxDxPOEQUXCLHSqxM8PfCpzGcufAs8cE0Uuf37iv5ojucG687XQxscnCxd08ceJF0Cpos=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhp+MbGCiHOHqtl3FwU2SEvUsVny7AR5MUdNoDWas6vPRptjtu
	UsR7z3hgjrynnevoqqKNIzq/sAQLRuaeFZ0xuBDx+d3IQ9pPOkBl0mFU6a85lUD7vqd6hWYUJ1N
	P0kS4
X-Gm-Gg: AeBDieuE7IgPDQ0yHwPJMabXXVfdSHDbsygyy9F9Q6XO54wXE0F+NFbw0zT2p8vpUiJ
	rdhFPvDZOzbNc55N03KZNtAR1GBtfhYt5y2PQr72R4IbTx+eTJ7X1SlCNbeG7OFBLJeEO5UkTzJ
	7CAR1u4hjAOaGrMUZrAoasv8Uf23i/2tN6V+LltEj61zymyH0UayCsGU4cpcbbIx00B8TQc2hra
	c5t3F9ULqaFkdVUq6NkxUX2xpB8Df7azx8jdqNRZ6OYtLojSRib6F5D9OSev6Om80hUIWZSkkL3
	naGL6KcHeGZxHOoKHE6/celBzCv6Me1i0jz9ohd4RWLlt4ocQCBbqimCZZyJ04W1xVVxYHVANb9
	Pmlt0DgoDYdZuO+WvnPbi/Rt8CCokni+7fL54k4tfQL9vY+JgjU7/Uw0hJ5rBqawiZHvFyehi/I
	NypfbLeqdUF29UkbleMcQDjAoX9Q/X2xplXoZD6PvF7W891G6gaEpcxhGiR3kCTcuQ4dytqB8QW
	GV6+w7U6mE=
X-Received: by 2002:a05:6512:1088:b0:5a2:c199:45a7 with SMTP id 2adb3069b0e04-5a337552810mr6556311e87.5.1775564145863;
        Tue, 07 Apr 2026 05:15:45 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6cccd2dsm4025361e87.67.2026.04.07.05.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 05:15:45 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] MAINTAINERS, mailmap: Change Ulf Hansson's email
Date: Tue,  7 Apr 2026 14:14:53 +0200
Message-ID: <20260407121458.252451-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Change my email in MAINTAINERS and add a few entries in mailmap to start
using ulfh@kernel.org.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 .mailmap    |  2 ++
 MAINTAINERS | 14 +++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/.mailmap b/.mailmap
index 2d04aeba68b4..22c5ab1c5d55 100644
--- a/.mailmap
+++ b/.mailmap
@@ -849,6 +849,8 @@ Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko.ursulin@onelan.co.uk>
 Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko@ursulin.net>
 Tycho Andersen <tycho@tycho.pizza> <tycho@tycho.ws>
 Tzung-Bi Shih <tzungbi@kernel.org> <tzungbi@google.com>
+Ulf Hansson <ulfh@kernel.org> <ulf.hansson@linaro.org>
+Ulf Hansson <ulfh@kernel.org> <ulf.hansson@stericsson.com>
 Umang Jain <uajain@igalia.com> <umang.jain@ideasonboard.com>
 Uwe Kleine-König <ukleinek@informatik.uni-freiburg.de>
 Uwe Kleine-König <u.kleine-koenig@baylibre.com> <ukleinek@baylibre.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index c3fe46d7c4bc..7167dcea737d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6716,7 +6716,7 @@ F:	include/linux/platform_data/cpuidle-exynos.h
 CPUIDLE DRIVER - ARM PSCI
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 M:	Sudeep Holla <sudeep.holla@kernel.org>
-M:	Ulf Hansson <ulf.hansson@linaro.org>
+M:	Ulf Hansson <ulfh@kernel.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
@@ -6724,7 +6724,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git
 F:	drivers/cpuidle/cpuidle-psci.c
 
 CPUIDLE DRIVER - ARM PSCI PM DOMAIN
-M:	Ulf Hansson <ulf.hansson@linaro.org>
+M:	Ulf Hansson <ulfh@kernel.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
@@ -6733,7 +6733,7 @@ F:	drivers/cpuidle/cpuidle-psci-domain.c
 F:	drivers/cpuidle/cpuidle-psci.h
 
 CPUIDLE DRIVER - DT IDLE PM DOMAIN
-M:	Ulf Hansson <ulf.hansson@linaro.org>
+M:	Ulf Hansson <ulfh@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git
@@ -10729,7 +10729,7 @@ F:	Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.yaml
 F:	drivers/i2c/muxes/i2c-demux-pinctrl.c
 
 GENERIC PM DOMAINS
-M:	Ulf Hansson <ulf.hansson@linaro.org>
+M:	Ulf Hansson <ulfh@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/power/power?domain*
@@ -18089,7 +18089,7 @@ F:	drivers/mmc/host/mmc_spi.c
 F:	include/linux/spi/mmc_spi.h
 
 MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND SDIO SUBSYSTEM
-M:	Ulf Hansson <ulf.hansson@linaro.org>
+M:	Ulf Hansson <ulfh@kernel.org>
 L:	linux-mmc@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
@@ -24696,7 +24696,7 @@ F:	drivers/media/i2c/imx415.c
 SONY MEMORYSTICK SUBSYSTEM
 M:	Maxim Levitsky <maximlevitsky@gmail.com>
 M:	Alex Dubov <oakad@yahoo.com>
-M:	Ulf Hansson <ulf.hansson@linaro.org>
+M:	Ulf Hansson <ulfh@kernel.org>
 L:	linux-mmc@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
@@ -27615,7 +27615,7 @@ F:	Documentation/fb/uvesafb.rst
 F:	drivers/video/fbdev/uvesafb.*
 
 Ux500 CLOCK DRIVERS
-M:	Ulf Hansson <ulf.hansson@linaro.org>
+M:	Ulf Hansson <ulfh@kernel.org>
 L:	linux-clk@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.43.0

