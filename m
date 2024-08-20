Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116A718E75A
	for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154642; cv=none; b=DkhqrTD8MWgWH2qATEDCkFRPbTJXAEMUx0n3Qc0rQFVl84olLNs8BrUAJ99KS0o2qDkBx/jh4VJnMneMD5gY3x1/7yQ+cH/t5ajSuBRogS6ReWQJZQHkLL8l6f/KL1ezqV3VmA+PjoqsDkcfflC4M7jApt17Rw3vscXDEq4cLs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154642; c=relaxed/simple;
	bh=mqu+zUl6X9D6f93sxCCJF2mnDHiCXHlm2Mfc68Fo06E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuHt6az8Y52j6D1i13R8wLGfg0fDSxLLJSHWUIvNyJvgb2uhXQ5x2Bb5KbQ+EfuplIz02AOiEoANcvamr4T/9qXTy2BKPjSOdV+U3E1PqLEfSND9XNG8hvYHcpgcX+3BQzoZzBntDHdzyyZ87q41B5+2TsAyr4W/k3qGLe00RaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C9cObCYO; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9cObCYO"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e1654a42cb8so556464276.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724154639; x=1724759439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FlNvcC8AuUIcreI5Mnui6pLZVwffrglnnBdB2303BJE=;
        b=C9cObCYOexsF0MXxhSQ0JRTIMKIIv5mdti3CJzI4VYvEIipsxnJv+/c+uy3eCT4a7y
         9leXHG+m7fRVXpBni/UBkreNaWquGe5pXyzRvVfWQQU4kYB/Si2eni/hRkczi9tseGf0
         uSo2dZUpgUj7HR9nKx9A0J5vC6BVgjIsu7y4xqdDhjT8cPOxrauHuom1wl7CllxeDcyr
         lfRQ7dIXU/0PQRD1hmECFUKumgVvjaGvDHchw1BLtgCITLpAJAP/5NlJjg0QCQQJxsAE
         B3fhcCLTbHqzlLC5aFfu/tNR6JGXuNWvMuEFsBaah4tFI7nfsh+NrHH1Hcc3QqhEH954
         1LRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724154639; x=1724759439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlNvcC8AuUIcreI5Mnui6pLZVwffrglnnBdB2303BJE=;
        b=sBGuPO0G8YhSWWpfjqKL0mWpy2naIOoMiVTkmz3rFoM5xUaBDjnGli8y9KLGp1fQWd
         9x9hyIUlSqKEKMGMAK7VFQD/l1K7XCNhKxXrNEWDT7rmNKDibjNtmWLZIDu+wjaeB45R
         slYxwnCCCU6vHhBLlpEsLT+roEeJfQuLJIG2MWLAMstJhmMcsYR9IOVU7u94RbyqJDwn
         ZNy2TPifELVhSxvCAi5t4plraQaPpl2IjYuM3vfGkA1EwjjZD1kXjpq3gC8J4wkpL04f
         K3+xVzBXRSHRTw/EKU/7Io7gjhmnxsy8XZdux5fLi1q4bR+aE6aEgpHypmmuQsZG5zLX
         yU+A==
X-Forwarded-Encrypted: i=1; AJvYcCWIOD5XrQBTqR6hT37lA2qb50MEJwBJOJrAUMdLpuB30YM5sO1u3PliZYecHA00p+eY0p0ySc2/OXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvuJ2uoPmxlPIMcqikrI4AqpqhiF7A+W9VrJX4TN3uJYsQo8Ig
	F1nFORPsyIpjBDtTan/2Pk/iZvp8Eg+A28EXoN348waX3yh7RwKLenkHfQC5BX8+0GWTEGEKr3s
	B0FKdOFtQG3I0K7muqsPUrrHe7YxMr4VGy66F4w==
X-Google-Smtp-Source: AGHT+IF+VTVxHiNVj6hPP3k5Ib1ma5eJfAGMXGeEZ5yHCDH3TQ72vmA/Si0268nLARdDdIAk7TAtRCsPfyEdSpUHw4k=
X-Received: by 2002:a05:6902:2612:b0:e16:1747:732a with SMTP id
 3f1490d57ef6-e1617477734mr7970816276.38.1724154638960; Tue, 20 Aug 2024
 04:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818172923.121867-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240818172923.121867-1-krzysztof.kozlowski@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 13:50:02 +0200
Message-ID: <CAPDyKFrcdk76CPCVRLLfRVT4BKMRQFJjZVV8ss-u1NegSf4fkQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: add top-level constraints
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Aug 2024 at 19:29, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Properties with variable number of items per each device are expected to
> have widest constraints in top-level "properties:" block and further
> customized (narrowed) in "if:then:".  Add missing top-level constraints
> for clocks.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 1155b1d79df5..6d4a1faa1c4b 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -77,9 +77,13 @@ properties:
>      minItems: 1
>      maxItems: 3
>
> -  clocks: true
> +  clocks:
> +    minItems: 1
> +    maxItems: 4
>
> -  clock-names: true
> +  clock-names:
> +    minItems: 1
> +    maxItems: 4
>
>    dmas:
>      minItems: 4
> --
> 2.43.0
>
