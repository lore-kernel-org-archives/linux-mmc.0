Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687691DEFE9;
	Fri, 12 Sep 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689220; cv=none; b=lauakUCWj9Q73j6WNBHUMQejaV/Ujz74/RbSmCcun28xON6aPlSc476Xe2fsMXGijmt7EfF6/pPFHBzQLKr7qDE3w5TC+8HruMjBgb6k7EVJi1b1+tm36AtHot1RwaFxOvql7ZPpsmVVkSyUudJWNjn10qNi7zAxftBnAz60HiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689220; c=relaxed/simple;
	bh=8WXsj4Rt4wdU5XyvqVm2vpBIseC8WqDgLjS/hEAuaRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+l2EFaNyQdETR2X9QawBsJrdLdWS1wMiHJ9Udm6DqA8NqShRhJEtTFWmZqtf3tfYqjsvlomNBqd3QwackVwBwAY5/7Oa8QAYgeygHNun3ZDGUv0YA+YNO52N16nvxPcDIS516iCS8J7UNzjdvouwtfk1fChI0J1TMTiEY6+0g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=IgC1FXen; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="IgC1FXen"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=PdI0ZWf/Ipj149RcGeqPm4YhKLc1nj1TVl70cM05bzI=; b=IgC1FXenlRjXGCF0I129O/VN4W
	Fnj8u2hYi65nae9Uwz6TAtXwS6mQG7KN0qh275rwLOczD5zxmiz8hgjeRR1x8fZ0MIAe1Dgr0vDrG
	NP8ncgyNIHvRvYMJ+oGATQgM8a8pdOYlJIAReR9z7OdwZ/3nz+xTtmKuIziBV/r6LBsexPXyeBgnr
	Jj3wcdmjDtdasHEHigggrKA3H0xEixy6ng4ggA4/Qci7GDkR+k9QMAmsbV7tgOsafHYSmaf6KE0p+
	4tLxK/VsXuIMr2g0ZXSVP68YnnJkIiePDkr2NQpRmK9hlHRoCmicrLU3FJVyfU62YMrWHcRhZCUSU
	7hjWszIg==;
Received: from i53875a48.versanet.de ([83.135.90.72] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ux5Fz-00031I-Mv; Fri, 12 Sep 2025 17:00:11 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: linux-mmc@vger.kernel.org, Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
 adrian.hunter@intel.com, victor.shih@genesyslogic.com.tw,
 ben.chuang@genesyslogic.com.tw, geert+renesas@glider.be,
 angelogioacchino.delregno@collabora.com, dlan@gentoo.org, arnd@arndb.de,
 zhoubinbin@loongson.cn, Mikko Rapeli <mikko.rapeli@linaro.org>
Subject:
 Re: [PATCH v3 1/4] pmdomain: rockchip: enable ROCKCHIP_PM_DOMAINS with
 ARCH_ROCKCHIP
Date: Fri, 12 Sep 2025 17:00:10 +0200
Message-ID: <9157586.VV5PYv0bhD@diego>
In-Reply-To: <20250912142253.2843018-2-mikko.rapeli@linaro.org>
References:
 <20250912142253.2843018-1-mikko.rapeli@linaro.org>
 <20250912142253.2843018-2-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Freitag, 12. September 2025, 16:22:50 Mitteleurop=C3=A4ische Sommerzeit =
schrieb Mikko Rapeli:
> On rk3399 based rockpi4b, mounting rootfs from mmc fails unless
> ROCKCHIP_PM_DOMAINS is enabled. Accoriding to
> Heiko St=C3=BCbner <heiko@sntech.de> all SoCs since 2012 have power
> domains so the support should be enabled by default
> on both arm and arm64.
>=20
> Failing boot without CONFIG_ROCKCHIP_PM_DOMAINS=3Dy:
>=20
> https://ledge.validation.linaro.org/scheduler/job/119268
>=20
> /dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup =
blockdev
> /dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup =
blockdev
> /dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup =
blockdev
> /dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup =
blockdev
> /dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup =
blockdev
> /dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup =
blockdev
> dw-apb-uart ff1a0000.serial: forbid DMA for kernel console
> root '/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e' doesn't=
 exist or does not contain a /dev.
> rk_gmac-dwmac fe300000.ethernet: deferred probe timeout, ignoring depende=
ncy
> rk_gmac-dwmac fe300000.ethernet: probe with driver rk_gmac-dwmac failed w=
ith error -110
> rk_iommu ff650800.iommu: deferred probe timeout, ignoring dependency
> rk_iommu ff650800.iommu: probe with driver rk_iommu failed with error -110
> dwmmc_rockchip fe320000.mmc: deferred probe timeout, ignoring dependency
> rockchip-typec-phy ff7c0000.phy: deferred probe timeout, ignoring depende=
ncy
> dwmmc_rockchip fe320000.mmc: probe with driver dwmmc_rockchip failed with=
 error -110
> rockchip-typec-phy ff7c0000.phy: probe with driver rockchip-typec-phy fai=
led with error -110
> rockchip-typec-phy ff800000.phy: deferred probe timeout, ignoring depende=
ncy
> rockchip-typec-phy ff800000.phy: probe with driver rockchip-typec-phy fai=
led with error -110
> rk_iommu ff660480.iommu: deferred probe timeout, ignoring dependency
> rk_iommu ff660480.iommu: probe with driver rk_iommu failed with error -110
> rk_iommu ff8f3f00.iommu: deferred probe timeout, ignoring dependency
> rk_iommu ff8f3f00.iommu: probe with driver rk_iommu failed with error -110
> rk_iommu ff903f00.iommu: deferred probe timeout, ignoring dependency
> rk_iommu ff903f00.iommu: probe with driver rk_iommu failed with error -110
> rk_iommu ff914000.iommu: deferred probe timeout, ignoring dependency
> rk_iommu ff914000.iommu: probe with driver rk_iommu failed with error -110
> rk_iommu ff924000.iommu: deferred probe timeout, ignoring dependency
> rk_iommu ff924000.iommu: probe with driver rk_iommu failed with error -110
> platform fe800000.usb: deferred probe pending: platform: wait for supplie=
r /phy@ff7c0000/usb3-port
> sdhci-arasan fe330000.mmc: deferred probe timeout, ignoring dependency
> platform fe900000.usb: deferred probe pending: platform: wait for supplie=
r /phy@ff800000/usb3-port
> sdhci-arasan fe330000.mmc: probe with driver sdhci-arasan failed with err=
or -110
> platform ff1d0000.spi: deferred probe pending: (reason unknown)
> platform hdmi-sound: deferred probe pending: asoc-simple-card: parse error
>=20
> Working boot with CONFIG_ROCKCHIP_PM_DOMAINS=3Dy:
>=20
> https://ledge.validation.linaro.org/scheduler/job/119272
>=20
> dwmmc_rockchip fe320000.mmc: IDMAC supports 32-bit address mode.
> dwmmc_rockchip fe320000.mmc: Using internal DMA controller.
> dwmmc_rockchip fe320000.mmc: Version ID is 270a
> dwmmc_rockchip fe320000.mmc: DW MMC controller at irq 45,32 bit host data=
 width,256 deep fifo
> dwmmc_rockchip fe320000.mmc: Got CD GPIO
> ff1a0000.serial: ttyS2 at MMIO 0xff1a0000 (irq =3D 44, base_baud =3D 1500=
000) is a 16550A
> printk: legacy console [ttyS2] enabled
> mmc_host mmc1: Bus speed (slot 0) =3D 400000Hz (slot req 400000Hz, actual=
 400000HZ div =3D 0)
> dw_wdt ff848000.watchdog: No valid TOPs array specified
> mmc_host mmc1: Bus speed (slot 0) =3D 50000000Hz (slot req 50000000Hz, ac=
tual 50000000HZ div =3D 0)
> mmc0: CQHCI version 5.10
> rk_gmac-dwmac fe300000.ethernet: IRQ eth_wake_irq not found
> mmc1: new high speed SDHC card at address aaaa
> fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
> fan53555-regulator 0-0041: FAN53555 Option[8] Rev[1] Detected!
> rk_gmac-dwmac fe300000.ethernet: IRQ eth_lpi not found
> mmcblk1: mmc1:aaaa SC16G 14.8 GiB
> rk_gmac-dwmac fe300000.ethernet: IRQ sfty not found
> GPT:Primary header thinks Alt. header is not at the end of the disk.
> rk_gmac-dwmac fe300000.ethernet: Deprecated MDIO bus assumption used
> GPT:1978417 !=3D 31116287
> rk_gmac-dwmac fe300000.ethernet: PTP uses main clock
> GPT:Alternate GPT header not at the end of the disk.
> rk_gmac-dwmac fe300000.ethernet: clock input or output? (input).
> GPT:1978417 !=3D 31116287
> rk_gmac-dwmac fe300000.ethernet: TX delay(0x28).
> GPT: Use GNU Parted to correct GPT errors.
> rk_gmac-dwmac fe300000.ethernet: RX delay(0x11).
>  mmcblk1: p1 p2 p3 p4 p5 p6 p7 p8
>=20
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Suggested-by: Heiko St=C3=BCbner <heiko@sntech.de>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> ---
>  drivers/pmdomain/rockchip/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pmdomain/rockchip/Kconfig b/drivers/pmdomain/rockchi=
p/Kconfig
> index 218d43186e5b9..17f2e6fe86b6f 100644
> --- a/drivers/pmdomain/rockchip/Kconfig
> +++ b/drivers/pmdomain/rockchip/Kconfig
> @@ -3,6 +3,7 @@ if ARCH_ROCKCHIP || COMPILE_TEST
> =20
>  config ROCKCHIP_PM_DOMAINS
>  	bool "Rockchip generic power domain"
> +	default ARCH_ROCKCHIP
>  	depends on PM
>  	depends on HAVE_ARM_SMCCC_DISCOVERY
>  	depends on REGULATOR
>=20

Acked-by: Heiko Stuebner <heiko@sntech.de>




