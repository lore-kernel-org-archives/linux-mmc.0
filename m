Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1613219AD90;
	Fri, 17 Jul 2026 00:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784248539; cv=none; b=TYTCijLKtMc91J0lq8cG8KbxTVsxQeh7TqIPCI/2x2utFMPg7nN5Tey3FldYeiaDWjzvybqUqu4Iftki8USS1lFcoxzJOvOBYIdx4Pbx+essiwH1w+Abff+KfJnEi/wu52vQDLbhyR+BXhKHYDt37tKIk6NvqW/WAiRxKtLAIHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784248539; c=relaxed/simple;
	bh=la9ppKLG1GqKDdpSeTATmaSmOyisP/oD1W7wRd5tbeo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=EGNBMEgNSyC/2/liHM0OaW41pn4VCF7BnyAkM4j/qJfWYe97aMtX8MvjjRjJhcSjG/nsWc3Fk7oyqK8qIQEqM1hmoUTS8flObIarlSg+yEEEybQRqG2dtyzK7CD1cz4G7ogynYhK/TDxwoAype+L/oo1ArT5iGNmvjo4uQNel1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNLcOwgG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNLcOwgG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876B71F000E9;
	Fri, 17 Jul 2026 00:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784248537;
	bh=ovdFFy+hiQQ6Lz6T/cVfUyU7pOYUGQM2mUPHwvD8qlQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=fNLcOwgGYv/sujxdrm+V6Eqr1Nvi9x8TRZHHBVb8At5C3mXzL3vJa1hXNiRfHXqMT
	 GJxG2EUMNHEWq73HgGp7hktSv5J1TTM3NhU//L1zfhqlQ5MhoWByjxk7wGLRMEr5Uz
	 Sd4MAnEDNQrVbeFInW2R6l1Pst52AHB2HYCdXJ5ZXE44RkX93M+/NQS2f3ofyDEEb6
	 /T4p9In+BBzT2PjgvcFaasaxpcDalfQFxUVJmjEsEoh8r1SfQaS0sslPaZt+ezVvtb
	 Spg/5gjpVVwigxqzc51rGxdL6+DcOizLraaBGh58LDtlum/Ibq+h2/WC9r1OCfJkL+
	 nyvDRX2RqCC7A==
Date: Thu, 16 Jul 2026 19:35:36 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Judith Mendez <jm@ti.com>
In-Reply-To: <20260716232641.2659710-2-jm@ti.com>
References: <20260716232641.2659710-1-jm@ti.com>
 <20260716232641.2659710-2-jm@ti.com>
Message-Id: <178424853689.2124957.15369600144295618972.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: Add post-power-off-delay-ms
 property


On Thu, 16 Jul 2026 18:26:40 -0500, Judith Mendez wrote:
> Add post-power-off-delay-ms property to MMC controller common.
> 
> This property shall be used to specify delay if needed after
> deasserting power during MMC power cycles.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  .../devicetree/bindings/mmc/mmc-controller-common.yaml    | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml: properties:post-power-off-delay-ms: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260716232641.2659710-2-jm@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

