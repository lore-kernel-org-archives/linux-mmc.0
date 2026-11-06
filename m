Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968836;
	b=43+T46lVhkBwJR9kn9PPhM3HoH43Z1CH0IPraq/0dBjvQ+oAgUX1elg91hS6W4DGkggR
	 SaX/WgdgLRc8fdYOhf8DGdQpbp4FeyvWBixMNPQxgmHYMGO4WqhKYNlTzfnztCnVjHwX/
	 7Ofkhw4SPaG3rQDgeWxeVQ/t+rAsL4LvzQcizSwn6c3BkmJbUg0LsxB5IVd5KT05P49jJ
	 ddjHmBNkd/WTpCgrAIpD8sWrovuCtycPjSRgGMm66Qr6Cy+VWDL7de69YC+G/IqM10PyN
	 M2jkCIndL3WG/lhN7hKaJ2Ea0Gnzvc7JwZPN+dgiEV5sqAC8f3fOAMDVjkg0aQUDYOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968836;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NWTVNpqYWoyFPbzwn51K4jNXuRKcTGDmTErIM7JBOtw=;
	b=ir6I1mqKG1Tp3TGmLsYo8/lKUkNd83O7rRtTKC+K0jzZI03L3qS/wxIid8cEyJhk+qXE
	 LXKhnhdTuprp8HJU+QPZgMXpLdqTtflA/u9Au3FeWnLERU97O0gkHyqMFlr7pcLu1HKp8
	 m0S1Ise01nbzBXQVefXPjSbWHj9palLPG3IBDY939oYiZcqytyihtIGYh11R+Y1F39Zy8
	 kKH+xgijVHAQpo8dP/1VmpV9eExIj4Lf2fQwXy2YPWA99hISOBS05IOYHT+fj+HgZfUl2
	 yin14SPAfK9VKdDVxg9VdmWtkPKH9wCY4tqUA8u549oDk5h+NGYGEkmcy2Ojs/N9SuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YB/ksS/R";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D7F606A333;
	Fri,  6 Nov 2026 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YB/ksS/R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A3F1F008A4;
	Fri,  6 Nov 2026 12:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793968836;
	bh=NWTVNpqYWoyFPbzwn51K4jNXuRKcTGDmTErIM7JBOtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YB/ksS/RwDFYawBxeO7gbvYf+9ohUedW6BI0ro/++Do1Q+fO6BMgaD0/ixTTDY47q
	 9wqpTCEZY/uAQ37ELFQwtFWrqbNOL5pBbN6WJhKEVV/YwneuYrGQUCj8HSASwPHXjG
	 lpj6VgZkuqks6rp42Bg9KN+Ja1zUNFcF39TqI4wWRJlopO4ka0zfpKf2iEVSzzEBp3
	 cx7a/RA/cvynCAXqoEuO1dZBYce7AvwnwHRfWLQh1GvEqMw9H9QrtHQ6cJK/gBB3ek
	 Bo62o82ZaUJZ/MTJGjrHbSn1yzpHAQXlJDw4TUk2Tfwb5KbDRa0axbfvA29yrMtC1k
	 uHsW4MZ0lKsbQ==
Date: Fri, 6 Nov 2026 13:40:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: tze.yee.ng@altera.com
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH v3 3/4] dt-bindings: mmc: cdns,sd6hc: add SD6HC DDR50
 read-path tuning
Message-ID: <20261106-handsome-dandelion-piculet-349c18@quoll>
References: <20261106-sd_cadence_ddr50_v3-v3-0-cb50afece614@altera.com>
 <20261106-sd_cadence_ddr50_v3-v3-3-cb50afece614@altera.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106-sd_cadence_ddr50_v3-v3-3-cb50afece614@altera.com>

On Fri, Nov 06, 2026 at 02:16:54PM +0800, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
> 
> DDR50 has no CMD19 tuning, so the SD6HC read path must be centred by
> static, board/SoC-characterised PHY settings. Add three optional SD6HC
> properties for the extended-read DDR modes (SD DDR50 and eMMC DDR52):
> 
>   - cdns,ddr-read-dqs-delay:    read-DQS delay as a count of DLL delay
>     elements (0-255), each cdns,delay-element-ps wide, that centres the
>     read eye (default 0).
>   - cdns,ddr-no-lpbk-dqs:       disable the loopback DQS read strobe and
>     use the fabricated phony DQS instead. Loopback DQS is the recommended
>     default; set this only on boards that need the phony DQS read path.
>   - cdns,ddr-phony-dqs-timing:  PHY_CTRL[9:4] phony DQS assertion timing.
>     The driver derives this from the RE# pulse width; this property
>     overrides the computed value for boards whose flight time shifts the
>     DDR data return.
> 
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
> Changes in v3:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

