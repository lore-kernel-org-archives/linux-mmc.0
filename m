Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2C228E20
	for <linux-mmc@vger.kernel.org>; Fri,  5 Jan 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbJ96XpP"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5f00bef973aso14375597b3.0
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jan 2024 02:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704449966; x=1705054766; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n0YT8OLceLy11zfmMxqjz6DIdrrqG0STUuPfEB7KbAk=;
        b=pbJ96XpPZvRtt9VeV9GJ/L82cjAz2iLL1vQZZPYtTITK58x+TPnnkp2Wh9G8BQzaeK
         GxHsn22kOiDoisD3FYLZ3gHfi5yVHZSboUkysgE8Ir9ZDXzVrlxH67BFQ5Xr3q9M8+VZ
         xyvQJVEYdj6R3Y2OsBR7zVML4Mp2Bs05uEXK73p+/6YwJNxnwRBaW1Tnb9xY8KxIk83T
         eQ28Y7tGNoKidCxNZqV89z7jfULuJoGvnrKBL0Ht/X++QR6MkPQK3ga1PiolyprwuB5+
         25euam7QVqsn9H2kLbdrwkAn3czDL+hBVFZfDm/+S4SoEm3hODFRNKSOPHafmKoWHz7H
         D59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704449966; x=1705054766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0YT8OLceLy11zfmMxqjz6DIdrrqG0STUuPfEB7KbAk=;
        b=h1BlG9I95fyPZEkFUz3EChqbhdNPsXhOkBVeQGD1N141lPOA1EtCbaePJ5kRv+hcm0
         gZ8IemKZ65xe6t99/+mw4kYqViNXquj8oyZaFHAVIojYC7wccbP1h4qWosS3crgEaY8f
         SJviwDyHGjNpOd+HRs0VHZthH/CzOmagkaw34mLplJ3Oze3n9i4SPmivRvTQoNK6EUst
         6Kn/4DOgcUa+Le3hfT+SoOOrYEqoejDt03+/lmP9IHMLaH0z+kYXCcINTFmWKLLYmYNE
         Rg/Qt0oykLEXnSxKoD2V0hc78S94B7TdEGO9TNs5XTAYKYwLe8NBiZgHiYbD+4r2an4o
         Betg==
X-Gm-Message-State: AOJu0Yz1Rj9q1wgo0JEG3eccOXGkcjh2Zsk1ukixBMcv8CKhQgFBD70I
	p4aY8NEf2vdEoTu99Y4Iu2crvhy+sa7qVmuBenAME8/SahMEew==
X-Google-Smtp-Source: AGHT+IF39mWmdi9EttHUPrPz0qa0RofK5Aeroz/5zWy6qxI2/WB/zFMhxJQRo4rg0D0YydUCWDG0tVu59cgW0BXkfko=
X-Received: by 2002:a0d:c985:0:b0:5f0:d8f7:f999 with SMTP id
 l127-20020a0dc985000000b005f0d8f7f999mr1762853ywd.82.1704449965938; Fri, 05
 Jan 2024 02:19:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103172803.1826113-1-enachman@marvell.com> <20240103172803.1826113-2-enachman@marvell.com>
In-Reply-To: <20240103172803.1826113-2-enachman@marvell.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 5 Jan 2024 11:18:50 +0100
Message-ID: <CAPDyKFoi=AzMveZUpdx_+k8_MnqK9pgM=QvpZcstc5-RzCc_CQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: add Marvell ac5
To: Elad Nachman <enachman@marvell.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, 
	huziji@marvell.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 18:28, Elad Nachman <enachman@marvell.com> wrote:
>
> From: Elad Nachman <enachman@marvell.com>
>
> Add dt bindings for Marvell AC5/X/IM eMMC controller.
> This compatibility string covers the differences in the
> AC5/X version of the driver: 31-bit bus limitation and
> DDR memory starting at address 0x2_0000_0000, which are handled
> by usage of a bounce buffer plus a different DMA mask.
>
> Signed-off-by: Elad Nachman <enachman@marvell.com>

Applied for next, thanks!

Kind regards
Uffe




> ---
>  .../devicetree/bindings/mmc/marvell,xenon-sdhci.yaml          | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> index 3a8e74894ae0..cfe6237716f4 100644
> --- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> @@ -27,7 +27,9 @@ properties:
>            - marvell,armada-ap806-sdhci
>
>        - items:
> -          - const: marvell,armada-ap807-sdhci
> +          - enum:
> +              - marvell,armada-ap807-sdhci
> +              - marvell,ac5-sdhci
>            - const: marvell,armada-ap806-sdhci
>
>        - items:
> --
> 2.25.1
>
