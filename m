Received: from mx.et1.uk (mx.et1.uk [116.203.106.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A97449B08
	for <linux-mmc@vger.kernel.org>; Mon, 20 Jul 2026 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.106.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577889; cv=none; b=RHt9nqBC1qfztM8wGrJeBSAsvEq/2YIejpmJN1YHqQml4huwhpfoemWgrYmUFI3XsGstSJc3NVcc9DkxOTYvU81ixQPW9hudxNk1de4LjzXBkZsSsnrFbt2d+b+ipxwiufOsBTHJLQocIl94sP7XcXk60l6eo9EPdjbvgV24yFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577889; c=relaxed/simple;
	bh=4AtfKWN3a5iLV/rpjY/a6WUEoZESIe+UaxFwbw+Lsgo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UW6SoxTqyonox9pgIvpORNacJjSGBBSw/09mir7bETAZqHIlPjD/L2rSurW+pjMTfXO039A45MPP14qQug6hUhz5YKHcfEqnQGaPC1S6A5/qxWUKfuHcrKX6AospcoyBpaOfPGyuBT8y5BR/jSDaP4Z1CuxPjpGvnCEFyZMJS8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=et1.uk; spf=pass smtp.mailfrom=et1.uk; dkim=pass (2048-bit key) header.d=et1.uk header.i=@et1.uk header.b=W4QJHAM/; arc=none smtp.client-ip=116.203.106.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=et1.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=et1.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=et1.uk header.i=@et1.uk header.b="W4QJHAM/"
Message-ID: <43e06f45-7617-4a6c-9b4f-f952e8700456@et1.uk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=et1.uk; s=mail;
	t=1784577374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PfdKbEVdsco/4dRwEOlsRduQROiYg9uxYVCfLW8VuBs=;
	b=W4QJHAM/2+KIWpwXA/y4GHHs/9MSmi95zRAGaIz8DEAZU02JiYt5u019uheUR1pqV7V4om
	85baQ+DEYfoNshYIgPuTfrgd4/F+NKpSHlUXMlN37VmlnRIXW5TSx81kx8i76LSjA7BghS
	iw9+23dYJpr2L8DWGeZR1vwBwO/vSDbnG/4FDxjZQla4ULGNewAIJLaFANmNLt3tGTkApH
	d1Ezjoc38YmuBAoqz6o+nMTJsJfjj3dP6Ud/OYDmH+NbaLr21CnCKcqB0G90ceUUKc2xvS
	ieqIVphlDSPJKB1YmNe4GdtrG5qXflg9psXU4KwXLI1yltCan/msqo8P/5jCXw==
Date: Mon, 20 Jul 2026 20:56:12 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>
From: Peter Taylor <me@et1.uk>
Subject: PROBLEM: mmc clock reduction error on NanoPi-R5S (rk3568)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

After the changes in 3009738a855c (Prevent illegal clock reduction in
HS200/HS400 mode), when trying to change the drive's partition table
using fdisk, it fails when I go to write. Here is the relevant dmesg output.
[ 19.509615] dwmmc_rockchip fe2b0000.mmc: IDMAC supports 32-bit address 
mode.
[ 19.510330] dwmmc_rockchip fe2b0000.mmc: Using internal DMA controller.
[ 19.511727] dwmmc_rockchip fe2b0000.mmc: Version ID is 270a
[ 19.512302] dwmmc_rockchip fe2b0000.mmc: DW MMC controller at irq 94,32 
bit host data width,256 deep fifo
[ 19.541960] mmc_host mmc1: Bus speed (slot 0) = 375000Hz (slot req 
400000Hz, actual 375000HZ div = 0)
[ 19.563121] mmc0: SDHCI controller on fe310000.mmc [fe310000.mmc] using 
ADMA
[ 19.602217] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 
50000000Hz, actual 50000000HZ div = 0)
[ 19.603277] mmc1: new high speed SDHC card at address 59b4
[ 19.647750] mmcblk1: mmc1:59b4 SMI 7.50 GiB
[ 19.652366] mmcblk1: p1
[ 19.655584] sdhci-dwcmshc fe310000.mmc: Can't reduce the clock below 
52MHz in HS200/HS400 mode
[ 19.656917] mmc0: new HS400 Enhanced strobe MMC card at address 0001
[ 19.658749] mmcblk0: mmc0:0001 hC8aP> 58.2 GiB
[ 19.665252] mmcblk0:
[ 19.665969] mmcblk0boot0: mmc0:0001 hC8aP> 4.00 MiB
[ 19.669411] mmcblk0boot1: mmc0:0001 hC8aP> 4.00 MiB
[ 19.672446] mmcblk0rpmb: mmc0:0001 hC8aP> 16.0 MiB, chardev (505:0)
[ 462.450194] sdhci-dwcmshc fe310000.mmc: Can't reduce the clock below 
52MHz in HS200/HS400 mode
[ 462.452168] I/O error, dev mmcblk0, sector 122142719 op 0x1:(WRITE) 
flags 0x800800 phys_seg 1 prio class 2
[ 462.453338] Buffer I/O error on dev mmcblk0, logical block 15267839, 
lost async page write
I have been testing on v7.1.3, and it is known good on v6.18.38.
As the error also occurs at startup, my thought is it could be an 
invalid value in
the device tree, possibly the 24MHz value in rk356x-base.dtsi:1085 ?
