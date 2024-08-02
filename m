Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87D3175D20;
	Fri,  2 Aug 2024 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613109; cv=none; b=QKXrTDWDjEPj04ZkjgLx8mdsDyq9iB70l0uPAu87qOMpaK7slDqE2HZObvMZY8/HO1hLvG4VmL+nWL/faWxNm3kLHWiScOzSwjSh9Eamlgb4jRNEv3s0KZmtAmNY8w6dgdGBXueLdtZVVH4uDx8xnvUSWrvCQDvFEsBW8EWGOkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613109; c=relaxed/simple;
	bh=9U34Es3zsGrdFdeUdrkf1ROpI97+/+LYAK8kb5fRee0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ipoe1jsDeO2k6CfktXF2FqgyxxNdaSNCLwVq6IKZ8d+5mshGy0bPL9tD3IhvcFgnChFYfjL+SUCJS1LrrVuWCneHIUdLcfc16XNtXlDh0so8ns7vqr+zCoy4P7yvmb/aEISz8w7c2LPAJLBsynZUOwz2oVWOY/HtTTIhph6aEm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vIRKx4V1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vIRKx4V1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722613105;
	bh=9U34Es3zsGrdFdeUdrkf1ROpI97+/+LYAK8kb5fRee0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vIRKx4V1Aus8wOQmwDGZFBFHfO3eOxc1GMQMLiQdeCFevkGrxMBnrYLoD6fJpa+Up
	 qOX2OL1y4klIyt5B8b37Z/6E4onF7xJkwyteFuXseoVJTm2oMpqUJPWOC03Tm0TlMh
	 rMGPvVaaFnDU/1z3+3JlYbcsaJn08/WD3lrk3NwackJrnszzR2nwMjaceHJ6cu60pY
	 ZOQp54QL+Z6s2dyxLDbYjPD4Sy1UetG0pbt0VPIuT0tgHYUwhdQjNysWnHf1NrB8J7
	 3hQ6y1tbmJtdU7Q6/snh6vO2Xy02Vd3Blqm3S+4auDjXFyAB+8g0llBVrHKzYcSbyq
	 S/4W/0J6yBRpw==
Received: from trenzalore.localnet (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 594423782212;
	Fri,  2 Aug 2024 15:38:24 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: Add rk3576 dw-mshc bindings
Date: Fri, 02 Aug 2024 11:39:32 -0400
Message-ID: <6067992.lOV4Wx5bFT@trenzalore>
In-Reply-To: <20240802153609.296197-2-detlev.casanova@collabora.com>
References:
 <20240802153609.296197-1-detlev.casanova@collabora.com>
 <20240802153609.296197-2-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> [PATCH 1/3] dt-bindings: pinctrl: Add rk3576 dw-mshc bindings

s/pinctrl/mmc

On Friday, 2 August 2024 11:31:27 EDT Detlev Casanova wrote:
> Add the compatible string for rockchip,rk3576-dw-mshc and add support
> for the rockchip,use-v2-tuning flag, a new feature of this core.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml     | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml index
> 211cd0b0bc5f3..dd8d1e773bb38 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -39,6 +39,7 @@ properties:
>                - rockchip,rk3368-dw-mshc
>                - rockchip,rk3399-dw-mshc
>                - rockchip,rk3568-dw-mshc
> +              - rockchip,rk3576-dw-mshc
>                - rockchip,rk3588-dw-mshc
>                - rockchip,rv1108-dw-mshc
>                - rockchip,rv1126-dw-mshc
> @@ -95,6 +96,16 @@ properties:
>        If not specified, the host will do tuning for 360 times,
>        namely tuning for each degree.
> 
> +  rockchip,use-v2-tuning:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      If present, use tuning version 2.
> +      v2 tuning will inherit pre-stage loader's phase settings for the
> first +      time, and do re-tune if necessary.
> +      Re-tune will still try the rough degrees, for instance, 90, 180, 270,
> +      360 but continue to do the fine tuning if sample window isn't good +
>      enough.
> +
>  required:
>    - compatible
>    - reg




