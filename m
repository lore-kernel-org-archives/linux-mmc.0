Received: from mail-m3269.qiye.163.com (mail-m3269.qiye.163.com [220.197.32.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A06320CAA;
	Wed, 15 Oct 2025 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512849; cv=none; b=h6zdn9C6lekLiyPr1uSybqcqzww47xNYKpoeo1KiJD/sH1z/VAZx9IjeZH+xrRR0HZIqVzrCtp3Gcfu1PpfnbM3zHplOtcDI71/HNZD2XKFdnr+vNv1Z/A+pfr/F1EuvFOudGE5mIQHz+Dljbgv3Cg7ffcQ+EdscW4EZQ6QEMPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512849; c=relaxed/simple;
	bh=xMVj9/+2Xo/AOfRErCyuIZTlTE51ez+ck2g2xXg5Jh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCbSqaXKklW6BjlY69LtQqujleyS1znxj4I9sM9tKNJR6qCRB2mlpX0P1iZz0JwSZhYwywrSkHWpfy7ASGoTMdL9pqcVDPqPJhRHJO9scVwRcfYfdFR9tN1BTDNWURWsYqyXSKzerTrDa42Gu4G+1htaixl3oYK9RWcqNCcl58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=i2a9NnKU; arc=none smtp.client-ip=220.197.32.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="i2a9NnKU"
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 25f9597c2;
	Wed, 15 Oct 2025 15:20:43 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: adrian.hunter@intel.com
Cc: yangzh0906@thundersoft.com,
	arnd@arndb.de,
	gordon.ge@bst.ai,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	robh@kernel.org,
	ulf.hansson@linaro.org
Subject: Re: [PATCH 6/9] mmc: sdhci: allow drivers to pre-allocate bounce buffer
Date: Wed, 15 Oct 2025 15:20:42 +0800
Message-ID: <20251015072042.1477680-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <acd73e05-fb8d-46f4-aa8e-e475685e5a18@intel.com>
References: <acd73e05-fb8d-46f4-aa8e-e475685e5a18@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99e6be1cfb09cckunmd9da6e9c619db7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCT0gaVkxDSU5IQ0xNTktLSVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=i2a9NnKUaiZL2LyovmcLFVjoLvJkuKj1F4wmGi5bQzuXPsbtEyWdh7L7OMN4lP8K6NjMws68kS92ZsFQiiETmOlSrz8nWfcKfJmvRTMGaVqRLCWudVQD/trB2C/g7XJ8OnNB+rNDrf87QVhfmW+cojptwp/YVQRA6tip2++Vehw=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=xMVj9/+2Xo/AOfRErCyuIZTlTE51ez+ck2g2xXg5Jh8=;
	h=date:mime-version:subject:message-id:from;

Hi Adrian,

Thank you for the review and the Acked-by!

On Mon, Sep 29, 2025 at 04:26:11PM +0300, Adrian Hunter wrote:
>
> This patch needs to come before patch 5 because patch 5 depends on it.
> Otherwise:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>

Understood. I will reorder the patch series in v5 to place this patch
before patch 5 to fix the dependency.

Thanks again for the feedback.

Best regards,
Albert Yang
