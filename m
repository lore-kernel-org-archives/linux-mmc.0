Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB0F3A4F2E
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058850; cv=pass; b=nmtN6DNukkguhu6jXvHv6X7DLpaVA8NMckDdapLoNGJhaFOYuI/KILsFEGvK4p+W8uelQznCXELmgTSQdD2Wm1oAv2+5Qc3tUf4bV9SzoyWlmr+Xu4xA2mBltYjOLqg2hckZbdCnM8tAlD5pp9qXGL3h5r/3Fwyf3ufJY78z8W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058850; c=relaxed/simple;
	bh=d1PKWdUH6s0xenlw75tFLRRRzw5FJdFYspjgpzFyMYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLjXIay66QqJyFHmxMovj/LBlDYCxlGDobu97FrDNm0h6s4cdEl4NNG+rSlyVPOSM1J7/rgRvFtCA4Ttdo+I6qCkQQ84EDheswSiV0CMkEV3Drk9IL0q2OXJ6cpknEc3Czik/U8VMP+QQtFMLqHDsXBGjdoeBGNVVcTvmN3/TT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DgsnBGFs; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DgsnBGFs"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a1273de95aso5975054e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 05:20:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773058847; cv=none;
        d=google.com; s=arc-20240605;
        b=Y+RLALTezeVslAgtNr+wKf9j2ERKU9e7R8vt/zjyx46hqTIUhusn2s2uG5X1ec/Bow
         4vnDuaNptWvyyaFE2JnlkgwKQwzbsVsgSqyzkEPp4YonYhA1lU1JfybMlUSD18mrIVsE
         dochGB4geN2KyxTjUKfKaozATwnava/LwiOMvPSZQ2QmgPCcnkvNY+JH3d1ey1RXOVWM
         BUhHR8tKmr8tZ5+6tCmHVqhxZpAFV2xzDTKCj7FOKkC+3sHL4Xf+SeI9pkAA+/NCmfJb
         9X1+GKQheR5hAAsYW0raWI/NA/omkwkO7ZNYpuvvh5g7GzflvU4gBgf7sY/MaYXAhweo
         Sv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6EqYkG8wu12BxjB68VgkSM5Yu2dl95wgUL2GDRyWgOE=;
        fh=h5sQEmPXVRBKQ4gueELBj7DFDPGIreq9dL5QWLBVW4U=;
        b=GsZnyVHJZoVqHKRIkLJxCdXQcUcI/4BpGEF8yCxSApTaxfnRbc8Xu1KML0l6D9UQO8
         6fs0YR2QOltOiqh5uWHR5eBUW9d/kNRziuO8hW+69gLINVLre10x4KTklvoo6AriE+uN
         5TNBKOZ2nky8WK7IjipS3kNOg+9rqS+FJRTPnoMknJiJQfGwaiU/iqx57czUtYb+Pxqz
         B8bOdRwa2SsVd8LikrXCXBSY9neC8tuL38EaKD+6OE0eAIimtu5sj14qEV6M+epovR7n
         kb5wXVt1XIASOVDGK0MGFp0MhumpP9oETTeSpSjVJTyDP11+4KFbtekpNOC1cCffJaJg
         Iu4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773058847; x=1773663647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6EqYkG8wu12BxjB68VgkSM5Yu2dl95wgUL2GDRyWgOE=;
        b=DgsnBGFsE1WPPMayo+3Zk8o2EOUxVPGgluE7U8dbvMCXer8NTJH7FSF7GOvuBIiBRk
         jslPysnWsaeuUpj96E4Td62VfOdCND7ikUYbRWzt6B8/2bkj0TV7OCr8eNNoUA35plhD
         2Vi49+J3iGec0J3VbNWyd+cX6qf4VsekscIQPpS18axkOJbSfUx59WKMZQSH2L3r+HPZ
         QoRLejIvZ/4bLe/wBOZJ3PuKT7sgsRwATYraksS2dCzF4Bc4yfynIBJzgtcSt3Qyd0Tg
         S7JnWNgaJLISdMtc7gGIfwibu8Sw0oJ5bzjNdZMbg8Y1lw/+O9BsP6byv3WZxRcxns3D
         0dYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773058847; x=1773663647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EqYkG8wu12BxjB68VgkSM5Yu2dl95wgUL2GDRyWgOE=;
        b=cQSoMDJjSYGVpkFxFJbrulgtVLbASeTPtL0TjbNm9cwgIR4xemrCgFXX80eVxbeihh
         e4x9Fs45fvaXsYzxCUCn4QigZ+x1tJy7oHIUpv26FoxYO9nweEQZ7NVC0ZsXz+Z3UA42
         avJJ6rykv1OLXFXegpK03LDRw1YC7QSgPpcMyMrV58IB09GWE7GwGkOhDMrjiF4t/BX1
         wIrWrUr38M6Te4ttC4TJdIMa9cOR+cu2ckIEEFKED6m9JONu6B/KkuXvOunf2+ByrWb2
         LZkwCxbxwlJrUm2Q+tLcyJQRDZUNdkaVIbN27CVdmsFSX1qurNKxtpliKSHXpxLotZaJ
         mHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+VI7l8jubfjZ1mIhkLJsiOv6A4d1fhiOO0eRfT9EZTv3Bmv0KGwJ+5MYXQnUMbBMFHcuY597Fyow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwakBgt1Q98A1rhl5Yci52hnipYX9mbPvyn26x6pfCLm58ckDQq
	U7uAkqtSSqSfdzCWH7qqvMWlLXg/a3v9EbqjnctthG7HBWSYYaOyzXdpwnNb6NbuHsT1lZ71dQp
	Onfg6jzT1M+daYxyftnKyT/LRN/o1ysvYNX1/iwCFMQ==
X-Gm-Gg: ATEYQzwZEoBw2LIPvSkKEz3kqMo3YZrP8LcjrSIhgBh1I2IH3FSUzSIhsKNq41FEVdu
	zcaEZOkh+uKMULaEngsz9wuihDDqOxq9WW/4aYpXsWp/VNQcm7W3Rp12e7Rv4KONbEcdxf7bny2
	2BvYTd+JuxeuBPnEksWapnCNquIRP+6YGEg2sr7F/LclwbWLlj5l36F5XTheto6inj1jpR2U6kM
	1qUS1m4n5XaiQcrlcMY/IaYXXXWMNL//fc8U5LC7EOKeCJ5pWLr6ipeQeUDzXsQFQMYMaO4ApiT
	jr4OhbV5M1pQL2iSbb0=
X-Received: by 2002:a05:6512:800a:20b0:5a1:3e94:b7b2 with SMTP id
 2adb3069b0e04-5a13e94b813mr2280749e87.32.1773058846752; Mon, 09 Mar 2026
 05:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306112742.64235-1-ulf.hansson@linaro.org>
 <3eb61c4b-2902-4a62-8246-4bed683fe326@kernel.org> <CAPDyKFosu5=gAb0QzhkACO6RhXkOFNiKKOSdwrDsezT-bx4U2w@mail.gmail.com>
 <aa85df27-ebbb-472a-a300-f8ae87080ee3@kernel.org>
In-Reply-To: <aa85df27-ebbb-472a-a300-f8ae87080ee3@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Mar 2026 13:20:10 +0100
X-Gm-Features: AaiRm51aa32cHVLFFVHfXIi249VRFQ79xzZslmYs2h8m9Fi7cSXJjiI16fG0r4U
Message-ID: <CAPDyKFovqBNr=9Ab2R+XCNWp_+3KOQJ+absJfxuR4C94zwbtbg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: samsung,exynos-dw-mshc: Make both
 clocks required
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ping Gao <ping.gao@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Mar 2026 at 14:08, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 06/03/2026 13:55, Ulf Hansson wrote:
> > On Fri, 6 Mar 2026 at 12:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>
> >> On 06/03/2026 12:27, Ulf Hansson wrote:
> >>> The current binding allows one or two clocks to be specified, which is
> >>
> >> It allows only 2 clocks, unless you meant that referenced dw-mshc schema
> >> allows one clock. I don't see it there, so I am a bit confused.
> >>
> >>> wrong, as both clocks are needed. This is also confirmed by looking at the
> >>> exiting upstream DTS files. Let's update the binding to fix this.
> >>>
> >>> Cc: Ping Gao <ping.gao@samsung.com>
> >>> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> >>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>> ---
> >>>  .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml          | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> >>> index 27c4060f2f91..3e560dde714e 100644
> >>> --- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> >>> +++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> >>> @@ -42,6 +42,7 @@ properties:
> >>>      maxItems: 1
> >>>
> >>>    clocks:
> >>> +    minItems: 2
> >>
> >> That's redundant, 2 clocks are already implied.
> >
> > Doesn't maxItems mean the maximum number of clocks? And since clocks
> > are required, it means that it's perfectly fine to only have one?
> >
> > My points is, we seems to be requiring *exactly* two clocks, no?
>
> minItems is already (implied) at 2, so I don't see what is different
> here. You can open any other binding and see exactly same pattern
> everywhere, so that's why it would be good to see here explanation why
> this binding is different than others. IOW, what set here the number of
> items to 1?

Apologize for the noise and thanks for clarifying!

I just didn't know that omitting minItems implies that it takes the
same value as maxItems.

Actually, there are quite a number of bindings that do specify the
same value for minItems and maxItems, but I assume those could be
simplified then.

Kind regards
Uffe
