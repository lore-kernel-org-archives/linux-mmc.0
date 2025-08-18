Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52F61FF7BC;
	Mon, 18 Aug 2025 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527820; cv=none; b=N/L/ZTXwu6P34rfWMtHn6VTmHB5/t/FvHU3K7Y7DWhJpTu5thuNsM1z14rhkPuzHgoHpeVw7911PxA4g5SihaXxrNbW8Oksnq4vhMyV2PUjSH98hpdcu2+ZbmW391+RT/4ThGHvZ0xnelp7BUd9TGU8lVpAPAZpyQ/9AdS7O7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527820; c=relaxed/simple;
	bh=MEuQmN6dB4qhRlM2ZjIWDLLN/sxc9sQMj976sd99t70=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Re3frUg53PwtUeef8oEsmgqI68f2bkp+A+gquTfQKXuC7JPCvZS7v/Yasc7zJOEWtTuxJlF2+EW668ctRFcueCgqcmcjoIYAHGe0lD7c7ZRxS3JKUXQ/zzigWBQWKvaeW3yqxQXpCBbeUixXIqWnUhJwwlLdeSWGDxtO8DH4GRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZP1vKGn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZP1vKGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2B9C4CEEB;
	Mon, 18 Aug 2025 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755527819;
	bh=MEuQmN6dB4qhRlM2ZjIWDLLN/sxc9sQMj976sd99t70=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=EZP1vKGnknr3Yr+gDnMlWUcDB3NILxB6yvh1iwapY4aQr6ySF0XyxO848RHHUMLZA
	 2zMA9sxRNwoFLFKNeav019tKJoKIt0tgP/68X5U2xz6G0s902fHaA6fhyU4WNEOb9D
	 uqudknUe86CdcMrlsp//Weao0bCfWr/r1TyThmjTBsP5VSFzyozlXTjRo7l54DeyOm
	 fsaJiJ20kh+Jt7B8F8SeKR1wtkSYF1siRVVxjVYhpziqxJtm+68jnlo2par0SLsX66
	 ncOgxmVGG2b59e0fqNTX1scyJK647YEm16Z8CiUkfPpDlyt1+JzF+OaXOtPVCpGL+i
	 O8t74L5VuoxyA==
Date: Mon, 18 Aug 2025 09:36:58 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
 Chaotian Jing <chaotian.jing@mediatek.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-mmc@vger.kernel.org, Wenbin Mei <wenbin.mei@mediatek.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Mengqi Zhang <mengqi.zhang@mediatek.com>
In-Reply-To: <20250818114855.8637-1-mengqi.zhang@mediatek.com>
References: <20250818114855.8637-1-mengqi.zhang@mediatek.com>
Message-Id: <175552781678.1170160.15905675256206563540.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: mmc: Add compatible for MT8189 SoC


On Mon, 18 Aug 2025 19:47:27 +0800, Mengqi Zhang wrote:
> Add a compatible string for the MT8189 SoC's mtk-sd mmc controllers.
> 
> Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>
> ---
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/mmc/mtk-sd.yaml:333:10: [warning] wrong indentation: expected 10 but found 9 (indentation)
./Documentation/devicetree/bindings/mmc/mtk-sd.yaml:334:13: [warning] wrong indentation: expected 11 but found 12 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250818114855.8637-1-mengqi.zhang@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

