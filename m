Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0EE30CDA1
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766082229; cv=none; b=UYh6HUF3us63HAfoCjbVxqpRlaaNFkP0UXxhMjNcv2Db7I/aydDTLPYr8zFi74gQANlJG/m2ARiRVhnA9N3Ek9/gruYriyMdPhBM3IE4q8J7AWfVqIreUbocwyr5syIld7GTOcemIhIhacEsKZEw7VOwGTpMREhOhvk8zeKWFBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766082229; c=relaxed/simple;
	bh=4Vbbhfnwr61064okpxAWRk+LE/6YKSq8V65W+B+aPiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=J3CKR+b7aSSFOpitXINnwipIrsTGJ5Byhk0zHxJFbZwp7MhqaGQj402sTd2p1VlwzZV9s36658u/e9KZuwPwvHdCGJ6+jwsgYMhPIGgf6ew4tMY3sL+rl81kHRwSKyfnNcS5qJf+0Sd38AfCMCWs2bxl99+sdmUNcelno2G874A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DdNeheBM; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DdNeheBM"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251218182343euoutp02787b92e1b1aeb439116c0285fb54cf4d~CYmzshpzG3180131801euoutp02F
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 18:23:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251218182343euoutp02787b92e1b1aeb439116c0285fb54cf4d~CYmzshpzG3180131801euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766082223;
	bh=jCr+tvSOjLIxUfqNp2HAh4MAw0pWzJp9NfrHTJJHQE4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=DdNeheBMDmvQswcCHqXaF3W0AVUmMHi5IS76dwV39BlrYcTu6FwJKIJJv9cT/owZo
	 QSWTvXDqti5CEDb1l8JX8XBn6XlTIAlo/85vtC2BDZzjx7QeSnt6NYR1TWuQNkUWhF
	 bySL7U91ideslpe+rH0s3f3Sw+1ufljyEmqOwR9E=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251218182343eucas1p2d8e8c97da2f3abdecd0a2f54b06c10cf~CYmzV5nqk2545425454eucas1p2f;
	Thu, 18 Dec 2025 18:23:43 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251218182343eusmtip2504877b1d58fd318c7878a070249d613~CYmy8v6WG0717707177eusmtip2e;
	Thu, 18 Dec 2025 18:23:42 +0000 (GMT)
Message-ID: <75e28c6b-c62c-4c84-9b88-6bc8902b8c5b@samsung.com>
Date: Thu, 18 Dec 2025 19:23:42 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 12/12] mmc: dw_mmc: Remove struct dw_mci_slot
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>,
	'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <1765885807-186577-13-git-send-email-shawn.lin@rock-chips.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251218182343eucas1p2d8e8c97da2f3abdecd0a2f54b06c10cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251218182343eucas1p2d8e8c97da2f3abdecd0a2f54b06c10cf
X-EPHeader: CA
X-CMS-RootMailID: 20251218182343eucas1p2d8e8c97da2f3abdecd0a2f54b06c10cf
References: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
	<1765885807-186577-13-git-send-email-shawn.lin@rock-chips.com>
	<CGME20251218182343eucas1p2d8e8c97da2f3abdecd0a2f54b06c10cf@eucas1p2.samsung.com>

On 16.12.2025 12:50, Shawn Lin wrote:
> This patch sets struct dw_mci as mmc_host's private data by
> copying struct dw_mci passing to dw_mci_probe() in order to
> achieve with mminimal changes. Then we remove slot everywhere.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

This patch landed in today's linux-next as commit 926311cf3361 ("mmc: 
dw_mmc: Remove struct dw_mci_slot"). In my tests I found that it breaks 
DW-MMC driver operation on Hardkernel's Odroid-HC1 board. This is a bit 
strange, as it works fine on other, similar, Exynos5422 based Odroid 
boards. On Odroid-HC1 no MMC card is detected at all after this patch. I 
briefly checked the code and I don't see anything suspicious besides 
this host vs. local_host structure copying... Reverting $subject patch 
on top of linux-next fixes this issue.

> ---
>
> Changes in v3: None
> Changes in v2:
> - Fix dma_set_mask_and_coherent mistake by code rebase
> - fix compile warning
>
>   drivers/mmc/host/dw_mmc-pltfm.c |   2 +-
>   drivers/mmc/host/dw_mmc.c       | 250 ++++++++++++++++++----------------------
>   drivers/mmc/host/dw_mmc.h       |  22 +---
>   3 files changed, 120 insertions(+), 154 deletions(-)
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

