Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF633337BAA
	for <linux-mmc@vger.kernel.org>; Mon, 26 Jan 2026 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769433734; cv=none; b=txyu4VJ+VNWgm4gQY9AqiqSnYRWu8KACvCENiGQISquZRgZ7KCbvz7jLpwaXN/UhTIxlQEdENBxvATzWiUVT/IqlAmxdavBJJ0KxCnGAfohXYAPT664f3LTIJcl8bY+rhE4tTp8o3oRc5Ylo4fI7PXl4BxM5Toifo+1eB+oBz6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769433734; c=relaxed/simple;
	bh=U+c8ZIwYNnuckjMqVW4HlV5hWVmaBY/Xta2VJXaum2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=NxSAc2JiFbwxDzpHs2doQCbfSrZwSOqKDBY6f6gp384y9QyRyjav2pcGVU8fobPPm0iOjaZqmp47RqQBQLY4j7Q5sZJFLLkDxLf/E7pduGrtzLknVSHC24q7x+W5g6IhQNwUQoKrJLQ3jrpo+5NLVgqel1duNpZgqlgeUk2YFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XvsFw5L7; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XvsFw5L7"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260126132210euoutp013a355736b7040d53cd358321d2615134~OSppEnLHZ0808808088euoutp01F
	for <linux-mmc@vger.kernel.org>; Mon, 26 Jan 2026 13:22:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260126132210euoutp013a355736b7040d53cd358321d2615134~OSppEnLHZ0808808088euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769433730;
	bh=MtEdSqzHCkU44IqpH+pElriHyb8dI7mu/rz9KfZ7Xjc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=XvsFw5L7/1wtcNRdbXBCFF8flA7IaajvENoWupGkRSoDh4XQAUgn9/3JzfKQ2FgKO
	 Cq8tP0+7ldaSAJJZagpQ43IWJgF6vD5AS1W11C/yi0dF1AOoRQAwO2ACQ9kUr4U9Zf
	 0BQx4bH3vKm77NEtpVpFRNF/9F4Gq5fXf7gogy98=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260126132209eucas1p17cd332f56bbe6aa2f168d50b44626ebe~OSpo7Gr172605726057eucas1p1M;
	Mon, 26 Jan 2026 13:22:09 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260126132209eusmtip1e9a1ed8dad458fec5a76506423258c88~OSpoq-Ne33000630006eusmtip1s;
	Mon, 26 Jan 2026 13:22:09 +0000 (GMT)
Message-ID: <55a29373-fe1f-4628-9e0e-e1ade3a64edd@samsung.com>
Date: Mon, 26 Jan 2026 14:22:09 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2 15/18] mmc: dw_mmc: Remove check before calling
 mmc_regulator_set_vqmmc()
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <1767665829-183001-16-git-send-email-shawn.lin@rock-chips.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260126132209eucas1p17cd332f56bbe6aa2f168d50b44626ebe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260126132209eucas1p17cd332f56bbe6aa2f168d50b44626ebe
X-EPHeader: CA
X-CMS-RootMailID: 20260126132209eucas1p17cd332f56bbe6aa2f168d50b44626ebe
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
	<1767665829-183001-16-git-send-email-shawn.lin@rock-chips.com>
	<CGME20260126132209eucas1p17cd332f56bbe6aa2f168d50b44626ebe@eucas1p1.samsung.com>

On 06.01.2026 03:17, Shawn Lin wrote:
> The vqmmc regulator is acquired as optional via devm_regulator_get_optional().
> The helper function mmc_regulator_set_vqmmc() currently returns -EINVAL when
> vqmmc is not present. This patch justifies why this error code is acceptable
> within the dwc driver's usage context.
>
> The function is invoked in two scenarios:
> 1. In mmc_set_initial_signal_voltage(): The return value is ignored, so
>     returning -EINVAL is harmless.
> 2. In mmc_host_set_uhs_voltage(): This higher-level UHS voltage setting
>     procedure should not be attempted if the vqmmc regulator is not available
>     in the first place. Thus, signaling an error is the correct behavior.
>
> In both call paths, returning -EINVAL for a missing optional regulator
> does not introduce regressions.
>
> So this patch removes the check and still returns error to the core, instead
> of zero, if vqmmc isn't present.

Unfortunately this change, merged recently to linux-next as commit 
9157b7f91ed6 ("mmc: dw_mmc: Remove check before calling 
mmc_regulator_set_vqmmc()"), introduces a regression: it breaks probing 
of the built-in eMMC storage device on Samsung Exynos3250 based Rinato 
board (arch/arm/boot/dts/samsung/exynos3250-rinato.dts). In the kernel 
log there are only a few lines about EINVAL error:

dwmmc_exynos 12510000.mmc: IDMAC supports 32-bit address mode.
dwmmc_exynos 12510000.mmc: Using internal DMA controller.
dwmmc_exynos 12510000.mmc: Version ID is 260a
dwmmc_exynos 12510000.mmc: DW MMC controller at irq 65,64 bit host data 
width,128 deep fifo
mmc_host mmc0: card is non-removable.
mmc0: error -22 whilst initialising MMC card
mmc_host mmc0: Bus speed = 50000000Hz (req 100000Hz, actual 100000HZ div 
= 250)
mmc0: error -22 whilst initialising MMC card
mmc0: Failed to initialize a non-removable card

It looks that the vqmmc regulator is optional and eMMC chip can switch 
to HS without changing the (optional) regulator voltage. Without this 
patch the mmc0 is probed properly on this board:

mmc_host mmc0: card is non-removable.
mmc_host mmc0: Bus speed = 50000000Hz (req 400000Hz, actual 396825HZ div 
= 63)
mmc_host mmc0: Bus speed = 50000000Hz (req 52000000Hz, actual 50000000HZ 
div = 0)
mmc_host mmc0: Bus speed = 100000000Hz (req 100000000Hz, actual 
100000000HZ div = 0)
mmc0: new HS200 MMC card at address 0001
mmcblk0: mmc0:0001 F5X5MA 3.64 GiB
mmcblk0boot0: mmc0:0001 F5X5MA 4.00 MiB
mmcblk0boot1: mmc0:0001 F5X5MA 4.00 MiB
mmcblk0rpmb: mmc0:0001 F5X5MA 512 KiB, chardev (244:0)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

