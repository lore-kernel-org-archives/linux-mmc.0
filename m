Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B5B1A5BA4;
	Wed, 11 Jun 2025 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654935; cv=none; b=kma3IL2kiJJJWbdlwiDUAHJVuVeB0UWfRMUkv+hPaH52I8mrLtEz+/TUDQ+pVISy58wlu6ZSqoeiBt3vk81zMX64j82qu7lbS7BFVymDXNDJilqPzVWKhWtzjb7sADIkCsX2k6vs7C/7BBow2gHpH9MMao/Kkv9AOHr21JVnmU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654935; c=relaxed/simple;
	bh=SkmWsUzdGujwGykgrZxaYqoTD2t/kuu5qyKPRe6ASK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HiFzgEm6tNk7VAijATwFrprK4Ca0XXMEZEdnNbeoPzxRfFZOLpt97dlGuqBXNfeGNRM/iGxUlDxLZ4iUnNBA56ID22xDwJwlRGMaW3OxZvmOe5CFJ+8EvDSPPdP6sxJUlvYeYGapBikXWllkpLjUoiSzMz+ARXshcJGEk195qnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost.localdomain (unknown [116.232.147.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id E9846340824;
	Wed, 11 Jun 2025 15:15:27 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: spacemit: enable eMMC for K1 SoC
Date: Wed, 11 Jun 2025 23:15:07 +0800
Message-ID: <174965447661.1611186.10400081292030756093.b4-ty@gentoo.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523-22-k1-sdhci-v1-1-6e0adddf7494@gentoo.org>
References: <20250523-22-k1-sdhci-v1-1-6e0adddf7494@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 23 May 2025 21:21:04 +0800, Yixun Lan wrote:
> Enable eMMC support for SpacemiT K1 SoC, successfully tested on
> Bananapi-F3 board which shipped with a 16GB eMMC chip - KLMAG1JETD-B041.
> 
> 

Applied, thanks!

[1/1] riscv: dts: spacemit: enable eMMC for K1 SoC
      https://github.com/spacemit-com/linux/commit/37df56ac500222384d6a6a13c69c489e01fb686c

Best regards,
-- 
Yixun Lan <dlan@gentoo.org>
