Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458D3176FB1
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768872340; cv=none; b=JLI0TA6ffMvAjvjsh7qkOv0LC7Hh9KbMZEMqVvoXesxevAKdB0v0XJxyqDpasGS8DQbUayTMzg6KqMJ9vzCEtxIV4IGbpxU7mpk4A7sPUEd8b55z+FEkP36o+pD3BtgYl/1xLrveRATTVZpIKxbpeEepcw9/rXudvGSfzv3aFaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768872340; c=relaxed/simple;
	bh=wPJaPF/e1niZfHaTFMCqulNIhP6lWBEjt4yhUvGuyO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmtveLbI4DLzoU2Xh8wiJp2cN32eWyhyBXLUJuRs77cwgp61rmMiHKWazHz/q7pTbyiP2SfdcO5xYdiIm0nmZzWJ9U9vygyzGG+ckKBdji4bSM37b8N78YOqsHwT2/d9g+osxSyXxEVuOfvF6hkUUyEZFRd7chFKa7aRiqFv+74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qu7Ncsh/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qu7Ncsh/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C48C4AF0B
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 01:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768872340;
	bh=wPJaPF/e1niZfHaTFMCqulNIhP6lWBEjt4yhUvGuyO0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qu7Ncsh/GIl3IFjYmpv6jgyT9D+SF4lwbOdStRZMoNpG+OfItN8Vm6qnorlX7BTax
	 BCxZ9/4wy+AkLywLksr8qUArIe+nBN08dK0+uj/2GPVKv+g02h8ApN7YkkmALEHBte
	 tBalEavC0e1hv+0Gs0Fsse5W9sxMVNliKWIAWcqyGGsuBzO0hO3ZWT/p4AoIdV30d3
	 NTaMd74CJ6OEjAFlbAFpQHTmVkVGIeiESqghTJ0v1/vONeYHCiZ9NrElQavKEUqBxm
	 uQe0pfcWd0hGQSpLOf4PEKCmQMnb9EE+XpFL/V95CWVVL5/lw1dgaomu+LwUxXDVYQ
	 sRsxmKMK+L94w==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-650854c473fso8778076a12.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 17:25:40 -0800 (PST)
X-Gm-Message-State: AOJu0Yyvd+/MfpUdGdBp+AY3yPfHJX41mfm3bhsNKBgwnBVkT00MYBha
	Hx+7hTooJFJXYhLaV3iDuedYCuMLcaB/XhR3g6DdrEYN1PsQ0kke/6V2fOwiW32NDwQ4ZhIV1w8
	TbbTTuXl0OLxhSSHN3kT5jHXmRPyacg==
X-Received: by 2002:a05:6402:26c8:b0:64d:1294:42e8 with SMTP id
 4fb4d7f45d1cf-65452ace66dmr11949804a12.6.1768872338708; Mon, 19 Jan 2026
 17:25:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com>
 <176840729246.2734238.959231359705262987.robh@kernel.org> <9c21bc87-326a-aa0b-ba81-31b10e119acb@oss.qualcomm.com>
In-Reply-To: <9c21bc87-326a-aa0b-ba81-31b10e119acb@oss.qualcomm.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 19 Jan 2026 19:25:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLVOLwC5fdQUoU-0QXcyjH0tK7cTE_7B6kVa6kFE8zF3g@mail.gmail.com>
X-Gm-Features: AZwV_Qg4kH3bUXgsCT2ukS4kG5Q-TefN9r3ma3u_YnPri6GEtN6P4BDHICeXams
Message-ID: <CAL_JsqLVOLwC5fdQUoU-0QXcyjH0tK7cTE_7B6kVa6kFE8zF3g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Enable Inline crypto engine for kodiak
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	krzk+dt@kernel.org, ulf.hansson@linaro.org, devicetree@vger.kernel.org, 
	andersson@kernel.org, konradybcio@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 6:49=E2=80=AFAM Neeraj Soni
<neeraj.soni@oss.qualcomm.com> wrote:
>
> Hi,
>
> On 1/14/2026 9:48 PM, Rob Herring wrote:
> >
> > On Wed, 14 Jan 2026 15:18:46 +0530, Neeraj Soni wrote:
> >> Document Inline Crypto Engine (ICE) handle for SDHC and add its device=
-tree
> >> node to enable it for kodiak.
> >>
> >> How this patch was tested:
> >> - export ARCH=3Darm64
> >> - export CROSS_COMPILE=3Daarch64-linux-gnu-
> >> - make menuconfig
> >> - make defconifg
> >> - make DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/mmc/sdhci-m=
sm.yaml dt_binding_check
> >> - make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- CHECK_DTBS=3Dy =
dtbs
> >>
> >> ---
> >> Changes in v2:
> >> - Removed the "if: required:" description for "qcom,ice" dt-binding
> >>   as the ICE node is optional.
> >> - Corrected the ICE dt node entry according to the dt-binding descript=
ion.
> >> - Added test details.
> >>
> >> Changes in v1:
> >> - Updated the dt-binding for ICE node.
> >> - Added the dt node for ICE for kodiak.
> >>
> >> Neeraj Soni (2):
> >>   dt-bindings: mmc: sdhci-msm: Add ICE phandle
> >>   arm64: dts: qcom: kodiak: enable the inline crypto engine for SDHC
> >>
> >>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 4 ++++
> >>  arch/arm64/boot/dts/qcom/kodiak.dtsi                 | 9 +++++++++
> >>  2 files changed, 13 insertions(+)
> >>
> >> --
> >> 2.34.1
> >>
> >>
> >>
> >
> >
> > My bot found new DTB warnings on the .dts files added or changed in thi=
s
> > series.
> >
> > Some warnings may be from an existing SoC .dtsi. Or perhaps the warning=
s
> > are fixed by another series. Ultimately, it is up to the platform
> > maintainer whether these warnings are acceptable or not. No need to rep=
ly
> > unless the platform maintainer has comments.
> >
> > If you already ran DT checks and didn't see these error(s), then
> > make sure dt-schema is up to date:
> >
> >   pip3 install dtschema --upgrade
> >
> >
> > This patch series was applied (using b4) to base:
> >  Base: attempting to guess base-commit...
> >  Base: tags/v6.19-rc1-102-g3af51501e2b8 (exact match)
> >  Base: tags/v6.19-rc1-102-g3af51501e2b8 (use --merge-base to override)
> >
> > If this is not the correct base, please add 'base-commit' tag
> > (or use b4 which does this automatically)
> >
> > New warnings running 'make CHECK_DTBS=3Dy for arch/arm64/boot/dts/qcom/=
' for 20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com:
> >
> > arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dtb: soc@0 (simple-bus=
): crypto@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/sc7280-herobrine-crd-pro.dtb: soc@0 (simple-bu=
s): crypto@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: soc@0 (simple-bus): crypt=
o@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: pmic@2 (qcom,pm8350c): pw=
m:nvmem: [[386, 387]] is too short
> >       from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic=
.yaml
> > arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: pwm (qcom,pm8350c-pwm): n=
vmem: [[386, 387]] is too short
> >       from schema $id: http://devicetree.org/schemas/leds/leds-qcom-lpg=
.yaml
> > arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtb: soc@0 (simple-bus=
): crypto@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/qcm6490-idp.dtb: soc@0 (simple-bus): crypto@7C=
8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/qcm6490-particle-tachyon.dtb: soc@0 (simple-bu=
s): crypto@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb: soc@0 (simple-bus): =
crypto@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/sc7280-idp.dtb: soc@0 (simple-bus): crypto@7C8=
000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dtb: soc@0 (simple=
-bus): crypto@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/sc7280-idp2.dtb: soc@0 (simple-bus): crypto@7C=
8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtb: soc@0 (simple-bus=
): crypto@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dtb: soc@0 (simple=
-bus): crypto@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb: soc@0 (simp=
le-bus): crypto@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme-lte.dtb: soc@0 (s=
imple-bus): crypto@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme.dtb: soc@0 (simpl=
e-bus): crypto@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb: soc@0 (simple-bus): crypto@=
7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dtb: soc@0 (simple-bus): c=
rypto@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb: soc@0 (simpl=
e-bus): crypto@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dtb: soc@0 (simple-bus):=
 crypto@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dtb: soc@0 (simpl=
e-bus): crypto@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb: soc@0 (s=
imple-bus): crypto@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dtb: soc@0 (simple-bu=
s): crypto@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> > arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb: soc@0 (simpl=
e-bus): crypto@7C8000: 'ranges' is a required property
> >       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> >
> The crypto node i added is not a "bus" node but a leaf node for Inline Cr=
ypto Engine (ICE). There are no props like "compatible =3D "simple-bus"" or=
 "#address-cells" and "#size-cells"
> added in the ICE dt which indicates it is bus device so why the tool expe=
cts "ranges" prop? Adding "ranges" as a property in ICE node will be wrong =
since it is not a "bus" device.

The issue is your unit-address is upper case hex.

Rob
