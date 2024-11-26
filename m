Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE768F58
	for <linux-mmc@vger.kernel.org>; Tue, 26 Nov 2024 00:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732579679; cv=none; b=ryp0iAm+dFfpdFN0Nvwuxtiqg4ipEDdk0ZMyaMVi+9aH8SoJ4VrZCqi0JrvlSgrPCeoycAKWW7Hv3hZUto0/jop5Jy9aSu0g2rY8GAij6nmkkkF+LSUTZckdBZyDxDg9E2Nclb/0KvgNRglUd6Qwcf6ld5DbCYyxc28NcUh7DHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732579679; c=relaxed/simple;
	bh=X6mpm+0aSH+yONFTblg/2zcjomYbcE73fIlBfI5RHMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/a/uYZaQBQSicodpW2xy6+RbNPu6rlpvVgmeyuj5oVLR6l8beRlnpMz5hT+wihO3Vn9zeJgi7zXYn5gdpofve6Xasnuh+RpaXYD4G2/ct/UyVkv6yD77sMKzv4o109Hy3sgpIu23xHFEkDyhU4Sdstjd6cN+iKL4mpHYjD65Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ORbQMwZE; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ORbQMwZE"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53dd9e853ccso3054580e87.1
        for <linux-mmc@vger.kernel.org>; Mon, 25 Nov 2024 16:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732579675; x=1733184475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s0h1yJRyvRJoHgt/KNNsfZgVIwPLNDSnb2kihwUErsQ=;
        b=ORbQMwZEVk0ABiGLa8623WNatb027pWFXlY4SxlKYjZ7H6G48PI8e+vuX7z1lFFXnt
         +4e65DMtXe98gkorqTPk2CxKj4HwnSIJjZxkv92okceEmwZ46K9fjGl0Gf379ZWEyUq1
         9ueVSJKq9QrAkimIZNdXTsoua3dTFiCWbhBD0VrhrEgG4xazcme8RiEneHzQlJ733zWc
         b3+7oRqHaM30Z6A3l42U4lS58K17slfycpArKk4AF95MNw+qKGJwJOhkCCwpp0hPJq34
         NI7dZVzkLQYzoKsCM4El/VLhlp7hdirxc/rCPNYMruALCbIZd/0Cbx5Cblf0Q27OYHuT
         U84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732579675; x=1733184475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0h1yJRyvRJoHgt/KNNsfZgVIwPLNDSnb2kihwUErsQ=;
        b=oWojwre4imXeernrRj6465GJT0I0l7OvAWIsPCJDFAgJG0+qv865MIwM0XeNc/Xcxg
         ov7h5rQHuaps7/cdFcuObf+mlQec/c5RWD+qYNGJ4n1PwK4K/PfQOr+mm2Tq/v/OpgFM
         1YPrQi84AxnVs8PoKD4lKAI+19prdFX3sXQwEGNblBrGP/LqPnO8C6PXR6XfHQ9b+18L
         c0JB0oZFPbJSQIFWLU4zQmVPEYGgn47lQs48fRYZ/mKF7N3tnAfgXpAiHFYRuzh8URBs
         4Pjcl3lLd+WO8Oh99c5UPtQaQK1/DSwVWY0kBSyuY2qWWffc13+RFJ1JC3yMYnr+L3MV
         MCOg==
X-Forwarded-Encrypted: i=1; AJvYcCWn43fA8poFz4pZtBT5SmDH4d/IoTSXTGTtHOBscj/RWApOq4xJs/jbAbUxJlpdJuJYy3cS7Z4EXr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDqh+3pwmj4DMB7AWuWPWgKbO6oEMlA/Lx1vqMuRRB2v0JpGpA
	KfWY6GBd+syw8OnTai6rJsIufb8En/bOYG72MLHndEL8gUeTl9TeD/sUg9NHcVQ=
X-Gm-Gg: ASbGnct3+T/bM9Q1OnK64qu788+jktGfrRYWcn/VnQaf3UMvziCT8+emToC0zVY25mt
	qnyh8dQGaeiZ1gWZvcfRghCXGH0lkZTXFGk2cLHSq9Qv/U5zk0w9ZeKUGlK8g1Ae+aY2johURdh
	CUtns1CGLeUK9xvs4u/eddN01KMz3v1NgMdDeJm5gwU6PmjZ+57k6sNEB2V0bFjYyeOrKwqzzfi
	Zuv5QveHRHxoJQN0U3E8YOB2cP7ZYv/oFcaGFGrX2enFr8GwwOrFndWB1xO4uuTNW8MWsxNpT39
	LOgTU54su7fq9gOWtFYQdMEwmVtQFw==
X-Google-Smtp-Source: AGHT+IHNAOdFRvV/LBBc9GEXqWd+CaGlgu2KPTG20eKSwEZ7/zIcGDm+IM+4HhB+6bbrWpaYrRfyCw==
X-Received: by 2002:a05:6512:118d:b0:53d:dc12:7cb4 with SMTP id 2adb3069b0e04-53ddc127db7mr3683910e87.29.1732579674934;
        Mon, 25 Nov 2024 16:07:54 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2451f8csm1824556e87.79.2024.11.25.16.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 16:07:53 -0800 (PST)
Date: Tue, 26 Nov 2024 02:07:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Yuanjie Yang <quic_yuanjiey@quicinc.com>, ulf.hansson@linaro.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhupesh.sharma@linaro.org, andersson@kernel.org, konradybcio@kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_tingweiz@quicinc.com
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: qcs615: add SDHC1 and SDHC2
Message-ID: <frjnnd7bvrdn5frfo4xnz35rb5zxa33eayu3oc5wux7casay64@t2tfbsf5jrva>
References: <20241122065101.1918470-1-quic_yuanjiey@quicinc.com>
 <20241122065101.1918470-2-quic_yuanjiey@quicinc.com>
 <7c0c1120-c2b2-40dd-8032-339cc4d4cda4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c0c1120-c2b2-40dd-8032-339cc4d4cda4@oss.qualcomm.com>

On Mon, Nov 25, 2024 at 02:13:22PM +0100, Konrad Dybcio wrote:
> On 22.11.2024 7:51 AM, Yuanjie Yang wrote:
> > Add SDHC1 and SDHC2 support to the QCS615 Ride platform.
> > 
> > Signed-off-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qcs615.dtsi | 198 +++++++++++++++++++++++++++
> >  1 file changed, 198 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> > index 590beb37f441..37c6ab217c96 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> > @@ -399,6 +399,65 @@ qfprom: efuse@780000 {
> >  			#size-cells = <1>;
> >  		};
> >  
> > +		sdhc_1: mmc@7c4000 {
> > +			compatible = "qcom,qcs615-sdhci", "qcom,sdhci-msm-v5";
> > +			reg = <0x0 0x007c4000 0x0 0x1000>,
> > +			      <0x0 0x007c5000 0x0 0x1000>;
> > +			reg-names = "hc",
> > +				    "cqhci";
> 
> There's an "ice" region at 0x007c8000

Shouldn't ice now be handled by a separate device?


-- 
With best wishes
Dmitry
