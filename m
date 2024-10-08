Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EB01E0B9B
	for <linux-mmc@vger.kernel.org>; Tue,  8 Oct 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398210; cv=none; b=n8IubM0zHwEbaGqQRhS18laxtZzie6oYTfnCeOGeLb9GHkPqzc3oCYYDnzWttVfiVa/vdr9Cf9VXYLBZK1MMHS1123OYswPopNxy9oZ7p3E4NfzHrwg/tnlTie0z773YfbmvsnUa+h35K2aEJCLGUAYTjxuNeCiiO2m5exJu7wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398210; c=relaxed/simple;
	bh=0Z1JExvdy9ZeQJ6p0A/0vey3LiyAqfmOE62rwLJZmTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwmayELhXPpEu7cvZTOeMhxCvSA5s/GZa1SR87qajd9OCRNY41M184G3q1oZV75yCClsmETr9kFgh86iqm53QU95xE1q1OF3WrANlf/NeNstNsUbKff/AGf/cUYPmxU9ccqM8vjRbK88aqW90KgzQVzq8KVM1gKL7LVK41HfhWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DVzfV3P1; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVzfV3P1"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6dbb24ee2ebso57523267b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Oct 2024 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728398207; x=1729003007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iwY3r5V9M933BYc/JpXLz8VpdD3oK06DMiHe6qdoa+c=;
        b=DVzfV3P1/xELASKTE2Y6d8IlVKVLot8vmbVzfzaw2Rs4gDpNTHkVRJHYnecJEsRCsY
         qL1Y6uQmUtHl5rHUbQLc5HhiQc3spJpTiqS3gdpBuXNh3G+Zt1MdtfW0TJZxmyTNdO8D
         aq1Q9DRW1kcvaFqilKJg3z8UhhVFFPidFgy3E/+JNFcZe2VRMzwnExKJWL/QUj74DUt5
         B+ibSxco0i2maIs60/tvOTn57sSWN+oqhFu1OxopPju73hX20BWia2XsxeJSFl9N/O7A
         Ukn21nlLqOOhZ0s2Zrk7c0UtmfB0i2aLu2mNYcPk2IzC6rAIrrHAnoamOk5WYlYErfp9
         /EHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398207; x=1729003007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwY3r5V9M933BYc/JpXLz8VpdD3oK06DMiHe6qdoa+c=;
        b=NxsO5Mm4xaPFYIbf4ZK+hQlYR7w9N6VBdFDKbpD2z+R+uya62zvJNJoW9cZylchb+d
         0FB+icozuQ7rCYvPDr+go7HQy4iWpeABo+ly+0bPaLzizKIRG0yvHrYxkZjJQU7LtrWV
         F6N44Z9cINFFZEBLu/pO1U9w43w2J8KLwkgZqMDu1dL6R8sBMYVX5LIVTeLeafCvpHwV
         xJCoRIXe2fPuU1vkr1E5hgVDPLtKK7xqZdNAoOwABL26mHKXi5U3doKpkW6R5dzMD2A2
         hYikEaoBxW1cSZFPdwQlgURmenDL4XYti5VM9vXn3CYbLemc4nNqtANpQoCY+65iXjXI
         t+4g==
X-Forwarded-Encrypted: i=1; AJvYcCUUUi7U50Aud6sNc8P/VDcwB/HS1/JutXcC34msH+CsgE/zyy/Qt73oyXgeNdVc+i8FxA8iG604df4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1gxWBxGa5G230yK/VtjymUO8vND0MlAy6aaZe8cJT/ohR3avg
	WQAIrXVzg0jzFak24bQChn0TfyCSQJP2BFtzUttcvaSczBVqLNJ4cF/wsD8VJSnZtUhctWboJxv
	+0VvzMmkKRPET8aLpcMl//zOZZ4rM+a3iLbtHQw==
X-Google-Smtp-Source: AGHT+IHCEE3cQALhziR76pWxSHYgivNkdxDE7czzTvB21/L8ltLPROWzkDkpEip7V+fuz0HUO9PqM2K24IAxVFHk8Es=
X-Received: by 2002:a05:6902:1b8d:b0:e1d:8a06:86c3 with SMTP id
 3f1490d57ef6-e28937df468mr9516417276.31.1728398207480; Tue, 08 Oct 2024
 07:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com> <20240930095449.1813195-17-pierre-henry.moussay@microchip.com>
In-Reply-To: <20240930095449.1813195-17-pierre-henry.moussay@microchip.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 16:36:04 +0200
Message-ID: <CAPDyKFq1HZxKSd-V_VnmpbQTftMDmF8SkPf11N_ELcahqo16QQ@mail.gmail.com>
Subject: Re: [linux][PATCH v2 16/20] dt-bindings: mmc: cdns,sdhci: ref sdhci-common.yaml
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Sept 2024 at 11:55, <pierre-henry.moussay@microchip.com> wrote:
>
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>
> Since the Cadence sdhci controller is sdhci compatible, the cdns,sdhci.yaml
> should ref sdhci-common.yaml to use 'sdhci-caps-mask' property.
>
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index ee3a838f7f06..0432cc96f7ca 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -121,7 +121,7 @@ required:
>    - clocks
>
>  allOf:
> -  - $ref: mmc-controller.yaml
> +  - $ref: sdhci-common.yaml
>    - if:
>        properties:
>          compatible:
> --
> 2.30.2
>
