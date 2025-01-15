Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7038155A30;
	Wed, 15 Jan 2025 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930273; cv=none; b=HVtyBhqcyvKmMeq+Ml59jQ5wPKWjQyu3PIEZ/e/rcrcp58tIc4RzokKYSHAOQDPz6JysB4EBKr3FcL0qPipjRqNUtv46ry8ok2Sscq3aX/WP8RiV3U9gZ7JCu4+7YlEcFPeJ+VCvxtJBUq1OD/zJ4TO1NyAjELx7Rs+/F6XAizk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930273; c=relaxed/simple;
	bh=vyRbBaZo/lSYwKFE9n7rCU97h+K/OLoEAgv/w89xg2g=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=KUVwlIvF/WxZOQCcwj87DX0Ib6DT8/6X991X1vAkdLsmhL51iaJGi4j/Xur/moAML6EoDqEsc9BAIZavY+pa4wWfyCv0FTsmvsfjL+9MjB9tb6WaUs29+xfVfAtUZT8cqj68MUKxrnrQZ1FBGk5EuLYKptgQio1MCrL0EwK0BaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcHmbhvC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcHmbhvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1901EC4CEDF;
	Wed, 15 Jan 2025 08:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736930272;
	bh=vyRbBaZo/lSYwKFE9n7rCU97h+K/OLoEAgv/w89xg2g=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=FcHmbhvC0TllnjT/YWcEywyTOQWlMSCVxa+GI/4NA6ZxurJFIz2+uYZWGmVs/SIqX
	 BO62lY0ZycFRHfQ+2m15ZKAPjzWbRJkuwKRJazxH8GWct1ilTHEAP8VnX3HDvFN0QL
	 PkUmlRn+2uYV7ub8ZulH+kpPmUd0h21J0hTs9JxJgt4/6scROa9iCYfWK1fEQVYpEM
	 O7Y4CMVtmM3LaQDTUnY05GWWfeYuOsFa8XipLbCaZMiGtVXE5i6Zz3JyXFPZSTHPs/
	 qsIZ1Ejc4jJTciyJKbn/+ZbsEjpd3juC1yUsQGnRxJtIDX6nLkX8E1ZZPz1gmji4zb
	 +SbMGHnr9B26w==
Date: Wed, 15 Jan 2025 02:37:50 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mmc@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Wenbin Mei <wenbin.mei@mediatek.com>, Conor Dooley <conor+dt@kernel.org>, 
 upstream@airoha.com, Chaotian Jing <chaotian.jing@mediatek.com>
To: Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250115073026.31552-1-ansuelsmth@gmail.com>
References: <20250115073026.31552-1-ansuelsmth@gmail.com>
Message-Id: <173693027082.3240418.16772447316188600820.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mtk-sd: Add eMMC for AN7581


On Wed, 15 Jan 2025 08:29:50 +0100, Christian Marangi wrote:
> Document eMMC compatible for AN7581. This eMMC controller doesn't have
> regulator exposed to the system and have a single clock only for source
> clock and only default pintctrl.
> 
> Rework the schema to permit these new requirements and make supply
> optional only for airoha,an7581-mmc compatible.
> 
> Also provide an example for airoha,an7581-mmc.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> This depends on patch merged in clk-next
> bfe257f9780d8f77045a7da6ec959ee0659d2f98
> 
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 64 +++++++++++++++++--
>  1 file changed, 58 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/mmc/mtk-sd.example.dts:104.31-32 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/mmc/mtk-sd.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1506: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250115073026.31552-1-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

