Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795363414;
	b=IYtZsfKnq9eU1fcsBpsKSjgumRJKp1BX2mtLhtgcxUIDybMEfRyb6bT8fxyauE8UAjrj
	 59Vne9KGQZte7weqOmtNoOCcTVPjy+KTew/DbPLnTpzeHbhR96ZDy/yB053h0Fv9vT1WC
	 uWv+l/iISCwdNr6K6CnuMSQ2MIEeK+swapUkvOfjFhmkZYeCNcHFisKSjnB6TgzjPUWkW
	 s/MtZuiwIXnQNX9YRBAhqXXJfpH6aq+fCxj7R2my/7jhLg/4UyL/sj3rQf3ICssFk8g5w
	 oPbp9BYAH6C73K+2LBMcL32bf8EUtThagryG1Q6xTs8JsT7npd1KyJWAyTySUIztl5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795363414;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZIXQJqPnlijo9oqLbOy2evsneVAb3DdZUTrnXReNgqU=;
	b=xN9QcR1nwRv8lj964R3PZIM5HDxkmLCWpe6Vb/tlM4+pb7Nz6bpXEtsMXSKBO8xEFg/k
	 P6lyMcXhp029nNSZCH//Wj/JhsCPgpdpAUSSBCDNgOxdWo4IzUI+24fF6dvZKgTdp+sqM
	 O+g/3d7zPZFEe/l4h4+jR5TkToxAuCYfcLUwawwbJ7aOvPO5HIxSLKaguo5L0hfmYN2db
	 A8hP3gGexqezgtoEuMkrMdpUpWY72lGFyVHG0U2B0/nxHlQMZoXfXABUqpp4iV6apIOgG
	 35HNq7E2jby+Fzu72LX6te8s7UniCE/EzT3Wh/ZB0kuG9cKVcWjt8FfRsbsTQU+c/Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRzVQLm8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1782D606A320;
	Sun, 22 Nov 2026 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRzVQLm8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBDA1F000C0;
	Sun, 22 Nov 2026 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795363413;
	bh=ZIXQJqPnlijo9oqLbOy2evsneVAb3DdZUTrnXReNgqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kRzVQLm8QkHKNZKDqlPWBtQ8wAIOqf04nFS2Bq8AxIFhQ3lG5Zse/Yzoi6gq+sjmZ
	 Vdwopy1bHBC8Wx3KmYLq3+BOUhuMLHAKuC3R0pXGcgTO3FoZeASmDmxFF92gzveH9i
	 H8Qlrjfp635tZa9HTCdKXt6ilmVitxMzkhma16r5r8lGWJritDUkp0p/0mNGt3Wv/W
	 vDI6Iw2/Ukn0IA3+zWdqvQSKXev4xgeF4to0a8n9ifIx66u3rublHrTdT9e3qk9I8y
	 I6sCtf/077CGElipRV3c/BmCre0GNBVpJB+fMJ/Is8LBL+f3ffcuETs2PdyGVQV004
	 eK8e38O7a3IUA==
Date: Sun, 22 Nov 2026 17:03:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: tze.yee.ng@altera.com
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: mmc: cdns,sd6hc: add SD6HC DDR50
 read-path tuning
Message-ID: <20261122-small-xanthic-macaw-f4acaa@quoll>
References: <20261119-sd_cadence_ddr50_v3-v4-0-95a94a0aaaf3@altera.com>
 <20261119-sd_cadence_ddr50_v3-v4-2-95a94a0aaaf3@altera.com>
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
In-Reply-To: <20261119-sd_cadence_ddr50_v3-v4-2-95a94a0aaaf3@altera.com>

On Thu, Nov 19, 2026 at 05:45:34PM +0800, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
> 
> DDR50 has no CMD19 tuning, so the SD6HC read path must be centred by
> static, board/SoC-characterised PHY settings. Add two optional SD6HC
> properties for the extended-read DDR modes (SD DDR50 and eMMC DDR52):
> 
>   - cdns,ddr-read-dqs-delay:    read-DQS delay as a count of DLL delay
>     elements (0-255), each cdns,delay-element-ps wide, that centres the
>     read eye (default 0).
>   - cdns,ddr-no-lpbk-dqs:       disable the loopback DQS read strobe and
>     use the fabricated phony DQS instead. Loopback DQS is the recommended
>     default; set this only on boards that need the phony DQS read path.
> 
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

