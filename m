Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457752E3399;
	Tue,  4 Mar 2025 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117814; cv=none; b=EcKx31YywJ9XEvAJ9I8MnVl0CBUPB+M0K1tYlfbavZFhYpBpTjr78a+94l4eUzzTrdbZUmrBEORyxBsvq3ubccgiKCnNRZy9DNWjqEhJX7+2J+qeofkSQTH5qPXSkIkXUojL+czlh59tTy2TJbLBizOwkuBHjctw9lDW2jHOueM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117814; c=relaxed/simple;
	bh=/vRWKQtZKb8AVks66fKFJNA8Q7HHHVpV5dIgIcKRJh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1hnNqRWs9nRa/GCBrZwc+9fEblU+wo1lkpRSIwI3jBDlKmwa+wcVU8Ch1dXsU8ALBlLZVA54xC+yHE1PF3EP6fKEzAeZeK4SIDldI1SHVJ5jg1lTlr2FvVkCX+ehCtB8ccF+XhTf7whnwVFLOl3mGACXK/j1hDs7CYx6Hr6hgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=EWOlvoXB; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="EWOlvoXB"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 0095C252B4;
	Tue,  4 Mar 2025 20:50:09 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YOe44yWLNYEa; Tue,  4 Mar 2025 20:50:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741117804; bh=/vRWKQtZKb8AVks66fKFJNA8Q7HHHVpV5dIgIcKRJh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EWOlvoXB2lKejxwrdke4Er6of5ABdK3jBS9BAXlXEL0XFcLS/7C0FI/oEB1pz5JpR
	 yStJAX5kufOc7R5KTMYtpQvzZZClaZe1L05PLt1BJlCvyAp0TMiVt3jZyiEQhZKrrh
	 DC1g3n0EnlgV3+tBx61eFGMHLWBzWJuq3kRkNOP16r7p/9ZOBZKIVKjByeqdnt8ry/
	 pkLkd8wXvLy+ItQptFHSWKUtx0nVA9JiMlh7MObc7kiMZrzVqHDyUo+bduvDD9iybP
	 ZvfPyhbDp0qziwtu+YrJ/xUroOCsLzWzkjRo3HlIu3EkzYRmFG0gxi1zzBElz5i8f4
	 /EsfnkVnFBvTg==
Date: Tue, 4 Mar 2025 19:49:45 +0000
From: Yao Zi <ziyao@disroot.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, cristian.ciocaltea@collabora.com,
	detlev.casanova@collabora.com, devicetree@vger.kernel.org,
	frank.wang@rock-chips.com, heiko@sntech.de, jonas@kwiboo.se,
	krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 8/8] arm64: dts: rockchip: Enable SD-card interface on
 Radxa E20C
Message-ID: <Z8dZWYpABghRHHge@pie.lan>
References: <20250301104835.36439-1-ziyao@disroot.org>
 <20250304121036.1453284-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304121036.1453284-1-amadeus@jmu.edu.cn>

On Tue, Mar 04, 2025 at 08:10:36PM +0800, Chukun Pan wrote:
> Hi,
> 
> > +	aliases {
> > +		mmc0 = &sdmmc;
> 
> s/mmc0/mmc1

Will take it and add the missing pinctrl, as Jonas already pointed out.

> > +&sdmmc {
> > +	bus-width = <4>;
> > +	cap-mmc-highspeed;
> > +	cap-sd-highspeed;
> 
> I think for sdcard, only cap-sd-highspeed
> is needed, not cap-mmc-highspeed?

This makes sense, will remove it in the next version.

> > +	disable-wp;
> 
> Missing pinctrl.
>
> > +	rockchip,default-sample-phase = <90>;
> 
> It seems that all rk3528 devices need to set this
> default phase, so maybe this can be placed in dtsi?

Yes, since the tuned phase offset is a SoC-specific value, as pointed
out by comment in the driver,

	this is _not_ a value that is dynamically tuned and is also
	_not_ a value that will vary from board to board.  It is a value
	that could vary between different SoC models.

Will take it in the next version, thanks for finding it!

> > +	sd-uhs-sdr104;
> 
> The rk3528 devices uses gpio to switch IO voltage, maybe
> more modes should be added here like vendor kernel?

I cannot get the relationship between things you mentioned. For the
regulator, yes, here vqmmc-supply is missing, as already pointed out by
Jonas.

> And these devices use 3.3V IO voltage by default.
> 
> 	sd-uhs-sdr12;
> 	sd-uhs-sdr25;
> 	sd-uhs-sdr50;
> 	sd-uhs-sdr104;

But I don't think it's necessary to lay out these slower modes
explicitly, since SDR104 seems to imply them, see
sd_update_bus_speed_mode() in drivers/mmc/core/sd.c[1],

        if ((card->host->caps & MMC_CAP_UHS_SDR104) &&
            (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR104)) {
                        card->sd_bus_speed = UHS_SDR104_BUS_SPEED;
        } else if ((card->host->caps & MMC_CAP_UHS_DDR50) &&
                   (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_DDR50)) {
                        card->sd_bus_speed = UHS_DDR50_BUS_SPEED;
        } else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
                    MMC_CAP_UHS_SDR50)) && (card->sw_caps.sd3_bus_mode &
                    SD_MODE_UHS_SDR50)) {
                        card->sd_bus_speed = UHS_SDR50_BUS_SPEED;
        } else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
                    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25)) &&
                   (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR25)) {
                        card->sd_bus_speed = UHS_SDR25_BUS_SPEED;
        } else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
                    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25 |
                    MMC_CAP_UHS_SDR12)) && (card->sw_caps.sd3_bus_mode &
                    SD_MODE_UHS_SDR12)) {
                        card->sd_bus_speed = UHS_SDR12_BUS_SPEED;
        }

> Thanks,
> Chukun
> 
> -- 
> 2.25.1
> 

Regards,
Yao Zi

[1]: https://elixir.bootlin.com/linux/v6.13.5/source/drivers/mmc/core/sd.c#L448-L479
