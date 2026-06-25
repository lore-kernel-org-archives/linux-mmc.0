Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29185334C3D;
	Thu, 25 Jun 2026 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782372674; cv=none; b=rob3i8dw2GrXN+ofgY406ZJPw75yvDHIb1kdind+mZhWq51bQN+7tqw+08jr8brV4gZlJIkxEj8OtftlJajjquEcAP5ZVDindX5YkICiJ1CcXvjwKH7tuMUGaOPs77l43hpVF2YmUBPaOMGaGyk3s8HzHxFkxftnKBGEhN5Gn6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782372674; c=relaxed/simple;
	bh=rjmokHLwOy3JjQ5YkQoKb+kA8OIJkILRD/da9HzifhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foqdSl7PIzUgX1ufhcAJMe0NNyuNGMd4Xv7gh3H6SzvAuh42xXvkyLMcp+tRrnwVjxrpG+ZDKelVOuFzCvyQNzMwSdHy+T03ILjBYlMAja1wwOS7EnjInEBLnpr/FHymG2UbAAhB7l0HkJLp6CkDPxOOoz6pjgv4iRvk/UBE+1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvN3wV5f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvN3wV5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDAC1F000E9;
	Thu, 25 Jun 2026 07:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782372672;
	bh=iTdgDtuDpWr7AZp5mL8mSgm2cdzH6KfxrYrYV/lUhcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JvN3wV5fYIiCDsuufP63fxm9UNwZijgAlezZig5SRdOeCBc7VIVkQDaAd3NKrSMRu
	 Tx3PYZ2qw3Tgj5HGraNHhkDOZfq0JKHSC2oz+WkskvxWnLsafxtDo5PSXMjJcnzhoI
	 V+t4xf+yZVHGW1eYa2KoKf5QJWXIgIUbNkO1xH5oaDX+u61ruy/yjjNXgJAVWmQXrB
	 cr7JouuX0gBdqe2QdHuPa3dU22ebv6KRJBcdDMIHg4DPeurN5J1NivUw9YzRWQyXGd
	 4HIyXK5gHCcn+JNLM/urwWlsdJVNsJ7r3cava1EY80/T+hGu8eAzM97xiE1aocDTmA
	 Sy9aGDp83JHJQ==
Date: Thu, 25 Jun 2026 09:31:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com, 
	m-chawdhry@ti.com, Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mmc: Convert TI OMAP2420 MMC to DT schema
Message-ID: <20260625-cyan-ibex-of-pluck-0a5fac@quoll>
References: <20260624163112.535237-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624163112.535237-1-egbostina@gmail.com>

On Wed, Jun 24, 2026 at 04:31:11PM +0000, Eduard Bostina wrote:
> Convert the Texas Instruments MMC host controller bindings
> to DT schema.
> 
> Note that the OMAP2420 driver will not work with OMAP2430 or later omaps.
> Please see the OMAP HSMMC driver for current OMAPs.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> ---
> Changes in v2:
>   - Changed ti,hwmods type reference from string-array to string
>   - Updated ti,hwmods regex pattern to "^msdi([1-9]|[1-9][0-9]+)$"

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

