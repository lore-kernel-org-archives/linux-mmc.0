Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359305;
	b=UR/9Ncw4CutmKyAOoMU4OkBFsp3NmuirYRxCS9Xx0K+Bba4IfHR87qXlWO7ovLBD2I6O
	 BK+5hFq+HIkQzgfNhktaq2xugihHEgIYIgCVz+l95Dr+o2Pg4FpV/FyLAvAY0PQV09d6E
	 T0XdsnkM9JhFlgkMLDVnkDdAZ/SYN52pZoI47zLgsqyh29OlAQ9MV92krjjB9LWEAFdHG
	 eFvH/wXbkTwAwErh9YYeMX4ShRGw1YYJ2fMJjySKEG2onQvfz7S1fN/puKbD72HLoozOJ
	 ehA/QA0ldj7qZVj+kWUlXTBe9+4yDMvPRx7/reBlF2h3d1095YssG8VwZO3ougMIemg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359305;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Ivlp40VyVn8KszTJtgCYob0RPuAFDPOsj7lo4X2gHHY=;
	b=YfhdD3cJ4Nf1002e0QQ1w0FScE+m35HnacoUJobhp+IdoGpBUkGotNuZCzw9h6U2Orit
	 YrACnTOsOveI4dLmz1WNPT2+OAoZkQdZNw+fg/UNa4pgjJ9CNasQzb37vHvct8XXsMi2i
	 pqA3bg4jGpI9bAN3dGXtxCeGFnarDj5NnYYDVYMU4J3gc+j4rYijeUadW7r1LUh03/1ET
	 vcRoRDzoWcIK+eacuAi/sCdWzpKpGauczA5sVPMfJyAIib2XQ0wIRPepqM8JUBQrdl2EW
	 9uipHch5DLi/AIiBDkcECyHDUFs+U2GBvnSZt5/nyAaMcY7IjDSKXPJytb/UM6SBbmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUeqAFHQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB02606A32D;
	Fri, 30 Oct 2026 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUeqAFHQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE601F00A18;
	Fri, 30 Oct 2026 11:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793359305;
	bh=Ivlp40VyVn8KszTJtgCYob0RPuAFDPOsj7lo4X2gHHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oUeqAFHQV6dbP0aw5HxzJN5G39aqc7eFWXNCy/m40JH1jRwjt3iAdOqRY6A3+0/F/
	 NKKYgpuLa0Rx6uOkqb9myzFhRhynrFFsnI8+3Hgv5MykQiWdQApF/Kik6pjLuFBSmI
	 2zc7M4l9V463SuPnDPejWgbmqcQowbr+a39a8F+omLtQoKloVQt8qi0YpWB6QYEU3n
	 8eD+lXsYGf2dljt5/9yEDBLqQboxzSlxJHymEmlXTFx6C1Nd0rAPyvoGrev+cTZH1I
	 pSukKz39WpDiKlMx7qA9Tkxp1/hxoMkNsYZx/lxzIy2GQ/9OwimD021NkiDV4u8bLB
	 gZc90AOO9vAuw==
Date: Fri, 30 Oct 2026 12:21:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: christian.koever-draxl@student.uibk.ac.at
Cc: ulfh@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, neil.armstrong@linaro.org, khilman@baylibre.com, 
	jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Christian Stefan =?utf-8?B?S8O2dsOpci1EcmF4bA==?= <ckoever@outlook.de>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: amlogic,meson-gx-mmc: add
 amlogic,core-phase-degrees
Message-ID: <20261030-sarcastic-sophisticated-tortoise-a7a8ea@quoll>
References: <20261025192059.208792-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192059.208792-2-christian.koever-draxl@student.uibk.ac.at>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261025192059.208792-2-christian.koever-draxl@student.uibk.ac.at>

On Sun, Oct 25, 2026 at 08:20:58PM +0100, christian.koever-draxl@student.ui=
bk.ac.at wrote:
> From: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de>
>=20
> The controller samples with a core clock phase that is fixed at 180
> degrees in the driver. Some boards need another phase to work at high
> speed: an SD slot on an S905W2 TV box fails with CRC errors at 50 MHz
> at 180 degrees but works reliably at 270 degrees, which is also what
> the vendor kernel programs for it.
>=20
> Add an optional property to describe the phase.
>=20
> Signed-off-by: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de>
> ---
>  .../devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml    | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.y=
aml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> index 976f36de2091..8123375a66e0 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> @@ -58,6 +58,15 @@ properties:
>    power-domains:
>      maxItems: 1
> =20
> +  amlogic,core-phase-degrees:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Phase of the controller core clock relative to the card clock. Some
> +      boards only sample reliably at high speed with a phase other than
> +      the default.
> +    enum: [0, 90, 180, 270]
> +    default: 180

Is this the same as clk-phase- properties from mmc schema?

Best regards,
Krzysztof

