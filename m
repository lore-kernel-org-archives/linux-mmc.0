Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079CC23BD05
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773406481; cv=none; b=RP0KQa2if7DVkyxFRXsX4UFwltz7cEQFeA0UuVN0BFvt2YJSgmjh+SkvBeP163LWpb/Nhaqlcd2EhxKSg26Wo/k+e9v4vT2DFY5MgSJ42bADNPtY5V1dOJH1yHVQusPqU32l93rL5o87lbkj57fv9zUIWW/Uxc5Wv9YvezqyrRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773406481; c=relaxed/simple;
	bh=jQS5hWOdYB418CAw1PuBt8maqGMZdsbdkaYVXTrqH8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtVRcjx7ofOC8yl3ImI5n4QLSHtvMR8GKsoxD1T0xcW6tX1gslGfa1EaDl55SzFWw2HAoQ7Kudpsd8g5qPZEIylRrncXzDTE+Go3KFH/RBON0DbaBAC9svDbc7ZWkqIE5B3dAPN4dOWz4TbgHRVbqNokJ1hloHT4JobBy7Qc7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NjXFX2Dx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YgE580FD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NjXFX2Dx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YgE580FD"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DAmpnH2390203
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 12:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GrWQ1YC99XSo/kzP4swRrD7onPPXsUnNzZTfAflWHlI=; b=NjXFX2DxghTuYEVc
	gkLO9DchOlg6Ct64GA/xzNCBdaCoqS5x5lb8bzKR6d6gJkCDoUtNNA8+CDYKWkZe
	J6ROl4bWcC1hOPZY2+FPRonOGLycVeRCPZlV2xMXPYy0dFsVcCmPI2gzDx/5KY6b
	uBL+cYO2rprRA8gSl2kjlMEdHRNb03i3yV4YoitdXaXyWD1wm2QTyl8SNoYM+Loy
	6/usSWLgOBLr6r5zpKhUbyZpo4EB3vGM1JnmfmTeU3XgzVEyTVzTxQP3SJDCqqdq
	QpHsJmMfNwGiszMJ9bAWxcUCdnvYx9V57LB5JZ4ZUqfTiooWovFhx6CAdAfqAoNg
	a3G4hg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvh5m8brp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 12:54:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd8e89d19bso117525085a.2
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 05:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773406477; x=1774011277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GrWQ1YC99XSo/kzP4swRrD7onPPXsUnNzZTfAflWHlI=;
        b=YgE580FDHF0xVVmM2L58r2beHUuXjy3mt6SvZjT0rzfV8ex2CnPx7cRzlLIthKTo/v
         MjOBXvXWpvZ2GKfOd1uhYCaDCt7LMmJSyi7syYMQ3tSvFzw8W3y4EZdkOFo2yHCSi7Nc
         W6+GpTASnCeAwanWNeO2DvWsRc4INGAdEOqCPLTdYNpDsczJEDblnKla3a9irlrIVbS5
         0P5pA3uVZeFoXFInATCr5R0JMTNV2pgpg6BYGoiXYht61sK0g7lv1oNQ+jhDbeaXT3kH
         MUBgnprFCfGleOoodP7XexEw4WUYzmXPpYEhqINrzic8OiKNY577hjABUJsb/OvyeLV9
         IUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773406477; x=1774011277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrWQ1YC99XSo/kzP4swRrD7onPPXsUnNzZTfAflWHlI=;
        b=UkMHkOe/ulGr+Dkwj6K5eFpQHisL6ysh8V2plxi9Y4VOxcSgsYLrdYjXXl7rpW0YA4
         sp0uiVUU7b362oB+svyNOW0V+3TYRNKdp0Q4QF4AZJ4MxCQBaP1AhYkWco0osGH4vLBF
         XD9ybcIHa/mv8/tiEjqKj38KT1WmPvAv4lUfphAyfDwe+81U+oY4qJ/Iejk9U+ZoLbjq
         REAxmgDsJfBGkHgD1JK/5181s1kWpa7s73yxbX+hQBeJljzboE/Zrwg0GaeYH1nCAqWD
         ZoOiRYTDxBWcTlVlmshN93Pkww06Jj5w+I9WxeGraozYZbsPH/pI0atpxxaZ+iGQykFQ
         BMDg==
X-Forwarded-Encrypted: i=1; AJvYcCUZGYAJHreouF2PJnylKKzdJsmQP0mZRwWy2YvJGDFLaCQyQoCjaPVDMR52kAN++ZIywloiyANqUhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm1v7LmsTZsH8DfAd4zTgG6xJj86Ib+JH80vLptdNYnal9iKL+
	hrJ5jMBOAdBIeFLBCgKBsmao54Z9D1bayKtcxuwVqY82/tRtAMPRaMKgaJeb1vqhu5fFQ6O/2k/
	jkdmJOfcs0s1RAYv695CvPkbVP6JMlzFFsLQISLds2o+YkzIdLenPigjMc+76EsM=
X-Gm-Gg: ATEYQzzEdI8HYD2I5OABU6sb7GA8npDUbayiMJl7MIU0UIauWLISfCsZr6lGDTQkcYP
	Chcars5DZOr7Ii8YNqlAh84tYUgoQ9GVVk6RB0+t8M4UTrmBrHCi9NvrYkcvCk5TsPWElIt3Fo7
	qFOuJtsWS7iFzvWfjb05fPJgxdEqLpguHwc+x3ZMonVOehU7cVdUxkx/hxl4HlUS//AVhuGYYoe
	2YLsiZI9dLnKu96maqhsVqLyhVRtF587xYOlGZwgBE6UBauDx+1+uBa7dV+9yBgY34YRJzzBYjf
	k9Hf5XOLoNShnJi4kLwZ7HYzUSOpXjlHj2ox9gJivUwws8P2DYd7MSO8v8tW8xceLmMlryT0oEM
	R+WlU37s8RtB3ICVaEddKiwj30k9pN1rMbkXSMTi03rgFvW0ABdv6CwhEHaziSQUfhWE2Em/Vb0
	B5IMo=
X-Received: by 2002:a05:620a:29d4:b0:8c6:ca3d:4e0a with SMTP id af79cd13be357-8cdb5a7e0f1mr314016685a.3.1773406477444;
        Fri, 13 Mar 2026 05:54:37 -0700 (PDT)
X-Received: by 2002:a05:620a:29d4:b0:8c6:ca3d:4e0a with SMTP id af79cd13be357-8cdb5a7e0f1mr314014185a.3.1773406476882;
        Fri, 13 Mar 2026 05:54:36 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6639fe6dc9csm794503a12.17.2026.03.13.05.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 05:54:35 -0700 (PDT)
Message-ID: <05a1dcfc-7df1-4b20-a504-468814a87b3d@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 13:54:31 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] pinctrl: qcom: Introduce IPQ5210 TLMM driver
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
 <20260311-ipq5210_boot_to_shell-v1-4-fe857d68d698@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260311-ipq5210_boot_to_shell-v1-4-fe857d68d698@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WHx9aVTK8MiqNc2EXoqgB7qFVvEHv2OY
X-Proofpoint-GUID: WHx9aVTK8MiqNc2EXoqgB7qFVvEHv2OY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEwMiBTYWx0ZWRfX7jh1f9qsnwWv
 4nMHdFJcFayC+dNTEhJHmWktoW0Ihnxip0lRiJYUDZDriUmZxK5Q3ZXm1SOv3DtNdb4wh4fp2WX
 IaYStvrXW/fXIn97HmjOyiu+sRGvT0hlIK3USFaNlXK+D3gX2Fq9AUl4Gp7YOvkApoI5Ko+BWEw
 AeWrDUsTK/3tjTwJ2VSyx0FY1nGhn5VIauwMt/4Z7/jJ/9oSGV2X8c5GSd0zTYdDS5/hgjeW0Qu
 NtM6yT80ZLzRfifw24jrNQFpNFKEILtY3hAY2RwVp4+5XflDqP1HUUEe1aOMheL9aRBzsAJgKha
 9OlWfTunmg5mrMpG9SjVoPP9zCwe9WpFVfXeq8sNJ3GAYzCaccOcyWzOc+7z4UT+e0rfw/YXVWG
 Wi6DwEpOgzP4Oxci+TFj4qOUtZ4z6i0NG6yRPKhEr2Rjjwxu34q8OJj1d5M9X+KitOI8FqfB6t9
 8gtweW9ip33peTK7CNg==
X-Authority-Analysis: v=2.4 cv=S6TUAYsP c=1 sm=1 tr=0 ts=69b4090d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=V7fxQ59pePFiGF_lOj8A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130102

On 3/11/26 10:45 AM, Kathiravan Thirumoorthy wrote:
> Qualcomm's IPQ5210 SoC comes with a TLMM block, like all other platforms,
> so add a driver for it.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---

[...]

> +static const char *const Led00_groups[] = {

odd uppercase

> +	"gpio23",
> +};
> +
> +static const char *const led01_groups[] = {
> +	"gpio39",
> +};
> +
> +static const char *const led02_groups[] = {
> +	"gpio6",
> +};

What do these 'ledN[012]' functions represent? Are they muxes for
getting activity/status signals for eth/wlan ports?

Konrad
