Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C99339BFE7;
	Fri,  8 May 2026 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281854; cv=none; b=ZlvccArm7KOrI1h0P1IIW7De2+mDbJVc8kDJk491OzzbSDHAfXPoFnpu9FAPfTNZ2F0SH4l8QAbBPQrsJtaFZuf0lPHwhec8GhkD4fqxCdQV1xYxvZXeiGtW0tXanohRoS0u/dXGSjZZFQTjTflHKtcj+IVOun8YCtI1DtlI/zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281854; c=relaxed/simple;
	bh=ORUCAFTKRGtPG3yUupNBAwqRD7T186ukSAgBZG1/VzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9y/s6I4hLGEEb9qzQ5SFXNAXY8LzvORWiIwQ4kkhNsYtXb9yMjzuedVs4fG7tMN+/zdHvQrtyki601iJb0stkImXyI7FCnwC1MWO+Noy5xVdbErQQZKAcsdaZr+qjcGvlAWNj40515vnqxHYgoGNmcPX1HgXifCoT/w9eJtNCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bkp2tTvz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bkp2tTvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92092C2BCB0;
	Fri,  8 May 2026 23:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778281854;
	bh=ORUCAFTKRGtPG3yUupNBAwqRD7T186ukSAgBZG1/VzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bkp2tTvzxBQ1lw4TojOwbCxXjFn3apkpbGAlAAl5jjvRm5xLfk8ckS7o6lDCOr39s
	 e5KMX0cyLx1MfBiyzPyqTOYi1r+GROZMtblQykNNnLG8Sc7Rke17bGGU0WSCMOOgkh
	 vvKSYbgB6rBj2dIxILCpx7T865GFhyyO8Ry+4h0bP4QLSRliClw3wSMTcYiEOBpZTy
	 QU/NcDi+61hZwBCBbqYjZ/+0VouP5O7jGAxRW8AyPkL4KH/pG90FxoRht62WhY13N1
	 c95TPlVgYcd5XOOrLa8Di/sQ3bXfAqYENtWDfxaJftaR0PkggdRkpgSl5ICD2sZFab
	 Shn1Z4ZNkMdxA==
Date: Fri, 8 May 2026 23:10:51 +0000
From: Yixun Lan <dlan@kernel.org>
To: Iker Pedrosa <ikerpedrosam@gmail.com>,
	Troy Mitchell <troy.mitchell@linux.dev>
Cc: Margherita Milani <margherita.milani@amarulasolutions.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v8 8/9] riscv: dts: spacemit: k1-bananapi-f3: add SD card
 support with UHS modes
Message-ID: <20260508231051-GKC3590877@kernel.org>
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
 <20260413-orangepi-sd-card-uhs-v8-8-c21c40ec16d0@gmail.com>
 <CA+Xcp4nY9GVMOmtMG-PNhY2vqP4Cc_amAMSa+M3vuDjWUkuCHw@mail.gmail.com>
 <CABdCQ=OsPva9=YPdBd=3HW1OO7=_zJtpXjvaiA0WLEDT5Scs_Q@mail.gmail.com>
 <DICDTHYTPDSP.210EBVHTQ6966@linux.dev>
 <20260508225341-GKB3590877@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508225341-GKB3590877@kernel.org>


On 22:53 Fri 08 May     , Yixun Lan wrote:
> Hi Iker, Troy,
> 
..
> I would object to add CONFIG_I2C_K1 as hard dependency, the reason is
> that the spacemit sdhci driver (sdhci-of-k1.c) has no used i2c
> api/function, it's just need I2C function via an indirect requirement,
> which sdhci -> regulator(p1) -> i2c, besides, from the hardware design
> perspective, it just happens that K1 use P1(via I2C) as PMIC, it's
> totally possible(even in theory) to use other PMIC as power supply
> control which may not be I2C interface (maybe use SPI, for example)
> 
> If we want to solve this more gracefully, I'm in favor to add explict
> option enabled in defconfig..
> 
or I think it's better we do this way..

+++ b/drivers/i2c/busses/Kconfig
@@ -794,6 +794,7 @@ config I2C_K1
        tristate "SpacemiT K1 I2C adapter"
        depends on ARCH_SPACEMIT || COMPILE_TEST
        depends on OF
+       default ARCH_SPACEMIT


-- 
Yixun Lan (dlan)
