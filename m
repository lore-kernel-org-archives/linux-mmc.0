Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED8E321F46
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686991; cv=none; b=jQQGh1xCz1jjHYi0ihybTd3P3YQfjsyq9zafNrUln8t6GhPbDbE1eqoEo+o0yfNTirCgLpKA5XqfQyPcJN/6m7CEJGYMv40Rpv7S4dMkoSazMZZSwLKxsCZ6OZogwg1PGXqw9H5V/icSCzLNauVtsdzAWPOBFsubn5cASRZr7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686991; c=relaxed/simple;
	bh=/SxMVDTkZvMbBsZ1m84K+ZCGY5O9Fq7p3OG5ytCeDD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1JvdU3nRgMtbuOC/YmRif+ncTKg+eA72t3dJL0Dw/ksVuD2bBCJor0qeeohZiv4+pU5kegnnBToElhrDWLpRuxBS5qSHVDe2yBgaZnkMUGBZFtnMvUs/xhBpst/fr0A2Q6Szyg11Scsv/xGYcucn8sf+sIQC7+nX4W2ofpEbX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kMMBGAiN; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kMMBGAiN"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f720ffe34so2440652e87.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757686988; x=1758291788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKVoiH7XLcNaedQxfza9YTAwsoIt9Wu8Ls74q3lR27g=;
        b=kMMBGAiNrR92Q3EFGYmLTQZbs7aIBoTk5U4pKpsf0n7cgJYI0k6CFXUru6mEsM4iSo
         sxm3KzS1HVow31GFrvVed14VJLf3VjzApEFk1cyKgurlpYp9f26xApIG1VdlIJKQgGBF
         0NnlgI4wrwVS/SpfRF0Ajw7cu8lb+gFK7Liu26AqtcDHB1886c0IxHUZcXHRkzQjnCyl
         H3EGAqjNysFT7i2eOaHYdp4eGTtwpZ4nDj8CM9liUIpVxM7KVKTaLYDAZAXHNSJQk+Gd
         NK7poB0yVU7tKzoIJX2vyXkVXZLuwgqnWHKpgzCq1iIZYuJ85XB1R4Oa57PDYPILFBC7
         Jvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686988; x=1758291788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKVoiH7XLcNaedQxfza9YTAwsoIt9Wu8Ls74q3lR27g=;
        b=t234oefgl9v74MzLWnH0alhy13TOxwuCMyeVz26/dKJk7MlIiZinCkhcwAv7QHaYqn
         tLTqzrAxuJ2MZKtCllbyPpcmHAHIHxauAKeR2+GbBfvfclt0QeTBb1cGu8+u4XB87sUN
         qfVzTHkh/n6nh4gFKOS4PgObi98j1rsOmyITX5MdD8O/RXOg9lr3fBVfupGr66EACmJn
         W417XdxTuLaaa+tJTg4dC21aA5xivLgggXsew+op/NVryf3bO+/6MAGGT4e8tJM3rYMf
         cjp/BHtNqSYEOXVa8UYj6oUpMPXdv4HIvBSeJOiTU7f8O7cCJlg+y0DUYlKzyLUmQAg6
         ksXw==
X-Gm-Message-State: AOJu0YwSIIHPnSpuOwUzRd+e4gBG/xdtuTy/dg9/tARr2z2qyq/l+dHm
	w/dM3V/0MuvNqKy7GfWEWjHWARudZi4tpLCl4jJlJGN2khWoRGiZegeRMMvWhAaBYTBslVjdVE6
	fyY3QhKnNog==
X-Gm-Gg: ASbGnctruWjAteTRbJEG+1uQq4n0hDfTZiSygVmseA6BbHQbOwZzhta+s0eCwT/sQ+1
	uiNl3AVhrW3qzpJtExyrgnl/E4/xSUTZIjcjfK0hJL9VqgJeaeQDzcsmtqxhe3o/JxNAQeioP17
	B68d8mFweF+B6sCXAA61C3SVKOtpZPdGTa3MgbaldY0HjHzELhykHsnWnjWUgIN4N1++4v5BgUp
	zDcKfJvMUtKKM90hHZE+LZl/wiER5z+tEIkd13W7Wp8Co/hC86BEOaP2XXRQC/PDmIuvvO6sFdZ
	A4Q9gxFPEv+yg4t5vN6NNTPdiVjyWiBmXq5w2oPijDOGq9SGIVJt5GGURZJp9eG2HBvcR2XKTL+
	Zf3J/MOO99p7bxUYp5kEbDdoJuDlKzF4K2jedbxCpaRreTQY5FcCRegjte74nVV1HdQ==
X-Google-Smtp-Source: AGHT+IGA5WNSRbR+gOyEJy/6pRky35EYUnzZIoTI1ClROTD2m3J00lQr61eUAQlXoeKlOouLRMbJQw==
X-Received: by 2002:a05:6512:2529:b0:560:83e2:1dce with SMTP id 2adb3069b0e04-5705be233bamr880120e87.6.1757686987511;
        Fri, 12 Sep 2025 07:23:07 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a5df5f74sm164981e87.54.2025.09.12.07.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:23:07 -0700 (PDT)
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
Subject: [PATCH v3 1/4] pmdomain: rockchip: enable ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
Date: Fri, 12 Sep 2025 17:22:50 +0300
Message-ID: <20250912142253.2843018-2-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912142253.2843018-1-mikko.rapeli@linaro.org>
References: <20250912142253.2843018-1-mikko.rapeli@linaro.org>
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
domains so the support should be enabled by default
on both arm and arm64.

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
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 drivers/pmdomain/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/rockchip/Kconfig b/drivers/pmdomain/rockchip/Kconfig
index 218d43186e5b9..17f2e6fe86b6f 100644
--- a/drivers/pmdomain/rockchip/Kconfig
+++ b/drivers/pmdomain/rockchip/Kconfig
@@ -3,6 +3,7 @@ if ARCH_ROCKCHIP || COMPILE_TEST
 
 config ROCKCHIP_PM_DOMAINS
 	bool "Rockchip generic power domain"
+	default ARCH_ROCKCHIP
 	depends on PM
 	depends on HAVE_ARM_SMCCC_DISCOVERY
 	depends on REGULATOR
-- 
2.34.1

