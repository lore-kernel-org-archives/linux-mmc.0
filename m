Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A0C22B8D5;
	Mon,  2 Jun 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748893212; cv=none; b=DRTnpA+OO6MRz6iI1To0k69LEbBbOTfA6nODinXxBq7abBEHBPhG2/xFo1eFQOpf/AXw4QrFDehdoqAUevlcmMC/OMvgW6zvbjNp/GAIEU7YXcV7TO+YcKJfQg4KZFEZCrkk28JBTyH1KlAa/4WtI4YpwKMJiUfDS4TPbSzM60E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748893212; c=relaxed/simple;
	bh=n19CmSXpjhdn/QBHrUweXIEz9WZjEQcw/ITqIU41JCc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=NT8as+v8keoZ9O3F0c/co5hV4CXwzNRctkhEH0iecMlodshfnSdT9BJJ5w1t3OOZuMGKvz0lqYBYgz23kg7mUuWn509XWdWfcqQUX8OM1jRIhSeWGhJV48hrmIcl1IZlXsx1RCeDuqm4OdY2zVcwc6X6xgdD1ejHwrZ+kg/akeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nghj/WVW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nghj/WVW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85840C4CEEB;
	Mon,  2 Jun 2025 19:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748893211;
	bh=n19CmSXpjhdn/QBHrUweXIEz9WZjEQcw/ITqIU41JCc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Nghj/WVW5m2fhZWInJI+AZsbrYk5aIR2uWEzRc11ACV2TBUEIW+FOPO1l8gozcMEM
	 lZg2kxu+rA3e+/MONvG4OT6DnehGlE//RyONxeOyR993MYZVl+rKF/HL5lAIkFz+U5
	 QrRXy1CA87oNqO8FNJsE/ePiwGFAOk/ak7d5EY2BF1AXIgFQrsHjpW11KUNGrGy/sy
	 acn8bdenYZy0tUR81sIuCUpB7z7YZzDpB8iFwOUBsJcTSAkfA11lvadCSAsHWloMHE
	 Py+ywir/pA2bct6UZn6ly7BjJFaGfyVb5XgjSfHVSrQzz1M2TLdnND+K39M7GshCEH
	 Qul7oYlg577aA==
Date: Mon, 02 Jun 2025 14:40:09 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mmc@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, 
 wahrenst@gmx.net, linux-kernel@vger.kernel.org, 
 Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, 
 Shawn Guo <shawnguo@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20250602150147.947883-1-Frank.Li@nxp.com>
References: <20250602150147.947883-1-Frank.Li@nxp.com>
Message-Id: <174889320959.2722772.656313710897661883.robh@kernel.org>
Subject: Re: [PATCH v2 1/1] dt-bindings: mmc: mxs-mmc: change ref to
 mmc-controller-common.yaml from mmc-controller.yaml


On Mon, 02 Jun 2025 11:01:47 -0400, Frank Li wrote:
> Change ref to mmc-controller-common.yaml from mmc-controller.yaml because
> imx23/imx28 use dual mode controller (spi and mmc). So default dts node
> name use spi instead of mmc. The legacy reason, it use difference
> compatible string to distringuish work mode (spi / mmc).
> 
> Fix below CHECK_DTB warnings:
> arch/arm/boot/dts/nxp/mxs/imx23-olinuxino.dtb: spi@80010000 (fsl,imx23-mmc): $nodename:0: 'spi@80010000' does not match '^mmc(@.*)?$'
> 
> Additional add clocks property.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - add clocks to required
> - fix typo legancy in commit message
> ---
>  Documentation/devicetree/bindings/mmc/mxs-mmc.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/mxs-mmc.example.dtb: mmc@80010000 (fsl,imx28-mmc): 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250602150147.947883-1-Frank.Li@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

