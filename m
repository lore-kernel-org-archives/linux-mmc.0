Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32CE38C430;
	Thu, 26 Mar 2026 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523984; cv=none; b=TOhLqhtSns7yEJ6lLJ2RZmxW4uMRSeIZHVYso2SwBX/tLlHR7NLpVLvSFmF80y0/i1inXYNSvEmZJ4QjNDot25e78t/8z7EdYNE+WFXPY2MrAkKbM7eW04PasMGpMU53XFmGoMExqCPui5QOMSwIfqnJIJqsu7YbvpeUJg+4fNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523984; c=relaxed/simple;
	bh=5zWpjUiosTsBLXN9TPN/TysyeBthI/0455XUGFFlDcc=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=tp1KnaMpWTo5fyQkZuj0osO+D76KBzx5tpiUyEkHJEpu3hmm7T0jGfJIKgGZONS3/aM3nvq3DrVWW4AzG+Y8zqRmmjOLAqVtYS7eOsd+pXB/uEjX77ONOL+PlKO15gy8sL3ksIXHDmn0jWyErvQvgdwHJx1tzl3XVwRT+danms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PqfD5wy9; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PqfD5wy9"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4eUbyrBQrZeyw3b/k/SDrTACodn8YBSMmYKpGCCfH9E=;
	b=PqfD5wy934jLNLeuXyaaOLg1+NyOaHiHgYF2LSoav3XafE3peWSUj2uOnPF8hsW/eYKyKuIHB
	5/KMAFgPcTmA6XJp+T7F8S82XOXNdfs6CQzyraZDnhcdH+dqpo7V67PYgw8rXtt9iqY99o2hes/
	oZm+auom9IW5mWJazjO8v/8=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fhLkf6WRjz12LGC;
	Thu, 26 Mar 2026 19:14:02 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id A396C2025E;
	Thu, 26 Mar 2026 19:19:29 +0800 (CST)
Received: from kwepemq100003.china.huawei.com (7.202.195.72) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Mar 2026 19:19:29 +0800
Received: from [10.67.113.213] (10.67.113.213) by
 kwepemq100003.china.huawei.com (7.202.195.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Mar 2026 19:19:28 +0800
Message-ID: <69C51640.8070408@hisilicon.com>
Date: Thu, 26 Mar 2026 19:19:28 +0800
From: Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Bhargav Joshi <rougueprince47@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <ulf.hansson@linaro.org>,
	<zhangfei.gao@linaro.org>, <linux-mmc@vger.kernel.org>
CC: <daniel.baluta@nxp.com>, <simona.toaca@nxp.com>, <d-gole@ti.com>,
	<m-chawdhry@ti.com>, <linux-kernel@vger.kernel.org>, <xuwei5@hisilicon.com>
Subject: Re: [PATCH v2 0/2] mmc: hisilicon: Convert dw-mshc bindings and fix
 dtbs
References: <20260325225439.68161-1-rougueprince47@gmail.com>
In-Reply-To: <20260325225439.68161-1-rougueprince47@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq100003.china.huawei.com (7.202.195.72)

Hi Bhargav,

On 2026/3/26 6:54, Bhargav Joshi wrote:
> This series converts the Hisilicon dw-mshc text bindings to DT schema
> format and cleans up legacy node names in Hisilicon board files.
> 
> While testing the new YAML schema, dtbs_check flagged the hi3660, 
> hi3670, and hi6220 SoC files for using the non-standard 'dwmmc' node 
> name prefix. resulting in warnings.
> 
> Patch 1 Convert to DT schema
> Patch 2 updates the Hisilicon dtsi files to use standard 'mmc' 
> node name.
> 
> Changes in v2:
>  - Patch 1: 
>     - Grouped compatible strings into an enum.
>     - Replaced raw numbers with proper flags.
>     - Fixed property order and removed invalid hex values.
>     - Added explanation for clock order change in commit message.
>     - Collected Acked-by tag.
>  - Patch 2: 
>     - No code changes.
>     - Collected Acked-by and Reviewed-by tags.
> 
> Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
> ---
> Note: this patch is part of the process for applying to GSoC device
> tree bindings conversion project #
> https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings
> 
> - The file is enabled by arm64 defconfig (CONFIG_MMC_DW_K3=y)
> - It is used in following
>     /arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>     -included by /arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
>     /arch/arm64/boot/dts/hisilicon/hi3670.dtsi
>     -included by /arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> 
> Bhargav Joshi (2):
>   dt-bindings: mmc: hisilicon,hi3660-dw-mshc: Convert to DT schema
>   arm64: dts: hisilicon: Rename dwmmc nodes to mmc
> 
>  .../mmc/hisilicon,hi3660-dw-mshc.yaml         | 117 ++++++++++++++++++
>  .../devicetree/bindings/mmc/k3-dw-mshc.txt    |  73 -----------
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi     |   4 +-
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |   4 +-
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi     |   6 +-
>  5 files changed, 124 insertions(+), 80 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/hisilicon,hi3660-dw-mshc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> 

Series applied to the HiSilicon arm64 dt tree.
Thanks!

Best Regards,
Wei
