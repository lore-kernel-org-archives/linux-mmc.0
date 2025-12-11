Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2124523E356
	for <linux-mmc@vger.kernel.org>; Thu, 11 Dec 2025 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765452738; cv=none; b=cDiVm2vrJMs6UQFh0JCSca1cfBZNWL638bQd9YaxYcReMjBdpGCWpsHFng5HFj6mtArZNEza340GUBS/injvWepsVE5PWfE4lpuX7H25wGntgu48CIPeDOK+c7D/BNDdt0dyxYbuCabqdVOo9zd3vx022rGAIpFlwWlGG54GMRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765452738; c=relaxed/simple;
	bh=NchHZPDCVbR2zKgQZ6II0ne2TAbumnNcDZoeVADXcKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i19LtZqG7Y5zwtn/gs25S36KgImB/0/U49YHE3kDBxUiDZua4buKDa2ehroZvy0PP9imw29pVs93ncKd9V1/jS8aaVtFTQwJvwro4S3ZjXwo3AmUNgKIxKPYdgB8TypEbstaLBf2bbyhg4Aau+JMOZVUyDi57tKCJbdczja49B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QQX57O8O; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQX57O8O"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6446fcddf2fso697096d50.0
        for <linux-mmc@vger.kernel.org>; Thu, 11 Dec 2025 03:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765452735; x=1766057535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vAvAduq0/fXRtJhO0coRhdPgTbJSI1bNLnmdQnPpfuY=;
        b=QQX57O8OsKuVkASZOy3qxp6if78bDgDbkjwSeD7uaKrKurvNp1ku/3MDnCE9Bf6Mym
         C+NxsqKpUWN8GaO+RapzoLI/tFEh9UW9QqyYNX0PmN9kAFmFVCqFATZR4TX2+JART4Ij
         Ww1J4foYdr6vNtt8a7tOuoiWCzh7oZhR6S70cb/Kv0KsQTQyCYa60HSECZoFp77O9N8H
         VRb0rfvZ7BoxG92nyYSOGgqg5xoWMAP23FDSPo9rP75amoW8qhfaCLkVnVG8eHhNcGb9
         vncS2Ps5PoPRn4RlbNAcuewgWJFWm6evYv1K+ckfssLI9BeMqOCvPe8FxXjDgx8FcCr/
         O/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765452735; x=1766057535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAvAduq0/fXRtJhO0coRhdPgTbJSI1bNLnmdQnPpfuY=;
        b=WA/XxIaC2PtkqMFHJG6QIpDVejcvAQPB2JYRE55UYt7CxBpbQUItXKpw1284/2RONd
         KPsC9TeDwbxRksT56zr9yPhj87Pmge8SnO/ddIVW0U5ZKOgwcgXoUUcZh9MpzGlF3b/v
         hL3QlRMSGE2OPWfJ/pchpEHT+Hp+mUZlRXa+XYDeorB+1KEWKuiD1dNfLz0+xIu9exS7
         i8yrDR4P+5li3mdwXc7ZFntNaPUFs6a313Rfc1pXC9b3Tm9jNDHwdcE2w7scSZbHgjEQ
         +fNXNmu1anS0wm6ZglS0DSOZQBzs/rDgvm4I6P9gw01uoyG2TBNF4xjzI5MEChiVw+dd
         7Ryg==
X-Forwarded-Encrypted: i=1; AJvYcCV7CX/LUoIvTgmM9KAHHvxV3c95kftlk89AIgtJjy8AY8xkmTcOvrZ4hd9We/7VRJssszYusA4pAfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd9O/qlbLtqbCpNIjtxGV9hVQPqSb69FvjkgDK4vgPNNC47itt
	KrySKYU1BiZcIbUh6IUJkwccpJDJN7D6xW4czDz8fg1LClZ62WTHkNQLhkqbvQjHYXeAeIcqJ+y
	5QzLIiOm9XwK5Mzx6yoHzq3/LeiB+6gMODLZUWagOtQ==
X-Gm-Gg: AY/fxX5ZC/QbnARoegb4fMbx7ld6Gc1UUEoM0zY53re/Mt59FMspDH3/7pAjzQWyZAR
	q2iU2MLpTy1iMWU5oi89m1Ha6t4GvzgOfb+3S9xeJMjTsSHqRceJIb4PcdUyOlTMKHwhL4i3xhY
	QdZMsg6oElujFax22pXiTIU5pcZEeEZWdWQOXD2a7CXhZDoay+Sdxx1TMj0zabRehhaRveqnlk3
	RcS8i1NwR2RAMigY7idzTya3YwLy8Zl21VzPk3v4yIPRYPjNkpwJq/0e9sTL4AxcC/intqx6Uw/
	msOu1U4=
X-Google-Smtp-Source: AGHT+IG8bNJ7GVmxCtKmkFoNf2sieoYkv2mgOPVq2xJndKf37hgXCewb4eZsd1D0ffqnRQUAE3M4kyCHgtlEMcMmN4I=
X-Received: by 2002:a05:690e:191b:b0:640:db57:8d95 with SMTP id
 956f58d0204a3-6446eb3aa4emr5006636d50.63.1765452735377; Thu, 11 Dec 2025
 03:32:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
 <20251211-dev-dt-warnings-all-v1-6-21b18b9ada77@codeconstruct.com.au>
In-Reply-To: <20251211-dev-dt-warnings-all-v1-6-21b18b9ada77@codeconstruct.com.au>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Dec 2025 12:31:38 +0100
X-Gm-Features: AQt7F2pSIRmWc3gz3aUnvZCl6QhFMFW_pPE_bkwFhLy-FhbClf3aqE2_J1pJY4M
Message-ID: <CAPDyKFrbS_3XRTSuexFxTpP1ydgvfFvXNv_tninnTqum7+92ZA@mail.gmail.com>
Subject: Re: [PATCH RFC 06/16] dt-bindings: mmc: Switch ref to sdhci-common.yaml
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Dec 2025 at 09:47, Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Enable use of common SDHCI-related properties such as sdhci-caps-mask as
> found in the AST2600 EVB DTS.
>
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Applied for fixes and by adding a stable-tag, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> index 9fce8cd7b0b6..d24950ccea95 100644
> --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -41,7 +41,7 @@ properties:
>  patternProperties:
>    "^sdhci@[0-9a-f]+$":
>      type: object
> -    $ref: mmc-controller.yaml
> +    $ref: sdhci-common.yaml
>      unevaluatedProperties: false
>
>      properties:
>
> --
> 2.47.3
>
>
