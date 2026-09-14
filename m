Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B17947F3D3
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395684; cv=none; b=AYKNYRbQ9pL3GxZuaLtqOy+D/bayej+kfvxbzP50DP6USXlAkehA3aFo8UAJhkL4UrilfJoa5FnxhZUlCCJhFBUzOzQsmt/FUCTkGjEISDyHn+LeXD5E6V/8T4Nvnz7AUEFVUum5t6RzUmDvLRL6qMmql+CQPegSQYonAkdpQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395684; c=relaxed/simple;
	bh=qpr20bFoWIAVz6Uu6SDBY1Onol/yGpj70dm5w/7HmbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5fmRbJfg4bJUU94mQ+bQrxjfXswwIAigaRyMuBHHFfP597hxyg1o5RSKns2aHLsFgkdtYsD2ZLqitqYSZPgGVZRwzRpgvUg0ywgiA5QqDduNlDuSdGIFwLD6tzh9ne9wSyXX4/+asCBqDMC0XMfB7DehjxcgJD3BoorzBUm/lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZAA0sVec; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dZQtb65n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZAA0sVec";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dZQtb65n"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0YUt674516
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 14:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hsC/n5G/ysH1TDMPqrs15Xr5
	Fe1eAaS5X/4GfDOh5vA=; b=ZAA0sVecotuQbIutF2EPWz8avV8PBXwK/D22V4EB
	T7JIXLLQ1Pw29b6EVFSY0wTE0TlLHg8qvV6Ovch1DnuNa6WKDmsBAgDOqC5PTuHw
	CixdNiZOG/sxPSsQUkr2Jpm8dKWiAr/QMr+AD9bvsFRLx/2dX/P8Syg4vKCUUFV0
	L1N+4XVPHfeVUI6LLy/0yu5JJQapY83jolFHwcayTw30aMwBkLJUNgcQzrjDmiuy
	EtLVZFaInA13UVi4sYGXkQg5Tur2Nc3gNJ1GHg1TMmmKRltzL3ZNdMRdbhd0y4qk
	MjDsMNpT3yqlYInbKgzhkCs/Kot+rkHfPMWXQuX82Ttt7Q==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpecs9455-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 14:21:22 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-798c310ebb9so1089646137.2
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789395681; x=1790000481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hsC/n5G/ysH1TDMPqrs15Xr5Fe1eAaS5X/4GfDOh5vA=;
        b=dZQtb65nHQWP/U+6nd8BGH73mm5a8w6wz52rIwnINgZABoGFTDTakG+dMqia/1/Dvg
         9RS5uXK5f0C324qddWAmOuCAEiGUTZvamsJReUOEgV9KWNx8GyPixE++IPNCq17wsaSm
         SXIBJZMGXuAUkpgDIQV7TLwWtBAmrK9Iwv1cpciZXhUX9kbixtZf6JQ4cIIqiEtTHHan
         wjRONlkdE6Fnd3odKhr1/ZqBG/alF9p/1EQOXWWJ65iZ7Y84RUjijBfHQkCAAXtSiiGz
         c9J0VTg9bY9xZ+OJ+2DvswPTRocLXSH+vN4LhIa37qX/Oz06LUQZeQRaReogwlSzrTbz
         zyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789395681; x=1790000481;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hsC/n5G/ysH1TDMPqrs15Xr5Fe1eAaS5X/4GfDOh5vA=;
        b=bYCAMo7OR4wFdhuHZnaDo1KSufSqYEytNzB6KWPrnJqEpH3SuUnJQuEtjrBppupzWp
         5C7GRbwH4a0fvZ+VsyT6r2VN9qbfvcTodaITc7PUi8PKfgRRoMGB+7staabPxoBpSviB
         lRzOorCPxdemETBr6S2YD9TK+SvUdLUQxjDrAxU8t20wZtS5F62rchbOG+mYdFXHayuQ
         MWfzECl99e7l585ja9H76Kw8Vg5wcimnHHXZFb3AQwbKu+BRdFFi1ePjdQMxIZkRhmjU
         a95T5mykBIFkFJBBBPuqWpusWRVKpEN/Hu0jL2rRrmHdEHiPbtdVVh1He3EN79Y/5Eyn
         f9fw==
X-Forwarded-Encrypted: i=1; AKwUvByimmFjDwFGu+DDCXSso/dA9lj4BfvFrVzXgNQeKSGU9Z3BSVBeep3lw7wG8gC5WR3MAB0x/8Q2lDM=@vger.kernel.org
X-Gm-Message-State: AFuF++kaUDM+4DxClxSX+HpXx+LobR9c6pa6A5KDnYU8F/hQi4hK3XZl
	Gx8YU0F4EmhP/Ncxqh9UTXF9BQjT2gHtxSsGF3JkSZzYfHIdKg1F8Z8ac4/4SXLO3TkBD+X86UU
	RBcEL6P8GtpyFnAvhA7JewTVkWjeKZwmp4SBpAJrQqQkkp8OplS8tt2B++/yaM2A=
X-Gm-Gg: AYBFou1kr6Mu5n8PFOacT3MSzktIPo96d58bfWFx1IRqoPB0XNmSe/n6QBUYbS5JJeH
	ClvJSiWBRrigqpUFiVNn/k+pNezjFM4aUK9r6y0LG988qqiHrAOWZ0a5fRj2qe/Gq+S+oZ/7Qp6
	6VKvIRUWMLmu4sBd5A7SPRkE5nTuGbBSher7j0yOph7995RDqgGIwvc6Gi/TpNzu16bq8Irqnw4
	t6Sbjhn2mDM8xa0FbinjBNivQfs60jAYRSvKWLiYo4luN6JaKbQh1UhwyLEiObr4CHmc48r9pB8
	Eee2H/Zi9G1+Y6hRiKhvNEJsXCpjHxJMxPrQscvKpDc8zZU+EHDly8B9m62kjYAmQlJUWzu424c
	M4WFNhxcYoBqVpPY=
X-Received: by 2002:a05:6102:548a:b0:79b:dfbd:d0f7 with SMTP id ada2fe7eead31-79bdfbded2bmr1731008137.0.1789395679763;
        Mon, 14 Sep 2026 07:21:19 -0700 (PDT)
X-Received: by 2002:a05:6102:548a:b0:79b:dfbd:d0f7 with SMTP id ada2fe7eead31-79bdfbded2bmr1730677137.0.1789395677612;
        Mon, 14 Sep 2026 07:21:17 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6499d57bsm477423505e9.3.2026.09.14.07.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:21:16 -0700 (PDT)
Date: Mon, 14 Sep 2026 17:21:12 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH RFC 15/20] soc: qcom: ubwc: Add UBWC config for MSM8952
Message-ID: <z7rjt5237gdtytb35chtyjposyvqpgqfsxhov2all4g2527aix@dabjw24dluwa>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIwNSBTYWx0ZWRfX8xDKlIRoAbyG
 9pgb8yE6tYtE6g0xqjmj3ib0TG8mveP4c049ILa2cvT1s7t1ATAwFHwCqIWITychxAAwIJ25/eg
 2TeWP1De/tLfk+GjrJ0ujKbwV/cLJGA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIwNSBTYWx0ZWRfXx6KCr5gjPDqZ
 yCTNYD5wI/oAxz2dm4AFliYVxW/TDTSGRGeRRmGzxJ/zmtKujVVsRwu9LQFhVGxI/cFaVknZM4m
 A5x1jmDkpCWj39mHrGUJGsj/272y7w0lU/dJzcWg2FhmW6xslDcumv5F3gJx8EiN3bdbSnRWMSZ
 yUmFvqa6qDvJctir7bQVbuCgN1OiWR1bYWA9gRTu5+5jsE9hlYnX9sC+v6kqrltz8z3lclfmU6Y
 ToLaiODOV4H8MJQ91nJLeqzrJnqoNvMFXhchAz9813jcS4lfWNzCOA+YHlthmZS0v0bMB49EBcX
 dB63JTJ8rbore4TmZB3v93I3qkzHnzQbjGNN5yAU12ygwk6FOnDyd6X9YrP7/WK7Y8WuHeUitDm
 Kv7l2dSOV8MvJf1IRWcc6ZLuqKvZXQYr4S54naAfgwjI72LY8enMMSF2X48xzyE4bDrVQt+242u
 +DlU3TjmWXt8vHUBMXw==
X-Proofpoint-GUID: 3_1z_TNANCctMvqQj6z4eDzyFLuBR3eE
X-Authority-Analysis: v=2.4 cv=b/cncdGx c=1 sm=1 tr=0 ts=6aa802e2 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=OvtQcJRYg_U4C0nSOkMA:9 a=CjuIK1q_8ugA:10
 a=TpgoBOgV9RAA:10 a=gYDTvv6II1OnSo0itH1n:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: 3_1z_TNANCctMvqQj6z4eDzyFLuBR3eE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140205

On 26-09-12 11:39:24, Muzaffer Kadir wrote:
> MSM8952 uses Adreno 405 and predates ubwc just like MSM8939.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
