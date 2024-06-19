Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263D217583;
	Wed, 19 Jun 2024 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781385; cv=none; b=g+xiCiYF+Na62VqTIHIPHZIWj92B0Zupy7M+jGzD0Ufzd2IXRvihLd8ozypTcMay6XwCzpGKaoI+R34F0xKX7/teRvR2kjQdqIEd7AYOXZvaeTjcHnk5xCzSrmi8Fa/AfxLWsIdFH5xtiXRIwyF7mpuRN/PnmezOg9x53dx9Gtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781385; c=relaxed/simple;
	bh=1SeX6DYpTe78Qp9u9466EckMez+yd1/EEOQ8w2vo0i8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=o5TXI8A5AkHfiN+YOLvYoj5JUzYShEmSDc2kYk3lRM7GTyUAPKkmq5yjtHYn3039Lq0lWsEs8DHP4CBOySa+pwHp+F1C71K7wBkUTatecoYYcTD/ZbbL5PhvrPmN12L9ZDKOSohbgZ6I4dJzFVFQEI/LjpUwSe1y9212EbMqyHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJm1iY6C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJm1iY6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8848EC2BBFC;
	Wed, 19 Jun 2024 07:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718781383;
	bh=1SeX6DYpTe78Qp9u9466EckMez+yd1/EEOQ8w2vo0i8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=uJm1iY6CBbwXF8+kYSJCKVVxnMvXF2gJdFeIXwy0bBppV+iQLSkh0tR75Gl9AZM8e
	 L8ph0vEZ/YUllDATVOBZfyz3PO7XV34/mVKUfWtPmdNcVKEIUgAB3aOTZm+jymZS97
	 8iPSHPu6R/lIN0ywnvtcVxJGWF86hRQXMmNQxPl+KGZRa6THDqXfXJRILJjxjIDHkF
	 z9xCmvBOgs09DJb7FP3qD5L7wzGR2R+hEdgu7vS33NMZyhQMFLD37LDIBBhgOfdVPk
	 9kgDy63QbTR8dX75uiIAxr/RivtGacRJrj2oGszHym8M4ecg93ckRqsJmbgmwQkwTc
	 ZVq4Z+y+3ynww==
Date: Wed, 19 Jun 2024 01:16:22 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shan-Chun Hung <shanchun1218@gmail.com>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, serghox@gmail.com, 
 krzk+dt@kernel.org, ychuang3@nuvoton.com, ulf.hansson@linaro.org, 
 devicetree@vger.kernel.org, pbrobinson@gmail.com, mcgrof@kernel.org, 
 schung@nuvoton.com, linux-kernel@vger.kernel.org, forbidden405@outlook.com, 
 tmaimon77@gmail.com, conor+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com, 
 andy.shevchenko@gmail.com, p.zabel@pengutronix.de, 
 linux-mmc@vger.kernel.org
In-Reply-To: <20240619054641.277062-2-shanchun1218@gmail.com>
References: <20240619054641.277062-1-shanchun1218@gmail.com>
 <20240619054641.277062-2-shanchun1218@gmail.com>
Message-Id: <171878138268.711122.13293312471456423483.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: nuvoton,ma35d1-sdhci: Document
 MA35D1 SDHCI controller


On Wed, 19 Jun 2024 13:46:40 +0800, Shan-Chun Hung wrote:
> Add binding for Nuvoton MA35D1 SDHCI controller.
> 
> Signed-off-by: schung <schung@nuvoton.com>
> ---
>  .../bindings/mmc/nuvoton,ma35d1-sdhci.yaml    | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml:77:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.example.dts'
Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml:77:1: found a tab character where an indentation space is expected
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml:77:1: found a tab character where an indentation space is expected
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240619054641.277062-2-shanchun1218@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

