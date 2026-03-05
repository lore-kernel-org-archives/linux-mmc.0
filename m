Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F8383C7D
	for <linux-mmc@vger.kernel.org>; Thu,  5 Mar 2026 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711836; cv=pass; b=k6Vr4MWbv2fETSpmmI5WXtKIr4BJAF1cigVZ4e7T42g5f6uJi5dusXzGzxQGoXmkN+DOL6/BkWs38zMPl4JVKIhnvptQUlRJJZkUmaJmazPxZSjDLtDSvfO/23SfLaCdZ+J4XhbnJ7AYfUjSo9sLNOh8Qrcp+VgTIo3f2eTEbLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711836; c=relaxed/simple;
	bh=1UGyEXtFp2NCUiehBRnGs11aEgs//ewe9LPC+9UIH6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yh0F8cymD24AVUWE1N0jn7IcPrFqoiW2HFcI0F2EU9L7gAyFx96OuT27WsySJkykGjmy6fa7T+/m6L93LSmhIpr7ZLJn30nseUJiETFqLFG1ZJu92HAWx6Y9Eb/96coTlhOWU5Ppe7SVz8bp31hAX6rmYlyRVjudkVaO8Yj8Cyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hFd0iBHi; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hFd0iBHi"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a12cd0bcd8so938947e87.3
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2026 03:57:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772711833; cv=none;
        d=google.com; s=arc-20240605;
        b=Ecy8EZKf6eUpgvBHVgkiGQp/eeTuorokYNTaZ0c1n6veFNISG27yF+CkZsEWkoeOGo
         vdaOh9bdRP8FGO+Rbjsc317QNr8YqBoL6HAMp3Vu474Z/iPN62zbESIMRDjESCOjldRa
         KJK+YolK8b0HL1DzbIB81+XpHbtesPyZnkFRGuUuGTTUcZKSiSxNwF3A4sywYDBpTU+j
         eaQSqbCowqn7UbzN7Ynduihw5Vc34/S4ERJI58rEC0XK7vFzAjawGrqbgKYKxVcg/c0w
         VjpQ2g+k2Nq2zVZLpKjmLenmMTMUGHEnSOkmL2CMnV8xyROB/N3vZXA0RaVHwFq7Tkod
         4nrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ALDYRPJkWtMzKaRnbmNmHj2U+4DhNXkwv052yxudN8M=;
        fh=bHThfr3hmWeer24G7gCPlH+bY0q1/+Kzc9qGJ1NFg78=;
        b=TtMmUPWKVa9wXg9zEBGYi+ShCAzr3UKVYvBtY9dNUMDQv87r3fwaFqZQHQl9chj4gv
         xRcCwboOp7bZkyQhiXCCsuT6cNPtYANzVildbnL8PmwrRR09HgcQPotmhKotfF1cYa7c
         gOHrlv0NtQLiX/jU/OyGezjirOOxEbs2jO/lXQ9P8XQ8u7OaznlHg/i4Byhu/Io/wc1c
         Pf92QDJsycJuloHy8ridBqkoA2px8+K8qnm1zG0DnWEfgPK8zqJ604ZRPDD7qWeFPy9I
         6SaHealhguLop1C1mYwvblf1GNT2DWdHCrMzfJytJrvy/4sXOyJnRZg7YTNlpWaO+gs4
         lFRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772711833; x=1773316633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ALDYRPJkWtMzKaRnbmNmHj2U+4DhNXkwv052yxudN8M=;
        b=hFd0iBHii57IkOq/r5sRlys6bKBC3vr3XQ1L/+YsMiEuWDncJut2WIJOsm/LDxrTqk
         vECh8E/sdxS+DRuYkeJOnh96zQFl2G/gIu6jNt5vG6VpYyBDWfS04hAWjUzgXG7oMm7r
         exwA1MPXEB8oknqM2zHazCSgVjf/+LUjUeCCNKlZoByQMwWO3YkvmbRv+o9GS07XKKdx
         FYULTgyVGE/iJ6WW+t1TcqG5QxIsG7RHrZeqOyPTP+TW6z7n2nX23GL7R8A8L4RexZx0
         AKRKiMP9Pw62cqNKRSqUTkzrpSOTb/t4jq0zIX+13iyrCDEq+6otVBBRT5LzCFgVCITv
         bvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772711833; x=1773316633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALDYRPJkWtMzKaRnbmNmHj2U+4DhNXkwv052yxudN8M=;
        b=TU0Q0ULXLmnBrNSzeBTCwrn1abYZxEZlMLMwgdiJTgCSXLBcpayuyYJPNcBsP7YiVR
         FjrNodMIhHlQ17JG+nbMlNUWDcyBHDPJNY+g9STUqu+UaL/1Fg+QbUcx60WkMLCCxt6C
         i0xc7e0/K8UMuTAToU4vLgbg5PaKzPseXAnvWOnlcyMdaF2cCrYeV+kYPr9f/y7399MG
         UEAH0dAeqZNz5pBSUEu2h96LTaAvzlVyj5tG6KDWeO6l/4GpNXc1XSaK/MZyVLap5lwX
         3fLZv499J5C/jJhxWzXRrB+m1SyP5jUlZ2izENl0e2ZbCR1jj1RZIgIzyDysgy9UGH6X
         +SXA==
X-Forwarded-Encrypted: i=1; AJvYcCXe8jO00+KuwfdKbI7HAxEDQxUvufW+tupWqNR2gDp1v5vjKPOhwNnY1BBe3NSTNA244Awlz2WVvXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCYr+jtHzUomL+2hO+ndYcg1V1Cu+yg1troAXTR6ugO18aGWGB
	gSrYnKL1/bGYCTIaPmG6UqP/1qSZaR3XLPfGVuae8bfMai/lxhuJiD7NbYonwW7M+zY0tztv0bJ
	FVXeuz47TF6LFQrT4lse98xkQYeperdFhmPObhXRpZw==
X-Gm-Gg: ATEYQzz78WeH7IHoST518UlR8HAi5Ip4GQIcvuITSFoiIoJyBfOsg/3zndIAyRWv6Eo
	Hoi9ZHGtb6Bt0cOItAM+G+/m7USBNxnm60PBpAhusr2/QsOoMbGvpHshULzjLZzotzXHNoO0ou1
	TGSXw8QOdQyxiRmIGt7vUKdry40mMtt66jpmUXLwujQkeC5cucMmBJkrzfha53QRmVi5y5F1hFH
	7uk0pIu88JE6nQg8lEChFCEq3iR5ibxBrfXQbMZ2QPH00uQ37RW5g8WfxefiCavcNjugApqq1Pb
	De+R2Rtc
X-Received: by 2002:a05:6512:1084:b0:5a0:fb38:4a01 with SMTP id
 2adb3069b0e04-5a12c2829d4mr823483e87.16.1772711832789; Thu, 05 Mar 2026
 03:57:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226092614.435-1-hehuan1@eswincomputing.com>
In-Reply-To: <20260226092614.435-1-hehuan1@eswincomputing.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Mar 2026 12:56:37 +0100
X-Gm-Features: AaiRm53dRGsxW4aISbyBsrKAujqBmnb3pz0qXGRf0FeJNJ07qSS8eTpMNu2SXOU
Message-ID: <CAPDyKFrSttCUg5cG5b0LrETAu3CC15bHpC8_hjLmzZoFJ8YGKQ@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: mmc: dwcmshc-sdhci: Fix resets array validation
To: hehuan1@eswincomputing.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jszhang@kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, 
	xuxiang@eswincomputing.com, Pritesh Patel <pritesh.patel@einfochips.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Feb 2026 at 10:26, <hehuan1@eswincomputing.com> wrote:
>
> From: Huan He <hehuan1@eswincomputing.com>
>
> The binding defines tuple-style reset-names items for some
> compatibles, which implicitly enforces a fixed array length
> via JSON Schema.
>
> Defining global maxItems for resets and reset-names causes these
> constraints to be intersected via allOf, resulting in an effective
> minItems equal to the global maxItems. This leads to dtbs_check
> failures reporting reset arrays as too short, even when the DTS
> provides the correct number of entries.
>
> Fixes: 30009a21f257 ("dt-bindings: mmc: sdhci-of-dwcmshc: Add Eswin EIC7700")
> Co-developed-by: Pritesh Patel <pritesh.patel@einfochips.com>
> Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
> Signed-off-by: Huan He <hehuan1@eswincomputing.com>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
> Changes in v4:
>   - Add Co-developed-by tag for Pritesh Patel
>
> Changes in v3:
>   - Add minItems: 5 in 'else' branch for non-Eswin devices
>
> Changes in v2:
>   - Keep the global maxItems constraints and add minItems: 4 for both
>     resets and reset-names properties
>   - Update commit message
>
> - Link to v1: https://lore.kernel.org/all/20260211094736.88-1-hehuan1@eswincomputing.com/
> ---
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index 7e7c55dc2440..5cebe5eb1efb 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -50,9 +50,11 @@ properties:
>      maxItems: 1
>
>    resets:
> +    minItems: 4
>      maxItems: 5
>
>    reset-names:
> +    minItems: 4
>      maxItems: 5
>
>    rockchip,txclk-tapnum:
> @@ -146,6 +148,7 @@ allOf:
>      else:
>        properties:
>          resets:
> +          minItems: 5
>            maxItems: 5
>          reset-names:
>            items:
> --
> 2.25.1
>
