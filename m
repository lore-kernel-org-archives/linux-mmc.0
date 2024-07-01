Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E594B4EB45;
	Mon,  1 Jul 2024 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817015; cv=none; b=emcwZfNxd9wtVrEiD7R5MH1Rkem1i2XPG2d75ppSOglmGv7ksMU248Fy+3Xe4hUT5QX8KNK3rmMMFyyGGVzFanf0GDCIx2Mq0XSaMJa9R5AgY1DMCLk4b74Ku9jAFknao59/MHrciW0FAocvvH0+URgoxgeabGwDbK0hDChJCts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817015; c=relaxed/simple;
	bh=+ntPJT+r5ArrobOCjTljPY5X1luO0LW3vJ9fSfFxWI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=giGNBuUNkHGvoE61BDSrahcjMsybYcZnbeOkjiSsmQCMpK+UKxY2n4pTGgy7v76phfEx2IkWrEhnIhVtE9BX0a2xKAWp9uZIL488eWHFgeeyatkfl6IJJw/YK4fLga98UXr5mRoCQMpra+OkBD3JiyCbzkpsc+0SFj675BdbJbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h87V073D; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h87V073D"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c9cc681ee4so1825102b6e.0;
        Sun, 30 Jun 2024 23:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719817013; x=1720421813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ntPJT+r5ArrobOCjTljPY5X1luO0LW3vJ9fSfFxWI8=;
        b=h87V073DHZRX2oFduFxZYCFGk7+mB8WXTR6EMqgiVXed0oZKwY7NV9n12f4PcTZjTt
         1qUiLnoEKMyHGU7c87xivHK8qfZHFlitZV82mZU88kADdg0+ninBJX7xx/jUautog4uM
         LrAO4cC25E8bjW7tvTAdkuJFB/s2SJLH0LEuVDUJEx+Ar741ciX9f8mikvWX9h3LpXG8
         PodP5K232B74RRk6YJyNryCxVsDGXMF6406PoRyj9BtEtIbdlZ4z/w48+bZfTX8PUMKM
         8D33in+zJXtyNUWWor10WGa49bdmpOk3lqCu3lBVWFEnufqksNhX5dbpGBodqFv0tTqV
         jhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719817013; x=1720421813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ntPJT+r5ArrobOCjTljPY5X1luO0LW3vJ9fSfFxWI8=;
        b=iSeiJGVe/g7BpSeldaO9IfCKoOPmz3EN124grAiSGwqlaJuhpkinazU2OUdM2tG4nR
         lrdhungC9C5QWPkXqcEoMS3T8haBiq3wtp19vFdyuHPdlfUQo3dHd2uon9snka1XGeNw
         a4/V4qHOp2X5n0z4Rl4e+sinDzXKYnbAnhdzGuIrHsMiC5hUy2kqRzeNR7IxEnGZXCvs
         dGnxywk14L9+m9pVIjkWhnV+4vruDqSwRT7E8W2Tc6ibiz96uFJAaLGgNgnPlvevX5dd
         u8wLeg+10vlvpufgRfpuoH+cHaNxwC/dz6m/uVAlNviPBIJL78gmkUSohrewFpdv6Tv9
         nb3w==
X-Forwarded-Encrypted: i=1; AJvYcCW/a6FhpDOITszcWlOrIG0RvMxSybkF41+KLSzn4HuwKCUSiZJZmMbSOxA86eSBkDRkugYHGtO5bMrAEJX+qFzeO9skno6ud9auzM9cXifqq3+bbSCY/DeAI3cvP3wpXTEPmMPnza7lQ3OUWpr3NqURU2x06nOiKeH9WBkE0V22Txjwxw==
X-Gm-Message-State: AOJu0YymkSzx8Vz8i6N/pcnSX2S9aDRMsDCy7u9nJuIHqTR9sh9LLTsv
	cQEMMgFT9TmE7ScqIQ0qcOuUIMWp/jXcYhK4VZDktxhikaRRAgeY
X-Google-Smtp-Source: AGHT+IEpqIOCW/jccTj/xYWZV3r4E+LFfyzOwkCVx0hHDZpgZCno30MYJoir9PNX4x8DmW0+NjCHRg==
X-Received: by 2002:a05:6808:f15:b0:3d6:2d45:a791 with SMTP id 5614622812f47-3d6b3c86bbbmr8659230b6e.32.1719817012691;
        Sun, 30 Jun 2024 23:56:52 -0700 (PDT)
Received: from [172.19.1.51] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044b1112sm5715670b3a.182.2024.06.30.23.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 23:56:52 -0700 (PDT)
Message-ID: <747c568b-6934-40dc-90d6-386fd1e0e795@gmail.com>
Date: Mon, 1 Jul 2024 14:56:47 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: nuvoton,ma35d1-sdhci: Document
 MA35D1 SDHCI controller
To: Krzysztof Kozlowski <krzk@kernel.org>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 adrian.hunter@intel.com, p.zabel@pengutronix.de, pbrobinson@gmail.com,
 serghox@gmail.com, mcgrof@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, forbidden405@outlook.com,
 tmaimon77@gmail.com, andy.shevchenko@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240701003913.729428-1-shanchun1218@gmail.com>
 <20240701003913.729428-2-shanchun1218@gmail.com>
 <e02dc084-1e69-4231-b191-3605c68b53f4@kernel.org>
Content-Language: en-US
From: Shan-Chun Hung <shanchun1218@gmail.com>
In-Reply-To: <e02dc084-1e69-4231-b191-3605c68b53f4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Krzysztof,

Thanks for your review.

I'm sorry, I just realized I missed an important letter.

I will drop status = "disabled" in the next version.

> On 01/07/2024 02:39, Shan-Chun Hung wrote:
>> Add binding for Nuvoton MA35D1 SDHCI controller.
>>
>> Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
> You ignored comment third time.
>
> NAK.
>
> <form letter>
> This is a friendly reminder during the review process.
>
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
>
> Thank you.
> </form letter>
>
>
> Best regards,
> Krzysztof

Best Regards,

Shan-Chun

