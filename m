Received: from mail-m1973172.qiye.163.com (mail-m1973172.qiye.163.com [220.197.31.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1442472BB;
	Fri, 26 Sep 2025 03:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758856900; cv=none; b=uxmDxlHlH1YrW3Urdbrb8+iwtVrcnmOkEVlbq2JZMW/0mF00cDwYygFunQDZXjLbIBA//7soM9lxCJ9LwyUERmj2El9Lu5lwgrkAeZ5ZqIiUQNuJsWCKjw+Vs5DYESNgrprKDj4TGY+Zw65RhK+is4XOhME1LsOOlTpTOPPSSwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758856900; c=relaxed/simple;
	bh=DJsF5euwhkf3WaZfxtcysZHH8vcnA8vTzkP8Xorfrkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELaExYxaT9yoLxsiKg6m/8nRBnZsINR41y4i7/umbPGB3Ths/vZMkaebM4Pu8CnFBoTebfFfFDle0wnrQLOjdyxAS2GF8fcWr2+tijXN6wV8CpUDjU/PiicLipR/TOEeIc05f8Ik1Yo5TjRfsdpeRu81Q6pZ87oK7Dt4JJQ1WFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=e88RQ4qI; arc=none smtp.client-ip=220.197.31.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="e88RQ4qI"
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 241ea83c5;
	Fri, 26 Sep 2025 11:06:09 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: robh@kernel.org
Cc: adrian.hunter@intel.com,
	arnd@arndb.de,
	bst-upstream@bstai.top,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gordon.ge@bst.ai,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org,
	will@kernel.org,
	yangzh0906@thundersoft.com
Subject: Re: [PATCH v4 4/9] dt-bindings: mmc: Add Black Sesame Technologies DWCMSHC SDHCI
Date: Fri, 26 Sep 2025 11:06:08 +0800
Message-ID: <20250926030608.2951582-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135620.GA3119392-robh@kernel.org>
References: <20250923135620.GA3119392-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9983fc398209cckunmb335c2cb8db69e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTBoeVhlMGk0ZTRodQ0JDTFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=e88RQ4qIHmc+kYFzbklCrM0t2AxXMrqOhSc8K7MwuUbv1RswqVZoh3rjsy4f1eSnpuYFBbQnpM29auwmHpAjznO53ylvcGgvRZ0B92pASS/x4f6BT/4tazqluJf0c3Np77Bj6qcy5ngSMd0qOYYs/mmHvR1mIClKTurBrblMUIQ=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=KKLV4+58bTG8VBls3155eUBifK8pZ1zD59z4H998/Xg=;
	h=date:mime-version:subject:message-id:from;

On Tue, Sep 23, 2025 at 08:56:20AM -0500, Rob Herring wrote:
> On Tue, Sep 23, 2025 at 02:10:10PM +0800, Albert Yang wrote:
> > Add device tree binding documentation for the Black Sesame Technologies
> > (BST) DWCMSHC SDHCI controller.

Hi Rob,

Thanks for the review.

> Thanks for the changelog here, but the subject should have 'PATCH v4' so
> various tools work.

Understood. Will ensure v5 has the proper subject format with 'PATCH v5'.

> Filename should match compatible.

Fixed. Renamed from bst,dwcmshc-sdhci.yaml to bst,c1200-dwcmshc.yaml 
to match the compatible string "bst,c1200-dwcmshc", and updated the 
$id field accordingly.

> Not really any point in having -names when there is only 1 entry.

Agreed. I've dropped clock-names from the schema, DTS, and removed it 
from required properties.

> Having this is odd. Please add a description saying what it is for.

Added description for memory-region: "Reserved memory region for bounce 
buffer. Required due to controller's 32-bit DMA limitation while system 
RAM is above 32-bit addressable range."

Updated example:

    mmc@22200000 {
        compatible = "bst,c1200-dwcmshc";
        reg = <0x0 0x22200000 0x0 0x1000>,
              <0x0 0x23006000 0x0 0x1000>;
        interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
        clocks = <&clk_mmc>;
        memory-region = <&mmc0_reserved>;
        max-frequency = <200000000>;
        bus-width = <8>;
        non-removable;
        dma-coherent;
    };

Please let me know if you have any other concerns or suggestions for 
this binding. I'll send v5 with these fixes.

Thanks,
Albert Yang
