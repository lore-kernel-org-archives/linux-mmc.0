Received: from mail-m49201.qiye.163.com (mail-m49201.qiye.163.com [45.254.49.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5332326E16C;
	Fri, 30 Jan 2026 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769767788; cv=none; b=WkfT8oXsGWQBaznBdN4NN3OYMJsRDTnas1Yr7LhahU0JaO0cLOVnffUfRWuKH91G/29yNgwO73ruKUlc6eg2FI8DYZ0AssncAElM6wthFGwAUUz/UKvotdcC6ILM/h6wA+zTGcBino+cdP13rEcmQAblnBT5Uy66ISvYKpy3nTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769767788; c=relaxed/simple;
	bh=n1wZiyfMx8IVzYEySroLrCqNqngfCfq32/pkqb6D23M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIOt1dtD6XpeA2IJ58U3HhosAmW8FsNlYmCeH5/DqXuJiAloEMd9hbBxORvmgJBKTZJJWE4n9jNR5CZzl9Atd71/QrUSP27s+9UgVmKtCnXNsRDbh5gRfCrzLpB/MCO8mm5liJRC3x6xe2Xgc6j30uGdd3AXlj0ush78Ef1xW/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=UMuHSfAk; arc=none smtp.client-ip=45.254.49.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="UMuHSfAk"
Received: from albert-OptiPlex-7080.. (unknown [112.65.126.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 328f6f4d9;
	Fri, 30 Jan 2026 17:54:18 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ge Gordon <gordon.ge@bst.ai>,
	Arnd Bergmann <arnd@arndb.de>,
	BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] mmc: add support for BST C1200 SDHCI controller
Date: Fri, 30 Jan 2026 17:54:17 +0800
Message-ID: <20260130095417.2113714-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAPDyKFroOi-7Dir_H2fPX9Ne6zFeM4=XD0eMMrX+iJ_si1n2sA@mail.gmail.com>
References: <CAPDyKFroOi-7Dir_H2fPX9Ne6zFeM4=XD0eMMrX+iJ_si1n2sA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c0e532e3809cckunmaa8a7f704391b3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTxgdVh0ZTRpMGh9MHk9MSVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSklVTU5VSklNVUpNSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0
	tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=UMuHSfAk0aAdu1IEeRFzrjjsTO4tF2s6Mr3JysqxA/5Ua77xzrxshI/989J05RQqEDYScm/hFW4VTh+7jyioRGcQlAJ+TYZOBw5ogjv928dHxWM/zucPPjTafXmgM36L3kuhspp6+cAyIfXeLKSydnQdMZ0A7yE/0g+104mgxXw=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=n1wZiyfMx8IVzYEySroLrCqNqngfCfq32/pkqb6D23M=;
	h=date:mime-version:subject:message-id:from;

Hi Ulf,

On Tue, 27 Jan 2026 at 12:01, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Patch 1 to 3 and patch 6 applied for next, thanks!
>
> The DTS patches (patch 4 and patch 5) should be picked up by the SoC maintainer.

Thank you for the review!

I will send the DTS and defconfig patches (original v5 patches 4 and 5)
separately to the SoC maintainers as a v6 series.

Best regards,
Albert
