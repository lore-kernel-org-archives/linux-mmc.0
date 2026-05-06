Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE08175A7B;
	Wed,  6 May 2026 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778055790; cv=none; b=Bp5UKNXml03390a/on4CCahaGlMZRiCTyC7Jh6jDNAkdHDJAGOm1/frdSIZyRRZTwAGsMgEseALsOM66LUGgVnVpuPEObqmZQwx7cANV/RKxQGZjJBQMc5cvYwYojKjxq814oILUBgVMdhagkFTB/M7ENLIr7Sp4YPzeI9Xf+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778055790; c=relaxed/simple;
	bh=2jEHqptD+qreSU/37Qicd0rNf1deow+eu2W5GdY5rk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAKyZA8x1MiCij/ZoEqza32V3TRy477IxTGdb+4ytuXQ6iOtX67uv9Z/oiPVuJZiFmuqKc4O2lO8OD7AyoGR9VV+G/GEilP5yTvd54n38p8SezfxIwzSzybIu6EgdS1MYJev0b3OgKsVExxnlHia7+xqykveomvJzOMjXtUr83Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdFCZ/Wg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdFCZ/Wg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AFCC2BCB8;
	Wed,  6 May 2026 08:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778055790;
	bh=2jEHqptD+qreSU/37Qicd0rNf1deow+eu2W5GdY5rk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IdFCZ/Wg5p41hFpFXmRl5ongMb94g0DD1kDBcLKQVMbucJXPFB/iDU1h2dcVs1COq
	 IClD23BDN7ejUQpjO5HA+DtMM0gVe/ZnIpgfhnPtJ8nnaKi+T0r94AVbMy5ponddPA
	 QkKcbwZ1P2e8m0UXlZSjLToqOU76wH9QnJKVUrXhtUVSQDYeUtwR3qIKZfNOq2zXwb
	 mjn1zG9vORpefObj43j5qa2dddVgac0TvOtbNc2s6EmEh8p4w5qvuy8LZCdn4rJ/q+
	 qpXM4TpGF+gUjFqYkYB6g2ut6dthI1QwgVgHmxlgIVqNcNhXxWcz0YTYXW5RG0daSm
	 khZRCdP2yypxg==
Date: Wed, 6 May 2026 10:23:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Monish Chunara <monish.chunara@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nitin Rawat <nitin.rawat@oss.qualcomm.com>, Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>, 
	Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: Re: [PATCH V1] dt-bindings: mmc: sdhci-msm: Document the Shikra
 compatible
Message-ID: <20260506-arrogant-warthog-of-holiness-84ceea@quoll>
References: <20260504071334.1061325-1-monish.chunara@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504071334.1061325-1-monish.chunara@oss.qualcomm.com>

On Mon, May 04, 2026 at 12:43:34PM +0530, Monish Chunara wrote:
> Add the MSM SDHCI compatible name to support both eMMC and SD card for
> Shikra, which uses 'shikra' as the fallback SoC.

How shikra can use shikra fallback?

> 
> The SDHCI controller on Shikra is based on MSM SDHCI v5 IP. Hence,
> document the compatible with "qcom,sdhci-msm-v5" as the fallback.

And here you repeat or state something contradictory. So shikra or
sdhci-msm-v5?

This should be just one paragraph where you state the device and its
compatibility with any other devices or interfaces.

Best regards,
Krzysztof

