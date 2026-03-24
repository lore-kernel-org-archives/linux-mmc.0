Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D2C401A3A
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364669; cv=pass; b=kHbledn6W2mq7NhR8s0KsbLFxRxOP9j98XZ2t3kRMhvNnFPKKIOGnBMWvsEt3hSNmLM6XZzjEBc1lxjWNlpSg8ty1Ls9z+cUrJ1bl7jgMG4hWGjLp7AH8QY+HV4d1f0y80QgxLjigshJvtgLXzYUP4JhRknJu1C96Qro1vr4rjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364669; c=relaxed/simple;
	bh=FQxDntrL8YL3mWkzhweOtwxoobY3Z+tpgmDJR8tTXUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cypkmBfMgWouUW/BIySlAAJooZ66wAwjKScj3LQV2w9d2FQey1VvIJKVTJ95/7v+rp70ADNst2dYYwNq+7eqjWD9YC77FXcEcUoCbG8nu7IPEtNjPLLsQSNwynZB7Y9IJnzN+h3YVVTP5SJc3G9zl3cbgUUsPiMnK3+X0Maa4T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hr+xyrz3; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hr+xyrz3"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a297a69089so740204e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 08:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364666; cv=none;
        d=google.com; s=arc-20240605;
        b=aCU37QR+7yeaEHWso4LWKjekQTvgXk9cMSgg4JPJkpks/wmq3cDCk2x7YcRMBuiYbK
         ZLye0/A+LBbQyTQoEga6AwsyoWcdYuMw3keZ8bN8hkL+E1rYiq4dH0gNHrDESIG2ZgTC
         /icDx3C5iDsa9ClnzzwSSXhe1PJw1VBpJd5MyMML3Z2KiUCH0i5VdIwrPv403ykqi3ld
         DFsqHWCNVQr8LjWPmZDH0NHkXzClikKjYvgw5GV8EtviCFNw+rze0PbhXR8nBeAkbvMo
         X4Jqe35c4tbAPII5fvKUR7UCScPm8VuLVGkghFbhjPC0tYfInL72JF2Dhw5WPeb8qwkZ
         aJIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AjCxn1Cse5cZLsfMqwS6O3xXKU9LhII7wm0gPZuu+cg=;
        fh=yMKIP1te8Lv4HAHQDpw35XBu7MoKSwLY/Xe+job+W2I=;
        b=YByu0EvaJo5moKMuSP0UUi+hezS85cfO3tXy1U+onnr1+JEVxik0AadpsOpnav2Ank
         OIcr18Di0R4H9bGZitF1hVK4uF4Az1QCEaPdiVOUOcJ1vKLjGuqx24kYI1BPjeLpbJVd
         YypnXHlBe8JgSpURo4lUjYL+LWw3Ky7Iog6qKu5XUOfpxSfYhcYuUfth2zzg4g9uURqJ
         3hv/PO6dzCjZ/xycyDyzCyTbBQOTs69tbUzJqcjXYtc0RV+Kw9994H15TPbHhOpaWSJb
         hNin/w3U+QtPSaiIczARSw+HacguPpry7+Y5e50Scevs8y6jfgLhJG13vZWFAJ+zwJ/7
         TyDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774364666; x=1774969466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AjCxn1Cse5cZLsfMqwS6O3xXKU9LhII7wm0gPZuu+cg=;
        b=Hr+xyrz33JU+GHmpkTgLxd1MbuxOVh4x8JGcWSjXeR1sI+a7E04ruOrO5HRkGDwNUx
         kMIC3kkIBjjzGBKXVXT+Qo0I3y+ZUsm7jtWy5iWVA/oM6flB1WMJOIWaxvFo/RJaVE1Y
         l8OUxpxV4A1nCNFnYqD2gFgA/358LcIlrPv7tH1GRm8GaZcKggXYBnZBAYtvgvSfhj7J
         hJXLCJFr5tOynWcmKomXKGVDJUuvLesOk9tGThN7vmNu1SmadoaaJiCrsLK41HbJdx3G
         /fjeVWLBPGfcsXjVzLo/P4vcHHrLRXkRSJCWOyfj+ur6Ilhph1rb/Q35RA3aeGnXgH4N
         oo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364666; x=1774969466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjCxn1Cse5cZLsfMqwS6O3xXKU9LhII7wm0gPZuu+cg=;
        b=M3UbpbFq0/K6jG06teM/smGBC0fgvHg8vCE9rYbiByAL+GAUIyR93dARntH+puvSP7
         /1O5X0pTRZAwOpCmx3yydrsmfURGoC4zdP6qwCG/ueGQugoCktyVxJooqCJo3fedaGRM
         S35fN9PiGJjL1kh2swoAC1PbaQOQx2HMaAAYs7RVF8Bu4rJgj/m4plL8oj4F16mTMp2P
         pE2h5d4yjZB3bTG6+I0Om/K5Z5DwOzd6sqGaVZ0yPj4Kz25kWsHb5f9c12jVh5ALbVjR
         BMq/+0q5x5VLsqrAEwqXZNwHh6JP7uGQ9qg8s6rDmFsEh4bhAtqLHnH3h51jT0B5Q5Br
         2WfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4P3f8lv4dIOGK5g7mJ6qLnhwNQmzclE9lDhGe3B7rs70NtdCmE7xaT25yK469i/D2c5CSuMYUkzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdDH9sgbpkG7s/MKuScqtYgcW/tODueMA7oS0tY3pEWKd1wXTi
	iZkIx4s2JYILDoNf4Q+SCSk7qg0CBjxObT2EzLfTneYWX/STlJYqXzy+TtaPohBgYTZ/RcxZ8+M
	mPQZYTinw/M8fX2fs5N9N7GAUsAvs8JOc/P5UQU/u1A==
X-Gm-Gg: ATEYQzzdUMCCVz0R3YAOCL3/voXmrxiT6iYzrQ/4oRwu/xfHMWwFz3oe/cn1fz5Y+qY
	o7tyeRd2t7f2MlXjyWpjsYWnceXtvA+8BBL0B8RE/ChavRNvbN8cbvpv+9yUwaEUIdvmdE8Ovai
	6BOOOOSwuiiwtNFt1kQdAdnLBzl6itcyN9MvJ9hQ+FK3JHLKQGK+j1GeGNO3fas0KnZnlgUp7R8
	SOeiB0GPZG/BCcDJo0xQFHR5dTzj6FCSzB+WquLHx8R77SU6BcEqVeJT7PkHzVhcWtOjjfB9EK+
	8A+rwg0g
X-Received: by 2002:a05:6512:318b:b0:5a1:27b1:1e0b with SMTP id
 2adb3069b0e04-5a285b5879dmr5609526e87.38.1774364665808; Tue, 24 Mar 2026
 08:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323-add-emmc-t7-vim4-v3-0-5159d90a984c@aliel.fr> <20260323-add-emmc-t7-vim4-v3-2-5159d90a984c@aliel.fr>
In-Reply-To: <20260323-add-emmc-t7-vim4-v3-2-5159d90a984c@aliel.fr>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Mar 2026 16:03:49 +0100
X-Gm-Features: AQROBzCPIbxWE8u1Ho5blhjIXaA43rjAdkegBcTuKwhyIBqFQ-RWFD1-u62lLKw
Message-ID: <CAPDyKFr5VHukeBE4Z1kVe-hUCFUCrw5roP=hT5jQC5b2X2fENA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] dt-bindings: mmc: amlogic: Add compatible for T7 mmc
To: Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Mar 2026 at 10:58, Ronald Claveau <linux-kernel-dev@aliel.fr> wrote:
>
> Add amlogic,t7-mmc compatible string, falling back to amlogic,meson-axg-mmc
> as the T7 MMC controller is compatible with the AXG implementation.
>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> index 57646575a13f8..40dccf9715781 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> @@ -19,7 +19,10 @@ allOf:
>  properties:
>    compatible:
>      oneOf:
> -      - const: amlogic,meson-axg-mmc
> +      - items:
> +          - enum:
> +              - amlogic,t7-mmc
> +          - const: amlogic,meson-axg-mmc
>        - items:
>            - const: amlogic,meson-gx-mmc
>            - const: amlogic,meson-gxbb-mmc
>
> --
> 2.49.0
>
