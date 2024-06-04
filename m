Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577F9145326
	for <linux-mmc@vger.kernel.org>; Tue,  4 Jun 2024 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499652; cv=none; b=C4mdgOqPsOIx0qV0KFDDs7falFfEAypXVw6LSudjzOCPrTpomQNIgFaIgn1WjRILF54n1Q0gMjnQvRv7zefJjaCPiW4U8oljufrOpxrtgaw9tVxj+HgE2sOSrUU1/K+ofe1t1EOP0xtN9IAzzec0AQrYmFgKJPiFRAeBBWnrrr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499652; c=relaxed/simple;
	bh=gkoEaXTyzcTGwsF2z95ESHnjbvRX6cwJPCJEJHD0kz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwyKHWEHbKWlh2dmDszokBkQqctIUW0YfDiEEd/QPhQLDrmcTywdXip39T/pcgCHiMndWSgJD9dn0GqOOfxpoZ4oo0At6iZpiRXMWltM5pJiedZDlRTE3dD6cIFzGqO9yyn5ecmDDW3La1Ms6wMeS6ge9bwv6UX4Z78bCSKSUMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pck8xz7a; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pck8xz7a"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfa4876a5bbso4931050276.2
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jun 2024 04:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717499650; x=1718104450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4BJtPQ73qcfI2sO7ETwV4VEq/ZHWblB62uvfMkAtXA=;
        b=pck8xz7aEQCZrXxZBnTqIUQJ/hy5CAtsO/YnI4+QTIMDaLZ/iomeFmDWIMuiuEOv2H
         cmI95gO6IS3BM1C3jdbsOzHg2NAmdNpWtKvP4DboE4PEWT2gHw3cRN2xAQ0zW3UId6HG
         qIO3XkzCY38Tqn1nzNDZ0bdyChnOHNXZCqPZqZ1pJkKBbxCtoL4LS2Z5ifWOEboVVBMG
         onQtMeGJXMeS7JF30GvwDra7+5K4S0xx3pnfd+liP8/0mZdgZTdNnX0dCNewHoi5UP0w
         SKY8xL5FCSOcmf734LZfR0qop/RzoYIA4TFibRAQm02HqW5U6hJQBFkMNobVG1rMjL31
         s91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717499650; x=1718104450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4BJtPQ73qcfI2sO7ETwV4VEq/ZHWblB62uvfMkAtXA=;
        b=Ba+l1OWM7qMDL+9iHjtvIx32/0jrB5jCUuBV4VvXajWmMIhmx/l4/1HRIzAvEWJ/gV
         DVQBSRuWWn366wTvZgoMqmwQQerr80ZsazOt28iPXEK1Y70rvqQYIYd8eBIYJDUQaEgL
         WpCPFt5+xJoc756YTVYOHj2AJB8dAbkm+orLHzwlzHBUUkUpmslcYOREwQq3twTO8d31
         EuC1D9QdMMSnfDBijmw64DHiYX8Sn0VXat5JrFFNGDu0Om8lzx9S9RlN5oXhRlUdq74m
         /XA8tet6ITwAr7ivzmiyTD+8fq2ML6ieQ8xsPQ1a4mcwKh/XYETSHS/AHid58PMRo/SQ
         azKA==
X-Forwarded-Encrypted: i=1; AJvYcCUPA/EtCh7HHWJjlTsrLzxUmeQ+lEch9bdLJr5/IwVnVmIgLiGx0vzpt6onVmnVuoi4OBfRysETrMefCiIsLdRF7p1K+j6od/vh
X-Gm-Message-State: AOJu0YwzEDiKCI6wS6h7eBQsR/MKz7rqTEw8nqenUWL9cBmDuKlddv5j
	9AKhcTpURrQ/0jB+mmW0wf9DlAJGhu03fx2i7wWsPgtrz0fXcn+U7lQnkEnGCVwu+Qgz2cPI4a7
	qhOyYrDQ2sVh6NMXcxO7+osoe26LW1U27FUSuKw==
X-Google-Smtp-Source: AGHT+IGbblsFi//5mNdWKH76B/L88CqYx2joBG7nqbVMyDK7axGNMhKFIZaU+2AbW4M8ccMJuHxy87Azife0n7bvlpg=
X-Received: by 2002:a25:acdc:0:b0:dee:998b:1459 with SMTP id
 3f1490d57ef6-dfa73c3dbc1mr11889385276.39.1717499650330; Tue, 04 Jun 2024
 04:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523120337.9530-1-quic_nainmeht@quicinc.com> <20240523120337.9530-2-quic_nainmeht@quicinc.com>
In-Reply-To: <20240523120337.9530-2-quic_nainmeht@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Jun 2024 13:13:34 +0200
Message-ID: <CAPDyKFpAtvQyfKJ6-xWEZhv259eAzuS+nmA9tcFDf_h728s1Qg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: sdhci-msm: Document the SDX75 compatible
To: Naina Mehta <quic_nainmeht@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org, bhupesh.sharma@linaro.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 May 2024 at 14:04, Naina Mehta <quic_nainmeht@quicinc.com> wrote:
>
> Document the compatible for SDHCI on SDX75 SoC.
>
> Signed-off-by: Naina Mehta <quic_nainmeht@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index c24c537f62b1..11979b026d21 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -51,6 +51,7 @@ properties:
>                - qcom,sdm845-sdhci
>                - qcom,sdx55-sdhci
>                - qcom,sdx65-sdhci
> +              - qcom,sdx75-sdhci
>                - qcom,sm6115-sdhci
>                - qcom,sm6125-sdhci
>                - qcom,sm6350-sdhci
> --
> 2.17.1
>
