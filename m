Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1131353366;
	Thu, 11 Sep 2025 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606786; cv=none; b=KT7STawoZbHwmXAv31TOkAP3HwhWQH9atdJXezroaDijJ/jVOQvMOv2Ujnt/Qx2TCIqWyKcz/vPLTJXPp94ypaNzAjI2fFjhFZs7DU3XoNz4JpLf3xeY6UW2Lnh9F6wB3RMi8J+AARDtGHFS6hIYg3X1O9mmUUxxN+LssVaXO3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606786; c=relaxed/simple;
	bh=ciCOZGhabF8HNR4h9pq04kCRspkxj5kJMALIlh2nY/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLsdPYbx+oxE5m+2EPOyscB7Id0QVV11k3Q7bQUb4hJAuytVrbU8xRsXSoQOZtxwzL+3tZcpOlaiwAIDXeIyQy8bJggBgc+1ymxciBLSGfcqGA4N5yQhhp/2MZOYyXZVQvANCx3aPtEl7unG7+7H+Jip1GB8k22VNuMisXtSh6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=lU4LzOPK; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="lU4LzOPK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=itbn4svyCtOyKrWsQDdF9xn6MViM9FiPog00luIp7Hw=; b=lU4LzOPK68yTBqYSalE1clHwYN
	5ZqJJgi9HtmpdzyYL3fKydZackJ0rBn6DiWtxo2NR2mhpxws1IaVOknCjfYk6auYUaFjRKiA2jyS4
	xscLRNyHUm42jJrh1e2OoHgH0Oo5qw907QspE8L06J+qB5nZtgCEdeLtBjh4cfAR1+vouZ52YQDGh
	/GNAzD46ms4S9FW30hQZNDg6LJkFVdh4QLMzdN5ab5UaAIl1TP7zm/ZD5oJWNRSr3lCsxOfMGoWp1
	ewFyxQqNNNdlYo8e7pjQ1SVX71P20S7vc/idWdCd7lKc0TJXHXKOEhir3vv9GHvYbI7taNCXVNf8L
	+VFLvWrQ==;
Received: from i53875b0e.versanet.de ([83.135.91.14] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uwjo8-0003Pg-EB; Thu, 11 Sep 2025 18:06:00 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: arnd@arndb.de, Mikko Rapeli <mikko.rapeli@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 adrian.hunter@intel.com, victor.shih@genesyslogic.com.tw,
 ben.chuang@genesyslogic.com.tw, geert+renesas@glider.be,
 angelogioacchino.delregno@collabora.com, dlan@gentoo.org,
 zhoubinbin@loongson.cn
Subject:
 Re: [PATCH] mmc: dw_mmc-rockchip: add dependency to ROCKCHIP_PM_DOMAINS
Date: Thu, 11 Sep 2025 18:05:59 +0200
Message-ID: <1813054.X513TT2pbd@diego>
In-Reply-To:
 <CAPDyKFqLag_WkxqOCebvBCJy4TzZEqt-rFD_Z30sajUxgSpcaA@mail.gmail.com>
References:
 <20250911144313.2774171-1-mikko.rapeli@linaro.org>
 <CAPDyKFqLag_WkxqOCebvBCJy4TzZEqt-rFD_Z30sajUxgSpcaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Donnerstag, 11. September 2025, 17:03:14 Mitteleurop=C3=A4ische Sommerze=
it schrieb Ulf Hansson:
> On Thu, 11 Sept 2025 at 16:43, Mikko Rapeli <mikko.rapeli@linaro.org> wro=
te:
> > @@ -866,7 +866,7 @@ config MMC_DW_PCI
> >
> >  config MMC_DW_ROCKCHIP
> >         tristate "Rockchip specific extensions for Synopsys DW Memory C=
ard Interface"
> > -       depends on MMC_DW && ARCH_ROCKCHIP
> > +       depends on MMC_DW && ARCH_ROCKCHIP && ROCKCHIP_PM_DOMAINS
>=20
> Rather than "depends on", I think a "select" is better to be added
> from the platform's Kconfig. Probably drivers/soc/rockchip/Kconfig is
> where to put this.
>=20
> Assuming that ROCKCHIP_PM_DOMAINS is a critical piece for most
> Rockchip platforms to work.

I'd think
=2D arch/arm64/Kconfig.platforms
=2D arch/arm/mach-rockchip/Kconfig
would be the correct positions.

And as Ulf suggested, this should be a "select"


And I guess, always selecting it makes sense as well.

Every supported soc back to the before 2012 RK3066 has controllable
power-domains and while the driver is selected in both the arm32+64
defconfigs, this still allows people to manually de-select the driver
leaving most elements to defer.

So yes, always-selecting the driver makes a lot of sense.


Thanks
Heiko


