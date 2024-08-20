Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A5018EFE6
	for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154625; cv=none; b=AvsI3hP2/PDywfOHDYJ++lWUWDJeapnkJGNt0wpmF7EkFE/wWpi+XnQvKORZOIU3jLw2f5OzA+AgnFGKpelyr1Wj92bC5Yr5oPiDhFlceTvs7es2B5ODJhN5eJxjd7SfgHzlHGHZzjTtP/wrN8Q/+xO7p53nrV0rEl2m0V23fao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154625; c=relaxed/simple;
	bh=IcBYd0In6vCgACRZeqarugL/3ETP63zXXDTjjizj93c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PULMXZckoXnLI6+4y1tezw0FlU3ztkuFLI4wNNebqCw+JEYjU3FB2yexsdK4rYuqk8oTKruXymE7rYiWmPJGCz7nhsNg5haa5dLtdjhMa2QcRwoO50vQ1q9NPKoWSm6P2MFoxT+e5the45ttVBkp0yoo7AuCezc9RqOCHRVSkBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KCGi1SFi; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KCGi1SFi"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e165825ebfdso439200276.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 04:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724154622; x=1724759422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iriHVArMljQdLri/Yu9Nfjv59wYq9jCnrGoMZhIUOa0=;
        b=KCGi1SFiJ+3w1MLpuIhbz5lmHKZL+HNiVtKiGg4tm/da3N6F+sg10bCogMd88YJomD
         0OtbyAdwUwGWVXciNS7P2P97+MuHHbAFWHWkYskIPtk2Yl0qV2l5bViuBqKxC8QbtfP3
         dArWs5lo6OQ3wL36dDJL57DnPtROUIudoSBwvUoLAI4UmoiKYBNZxFGXsRaZDfvABliT
         +918bA4t/NOaW/GEHno87+yKIwU1kEpIm8OnCpkMIgsnhOp+RFvqCm3gtjiz+TZP1Zm4
         idkoT1Moib1AWWZFCjnUjRFbIjNOoLxHKTqeFTGV/B0AqPjig+h1BaN9YQhoNGzK83HM
         EVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724154622; x=1724759422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iriHVArMljQdLri/Yu9Nfjv59wYq9jCnrGoMZhIUOa0=;
        b=NA3wBrPbVzQv2MXKJ6hhRgq1zrAJJGDn+8fde0IZF4TWP7X0utl+yEpGg386MzROR7
         kD+2Kj6u+njLpTwzxIjyjulHhukuSd06D2mapVFDEQIUZQWOaq21YrdVieBBkpPKshIK
         jGgFFQUFTAY6pRktYNAOYaAWh2hKsHuDcWbUmMTZ8CrTwAV1iB+xttoya4lASGwUvWs3
         s/X7aZzWgV3bhpjaTkz5z+61rjJTiJ2XsvNBgbPRkW6Y72FtEpC1yxfte57jYYvhGXXl
         93K2rY053pujNk3vAib10CtPSu0cFGHl3x6phRjVaLyHXnoAboE4fjD23xQx5vXIqPiS
         LV6g==
X-Forwarded-Encrypted: i=1; AJvYcCVdnphqCXOR1XqatlmN7DmD2ZRjqDcOILH/BluvDJbRUBgPrWQxKOOHPB3Dddp7ydW4Lsh7IG8CQYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPqsSscG+FMzRBqbYpzmqqmX9vzuC8hTRsLBR2/McWdAI6zRIb
	7OzoubTsIacRrI3wma5Q6pFTReToBlaWKMIXEMFYkwCQQJsWmng55hV0GRioFxjCd0ZORRt1HLK
	NFkbxnmie/EAiokhj5HUTZqKEpsxr+6etzBZ04g==
X-Google-Smtp-Source: AGHT+IHILDmUK5uFVRkWb7tEwNy3ZYRn0EpoNsn7I5jbZKxJiXulmWZhkFYJDUbPgBs4x/qBekzrkEKkNeDXT0K8pi0=
X-Received: by 2002:a05:6902:2b8b:b0:e03:a227:6476 with SMTP id
 3f1490d57ef6-e1180eb123amr15095660276.17.1724154621761; Tue, 20 Aug 2024
 04:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805211257.61099-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240805211257.61099-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 13:49:46 +0200
Message-ID: <CAPDyKFqdv=Gb=JMDvUD8Cy99B-uyo6gdRwpupmhddb6Fi=7SjQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Remove duplicate
 compatible and add clock checks
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 23:13, Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Remove the duplicate compatible entry `renesas,sdhi-r9a09g057` and add a
> restriction for clocks and clock-names for the RZ/V2H(P) SoC, which has
> four clocks similar to the RZ/G2L SoC.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: 32842af74abc ("dt-bindings: mmc: renesas,sdhi: Document RZ/V2H(P) support")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 1155b1d79df5..92622d65f12f 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -67,7 +67,6 @@ properties:
>                - renesas,sdhi-r9a07g054 # RZ/V2L
>                - renesas,sdhi-r9a08g045 # RZ/G3S
>                - renesas,sdhi-r9a09g011 # RZ/V2M
> -              - renesas,sdhi-r9a09g057 # RZ/V2H(P)
>            - const: renesas,rzg2l-sdhi
>
>    reg:
> @@ -120,7 +119,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: renesas,rzg2l-sdhi
> +            enum:
> +              - renesas,sdhi-r9a09g057
> +              - renesas,rzg2l-sdhi
>      then:
>        properties:
>          clocks:
> --
> 2.34.1
>
