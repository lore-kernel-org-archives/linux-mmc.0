Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A6947AF43;
	Thu, 24 Sep 2026 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251319; cv=none; b=mMGRzgPQyrqxlhGkWoq9BggmgpXhXx20kzvgPJQXWv/kctVeoWrz25bnZ/iPeesEnb90kDuFLBJfm3rEjFsrwjam+qCpMWH5WImSfnSZWfQe073FsxJLdwoBHXHZ0hY0HfaUA5pi32+bGqSn+ZbxWcHjs7Qq0Q/Ppx+JIAMVtPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251319; c=relaxed/simple;
	bh=jBOrgiMFEpstulATdM5kh+vQxQ2R3XKn97EH6342f2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSkg6IpgY1evZAY231A5HYuDQeqlYTYKOnVqmL+PGu86j3CFjbt6uKTwynDgW2u265XJ39NHMEI23+IqGaOz34XpCtrXbVW0gtekj0n3u7C9WFaVmrcVXYISlbr7nkD/vfsC2uXK2nNbUfDRHez4byhAYtvKC1xdcROJ+p+h+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcC8tR+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcC8tR+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CC71F000FF;
	Thu, 24 Sep 2026 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790251317;
	bh=ugFVTFUZKd5DVbiFq8MFmNC7p3Vw3V7eXLUNAr7Xrzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UcC8tR+Dnm8H+8AkV+jljM/p7Y7E18cp3wvRbeGfxEtru/jDq516lJFUhQAK2mWsr
	 3J0oFeXSiP3tZl4SikYimTGqohXk4X/9VJ5PbtTBoeRh4Cpv1wk8UPflo3qFOk8czF
	 ea91bH/UlQn5sh+CH6r5y+M7XN529diQVJqrjikLueU385jF3vb4sEZqFhmO3qSmkM
	 9GCoRTwlh3UbVZz8chWUU/P4gNIGgRrNluRimNeAH7YDrvnlm7pbBykKSMK2qEAlyJ
	 I6bPbCuZzveqV5INxddEBKTsw6Fwn8l1101mCN2XANaATnFPGBlEzUUmj/3xe66Neg
	 /Y4bVcwkB4n8g==
Date: Thu, 24 Sep 2026 14:01:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Chen Wang <chen.wang@linux.dev>, 
	Jisheng Zhang <jszhang@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v1 1/2] dt-bindings: mmc: snps,dwcmshc-sdhci: Add
 starfive,jhb100-dwcmshc
Message-ID: <20260924-truthful-uppish-porpoise-d3de6c@quoll>
References: <20260919092950.178617-1-changhuang.liang@starfivetech.com>
 <20260919092950.178617-2-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919092950.178617-2-changhuang.liang@starfivetech.com>

On Sat, Sep 19, 2026 at 02:29:49AM -0700, Changhuang Liang wrote:
> Add compatible string "starfive,jhb100-dwcmshc" for the StarFive
> JHB100 SoC.
> 
> The JHB100 controller uses three clocks (core, bus and cclk_tx) and a
> single reset, so relax the common resets/reset-names minItems from 4
> to 1 and add a dedicated conditional schema for the JHB100 compatible
> that constrains the clocks, clock-names, resets, reset-names and the
> required starfive,jhb100-per1-syscon property. The property describes
> the phandle to the PER1 SYSCON and the offset of the register holding
> the upper DMA address bits [35:32] of the eMMC DMA address, used to
> extend the default 32-bit DMA capability to 36-bit.
> 
> Also rework the existing if/else blocks so that the JHB100 compatible
> is excluded from the branch that requires the extra resets, while
> keeping the same constraints for the other SoCs.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 74 ++++++++++++++++++-
>  1 file changed, 70 insertions(+), 4 deletions(-)
> 

We are probably on the verge of readability of this binding, with
multiple if:then:else and quite some combinations.

Code looks correct, though I think we should for the next variant split
it per each device with some common binding.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

