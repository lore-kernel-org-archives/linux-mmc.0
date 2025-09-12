Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29D726E715
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666495; cv=none; b=TA8yuy5rUmw1TRirxhA6Zf8Fs4OomhF6UbcnsJcweicQDjdXx9sHxTTUWNOtw1Fkt2n65CcVYyw10Tp5G2aU7Zh241VuXx/8gcAGnC43SwpThJG/xe/Amh/PVNne6ZgLEi1lpwN3F3EDxvakww6PSxQN65Z6f7iaT/iLv2h+tZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666495; c=relaxed/simple;
	bh=bndgV+6/m12h1ryoikeMs/qo9IYJoKbrHEVer3koavU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Go6xwcarEO3nvxOyNXHg4tOTfGqLXCdGr9H7XiHCgKgl13QKuCd7MrbPM421ZY5QrBbm3oXrPfdIQ0xPCUG/6/1i9X61Rl2etYfg3s8pwl9ju30qYMc9giaBx/pJzcpAykCDismD64BgaX/sNHU/hY5+GQLd1I00BTjy3aw8LPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nCgNmZH3; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nCgNmZH3"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f7c0fb972so1705856e87.3
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757666491; x=1758271291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xBErhNse+j6I91tCklZOzCROEjv+OSz++yOZ5Je/Fkg=;
        b=nCgNmZH3ijeNM5ckURts/zxHmQd994PszaDQz+AocS9blDTYc9U0r+4JJtLoTj9cUN
         eiMvcOa5V6KZexmrF3oaLFRQcYxYl77fa10n4CzDwSQiSkSkdx2+5jhnDtTM4wybrcfw
         hd/eMUSmhVBywG221cCm6G9glb8X+8V0ZQay7jYgNRwrP+/XQ52hMUHvwiS0hAp/4pAn
         qw86C33UGNbxFKz3FrXSTJkUDiOyDwn3zdmMhbAJAzzaEdPi0ZTh6DZQiSQK8pKv6sKv
         x2QyM29YxXZHcfjnK26AmZiRntxjdq+yYiyawCtlstj3iLPTovFzFc5ll2wRTxkbn3g4
         5Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757666491; x=1758271291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBErhNse+j6I91tCklZOzCROEjv+OSz++yOZ5Je/Fkg=;
        b=eUuQUzH/7jH/4BVE3zx2FUjE4NE4F4RKJAg5xddc2QFSXJIWCz6Sk4YMT4Wua78msW
         qzxHvR4xvWQarq+QNs/mdcaXbw5VKHKRk3N8EzTNrO5Jc1TZ+tGDavHLx6JZ9n5gaB3s
         tcv5VgmTxQF2SoSP4PH9exMvjT6cNtx/ViYBkV/iTEjD5/s5uhk2RNacfbOESMcW9bqa
         Ibzh5W1eHHgzmBqLcNJGyfmOXMf8FRCvBGQcSxyVkWoImP4NOulxpxGt2ZRVIgJDBwkf
         k2ZmK4NeqvZvQAzokNbrkmW5+ha3VisG//J4c5Xjq5l9qALg9yr6Ijgo8s5mJnqtPAxp
         sEjQ==
X-Gm-Message-State: AOJu0YwrBaY6aXkFT0sDxCCRJh+lsT1MaZeyRarq+6kwv+DuAZI0OR01
	KnnvyoPYGe/Z5Q8wIQb8zsAx4fttrwHu3tOqPq6sXVCCPGWtjQ/Jv/SV6+WcrVLo9MSX2LAKtRe
	YnGKXB43SVQ==
X-Gm-Gg: ASbGnctDsF+aOELrXvOMGDr6OwWNMY/7MwFenCGh8ahcRL/tWsoEBTyqO8KIjl0NNk2
	5UCrkzeJbd36XIH1xOAO5DMQQtDwH0Hqkkrn947PY113Cb10NaNfQ+cWh2V9LlZlQvqBamcZXdb
	ndltZRQ2vDzG3DYLtpU+pvrE3oKKSIskS5XseOEt+7msczEFGprP3A1Q2k+j3H3raMSJ2a+FmbT
	e7hFxbayhuo1ereXbwRWiK/hLCAgDgG7SrjUvuyFU4XPkSOC+gqurzQxasHbRw/57LgpqErabxt
	HuBVZfccEuIZbpMioXjG/+ITFwUadsOI/6MLIEnvHxyF/IfoN9o1yX96RPFfAruQbRBtdpyNaRt
	E+7RjdXWBmUstAX240Po0yBi01esuzWAczcIyNfr3swLfS/P2cJsES2w=
X-Google-Smtp-Source: AGHT+IFlECbCfqHaKCOiMiZUo2tEkpklGg5vNw0995hSjAvtIzzPQhbV0GVdbxLFhZzl4M5n+xltng==
X-Received: by 2002:a05:6512:6715:b0:55f:6831:6ee0 with SMTP id 2adb3069b0e04-5704e34e78fmr629272e87.43.1757666491000;
        Fri, 12 Sep 2025 01:41:31 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63f6csm989050e87.86.2025.09.12.01.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:41:30 -0700 (PDT)
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
Subject: [PATCH v2 1/2] arm64: select ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
Date: Fri, 12 Sep 2025 11:41:11 +0300
Message-ID: <20250912084112.2795848-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On rk3399 based rockpi4b, mounting rootfs from mmc fails unless
ROCKCHIP_PM_DOMAINS is enabled. Accoriding to
Heiko Stübner <heiko@sntech.de> all SoCs since 2012 have power
domains so the support should be enabled by default.

Failing boot without CONFIG_ROCKCHIP_PM_DOMAINS=y:

https://ledge.validation.linaro.org/scheduler/job/119268

/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
dw-apb-uart ff1a0000.serial: forbid DMA for kernel console
root '/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e' doesn't exist or does not contain a /dev.
rk_gmac-dwmac fe300000.ethernet: deferred probe timeout, ignoring dependency
rk_gmac-dwmac fe300000.ethernet: probe with driver rk_gmac-dwmac failed with error -110
rk_iommu ff650800.iommu: deferred probe timeout, ignoring dependency
rk_iommu ff650800.iommu: probe with driver rk_iommu failed with error -110
dwmmc_rockchip fe320000.mmc: deferred probe timeout, ignoring dependency
rockchip-typec-phy ff7c0000.phy: deferred probe timeout, ignoring dependency
dwmmc_rockchip fe320000.mmc: probe with driver dwmmc_rockchip failed with error -110
rockchip-typec-phy ff7c0000.phy: probe with driver rockchip-typec-phy failed with error -110
rockchip-typec-phy ff800000.phy: deferred probe timeout, ignoring dependency
rockchip-typec-phy ff800000.phy: probe with driver rockchip-typec-phy failed with error -110
rk_iommu ff660480.iommu: deferred probe timeout, ignoring dependency
rk_iommu ff660480.iommu: probe with driver rk_iommu failed with error -110
rk_iommu ff8f3f00.iommu: deferred probe timeout, ignoring dependency
rk_iommu ff8f3f00.iommu: probe with driver rk_iommu failed with error -110
rk_iommu ff903f00.iommu: deferred probe timeout, ignoring dependency
rk_iommu ff903f00.iommu: probe with driver rk_iommu failed with error -110
rk_iommu ff914000.iommu: deferred probe timeout, ignoring dependency
rk_iommu ff914000.iommu: probe with driver rk_iommu failed with error -110
rk_iommu ff924000.iommu: deferred probe timeout, ignoring dependency
rk_iommu ff924000.iommu: probe with driver rk_iommu failed with error -110
platform fe800000.usb: deferred probe pending: platform: wait for supplier /phy@ff7c0000/usb3-port
sdhci-arasan fe330000.mmc: deferred probe timeout, ignoring dependency
platform fe900000.usb: deferred probe pending: platform: wait for supplier /phy@ff800000/usb3-port
sdhci-arasan fe330000.mmc: probe with driver sdhci-arasan failed with error -110
platform ff1d0000.spi: deferred probe pending: (reason unknown)
platform hdmi-sound: deferred probe pending: asoc-simple-card: parse error

Working boot with CONFIG_ROCKCHIP_PM_DOMAINS=y:

https://ledge.validation.linaro.org/scheduler/job/119272

dwmmc_rockchip fe320000.mmc: IDMAC supports 32-bit address mode.
dwmmc_rockchip fe320000.mmc: Using internal DMA controller.
dwmmc_rockchip fe320000.mmc: Version ID is 270a
dwmmc_rockchip fe320000.mmc: DW MMC controller at irq 45,32 bit host data width,256 deep fifo
dwmmc_rockchip fe320000.mmc: Got CD GPIO
ff1a0000.serial: ttyS2 at MMIO 0xff1a0000 (irq = 44, base_baud = 1500000) is a 16550A
printk: legacy console [ttyS2] enabled
mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
dw_wdt ff848000.watchdog: No valid TOPs array specified
mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 50000000Hz, actual 50000000HZ div = 0)
mmc0: CQHCI version 5.10
rk_gmac-dwmac fe300000.ethernet: IRQ eth_wake_irq not found
mmc1: new high speed SDHC card at address aaaa
fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
fan53555-regulator 0-0041: FAN53555 Option[8] Rev[1] Detected!
rk_gmac-dwmac fe300000.ethernet: IRQ eth_lpi not found
mmcblk1: mmc1:aaaa SC16G 14.8 GiB
rk_gmac-dwmac fe300000.ethernet: IRQ sfty not found
GPT:Primary header thinks Alt. header is not at the end of the disk.
rk_gmac-dwmac fe300000.ethernet: Deprecated MDIO bus assumption used
GPT:1978417 != 31116287
rk_gmac-dwmac fe300000.ethernet: PTP uses main clock
GPT:Alternate GPT header not at the end of the disk.
rk_gmac-dwmac fe300000.ethernet: clock input or output? (input).
GPT:1978417 != 31116287
rk_gmac-dwmac fe300000.ethernet: TX delay(0x28).
GPT: Use GNU Parted to correct GPT errors.
rk_gmac-dwmac fe300000.ethernet: RX delay(0x11).
 mmcblk1: p1 p2 p3 p4 p5 p6 p7 p8

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Suggested-by: Heiko Stübner <heiko@sntech.de>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

v2: changed from "depend on" in MMC driver to "select" as default
    on ARCH_ROCKCHIP as suggested by Ulf and Heiko

v1: https://lore.kernel.org/linux-mmc/20250911144313.2774171-1-mikko.rapeli@linaro.org/

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index a88f5ad9328c2..04b3601486290 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -306,6 +306,7 @@ config ARCH_ROCKCHIP
 	select ARCH_HAS_RESET_CONTROLLER
 	select PINCTRL
 	select PM
+	select ROCKCHIP_PM_DOMAINS
 	select ROCKCHIP_TIMER
 	help
 	  This enables support for the ARMv8 based Rockchip chipsets,
-- 
2.34.1

