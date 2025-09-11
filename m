Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B8B32BF44
	for <linux-mmc@vger.kernel.org>; Thu, 11 Sep 2025 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597115; cv=none; b=baxE2sfSFlXrSUuWcxALcYulbF85bYYluyIlc88pD2HGLl33A5X2wk3o5lnxMvRuGcney7tu1atq2xKatrP+CaD9FLT7CYYFIM10bSU8clO7KMFsGxlUP9i8GezWzhDOmaxeyO+MJJg8gSPdIOSd2yG+cnxHCJmQY4mFUa/8+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597115; c=relaxed/simple;
	bh=tvHtynkzdv1a6/2GIDVhvXbYgP7ctogGxu+SLDsFVek=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eoN+ZR+JAKmj1m3F08ZSNtIpWl1j2k+inG6PsIRgKUPVV9xXllk4rEkR9TT+iT105eM0jKBzVGZRePnXGs64L2oDW4M3MIYufkA6EIKqYzlkInA5QcOzQmVci4LShgcTs9wG/UaJESjbbXfAImFyoVCeJyEs75OSwIvcIkXPfeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FIfIOjPk; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FIfIOjPk"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-336b071e806so6363701fa.1
        for <linux-mmc@vger.kernel.org>; Thu, 11 Sep 2025 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757597111; x=1758201911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sKH9Tq5JpqAq1HnW1xohkQd88Pw1g4E8ukSxiOhM484=;
        b=FIfIOjPkSwlc6EbFu6WXdlEpy4VWaKnLjZR6H/dP1XwFlkg+C2xUgxtbIOc1g7yz7M
         GJVAZPqabKe1lAheW1Q+c9zQ2lV18QjU0DIbNJMMk7mVeT9dWXagRHkRqCMbFEAp1L9e
         ejOYM2V75YUgzrxWHgptill6ER5hots1aOG1mrlrP6UUL9RzTQfRpCBKqQLurGZG5aEa
         Jo3yGr7g5ANpqubCjx0vo3xFiN7IFMa+jUikcTnIkfgDdqRVjf9yi6RZmP8BvsoDvQol
         cXlP123VceslaCUvdMGv3JzT2H//oIcQfYpvbh+2O84RpMJeaTtmPhuPkZPOyoCfRglR
         pnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757597111; x=1758201911;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKH9Tq5JpqAq1HnW1xohkQd88Pw1g4E8ukSxiOhM484=;
        b=bcyFrZ6Tn3C1B/xUa2JamxcvQPRA+CBjMepYqcxLAOy/bfQKKlUAizxKZfk/d73rXg
         zqTUa7/p4d+utU/Ie6S1uAGlR29q92Duk86zFGnZdBP3psBoXuSbkLfGypUI07UfQK3i
         89WeZlWIwV9RiYjj7CEhXd3GuMUOrp0/GlKyzA08afskndukCVDJeDhl6pCe4uxguUhI
         xcPVmt1ozqRnFPYTx3PPvvjF5gx2fiPL1spWkqS77dXLjZPlRpi+UHPe3NLK8rRZ1qBy
         HKgdObH4wBIIpxD/yuXdtLYRyOSGPKDG/ZZwnkDL/5y50SLfc883L2o9FIZv67wEHXOE
         Mx+w==
X-Forwarded-Encrypted: i=1; AJvYcCXJQWx/qb+jBVaVGFriiPTnLtafj86d9P4axE5iBTJgjG4yhlxWNLpBgwpJppQKS3GQ2vzaram+Frw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuJ0A+JyBJTQLSPJsxboBXK5H0uUKpCHPncDo0dmVQi4ejjqRl
	tB2iwaKdbm/Owa5L5WEHzq+k1E4q9ItmyhIChaXNh6Sq6hGMUMVkMbUhVFRa4SRwWj6hn114yNa
	6WbFhguQRmFW4UC9ZbAimdtj6iO8dRoaRaxZOawx2AA==
X-Gm-Gg: ASbGncsLnkszo7L1ztaJdS1mhViJj3QaXBDYkrAy4OudMYKosCnsUX69bo6uku9IQ/M
	el2fLlPH1fxp5BAV1DmoJuoYJ6CpNvC67DzCJoGS3dv3NbxSisDF3SQ7v+tNmAo5Kfs8Z2zSCis
	JXypoXZRu+OfxQPaYoSgsljhuuEcGqbeUE4JvUlpYST3wTuGbTdVA1CZSkHslCsqeO4/sPATUmE
	fQnR/mx8XsupFR4unYnpErKV3QPOIuRCFIsWZc=
X-Google-Smtp-Source: AGHT+IFsA5ZOyU9tpTag4iQY+UEBWc1v4AgFQ6DjU2UnALeCrswvvm+lEztT+M/sSG35UIi0IcRGR77vi6rw6ChMafc=
X-Received: by 2002:a05:6512:33cd:b0:55f:489d:7bd with SMTP id
 2adb3069b0e04-5625d28e732mr6154709e87.0.1757597111174; Thu, 11 Sep 2025
 06:25:11 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Sep 2025 08:25:10 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Sep 2025 08:25:10 -0500
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20250908-lemans-evk-bu-v4-4-5c319c696a7d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com> <20250908-lemans-evk-bu-v4-4-5c319c696a7d@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 08:25:10 -0500
X-Gm-Features: Ac12FXyxL1zBhnbmQPIz3eBGCsQd9d-c4NEoyZ66twALqJFT9m4E9c429dd_4HA
Message-ID: <CAMRc=Mf8P=4vucch0sAtPNZ7DBB0Kw1hgvP1YLgZ5ZRfusFG-w@mail.gmail.com>
Subject: Re: [PATCH v4 04/14] arm64: dts: qcom: lemans-evk: Add TCA9534 I/O expander
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-i2c@vger.kernel.org, Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sep 2025 10:19:54 +0200, Wasim Nazir
<wasim.nazir@oss.qualcomm.com> said:
> From: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
>
> Integrate the TCA9534 I/O expander via I2C to provide 8 additional
> GPIO lines for extended I/O functionality.
>
> Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
