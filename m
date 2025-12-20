Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7C8242D83
	for <linux-mmc@vger.kernel.org>; Sat, 20 Dec 2025 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766270712; cv=none; b=QO4wNOmMmC7YPIJeSUoR4ymmtPjwPkV+idLBp2Oi6E5Q8ppVdgbWPP6LYQ91YERZtb7hsdpGYwqIlzEKcsNxj+z1mSNUKGN2hwRRBJn2fNXUCZrRfWWOO5lr+eb1Bzza/LgMs1497gt3CtPZWRm+nWRqJCsshnZyxp12ys3lfVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766270712; c=relaxed/simple;
	bh=1l3b4MIIjaNK3gvp8YpwG4zWCsJJLiV+E1lWvV1WUO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ePqHkZ0bM5rbNUQX4yuNQiiBgIM9pz+Du+it+ctRnefPhGsd6wdZBlD96OfLYYKOxU5WxlaeGKUTCrQs0aLBAvdT7L8D6t4Qxnl6jeNtcbIQXpskh+nW2b68vcfS3sFKoQV8pW68+I8fNcM/+T0vW8kYjPNYbMob8ZA9UJWDp8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sd/uPzGY; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sd/uPzGY"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251220224458euoutp02cbf91ba2516888ff3e9314090e4e6b7b~DDdeUev3y3119231192euoutp02u
	for <linux-mmc@vger.kernel.org>; Sat, 20 Dec 2025 22:44:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251220224458euoutp02cbf91ba2516888ff3e9314090e4e6b7b~DDdeUev3y3119231192euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766270698;
	bh=+HOU1xRSRnAFm8eF6nEtxbEIW2jhBTbQCfSS2xBDpiw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=sd/uPzGY/7N2fnbGtwOpkw2ulbEXj2QMs33ihYA49kPLOjsADJSdlqMv1IDyJjYYy
	 77khYvm7eS08uuYyI9a1red0Acp9eveva8YG9WRqdWp00uqoEwHOny+jUPzGIRblQA
	 GhFPGsgabUZ3I99Fq4bLsOMZyZQEQftoLnI2w81I=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251220224457eucas1p2ef6f1b3dfa76fcfb37b2856c178bf8df~DDddN4t-h1686116861eucas1p27;
	Sat, 20 Dec 2025 22:44:57 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251220224456eusmtip1afe429645c272fe704d5dd3886b4f1f5~DDdcjStSB2475224752eusmtip1K;
	Sat, 20 Dec 2025 22:44:56 +0000 (GMT)
Message-ID: <4707cf10-19e2-4253-8cc0-019eb0b83c95@samsung.com>
Date: Sat, 20 Dec 2025 23:44:56 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 2/2] mmc: dw_mmc: Remove struct dw_mci_slot
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <1766208126-42506-2-git-send-email-shawn.lin@rock-chips.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251220224457eucas1p2ef6f1b3dfa76fcfb37b2856c178bf8df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251220052224eucas1p18941ee450d7e8a0d0834f3f1d4f7bdf9
X-EPHeader: CA
X-CMS-RootMailID: 20251220052224eucas1p18941ee450d7e8a0d0834f3f1d4f7bdf9
References: <1766208126-42506-1-git-send-email-shawn.lin@rock-chips.com>
	<CGME20251220052224eucas1p18941ee450d7e8a0d0834f3f1d4f7bdf9@eucas1p1.samsung.com>
	<1766208126-42506-2-git-send-email-shawn.lin@rock-chips.com>

On 20.12.2025 06:22, Shawn Lin wrote:
> Use dw_mci_alloc_host() helper to allocate struct dw_mci for dw_mmc-pci.c
> and dw_mmc-pltfm.c. With that, we could get rid of struct dw_mci_slot and
> remove it everywhere.
>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Works fine on my Exynos based tests boards.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>
>   drivers/mmc/host/dw_mmc-pci.c   |   7 +-
>   drivers/mmc/host/dw_mmc-pltfm.c |   7 +-
>   drivers/mmc/host/dw_mmc.c       | 227 +++++++++++++++++-----------------------
>   drivers/mmc/host/dw_mmc.h       |  19 +---
>   4 files changed, 103 insertions(+), 157 deletions(-)
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

