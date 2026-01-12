Received: from mail-m49219.qiye.163.com (mail-m49219.qiye.163.com [45.254.49.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B64F500948;
	Mon, 12 Jan 2026 01:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768181584; cv=none; b=b18jTDswPgkzQvzh8FzPPQBI0VsANmB5goR3elafUNdZgUUuzquv497nZe2CbFUrZdfCOT6LX2eN1VrMmK4rODR+JCvU/ziMscPjhbniHQpNaQGural/A6nK/6MmbHnIlXrJLJ/k+PZZ4p0v+YwZv0h975yCTsp2Sd8YZLnuS3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768181584; c=relaxed/simple;
	bh=c4D4qRzclAUj5sU9Caw7MiY/vn0gUcs4DEL5srx7uCM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VJq1+EE3EaEHnExff3PgjOxQvbDutoxfpoq6m5FGASbzBICGenU9qZWfDqT3LJ+RqOeQYVkMjxXkEGlYA6OcH5tx5U82fnSShWDLni9KRLKDlexq6AB0CttzilGtUFfvpBGF0wl4TCzrAauwPp8sZIBihWlk9jM154aNDs50tiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=PUZD15TF; arc=none smtp.client-ip=45.254.49.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="PUZD15TF"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 303f0cc91;
	Mon, 12 Jan 2026 09:32:50 +0800 (GMT+08:00)
Message-ID: <67ccb8f6-f9bd-4266-b79a-b688bd6d030b@rock-chips.com>
Date: Mon, 12 Jan 2026 09:32:49 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-rockchip@lists.infradead.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, heiko@sntech.de, ulf.hansson@linaro.org
Subject: Re: [PATCH v1 0/3] mmc: dw_mmc-rockchip: Add stability quirk for
 NanoPi R76S
To: Marco Schirrmeister <mschirrmeister@gmail.com>
References: <20260110010715.1610159-1-mschirrmeister@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260110010715.1610159-1-mschirrmeister@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bafd59c4509cckunm6b904c3425d9cd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0tKT1ZCGRgYH0hLHk0aT0NWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=PUZD15TFeHoo8gN2FFcDZ0avYlYQF5N7lfZAwZgerD57WM3N5NA8XTpdqiJRjcb7D8eXVbJPTrA+FaewvgoG9ZQn0n2ULA0ibPRhxksTlN7ilOpGtu4kLuykrxjWWvQPZNVq5SBZ0bWdp0ftlx2a+0N++WEODvAFbfRU+wKrCQ0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=/coguvbuQJ6Lc8S2lu4ggKAcKXnFx/f9Jnk8AsJys3k=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/10 星期六 9:07, Marco Schirrmeister 写道:
> This series addresses a microSD stability issue on the FriendlyElec
> NanoPi R76S (RK3576). The board currently suffers from a 400kHz
> retuning loop when the controller attempts to enter runtime-suspend
> during idle periods.
> 
> Evidence of the failure in dmesg:
> [Fri Jan  2 01:28:02 2026] mmc_host mmc1: Bus speed (slot 0) = 400000Hz
> [Fri Jan  2 01:28:03 2026] mmc_host mmc1: Bus speed (slot 0) = 198000000Hz
> [Fri Jan  2 01:28:03 2026] dwmmc_rockchip 2a310000.mmc: Successfully tuned phase to 233
> [Fri Jan  2 01:28:04 2026] mmc_host mmc1: Bus speed (slot 0) = 400000Hz
> 

Does this problem happen with all microSDs or just *a* microSD per
your description?
Have you ever tried to disable SDR104 support?

> Testing confirmed that the issue can be manually addressed by
> disabling runtime PM via sysfs:
> echo on > /sys/devices/platform/soc/2a310000.mmc/power/control
> 
> I experimented with various changes in the Device Tree, including
> lowering the bus frequency and attempting to keep the power domains
> active, but nothing stopped the retuning loop.
> The issue only went away when I forced the controller to stay active
> by disabling the runtime power management.
> 
> This quirk is the only way I have found to keep the SDR104 link from
> crashing on the NanoPi R76S, I am open to suggestions if there is
> a better way to handle this in the driver or the DTS.
> 
> Marco Schirrmeister (3):
>    dt-bindings: mmc: rockchip-dw-mshc: add rockchip,disable-runtime-pm
>    mmc: host: dw_mmc-rockchip: add rockchip,disable-runtime-pm quirk
>    arm64: dts: rockchip: add stability quirk to NanoPi R76S
> 
>   .../bindings/mmc/rockchip-dw-mshc.yaml        |  8 ++++++
>   .../boot/dts/rockchip/rk3576-nanopi-r76s.dts  |  1 +
>   drivers/mmc/host/dw_mmc-rockchip.c            | 25 ++++++++++++++++---
>   3 files changed, 31 insertions(+), 3 deletions(-)
> 

