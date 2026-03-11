Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FBA36C9CF
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773240331; cv=none; b=JVcqKhL6EZr+i+7X9Mp+qa/xeyGSf5MK+JcnatOmMvGVvyl9gQ5hnvtDu1Ed3GGbqvhr3k3vGV/yaRbAXRWhrOAo8+otIFZaL7iNnpvDh0XkQDxIrL9qSnGhUMTuFezEYtbJ/lCy5w5InCuE/s+fW+wH8fWVVrWWK/mkCYQ0hfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773240331; c=relaxed/simple;
	bh=Pz3LSqnSgZPO+sikjWgv6OurkSgn5CfbQsARgMnvaBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlptwFoSrPR2Qs7SPb740E2RiLsVeKy4OnhrcH4EDW9Tf2jJ8cbphcgAeMngeeu1jyVVLzGvMBtou3BeFLHEmNb/pj+XxrvPPIIprZeOA0LudNH9hEEkTmHFyuDU3k4hYI89y8/MGtjunWgo/r+ZCtcxziIWEMgM98GtLh4kibI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kw2J3vh7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q+6v2oSJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kw2J3vh7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q+6v2oSJ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BBnvBe2677237
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 14:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hO8HenrdBwBFfXwe3brj0XRv
	Cy9c54B12m4F6gx96VA=; b=kw2J3vh7ymtz/kDj+rEzGHXzcJGFkEUWUPf0ur5W
	maaox5TuiYEjdMEYhxPsDWVJjVIIGGq4qgtySqX096u/zI6YkLGAnsB/EpWbaLTS
	IRjPKY/8/AKFPLIvnifmhm8HELFgKZZOgSfKFtu6OKNNXcNRruuUkUSnirZePBBA
	ejbUsKOAtg/iYkz4iTLIwGSkOtE4S624djbaY0uwbMAc1EfuyVko69zrVUnb4VMo
	ZwoPKd6BqvGv/1wV1Ls9FrrAEYoR8yTR6jMW6TLTFNdoLnxKgXYPFS5LzwssU9zi
	sJ23EtaBBIgq7TFOGJkfMB1wOehe0KK2vs0cDDfDBb9grw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu3cd1tkn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 14:45:29 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5fb6622ca5dso12887408137.0
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 07:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773240329; x=1773845129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hO8HenrdBwBFfXwe3brj0XRvCy9c54B12m4F6gx96VA=;
        b=Q+6v2oSJIfT3fJM8A3YHsi5lPT/96LTJPj4L/trpvEWi9DR7hjIYo4GTzGkmS1s0ws
         2kL1h7hSPhVv9eTZrpOdzgycogPSv4MUsnPIsqHxT7+ZiJsQH8MAXeungtZs8ngvYm74
         3RCvxa2CiiOx39xdSqKv9R/Y52PsbVhqtVTEkJudOC5UsgXHpofgrrkF/RGuASz7OGO4
         ugY89voj8Rm7zA/wkJfAFZOabnem8pYFMBfrHxxlARZ4adnqArusEG3yXH4dz7y91O4B
         NP+d7LHCHK7JydKh6hFcIboOX8Ez6wbYx3A490IsmDrLWrPJogfR0aQuFL5zXZ4Quw1y
         MYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773240329; x=1773845129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hO8HenrdBwBFfXwe3brj0XRvCy9c54B12m4F6gx96VA=;
        b=JuB1RXqxCOjyBNkzR1RWetYuKI4CClKaUe4gsJMVfQVLLsID3d1jbHVU2Fc7oRkWSK
         Wp9aTPDO5FYtDeN6G4Du+hVPZX6bJ5PJIuox2dEwSXyU6RaupgfV0anSvnSFPooDyFfn
         66ar74l+00JvmcY1HACuxFT0qBMDMod2Hgb1t4lltj2XmhvCOe8k4wH/Yf+o31vZEbqJ
         iG7MWEr5Pt2gtsbGVxeYlo9aPhjizp7KhqB0JjYx/rJIt1GpPPvHwaOhXSMc5EurCxEM
         0CZuNxFoHZ+HJW4NKXOdo53NU8KNKgmeFsiZOvlSTSJ3N9T1/QiXFfwfkA+ko0UqH/jl
         KDmg==
X-Forwarded-Encrypted: i=1; AJvYcCUqUdcXUSlPlAHrMjBH10JgJz8/10TC7K1U3/Ik1ZRnbRmPhk0RqCjBCwkXD0PBdZ1wwMl35wxYAGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO2dtXEPkmP9p1Nu64HY90WuOfsqARAdl8tHIB7cfmXsfY6Dmh
	cYUA7sBQhLbtdkm56545iVrIdbypaqURCpKpS22Q9+uBiipfjcO9ILfPHJs31oyK5m5lVo17SHh
	cZhWojY3GdQBbQt+XH6B9wRFRqTD+uQUcKA7O2UAS1na5SdaW5DQkbHW1fc5MGQU=
X-Gm-Gg: ATEYQzwBFARk9jk5aorbIpwksrRVDlkD4GmghvGzCyVF7z3yiG7UpZONKDcF1CMvlfE
	15EIn0qwa3e15Vt+j8LMgQuGdB4SAjs+GoY+VLGALRADQ75Xm4gAkGT2R09YVGEt5DSG62mXHJZ
	sSAwJOZni6lIkBL8TzKHbjgidZTMR1KPXlebP2t8E5Pp44c0kE/lknv/SC5uu1l5Y/yZjPABvC4
	JtKnwx12p1wpbWn4QKaMGYF8Aj0bSpWFuHuCcxO/lFxymkKUN0SOKMcWeO0UWDHa8RJzWsRqkGl
	2LUHn5MVopDaOlvtw+DW7GHTOleyj9qW40trGqu+1C2RXOlRbPbSPzL/9TixVakMFm7h5hYJuiV
	o6Lg0DmanQaSqrdWZVZt58p4/4SdD0k/uzYPpLqE8GDntayEotsHTvmP7tDV37r/30IaO40sVLM
	Dpzum2h85lzODFwXAATRSPlzrrNaHPrAjHpPo=
X-Received: by 2002:a05:6102:41a7:b0:5f8:e47d:165 with SMTP id ada2fe7eead31-601deb1bda7mr821294137.8.1773240328583;
        Wed, 11 Mar 2026 07:45:28 -0700 (PDT)
X-Received: by 2002:a05:6102:41a7:b0:5f8:e47d:165 with SMTP id ada2fe7eead31-601deb1bda7mr821281137.8.1773240328114;
        Wed, 11 Mar 2026 07:45:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e6788csm3872241fa.33.2026.03.11.07.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 07:45:26 -0700 (PDT)
Date: Wed, 11 Mar 2026 16:45:25 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 4/9] pinctrl: qcom: Introduce IPQ5210 TLMM driver
Message-ID: <mb5x4jspf4fwinimjnfhlf45gee2bajqxcp2nglqqkfnulnmbl@4lvhh2llnxjj>
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
 <20260311-ipq5210_boot_to_shell-v1-4-fe857d68d698@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-ipq5210_boot_to_shell-v1-4-fe857d68d698@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEyNCBTYWx0ZWRfX9mbnPlWbeJQ3
 G/yOWjE07fXLD2Yt/+FxjESCb3WikW8rdnsEFw1ze6lmLbfx4xkn7Y/eKzGkeUo6XIg2M9naEpA
 P4lBr3iD9PexNsRqd5lTn37+h2GsvyFKyyXERBtTrrsnrY6NpOYtN0kkjVY5q1cirk8Ep89Ym/I
 zdzgOvtiGJervEnIw4O23AREuhs9YREcgCxZukDqiBSEO4Wk7bgoBX0/bo0fTuN24ypm8zJxgjK
 /g7axU/I+Gg4iBvNf+izlE1gnrvrCHC6kQX+7yBaanFTNw2wtf9ZLRjF1ABzXkc5Bd2BzdWAzkg
 tOmViSQmEdDcKK2brvpLKhQZFlz2KF02gBNW7JVhmsRVL8ASuHa2h3XVhYjUXo63PKggxk8Lhfe
 jg71fnnUSD8cR50m9UFY0dSw3lp92zaXnu7/eoCGxspquAQCf93TGfFe9ILLjTddA1f3UAzud2k
 RcLaVFFHqBstMU0lLRA==
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=69b18009 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=yEwgHnYd1rMVcNmT1VcA:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: 5r3o7-POth9fdlHTYz98vHXNYZI8g5_i
X-Proofpoint-ORIG-GUID: 5r3o7-POth9fdlHTYz98vHXNYZI8g5_i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110124

On Wed, Mar 11, 2026 at 03:15:46PM +0530, Kathiravan Thirumoorthy wrote:
> Qualcomm's IPQ5210 SoC comes with a TLMM block, like all other platforms,
> so add a driver for it.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  drivers/pinctrl/qcom/Kconfig.msm       |    8 +
>  drivers/pinctrl/qcom/Makefile          |    1 +
>  drivers/pinctrl/qcom/pinctrl-ipq5210.c | 1156 ++++++++++++++++++++++++++++++++
>  3 files changed, 1165 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
