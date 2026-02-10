Received: from mail-m19731107.qiye.163.com (mail-m19731107.qiye.163.com [220.197.31.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB233327218;
	Tue, 10 Feb 2026 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724574; cv=none; b=Mc0gOfNkdcC7UhcL0umbg2HfQm3I9fsfnWfSygcPcvRw1w+EPOhS3t5IqBvKphtLb51KJWU9jh+D4m43Q4cLINdBTxojsCfQ4MsKirtcCyjV6+2xTq6giEZybU7FNcku2m7bjP0X321sEqBwaf5VijlzKYtdwz2sk2Yv00l2A5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724574; c=relaxed/simple;
	bh=Tn1yxxHX3XaL9Eit/j7IzXj+Vu4sydffCs/pe9X9oww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOfURa4f+0y71eL98Zy0iCmyteS6OdJHp5JEG33Eeg2tZqYz14YNygAv3yyKdjovQ34ApibbCVV4eTDMoLcAdBCoDMIeKMBZP4k6zi1EFF2OeNIYTcqhjhPqPAfaGzSbFAZCCxyUj66H2gaNZirpBP64ed0JPZTgn8xDMtvXnrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=Dd/RXPql; arc=none smtp.client-ip=220.197.31.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="Dd/RXPql"
Received: from albert-OptiPlex-7080.. (unknown [112.65.126.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 33be0945d;
	Tue, 10 Feb 2026 19:56:07 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: krzk@kernel.org
Cc: adrian.hunter@intel.com,
	arnd@arndb.de,
	bst-upstream@bstai.top,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gordon.ge@bst.ai,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	robh@kernel.org,
	ulf.hansson@linaro.org,
	yangzh0906@thundersoft.com
Subject: Re: [PATCH v5 5/6] arm64: defconfig: enable BST SDHCI controller
Date: Tue, 10 Feb 2026 19:56:06 +0800
Message-ID: <20260210115606.270000-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <93bff61b-ffc3-4b09-ac97-99f576e6d48f@kernel.org>
References: <93bff61b-ffc3-4b09-ac97-99f576e6d48f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c4768a8a609cckunm56c64d2736b8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQk9IVk9PSBlNT0weSklNGFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSklVTU5VSklNVUpNSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0
	tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=Dd/RXPqlOX5WnrutWKlnLu79gR1Tndka9KaC/J4akPCejzCdnVfB1Sb4vRcJ4SjhNHwNoch9Ko74te9rLzPayowwwKwEjylBa4bw9R4MZJzSCf617H6dLsXkBgAsanvJStWrXS/LrLQW6JkuySt/19W15a6jKyYAeqIwxgqIDus=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=0NWAU1Rgj+7j8yaUZF4MpiO+9Actr8LGdHetxcCk75c=;
	h=date:mime-version:subject:message-id:from;

On Sun, 8 Feb 2026 at 12:38, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 23/01/2026 10:53, Albert Yang wrote:
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 45288ec9eaf7..7f4da3117329 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -1222,6 +1222,7 @@ CONFIG_MMC_BLOCK_MINORS=32
> >  CONFIG_MMC_ARMMMCI=y
> >  CONFIG_MMC_SDHCI=y
> >  CONFIG_MMC_SDHCI_ACPI=y
> > +CONFIG_MMC_SDHCI_BST=y
> 
> This is still wrongly ordered. Look at your Kconfig. Run savedefconfig.

Hi Krzysztof,

Thank you for catching this again. Sorry for the repeated mistake.

I incorrectly placed CONFIG_MMC_SDHCI_BST right after CONFIG_MMC_SDHCI_ACPI,
but in Kconfig, MMC_SDHCI_BST is defined after MMC_SDHCI_BCM_KONA (much later
than MMC_SDHCI_ACPI). I have now run savedefconfig and confirmed the correct
position is between CONFIG_MMC_SDHCI_TEGRA and CONFIG_MMC_SDHCI_F_SDH30:

  CONFIG_MMC_SDHCI_TEGRA=y
 +CONFIG_MMC_SDHCI_BST=y
  CONFIG_MMC_SDHCI_F_SDH30=y

Will fix this in v6 along with the DTS patch, which will be submitted to
the SoC tree as per Ulf's direction.

Best regards,
Albert
