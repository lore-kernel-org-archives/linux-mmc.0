Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A80145B25
	for <linux-mmc@vger.kernel.org>; Wed, 25 Sep 2024 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727299905; cv=none; b=iRips9Fgo3QKlrsGPpk6o3FmOdSch9ClSmdU85YKD9MY5XAhpb4xsZDxUBQj73+FULEmlqboswGlJ1POVTXM0qlN0BqJmd1XDoUf6KND1Kh5F4clIyOjBU3kbzabHJ0ShYDAVBIyvxKY/2jWBArrpUWGCawVfwj3kM5bSQdrLn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727299905; c=relaxed/simple;
	bh=q1hnfW/UYENj/VV96bgSolK/g/2vdQSz2wVyhQteCPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sb7AJoe0k60T2qv3giRnnzlhDtLk79+x8VtmeefzM6a6tw0EJVwGZcnmHG6PKaoSUyrqq1+pt/iBZTEYfFyFQGisNhgqwFbxvS00B/b4KX8Dr2LMGeOU+WhCLqPahX/kcFgm4bAGv73h+7JVynEiLggDSAXMdJu09b0+SGebQAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vpHxw83B; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vpHxw83B"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5365aec6fc1so353784e87.3
        for <linux-mmc@vger.kernel.org>; Wed, 25 Sep 2024 14:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727299902; x=1727904702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2gRWXk6um8ssZG0dTYz3h8O6sPux+vtNyTeziNQM+4=;
        b=vpHxw83BEcxXUiXAHcwannMowZ5Cp/Zm0//e9txywTNF+VvbYNu8F1jTKNov+mH/Ns
         5hHQflIjhKUl5G/IPTQ1QlYBoyLU+pl1Qt4Mx572kqq6ImpdtT9nvn7R1iEEZdIHMOxB
         SzftUfPVRDvh/dh4iGooNg+6fQdfSwKqC2XOKsnIbMuGDmC0MWWgUrNTgHl0q+YB/QjH
         E6TDD2eqeFktH3aKA7aTMaEBEEEm2Bnp4OTeVI5cdWgWqIyT1MrP4YYAq9UO8Q2phjMl
         Cl+YWdmPf1FQZtaE2nhr2VGc1ZXKepGxtu0tMXMKlhUgIh3yLSandXdoVQjX1kgBeB6r
         TSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727299902; x=1727904702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2gRWXk6um8ssZG0dTYz3h8O6sPux+vtNyTeziNQM+4=;
        b=FGjXkZbEN2W8RVgl52R+FBlTYiryI1s5DeGBToCnSZONa38RZdhpEIDE07ZeSQ+7xr
         KICSPoIYVAv4ouXv2cyVBn61NB5EJY9IaY4xr7raUeymucv71O/Xu6GmYVcaxx+AaDNo
         Lg90Ti1j8UcCXg0+4jqIPoYp2NIw8jl+oeMtSmv5A2aF1fFU9QPU/YqY7kDQGics/vPX
         89VebhLyG9x7fwnjD7DNVyJ1U7Xo6fDGQsUBRa3DSAW9xViQ3wk2K0I31K9oLj5M2VCo
         KkHH+IVj++jvwucbO6+fburx2oevNumiDro8d547Nvw68ZlAYhWDZ/nmZX0IrA05DjZH
         AJ6A==
X-Forwarded-Encrypted: i=1; AJvYcCUDmutXf9gdjjgNWX4ZpmLaJh4PIbactnrEb9KZw9z8dI8W5vCmgiMQ+70oxB9qnkIDZZ2j1HlcrzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlS/s5aKV9UzxyG+lJ1TdZ7FE+9l7fm4gL8siHdUNaErTtdw9G
	OVy0Vr+OjQOI2fOISehnZnowusW8kuN24HvZtz4WH6OQ0YmLDK+WlDr3suW70Kc=
X-Google-Smtp-Source: AGHT+IGRtxkMp3x13jBkNmqIgOxnVIpZ0WovylKJsjpSzFGlmQuJwR6WMxOTZoa6v7kxp+tzwKvB6Q==
X-Received: by 2002:a05:6512:3a8f:b0:536:536f:c663 with SMTP id 2adb3069b0e04-538704986fcmr2778800e87.22.1727299902152;
        Wed, 25 Sep 2024 14:31:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a86408dasm623111e87.144.2024.09.25.14.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:31:41 -0700 (PDT)
Date: Thu, 26 Sep 2024 00:31:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	ulf.hansson@linaro.org, linus.walleij@linaro.org, catalin.marinas@arm.com, 
	p.zabel@pengutronix.de, geert+renesas@glider.be, neil.armstrong@linaro.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, quic_varada@quicinc.com
Subject: Re: [PATCH 8/8] arm64: defconfig: Enable IPQ5424 SoC base configs
Message-ID: <h6ajhgv5rqabxupove4ge4253ywzbjyxoqq75c7ojmauudd3z5@hhhkbbzfmved>
References: <20240913121250.2995351-1-quic_srichara@quicinc.com>
 <20240913121250.2995351-9-quic_srichara@quicinc.com>
 <4dxqbm4uuuuht5db7kt6faz2pdeodn224hd34np322divs22ba@dzmjveze3b4f>
 <2a16d5a2-17a5-4988-8a25-34ac10ff3d08@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a16d5a2-17a5-4988-8a25-34ac10ff3d08@quicinc.com>

On Thu, Sep 26, 2024 at 12:34:56AM GMT, Sricharan Ramabadhran wrote:
> 
> 
> On 9/13/2024 6:23 PM, Dmitry Baryshkov wrote:
> > On Fri, Sep 13, 2024 at 05:42:50PM GMT, Sricharan R wrote:
> > > From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > > 
> > > Enable the clock and pinctrl configs for Qualcomm IPQ5332 SoC
> > 
> > Please name the device rather than the platform. The defconfig affects
> > all users, so it should be justified.
> > 
> Sorry, to understand correctly, you mean to use the board name here ?

Yes, the board which is generally accessible, if possible. You are
increasing kernel size for everybody using defconfig, so at least it
should be obvious, who is benefiting from that.

> 
> > > 
> > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > 
> > Usual comment.
> ok, will fix.
> 
> Regards,
>  Sricharan

-- 
With best wishes
Dmitry
