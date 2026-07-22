Received: from mail-m15586.qiye.163.com (mail-m15586.qiye.163.com [101.71.155.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65D342CB3
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jul 2026 06:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701419; cv=none; b=rbiOexnK7y0T9BMr1nK1OxVSrQUtVWyx28utAVfYtyTTX9bIvijXhadTj/0BcB1o9BhGLyJKfmKi5QyYYhBX+E7ZF0EQtdWBMzjAmtRuJweRlkDH1INQMU0xMXnSCaPtcVEN7Otm0KtaJIPNGZxssFVNM9TyaeJ2Uj58xS+Y9pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701419; c=relaxed/simple;
	bh=+MAop0tSH8w2vQ3jBJcFBAb0ZmFYBNL8DXJe6E0JcMo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dfei6xzy14VTS7DmmL2uVP2yG7kcw4nm1sruJ+kMrl2IS3yaA24mUHbO35nBl2ocTGWPzX8s5UEnJtCT26yMY5FxIGlW3pyjlV8R61Xg3IzbP3jwYuK7mX1v99JCOcH4c5cOcgXPIkAH5hNEOtqbIeVZrp0Z2Gqg+U4UtboahOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hNZnW+PQ; arc=none smtp.client-ip=101.71.155.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hNZnW+PQ"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 471674a07;
	Wed, 22 Jul 2026 10:54:11 +0800 (GMT+08:00)
Message-ID: <b01a6658-e575-42e6-9520-e8bb55d0329e@rock-chips.com>
Date: Wed, 22 Jul 2026 10:54:11 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>,
 linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Subject: Re: PROBLEM: mmc clock reduction error on NanoPi-R5S (rk3568)
To: Peter Taylor <me@et1.uk>
References: <43e06f45-7617-4a6c-9b4f-f952e8700456@et1.uk>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <43e06f45-7617-4a6c-9b4f-f952e8700456@et1.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f87bebb9203a4kunmd27374915ddf7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQxkfVkIfGUNDGB4aT09MHlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hNZnW+PQr4Bvn5NqFcHavXyFWZWHwbqHyWOq2NuJTyBEQndgE9P2Aqr3fi6GzsIzCUZW2WJGw+TGwyfYpxYVgcrH0LWscsfq/8fIC/jsOxOglXOmNKIxOFYnDt9ntb8VyAOGqFKy1PMrM9IwwKeyogTQW083QmjXHX6sbWD3CJ4=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=V1A15LAH3pLo0S+e52GAbEOB1kaub9sBVqHB/R/WxwI=;
	h=date:mime-version:subject:message-id:from;

+ Ulf's new mail

在 2026/07/21 星期二 3:56, Peter Taylor 写道:
> After the changes in 3009738a855c (Prevent illegal clock reduction in
> HS200/HS400 mode), when trying to change the drive's partition table
> using fdisk, it fails when I go to write. Here is the relevant dmesg 
> output.
> [ 19.509615] dwmmc_rockchip fe2b0000.mmc: IDMAC supports 32-bit address 
> mode.
> [ 19.510330] dwmmc_rockchip fe2b0000.mmc: Using internal DMA controller.
> [ 19.511727] dwmmc_rockchip fe2b0000.mmc: Version ID is 270a
> [ 19.512302] dwmmc_rockchip fe2b0000.mmc: DW MMC controller at irq 94,32 
> bit host data width,256 deep fifo
> [ 19.541960] mmc_host mmc1: Bus speed (slot 0) = 375000Hz (slot req 
> 400000Hz, actual 375000HZ div = 0)
> [ 19.563121] mmc0: SDHCI controller on fe310000.mmc [fe310000.mmc] using 
> ADMA
> [ 19.602217] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 
> 50000000Hz, actual 50000000HZ div = 0)
> [ 19.603277] mmc1: new high speed SDHC card at address 59b4
> [ 19.647750] mmcblk1: mmc1:59b4 SMI 7.50 GiB
> [ 19.652366] mmcblk1: p1
> [ 19.655584] sdhci-dwcmshc fe310000.mmc: Can't reduce the clock below 
> 52MHz in HS200/HS400 mode
> [ 19.656917] mmc0: new HS400 Enhanced strobe MMC card at address 0001

May I ask which dts file you're using now?
The RK3566/RK3568 SoCs only claim to support HS200.

> [ 19.658749] mmcblk0: mmc0:0001 hC8aP> 58.2 GiB
> [ 19.665252] mmcblk0:
> [ 19.665969] mmcblk0boot0: mmc0:0001 hC8aP> 4.00 MiB
> [ 19.669411] mmcblk0boot1: mmc0:0001 hC8aP> 4.00 MiB
> [ 19.672446] mmcblk0rpmb: mmc0:0001 hC8aP> 16.0 MiB, chardev (505:0)
> [ 462.450194] sdhci-dwcmshc fe310000.mmc: Can't reduce the clock below 
> 52MHz in HS200/HS400 mode
> [ 462.452168] I/O error, dev mmcblk0, sector 122142719 op 0x1:(WRITE) 
> flags 0x800800 phys_seg 1 prio class 2
> [ 462.453338] Buffer I/O error on dev mmcblk0, logical block 15267839, 
> lost async page write
> I have been testing on v7.1.3, and it is known good on v6.18.38.
> As the error also occurs at startup, my thought is it could be an 
> invalid value in
> the device tree, possibly the 24MHz value in rk356x-base.dtsi:1085 ?
> 

