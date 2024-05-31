Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49D71422B8;
	Fri, 31 May 2024 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717149631; cv=none; b=feYn8aXkgMk+j92uhGwaORI6AaZagBDhS3AvD/gWXyE/0slbB3P0ZetZgQm8KCk2wMU9K2FZkuUcxY2CiHs2jglBfu0IXRvm03U5M2yb7XVO5kJ/b8SDl55dAW6JrmivWLM1iED5c+Q5axmS2WxE1UNnTjWMAiPE5YYYtjjp2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717149631; c=relaxed/simple;
	bh=GjsznghdysZp68H0iTM8WCUDR6RX6D4R9WpQ0Uw4Jfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Aun5znI5Ka6vpWXrEfJwYbjCKuHX7M9KPmnJ0x21ak1rG3IdVgL9v+H60ga9/YE+4Akodz07udI2MLrYeeFo8FycYoA1id8M4z5Z/+x7S8nVhcbAQiL2uDmVUO4DK3LqewdqNoTyjwx1iq9iMmmbKzR5jTT3SfRx65c77yeHBaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=rgua9hSZ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="rgua9hSZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1717149611; x=1717754411; i=wahrenst@gmx.net;
	bh=SKMrSxZi6YJ6irKfb+bbvyw+6ypZ+N02Wwss1x87j0Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rgua9hSZaZRfKQaAkFlyrTwkc9ISFT4I26hD62wr0fvrqgo40ejg9l5SGL4pmwVn
	 hB3b6uZAc+5rF1SbMNWnsqPLOAOn3zwxP/NKHNP9Z0NOW8RGkTvunipbl/w4AuzSU
	 jkiqsASmxE5HVdW6d+KvC+boVh3euSP8MmpSn6Ciqx0+qtvyycr11k10IDHST+HzV
	 KfIxTkAWmszASYIVxWvaLbLl0UB63xBAgBwUJ1SyeD4Qrpg7TwQqavZgyui7jEhLc
	 UZI3Lk+Ha/WJ9qxDBo7kmyBp3r57KSIibrj7WDfLyoCWDMYeIQDks6+Zbhca7u9XO
	 7s0q38Ym/Dnh0C+6uA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXhA-1rraK83SKY-00Md8t; Fri, 31
 May 2024 12:00:10 +0200
Message-ID: <36642bd8-c981-4190-9f44-072ac3c97c6b@gmx.net>
Date: Fri, 31 May 2024 12:00:07 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] Add minimal boot support for Raspberry Pi 5
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <cover.1717061147.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <cover.1717061147.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NC3U7PPJiwkY9pDq8eAw5WVvbNo2mtziqFH6WTnEhDW2yoCcFkS
 +0IhCR/H/Xq44Pl5QAT5O/TH25E7U0auv2ztbEvHfCDuGzND/yGPdvN9p4t/5e6MSwq1DcS
 /U6+BXowocckNKyxA/D2HXeRwOPgRitFEMY9vw4QW8uQ8vOazViSYwi5mvczuymgbUQVcvH
 AC5wHh1FAWxf7XqLC7PvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2aASMyPySck=;cYE8SQEXYO6YSrrCHXAMmcampT4
 eEw2/zrBMA7oAeTdxF6JThFFGVzhtgSS5LEtbRsHbXSpvnTZM5bOA4FSEFRzaAN2jjuUYp06M
 mHdZoXq3ERumQcJHouZugNYY1RaKE6cZo8EQClzDdg712I6ymYtrRZWxdsMRaiFXrOyMX4GAk
 i0lhwWfd7hLSG9NbTqOR++z+TCfKCFb5x/Z8pb/dd9AnuCxjU6EvkiGij4jbHzzuR61OX503M
 SBbgUbwhwjeqIa8iyNweqZHCKlG+EiWrur/vyIT6FZKHT7Sr1GoBAThm5oQ4EKr3ax7GhF4mR
 /CrMYM7J/ozCF8BGjWKjR4DqEcn2W0iAcsc6NMdhSEOE3id2lQxl4KnOXgXoBK69n8YLggDqR
 diHf05aOQt1EUcZ3+Bdnf+++suqeJQYK2hdstduzQrQhRTtiSVeSDXdj/Kyrddz7NyqBOboyP
 xz64yHm+j0PVTaP0sfmVIIdUWY5RmDj0QcWYXyDXiOQhc8CBGFrmWponv/Mx+gcwfdeZsoYIW
 BBHsReMIxV5R5XywUjlHMXCQnYK8hFBmN+xwd5R1yUs4yl37jp2e28UhCc7vf3G1c5kaMZMnQ
 We+7Rwa0ruyQPeCBfsgA2UjbYyVmBl8isCQxRU2JPgEws5tvh12SL76PR/qcp7TZxk5EKjD2n
 REU6yjP/AUoot/2LjsLryq197AuJsi1LAS6uazyN6KY6YDIFtcMmlyVlzhZF08akiI30NCPqg
 m33adAzpk8cWNq13pNNK0SF3UWo9r5uN3ew4qU8ahh8XvCdamBFLBK2xbUpCMYXkUQXP03DUp
 53Ul7kflx8f0fPh8spd0PC/IwWoCnQnzvbFBR8C14fgek=

Hi Andrea,

Am 30.05.24 um 12:11 schrieb Andrea della Porta:
> Hi,
>
> This patchset adds minimal support for the Broadcom BCM2712 SoC and for
> the on-board SDHCI controller on Broadcom BCM2712 in order to make it
> possible to boot (particularly) a Raspberry Pi 5 from SD card and get a
> console through uart.
> Changes to arm64/defconfig are not needed since the actual options work
> as they are.
> This work is heavily based on downstream contributions.
>
> Tested on Tumbleweed substituting the stock kernel with upstream one,
> either chainloading uboot+grub+kernel or directly booting the kernel
> from 1st stage bootloader. Steps to reproduce:
> - prepare an SD card from a Raspberry enabled raw image, mount the first
>    FAT partition.
> - make sure the FAT partition is big enough to contain the kernel,
>    anything bigger than 64Mb is usually enough, depending on your kernel
>    config options.
> - build the kernel and dtbs making sure that the support for your root
>    fs type is compiled as builtin.
> - copy the kernel image in your FAT partition overwriting the older one
>    (e.g. kernel*.img for Raspberry Pi OS or u-boot.bin for Tumbleweed).
> - copy arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb on FAT partition.
> - make sure you have a cmdline.txt file in FAT partition with the
>    following content:
>    # cat /boot/efi/cmdline.txt
>    root=/dev/mmcblk0p3 rootwait rw console=tty ignore_loglevel earlycon
>    console=ttyAMA10,115200
> - if you experience random SD issues during boot, try to set
>    initial_turbo=0 in config.txt.
was this an issue since the beginning of this series?

What kind of SD issues?

Is there a downstream reference?
