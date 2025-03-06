Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B662B207A22;
	Thu,  6 Mar 2025 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250454; cv=none; b=o4Ha8+g1iHaYSXR1DJAAtoWKUui8WZ7dewtxi0tcXR1+P/3mLXLoKUwZXXbtASf0hP1ckKyMc9cYQMtz8yLrXXQnGHVRGtaedG0PlU2EVdmVyMLe7DzqPv9KNgaGVSBpQUoz37LXc/8NWBdUhW//uqBpI1UwJWZfPlyukXZg5sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250454; c=relaxed/simple;
	bh=HwImz1GMX2O9S3KEUJEyqhf1220r8G2ZhwB4rv3Pob8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBPI6qJzdSfJql7NDFagx/QEWnXfdQVBOTbhnXWKdYIkRMKlcLosTZlP/V8CTxdLM5qI712ByXTO6XJdmn2H8Ei6bD+IBy2rIRgkmg0rCiLGHDeJYed3312/K/oowJwxKxgCDa9VDX470Bh975uiZ18MqQBF/1AbmwC8PDGT2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AazKnQU3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AazKnQU3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D622C4CEE0;
	Thu,  6 Mar 2025 08:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741250454;
	bh=HwImz1GMX2O9S3KEUJEyqhf1220r8G2ZhwB4rv3Pob8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AazKnQU3lpC/mR19m3RChMYXqnp60ihyTBG2Nk16YTshw439YbLi3UHc0ohM67o44
	 zorrj1vzxP80o3/BFJHS+1NUtAmzFFGo8lawnA1mhSYYLmDZ2KiwEPDZgCXZyDraIT
	 8THZR42XJinbfZJuUS8K4K03q2XrhXVToJ5CTkSyAReMzmj1ZrIy8Hz0Y+y4Yj4i3O
	 GdCVUsMW1VDXYZfrAbxc2Je1H9ya97y13KBzSpkagKRML7KdXEabFX7cygCfUXUMLD
	 gLthe4MlABJWL2NjDRAC5iQ4SqMaA8rIHj3Z4fZTTkd6WoDRI2OcRjOykULzHjNEeK
	 ex4UUiP3Xd0OQ==
Date: Thu, 6 Mar 2025 09:40:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Shresth Prasad <shresthprasad7@gmail.com>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Detlev Casanova <detlev.casanova@collabora.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 4/8] dt-bindings: clock: Add GRF clock definition for
 RK3528
Message-ID: <20250306-imaginary-fox-of-hurricane-aa1fa9@krzk-bin>
References: <20250305194217.47052-1-ziyao@disroot.org>
 <20250305194217.47052-5-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250305194217.47052-5-ziyao@disroot.org>

On Wed, Mar 05, 2025 at 07:42:13PM +0000, Yao Zi wrote:
> These clocks are for SD/SDIO tuning purpose and come with registers
> in GRF syscon.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  include/dt-bindings/clock/rockchip,rk3528-cru.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

