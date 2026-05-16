Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60289224F3;
	Sat, 16 May 2026 02:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778900228; cv=none; b=Viw3VSlV8QMkemagsijFY26TSc9PFjIpLd5SKkHZppghOdETLLubomphsl9LH8uIzLUCBrMv6+atgTLZ7VfFP2K2GUkC+d5uLpGQDZ4YlnwhiBSC1QGaVrUEtpvOsfjZpoJPqxsXPPVCOMH5vTF76ma5xnqe/KnptXXPWso601o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778900228; c=relaxed/simple;
	bh=M6nGzuhtuydJTS24X+joMHBqfjHReQnk/JS+UtPAYmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7XVq5y9mAHeVoOmBN3o1/OCcj25Uf+vMHf2uIsqlkw4f5UTu6iiCDimwnYDRpcP6AnAAOvIwyFZNWk++JxABLwSw0FWUupV4AjT9qAxYASpQOQ7bjYhdFgyHU9lJvCmqfT4JzL4jg+HIs+45SCDeedVJpd0o4NpwR3YplrU83U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQj0ikvA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQj0ikvA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258BDC2BCB0;
	Sat, 16 May 2026 02:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778900228;
	bh=M6nGzuhtuydJTS24X+joMHBqfjHReQnk/JS+UtPAYmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQj0ikvAvGebOjidCeb4lbqYeg8nWzV8uPsr0sQVf3ecOhvzKxj98lVehAxGLs1c5
	 51IWimbv16mI2OvpE9Q15vyhAg2Pu2g3PVUHLImA6Pz6xLGojlP5/f2Gh0kWWhGt0l
	 pg0b8R38jUAt26+e+4xjtGctsO9kyUkG+DQyLeexwd4O1oLT2maxfcfgTLWJAHCWfT
	 4zpzx+Cxaq8uFzLbVsYPDtdDQcQGcIvqEtN6AGw4XvEijH7ed1SqcCznvoCsHvvz0m
	 n44CEczj0bsaAoin7ZIS0jwy38kxzSmdO5DRs5k9a/5uXack3vocg9bK2zDodzqqwA
	 Ug82cbfcDkJIw==
From: Yixun Lan <dlan@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Ulf Hansson <ulfh@kernel.org>,
	Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.dev>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Anand Moon <linux.amoon@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Vincent Legoll <legoll@online.fr>,
	Margherita Milani <margherita.milani@amarulasolutions.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Andre Heider <a.heider@gmail.com>
Subject: Re: (subset) [PATCH v10 0/4] riscv: spacemit: enable SD card support with UHS modes for OrangePi RV2
Date: Sat, 16 May 2026 02:57:00 +0000
Message-ID: <177889984452.2298656.1074391459031404894.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515-orangepi-sd-card-uhs-v10-0-094af27e310d@gmail.com>
References: <20260515-orangepi-sd-card-uhs-v10-0-094af27e310d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 15 May 2026 12:48:58 +0200, Iker Pedrosa wrote:
> This series enables complete SD card support for the Spacemit K1-based
> OrangePi RV2 board, including UHS (Ultra High Speed) modes for
> high-performance SD card operation.
> 
> Background
> 
> The Spacemit K1 SoC includes an SDHCI controller capable of supporting
> SD cards up to UHS-I speeds (SDR104 at 208MHz). However, mainline
> currently lacks basic SD controller configuration, SDHCI driver
> enhancements for voltage switching and tuning, and power management
> infrastructure.
> 
> [...]

Hi Iker,
I've picked patch 1-3, for [4/4] I think it should be merged after
https://lore.kernel.org/all/20260513071958.29574-1-a.heider@gmail.com/

Applied, thanks!

[1/4] riscv: dts: spacemit: k1: add SD card controller and pinctrl support
      https://github.com/spacemit-com/linux/commit/2d77e577109967ef65f269c1fc1d6a659d4260fb
[2/4] riscv: dts: spacemit: k1-orangepi-rv2: add SD card support with UHS modes
      https://github.com/spacemit-com/linux/commit/2585c60ce2f977b13f14a67d1e3ed9c73fd7f381
[3/4] riscv: dts: spacemit: k1-bananapi-f3: add SD card support with UHS modes
      https://github.com/spacemit-com/linux/commit/c76e2f058cbcab84e4a703f26857a58bdf6a0042

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
