Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E61386A1
	for <linux-mmc@vger.kernel.org>; Thu, 15 Feb 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016138; cv=none; b=aMhlK+XEspo55XnHuWo1vduwI1YHIVgFGGsycKnfs0cbQX17HD3BsRx9H71CUl5zCp6a3z5kSixemHIDVK0DTiJ8SJ/zeZQdPgv47tpG24AToHlr3oyD+S3VTN7v1L3dGITXfWoksTy32t3suWxlBhzgQTsX7jctXqakSuH6LcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016138; c=relaxed/simple;
	bh=T2n/4szixuLGXvgOOUzbiM5pm5IPW+9TOhwcsXEbR5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LM/cQOyUGNiWSPj9AeW+r6yKzo4n0cwyoqPKb3UZxw/HhLk/l6IhOxcvkqDPFWTK6iI5tCxQJo+8qKCmj5rQFdz1HenfgGYOFdaNQSVPLzFsSmdu42QOeFW0ib+xS+1z3XJtErHqHD+imw05tm78jKccFIGNbZQzsuTtAyhQtM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MXWLoHsU; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXWLoHsU"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-607e905eac6so3748497b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 15 Feb 2024 08:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708016136; x=1708620936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=poZheT8LMONbwbXG36LCp2KJuCiXKMOv0XD+rp8kofA=;
        b=MXWLoHsUzbZOipRQqvHODtlCF2KUMWTOjeTYURysSEaWzYRYRDbzyyOx0XpTK7Y3b1
         Eoq0/p3KIzN18HWNHmmei1JxOSN6HZys3TifDBabMcRFzHjP8aVjSSbAwjtvrDB8qoxB
         RlQDxOC3AXySlH+bLX3Q+TCd6UzndUGgHLfJ1x+TMU04idm+Wc4S0kEj0Xm93CLDv7mz
         kXMmZUbXBzGGro7KtGgMcuQIhV+C04j2OzGdNQagzjLA5Xe5k4rQMPlQtf7EC2NXVm3J
         y+Okcsj5kYQZVR8QkpVn2QIsldDajLWpnzoUuCdg4dG4zWMPUAwrHi+2LSSnLly4ubIP
         Ztiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708016136; x=1708620936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poZheT8LMONbwbXG36LCp2KJuCiXKMOv0XD+rp8kofA=;
        b=kMG2InOZ5ZimM7DUs3soIjvR9rlDr1eapwux41rAyt6gTVz3902gbimug+n5bctICa
         RpewdOkMEHc/ibl/OX3navitMnEmPjLMG0kjy1Kp/PTorYYDWRu2k4X958t+vo5eLW58
         3N6JyeAQGEZco7Cl3Pqan2X1YDQmNihjTDgXcQ13xHWntMWQ3ZvZ6CvY0Ewv3yC15WxZ
         A2MzLV8SD5GbLa+mw+4rb+4GjYbS9fot3kVCqIXpGMyUbbLEQERKkC52wf/yY+8XEYMB
         akF9i9kkozoTd3F8g72et/K1Tyxf4PfRB+QpMy6X3GyLVQ5ACdMQq8kcXnza5vnM9fUn
         POWA==
X-Forwarded-Encrypted: i=1; AJvYcCXyQqKEKGhGKidK/42SKpgpxe9VwSJ6IeF/8po+wA0JVDA+qMj4x886f4n6OCYacFi1/rLRHI1cQFPLZtXS03yoCTDHwUG/XTyF
X-Gm-Message-State: AOJu0YxCJ0mruVgG0LV2daNi3hq/Jyb0f7eyM+BF88E3CXW46+5kO01G
	uCuzDP9FF5rxp5+cwA0oMKPLaDE6352ptiI1oEGwM4aUpVym+lLn4cuvk5XimWlej7jvUrx7ceq
	ncB0uNLukKc76gQzRxrvlFy5B3qX7lYL6IvGzmQ==
X-Google-Smtp-Source: AGHT+IEpJGNu8IMFSpuSTsiV8rNUurQsbhlaADMNqmbysfbAkAFNijtgAVbyd6vcEq1kI+aXaqyzELrondiqZuik5WE=
X-Received: by 2002:a81:7c55:0:b0:604:9322:9d56 with SMTP id
 x82-20020a817c55000000b0060493229d56mr2291098ywc.38.1708016136169; Thu, 15
 Feb 2024 08:55:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fffc5a0a73c4cc8e8d7c5d93679531cc24e006ca.1707915511.git.geert+renesas@glider.be>
In-Reply-To: <fffc5a0a73c4cc8e8d7c5d93679531cc24e006ca.1707915511.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Feb 2024 17:55:00 +0100
Message-ID: <CAPDyKFotPHiAWux8mhjFPMG7kwqaq6u-YZ957-6_=gKnVkDh6Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document R-Car V4M support
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 14:00, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Document support for the SD Card/MMC Interface in the Renesas R-Car V4M
> (R8A779H0) SoC.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index f7a4c6bc70f6cade..29f2400247ebc674 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -67,6 +67,7 @@ properties:
>                - renesas,sdhi-r8a779a0  # R-Car V3U
>                - renesas,sdhi-r8a779f0  # R-Car S4-8
>                - renesas,sdhi-r8a779g0  # R-Car V4H
> +              - renesas,sdhi-r8a779h0  # R-Car V4M
>            - const: renesas,rcar-gen4-sdhi # R-Car Gen4
>
>    reg:
> --
> 2.34.1
>
