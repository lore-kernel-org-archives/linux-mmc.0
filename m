Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87423570D9
	for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707868; cv=none; b=rrbc+KzWU9SG5gm41iLUabIaVLsUVHfoppYsrNok09Jx28j5LLwTMg10suFFbz3xS5DdM8FqSj8KjDrDQJatid/KgkyCj6Sgii1t5ATu0GhhMDD57TiSBRHD/3gmFo5TSj3CPpBcK/IeaIptI9CvwYG2j/zL9t9JmoApp7tYRYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707868; c=relaxed/simple;
	bh=dE9/ua2G+yDuGUrL76DK4p0HBiiblfdcYkaY/cxGS8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIjjFYZpmZ6/mPgnoQuFSNufT0KDzq1sq2oKWPMdbyehzxU+anXL7GKFg8XC6nYvy5VfhX7/dWYEXyxVandei+g1GpcHrc/JB++342ZMA2dBfhcbMHqByzwhlMR9vpVV1wmzkD8o0W6Q6YYQGqnUlX3PiLfJm+Hq6/r+IsCdwto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OW6YrPiI; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OW6YrPiI"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d71bcac45so20870857b3.0
        for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 06:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760707865; x=1761312665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f1HM0d52xL5++z1kGRjypoT65pMC3vnmCE9M/Z2HtkI=;
        b=OW6YrPiI8mXZzqqXJt3uJxufH6bnjTxOMFucnUji6RStU8NHoxAzwjcPK4FYI3IRo5
         5N71rh6FfaHLxLTteOMJpfQgVfoeaFoLigIVCYbrk9+89wooLtXjjAZkmW+T1/7z9gdQ
         JvKztkTF3sC5FN0wTfryrXCpoc42XClvMn1LtsmvqBIRVoZn6YJOHXiQW+LBTQAd53qv
         V/gPoY/0L9+tAnXZ8icBL1DRZ//5Gl7R5tXKCHCVACKNQ0p3Hj4sl/42XanyKYsi+duZ
         SRgvMwSf8tazfXfIeGWAlh+khPbu2wjRKyZc5qyyGEtu6YdQQvF/9jEubkgbjDNJxYiB
         FzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707865; x=1761312665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1HM0d52xL5++z1kGRjypoT65pMC3vnmCE9M/Z2HtkI=;
        b=iussctkAizkc2YHKWOQkvhK3CeFpbN2MWtk86KtAqpKh4HX7Ua7BBoLfAC1Yjya9tN
         KbHRytKrfh56v1eY0vJK58/R6I7NFMwXxBUl4D7xIxkpTu3PsLbFB4BvLqn8f6pG4mkJ
         ytK/gWnfj1mKq8xLSbBEDNTYZT8kLPDmtb1WEU/SRrul/wLKygAOujU+4TW+epZ2w9SV
         bTJbrTvq4VXvIYZSCVy3bw/qCzb94z4AOQ04F9FjZcwuxUIzB1TMtpzA3zsTI3HVkE53
         mA0pa6VVtecpoLlw486q/5UTjnbiNqK+R9MS7D/o/f8YEOeDt6r4XhP7Ap+p1ohP2Ee+
         Y+Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXOPRa3rXFcxTHE25lJ9YsfBlaygQjrt2o9570p1zP7CNSxVstZNo7r/dEUe7xsqre0E91OysGax44=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZwO7rvo86wv/K9THlkz6wjQLVn1ARcpUzEaUfbtohG4d4cwdb
	uhiE4tgzk4JG2NQiYWh8ptAbePZTpUB0y4LFHj92noQZdSLNM/EOlsZf60i73ulcZXcc8BsFTK/
	m3XydKxiASzk0V4rxmwGIOvRBNU+Sx/jsfmUPDwxRqg==
X-Gm-Gg: ASbGncuXq+cb13CDeWQszlrM+oyWUYkHyxaq8g/9EYYiLtHy6vGT1X2ewwclrNHRoDz
	U7mjwJGqX4r00KOd1LPpq/hCho/TdKgqgSPNu+1fyHDsw97mjXZbJqD/A5MqLPMOrcbKfTSTsSd
	u12Q5KcZL9NCSMMGpgifNXDCjxHXj54Z7g184uuGl9cOiU1HJQqYlO+aCoduZtXhmaQijJCdsQp
	yWFWX/Vdgv2WhY+Da+3wFNN81SnYHnDiLUFs6CbT3Yail6s5AvYRddJbD16Iw==
X-Google-Smtp-Source: AGHT+IE/y08spNfC3C2r2brNPGUt04U9WD7A7XI9X/3WcTMgc7vwP8JOHw/hjXOaZRx6V9A4RKsRRr1cMaZ80YFieN4=
X-Received: by 2002:a53:acd8:0:10b0:633:ac51:9823 with SMTP id
 956f58d0204a3-63e160e3c31mr3275386d50.2.1760707864737; Fri, 17 Oct 2025
 06:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com> <20251007054445.4096630-2-sarthak.garg@oss.qualcomm.com>
In-Reply-To: <20251007054445.4096630-2-sarthak.garg@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Oct 2025 15:30:29 +0200
X-Gm-Features: AS18NWAnMhRpcm4So5FqnrddWjLlUpGh3rZ6MGn4VSylaqx5Qy76TzuXLh5A2eU
Message-ID: <CAPDyKFpaza_wXUhkD44Jxh5MUGribDy6d=Wf+NNRO=B_cUBm1A@mail.gmail.com>
Subject: Re: [PATCH V1 1/3] dt-bindings: mmc: sdhci-msm: Add sm8750 compatible
To: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_nguyenb@quicinc.com, 
	quic_rampraka@quicinc.com, quic_pragalla@quicinc.com, 
	quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 07:45, Sarthak Garg <sarthak.garg@oss.qualcomm.com> wrote:
>
> Document the compatible string for the SDHCI controller on the
> sm8750 platform.
>
> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 594bd174ff21..027011223368 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -70,6 +70,7 @@ properties:
>                - qcom,sm8450-sdhci
>                - qcom,sm8550-sdhci
>                - qcom,sm8650-sdhci
> +              - qcom,sm8750-sdhci
>                - qcom,x1e80100-sdhci
>            - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
>
> --
> 2.34.1
>
