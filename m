Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D235158A2E
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867938; cv=none; b=oj2DzTgU/ajsmzq2wZkAtfwbVJGaYGeOXMxtj5ZD4Z3w2bgItZ5vVtJtdoOScn4WnFsEJUs27McllA2zRec47KGN9Yn3pLn/07GIhRrKGegsShrO8B7uj46+ql0W/HGYx0uN9CgcBBMS21DduHDvHir2tgGq64FGOSZQU0Do3xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867938; c=relaxed/simple;
	bh=BIJuuavrMOlGZTXnRZtJFIBi6jsUUmE/2bFNi5XpxeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s25zkEZ8F4aM/gV/nEVwfF+3dV82ZAhyzcD/Y/ST5UUiBCDRZ9kHI80Jbh23mkBgmZsQW19O9+JU7lgOs1AZ+bD35TUlfW6esvvQaXvEuKJ5TD5tvaQ6viCeucS1dOZ99wpg/4lSobgqVPjl7vNRsApjNL6v/k1znDSvls4pqZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JvGd3VBv; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JvGd3VBv"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9428152c0so2447196a12.1
        for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729867935; x=1730472735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nrOief8nbYiJuOMekAxMqg6yuzzPDCii8DxLZ9mR0vA=;
        b=JvGd3VBv4GyxKHxqlO3OtS5A7Y9aW8WI5C3XtQioof5mkInUsNYSitGjR5xH1MnTQg
         WdZpr/NNaaI9vXWunowmvckOPg0QessiRxsH+XSpOVfFQjP3hD3gFyDQRDXk7S8cCwdj
         sDYUmU65pftdWsdBRj2bvEi7STzfaOG078Nvw4ddmAjahiWQ7vwq3xJZRL6Aie7XhvIL
         SjtnFVrxKXatkC6UoMejsBoH6rkobxo3bZH3IFLsMNSF7ztnvBrU9WCL9CFlitNwNurT
         +EqA/8i/7qyBl6pvm+x/insO18akILP4vgFi+rJoB5AW8YLvikUp84yHTvDj5TWhlCkV
         nojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729867935; x=1730472735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nrOief8nbYiJuOMekAxMqg6yuzzPDCii8DxLZ9mR0vA=;
        b=YHSJqgKEaE/gYjog6mWseqG9jFKhUIP0ajvsSKzrySdTusmsYWteP3PwOYVT6SMb5B
         shL0h+/6kA4GTKhpN8JPrXescsRFhDko7Sa1L1ad0z9a35kPPsYkkP3aiLvXIN/jYR79
         Z08AKkVqGxYpMN+XF0E0dF/L3EkJ3vLNj5DJXsWV5W2osUSeT5EYm5cWgcxfbWcHsJMd
         HY5kwsnJrpK8Xbyc1H6mncjgryo3wcyHTivyzS3y4XKXskKq/k2Sq0TdmfEbX35MgCiG
         Z5uY9YYctL7JnrxdvlOY5nqWuqLMYuHNVo372o8jlCd4jhfAFqBLUitvBs15Zwwk188H
         gYRg==
X-Forwarded-Encrypted: i=1; AJvYcCWPc/ahIqsBznOogDcDHljEInJDQeieVTf/ibvU9DQfHH1E1nerR/A29BTjEFfu17u5NX3fRsSlx9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZmZv/Owskzf6rBSEeZAaZ7ggHyAzP0HBLy88WDflSmtJJMGXG
	bWIfXwVWBw3fsDPFWXwWnMqZ2adsIURuLXPawYLIwX0zNSJe2/ZyeuDzmIKQWgfB0xw5EkPD5Uj
	iHM7Ayr+ktAmjWHnm/vwYxBm+HHu+Af+5bhj9qQ==
X-Google-Smtp-Source: AGHT+IHscqiA2vwhlqzyfYQiuye1p7e18GSeto+pEBjS430QeRHPKdPaupXdrDQYhsEJh+l4Tn8aYInhGwbc5CIL1KA=
X-Received: by 2002:a05:6402:4304:b0:5c9:2a5a:5f0e with SMTP id
 4fb4d7f45d1cf-5cba249c506mr5998675a12.28.1729867934911; Fri, 25 Oct 2024
 07:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023092708.604195-1-quic_yuanjiey@quicinc.com> <20241023092708.604195-2-quic_yuanjiey@quicinc.com>
In-Reply-To: <20241023092708.604195-2-quic_yuanjiey@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Oct 2024 16:51:28 +0200
Message-ID: <CAPDyKFr-Gzd3Mzn+vN6DXO9C4Xrvpv4z5V2G_VRTzOa=89Fd3w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Add sdhci compatible for QCS615
To: Yuanjie Yang <quic_yuanjiey@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhupesh.sharma@linaro.org, andersson@kernel.org, konradybcio@kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_tingweiz@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 11:28, Yuanjie Yang <quic_yuanjiey@quicinc.com> wrote:
>
> Document the sdhci compatible for Qualcomm QCS615 to support
> function for emmc and sd card on the Soc.
>
> Signed-off-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index b32253c60919..164a45cdb972 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -43,6 +43,7 @@ properties:
>                - qcom,ipq9574-sdhci
>                - qcom,qcm2290-sdhci
>                - qcom,qcs404-sdhci
> +              - qcom,qcs615-sdhci
>                - qcom,qdu1000-sdhci
>                - qcom,sc7180-sdhci
>                - qcom,sc7280-sdhci
> --
> 2.34.1
>
