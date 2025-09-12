Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114DD302162
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684097; cv=none; b=BIbz7SW2nqt9U0GjrIRe3QViPOrLS7OYYSQxCTTtdVL2kA6ow9HS1bqXNB/3qcy0RTgftRevrx6SD8jEKFI0LTMJdBxHG3DPoAyRGj0CLWSQFbCmYG1Ahfp4wo8ZVpyvkfdJW8br5f2AFFIviVruxz4LqId3t9OYvAgmaKBRlNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684097; c=relaxed/simple;
	bh=fEA2x43XLCIFZ1HAK3Qmgt2WPelPhB3G6VX1hKyr04E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAYGAFeiBtH55lyJPlcbR1wajgLK2hUxLgJHKjJutnFQ8JtQceZU4A6fwpRgsnwsq0ff4QdeJE+SWjDSh62DPWFKxxy0f4ZhL+vYBQxVbG3YeIiDpCARAUQk/Cbg8ye8SelThjBDEIku44C58HgJtSVX2sV0yY8QtRzY6kdzhXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HZY+ICV6; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZY+ICV6"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ea0150ee46dso1511428276.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757684093; x=1758288893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2bpJdu9pcJQYlguGDM8bqSYyNGG/RarwGDha2QaDV7I=;
        b=HZY+ICV6iudkiQNYe2sLLea4NT501Dw4egsi9L6nTGUS3TP4likQcWCh0l33zEkBor
         qld7HSDUKGCUZ3+K0pF4lA1NirUluSRDV7pIkFP+hsPRrt7d8IVtUvbAqpgAtK/rMYs3
         ggav0uF00M845sDJV/DSYbF8jXSMUNnFIPASX80UqZyWNik35Qs+raHmfHG/lGH+933g
         CQB8WuC2LHrS3Tdo296WX3l/jWoi+AtyWBkgtjg9iY8nsGB/DEVUNeDQ4gFAkY+ayQoe
         gMTiOLlY43MuWoA4ffPTPYUnyJz8bzYTCWyahejh6QpwdZqjTto+O57VOagO0Y1NYmte
         SESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684093; x=1758288893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bpJdu9pcJQYlguGDM8bqSYyNGG/RarwGDha2QaDV7I=;
        b=jrWx7xV7NBlleuY5bO7z2dYCFMqlCeUA0hhD7hZx8HVq7dZFb0U+/68A7eUgOg4x0a
         ahlaDoAKbHgIE2fcYob1QGJ66zhDJju9IFs68EoHVXIGAB9LdsgL7rxalQPLux9OSTxW
         aXJBNArb7f0UY6bQA6UxpoZHRJkWypo5fEUybDaozP/mXZhILKJtBaYqOEdG4f6mtdJI
         dwEmzxw+OsdG7ajn+ZHHdU7oGPZqGNpqrVun6d6xPWHbds5ldX0hJTLhpIhz7q0HsW/M
         RhrWsQu+bBmg61upkz8a1Gtz2wHFzeIwsiiIcNMThI6pUK9FMOyXajHBX1GKHFwIzghH
         xgyA==
X-Forwarded-Encrypted: i=1; AJvYcCVkxU6yT7cOh35JvgRuy8xpnygXZuVViiC37wRoIk23QSulBTFseTxnF8nl4QWDzkGr3c/c6lDyY3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0wjP/nMbtYZbvXHFC4Y65C0NOWyyB694bllX+LHU7uSBg/b/6
	7FHR7NsPVOJ0eZ3BVnNf8orml+7a+0DOUYNmrNHrJgwdjzORw+paUia5r6e0T/SX3k1rlymIo9T
	DQEzMUhCEbeZDboY0udm/VQL9ZCvUHcoAEFQZDRHy3A==
X-Gm-Gg: ASbGncuE0zubfFYXSYZOj6AAl4qWlfeAuihChHguGzAdcJay3dPmIiRuC0wzaKEivN5
	RD3BUGbKBGdKhwRRCg/TijdlKRjlf08Wbsubds/bZ+9q+N3Ny8I1IUSlLeA+tOInz+D/zzfp1DU
	ULtutxLDHIBXrbKDz4J/vgV8TiIUosRhp/Z05MN3uAODLwiWeQua/jVDiuE+kvaaOoIuqPKeNZl
	3XlsUHvPU8U9fqA7yE=
X-Google-Smtp-Source: AGHT+IEuZCNOuhgw71RPHODJCaUVdzYWPbD3/yFfpzIGoCGg4ZN37cLNl53g3621ReprRkmpK3fxKWmw69qSmb5zAxc=
X-Received: by 2002:a05:6902:420a:b0:e96:cb0a:de1e with SMTP id
 3f1490d57ef6-ea3d9a52b30mr2169012276.24.1757684092934; Fri, 12 Sep 2025
 06:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
 <20250908-lemans-evk-bu-v4-1-5c319c696a7d@oss.qualcomm.com> <aMP+cdmPkej+lPtN@hu-mchunara-hyd.qualcomm.com>
In-Reply-To: <aMP+cdmPkej+lPtN@hu-mchunara-hyd.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Sep 2025 15:34:17 +0200
X-Gm-Features: AS18NWClkCqcmoRAoe-mTGNfJBFQQqeUo2elvNw9ONlW9bzSgs8qRR9fnA2vWEI
Message-ID: <CAPDyKFoZEWyysS+WT=JBY388kFgKUeUL5hxm1wL1pmn+NUAEhA@mail.gmail.com>
Subject: Re: [PATCH v4 01/14] dt-bindings: mmc: sdhci-msm: Document the Lemans compatible
To: Monish Chunara <quic_mchunara@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com, 
	Wasim Nazir <wasim.nazir@oss.qualcomm.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-i2c@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Sept 2025 at 13:05, Monish Chunara <quic_mchunara@quicinc.com> wrote:
>
> On Mon, Sep 08, 2025 at 01:49:51PM +0530, Wasim Nazir wrote:
> > From: Monish Chunara <quic_mchunara@quicinc.com>
> >
> > Add the MSM SDHCI compatible name to support both eMMC and SD card for
> > Lemans, which uses 'sa8775p' as the fallback SoC. Ensure the new
> > compatible string matches existing Lemans-compatible formats without
> > introducing a new naming convention.
> >
> > The SDHCI controller on Lemans is based on MSM SDHCI v5 IP. Hence,
> > document the compatible with "qcom,sdhci-msm-v5" as the fallback.
> >
> > Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Hi Ulf,
>
> Could you please pick the binding (this patch) through your tree, so that the DT
> Maintainer can pick up the remaining dts changes through the qcom tree?

Sure, I usually do that, but sorry for the delay!

Applied for next, thanks!

Kind regards
Uffe


>
> Regards,
> Monish
>
> > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> > index 22d1f50c3fd1..594bd174ff21 100644
> > --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> > @@ -48,6 +48,7 @@ properties:
> >                - qcom,qcs615-sdhci
> >                - qcom,qcs8300-sdhci
> >                - qcom,qdu1000-sdhci
> > +              - qcom,sa8775p-sdhci
> >                - qcom,sar2130p-sdhci
> >                - qcom,sc7180-sdhci
> >                - qcom,sc7280-sdhci
> >
> > --
> > 2.51.0
> >
