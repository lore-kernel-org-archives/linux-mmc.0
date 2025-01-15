Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3623F262;
	Wed, 15 Jan 2025 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930904; cv=none; b=r8LZdiTSScxKKvFZp+tXILoAU1cF6Idbam15qW+rXpmzZKgAGK1O/AWtBEKal8602CHZENsVpzmV0rYQA323N53IgZd/I3dTqmZHTFVLI5fE+AaMNpXJYZdBc6AvEzUtrEVXpgne0dwfuvnZ7mIF9hFbKQNdNVkIF0+3YbPID/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930904; c=relaxed/simple;
	bh=fOXw5fOyRt7kI5Izd5k38cCPtug2wf6DvlV5sjdUlDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spOfPGE2MaS5sexx95/FdwsjWvhgkX9EEaDRkPLSA+pzqMBX+wnucIYYvXEs/tsV/In3AEq5SS77iBh9JQ2JygvaN/YZGueXbcmHmd4XO4ZdRRitiaZ/6xBHezL0ohpWI1anXJuT7tBte+aZKFZg1th3FzoEF6+VP967WdxZrJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uA/vsMSI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uA/vsMSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3E7C4CEDF;
	Wed, 15 Jan 2025 08:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736930904;
	bh=fOXw5fOyRt7kI5Izd5k38cCPtug2wf6DvlV5sjdUlDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uA/vsMSIDCY6rLfEq8TQ9XgQbg1CNxSMkghiE6jRdMUYtJcHkF1jev4UFzq7RxlG5
	 cNy6+NTHnMzJ8cahf6NuzV1scc0AiA5IImn3W8FH2cC9L2+TF4LJk4RGTuODeQ04GN
	 UV6hqUrDAFlz0m8wSWNRkTiDgkvfJVgILHtSlLSA207CvmwPP9nk7ppwgRgGXrQzx4
	 1y5oFK+CUbvageMfCFni/T358jX5Eto7u7/iNTh4gsGy/gauNPGl0T+ZpJpG5vO1m4
	 i+MwtUQtv2o7Xqxi+EDCPTi+M9PGW6nSoDaD3MfGEDfpCkZx09G4TwN6anhG/uAkp4
	 JS1hd9D1/BJVA==
Date: Wed, 15 Jan 2025 09:48:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, 
	linux-mediatek@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mmc@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Wenbin Mei <wenbin.mei@mediatek.com>, 
	Conor Dooley <conor+dt@kernel.org>, upstream@airoha.com, Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mtk-sd: Add eMMC for AN7581
Message-ID: <dvt3zgjfliu22uyvxrmuteiet32gb5qdn2u6fh3xw6qp4xohw5@vwtkrgsh7asm>
References: <20250115073026.31552-1-ansuelsmth@gmail.com>
 <173693027082.3240418.16772447316188600820.robh@kernel.org>
 <67877449.df0a0220.cdd29.8807@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67877449.df0a0220.cdd29.8807@mx.google.com>

On Wed, Jan 15, 2025 at 09:39:34AM +0100, Christian Marangi wrote:
> > dtschema/dtc warnings/errors:
> > Error: Documentation/devicetree/bindings/mmc/mtk-sd.example.dts:104.31-32 syntax error
> > FATAL ERROR: Unable to parse input tree
> > make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/mmc/mtk-sd.example.dtb] Error 1
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1506: dt_binding_check] Error 2
> > make: *** [Makefile:251: __sub-make] Error 2
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250115073026.31552-1-ansuelsmth@gmail.com
> > 
> > The base for the series is generally the latest rc1. A different dependency
> > should be noted in *this* patch.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit after running the above command yourself. Note
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > your schema. However, it must be unset to test all examples with your schema.
> >
> 
> Hi Rob, I think this fails as the CLK define is still not merged as said
> this patch depends on bfe257f9780d8f77045a7da6ec959ee0659d2f98.
> 
> Any hint how to make your bot work with that?

Don't use the define, but raw number or just some fake phandle.

Best regards,
Krzysztof

