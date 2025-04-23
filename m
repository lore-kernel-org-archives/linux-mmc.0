Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5458D28A40F;
	Wed, 23 Apr 2025 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423719; cv=none; b=eI5V6q4vg04j5ejMDFY1RVpdK6ib25hq/kVoueb+y9ETMQwnowpnwYtvgjcpDuuwjZn/aq4mJfp7G4s/Wa/zgyVZXTfKJ7Ld6PVrbPw1WK9Oq2h1ZamnCx/ff5HA3zznj3uURKzCVVh1CPOfhtzLI3WWzaulbh0s38rlmj9QNCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423719; c=relaxed/simple;
	bh=A/JbmNFtiekFMU17Tr7eADwSvSKXMsVykZ17Vq2oUnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8GRyCclOsAgGRyhH7/Nqe2N+Zhl7Wzl+40wL7HUXuyWGVGY1Q4jDNwVM1v/Eg50FHVBsc5gKeCiE0Dl2TT9OCYW1SssKxNfcD1k77YvbDjqaPD2lgjejomgMQIV9UUP4iTDM5I6uwYCIkhLyx9XtXQvSiuBWxvGJ/B32YnjW14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQll1ySt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQll1ySt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4F3C4CEE2;
	Wed, 23 Apr 2025 15:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745423717;
	bh=A/JbmNFtiekFMU17Tr7eADwSvSKXMsVykZ17Vq2oUnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tQll1yStHKhTaR4zdvp1Egn9CiTLoyK0QwNCsg+lODX9vRHTlby75pgxQ7RYZnmBz
	 Ia+4p8llQPRG8162UsYv1YuHogzK8mdLPltMsszNlDtNVfuYckw9sb6xsOsdGqtVaN
	 maFCB9opni+OJctVEsMTktj9LS15CoS7TCmybasjoCo+F76Dgn183Pj4840gKRWCZ2
	 0wAPQ1cLgfGSm9gvArRJbtmPqUqfRufgAG6tybfMFZT9I7xF84xH0nf+d8i+zkD468
	 n8HrrtWN5HTpu/aazWKW1DM3VXABQiDizV/as14RZd4zO8eyB8WYxJNdIVeaBzh08a
	 JLNQsQRJhni3w==
Date: Wed, 23 Apr 2025 10:55:16 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: linux-mmc@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mmc: vt8500-sdmmc: Convert to YAML
Message-ID: <174542371550.599081.5723331661512709392.robh@kernel.org>
References: <20250423-vt8500-sdmmc-binding-v2-1-ea4f17fd0638@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423-vt8500-sdmmc-binding-v2-1-ea4f17fd0638@gmail.com>


On Wed, 23 Apr 2025 14:53:29 +0400, Alexey Charkov wrote:
> Rewrite the textual description for the WonderMedia SDMMC controller
> as YAML schema, and switch the filename to follow the compatible
> string.
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> Split the series from v1 into separate bindings patches so as not to
> spam all the subsystems with unrelated changes, per Rob's suggestion
> 
> Changes in v2:
> - described the sdon-inverted property in greater detail (thanks Rob)
> - dropped the hunk that updates MAINTAINERS for easier merging - will
>   be updated later in a single pass to cover all VT8500 related files
> 
> Link to v1: https://lore.kernel.org/all/20250416-wmt-updates-v1-3-f9af689cdfc2@gmail.com/
> ---
>  .../devicetree/bindings/mmc/vt8500-sdmmc.txt       | 23 --------
>  .../devicetree/bindings/mmc/wm,wm8505-sdhc.yaml    | 66 ++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 23 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

