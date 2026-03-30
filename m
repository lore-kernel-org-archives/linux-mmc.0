Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9D43AE6FA
	for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2026 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861885; cv=none; b=IRV4CR09H2KPSULAgwdh//YjdovXTOaCIo6C3v+pv57pcdXhHZEoxeLS80gghV4j55+TbPABv2mqgC44IV4f7exKYqaF81J3dPUkX+wG781geL2GhOMPYCkHU4/b+o4XzqnvG9xeJP3VthcMRJJAD0h0jcoLfKzC0yZKoy9xgss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861885; c=relaxed/simple;
	bh=6zmpLy0QOmVh5AXq4LxSNCRv2qdkcVSDutpQ27Vq4ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWzssmOfrFdSYTLha9OgqdQyxy10pHhHGyQq2OFzLIeO8uNlogqpuHk2GOE95Io9yZ1a6IOGTXRq9Qyp1+5OmfAX1dirtFD+znVlSBuiZmAJJfR93tnqBApZxQfMJEOtdJmC+a+B4lC0zyAPumbJIVDO5G5y9vYLyRO4jiJ5E04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LqTHpS3O; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LqTHpS3O"
Date: Mon, 30 Mar 2026 17:11:09 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774861881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWLL1ngJTwQYwWnnu+CvoNT76JVvFYBiVINVvbGMfIs=;
	b=LqTHpS3Oy8BE0FVueb0+OHKZbGIzEIAXz/ujG5sEIXVN1V7nvBUViVznOfte/SHGMNMtiW
	+F2FkUKLqtfkLudR9xNPOI/J2hEeDfEMZB64Ef0LSBUjhLFoylMdCt9B93lqr7U62ffDuf
	lPpbhVfPpXC1GUl9MYoC2/zkjR+brJw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.dev>
To: Iker Pedrosa <ikerpedrosam@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Troy Mitchell <troy.mitchell@linux.dev>
Subject: Re: [PATCH v5 2/9] mmc: sdhci-of-k1: enable essential clock
 infrastructure for SD operation
Message-ID: <aco-LZmy7iTTFG9v@kernel.org>
References: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
 <20260330-orangepi-sd-card-uhs-v5-2-bd853604322d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330-orangepi-sd-card-uhs-v5-2-bd853604322d@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 30, 2026 at 16:38:03 CST, Iker Pedrosa wrote:
> Ensure SD card pins receive clock signals by enabling pad clock
> generation and overriding automatic clock gating. Required for all SD
> operation modes.
> 
> The SDHC_GEN_PAD_CLK_ON setting in LEGACY_CTRL_REG is safe for both SD
> and eMMC operation as both protocols use the same physical MMC interface
> pins and require proper clock signal generation at the hardware level
> for signal integrity and timing.
> 
> Additional SD-specific clock overrides (SDHC_OVRRD_CLK_OEN and
> SDHC_FORCE_CLK_ON) are conditionally applied only for SD-only
> controllers to handle removable card scenarios.
> 
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
