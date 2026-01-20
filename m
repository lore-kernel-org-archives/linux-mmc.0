Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2781140759B
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 10:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905654; cv=pass; b=e669mzLOj55pePbL1emwD87UpZKMLVeTXvCMNuVOy3t3k/O9QvflIeBEnd1knO7yZOyxubFBj+v3EFg65F4wVw748cNRcmEAWtPRfql4AKJ9QC1/8AWhwLTfO8jgY3rs+ZKDXcRbOa3qKVJOaYPHhRitloMdGQbyhzFWrhlnrk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905654; c=relaxed/simple;
	bh=uHVcdQuRi0ye28VhVqOFU/npTRuyu5yyoY773NX+xsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJTmcxTIaW7ufuQlrfzcr66wZL729cP6C8WKAdJoZMq8nTcD597QfajMo0o4ji0Yy5QHMVTcxoLArPB9L1PrYvIr5nr8i2o5MG0/quEyXIJReXQgMenhJuMjxtZ3WuvJiImCuayVcex+BBGJ9i+eu8jmaTrXr4npZhMD0njMpW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=clZXF/bw; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="clZXF/bw"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59b77f2e43aso7798147e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 02:40:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768905650; cv=none;
        d=google.com; s=arc-20240605;
        b=Iim5VomCgBUr46iv/2evMY2B0O5ceZ7tPRITpK5943e6+NtY5AkajjZW1XYd4NEC2e
         iRL3e8uJSSRP7/rEcbstxiE16auZkCnv5Db0pIRcZeD3ASVDuDrJZWDrDC3e8wt8gg0a
         zAZfb7nOQAeiv+m1T0pvxFub44PfYKB0x/U8W3ICydF6X4MPVSUFpR1LiAWt/NElhxnC
         yIJxf7EGUrqJQCDBEdfLsVTfV7YI/umouKfI+GNI7WGSCu+iCqZU1KZ8E2whJ85w6ITB
         SPmIkAjoiBEqI9pSkyE9/xX+Lk9sowuzM97yrQ3I6z4tMmevJJAKSsfB42lc/5/SwDFO
         UxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eX8v1QdR4WJF8OCIlBf2jemkm5zLheafYqJqaFWFWj8=;
        fh=Zq0cykJlwC4OiVmlaKB7vYNG5iSTk6Ro83R3lkUAmeM=;
        b=aR6HWGes5DIW0ZxieCfDCxSC2aovrQFHgY44KgYkuJ3sfy7Pbjz8zfqaY6hKCrJxr5
         Y4fMBLib1hxnUWyTPwAInNlwZOXTCTF+yOD4rrmrlKaZkSrqg5K02jaCvJaQcesdDZUi
         h1So+QePQyH/atZB5FgCGT51EeZJ0XqA9qxAUqzV7sdTmCL6SMJct6mQddoM3K132GgE
         VDUw9Hxkc2laZ0jAp1PidR01k5sBcp728yX0KJ14AslMjtgR4i/8F4/c0+bUmxu/JPoL
         GD+bujsIJLozdP68N7mOn1iZCUtBMqkeQuh47ck7LIYo2/tDLLfZgdXGZ/PKR7avDKZE
         xBqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768905650; x=1769510450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eX8v1QdR4WJF8OCIlBf2jemkm5zLheafYqJqaFWFWj8=;
        b=clZXF/bw872fpXKuW6mekndn/CeJOFgx+3YeXDsu/mwJctwe2GFXIE3oTIBCi39vl+
         qizUfwUOZC1pyvmtu77szfW+tyoywSwZulRpBi2NFpSG2rlbx3O7+HHfEHjTD/+ZBzkW
         qcgVzIa4veInFPE5Oeg0EFDzyVaa88mASPltOGyf35f50QyNzgCnYA30rW88dkhw5m/6
         TfJfdD21nOhZJoW2hc3wsulqKsoN28QCemw5/u0ozg2s5/An/w81QMP3S7kcWFGDhg7i
         0NfbZ2KbFcX5ztR/vFaAegMgQPeDlxdcxtSx5lB2LVUC3wrlvKteQlugm2DWDAs6/3vp
         fNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768905650; x=1769510450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eX8v1QdR4WJF8OCIlBf2jemkm5zLheafYqJqaFWFWj8=;
        b=rTzh+iSmBfsoLjlRCso2uqm0j1XCkSTGPtgl/7vLlhBpnkFinB+Jx1zXFNOhtjjDGA
         TzoZ/kIptooWfWmhX8Z9PCzBCvee005Cfzii9yV8LATgiXrEPaV78yIfco4nCUiMFbk/
         jwcHXj+xL8Vx2orslpNHhcRLl+qjLSFEWz76JUeloECsS9LljfdchfYNSo4bK5Mo22bN
         pBnulBG8K/WgH3X/TTISVOTTV1Nl0RhuUmNEqGkfPAyr617wi8Ifp+zaImZ0JmMWgnJO
         8vsKwxDxpR9WnhzRaY18bRf9myNspeWEKv3qaX1BKROOKZ/S8oe7eeFpEe/QT9Dylvlv
         s6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPdJz27rpgY81u8CT/HLAqIe7Td0VGcRLg9K/6COWqNZoUuKi70SxTjx/Ngh6uAo5sxjVGaaBqJ7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdkv9ko44ebWzs0vv53OdanautcPek9iQPr8gZqzKsfr7WpmkO
	hrrlEovSINml9LfqTh4fcfkWC0qv+4ewPW+5XHk2oOOGY0U9bxy7uHZXqA+NP9PVNYeN3pdLxDI
	he4ByZeqt4leGb+xZrYItJ5fCBW7qDaPWYKfn01dCWQ==
X-Gm-Gg: AZuq6aJCGPaV34J1LykVDWt8mluwqpktZHTGknsWd2M2rfEMOS7ZUlTJQOErQvq0RTH
	rnNnd9igiut1LeXa/A9wa9EdaNd24hopP1yjIZ7cg2qu5f1o7SuKQB6S72hzSKWl52KvUxYHCv1
	TMdRaQ2ZC8ovQYMXLr09V8MxXvuBxQ0nNxVYzlv7YwXhz96yJ/eJHfwJTrhLf6ZG+AZOUF3nxuu
	rAEb766sNKDcBG9AXKtUmV6Rxi/g169gRJcR8ZXIU7GoDfkkESGa6zlhULgD2dMxZsro88A75Kq
	cuwm8A==
X-Received: by 2002:a05:6512:128a:b0:59b:afeb:fcbc with SMTP id
 2adb3069b0e04-59bafebfcefmr4516134e87.2.1768905650007; Tue, 20 Jan 2026
 02:40:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-dt-mtd-partitions-v2-0-77ebb958a312@kernel.org> <20260119-dt-mtd-partitions-v2-6-77ebb958a312@kernel.org>
In-Reply-To: <20260119-dt-mtd-partitions-v2-6-77ebb958a312@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Jan 2026 11:40:13 +0100
X-Gm-Features: AZwV_QhqsUxCI7MbeIHxKDkh3ditdiXP0OuLPOhjt9QynYvMhxR1XuB9Re1SWTU
Message-ID: <CAPDyKFo_4jiX7HjqzRc6r_uLG5Chto8aP_e5R9qv=jUjczr2Hg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] dt-bindings: mtd: partitions: Drop partitions.yaml
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Brian Norris <computersforpeace@gmail.com>, Kamal Dasu <kdasu.kdev@gmail.com>, 
	William Zhang <william.zhang@broadcom.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Simon Glass <sjg@chromium.org>, Linus Walleij <linusw@kernel.org>, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Roger Quadros <rogerq@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jan 2026 at 02:49, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> The partitions.yaml schema is an unusual structure in that it includes
> all possible partition types, and it disables the normal matching by
> compatible strings. As partitions.yaml has nothing to match on, it is
> only applied when explicitly referenced. The use of "oneOf" also results
> in misleading warnings which are difficult to understand. Drop
> partitions.yaml and rely on the standard compatible matching instead.
>
> The "mmc-card" case previously allowed any partition type, but now only
> allows "fixed-partitions". There aren't any users and the original
> intent appeared to be only for "fixed-partitions".
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC

Kind regards
Uffe

> ---
>  .../devicetree/bindings/mmc/mmc-card.yaml          | 20 ++++--------
>  Documentation/devicetree/bindings/mtd/mtd.yaml     |  2 +-
>  .../mtd/partitions/arm,arm-firmware-suite.yaml     |  2 --
>  .../mtd/partitions/brcm,bcm4908-partitions.yaml    |  2 --
>  .../partitions/brcm,bcm947xx-cfe-partitions.yaml   |  2 --
>  .../mtd/partitions/linksys,ns-partitions.yaml      |  2 --
>  .../bindings/mtd/partitions/partitions.yaml        | 36 ----------------=
------
>  .../devicetree/bindings/mtd/ti,davinci-nand.yaml   |  4 ++-
>  8 files changed, 10 insertions(+), 60 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Docume=
ntation/devicetree/bindings/mmc/mmc-card.yaml
> index 1d91d4272de0..a61d6c96df75 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> @@ -32,21 +32,13 @@ properties:
>
>  patternProperties:
>    "^partitions(-boot[12]|-gp[14])?$":
> -    $ref: /schemas/mtd/partitions/partitions.yaml
> +    type: object
> +    additionalProperties: true
>
> -    patternProperties:
> -      "^partition@[0-9a-f]+$":
> -        $ref: /schemas/mtd/partitions/partition.yaml
> -
> -        properties:
> -          reg:
> -            description: Must be multiple of 512 as it's converted
> -              internally from bytes to SECTOR_SIZE (512 bytes)
> -
> -        required:
> -          - reg
> -
> -        unevaluatedProperties: false
> +    properties:
> +      compatible:
> +        contains:
> +          const: fixed-partitions
>
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentati=
on/devicetree/bindings/mtd/mtd.yaml
> index bbb56216a4e2..e56dba83f00a 100644
> --- a/Documentation/devicetree/bindings/mtd/mtd.yaml
> +++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
> @@ -30,7 +30,7 @@ properties:
>      deprecated: true
>
>    partitions:
> -    $ref: /schemas/mtd/partitions/partitions.yaml
> +    type: object
>
>      required:
>        - compatible
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/arm,arm-fir=
mware-suite.yaml b/Documentation/devicetree/bindings/mtd/partitions/arm,arm=
-firmware-suite.yaml
> index 97618847ee35..76c88027b6d2 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-s=
uite.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-s=
uite.yaml
> @@ -9,8 +9,6 @@ title: ARM Firmware Suite (AFS) Partitions
>  maintainers:
>    - Linus Walleij <linus.walleij@linaro.org>
>
> -select: false
> -
>  description: |
>    The ARM Firmware Suite is a flash partitioning system found on the
>    ARM reference designs: Integrator AP, Integrator CP, Versatile AB,
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm490=
8-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/brcm,b=
cm4908-partitions.yaml
> index 94f0742b375c..159b32d12803 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-parti=
tions.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-parti=
tions.yaml
> @@ -17,8 +17,6 @@ description: |
>  maintainers:
>    - Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> -select: false
> -
>  properties:
>    compatible:
>      const: brcm,bcm4908-partitions
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm947=
xx-cfe-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/b=
rcm,bcm947xx-cfe-partitions.yaml
> index 939e7b50db22..3484e06d6bcb 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm947xx-cfe-=
partitions.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm947xx-cfe-=
partitions.yaml
> @@ -35,8 +35,6 @@ description: |
>  maintainers:
>    - Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> -select: false
> -
>  properties:
>    compatible:
>      const: brcm,bcm947xx-cfe-partitions
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-=
partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/linksys,=
ns-partitions.yaml
> index c5fa78ff7125..02ecb51fcece 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partiti=
ons.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partiti=
ons.yaml
> @@ -18,8 +18,6 @@ description: |
>  maintainers:
>    - Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> -select: false
> -
>  properties:
>    compatible:
>      const: linksys,ns-partitions
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.=
yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> deleted file mode 100644
> index 76199506d690..000000000000
> --- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> -%YAML 1.2
> ----
> -$id: http://devicetree.org/schemas/mtd/partitions/partitions.yaml#
> -$schema: http://devicetree.org/meta-schemas/core.yaml#
> -
> -title: Partitions
> -
> -description: |
> -  This binding is generic and describes the content of the partitions co=
ntainer
> -  node. All partition parsers must be referenced here.
> -
> -maintainers:
> -  - Miquel Raynal <miquel.raynal@bootlin.com>
> -
> -oneOf:
> -  - $ref: arm,arm-firmware-suite.yaml
> -  - $ref: brcm,bcm4908-partitions.yaml
> -  - $ref: brcm,bcm947xx-cfe-partitions.yaml
> -  - $ref: fixed-partitions.yaml
> -  - $ref: linksys,ns-partitions.yaml
> -  - $ref: qcom,smem-part.yaml
> -  - $ref: redboot-fis.yaml
> -  - $ref: tplink,safeloader-partitions.yaml
> -
> -properties:
> -  compatible: true
> -
> -patternProperties:
> -  "^partition(-.+|@[0-9a-f]+)$":
> -    $ref: partition.yaml
> -
> -required:
> -  - compatible
> -
> -unevaluatedProperties: false
> diff --git a/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml b=
/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
> index ed24b0ea86e5..7619b19e7a04 100644
> --- a/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
> @@ -24,7 +24,9 @@ properties:
>        - description: AEMIF control registers.
>
>    partitions:
> -    $ref: /schemas/mtd/partitions/partitions.yaml
> +    type: object
> +    required:
> +      - compatible
>
>    ti,davinci-chipselect:
>      description:
>
> --
> 2.51.0
>
