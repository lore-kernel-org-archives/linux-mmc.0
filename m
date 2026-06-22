Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD8374E7F;
	Tue, 23 Jun 2026 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184395; cv=none; b=T8kEJjHokpkJWzWEHi97jb8gkFByAS0Omf7/AkJfh05zrZvS2UUVSUR1b4nceStW1sNW0AknleE/G0K/idHK61bY6R6wwe5Ic2p86/L+fiJF3Nu3mX8NSZZIDkUshRf/nl7sQPjphOwYRgwl5IEftpzMkwE4UXi5TIR+zphVh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184395; c=relaxed/simple;
	bh=SwNva69jy2afJIyfC0fIqgAntqNuL+DM/a3cYXevjM4=;
	h=From:To:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Oox69dgE3K0Kqu+3LKt+gxQmKhT57FU0fP9mHyTb51RT/JGqq/LH5wSIXtJA6L5ah/DU9G/Tyud4wBnDMPBiSMcIgG+GFPJbp1ltmBjxpk1cYxzAFhyUaA0vcoTNT1jZECjimfJDJzVLtbtDPzwiF3dh1nLT4eGog/pLmct6Z9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HSBXm6Wr; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HSBXm6Wr"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260623031303epoutp02488f852023875c7b097a7427dfb11950~7l0ExemEP0684306843epoutp02R;
	Tue, 23 Jun 2026 03:13:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260623031303epoutp02488f852023875c7b097a7427dfb11950~7l0ExemEP0684306843epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1782184383;
	bh=xYWvnYzx61MOHShrICO4N9ZwFKzGqTfE6OdZqCfXxL4=;
	h=From:To:In-Reply-To:Subject:Date:References:From;
	b=HSBXm6WralSrItnUo41WTp4Q9bHEdBGeR/ktDAbhDUX4jHkktSgXl1qVmshH/Zbfz
	 HyFkrFLLFUikPIvVZvLN8hutNjgoW819TbAeR9N1Fg49C1AhVAoaidIA6WQL6TnjHz
	 ZebhsaMkFvMv6aZD8a/rzkNbslvDGFU7faVRYhzM=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260623031303epcas5p1fd11dbfc745aa99f18d960e686705fcd~7l0Ec3mqg0166901669epcas5p1o;
	Tue, 23 Jun 2026 03:13:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4gkqrb2vfDz6B9m9; Tue, 23 Jun
	2026 03:13:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260622114230epcas5p3e590b84087d9879e30d604f89ce938a8~7ZHlpxa2p3249132491epcas5p3i;
	Mon, 22 Jun 2026 11:42:30 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20260622114216epsmtip1ccbcb97431d34878191527dbce3b94b6~7ZHYxKdLA2526625266epsmtip1D;
	Mon, 22 Jun 2026 11:42:16 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@oss.qualcomm.com>, "'Bjorn
 Andersson'" <andersson@kernel.org>, "'Konrad Dybcio'"
	<konradybcio@kernel.org>, "'Rob Herring'" <robh@kernel.org>, "'Krzysztof
 Kozlowski'" <krzk+dt@kernel.org>, "'Conor Dooley'" <conor+dt@kernel.org>,
	"'Peter Griffin'" <peter.griffin@linaro.org>, "'Michael	Turquette'"
	<mturquette@baylibre.com>, "'Stephen Boyd'" <sboyd@kernel.org>, "'Brian
 Masney'" <bmasney@redhat.com>, "'Sylwester Nawrocki'"
	<s.nawrocki@samsung.com>, "'Chanwoo Choi'" <cw00.choi@samsung.com>, "'Sam
 Protsenko'" <semen.protsenko@linaro.org>, "'Rob Clark'"
	<robin.clark@oss.qualcomm.com>, "'Dmitry Baryshkov'" <lumag@kernel.org>,
	"'Abhinav Kumar'" <abhinav.kumar@linux.dev>, "'Jessica Zhang'"
	<jesszhan0024@gmail.com>, "'Sean Paul'" <sean@poorly.run>, "'Marijn
	Suijten'" <marijn.suijten@somainline.org>, "'David	Airlie'"
 <airlied@gmail.com>, "'Simona Vetter'" <simona@ffwll.ch>, "'Maarten
	Lankhorst'" <maarten.lankhorst@linux.intel.com>, "'Maxime Ripard'"
 <mripard@kernel.org>, "'Thomas Zimmermann'" <tzimmermann@suse.de>, "'Inki
	Dae'" <inki.dae@samsung.com>, "'Seung-Woo Kim'" <sw0312.kim@samsung.com>,
	"'Kyungmin	Park'" <kyungmin.park@samsung.com>, "'Andi Shyti'"
	<andi.shyti@kernel.org>, "'Georgi	Djakov'" <djakov@kernel.org>, "'Lee
	Jones'" <lee@kernel.org>, "'Pavel Machek'" <pavel@kernel.org>, "'Hans
	Verkuil'" <hverkuil@kernel.org>, "'Mauro Carvalho	Chehab'"
 <mchehab@kernel.org>, "'Ulf Hansson'" <ulfh@kernel.org>, "'Peter Rosin'"
 <peda@lysator.liu.se>, "'Vinod Koul'" <vkoul@kernel.org>, "'Neil Armstrong'"
 <neil.armstrong@linaro.org>, "'Linus Walleij'" <linusw@kernel.org>, "'Geert
	Uytterhoeven'" <geert+renesas@glider.be>, "'Magnus Damm'"
 <magnus.damm@gmail.com>, "'Sebastian Reichel'" <sre@kernel.org>, "'Javier
	Martinez Canillas'" <javier@dowhile0.org>, "'Liam Girdwood'"
 <lgirdwood@gmail.com>, "'Mark Brown'" <broonie@kernel.org>, "'Greg
	Kroah-Hartman'" <gregkh@linuxfoundation.org>, "'Jiri	Slaby'"
 <jirislaby@kernel.org>, "'Srinivas Kandagatla'" <srini@kernel.org>,
	"'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>, "'Rafael J. Wysocki'"
	<rafael@kernel.org>, "'Daniel Lezcano'" <daniel.lezcano@kernel.org>, "'Zhang
 Rui'" <rui.zhang@intel.com>, "'Lukasz Luba'" <lukasz.luba@arm.com>,
	"'Jonathan Marek'" <jonathan@marek.ca>, "'Taniya Das'"
	<quic_tdas@quicinc.com>, "'Robert Marko'" <robimarko@gmail.com>, "'Christian
 Marangi'" <ansuelsmth@gmail.com>, "'Stephan	Gerhold'" <stephan@gerhold.net>,
	"'Adam Skladowski'" <a_skl39@protonmail.com>, "'Sireesh Kodali'"
	<sireeshkodali@protonmail.com>, "'Barnabas Czeman'"
	<barnabas.czeman@mainlining.org>, "'Imran Shaik'"
	<quic_imrashai@quicinc.com>, "'Sricharan Ramabadhran'"
	<quic_srichara@quicinc.com>, "'Anusha Rao'" <quic_anusha@quicinc.com>, "'Luo
 Jie'" <quic_luoj@quicinc.com>, "'Tomasz Figa'" <tomasz.figa@gmail.com>,
	"'Chanho Park'" <chanho61.park@samsung.com>, "'Sunyeal	Hong'"
	<sunyeal.hong@samsung.com>, "'Shin Son'" <shin.son@samsung.com>, "'Krishna
 Manikandan'" <quic_mkrishn@quicinc.com>, "'Jacek Anaszewski'"
	<jacek.anaszewski@gmail.com>, "'Jaehoon Chung'" <jh80.chung@samsung.com>,
	"'Marek	Szyprowski'" <m.szyprowski@samsung.com>, "'Alina Yu'"
	<alina_yu@richtek.com>, "'Andy	Gross'" <agross@kernel.org>,
	=?UTF-8?Q?'Niklas_S=C3=B6derlund'?= <niklas.soderlund@ragnatech.se>,
	"'Wesley Cheng'" <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<freedreno@lists.freedesktop.org>, <linux-i2c@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-leds@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<cpgs@samsung.com>
In-Reply-To: <20260622101606.485961-3-krzysztof.kozlowski@oss.qualcomm.com>
Subject: RE: [PATCH 1/2] dt-bindings: clock: Drop incorrect usage of double
 '::'
Date: Mon, 22 Jun 2026 17:12:14 +0530
Message-ID: <1050065615.01782184383398.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIwXoGyyqYeRyJ4JjkgDeaw0zOZjgI6ZcaYtZHncYA=
Content-Language: en-us
X-CMS-MailID: 20260622114230epcas5p3e590b84087d9879e30d604f89ce938a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260622101627epcas5p2aeb4aad096395936c04cb563eb226b83
References: <CGME20260622101627epcas5p2aeb4aad096395936c04cb563eb226b83@epcas5p2.samsung.com>
	<20260622101606.485961-3-krzysztof.kozlowski@oss.qualcomm.com>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Sent: Monday, June 22, 2026 3:46 PM
> To: Bjorn Andersson <andersson@kernel.org>; Konrad Dybcio
> <konradybcio@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> Peter Griffin <peter.griffin@linaro.org>; Alim Akhtar
> <alim.akhtar@samsung.com>; Michael Turquette
> <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; Brian
> Masney <bmasney@redhat.com>; Sylwester Nawrocki
[Snip]
>  Documentation/devicetree/bindings/clock/qcom,videocc.yaml   | 2 +-
>  .../devicetree/bindings/clock/samsung,exynos5260-clock.yaml | 6 +++---
>   .../devicetree/bindings/clock/samsung,exynos5410-clock.yaml | 2 +-
>   .../devicetree/bindings/clock/samsung,exynos5433-clock.yaml | 2 +-
>  .../devicetree/bindings/clock/samsung,exynos7-clock.yaml    | 2 +-
>  .../devicetree/bindings/clock/samsung,exynos850-clock.yaml  | 2 +-
>  .../bindings/clock/samsung,exynosautov9-clock.yaml          | 2 +-
>  .../bindings/clock/samsung,exynosautov920-clock.yaml        | 2 +-
>  .../devicetree/bindings/clock/samsung,s5pv210-clock.yaml    | 2 +-

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>




