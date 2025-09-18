Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5155A2F5A2E;
	Thu, 18 Sep 2025 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229789; cv=none; b=O/KMwxxknMmW2CEbVc4pBXbdV65X3Dd9MqR1PiPCpy5t+XkrLCPanZNpZkmTyTRYSS+I0dm5r6cOMXzD2eFuakWCNPysMPZxD9+MYCIFNirdwzGi9Qf/CwPNzS2yBTo3kDkG9v0/T1+OGLeQnSxQJ2AKmvlLaufo+b4wD1Hvdpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229789; c=relaxed/simple;
	bh=mn+HGNeSXOxkQbHesF3j5T+ziS67TL3+xgDi50urA2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bL4Q00tDr2BgemCQROIZGH/DF2pFRJ7Qc3XYQKnDcXpwQlQSGhKm1Pk8GxyMyNhjk1KWUAf9APdD8o197AxZm00xT10DWcs3P7+oWkURpcsccGZFTllxs7gABxy8un/xlNDgoxcIlw00bHzd+8vHlCdgqSCs/deTc58D74/J5yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=tJOavz3M; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="tJOavz3M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=S8xxkZ0i81uYRniosEUc93s/XZExd8jIygi5IB68BPU=; b=tJOavz3MFs8g/xuyfoqDitqQnG
	/Jn5kuyKafJO5cDER2D0DCF5rzDMMs2y2K3sF+n20TyznunnFkI8GpXdrimcqGS88BUxlLf4JCsUx
	riBxxxrP+QhH/oFjQpNmc2q9rOWqbzMC4gzxzsF82HW1PxK81MAlDPmvsMk6Zlv5ZLzQjnGu44Vqj
	fzv/eiGlU+XwmSU15Ry3RErCi85/npMeWdb1PpY3TR0b48WMJcd+jMOqsNj/LylsYdLlIbCLRkTPC
	ttG4vdt4pHBsuDM0GSKuOTCmha8GYe7J3NA9iKh1fiGMpntliBc6cvqdvpOYy2a6WVyzrfATkahwi
	AENWM5Hg==;
Received: from i53875b0a.versanet.de ([83.135.91.10] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uzLsj-0003SC-N9; Thu, 18 Sep 2025 23:09:33 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-mmc@vger.kernel.org,
	Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	adrian.hunter@intel.com,
	victor.shih@genesyslogic.com.tw,
	ben.chuang@genesyslogic.com.tw,
	geert+renesas@glider.be,
	angelogioacchino.delregno@collabora.com,
	dlan@gentoo.org,
	arnd@arndb.de,
	zhoubinbin@loongson.cn
Subject: Re: [PATCH v2 1/2] arm64: select ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
Date: Thu, 18 Sep 2025 23:09:21 +0200
Message-ID: <175822973684.1568500.2874531983654815490.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250912084112.2795848-1-mikko.rapeli@linaro.org>
References: <20250912084112.2795848-1-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 12 Sep 2025 11:41:11 +0300, Mikko Rapeli wrote:
> On rk3399 based rockpi4b, mounting rootfs from mmc fails unless
> ROCKCHIP_PM_DOMAINS is enabled. Accoriding to
> Heiko Stübner <heiko@sntech.de> all SoCs since 2012 have power
> domains so the support should be enabled by default.
> 
> Failing boot without CONFIG_ROCKCHIP_PM_DOMAINS=y:
> 
> [...]

Applied, thanks!

[1/2] arm64: select ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
      commit: aff3de3b9a597763bec5d1c56c11b56fb2613085
[2/2] ARM: rockchip: select ROCKCHIP_PM_DOMAINS
      commit: 47c9bfdf7376e8b1842699b064ae3b052e2c3c1b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
