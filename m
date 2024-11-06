Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64791CC8B4
	for <linux-mmc@vger.kernel.org>; Wed,  6 Nov 2024 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878632; cv=none; b=ugjTyhx9Tnco5q9DjHgujixObS66j8aiCk+C/RKMnzu+iT9RVDzPNdbLz/0EPhjZakvQpqwEn/WaL9vy0rzQ+1LMw7hUSbIYBSqAPqT4ZotxLEibCC0vEo3YIp6cZfEDBFFOy+0jsY45Rh+dPRCoWjzwg1MMoPlE2L7rHC8PXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878632; c=relaxed/simple;
	bh=T+IDxfnEDhIbzwhDwnYLVo8b5mJZHz3JOJrvtUZgZUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDGzRXSTjTx4fRTyUWysVi8uesS2F45M0Kxl+3mquq2PrTBzMkl4YgLsK/6P5Fj+4tRw9IjBASUd3esDRobVnNJU27K7RQzkDECj4AgG65MJW0WHHgCSg52VGzNWbhEVAP2kYrDFvx9uHGqjlQQ1LODySTOCA5WVQqkOXu3BdhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mXpxlDey; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXpxlDey"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e59dadebso7835821e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 05 Nov 2024 23:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730878619; x=1731483419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1xBr3nMrr1f+V04w4SZ0IWUu6Cb5RyUO9D91ndFpL84=;
        b=mXpxlDeyB7/qoPH5Nmmk3gGt7jc/h/qhyodAN9BdeRkI719HVImXmCbYHm35JItEjR
         hxS1wnDq+LXFC6EdgvM4VkJE71u7HxRgDpm7bi9G3YKnWcl2KArfAL+vHe6XZgoAQaJn
         srUEwBK0zv5Wsii3oGLrVwZ/sBAcJe08+T/xXH1nuusUr5TSWSAjdPW4KN+ul7OkfuDL
         pIC3W+2dHU/hjAtE1AqudlZF2lCIwMk6zkPAErgUh4BKerd9Ke1Qc8uZTn7lFDsE6ZDp
         CXaIjUvmzHXEb/1N5tHmkqNvvpVHwsd6oiD9i47Oa5s+hxwzdZWYDcJRPhb1doqO3Bq3
         LpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730878619; x=1731483419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xBr3nMrr1f+V04w4SZ0IWUu6Cb5RyUO9D91ndFpL84=;
        b=gj5uMg950nebkdMYcV+8z4OF967rq2urMO2Fh7q12ZiLqqryemJhCTPE8DRCwv4UZf
         /5h0IhfGnb7FwREq4AnJ1LyWFL/BmNMN6Wpm3h3J/fpQWXfZoEhIrRYSm/Jj19Tk9m9f
         W7eJsd4fc/O6OHPAM/YH2VSi7OiyK/MLrOtnrtgIe0HLZVwD8HEDBWOMoH2OpmoY68VC
         xURTBuAbWF2qke3VQqz0Ck7UrnY/5ilQWwyLHjnD1HxGcByf0tJwkGKuyuvmD1oJY7uO
         S2lflGPi1Osglzv7KP8DWnLlmTaDr96z+mweAI21cw4/izDzKguuYa9SlCtX/IVqda9q
         fwtw==
X-Forwarded-Encrypted: i=1; AJvYcCWQCK+uSEWtepzQmydgr1hJE4n2CFWgsM8NVpVxyEmHNxU5fTfJEC3yjV74obglqQ6iiOzLTYZVH1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnVOXJGmrXT9JGxIOzZwjmBDsB7rylYQx6TpQfC5mBmwkWXHVV
	Cng8hefBVPRpvdbOifSGr+t9y1KOpZcbPt8k97Mf2oKIBIWBDdT5Qv8WQs6c1pk=
X-Google-Smtp-Source: AGHT+IFYDqIISjoUL85nMRIGPu671NngEQq2CYpjOQlQooiQOP6StYmNoX9XGKAhYB1b9IQWouSWdQ==
X-Received: by 2002:a05:6512:4020:b0:52f:c13f:23d2 with SMTP id 2adb3069b0e04-53b3490ed8fmr18329343e87.25.1730878618811;
        Tue, 05 Nov 2024 23:36:58 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc961dbsm2398693e87.43.2024.11.05.23.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:36:57 -0800 (PST)
Date: Wed, 6 Nov 2024 09:36:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yuanjie Yang <quic_yuanjiey@quicinc.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, bhupesh.sharma@linaro.org, andersson@kernel.org, 
	konradybcio@kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, quic_tingweiz@quicinc.com
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: qcs615: add SDHC1 and SDHC2
Message-ID: <347uhs7apex3usmfpzrpwakrzchxactwtc7gs45indkzez2vfj@n75dc3ovl3g2>
References: <20241106072343.2070933-1-quic_yuanjiey@quicinc.com>
 <20241106072343.2070933-2-quic_yuanjiey@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106072343.2070933-2-quic_yuanjiey@quicinc.com>

On Wed, Nov 06, 2024 at 03:23:42PM +0800, Yuanjie Yang wrote:
> Add SDHC1 and SDHC2 support to the QCS615 Ride platform. The SDHC1
> and SDHC2 of QCS615 are derived from SM6115. Include the relevant
> binding documents accordingly.

Which binding documents?

> Additionally, configure SDHC1-related
> and SDHC2-related opp, power, and interconnect settings in the device
> tree.
> 
> Signed-off-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 198 +++++++++++++++++++++++++++
>  1 file changed, 198 insertions(+)
> 

-- 
With best wishes
Dmitry
