Received: from mail-m19731109.qiye.163.com (mail-m19731109.qiye.163.com [220.197.31.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1777469D;
	Fri, 11 Jul 2025 05:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752213342; cv=none; b=jh6fzMuX4CS3FRzS4/9ruf3sO1Xucv/pp1KaCZNkutegh96JGviGg/wu4YGuGqgwq0lgiSzsRXX+JfUpw9Uo8rmqrz7bhH3x7MZ8dzJAgR96krO9/W2gWsBbYbABiPDivqi0G6J2g2nxQh6jppHIxKZHJb2JPM7Wfjubau/1oQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752213342; c=relaxed/simple;
	bh=ryT+XYho9bF/4V/++q4QOBHcZEKXqBVzYUTq/yWVWaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PAgptQOTZ5bTsd6rTe34TVWo2EMn+y9ITdCOBGhQZAp1oB59TeLXhaXxgHwCNvxwLF1+e+R4F6QqLmZHSk2guIPvxhRl3PnqYan+cIX/4a040sJdK5E2+Wy4s4jl65hvEismnxBEHMA33uWwZJlWWNweWJcSoX1W+3MV3+1QjmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=krqTzltB; arc=none smtp.client-ip=220.197.31.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="krqTzltB"
Received: from localhost.localdomain (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1baa85b36;
	Fri, 11 Jul 2025 13:55:30 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: arnd@arndb.de
Cc: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	gordon.ge@bst.ai,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver
Date: Fri, 11 Jul 2025 13:55:29 +0800
Message-Id: <20250711055529.1321072-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <53ba18c1-4554-4d77-84fd-d921febb7559@app.fastmail.com>
References: <53ba18c1-4554-4d77-84fd-d921febb7559@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSUNCVh5NGR9CGh4fTUlOSFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSk
	tLVUpCS0tZBg++
X-HM-Tid: 0a97f80d995609cckunm40278df013f2e34
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OEk6Fgw5SzExDRgeMkgZQ1YL
	QhEKChVVSlVKTE5JSUpISEhKT0hJVTMWGhIXVQIaFRwBE0tCS007DxMOFR8eCQgUHQ9VGBQWRVlX
	WRILWUFZSkpMVUpDT1VKSUJVSkhPWVdZCAFZQU5JSk83Bg++
DKIM-Signature:a=rsa-sha256;
	b=krqTzltBSK6R8iO/sIkcsNNJtF/9LFNZ9dkm/hq5CACZ1JSLnmPlXtlG6uCV6TNuEByyvVwJKIH1CJxcDIIwVACnPPb2aLgXMADuelG3Mgm8IEgCFSq5FiwpeWjHS4FcaeBR0tigl7KlKkue+Eog6X/TZ+0rxGylLjymKlj5fqo=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=8JI3v8SEkCUiC8EaufkNhA7P5YwSp0PygxDPJd1s0z8=;
	h=date:mime-version:subject:message-id:from;

Hi Arnd,

Thank you for your detailed review and suggestions. I have addressed all the 
issues you raised in v2 of the patch series.

On Wed, Jul 2, 2025, at 11:44, Arnd Bergmann wrote:

> The description does not mention the actual device it's for
> but only DesignWare.
> 
> Try to keep this sorted alphabetically between the other
> CONFIG_MMC_SDHCI_* backends

Fixed. Updated the Kconfig description to mention "Black Sesame Technologies 
BST C1200 controller" and moved the config entry to the correct alphabetical 
position between MMC_SDHCI_BCM_KONA and MMC_SDHCI_F_SDH30.

> You are only using the first member here, the phy_crm_reg_base
> and phy_crm_reg_size are assigned during probe but not referenced
> later. devm_platform_ioremap_resource() should help simplify
> that code further.

Agreed. Removed the unused phy_crm_reg_base and phy_crm_reg_size fields from 
dwcmshc_priv structure and replaced the manual platform_get_resource() + 
ioremap() calls with devm_platform_ioremap_resource().

> You always pass priv->crm_reg_base into this helper, so
> it would be simpler to make it take the sdhci_pltfm_host
> pointer and the offset instead of the address.

Good suggestion. Replaced bst_write_phys_bst() and bst_read_phys_bst() with 
bst_crm_write() and bst_crm_read() that take sdhci_pltfm_host pointer and 
offset parameters for better encapsulation.

> The comment says 64K, but the size you use is 32K.

Fixed the comment to correctly state 32KB.

> Having an explanation here makes sense, but I don't think this
> captures what is actually going on, in particular:
> 
> - dma_alloc_coherent() being backed by an SRAM that is under
>   the 4GB boundary
> - the problem that the SoC is configured that all of DRAM
>   is outside of ZONE_DMA32
> - The type of hardware bug that leads to 64-bit DMA being
>   broken in this SoC.

You're absolutely right. I've enhanced the comment with a detailed explanation 
of our specific hardware constraints:

1. System memory uses 64-bit bus, eMMC controller uses 32-bit bus
2. eMMC controller cannot access memory through SMMU due to hardware bug
3. Our SRAM-based bounce buffer solution works within 32-bit address space

> I still have some hope that the hardware is not actually
> that broken and you can get it working normally, in one
> of these ways:
> - enabling 64-bit addressing in the parent bus
> - enabling SMMU translation for the parent bus
> - configuring the parent bus or the sdhci itself to
>   access the first 4GB of RAM, and describing the
>   offset in dma-ranges
> - moving the start of RAM in a global SoC config

I appreciate your optimism about finding alternative solutions. Unfortunately, 
we have thoroughly investigated these approaches:

Regarding these last two suggestions, I'm not very familiar with the implementation 
details. Could you provide more guidance on:

1. **dma-ranges approach**: We tried adding these properties to the device tree:
   ```
   dma-ranges = <0x00000000 0x00000000 0x100000000>;
   dma-mask = <0xffffffff>;
   ```
   However, we still encounter DMA addressing issues. Are there specific 
   examples in other drivers we could reference for similar hardware constraints?

2. **Moving RAM start position**: Which component would control this configuration? 
   Would this require bootloader parameter changes or SoC-level configuration?

We're certainly interested in exploring these alternatives if they could provide 
a more elegant solution than our current bounce buffer approach.

The v3 patch addresses all your code structure and documentation concerns 
while providing a clear explanation of why this approach is necessary for 
our platform. I have also fixed compilation warnings about unused variables 
that resulted from the refactoring.

**Current DMA Issues**: Despite setting DMA32_ZONE, we still encounter DMA 
addressing warnings. Key error messages include:
```
DMA addr 0x00000008113e2200+512 overflow (mask ffffffff, bus limit 0)
software IO TLB: swiotlb_memblock_alloc: Failed to allocate [various sizes]
```

This confirms our hardware limitation where the eMMC controller cannot access 
memory above 32-bit boundaries, even with ZONE_DMA32 configured.

The complete kernel log with detailed DMA allocation failures and warnings
is available at: https://pastebin.com/eJgtuHDh

Please let me know if you need any additional information or have suggestions
for alternative approaches.

Best regards,
Albert
