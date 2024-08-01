Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC1188019
	for <linux-mmc@vger.kernel.org>; Thu,  1 Aug 2024 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510116; cv=none; b=M5xiQHuVfTuC7P8KTvlcOxL3E5cbzDMk1sIWrUM0hlvma7key1wxwMvqv/MMCdfomUqSmS7rJhYroLrn1H/jlj9O6cceGS2hhlwUwM9SYBgfEicrtfwTU1Dyj1I+X/h+sKNnaDWJVcriFvXAaRSAsSeauVrORTV6MOcgCakRkzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510116; c=relaxed/simple;
	bh=PDTx8zjwXbXzbNWfOuMH0iA/PcBbphotz7ExTZjHXjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HS3xvDsNEDogpNA8zb2ktMyCH7N2KXXtwMmRm5jkJReIReEFKEUUCvuDxEvBiPdunhYDxAF14rSvilAEeDqx1YVNNpUH10ZoDxV/DaTm5ySo3ZTgvoZLOepaNuVDHLL5Yzs4qywPaEiM58sb1YkJy/roKlqb9EEddGHRz6qOKtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xwmMacpC; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xwmMacpC"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e04196b7603so5144866276.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Aug 2024 04:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722510114; x=1723114914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xf663Oxqn+Hg/bp3CbFPSIMYObW/RVLrZF4k/w+9/Rc=;
        b=xwmMacpCpRTKt9lDC4rBFs3WZ+qNGsRqxxnz+5c/cHCcZ7XvODk3qZVe/TGJ0MXmrM
         b8LW4Yed4BuQVU/OQ+O22BAZ5AM5Qz4MkmR3qmUUqUqQ7H5ogYtz6MLfXCNq2h4b/LD5
         /RDyEGQah+8Pt/TLw6DoWKLudCkQghjhae7yX7/8mzcWYXVDKcvNvx55emyEladT8ifp
         G+TpEE7qT5UXzjUbQZLQyj5G56IVtc8pru5vcdnco5rsbz8qkR3J4a0RanocBc+l4y6a
         toh4YymmyYkuWZi+kr9EX3fH/DOkE9Z+Re6KPbgavd3gHH7j64I09xZlU1S0I5WEakYT
         g/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510114; x=1723114914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xf663Oxqn+Hg/bp3CbFPSIMYObW/RVLrZF4k/w+9/Rc=;
        b=H/lkJU7NoINwIJSz4VP3Bxr4HAU1+92DK7MbPFJvcHg4KsFd4n9XexEcj6W2/FV6ia
         Iz94cxuJTFZqpl7qgTQStzgP9kylRBOOdjYY5lXTxHzXjE/6V3acXzLBGbjM0W92emwP
         mKO5rWbq0OL11AoI/40iRuoWY+e6H003U1oA32xXA4xnrW7l2OewzmhsYQpbP+r5r0wJ
         xK7a7CU+GhTZojLV4j7IrezrZHviISUIds2KfwswseH/gXHDHoESaDCIDFyEd2GWuRDv
         tkmUC2ihOcYevEvubFRDySjAUGBIw5qhcVPOJDFJEiFjTAMcfXG4ztYE+tcI64NOGlT1
         RNeg==
X-Forwarded-Encrypted: i=1; AJvYcCU6dw47iH0RMKiaOvQqEYFpAH/nF7qynP5kZTd1J5hIUbuFUpGnSHhsEV355IQN7Mqhe/WpWi2j2KKIwllg67REZcTE67C+x2Qi
X-Gm-Message-State: AOJu0YyV9hATFXxfeypnbKyGenO+MRWNLavWCiUnTbAFNIcNhGnThsSN
	OVwyC0lXrZJHP8uXzmWEzF6Cs8YadAOtn7724wiXxKK+MZvXKQjku6hb9OmjfMBe42npILRTbck
	RSqW/xEqykan2wEeRWNNyFvdfXUgTmFRECnumPg==
X-Google-Smtp-Source: AGHT+IGz8BY1lj9zv3tlXj5dYR89gFHb8pzgw3f8o7RUzA9kEaL9W7hkxl5EaciVMR7U8IJTC1gV5bcO0wGy86mIQic=
X-Received: by 2002:a05:6902:110d:b0:e0b:bc96:550 with SMTP id
 3f1490d57ef6-e0bcd25c795mr2527077276.23.1722510113989; Thu, 01 Aug 2024
 04:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724182119.652080-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240724182119.652080-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 1 Aug 2024 13:01:18 +0200
Message-ID: <CAPDyKFpP7VkXNJZ_uYpnO8=bH9k0P0qq-JVBfYRC3QmsM=ia1g@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add SD/MMC support for Renesas RZ/V2H(P) SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 20:22, Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Hi All,
>
> This patch series aims to add SD/MMC support for Renesas RZ/V2H(P) SoC.
>
> v4->v5
> - Since the SDxIOVS and SDxPWEN pins can always be used as GPIO pins on
>   the RZ/V2H(P) SoC dropped adding regulator support.
>
> v3->v4
> - Dropped 'renesas,sdhi-use-internal-regulator' property
> - Defined vqmmc-regulator in top level
> - For special handling of internal regulator now using of_device_is_available()
> - Fixed comments from Claudiu
> - Rebased patch on top of https://patchwork.kernel.org/project/linux-renesas-soc/patch/20240626085015.32171-2-wsa+renesas@sang-engineering.com/
>
> v2->v3
> - Renamed vqmmc-r9a09g057-regulator object to vqmmc-regulator
> - Added regulator-compatible property for vqmmc-regulator
> - Added 'renesas,sdhi-use-internal-regulator' DT property
> - Included RB tags for patch 2/3
> - Moved regulator info to renesas_sdhi_of_data instead of quirks
> - Added support to configure the init state of regulator
> - Added function pointers to configure regulator
> - Added REGULATOR_CHANGE_VOLTAGE mask
>
> v1->v2
> - Dropped regulator core API changes
> - Updated DT binding
> - Now controlling PWEN bit via regulator api
>
> v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20240605074936.578687-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> Cheers,
> Prabhakar
>
> Lad Prabhakar (3):
>   dt-bindings: mmc: renesas,sdhi: Document RZ/V2H(P) support
>   mmc: tmio: Use MMC core APIs to control the vqmmc regulator
>   mmc: renesas_sdhi: Add RZ/V2H(P) compatible string
>
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 2 ++
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c           | 1 +
>  drivers/mmc/host/tmio_mmc_core.c                        | 7 +++----
>  3 files changed, 6 insertions(+), 4 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
