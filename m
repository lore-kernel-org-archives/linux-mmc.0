Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669AD240242
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782681; cv=none; b=FLY6Ht24PGx6B/CzrdjaB0N4rFcdLXUgFq6m48T1IgpYF5DI71Hk4utZeRItwsZ8aRzjkPkCCidR0YR4iOPRGMMHb/jg4R0eYa5sbHjFWxfIu/mnVodyF+r4pbMhkoWibS+4CKcvfqYFcveSf4hhJn/SeLNfmL5aGsaR1hqn+jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782681; c=relaxed/simple;
	bh=UgWOTZGuQDDiIxbJBPlqOCO2mm65GMRFIxvKgoDvxME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onQAPJdVl4XjY0wI1y5+gGMdJVnuM16EAfCSANsUeyyCPSbZIEZHoHBEdg2WpAcaP+Os+6Wk+mDxY+Iajz9xL/TDZrN5rLRSe1NhQZFAZLtq98Nw6LUO+4o/sUAxiFsnbIaIAazhQLIOYPtmC2N/Sz454+I6FZCmlCl3hEGZL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pdMjRWGB; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pdMjRWGB"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e549be93d5eso7751219276.1
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2025 07:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736782678; x=1737387478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WHmss5GuNuMPMuJLhtCwmXANZEgbIohfRiOzTjx30TE=;
        b=pdMjRWGBChwMkQSArt/FWlYOnKMAkNdm5rLxmczBuOHSYZ5QTQ82EajGzZheCAcC71
         GVBPA1PWx6B0znGYojwt8mLfGz2sdGtmBPrpfc9yB/43LHnHSsWKYqqxDJNy5fak62V/
         oJRH+t934TWoC4pWZOtidyhHKfPzvHFh2lCLkubETddcNFj/NCE/u0UWLxqUCNLQgeeM
         5INH7bQHNa+t69p0QXQRmmUKtqZoouOtW4G0McB68qhxOMPvW7A4sw3SD23Cdl70K1qL
         wsanF3+k9aCsz4AxLELOyu8cuVkrcsanKPq2O4k8ThFrpsYGGR9JKwGFe4yyaNvQtzT2
         RA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736782678; x=1737387478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHmss5GuNuMPMuJLhtCwmXANZEgbIohfRiOzTjx30TE=;
        b=qPp99ZJCMlc7Z3kM2wilH9DmSb8Ds8lvw+WYb49TbdhErPcDd5YNwriMoaIN+h7e7V
         Rr985txuaOrBnkS7247Q/Lv4yYrpp0S7R8BIKsmmhTlKvVt4I91UhyuZ12dspsx1T90W
         lCc8GGrPrZYQ6W8/yV1rL2eAPCMPYgiwHyvdthyhODd8FWrE4p577nT6fuZaAxHgbOCW
         kx9UIKmDu5JWxpUwYxAh5UKK3nGCSBIwvIAZVKur38IvJm6mBglI/mkVVLvujdxA4kRr
         ARfiZ7SofmTR1/OJGzcp4eROo9SDhQGXAzDJIf+YTlI9dC3gQh6wkT6HIvB6ofVR+pyG
         kMnA==
X-Forwarded-Encrypted: i=1; AJvYcCVLGWAhLj5xOLslrMVXg2g3bEkwMZY6SnMLnEFVCL2BVLi89vTGbulJBQLraGZIk1sm8U4r1mn82sY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZRnI+HtWEK8xH5Gik//SxbqnYqcZmEj8X/nt2Q+zdHo2TVFp
	0qNASkqI6tmzxEF7sJo5R8Iqpve3ZQ9K3UGEgfKl/ehUdwABndw3hzRE3jsiGJ9F/hfB6lFIAuU
	fz3KS/h9v4OBTyUINUREPX6T+z048vHYceiSEFw==
X-Gm-Gg: ASbGncuX8a+wzcT8Y7yVyTJhuhZpYsv73eGfsvz7gBqOfW0QCeh1MbbXJiZBzbZmkVw
	JUjMj4/Z7MpZfG2gUCkhoS0yFE6bfhyo0sh9vU04=
X-Google-Smtp-Source: AGHT+IHmfuzafpUqk3KxG+kn0+sH+vHEKlPScEseDnN/W27tVQ+3wEY9S4Ua75At7AAxf3Kwrj/jQOrBdgSbPpY4wvU=
X-Received: by 2002:a05:690c:3693:b0:6ef:5abd:d0d with SMTP id
 00721157ae682-6f530f28e53mr163298117b3.0.1736782678456; Mon, 13 Jan 2025
 07:37:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105161344.420749-1-ivo.ivanov.ivanov1@gmail.com> <20250105161344.420749-2-ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20250105161344.420749-2-ivo.ivanov.ivanov1@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 13 Jan 2025 16:37:22 +0100
X-Gm-Features: AbW1kvb6SL7ENMYcV-U0gwzZDQlxjULLo1-VKuQbPKeXd7cbjjP45Tg9iM2uUAc
Message-ID: <CAPDyKFoUajmhPu-xTzvjrMZUzqmECGXX-N-KLq=A6+hrwNuvWQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: mmc: samsung,exynos-dw-mshc: add
 specific compatible for exynos8895
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Jan 2025 at 17:13, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com> wrote:
>
> Add samsung,exynos8895-dw-mshc-smu specific compatible to the bindings
> documentation. Since Samsung, as usual, likes reusing devices from older
> designs, use the samsung,exynos7-dw-mshc-smu compatible.
>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml          | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> index 5fe65795f..ef2d1d7c9 100644
> --- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> @@ -29,6 +29,7 @@ properties:
>                - samsung,exynos5433-dw-mshc-smu
>                - samsung,exynos7885-dw-mshc-smu
>                - samsung,exynos850-dw-mshc-smu
> +              - samsung,exynos8895-dw-mshc-smu
>            - const: samsung,exynos7-dw-mshc-smu
>
>    reg:
> --
> 2.43.0
>
