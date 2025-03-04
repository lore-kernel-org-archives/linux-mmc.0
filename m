Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F7724EAB0
	for <linux-mmc@vger.kernel.org>; Tue,  4 Mar 2025 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118147; cv=none; b=Tq1N4kpvHVuBnZ5IQsdCuSrfxsgM9z/++NZpBO5Trzqg/MDEDTI3XRAMC0HpBisXk54Hzd0UZleVfCSjdBEzsLsyWUvUzGkZJwRovRI41bLYRXF/ouzoKfOZYcXz+tiDwo5PQiztCJstYrfLDtpIcXh5xvdiIJGv4EfP0JYfpbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118147; c=relaxed/simple;
	bh=CeLR4mKb9WxrBvHDq2sz+cc4eUGHQ5l9Bx1L8sbel3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yx1E6oodCZ8dr908LCSm3+8bRheUlOoJgitVgFFOApIlYSf9BA1iG5/ZjuGltgJUrUVzVFBjdHdGL+iYxuffFJpdK8/KRjJLt7I67VnNiVzRExncHs3zcJKCTkPV10LfPJ9AXzrfMqziL1T0RMzi4G+NzQ7Q1c4nCczGzd68i2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=yNw1wm/l; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="yNw1wm/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741118145;
 bh=eJwNGtEp4XbaHSJ4DCMpAhRX6Xx7TLv6dC2ug10rAwQ=;
 b=yNw1wm/l8hnDFp7zc/f8qrC8fhX1IvNphtQbUMyJ0hTFEYxQ5PupMLE9p158McdJUS3uOW279
 UmTygYYXsu5V6ODqsbeuzt2Mw2PDOPN1Db8zfsMU3HxZO6SD7ClHy5sNoZcmVp8aIOWjzB2x/Pp
 tr24ou1aEQ+95wtmwmoMpJakkqyqThvXMMhtO6nG2sp1Ya3YnpUS1DW2CjD6PpQcf5jMU5ClS7i
 x2L+JiidHDW9nrK8NClrazDXwurFrtv79to5A0IZMQJ8EWEQfe4D/FbV3nV+7xWJPOa8rTkgm+K
 tNP1v1N5rRwPsJLZEzTec5VZSQ6b/1f5chTovPWa2cSg==
X-Forward-Email-ID: 67c75abd2e5baeec949f8de0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <5c429552-bdbb-43d9-8e07-bacda57c0fcf@kwiboo.se>
Date: Tue, 4 Mar 2025 20:55:36 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: dts: rockchip: Enable SD-card interface on
 Radxa E20C
To: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, cristian.ciocaltea@collabora.com,
 detlev.casanova@collabora.com, devicetree@vger.kernel.org,
 frank.wang@rock-chips.com, heiko@sntech.de, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-rockchip@lists.infradead.org
References: <20250301104835.36439-1-ziyao@disroot.org>
 <20250304121036.1453284-1-amadeus@jmu.edu.cn> <Z8dZWYpABghRHHge@pie.lan>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <Z8dZWYpABghRHHge@pie.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yao Zi,

On 2025-03-04 20:49, Yao Zi wrote:
> On Tue, Mar 04, 2025 at 08:10:36PM +0800, Chukun Pan wrote:
>> Hi,
>>
>>> +	aliases {
>>> +		mmc0 = &sdmmc;
>>
>> s/mmc0/mmc1
> 
> Will take it and add the missing pinctrl, as Jonas already pointed out.
> 
>>> +&sdmmc {
>>> +	bus-width = <4>;
>>> +	cap-mmc-highspeed;
>>> +	cap-sd-highspeed;
>>
>> I think for sdcard, only cap-sd-highspeed
>> is needed, not cap-mmc-highspeed?
> 
> This makes sense, will remove it in the next version.

Please do not remove the cap-mmc-highspeed prop, I tested the controller
with a microSD to eMMC adapter and MMC HS speed is supported:

  mmc1: card 59b4 removed
  mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
  mmc_host mmc1: Bus speed (slot 0) = 49800000Hz (slot req 52000000Hz, actual 49800000HZ div = 0)
  mmc1: new high speed MMC card at address 0001
  mmcblk1: mmc1:0001 DG4008 7.28 GiB
   mmcblk1: p1 p2
  mmcblk1boot0: mmc1:0001 DG4008 4.00 MiB
  mmcblk1boot1: mmc1:0001 DG4008 4.00 MiB
  mmcblk1rpmb: mmc1:0001 DG4008 4.00 MiB, chardev (499:0)

  ~ # cat /sys/kernel/debug/mmc1/ios
  clock:          52000000 Hz
  vdd:            21 (3.3 ~ 3.4 V)
  bus mode:       2 (push-pull)
  chip select:    0 (don't care)
  power mode:     2 (on)
  bus width:      2 (4 bits)
  timing spec:    1 (mmc high-speed)
  signal voltage: 0 (3.30 V)
  driver type:    0 (driver type B)

Regards,
Jonas

> 
>>> +	disable-wp;
>>
>> Missing pinctrl.
>>
>>> +	rockchip,default-sample-phase = <90>;
>>
>> It seems that all rk3528 devices need to set this
>> default phase, so maybe this can be placed in dtsi?
> 
> Yes, since the tuned phase offset is a SoC-specific value, as pointed
> out by comment in the driver,
> 
> 	this is _not_ a value that is dynamically tuned and is also
> 	_not_ a value that will vary from board to board.  It is a value
> 	that could vary between different SoC models.
> 
> Will take it in the next version, thanks for finding it!
> 
>>> +	sd-uhs-sdr104;
>>
>> The rk3528 devices uses gpio to switch IO voltage, maybe
>> more modes should be added here like vendor kernel?
> 
> I cannot get the relationship between things you mentioned. For the
> regulator, yes, here vqmmc-supply is missing, as already pointed out by
> Jonas.
> 
>> And these devices use 3.3V IO voltage by default.
>>
>> 	sd-uhs-sdr12;
>> 	sd-uhs-sdr25;
>> 	sd-uhs-sdr50;
>> 	sd-uhs-sdr104;
> 
> But I don't think it's necessary to lay out these slower modes
> explicitly, since SDR104 seems to imply them, see
> sd_update_bus_speed_mode() in drivers/mmc/core/sd.c[1],
> 
>         if ((card->host->caps & MMC_CAP_UHS_SDR104) &&
>             (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR104)) {
>                         card->sd_bus_speed = UHS_SDR104_BUS_SPEED;
>         } else if ((card->host->caps & MMC_CAP_UHS_DDR50) &&
>                    (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_DDR50)) {
>                         card->sd_bus_speed = UHS_DDR50_BUS_SPEED;
>         } else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
>                     MMC_CAP_UHS_SDR50)) && (card->sw_caps.sd3_bus_mode &
>                     SD_MODE_UHS_SDR50)) {
>                         card->sd_bus_speed = UHS_SDR50_BUS_SPEED;
>         } else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
>                     MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25)) &&
>                    (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR25)) {
>                         card->sd_bus_speed = UHS_SDR25_BUS_SPEED;
>         } else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
>                     MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25 |
>                     MMC_CAP_UHS_SDR12)) && (card->sw_caps.sd3_bus_mode &
>                     SD_MODE_UHS_SDR12)) {
>                         card->sd_bus_speed = UHS_SDR12_BUS_SPEED;
>         }
> 
>> Thanks,
>> Chukun
>>
>> -- 
>> 2.25.1
>>
> 
> Regards,
> Yao Zi
> 
> [1]: https://elixir.bootlin.com/linux/v6.13.5/source/drivers/mmc/core/sd.c#L448-L479

