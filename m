Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81225A357;
	Thu, 26 Mar 2026 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774529622; cv=none; b=LyPbAnRa4uolJom1HX2CYmshzx1krYPAYVZMqJM6z5lX/TFOOL0nhcMsuzkiKs6ikSYqnPQCnPhbbrwH2VXmNcqxl1G+/kmBjr/a40cr6yK30Fe7FAZQ601rj1xY1/3kiQzB20L4JKKmy2XFHc3OoRw2VlZSVxPN+GLrw3a77Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774529622; c=relaxed/simple;
	bh=Q0nmFsxr4p9N2+JQyG7ZUpExeR9GG19RsZcJvYw9ToQ=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=FJiFqcbQAj0Lx1PtOCFCUWKygbB4/gxsnU/KL/NKo+n88vLLdkzstdASu226/yNvSEwg8exfbtwzzDNnG+vEU/YoG1Wvz65/cWaUobJc7A4Ps54jIAO6nQbFzo9e2An0xXXgOn4W8n1cqLTghKxezL9+B1XRJ8n9UnQQl026qpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2Nmqg6ZT; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2Nmqg6ZT"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JwogkyK17K7R1DHebXs4/gznNtvqRuSbgYVa8bTbTWw=;
	b=2Nmqg6ZTsKKjro7kmOWyBVibO0nBQkaqUnm9ilMsy0af15aRRP+pa13Cux862kZSbGNSDpaHN
	x4UFKzd7OsgjItBbcJ7p5JXaPGpyo4/05nsIAqAOy2xSITbopiMvo+msJNSHtBtqx249Z7bHfjQ
	0qlx3xHW4hpnSk/QztlJAFk=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fhNpN6Hkzz1K9Cc;
	Thu, 26 Mar 2026 20:47:24 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D6C0140563;
	Thu, 26 Mar 2026 20:53:28 +0800 (CST)
Received: from kwepemq100003.china.huawei.com (7.202.195.72) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Mar 2026 20:53:28 +0800
Received: from [10.67.113.213] (10.67.113.213) by
 kwepemq100003.china.huawei.com (7.202.195.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Mar 2026 20:53:28 +0800
Message-ID: <69C52C47.2030001@hisilicon.com>
Date: Thu, 26 Mar 2026 20:53:27 +0800
From: Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Bhargav Joshi <rougueprince47@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <zhangfei.gao@linaro.org>,
	<linux-mmc@vger.kernel.org>, <daniel.baluta@nxp.com>, <simona.toaca@nxp.com>,
	<d-gole@ti.com>, <m-chawdhry@ti.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] mmc: hisilicon: Convert dw-mshc bindings and fix
 dtbs
References: <20260325225439.68161-1-rougueprince47@gmail.com>	<69C51640.8070408@hisilicon.com> <CAPDyKFq6F3PZgqTtHXZPQPPBvdPhsQPtUVHiZV6X-QXvS42+CA@mail.gmail.com>
In-Reply-To: <CAPDyKFq6F3PZgqTtHXZPQPPBvdPhsQPtUVHiZV6X-QXvS42+CA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq100003.china.huawei.com (7.202.195.72)

Hi Uffe,

On 2026/3/26 20:39, Ulf Hansson wrote:
> On Thu, 26 Mar 2026 at 12:19, Wei Xu <xuwei5@hisilicon.com> wrote:
>>
>> Hi Bhargav,
>>
>> On 2026/3/26 6:54, Bhargav Joshi wrote:
>>> This series converts the Hisilicon dw-mshc text bindings to DT schema
>>> format and cleans up legacy node names in Hisilicon board files.
>>>
>>> While testing the new YAML schema, dtbs_check flagged the hi3660,
>>> hi3670, and hi6220 SoC files for using the non-standard 'dwmmc' node
>>> name prefix. resulting in warnings.
>>>
>>> Patch 1 Convert to DT schema
>>> Patch 2 updates the Hisilicon dtsi files to use standard 'mmc'
>>> node name.
>>>
>>> Changes in v2:
>>>  - Patch 1:
>>>     - Grouped compatible strings into an enum.
>>>     - Replaced raw numbers with proper flags.
>>>     - Fixed property order and removed invalid hex values.
>>>     - Added explanation for clock order change in commit message.
>>>     - Collected Acked-by tag.
>>>  - Patch 2:
>>>     - No code changes.
>>>     - Collected Acked-by and Reviewed-by tags.
>>>
>>> Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
>>> ---
>>> Note: this patch is part of the process for applying to GSoC device
>>> tree bindings conversion project #
>>> https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings
>>>
>>> - The file is enabled by arm64 defconfig (CONFIG_MMC_DW_K3=y)
>>> - It is used in following
>>>     /arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>>>     -included by /arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
>>>     /arch/arm64/boot/dts/hisilicon/hi3670.dtsi
>>>     -included by /arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
>>>
>>> Bhargav Joshi (2):
>>>   dt-bindings: mmc: hisilicon,hi3660-dw-mshc: Convert to DT schema
>>>   arm64: dts: hisilicon: Rename dwmmc nodes to mmc
>>>
>>>  .../mmc/hisilicon,hi3660-dw-mshc.yaml         | 117 ++++++++++++++++++
>>>  .../devicetree/bindings/mmc/k3-dw-mshc.txt    |  73 -----------
>>>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi     |   4 +-
>>>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |   4 +-
>>>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi     |   6 +-
>>>  5 files changed, 124 insertions(+), 80 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/mmc/hisilicon,hi3660-dw-mshc.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>>>
>>
>> Series applied to the HiSilicon arm64 dt tree.
>> Thanks!
>>
>> Best Regards,
>> Wei
> 
> Usually I pick DT bindings (patch1/2) for mmc via my mmc tree and I
> also just did. Would it be possible for you to drop patch1/2 from your
> tree?

So I will drop them.
Thanks!

Best Regards,
Wei 

> 
> Kind regards
> Uffe
> 
> .
> 
