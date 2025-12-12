Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A5285CB3
	for <linux-mmc@vger.kernel.org>; Fri, 12 Dec 2025 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765551848; cv=none; b=obu1ipvueU+ux0KEUrS/aZEPf257HC1rNwj1xZonooSI4qeNzAiBBYg2PQUzDntvjmMa4ByeJPlPbZ8/zQti6+A8kiBGjuEN0ZGf7lanfk4Gt274zAc50XFQ65PbGeOVaz44AjHwmSug3G54j041Qj9/NI2mk5dls3IGlA4KCus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765551848; c=relaxed/simple;
	bh=fZAcqRD50Wi9zC/Droas8GpHjMnmrcAYigk011caHOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Bf5/oZX8TX/RLi3COk3ZAEVQxPV43WlJi2mZbSUYHS14kuFE7K2LEfflOsZKDgI3a2+rfppOnk7KDSk8BDMfelH56e4eTpM4FdQuQji4h7puyjURFTvypcz2kaWsysiRb7XDwcjj0TGqUqCiDGxAOoANfZ/MQa1WHsnYBSUJYQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JyT7KsnV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aEDctKxA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyT7KsnV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEDctKxA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765551845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rgxpVSt066TUyJCGi3OmDYi9BAgnnOl/eGNX0JHnjDw=;
	b=JyT7KsnVgIWWE8aP2OWeZ1h/C4awlSp9CBnBeP0lm2OuMKSf1XXG2MUPfUtEVukwCMylmO
	443QFCL/Ry2ivhot3UONrT+II6+5u2X8C+PKVY8LMaYwzp2P/2Inqce8SCyVfgMvBj8UCf
	bDek1/vgkKEpTQKHw8wGQd3t4VKXbQk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231--7fS598SO8arS2GQ4BWTKA-1; Fri, 12 Dec 2025 10:04:04 -0500
X-MC-Unique: -7fS598SO8arS2GQ4BWTKA-1
X-Mimecast-MFC-AGG-ID: -7fS598SO8arS2GQ4BWTKA_1765551843
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7be94e1a073so2087238b3a.2
        for <linux-mmc@vger.kernel.org>; Fri, 12 Dec 2025 07:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765551843; x=1766156643; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rgxpVSt066TUyJCGi3OmDYi9BAgnnOl/eGNX0JHnjDw=;
        b=aEDctKxANu6bkGezEfC/SOi/fr52+ZFPXVuh4qj1TTjxC43DzoodpjEj7HRi8Ej2vM
         DGIezTQxfqtuwzvkNG9Mv61uMRH7Ys6w6ADJ0KCRJquodVMSwlKFZmrenFWih1XddY0u
         TAgHxTq6CiZh1Vm1D3u0H2/L71eri/j3WsNDQnGSMrHkGX93iIFaBiC6odq3jzMotsPb
         qNdcmfnyJ1oYozWqCSmAz5IceN37kW/lsfZtn+Y1ykEBvEsXKSdGOEYtkna3WE4dkFey
         02MhgvPIQ0PGKCSlTJOWVTWA0XjOmL0BU9LWtrXLMBTN89pRnGEige5XcqAvMK1Zz4Kp
         NL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765551843; x=1766156643;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgxpVSt066TUyJCGi3OmDYi9BAgnnOl/eGNX0JHnjDw=;
        b=XRX+tKfVr/P5b9Mk0cVVBZIdephz31QInc7Z3SDeBTHFvLMLd/N7Ya/7flPQ4w956j
         xeBCseUpC0inj1dc0RkJehl9kI2wWLcd9BryOl6lvS/mP1KcxGFiiS5pKs1U9b8Czuco
         4ozt8ZkEuhAqrYmqwmwVjORZOxg/gpADsY+fwdLAqJL+O/EzX978ADM7oWjqnQ7UkXGA
         auyOTce/Sdjehn18BQn3+DzNAGuyUlXt0B7hzpv9CDzitrD5/JzUEN+URh8HighdzSoa
         aM8RVOnIo5dDwBzM8fdimZjQFfr7icJs46On72rPOTqMEhhvB3PLFI8Jd9IjKsktTfoV
         +AlA==
X-Gm-Message-State: AOJu0YyX9TT4vIdgIrDAHKaKxY+6TPzTBejErATK3Ci18W0JbJ8+4WXS
	tA8+W0++U4Dh/Ycx1VRzaW/W/Pogg9DpYATy7Dnr7g+fz2VDOr4wob812enNplz6nnewxdxdiAp
	cbnsX9k1WPMr0TNR0Tc09NAxx/0nPSCdqiEf3yx5gXjgpnWDrftSqemFdZG3hfw==
X-Gm-Gg: AY/fxX4KBcJwXFV8zpYtJwsug4Dz+5FOyCEBso4XgNmCQwnYKGu/pDd2Tbs8E4mn9LN
	Mho9kAt7i2PIwfPoEWxBmjB41T61uGO34Bhy6pgUGcxnXQmS1WQKrL6+HTthew7lZP/EBot4eh+
	Q0/U4WZgpls68YcTegBG6JsJ+CvORFUY9cO6RPXQLRR5ER80swajpscDRac3RoR0ebudHnf7JsW
	aQlw3B8TqEInACbIIs7EJv2hQ+uNAnWi3WSrhhEXj/MOGlitVbF8c0hrqIPJslpDeWoZlDALvHU
	O9w4xpeqDD9cFUdeJJV30s71x5ZYYY/4jVqBUhAjpAHgllnrynVYwE57e5Xuc0Ec+AcMO/dDsbZ
	fMSzA/alHaDX2kDcuDtSZvRsMZ3G5+C5p0M8FqBEi3Q==
X-Received: by 2002:a05:7022:ed02:b0:11a:f5e0:dc8 with SMTP id a92af1059eb24-11f34c4ce6dmr1085523c88.28.1765551842659;
        Fri, 12 Dec 2025 07:04:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEb1zyrPRFVrIwsGWsg/+MOeas9yeMDNDfquzoK4AyHa02WZnuzqW3kokEIkkaJiXX2KbIydA==
X-Received: by 2002:a05:7022:ed02:b0:11a:f5e0:dc8 with SMTP id a92af1059eb24-11f34c4ce6dmr1085495c88.28.1765551841915;
        Fri, 12 Dec 2025 07:04:01 -0800 (PST)
Received: from jkangas-thinkpadp1gen3.rmtuswa.csb ([2601:1c2:4403:8750:d964:d6a9:f204:ed2b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f392500cdsm1113616c88.7.2025.12.12.07.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:04:01 -0800 (PST)
From: Jared Kangas <jkangas@redhat.com>
Date: Fri, 12 Dec 2025 07:03:17 -0800
Subject: [PATCH] mmc: sdhci-esdhc-imx: add alternate ARCH_S32 dependency to
 Kconfig
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-s32g-sdhci-kconfig-v1-1-8e278c8d7f78@redhat.com>
X-B4-Tracking: v=1; b=H4sIALQuPGkC/x3MTQqAIBBA4avErBtIy/6uEi3KRhsCCwcikO6et
 PwW7yUQikwCY5Eg0s3CZ8hQZQF2X4In5C0bdKWN0kqh1NqjbLtlPOwZHHs0vVnboRpctzaQwyu
 S4+efTvP7fgsuFhhkAAAA
X-Change-ID: 20251211-s32g-sdhci-kconfig-585b6909f7b4
To: Ulf Hansson <ulf.hansson@linaro.org>, Haibo Chen <haibo.chen@nxp.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chester Lin <chester62515@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, s32@nxp.com, linux-arm-kernel@lists.infradead.org, 
 Jared Kangas <jkangas@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765551836; l=1453;
 i=jkangas@redhat.com; s=20251111; h=from:subject:message-id;
 bh=fZAcqRD50Wi9zC/Droas8GpHjMnmrcAYigk011caHOo=;
 b=gwmpJ5jaWiW+bNeO8y1ltBZKRvbuoEtgP5r39xeccaPH9fbkH2Wq76atnFsPgELe37jtmkqLJ
 7aWyvSXJ9R0C3SBL3godhPcGZcJ3watT7QPUteYodMwfmQvQaOLRTIQ
X-Developer-Key: i=jkangas@redhat.com; a=ed25519;
 pk=eFM2Mqcfarb4qox390655bUATO0fG9gwgaw7kGmOEZQ=

MMC_SDHCI_ESDHC_IMX requires ARCH_MXC despite also being used on
ARCH_S32, which results in unmet dependencies when compiling strictly
for ARCH_S32. Resolve this by adding ARCH_S32 as an alternative to
ARCH_MXC in the driver's dependencies.

Fixes: 5c4f00627c9a ("mmc: sdhci-esdhc-imx: add NXP S32G2 support")
Signed-off-by: Jared Kangas <jkangas@redhat.com>
---
 drivers/mmc/host/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 10d0ef58ef493102d3586d7a31d755543297999a..c94ae4794545de1c818ad50be7f91331862b6acf 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -315,14 +315,14 @@ config MMC_SDHCI_ESDHC_MCF
 
 config MMC_SDHCI_ESDHC_IMX
 	tristate "SDHCI support for the Freescale eSDHC/uSDHC i.MX controller"
-	depends on ARCH_MXC || COMPILE_TEST
+	depends on ARCH_MXC || ARCH_S32 || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	depends on OF
 	select MMC_SDHCI_IO_ACCESSORS
 	select MMC_CQHCI
 	help
 	  This selects the Freescale eSDHC/uSDHC controller support
-	  found on i.MX25, i.MX35 i.MX5x and i.MX6x.
+	  found on i.MX25, i.MX35, i.MX5x, i.MX6x, and S32G.
 
 	  If you have a controller with this interface, say Y or M here.
 

---
base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
change-id: 20251211-s32g-sdhci-kconfig-585b6909f7b4

Best regards,
-- 
Jared Kangas <jkangas@redhat.com>

