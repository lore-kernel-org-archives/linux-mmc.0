Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB11016F8E5
	for <linux-mmc@vger.kernel.org>; Fri,  1 Nov 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730460117; cv=none; b=qSy/dFdrsEUHRf8JlX0M2Uhx0MdqVpiesdFu5fyA84/00l33C3xQwtfdmACwbRa3hapAQTKJEF8WbcLhX2O9ps+QpaLGZ5P94BYgl0Tpa2yPVCqmTDqyR/u81jqyy+2JYwGaicOUhF5I+kSu0Sm050J3uVw2f3p666TnJOBOiB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730460117; c=relaxed/simple;
	bh=KoTvzO8VKEqtuA3KrJa8XxyQcDEmRjc9CaAtz8YICLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyiA1Nwq2pZevB5LS1Hx6TmbVXjv1XXLROV6WJEjlqALnaGBywiDopv4U8Gy4UVgN5QjXhASrMjWOVqcEPNj0gtPxEENGCQDa1Zc5Ta0aF21wBWaAf6nCoqeTKi4d1dIi5VgrmzqXMOugfxUWGOO3Rk5SAazgX7PVvtrt2Bghdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D0+H3b1C; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0+H3b1C"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so1434833f8f.2
        for <linux-mmc@vger.kernel.org>; Fri, 01 Nov 2024 04:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730460114; x=1731064914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXKsOWR/wJ8s/vomPLhl+IstAtu8+B4WWYmjYIcAfF8=;
        b=D0+H3b1CJsHsW37MQ9JBJ/6HJLHuK1ZM8h2nikhAD8L8bG8AqhMBJ/rvNlKvvOG+bL
         6b0PSWwpp1Zx2qFi+p301nVQAd9H5/9W8Crdi5yBiWEfMz7ppIIRzDI3iCgCxiBHqTgc
         20D0trc1YBuF/zNdp7TGWFPqbffhk7rDm+PUdEIAny07XC5HvoawO/0Tk242VBQQ7I4y
         lSpQ1rTUtbeEjQ/SpSnwwURJuPaEhg1c1DnExTPnpXQm0s39OWBSWA6b3TZrqKtmxDhX
         gWqYa3+6ByhQKu9mtWJWJu85StsKS2kq6MG6oeiQcnlh+jD0bCGvILDQSyDaiD1VwcA9
         nzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730460114; x=1731064914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXKsOWR/wJ8s/vomPLhl+IstAtu8+B4WWYmjYIcAfF8=;
        b=hjdv/0txIQFaPOhSMST/2qniRq2Vm5tDaA9kG5uc3Mcod1uLByFx8TXXKfBXyRpHnq
         TlZlx3W88x3n06LELQEBAZWH3BbqQhBHm4fu7VDOR+9yLrE+892VLRO6v8L7n216q1hE
         aEiBDr4IXv8GNllwNr8WBUzOoNoo5ckawknncScgsEKwbKo/UYuU9tcTuYfNl5z/UqQ/
         EOSHMTVquY+L5LtU+/I18wLJ48LDbut8LVrkCFd+DGsdT6HzJ3UW/5ku4YhaI10fv2sx
         kA2xIRqQ5xRzN3tUSz7dJTonaxWe8pCcEP5UCAeN9NKya1TxGEb82xe6EL4qdyRWMp5o
         6PPA==
X-Forwarded-Encrypted: i=1; AJvYcCVEgiKu7DWhA/x6uYsfQntE4oQzTPawUf2ILOkeIKOYpvYgTcQiRFejTcoY+WO1KOL+mAwpwybP3MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWBpDr3Si+DRzFcFqca6FBN65lg38NgTNVbmHNNS90FR89dl9
	6XEAmDmYqBQ5EDTC/hfimtQfyoMX+rd5JRrWx2LiEaDRnd1iZV95FcDj10GLQBQ=
X-Google-Smtp-Source: AGHT+IF1Hi3RvwWs7DSq+spdpzYUhwOwwmzTbkypHgqr1nBe6xd71RG+VXm6t9yCvd53dDUoi1AkKw==
X-Received: by 2002:a5d:5a13:0:b0:37c:fbf8:fc4 with SMTP id ffacd0b85a97d-381c7af3be3mr3201528f8f.59.1730460114103;
        Fri, 01 Nov 2024 04:21:54 -0700 (PDT)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e89csm4808765f8f.74.2024.11.01.04.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:21:53 -0700 (PDT)
Date: Fri, 1 Nov 2024 13:21:52 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: x1e80100: Describe TLMM pins
 for SDC2
Message-ID: <ZyS50DFLhHVlnRtd@linaro.org>
References: <20241022-x1e80100-qcp-sdhc-v3-0-46c401e32cbf@linaro.org>
 <20241022-x1e80100-qcp-sdhc-v3-2-46c401e32cbf@linaro.org>
 <a282021f-5e61-480c-84c4-272049e28244@oss.qualcomm.com>
 <Zx9P+HQMOkJsJGcj@linaro.org>
 <327507d8-2dc7-4645-ac3d-d68ff31a84dd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <327507d8-2dc7-4645-ac3d-d68ff31a84dd@oss.qualcomm.com>

On 24-10-28 14:10:54, Konrad Dybcio wrote:
> On 28.10.2024 9:48 AM, Abel Vesa wrote:
> > On 24-10-25 20:34:19, Konrad Dybcio wrote:
> >> On 22.10.2024 12:46 PM, Abel Vesa wrote:
> >>> Describe the SDC2 default and sleep state pins configuration
> >>> in TLMM. Do this in SoC dtsi file since they will be shared
> >>> across multiple boards.
> >>>
> >>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> >>> ---
> >>
> >> Not very useful on its own but okay..
> > 
> > Fair enough. For some reason, I'm not able to get sdc4 pinconf
> > to work.
> 
> Any chance you tried to define 'sdc4_cmd' etc.? This one seems to have
> sdc4 pins on gpio127..=132

Yes.

But since the sdc4 pins can have other functions and since there is no
device that uses them (yet). Shouldn't we just skip describing the sdc4
pinconf entirely as that should be done on a per-board basis?

> 
> Konrad
