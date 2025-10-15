Received: from mail-m49219.qiye.163.com (mail-m49219.qiye.163.com [45.254.49.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421973090F7;
	Wed, 15 Oct 2025 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519412; cv=none; b=H2021DX9MfmuZw8jmMiuw3TiQlCpx8bWl2KnTk0h1VZN19dt1g3203yowA0OGBiTBLJWUmrg8VrubBXoPeToSUucmwARAXKw3k8BKFjvERrfBy2SNM83kEAxNczzC9n/HKW3Ny37kRA9ROybg8VrrG4XAwK7kLpXlICQvhuPwb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519412; c=relaxed/simple;
	bh=nuZmFFZW/qlUylipAljtu2d8WdxO4B/y/NQgH/4GKgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S10kou5whcdSMfSCQHwK7xWVCMCO8Xd/RA9FSq0IEWO0EJJgqUZsefDLs6QNBYGYS+NRIoJn9sdyWJgtUThQEJ+3Tv2OTvmFuNAr5Zf2CQMacOrsobK86LDl+En3XyeWjFB0vRth3tt1oIKipTtBCeWTxy1WYfOqax+SHrwC4d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=NvqHwAdo; arc=none smtp.client-ip=45.254.49.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="NvqHwAdo"
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 25fdef37e;
	Wed, 15 Oct 2025 17:09:58 +0800 (GMT+08:00)
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
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org,
	will@kernel.org,
	yangzh0906@thundersoft.com
Subject: Re: [PATCH 4/9] dt-bindings: mmc: add binding for BST DWCMSHC SDHCI controller
Date: Wed, 15 Oct 2025 17:09:57 +0800
Message-ID: <20251015090957.1533003-1-yangzh0906@thundersoft.com>
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
X-HM-Tid: 0a99e722245609cckunmf9bb21f3648025
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDS0tIVkseSR4ZHk9MS00fTlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=NvqHwAdolml55y1fUTrEj0qHhlhHQgcCkqahnTkmRYHXHyBk03moQBZe9JrtcpSekbNZ3CyajDUuNgcNASazasgbmEHdYiBch9Vb5GOEl3QVnXV1A/pGjqbj5gZs56MALY27qwSeGUVrYVJeFFF5LyuFtkbH8soiscEbnDnrEME=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=LKQbqU+sTp1fVknZcwtJ+snTmTwbzVT7SLAG891vDvM=;
	h=date:mime-version:subject:message-id:from;

Hi Rob,

Thank you for your review and feedback on v4!

On Tue, Sep 23, 2025 at 08:56:20AM -0500, Rob Herring wrote:
> On Tue, Sep 23, 2025 at 02:10:10PM +0800, Albert Yang wrote:
> > Changes for v4:
>
> Thanks for the changelog here, but the subject should have 'PATCH v4' so 
> various tools work.

Acknowledged. I'll ensure the subject line follows the correct format 
"[PATCH v5 X/Y]" in the next version.

> Filename should match compatible.

Agreed. I will rename the file from:
  bst,dwcmshc-sdhci.yaml
to:
  bst,c1200-sdhci.yaml

and update the $id field accordingly from:
  http://devicetree.org/schemas/mmc/bst,dwcmshc-sdhci.yaml#
to:
  http://devicetree.org/schemas/mmc/bst,c1200-sdhci.yaml#

> > +  clock-names:
> > +    items:
> > +      - const: core
>
> Not really any point in having -names when there is only 1 entry.> Not really any point in having -names when there is only 1 entry.

You're right. I'll remove the clock-names property and its entry from the 
required properties list.

> > +  memory-region:
> > +    maxItems: 1
>
> Having this is odd. Please add a description saying what it is for.
>> Having this is odd. Please add a description saying what it is for.

I'll add a description for memory-region:

  memory-region:
    maxItems: 1
    description:
      Phandle to a reserved memory region for DMA bounce buffer. The BST C1200
      SDHCI controller supports only 32-bit DMA addressing, while system memory
      may be located above 4GB address space.

Additionally, I've already corrected the example's compatible string from 
"bst,c1200-dwcmshc-sdhci" to "bst,c1200-sdhci" to match the property definition.

I'll prepare v5 with all the above changes addressed.

Best regards,
Albert Yang
