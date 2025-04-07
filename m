Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1182080F8
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041904; cv=none; b=Z37aNFAq6HJgfPO+aPfE1qizcolnnnYltVLGymTfPG5yLPl4nNY8FKiTRb6800+bU/VDHVctXnad/KcxDQ4fFx9gDGtKSakYWmt59kTpN3FbKcwOZ7AC7VQHjNkzAAWr9Fx04xWZNdtINEu9ap1mee9Gow2mphZIOkc9P9Sy5ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041904; c=relaxed/simple;
	bh=CzhGNQOmqbt6ZreL9SgDiADX5hgQoThZrl7pTv9rBpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrD8gp0ifQrB+fe3PgYTcXmxlWaobyLccvZMTTpG+rQfi+VixjVXK/aaDQl9YK6RGRxs/kdMhQu+wtcr4QlRK0CdbDAl5aQnf9M3rHDSTCWHYce6RRQ6elEIBeGO4mTZDfLckhymhQ6qTlDZK5b/GuQOGA4YcNoO0AGXK2pnnlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EWvwPlYH; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EWvwPlYH"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6fedefb1c9cso37216907b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Apr 2025 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744041902; x=1744646702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A0QGJ/98UjXJ4a82WsY8C5O3bLdEhkcOxRTFuuyhgXU=;
        b=EWvwPlYHa8i9RHio2cp70Ik8l3sNnYi5NY8tPLbBm4QSdC47IZ1VB68swwpzhm+Af3
         Qxh73ECEgZaJps7xkl8ROUg74l4GL8tNcfh4hnj5TR2EgcgMQCIm2h2+XD0exCNrdImE
         kIkEGcKG/Rcw/scP4S+3yYsV1YvcGyXpszm75VVzu9BKfdql54DlW8B2TxCijv4lwe5r
         ecV0R4+wkqwiDuOQh14AHVvNx/BKtSVNeAsc/xxznk50ahOGrtbuBsIesR+5YqkNkbww
         V2CFXrOn0Xz/Tz6FeIe3KJW1wUdUd8YfOS0bF9jZqr3mbxPo1GEFT0EtXl3i1maSM/WA
         z1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744041902; x=1744646702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0QGJ/98UjXJ4a82WsY8C5O3bLdEhkcOxRTFuuyhgXU=;
        b=Uo/e6/H0gTNlXqUURUznS8nJOI0mPFJcIVU62jh2Jokyo3g+GfdDEC2/C9t+SDhZb/
         EtEgi9x/Uzl2AlC9gRHmLqbO1m+En10EGYyb5quunptBJIyn0WRtvQknZaRST1SQTmV/
         nenCIfvpm4sIW9xSpvORtngJY0Ix8Lp/E6pL8elTszC5HEf6AmM7dSFwN66HqDnPVhlL
         4Y2zREkaFF2Kc0Ec8yL+d5jKfajajxKf48RGAFChBfd5DuERW77d2HGKAMrCVATUYMDb
         uYhyvbR3rIJPVa+8H9sXl/sVyEQ1/sqCQmPfg76bLC59qDaCtUwURkfwYLFb+XtmvxZa
         +UeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjkoIXb5bvyp8XyoaXAGfgAx+9XDWLzjc+7FUaaeeFZxhHYN6oAOL8+yW1zQQQgMS2k9WWZtbdJyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTMtiBOibYnv1PcK0Nt7/RwxPO+cWzStWqiWZELXQO3kzpTx2M
	4xiyp5L/25sg47Dg1ZT23GahLwUyzbwwjCMN1UKWfle88mS2dmEBzqcuvPDnZ+ppwjJ3GrYlEI+
	ShxcQOY4Jyi3sGnOY+g7X//ZKqEpJz5oee4lmQw==
X-Gm-Gg: ASbGncuA4OX+V2cVyxCoUFwOJdOs3MaHxv3AiCAbwsju34BCKuLoYejtbv7mtLjfivi
	X0r09OpJG8DjrIWgl5KpJ5gNGIK1HhuMOXxnkn3RzXpVhzZ68tCEBtroJ+D7/lOhGAUdZBdmnKR
	pXIA2qmZ93SS0CLNaZbGrFfrxMi0k=
X-Google-Smtp-Source: AGHT+IHANCkxzh+wubRAXgSFUnOAzH7wDOb2nf26ksZRKOBL2l6Zndanfaex8MrUBtCadQw25RKQniC/QrxXxgjj7mc=
X-Received: by 2002:a05:690c:3508:b0:6ef:9e74:c09b with SMTP id
 00721157ae682-703e1646ca9mr235838577b3.33.1744041902031; Mon, 07 Apr 2025
 09:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320-dt-marvell-mmc-v1-0-e51002ea0238@kernel.org>
In-Reply-To: <20250320-dt-marvell-mmc-v1-0-e51002ea0238@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 7 Apr 2025 18:04:25 +0200
X-Gm-Features: ATxdqUFdrsufXNsqF_X2LZ9XFXfOuIM3sa9Ny1cJzNnThlBQWgB4lSpSK4o_xFc
Message-ID: <CAPDyKFpchK3nV36MTJR71OuzaeFk2ktDAJrbEdd-oowOtg-0og@mail.gmail.com>
Subject: Re: [PATCH 0/3] dt-bindings: mmc: marvell,xenon-sdhci: Fix several
 validation warnings
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Hu Ziji <huziji@marvell.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 22:36, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> This small series fixes several validation warnings caused by the
> marvell,xenon-sdhci binding:
>
> marvell: mmc@6e0000: clocks: [[4, 4]] is too short
> marvell: mmc@6e0000: clock-names: ['core'] is too short
> marvell: mmc@780000: Unevaluated properties are not allowed ('dma-coherent' was unexpected)
> marvell: mmc@780000: Unevaluated properties are not allowed ('dma-coherent', 'iommus' were unexpected)
> marvell: mmc@d0000: Unevaluated properties are not allowed ('sdhci-caps-mask' was unexpected)
>
> Signed-off-by: "Rob Herring (Arm)" <robh@kernel.org>
> ---
> Rob Herring (Arm) (3):
>       dt-bindings: mmc: marvell,xenon-sdhci: Allow "dma-coherent" and "iommus"
>       dt-bindings: mmc: marvell,xenon-sdhci: Add reference to sdhci-common.yaml
>       dt-bindings: mmc: marvell,xenon-sdhci: Drop requiring 2 clocks
>
>  .../bindings/mmc/marvell,xenon-sdhci.yaml          | 27 +++++-----------------
>  1 file changed, 6 insertions(+), 21 deletions(-)
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250320-dt-marvell-mmc-443bd0060974
>
> Best regards,
> --
> Rob Herring (Arm) <robh@kernel.org>
>

Applied for next, thanks!

Kind regards
Uffe
