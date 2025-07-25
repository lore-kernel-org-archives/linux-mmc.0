Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5424F2356CF
	for <linux-mmc@vger.kernel.org>; Fri, 25 Jul 2025 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452890; cv=none; b=cv1CcoFjHUMUTP5oJV2qEwYtIlYnS3A84TzyhET+uqRFZkp691ycJ4ShwUsgNrsSnXVgM8kqTBvcFMqlrtQ8rrdV0Q9lq34AGrljZgJS/YKGa+e3ZvlpbvtGg2FeWcGrq6yzOJVT+ZqseSu6WIU9+4yMAyLzQ6kY52Ypwr6UraE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452890; c=relaxed/simple;
	bh=rNyAWlp56eBFvy36oX5YiZlPyIt11W/cxbD2Iyf2S4s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=q4BFbTHvqNegKSs3E4fQGmk74l9PlVNE7X4iqThQjwtpjuwkKtVc2nbzZXcSmFebn8S+uBsM2zGR28kSLF1P8+gRzbBj7b5WdXW3SB2WxNUpIynBoeoCrOovduJYz3Nvx5B6A3/myQzCLvtj82hrBqANCgJ1IeNhWkboktPEP9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=3GNcyl+V; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="3GNcyl+V"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so4456318a12.2
        for <linux-mmc@vger.kernel.org>; Fri, 25 Jul 2025 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1753452886; x=1754057686; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSkJyTrv6R3uiwv3q2J4zn3hDj1JQ7Rtyl+OeDRudNc=;
        b=3GNcyl+VN56MLlLZZiFVdso3FYTMvxLqn0YicT4yjc3jDsdFduc6k8L2aJz+z7EMyB
         MwmZZxlrU27kgawqJRkZm2zoQP2golw0YdBQEdxJg3OpVk1uIXLgbBiO2YEe9ssCeyfq
         NEE3TiphHbKz1lK+XfH2G1qBUvZKPPaJv/znEj++VkWiLz9kiBcbgwmdKXKc/juZaz6n
         UkHw63EKc8v0nhrOsyDsAZvXu1g8aeI0CtC6L22yQcvO5DjQdju5F0hof5CO4JJFhDKR
         1va/awzeHy9uwa5YGsdaj0I5nvvekY+MC7BvqIZtc30xXJ7j4vpvZDgX2T5xHDb0Qfib
         /0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753452886; x=1754057686;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iSkJyTrv6R3uiwv3q2J4zn3hDj1JQ7Rtyl+OeDRudNc=;
        b=iyxPelw2GOi5zAkLUb77u+lbpHpREMqetFWStIN4DwA0t6uDN2DYVK1nKVksYIXcSi
         7hZ50Fk8bP1kNHteuHaiU9MTz1j25oG3Gx+fli2mm7F4CSMq4eIaLnq1u0gyo4gzxI9e
         uGR0NqFKPrwQM7Di/zm9cab7TjqQGIFKgskcArcjzkOZuFHxXsCeH3b2E3uN7UuQkft+
         W9p/1nSAwwwtblo/hogW3jifOcXpxstGKd64dSF6xBKs3xLi8SsZyzopLljrQbErECAm
         +NZF4LTUX9G2PzAR8tcI8pxHXCiGQ5GY1j/bjzeXsVUmxbTPRLU+UaqvqvC7Qvvcntac
         9LHA==
X-Forwarded-Encrypted: i=1; AJvYcCUxHv5DA+xyWWljFebaqwIoxXfh1218ykaT0C/aw5aLGesxs8UmRc2Vvfpe9u5vXTQGE4X0at+FU3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe4fNWiBW8QlwjGjd5H++VnKHJh06LvKongCysNYy9xXXJpj9L
	EW9v2q0y+FuwqFUWxUXaMQwwfU4x3Zc3+2vDWsFV4EB0SgX8UQiGCNZtRhBQEGe4mvc=
X-Gm-Gg: ASbGncscjLOHYuXyXsNEhybAB91U5LQGVQDlXJKXcz5Iliyefc9VQTjonhun0bKLHIH
	SBtcl9xYrWr/YBmA+WMljrYbae9i3jledU89EK6dEP19pepTYCVvv25R5reRxk9rAjSrtc+aE0F
	UjuWAb2ZR3WHQ5dRuk9W5J7HyArvvnISPhDZXsOQxlvOdtC906teoFXxK5KaLdFOpLjaraVP/4E
	d82ETQAWiXTWBQq1MarkSm344f8q6Clrj1hBjjA04LSRZi7YjLarbe9AsBy8EmdGZcNH4VM/fDH
	tsYltRdAR6/qvlMpGM20E/KxnOcZCVwDcmkyX8o47/CG2Cg7ddTDIsqHaT3Tpb8ROlp8jlNIxHU
	Rw7yCTomKzC3+Lk1k7i8dKwXTxY20Xjaqbtyylpx7pqhfT4wS69VoDQK6s7V0iBzcXvo=
X-Google-Smtp-Source: AGHT+IGz463msOz8qJcurxvgKtRb5VKMVkS2t8llkd59+2lECxEEVtdl6gBW3cfbqM7OYO38KYCWFg==
X-Received: by 2002:a05:6402:3595:b0:604:e440:1d0b with SMTP id 4fb4d7f45d1cf-614f1a88810mr1744941a12.4.1753452885513;
        Fri, 25 Jul 2025 07:14:45 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614d907a40csm1635236a12.15.2025.07.25.07.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 07:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Jul 2025 16:14:44 +0200
Message-Id: <DBL766O111UP.1IBG5Q30DCEQS@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 06/14] dt-bindings: mailbox: qcom-ipcc: document the
 SM7635 Inter-Processor Communication Controller
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Will Deacon"
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
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
 <20250625-sm7635-fp6-initial-v1-6-d9cd322eac1b@fairphone.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-6-d9cd322eac1b@fairphone.com>

Hi Jassi,

On Wed Jun 25, 2025 at 11:23 AM CEST, Luca Weiss wrote:
> Document the Inter-Processor Communication Controller on the SM7635 Platf=
orm.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

I see you picked up this patch[0], but "qcom,sm7635-ipcc" should be
dropped. Only "qcom,milos-ipcc" from v2 should land.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?id=3D872798f61d8bfea857e54aa17baa7b0d3ee24b65

Regards
Luca

> ---
>  Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/D=
ocumentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> index f69c0ec5d19d3dd726a42d86f8a77433267fdf28..6e86ec36a82254ebd73c3067d=
e495795c36c6bee 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> @@ -34,6 +34,7 @@ properties:
>            - qcom,sdx75-ipcc
>            - qcom,sm6350-ipcc
>            - qcom,sm6375-ipcc
> +          - qcom,sm7635-ipcc
>            - qcom,sm8250-ipcc
>            - qcom,sm8350-ipcc
>            - qcom,sm8450-ipcc

