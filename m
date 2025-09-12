Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A327322550
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686993; cv=none; b=hqRXQ0kQugANdp9ogV4Q1VSChbgL/muXb6HUR5Yh7+F8BXJQ/SSBSTPii8bvfZlqt5v0y7IR1ooE+P8oYl18SUiPLGLtWsUhd16ruOhFpE+BO207cuaDWIGSJdmL7g0cwm7urbqZR3BBgs9CpkU2v4zjH75MTC9D4qWIIZB8k1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686993; c=relaxed/simple;
	bh=ePUrNeYcfbWDzNUMEcIA1fjUkpMsdOycpku5PEFxqG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRIvscj5rNVvc27IF5wSdH+tEAWrGkGBekPOgfaHt0m12fRHXkzelwMTVQwnqWI0nZrxUTzErW7vCRq3KAnduaGnCc3Jv/BG4iBAYmf/e4N95SeYIbIWPe7xaxBmmNkjTm1YGqjMTXFhI6fGosAETf7nA5uaDeEvW91rryLXGq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XQT5V/7H; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQT5V/7H"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-33730e1cda7so18611741fa.3
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757686989; x=1758291789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2zyUFMODPm+3x9f3cYjxzBFh42dmd7tVFDAg+JdNrU=;
        b=XQT5V/7HV9vZqdo7rWHRvt6emMp4tziXeHz2CLwPOTZUW+5g06MlU+pYt7RzcYp9XH
         k/tD2hGhOD83urfO2KDbJSwuMxw5kg2ggR8vlWSJIusuOYVMW4DMWFXVWETwefvGQul3
         ltO9d0OMPg8q78gOJQr/Bp81Tc+H0osp7wtmmwumGNJBHdXnuqF8kUKXyamGfjxm2Pe6
         qqnARygAA/3IwoHh6grmw87NNPWdvkNbfYY0gztxOzqNEY9ZxzkYvidcjt0COgdz9yCH
         h1aycf8lkCLMvB65Z+GQfCCFRJ0D7ZJaCpgM8ulyZtMP45NDlrGDRfa5KGcDpHev8tfH
         QlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686989; x=1758291789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2zyUFMODPm+3x9f3cYjxzBFh42dmd7tVFDAg+JdNrU=;
        b=ZCreqCT5wJsSId+s+mDUFpw53lAaQN/HaeYMl4mfbUPcAyLpCDsPRNMCT5IdP5mrXi
         UMP1tAbWl6AvG/0wn4xgE47giA0OdaxPVjyTswrU1L3V6uxcVcnWMjZb7YQZ2psGSXrY
         3alyq4wUF1DI+KLymL6FGYEF5oDFN3RgWTw63ZIc1Q8jJ4FKPtyBuFwXF4v3HGpEyelP
         2YmmEZ6mgmKE/AxIxQYku5ImDbduGWSLDCYCJTYczG3noN4m4bLFjZKaW/G+laOZb3v3
         abXXCPeIDDuDgRn889joB9rkaFx/XWugwSr3ptbH8Cg+qNSBlZ+QZ657E70RkBW+uz93
         9a3A==
X-Gm-Message-State: AOJu0YwxkM90JSR1KgjamMKJms+z3fxF7SSpATNTQSzNl8V56MAQnZ7W
	0AvMLucCpc+XPqyxkjmgRvW3KmXx7ww6eCO6IvJZsO2Jirgc69jDrRUtrY4SwA1ym9DS8CUuyQ/
	QhcZlhX+Umg==
X-Gm-Gg: ASbGncuL4UC6eEd7ejxOqlVWULE37q3ShX5oklNmFRUMI70u8KCbP5P53MUuSmoXq0f
	iNZN2qWSCQ8cmk4NbKPv3UpBUcUel2hVvPfkNsap1QZ9e7rh0h/ifNlSpgwmGhkl/tXZYw+F6/9
	zrAoYBNHF3ARmEaJ+U5Rv8zII8JOSBvdIFnh0mFZ+RaXJk/HPFB/GG5afI9lJSWnEXrkCTr8f8c
	KnJnu/5eAyxGi6pousvSFxr/wl9zWJpSgOacWVFhAFJiy9GvqAenQowokz1BosXFkiMibM/LWJd
	S3U7oU0p+NT1F2fhg+ZO/xJE7np7srVij4cycvGzPulDxA1Y80ZhKYxB9XN6srzkM8wysDjAGzX
	+2ElraDPYDKtDRqa2Ax/ji5rh2OcvFwajI4corC66Ar0FaLtQp27w2wctw+SpL9lNFg==
X-Google-Smtp-Source: AGHT+IHFUaseLNHfzoJaHm+RoOJjn9rz/mii36hbT1zgl7fAKkz+PFk0Q0oVaDOWjWsa7SP4UDw72Q==
X-Received: by 2002:ac2:4e98:0:b0:55f:4c1d:47f3 with SMTP id 2adb3069b0e04-5704f1cecd3mr887911e87.28.1757686988971;
        Fri, 12 Sep 2025 07:23:08 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a5df5f74sm164981e87.54.2025.09.12.07.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:23:08 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	adrian.hunter@intel.com,
	victor.shih@genesyslogic.com.tw,
	ben.chuang@genesyslogic.com.tw,
	geert+renesas@glider.be,
	angelogioacchino.delregno@collabora.com,
	dlan@gentoo.org,
	arnd@arndb.de,
	zhoubinbin@loongson.cn,
	Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH v3 2/4] mmc: add COMPILE_TEST to multiple drivers
Date: Fri, 12 Sep 2025 17:22:51 +0300
Message-ID: <20250912142253.2843018-3-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912142253.2843018-1-mikko.rapeli@linaro.org>
References: <20250912142253.2843018-1-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These compile on x86_64 with =y and =m.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 drivers/mmc/host/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7232de1c06887..2db46291ae442 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -56,7 +56,7 @@ config MMC_STM32_SDMMC
 
 config MMC_PXA
 	tristate "Intel PXA25x/26x/27x Multimedia Card Interface support"
-	depends on ARCH_PXA
+	depends on ARCH_PXA || COMPILE_TEST
 	help
 	  This selects the Intel(R) PXA(R) Multimedia card Interface.
 	  If you have a PXA(R) platform with a Multimedia Card slot,
@@ -608,7 +608,7 @@ config MMC_SDHCI_MSM
 
 config MMC_MXC
 	tristate "Freescale i.MX21/27/31 or MPC512x Multimedia Card support"
-	depends on ARCH_MXC || PPC_MPC512x
+	depends on ARCH_MXC || PPC_MPC512x || COMPILE_TEST
 	help
 	  This selects the Freescale i.MX21, i.MX27, i.MX31 or MPC512x
 	  Multimedia Card Interface. If you have an i.MX or MPC512x platform
@@ -866,7 +866,7 @@ config MMC_DW_PCI
 
 config MMC_DW_ROCKCHIP
 	tristate "Rockchip specific extensions for Synopsys DW Memory Card Interface"
-	depends on MMC_DW && ARCH_ROCKCHIP
+	depends on MMC_DW && ( ARCH_ROCKCHIP  || COMPILE_TEST )
 	select MMC_DW_PLTFM
 	help
 	  This selects support for Rockchip SoC specific extensions to the
@@ -948,7 +948,7 @@ config MMC_USHC
 
 config MMC_WMT
 	tristate "Wondermedia SD/MMC Host Controller support"
-	depends on ARCH_VT8500
+	depends on ARCH_VT8500 || COMPILE_TEST
 	default y
 	help
 	  This selects support for the SD/MMC Host Controller on
-- 
2.34.1

