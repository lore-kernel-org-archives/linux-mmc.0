Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE63FBEC7
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514046; cv=pass; b=Crqb0X5Mv2kPYAWZvOu+5P7Iu9wXVEPT98B3R+vIUSBWTnLGoF3XvppF4pDqeLX/khzu8i9SUOgrBoIPnnT4LkvQxCb+I219SHRdl3OhYk1AnvpmX8E7ULoqC67Y0fygcMAhN3xExFVklb+03W/aj9AnhwLNm5Imn0h/qiDkFk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514046; c=relaxed/simple;
	bh=pYW7RgYPb/aitZu0xIOw+1rg+iW8B1yMUnmb+fIb5/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iB0zrJ7fL7QpsQv5BWT5GifnuXcslC9Ck1zKY5xebr7E0S6Go/ddTBXY8pV7IRI7VpKmSH/h/sXbEMPYcZEJZbRTLRH1e+Xp24ZskVXnoufVxffNWcrmTFjCNwKVQz5lc1YvJTfu9rrLNQgTZFHoDbbRFsXz/28uVT2rsLlPDZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a1ukhUyj; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1ukhUyj"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a884ebba7dso4614759e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 08:40:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778514043; cv=none;
        d=google.com; s=arc-20240605;
        b=eBXsi07m+GEdfgKeRXdzTupRTa7t7J3sSZOypbleqw8ohoGO1kpwX4XKHlPg0v0vhc
         TGbqNDS9h0WiUloJD/xFtXQfiROx/jxiDuduV80n2HXaqOogzt5QHo/VGcUpTJZkUVRG
         jKxhQ42fWFXXSd+aj0oo68uW401pQDV8tgxNheJ7WhDAESQDqnzWaDmqvISoi4DxtIlx
         ESrq5XRShnNJOKjEUARAYlQWdwNUR42eZ4jHC/UOIF0H5DT2sWPJwcse59XBtw8p0e1j
         QgwM71gEGJFeoz0qc8xzWVAKnVJSVE49rzVPHAj6Wv4BQoKjOvCXHwu4IGlg38e0WJmU
         NtWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KjChFc16W6YK3fibnourBR78yR1fv1+j9VkzA0wOe20=;
        fh=EYycR9+qppenonB/QbhtiSaMfUtj6ySd8BcNY45tGG8=;
        b=TixyXj3jw1Jigu9qDFoVTuz/Km8Ji+p6Vtv1eYCf58Ir8JWbRc2pAJpwRAs3jbJrT3
         lIOr8XXakteyi3yuMhYC5HSLv+gCgDOwdn0Dv7U2P0HTA7PRnxfQcBrt+Dx204cbgV4a
         1GKDLW4kAuyCcEWDirEltHRXHd71H705DSiRjH6hmRBeyZ+r4bm9AkqsS6yDPHfYQ4Uw
         JJF62U6xWbn3tETudk/wniZma0A7RVjXFPQTfUlLgpG/dWQ8/n58G1sUG/CY/mCsQqWz
         cyaqSldQoz3fdg5tCv3lHVI7jxP+7qfgWY8+sVn82aaqdxQscJ96HyPZ8rA1ZiO2u6MX
         2l5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778514043; x=1779118843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KjChFc16W6YK3fibnourBR78yR1fv1+j9VkzA0wOe20=;
        b=a1ukhUyjKTE726gtgTOMCKf7F2deXxfK6tsxGlpzHMG8+Y9nwqBOPk22P+dBdjBAqZ
         VQY/tcZmrT/V96CPMoa6RpKNHns/Gs7dHkzATxu4uT9GTXIqe8FAik6fmzjlpcDOnaM1
         anGAfKQZLGP8sIcksyFQ4005gQq2kh4cAZUmRA73VVejE7wXfJLvL2vbnGN1Zkj+UNWC
         PRGZLgJT640sCFtr+VBw/p4EF/kHT1tQ4fIzWhq3bv8xZx7t8sY/DAR2wwRCOvxZ4+T/
         XCXbXe6upsLV2UPk+94n5aaQvJk5IeuGF7N/3CMVAML1xO7qbdbVvICvIsrfGmm3iqsy
         eSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514043; x=1779118843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjChFc16W6YK3fibnourBR78yR1fv1+j9VkzA0wOe20=;
        b=ChUaxNvM3CBm8gqmBoDnBV49gEo8uT6004+Yy315wRtVVZUQ885HH5/nmgEBzYEn93
         GjX9cWGbphrCkbQvG2zQubDe7DjHIgotw9RnyQIE5jZJw9woNCaS0BHaYOorGN5i2hjJ
         FORvQcTCLo4B+mzn1dmX21XmsXxQqpkpC/gMd4AqL7w2AqHuzCuDVlPDgTBwJUjDWtHt
         cB8Nfa0pW6Vkedmn/V7ZQCoV24b3fheD9ovCAq3ykuXoDobu25T1GrmSCjKYnmMZQg2a
         8rf3YYNLS5KZEByvkJnaqBdR+JQAnGwjTgT7U9R+0U+YsbmbxZ0ZZc8H7zdhDo3qYdnH
         yzpw==
X-Forwarded-Encrypted: i=1; AFNElJ8FYQAJhKsNHMBicpYeOxOSEBKDVtO55gtUJduOSq2H2+yBjN5+fjzsIEdYefA90WDffce5ETtizK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYIlZzCZLv6Bmnys/dWmkQCdc+4bYAwn2C/sEhE2o2eW0FOD/u
	j4dqv9w75dqn3ULp9r//Fa752eJ6TsTAZuD6Zv5UoBBgOVFtNzwwEa2/aebnqqkJ8g7GMbh92N9
	mMHpAz7r5D6GDDfJdZoiJK+617no44bY6V/yK36Biew==
X-Gm-Gg: Acq92OF54wpniJ3K+MG9aLE3CqR4mbnn9Zzn0rWi+kcdQX0uXkEdKtcNqYjrkCAP+6g
	aYCWis2NfGcnQI2Q0LKX0JZXnBpIq1Vp207oP98IkNPr2ALZIeo86L/43Lnq6fuGT50h1cC9uQZ
	jlgQU6mTn6+YES3iei/l+yuLPPn6+rnZj6yLbzdWvnSjpFWusQsnhdppikOJaTaWD/rxlF0lznG
	WQ5D5PyQ6sNSe0x6wtYsVp6/DNTf8Db7AKqOkmPXVELBMxqs5wjebSFWg+xb9toYw+ULIJFGN2Q
	mUC4spFa
X-Received: by 2002:a05:6512:3a83:b0:5a8:6e64:e88b with SMTP id
 2adb3069b0e04-5a887add6d3mr7544636e87.4.1778514042559; Mon, 11 May 2026
 08:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504144534.43745-1-marek.vasut+renesas@mailbox.org> <20260504144534.43745-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260504144534.43745-2-marek.vasut+renesas@mailbox.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 17:39:49 +0200
X-Gm-Features: AVHnY4LAe4jSY9ZIU0Jqqg3bAkBng0JF_5D_OZzU-aQcORXNKnNE7TuCtsiJ2MY
Message-ID: <CAPDyKFrDzA-dYF58_N05JCTqdgvPUMvXF+FKeyCFivLyhw5_6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: mmc: renesas,sdhi: Document R-Car
 M3Le support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Brian Masney <bmasney@redhat.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 16:46, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Document support for the SD Card/MMC Interface in the Renesas R-Car M3Le
> (R8A779MD) SoC.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Cc: Brian Masney <bmasney@redhat.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Ulf Hansson <ulfh@kernel.org>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: - New patch
> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 64fac0d11329a..4d66966ce2900 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -52,6 +52,7 @@ properties:
>                - renesas,sdhi-r8a77980  # R-Car V3H
>                - renesas,sdhi-r8a77990  # R-Car E3
>                - renesas,sdhi-r8a77995  # R-Car D3
> +              - renesas,sdhi-r8a779md  # R-Car M3Le
>            - const: renesas,rcar-gen3-sdhi # R-Car Gen3 or RZ/G2
>        - items:
>            - enum:
> --
> 2.53.0
>
