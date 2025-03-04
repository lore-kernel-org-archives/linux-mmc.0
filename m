Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35E11FBC84;
	Tue,  4 Mar 2025 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118563; cv=none; b=fscGlu1NSuVhtjiWh4C6+51PRtEB6zLF66y4HDUZOxHP+UG+VirRzzLD0ZMvZEcx3iTtTb+AjlcQKWbjXvqVGvXAUk6Jhp+gw9Ipct6vgQUgSxC7nU+PdtVAZAE42GDZRD5bUWp6Pg5J7N9/84syUpw+U3GGZka+O89teRcolRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118563; c=relaxed/simple;
	bh=UePoE7L+f7kPyHfkYoHOYaJpHOxR5rYnvPUWwiwyiDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVr/+i9qlJeCga6skW9c1u9I5NXvho88nULHR270OhEoxk0PmtXSBbSIrU+O+hZAV1AOKfODgNjjzUwmb2VzZjHu9JddmuVWmlqv605RKsTtcy25OhwmTs5UjmcRWI8UW63N0dBAsV7XdfEfor6waZCJ41qQpKP3ulnjKvDqQ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ax6vpksm; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ax6vpksm"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id F022C25C7A;
	Tue,  4 Mar 2025 21:02:38 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rsbyoN1SgCEm; Tue,  4 Mar 2025 21:02:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741118554; bh=UePoE7L+f7kPyHfkYoHOYaJpHOxR5rYnvPUWwiwyiDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ax6vpksmBD+CYVeLZO+qbuQqOz2F8d/OHrJiYEXf1cqJe9I39YUqdyU6VbDhsPhg4
	 x+9AtlWcGvxnP5kgm596OqXJ1UMLJ1pyh22g4Qw/WavCbiTwP//6MpzLSyokW3w5ie
	 BR8mIqqeqdywjNKaS//tqsQ5hf7Qkjx2uVkn4/nheuYbd1udjK2yupqFjIRmr2h+h6
	 8pUWyA23Kj0cX4mdTlPQmLeV9qIcAE2kD6Gd8YVKfGHZS6ULe778dkoS6HSLgB8/2P
	 k+rhVLTu6sFAfL1CJ8ZAEYVygWCcBdoYNgFGi/1knwkFOJPIfHZht/zvet292xVYB2
	 ichjAKH9MPMnA==
Date: Tue, 4 Mar 2025 20:02:14 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, cristian.ciocaltea@collabora.com,
	detlev.casanova@collabora.com, devicetree@vger.kernel.org,
	frank.wang@rock-chips.com, heiko@sntech.de, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 8/8] arm64: dts: rockchip: Enable SD-card interface on
 Radxa E20C
Message-ID: <Z8dcRjPcbKqEyKdT@pie.lan>
References: <20250301104835.36439-1-ziyao@disroot.org>
 <20250304121036.1453284-1-amadeus@jmu.edu.cn>
 <Z8dZWYpABghRHHge@pie.lan>
 <5c429552-bdbb-43d9-8e07-bacda57c0fcf@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c429552-bdbb-43d9-8e07-bacda57c0fcf@kwiboo.se>

On Tue, Mar 04, 2025 at 08:55:36PM +0100, Jonas Karlman wrote:
> Hi Yao Zi,
> 
> On 2025-03-04 20:49, Yao Zi wrote:
> > On Tue, Mar 04, 2025 at 08:10:36PM +0800, Chukun Pan wrote:
> >> Hi,
> >>
> >>> +	aliases {
> >>> +		mmc0 = &sdmmc;
> >>
> >> s/mmc0/mmc1
> > 
> > Will take it and add the missing pinctrl, as Jonas already pointed out.
> > 
> >>> +&sdmmc {
> >>> +	bus-width = <4>;
> >>> +	cap-mmc-highspeed;
> >>> +	cap-sd-highspeed;
> >>
> >> I think for sdcard, only cap-sd-highspeed
> >> is needed, not cap-mmc-highspeed?
> > 
> > This makes sense, will remove it in the next version.
> 
> Please do not remove the cap-mmc-highspeed prop, I tested the controller
> with a microSD to eMMC adapter and MMC HS speed is supported:
> 
>   mmc1: card 59b4 removed
>   mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
>   mmc_host mmc1: Bus speed (slot 0) = 49800000Hz (slot req 52000000Hz, actual 49800000HZ div = 0)
>   mmc1: new high speed MMC card at address 0001
>   mmcblk1: mmc1:0001 DG4008 7.28 GiB
>    mmcblk1: p1 p2
>   mmcblk1boot0: mmc1:0001 DG4008 4.00 MiB
>   mmcblk1boot1: mmc1:0001 DG4008 4.00 MiB
>   mmcblk1rpmb: mmc1:0001 DG4008 4.00 MiB, chardev (499:0)
> 
>   ~ # cat /sys/kernel/debug/mmc1/ios
>   clock:          52000000 Hz
>   vdd:            21 (3.3 ~ 3.4 V)
>   bus mode:       2 (push-pull)
>   chip select:    0 (don't care)
>   power mode:     2 (on)
>   bus width:      2 (4 bits)
>   timing spec:    1 (mmc high-speed)
>   signal voltage: 0 (3.30 V)
>   driver type:    0 (driver type B)

Oops, indeed, I didn't expect the adapted usecase and thought only
sdcards could be connected through the interface.

> Regards,
> Jonas

Thanks for the correction,
Yao Zi
