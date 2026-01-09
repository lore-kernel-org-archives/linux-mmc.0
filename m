Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB4818A956
	for <linux-mmc@vger.kernel.org>; Fri,  9 Jan 2026 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958302; cv=none; b=g++KdDf5H2xICR8txNP1n1kpDZFl4RDrMJYJ7hEEnd8hF41kp8tgvO27sx2Nae4JTHiKW8hdDqapWI5JBYGMG/lNl6AAuSR+4yJB2LtAmk/vqBXNm88sSfOpwG0u18iyEqHFh5o+b8aztQfRHPXKCPI5OwCwiBmdDtv2VeLTGAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958302; c=relaxed/simple;
	bh=sp8PgJ6KrhUSecexwuXpfnQcwIOHxluFhx5bgoab62Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtPPfTcLNibHRNIEp2la9WbXQm2oOTcOTth0fjwJVQzNe9NtEBU52WkpZodGJp2sFGKS3FgMod9TPnY6MSmC23xrHaWkyhrk8l24cNVSVScRbwbeOaOetNLWpP9rT1/dFsPEX7mPH2wKI0cFl0mZeavTUuUCVT54rdkhH5j756M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P/8nubK3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P/8nubK3"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b73161849e1so801016466b.2
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jan 2026 03:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767958299; x=1768563099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSCRQjzqMxlthpyK0S39/a+ZFZYJpJPm7XHV1APkAxI=;
        b=P/8nubK3kVwecNv0vO0/Qxr9pqzk3amMxZkOzNcYWEdN3UvFa55s7AqIjW1icXWaOO
         uTGbehpNvAMMIsZmma22ox6D1rThc+5qSJ0Edhe8fNn5xifb/duK4lcxS0wiosfv0xip
         vUMYJK+WnTz6wLybvT3jBMZNWBaBlfOUQsBt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767958299; x=1768563099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSCRQjzqMxlthpyK0S39/a+ZFZYJpJPm7XHV1APkAxI=;
        b=l1WMI4hXklg/vQ0RlprG7kscLuB23+TzhUnNFOMGCYtQ4G0Mj+X5yWvN+qwsoci8uK
         LHOnhPtSE7tZYuDz2iJZcagcDRkfNqKndPOYbYVWdYlMykR4QuP2Iq8dUWmPxyyo0qLD
         zR0NO71zRETOivlCp4BWLK3Zf1KDzoTCXqj4Ly9+TaGp4QoIYjCttv3TcSLXZaDshRwc
         XssZUnuHE3TirwYV+5CAowNk4T+1ekJnAvrxd1qV2DmIovZbfpmWYp0weo66CBwhE/0Z
         zRkrirRNSNDjzQ131iMMeCWksWPOinlIFyWJCPuBsT5NfFDIMCS9S3WTKr2sKcJx5euw
         qzrw==
X-Forwarded-Encrypted: i=1; AJvYcCWF8hMbAh+yD5iT8Vvl+xjgAYsuFi4bHrdxBHaekxtbrVcfNrNTKkfAzjtiaU9VGHXAuM/zsleN228=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+PvxphsEf5LU5xiZGpnCE4OP00sOcPAs1sCXPkIH4qZsg6U8
	RaZ6ZZxP1475du7l8LWzy7TJwou8WH4WG009dzrzX2Mix6K8c5pYqErBALEl6pln5F9kGU/mYYk
	GozLFg5m+uQ0ypxoFAjJyBjca+yWxJNZB4ytqjVeF
X-Gm-Gg: AY/fxX7u5BfUU9d6Inhg9OOb/MVQsstITtpPFLBQ7NCiK7HDbkyOb2aKxSdJpt2j/Vn
	aNuTaOH762BBFYT5brkoFchkNNADv+aTek4QCF8hY/Wr7J7uvrPLvb8uAaHuGZyP3PXHqMXQS+4
	N9h97tp4WRlWdH2/uLeNqEhgmBYBHaQwAxA6EW7xH7K1BX851EN4jdjBwKVZlQptikAV3gkP6sr
	E75DYtBDG58o6/QymOV3+xry2pdMO8Wb8LYkYXP23ZS/OzOO+gGfjFuTOSCXIRy8pVvxg==
X-Google-Smtp-Source: AGHT+IHumhVv8KY3Bg6JqD87gTvWI3jsSjLoKc+3DEfmoml5eVr0Pj1g8bymo8Pdbt3rhglv42hKSAoAOoLafZYaLB8=
X-Received: by 2002:a17:907:960a:b0:b7f:e703:fd77 with SMTP id
 a640c23a62f3a-b8445179dadmr816433766b.11.1767958298734; Fri, 09 Jan 2026
 03:31:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org> <20260108-dt-mtd-partitions-v1-2-124a53ce6279@kernel.org>
In-Reply-To: <20260108-dt-mtd-partitions-v1-2-124a53ce6279@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Jan 2026 04:31:26 -0700
X-Gm-Features: AZwV_Qi5Uf9IK7jzzaMO9Hhv7qu9_klerMUU60soC_dP-R-35zHLoPW9f0oY_TU
Message-ID: <CAFLszTj+L02si4C6TUymVQdx5fcvP_o-nMeYBAkKw_GvZhdt=g@mail.gmail.com>
Subject: Re: [PATCH 02/10] dt-bindings: mtd: fixed-partitions: Move
 "compression" to partition node
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Brian Norris <computersforpeace@gmail.com>, Kamal Dasu <kdasu.kdev@gmail.com>, 
	William Zhang <william.zhang@broadcom.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Linus Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Roger Quadros <rogerq@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Jan 2026 at 10:53, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> The "compression" property is defined in the wrong place as it applies
> to individual partitions nodes, not all nodes.
>
> Fixes: 8baba8d52ff5 ("dt-bindings: mtd: fixed-partitions: Add compression=
 property")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/mtd/partitions/fixed-partitions.yaml      | 18 ------------=
------
>  .../devicetree/bindings/mtd/partitions/partition.yaml  | 18 ++++++++++++=
++++++
>  2 files changed, 18 insertions(+), 18 deletions(-)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>


> diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-parti=
tions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partiti=
ons.yaml
> index 62086366837c..73d74c0f5cb7 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.y=
aml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.y=
aml
> @@ -29,24 +29,6 @@ properties:
>
>    "#size-cells": true
>
> -  compression:
> -    $ref: /schemas/types.yaml#/definitions/string
> -    description: |
> -      Compression algorithm used to store the data in this partition, ch=
osen
> -      from a list of well-known algorithms.
> -
> -      The contents are compressed using this algorithm.
> -
> -    enum:
> -      - none
> -      - bzip2
> -      - gzip
> -      - lzop
> -      - lz4
> -      - lzma
> -      - xz
> -      - zstd
> -
>  patternProperties:
>    "@[0-9a-f]+$":
>      $ref: partition.yaml#
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.y=
aml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> index 80d0452a2a33..0b989037a005 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> @@ -108,6 +108,24 @@ properties:
>        with the padding bytes, so may grow. If =E2=80=98align-end=E2=80=
=99 is not provided,
>        no alignment is performed.
>
> +  compression:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      Compression algorithm used to store the data in this partition, ch=
osen
> +      from a list of well-known algorithms.
> +
> +      The contents are compressed using this algorithm.
> +
> +    enum:
> +      - none
> +      - bzip2
> +      - gzip
> +      - lzop
> +      - lz4
> +      - lzma
> +      - xz
> +      - zstd
> +
>  if:
>    not:
>      required: [ reg ]
>
> --
> 2.51.0
>
