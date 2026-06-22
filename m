Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD6938D3E6;
	Tue, 23 Jun 2026 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184395; cv=none; b=ppPjLOsdfmP+Vk8us8Ganw6O0FuP1awjXyoMFfCwul+HGdcLFqHZAI7dQLCG3yTmMGA8dOLnNOOiHbGN4QRT8lq2OD9mBqLRSjhXQ4O5mZ8+ApuhjiC/h15eLG9mWa6BfFCubIpc2lzXnTpMJCae8Qk+HO6lGdEFR/M0OzBwXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184395; c=relaxed/simple;
	bh=tatdd/Q7QE0upqPJVjWgLFwHUzQQq+izQdPrwXLkDtk=;
	h=From:To:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Z9oS3eMmT4mzR5aLybFEz4wVeD2LPT9udgVHrMxRAp1o0WywAZezKeIe44q45ucCrX8Ta3KZpUTKpcM02trQmcTCKdhEeKdqYEdEZK84gvaIP6xD8CKl494dUQmTaMpREfnXgPF1oodc+IT7In9YbohfvNrwz+evUEe6Mu0/sUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dNfxF4M3; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dNfxF4M3"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260623031304epoutp04b58205b658a8fc7f7458a882a18eaba2~7l0FFYfm41880418804epoutp04a;
	Tue, 23 Jun 2026 03:13:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260623031304epoutp04b58205b658a8fc7f7458a882a18eaba2~7l0FFYfm41880418804epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1782184384;
	bh=tatdd/Q7QE0upqPJVjWgLFwHUzQQq+izQdPrwXLkDtk=;
	h=From:To:In-Reply-To:Subject:Date:References:From;
	b=dNfxF4M3fyZDfW3CRh3lyZWqMNYsOP4XtAdUT1p5ZJqUeSRRx63y6bFC8gBFnYGJ/
	 2PA9S3WitCXE5BiEd84kDRmhjRFpItBmgmC2TWVubBHDJLlGmnyl63bz1zTjkIX2Mn
	 UkknWAWYwpil1XaCsoKvzcmVN65+WOpAu9nWyWc0=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260623031303epcas5p378f6b175e3e88956e96fb88e6537bcf9~7l0EthhRN0685906859epcas5p39;
	Tue, 23 Jun 2026 03:13:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4gkqrb4vT0z2SSKX; Tue, 23 Jun
	2026 03:13:03 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260622114525epcas5p2654a56b123110dea3b2fb97739d9a92b~7ZKI1GCT00255802558epcas5p2L;
	Mon, 22 Jun 2026 11:45:25 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260622114503epsmtip205edc6f0281b21bca275e7401267a8a1~7ZJ05N0KR2405124051epsmtip2Y;
	Mon, 22 Jun 2026 11:45:03 +0000 (GMT)
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
In-Reply-To: <20260622101606.485961-4-krzysztof.kozlowski@oss.qualcomm.com>
Subject: RE: [PATCH 2/2] dt-bindings: Drop incorrect usage of double '::'
Date: Mon, 22 Jun 2026 17:15:00 +0530
Message-ID: <373928166.21782184383679.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI6ZcaYiR7zkv7wowZwd71jplyCqgLGmQzlAevIaT+1ahn2EA==
Content-Language: en-us
X-CMS-MailID: 20260622114525epcas5p2654a56b123110dea3b2fb97739d9a92b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260622101634epcas5p1137f33cd1e53341e3d7600eb105cd859
References: <20260622101606.485961-3-krzysztof.kozlowski@oss.qualcomm.com>
	<CGME20260622101634epcas5p1137f33cd1e53341e3d7600eb105cd859@epcas5p1.samsung.com>
	<20260622101606.485961-4-krzysztof.kozlowski@oss.qualcomm.com>



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
> soc@vger.kernel.org; linux-serial@vger.kernel.org; linux-
> sound@vger.kernel.org; linux-usb@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Subject: [PATCH 2/2] dt-bindings: Drop incorrect usage of double '::'
>=20
> There is no use of double colon '::' in YAML. OTOH, the literal style blo=
ck, e.g.
> using '|' treats all characters as content [1] therefore single use of ':=
' in
> descriptions is perfectly fine, whenever '|' is used.
>=20
> Cleanup existing code, so the confusing style won't be re-used in new
> contributions.
>=20
> Link: https://protect2.fireeye.com/v1/url?k=3D20b000b4-490b6806-20b18bfb-
> 905a08a8515a-b42887ea7482314e&q=3D1&e=3D9fffcc8f-6266-432d-a638-
> 208efe86c9d7&u=3Dhttps%3A%2F%2Fyaml.org%2Fspec%2F1.2.2%2F%23literal-
> style [1]
> Signed-off-by: Krzysztof Kozlowski
> <krzysztof.kozlowski@oss.qualcomm.com>
>=20
For Samsung IPs related
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>



