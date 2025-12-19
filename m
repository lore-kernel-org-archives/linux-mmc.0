Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B232D32E730
	for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2025 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766145584; cv=none; b=ERVpot5sHct5w4Rs0WKIdmFWHN1XfGs1nhr8bOzCEUdK7ifdRchmCccTJWsIZB45EPMxokfomBwwrD4AwNeS0M52ra4iUeQmaBPB2GxaZrTFM3Yx0z5waXgvxf2TH4NuoXXluSPp04kUFjHNh4gGccmoi2tHVSOruiaoc8PkHwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766145584; c=relaxed/simple;
	bh=2x8uXSwF/10VcLJv3HHYtx4R4qj0QGLNxZGn+WAJwEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=aA3KYNuuJLhVHFHoGE6HlyBWSePzvL4soGKgsKa1UUz94RxlcZdJYqpG21X7unnpaUuY8xkt4VDUYwxBPN777FuUZeytdQTgtCBfzYhC5Ia3aT4XDRejXW63Q/5rnGTYP0eFXjXWslGJv2j+gSr2ZbgbC/AXMVRgvtWDsW8+pQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rciGHjxj; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rciGHjxj"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251219115931euoutp02a1d84f48418011c0667ad256d66b09b9~CnApB-DKy1060210602euoutp02l
	for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2025 11:59:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251219115931euoutp02a1d84f48418011c0667ad256d66b09b9~CnApB-DKy1060210602euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766145571;
	bh=2c+C6hTEHY4fUro2+YtzIUkJbBqe++RHHrWBWXSc4pU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=rciGHjxjgrx3zh/fO2+gk5vi8UAx4Xp/ghxYqrwR2iz74Cf+B87AE4DW0l2coKZwf
	 jtE+kgUpE6RmLVuX+T7GiSRxwOJewAoqqtx7f9oV1O+CdyaUYlIcdx7/ha89KW4/V3
	 nywc37LqXEZJfHATr0AUJGjjGb5XHrgRsszNyTmI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251219115931eucas1p2c8a664e7ea74074aa057df93fa9e89ae~CnAoxyc4h1691316913eucas1p28;
	Fri, 19 Dec 2025 11:59:31 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251219115930eusmtip14d96bf4d67c06d2ab66c8cf83f17152e~CnAoTlhax1818118181eusmtip1P;
	Fri, 19 Dec 2025 11:59:30 +0000 (GMT)
Message-ID: <9af391bb-b607-481e-9d12-35b892469a06@samsung.com>
Date: Fri, 19 Dec 2025 12:59:30 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 12/12] mmc: dw_mmc: Remove struct dw_mci_slot
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>,
	'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <dbee3e27-d158-43d3-88ca-a9f3a3264af7@rock-chips.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251219115931eucas1p2c8a664e7ea74074aa057df93fa9e89ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251218182343eucas1p2d8e8c97da2f3abdecd0a2f54b06c10cf
X-EPHeader: CA
X-CMS-RootMailID: 20251218182343eucas1p2d8e8c97da2f3abdecd0a2f54b06c10cf
References: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
	<1765885807-186577-13-git-send-email-shawn.lin@rock-chips.com>
	<CGME20251218182343eucas1p2d8e8c97da2f3abdecd0a2f54b06c10cf@eucas1p2.samsung.com>
	<75e28c6b-c62c-4c84-9b88-6bc8902b8c5b@samsung.com>
	<dbee3e27-d158-43d3-88ca-a9f3a3264af7@rock-chips.com>

On 19.12.2025 02:47, Shawn Lin wrote:
> 在 2025/12/19 星期五 2:23, Marek Szyprowski 写道:
>> On 16.12.2025 12:50, Shawn Lin wrote:
>>> This patch sets struct dw_mci as mmc_host's private data by
>>> copying struct dw_mci passing to dw_mci_probe() in order to
>>> achieve with mminimal changes. Then we remove slot everywhere.
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> This patch landed in today's linux-next as commit 926311cf3361 ("mmc:
>> dw_mmc: Remove struct dw_mci_slot"). In my tests I found that it breaks
>> DW-MMC driver operation on Hardkernel's Odroid-HC1 board. This is a bit
>> strange, as it works fine on other, similar, Exynos5422 based Odroid
>> boards. On Odroid-HC1 no MMC card is detected at all after this patch. I
>
> Sorry for breaking Odroid-HC1 board. Indeed, it's strange other
> Exynos5422-based bards work fine, as this patch wasn't supposed to be
> board depend, even SoC depend. Looking closely again, still have no
> idea what is happening on Odroid-HC1. I have no Odroid-HC1 board to
> debug, could you kindly help applied the attached debug patch and
> share the log?  Thanks.

I've played a bit with that code and the $subject patch breaks 
propagating -EPROBE_DEFER from mmc_regulator_get_supply(). This fixes 
the problem:

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 8a0362257a2c..6be95a440ee9 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3428,6 +3428,7 @@ int dw_mci_probe(struct dw_mci *host)
         local_host = dw_mci_init_host(host);
         if (IS_ERR(local_host)) {
                 dev_dbg(host->dev, "host init failed\n");
+               ret = PTR_ERR(local_host);
                 goto err_dmaunmap;
         }

BTW, the $subject patch also lacks fixing drvdata in dw_mmc-pci.c.

I think it would make a bit sense to simply pass dev, pdata, regs, irq 
and flags as parameters to dw_mci_probe() instead of the second copy of 
the dw_mci structure. Or alternatively move these to the additional 
structure and pass a pointer to it.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

