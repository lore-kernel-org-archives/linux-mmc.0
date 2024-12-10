Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A21AF0D8
	for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2024 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847015; cv=none; b=P9CxoGldnWHsTDrg8AZIOjrjv+wZi01FlPLuQ8YgM41KmhcOyAfUZFwfqOsw4RQf7B0/e81G8TetvjetNNL2OlHirK+FlBOILgvd0Mj7bomcZBn2mRRQ76oiMlXF2T19287sgLf33dMO8TsDZ+ukroYYNn8nEj5vmIXlSg0a1JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847015; c=relaxed/simple;
	bh=5GudjBzxvQaYsCWXxbQ6HJDgG3OjE70z3x4WM6wZ57k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7aBS2WsrDshekZdZlR20tUWqhT4ZcCpQDj7h2SDqLGx7vYlLeNIiLxBluiVpnNOBwgyfP78zf03eKvFhaXFyzTNdEbVjCRS79aOLcvOaESsLu3rl3Nmdl2JpehLLHDDsoGbLYkfhXfZ5SkoJnC8T4OEPdzlPA59TMJwcTw9B3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lEQ3b60X; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lEQ3b60X"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3a0d2d15adso3790519276.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2024 08:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733847013; x=1734451813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HNXvfug15XfoQwdKiIGBWtNC3tcA8qpMkETpkFfQs6Q=;
        b=lEQ3b60Ximaw0rRGcTaxlZOxQ+s69OIiWqzpLCeo6tBC267U7PneKNrv2zBJIPFCdJ
         lVXTzchz9SIy0P2hFOSLEJ3eLzCalMNZFGv+NNDvk8hUVVkZJKIXdNFvih1XklHcYO+u
         flV8sRufX/GuITqv7L1oVmhqmEaUGISmCLIIHjvwZh+qaMHptvjkvTSrJMEwWS0IxHvH
         I0OKtkMwTVQbnNgVO6tU+vy14RlmQWiB0m3pxoBnIiWJteW8WbWhMCrBfgEr4qlydB3R
         mybKsXjc0eVhODmSaBFPEopy++xpRmgctn8m3eJKG0m0wmLsVIq94NMkZdKQfVrYqQIa
         8f3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847013; x=1734451813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNXvfug15XfoQwdKiIGBWtNC3tcA8qpMkETpkFfQs6Q=;
        b=P/s088ZbXTtH4bUOngZO6Vcu16TJ503ZjgNykG9FAnsbIwaKb2oS9mBkYxCujOBRW8
         GCp7jIxCfKdqNjD7dSdMsHPbUPBcFTmtLP4yqNmf0c3q/HFXqO/tpZp1QAhFn45fONhM
         YwV5ACAQ03pTLddcCZQO6mYvHeia0SWcOaVZH0Av/F+Y8VWPqScRK5MZNM8QSzqXexNj
         d5UCGtZhYhBfSFjRUAK+nfN2U30wyFqhPV/7+2Otv50kfgUGE3fA3OPgu0jWtifUAGvU
         xTqR4hISR6H1XDT+IRWzItUBsoqlQLAa5bLBH8Di0Rcf7sILFtIbF8IYawARCiWDAgQL
         X3EA==
X-Forwarded-Encrypted: i=1; AJvYcCWcHYVM7scsOmw8Jl4MvMy3Ua1VShg70Ok1NMScga7cpBVbtzh1GXNh4wVmuM+5Gj3TjPhYZyIU+7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUndA1DiD5Gu9r68+VUIBPddKbJU2x9nR3sijQOLs/Pw6dg7iU
	HIIz7OR3AgOA997+RJlpGmWl0TKakVmx/6kJNVHLImxgZ2IwFXzZnac7XDuajSFimUDsIdMgJV0
	USfYi7bZjjkzOs/7q+8KdBH+50zRJ3vYZCHHhag==
X-Gm-Gg: ASbGnctjh1z9Z9D0EgH/r45vEwOWzN4G/IyFcki5DxArCMUsDY53HY714GVAvZ9GjNW
	D+VrscJqzvYyze2h5Upd1DvgT+0OiciLqhS18
X-Google-Smtp-Source: AGHT+IELbJvk0NPV36M+fcncTTHMyREVObNbnHGvfeRgsIrYaGiOwpPdOwf890kyMOnEyS8+yJEfq/uf9mQc3jRotz8=
X-Received: by 2002:a05:6902:2b0c:b0:e38:b889:7eff with SMTP id
 3f1490d57ef6-e3a0b071e93mr15453171276.6.1733847013083; Tue, 10 Dec 2024
 08:10:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-0-11d9f9200a59@linaro.org>
In-Reply-To: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-0-11d9f9200a59@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Dec 2024 17:09:37 +0100
Message-ID: <CAPDyKFon9-3U5Vn2i+WtarSAYQHnA_ho8CGQmiVoboq1tnt4fw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] dt-bindings: mmc: document mmc-slot and convert
 amlogic,meson-mx-sdio.txt to dtschema
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Maxime Ripard <mripard@kernel.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 16:16, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Document mmc-slot because used by amlogic,meson-mx-sdio.txt and
> cavium-mmc.txt, so make it common.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v4:
> - Fixed address-cells description of mmc controller
> - Cleanup '|' when not needed
> - Added review tags
> - Link to v3: https://lore.kernel.org/r/20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-0-ad4eb22c2a8d@linaro.org
>
> Changes in v3:
> - Revert and insteads move common properties between slot and controller into mmc-controller-common.yaml
> - Fix other comments on patch 2 & 3
> - Link to v2: https://lore.kernel.org/r/20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org
>
> Changes in v2:
> - Fixed description, limited to 3 slots
> - Moved out mmc-slot in a separate common schema
> - Link to v1: https://lore.kernel.org/r/20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v1-1-b7bfae886211@linaro.org
>
> ---
> Neil Armstrong (5):
>       dt-bindings: mmc: controller: clarify the address-cells description
>       dt-bindings: mmc: controller: move properties common with slot out to mmc-controller-common
>       dt-bindings: mmc: controller: remove '|' when not needed
>       dt-bindings: mmc: document mmc-slot
>       dt-bindings: mmc: convert amlogic,meson-mx-sdio.txt to dtschema
>
>  .../bindings/mmc/amlogic,meson-mx-sdio.txt         |  54 ----
>  .../bindings/mmc/amlogic,meson-mx-sdio.yaml        |  94 ++++++
>  .../bindings/mmc/mmc-controller-common.yaml        | 357 +++++++++++++++++++++
>  .../devicetree/bindings/mmc/mmc-controller.yaml    | 346 +-------------------
>  .../devicetree/bindings/mmc/mmc-slot.yaml          |  49 +++
>  5 files changed, 504 insertions(+), 396 deletions(-)
> ---
> base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
> change-id: 20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-6fa70546ebb8
>
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
>
