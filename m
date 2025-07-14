Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F28248898
	for <linux-mmc@vger.kernel.org>; Mon, 14 Jul 2025 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496345; cv=none; b=qf9J9tjwC6fFzc+dgcDSJXp5uogIfJ939AvRbYC6kPZtDkx3i42YM0ilhmYGHTDD4gm4YsfiyFyX7ro1/sL3Yfi4A4zxYOcSWsfgsdQS57Lxhr4akZmy+h8Wf2LVT7ijIlg01nmhRUXaM1uX8JlOfrIMeLB7QMesP1RYsmQLTr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496345; c=relaxed/simple;
	bh=qYiuoKRE2NxLGDxKz6WhuSPkGY9D7Tn+i7spILVLy8k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ru1K16ZMYxUbzFOGDNKn4IM3J1Gjq/KGAo4C/ZRHWl8mBKwq46WX2XUmmQ/1RPdfeRSrMQxuMSJQsQziC7jqR8ANQSF3ycrRbN1E6niJ9BXOOVRIuRV/7P0LzLLj/uw+gEHgX7FLPRUeJnb3vSiqW+88+zKTWFVhWLs5JI0+SbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=3gZln2wO; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="3gZln2wO"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso892478766b.2
        for <linux-mmc@vger.kernel.org>; Mon, 14 Jul 2025 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752496342; x=1753101142; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GT+QfWaXLUz2plhdm6tzk3KnJrg30pcNVb5s5dMBoo=;
        b=3gZln2wOOI7lo/l7dUww2B9kfi7qpXoKtRHky3EZuBYaRsEKbOD1gxKJ+KOzRTwEGw
         uxqeWFJP1S5LlA2+tHfxdWvH8VfMPVHseW865DX3UmLf61AuVZn/TIlDyy/1c5JLB0VK
         V7cSSNyVjqSxLe+VUJ1PuTTjdyUk6OwAP9lHdnuay1znB9Tk+s/GtHQSni4pzoYhby/v
         FFmAE3/lcu0FaNBdZoBtx7sLc+LJM7p/jGcd+OQ14e8Vfx5i4zVmY5CzPhNH73URBNCx
         LdXSO6WSC/CfdWtBxpd/t9WSmpmQvKz5kcOhNzBFCeQf4gVjRBa/lJS0zKqj9GOR73X4
         Lz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752496342; x=1753101142;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6GT+QfWaXLUz2plhdm6tzk3KnJrg30pcNVb5s5dMBoo=;
        b=P8C13sGWPZmSufTXv69nIBQtWB19IoJhgKHyYEUKsESAYl82zVxXILOFR6vqWG0Y+7
         PupugMzCP/9aFvskwemwAjAzEZD3iKQBb+J12RYmz0QPkxE18+sR+tebmNN7VbS9sdmo
         +HjzWmE0FPdXhrg6bDjOEOt/p8JJX7mrvHwNKjmCOKtQpeP4Go5rJDct+QrmG5FldIqc
         V+2F0yx/4myg2lyJrIaguFp2Pok0HJjx+LNVUufKDQ9OIiVTWpwyMLKb5KSRcTvZ+AVW
         TMN7syl1rGhrs/nS8b2ydS6OZk0KrYr6s1TQi/qvo2FywXX+G0iO102Qusu1KTnGhOzv
         351w==
X-Forwarded-Encrypted: i=1; AJvYcCXhu7ICu5LRz60dn+4Vv+o0LV3w36hz7B+hEupkAD53Xp/8p15ydTne1AN9P1AbjjT29Vf3bqL3yGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww5OiyC0e+txS8j1WRffObmG6aqwoU/Cm3FoJRA8K+zgFxomeZ
	nUDqrD5rmNY5m8HOTdq6nqdbJChA8RQdWLgMmpfd0X3TZmM1gb/LiIa9BuICdDGb+C4=
X-Gm-Gg: ASbGncuUUld5fXbOhRYBvQhMviWPgqUUDkZ3XjxlGtlHSPwdhGPuVn7z5+ctGtyUPol
	s+T5SxqrAK50Vb1opM5gcQSA3Qf+uUKEYoK2k46imPVGmJnrTG9m/xD4G4TbFJ/+YTGaA6dBPQR
	8vK0HmTDp71xh5qERX8O5J3Gcn4+dXjyQTwA07PvMQX4awPZ8WnNoEjmfQClv68bIpmVOuO+DIm
	U6v9EVYqjuQaxeVUJ2fn73FExrWNSK5Npsv5ocJMvOJh/w5tUPUTom4N6duja7SX9V7+JthvFTi
	zVDLYQsL9zuhgWA1h5gQBLc5c4lDKzVYKY9ZIms1rSAIq7zZPG/n8BRnd1I2bHklhPQ5Ul3//Q3
	j26wnuP52ssHjN94Hzh6ZxHE0Ao94spR2DFVsQvs5+sD/3MNcQj22ChkABAcGX1Hgd5JvQyerKM
	g4flTgO3FQKFMTz/u6wDpASjAASULNcIqjUA==
X-Google-Smtp-Source: AGHT+IEdIUlKAIUoH3odRS/w1x3zJL/78SxmRMa+QOLnmU3zwNSH9f5FMxlA1f2U3nn/eb6t4vkm0Q==
X-Received: by 2002:a17:906:7956:b0:ae3:cd73:e95a with SMTP id a640c23a62f3a-ae6fcbc356cmr1271518666b.36.1752496341821;
        Mon, 14 Jul 2025 05:32:21 -0700 (PDT)
Received: from localhost (2a02-8388-6584-6400-d322-7350-96d2-429d.cable.dynamic.v6.surfer.at. [2a02:8388:6584:6400:d322:7350:96d2:429d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82962acsm818540766b.139.2025.07.14.05.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 05:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 14:32:19 +0200
Message-Id: <DBBS3S38CWTN.32RLYB9VEZAB@fairphone.com>
Subject: Re: [PATCH v2 15/15] arm64: dts: qcom: Add The Fairphone (Gen. 6)
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Will Deacon"
 <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>, "Joerg Roedel"
 <joro@8bytes.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Vinod Koul" <vkoul@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Robert Marko"
 <robimarko@gmail.com>, "Das Srinagesh" <quic_gurus@quicinc.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Jassi Brar" <jassisinghbrar@gmail.com>,
 "Amit Kucheria" <amitk@kernel.org>, "Thara Gopinath"
 <thara.gopinath@gmail.com>, "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
 "Ulf Hansson" <ulf.hansson@linaro.org>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-15-e8f9a789505b@fairphone.com>
 <6f8b86c7-96a5-4c7c-b54e-25b173084d95@oss.qualcomm.com>
In-Reply-To: <6f8b86c7-96a5-4c7c-b54e-25b173084d95@oss.qualcomm.com>

On Mon Jul 14, 2025 at 2:19 PM CEST, Konrad Dybcio wrote:
> On 7/13/25 10:05 AM, Luca Weiss wrote:
>> Add a devicetree for The Fairphone (Gen. 6) smartphone, which is based
>> on the Milos/SM7635 SoC.
>>=20
>> Supported functionality as of this initial submission:
>> * Debug UART
>> * Regulators (PM7550, PM8550VS, PMR735B, PM8008)
>> * Remoteprocs (ADSP, CDSP, MPSS, WPSS)
>> * Power Button, Volume Keys, Switch
>> * Display (using simple-framebuffer)
>> * PMIC-GLINK (Charger, Fuel gauge, USB-C mode switching)
>> * Camera flash/torch LED
>> * SD card
>> * USB
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>
> [...]
>
>> +	reserved-memory {
>> +		/*
>> +		 * ABL is powering down display and controller if this node is
>> +		 * not named exactly "splash_region".
>> +		 */
>> +		splash_region@e3940000 {
>
> Was it not possible to arrange for a fw update after all?

I've made a patch to support both 'splash' and 'splash-region' but not
sure when it's going to be included, I've sent the patch to the correct
people internally last week. Since Android build cycles are always super
slow, it'll take a the very least a month I guess.

>
> fwiw the rest looks good

Thanks!

Regards
Luca

>
> Konrad

