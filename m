Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD21A2749C1;
	Wed, 14 Jan 2026 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407536; cv=none; b=tBlimZPpK30FFi7GXtvbUAXmyexN4YR60z841I5bR5SMjYRmX0mhRMLFv1eUDPXtlIqO1AHRfvHtcvZh4Ik5usTN8jqX797zY6UgiU33qtABLRrqpw03DR7A7wzdmabGGjALcPjGJohstqGvfd22dB8AWQY2UHxfuTcfvuf2G9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407536; c=relaxed/simple;
	bh=FLBkDzDld6DYfohRX1q/2GpcjES2Dy2oiTRhwNsJ+BI=;
	h=From:Date:Content-Type:MIME-Version:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=FafoYqQD8vdvVcSrWy1nXVfRMzT0zwtnIapYEHa9XosJ9GsU9nPCCX85vhebVJ4VYJYIkkgFwBBKEeeJS1uPghFfb4mroQVmhIsHtL2xr9QX2wMEwinkaXju5qUo2tNyW3TyvjljCxfXvcebHrDhjepC9HrRsGBgw9kzbD2tSMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfsdGIxm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfsdGIxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA9AC4CEF7;
	Wed, 14 Jan 2026 16:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768407536;
	bh=FLBkDzDld6DYfohRX1q/2GpcjES2Dy2oiTRhwNsJ+BI=;
	h=From:Date:Cc:To:In-Reply-To:References:Subject:From;
	b=sfsdGIxmrdraumdqxRjzam6AipFOnU/a/RdTF4BvpITkIxtGxEe6XBjPCJxUjv7+g
	 j7HKrnsoSDLRXHVe/sY9oFD5d9l9U4PE4uB1hl80BIxqN3ndSiuGD8l7i7ubUj/lkT
	 eS52rl0YGw1oJ1MfSQ5pTKIbxk3IOfEyouKNbFEgEU89ErNDh8sSCi4pRlJJyRsAnD
	 unlZh8imF4oZf5FCbdfoiO7+34FQZ5tIjkgZbDfzBuipBlNQVankpdEQSxqua5KGw1
	 5NnO/OAcag3wF3gU2qA+EGBBdRZ/yjOjNfdcfhLUDpCrya875UnIjrvyTB3uif4ko1
	 rBSNvWkmB4K7A==
From: Rob Herring <robh@kernel.org>
Date: Wed, 14 Jan 2026 10:18:55 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 krzk+dt@kernel.org, ulf.hansson@linaro.org, devicetree@vger.kernel.org, 
 andersson@kernel.org, konradybcio@kernel.org, conor+dt@kernel.org
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
In-Reply-To: <20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com>
References: <20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com>
Message-Id: <176840729246.2734238.959231359705262987.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] Enable Inline crypto engine for kodiak


On Wed, 14 Jan 2026 15:18:46 +0530, Neeraj Soni wrote:
> Document Inline Crypto Engine (ICE) handle for SDHC and add its device-tree
> node to enable it for kodiak.
> 
> How this patch was tested:
> - export ARCH=arm64
> - export CROSS_COMPILE=aarch64-linux-gnu-
> - make menuconfig
> - make defconifg
> - make DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/sdhci-msm.yaml dt_binding_check
> - make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CHECK_DTBS=y dtbs
> 
> ---
> Changes in v2:
> - Removed the "if: required:" description for "qcom,ice" dt-binding
>   as the ICE node is optional.
> - Corrected the ICE dt node entry according to the dt-binding description.
> - Added test details.
> 
> Changes in v1:
> - Updated the dt-binding for ICE node.
> - Added the dt node for ICE for kodiak.
> 
> Neeraj Soni (2):
>   dt-bindings: mmc: sdhci-msm: Add ICE phandle
>   arm64: dts: qcom: kodiak: enable the inline crypto engine for SDHC
> 
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 4 ++++
>  arch/arm64/boot/dts/qcom/kodiak.dtsi                 | 9 +++++++++
>  2 files changed, 13 insertions(+)
> 
> --
> 2.34.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/v6.19-rc1-102-g3af51501e2b8 (exact match)
 Base: tags/v6.19-rc1-102-g3af51501e2b8 (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com:

arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/sc7280-herobrine-crd-pro.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: pmic@2 (qcom,pm8350c): pwm:nvmem: [[386, 387]] is too short
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: pwm (qcom,pm8350c-pwm): nvmem: [[386, 387]] is too short
	from schema $id: http://devicetree.org/schemas/leds/leds-qcom-lpg.yaml
arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/qcm6490-idp.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/qcm6490-particle-tachyon.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/sc7280-idp.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/sc7280-idp2.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme-lte.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml





