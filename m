Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7CA1A0BCB
	for <linux-mmc@vger.kernel.org>; Tue,  3 Sep 2024 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367066; cv=none; b=VF/RTR1ND3KwqWKqJAlnAll/CnYH1aWHrPs4NmxjAxJjZmn1CHYfEuVqZ2kroYeX2cN1jm7GL+6l5zUA/yN8ZENsstGCRwZMaIc8xZGkF+ndStwc0chEQH9I9JJM0BhGE9GXu3gyj98XrTPXjE6CSuZpUWyv3y2jBGGIpxPeE9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367066; c=relaxed/simple;
	bh=w0NDR4g3yWZcVdllP+36hvrmByCu7wczMm3XTMj/jGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/wCE/yFR6rNsgWMwZKdMbJM7rFBPhCqtulO9Qfzgae4Q5WfO87xXaxDAtm6FFC5XcrycXV44Y9IX7ww+OWE596lTNsc/6ulSOBwsumx2XyFWf/bDS1JUh6wT4hs0jAm+mDZJvr4ik3Kb8hJGH5PX8Z3Xaswi5Ki5b6+qgWtCns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B4TNSYdR; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4TNSYdR"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e116a5c3922so4991197276.1
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2024 05:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725367064; x=1725971864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xRSvMnDTMDKxhA7VhtYh7uLTsocsLyQdi8v0n2nl6pk=;
        b=B4TNSYdROzfSRY2GSYbhWSiTJ2y+IProWkB1BIpcDNtrVd8Vg8k38hVWC3aoFTjSZd
         B1U5eIWJZ3QRkNkowCgI5SVw6csdua6+V6O91OmPrSsiNjtjUa1OCVFc0AKuRRNOmAI3
         rQ+QwqN7MrpYOmE2ogJjEkrKYuEjniKLiPcm4IOCceNM3UZx27C1EDr1saEKbzmux6uf
         R7KoerIEh7R7v5timvpeMMnjiyJezffBhktxJ3gr2iQBGMy5qfm5hEWtuU7XxDDwe03K
         0qpxeeP/BQOEWKVTThAxpZMFn5D4xzkxUQsWcjCCxkc8LOivTFrS2hbwS7ZaaaS8nPoI
         pABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367064; x=1725971864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRSvMnDTMDKxhA7VhtYh7uLTsocsLyQdi8v0n2nl6pk=;
        b=btW91246FG/3S47EAvIXIyRxsvQ7Zj55mb1YPd2X0EbqS+orix+YVLXfr6w7EZeZfS
         tahzFKJviWsXDDuHyFmEP5jJlP1UFvX7q7ptrSQ4efpXZpfCfcZBagN5yORDKBqGtFXH
         9ZSKGtEt9MyQm7P/LW+OB8VNZfuF37+GPyUKRh/7ERfKu8hsP/BG89BHGb/oVBA88JuL
         nhNAjG8LxfuSPNXpTzRyNFh+PdT/uoN2GMssYid4v0s+vfz5xB23XSI308bXORkVJi54
         Hky5eyB82pa3sNlickz0CyAiZUpW2usD4DjB57d9EXQgfS8ZbwNVIf2QAUiBSl+FLoxC
         5uYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhHt8cuu/+lIeF+8Oowl2mfszt/nZlmuRl5a3ZiPbvd5wwKH6x4/Q0uvgKCfjvbgFaCF+awj48HBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC51SrbSFmKUD1EVt7uXk2EEpEaehpLwsOUW6SFmzTlD1pWhwa
	8IJ8ce+DG4ki1fODfJ/0u4YumbpG8rdOg+j4fMZ0XgPcz2nitooV8y1mNiXZhbezQzFg+tHI+KX
	VoaiRIRzojvNRBTe7X1KgZSmYkKp4vC316mPC4Q==
X-Google-Smtp-Source: AGHT+IFQF8b0/Dxwwp4pWzLNZOOlIYeobiuC9YLSQvh3EAc6u9FMJheFaNSQtuz4xhHdNlC0iKN7ML0RWiRLCHQ408U=
X-Received: by 2002:a05:6902:1b8c:b0:e13:c6ec:2a7d with SMTP id
 3f1490d57ef6-e1a7a1a1cdemr15286662276.37.1725367063845; Tue, 03 Sep 2024
 05:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <010201919996ef8a-db8bbe89-3c18-4dc3-bd0c-6498f09d978a-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201919996ef8a-db8bbe89-3c18-4dc3-bd0c-6498f09d978a-000000@eu-west-1.amazonses.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 14:37:07 +0200
Message-ID: <CAPDyKFrZKq69yHnA1w813b6nwy1Bn_A=1c133CSk9scO1qMxEg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add dw_mmc support for rk3576
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Aug 2024 at 17:24, Detlev Casanova
<detlev.casanova@collabora.com> wrote:
>
> The SD card controller on the rk3576 SoC stores the phase settings into
> the dw_mmc controller, so the code has to be adapted to implement that.
>
> Although the feature can be detected through the USRID register value, the
> decision to use it is based on the compatible.
>
> The compatible for rk3576 is added in its own group of compatible to mark
> that all devices compatible with rk3576 have internal phase settings and
> don't have the ciu-drive and ciu-sample clocks.
>
> Changes since v4:
> - Drop commit that ignores phase above 270 degrees
> - Use a bool instead of int for internal_phase field
> - Fix pahse typo
>
> Changes since v3:
> - Remove internal phase auto detection
> - Set compatible in own block, with own dt_parse function
> - Add internal_phase variable
> - Use function to set clock parameters based on internal_phase variable
>   instead of multiple ifs
> - Use different commit for skipping phases higher than 270
>
> Changes since v2:
> - Drop rockchip,v2-tuning and use compatible-based detection
> - Fix coding style
>
> Changes since v1:
> - Renamed use-v2-tuning to v2-tuning
> - Rewrite v2-tuning description as the hardware feature
>
> Detlev.
>
> Detlev Casanova (2):
>   dt-bindings: mmc: Add support for rk3576 dw-mshc
>   mmc: dw_mmc-rockchip: Add support for rk3576 SoCs
>
> Shawn Lin (1):
>   mmc: dw_mmc-rockchip: Add internal phase support
>
>  .../bindings/mmc/rockchip-dw-mshc.yaml        |   2 +
>  drivers/mmc/host/dw_mmc-rockchip.c            | 217 ++++++++++++++++--
>  2 files changed, 204 insertions(+), 15 deletions(-)
>

The series applied for next, thanks!

Kind regards
Uffe
