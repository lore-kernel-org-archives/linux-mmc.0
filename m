Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4FA368D5F
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827842; cv=none; b=taZjh4lmmwD5kvSUlTQKdjI6D43YCfetLoJQzqD4l1si2IzGVxOmQEfM+En9QypmQ0FCgsvKE307SbyoC93n4ePlqpO33OJ5aH0vRI6bG2A4UC9xFDtn9jH/8j+R0rfgyfsjf+eA6K1zXDHOIK2kr8Zw9h0r8eVYhD7mzLOXNc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827842; c=relaxed/simple;
	bh=VZXDCkGXPqjXNLo87oDiL3MGUCb/C/NcqCHPksmBoj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwVKdcgbbjmxQgWiWkS25/btx0PAfADwYDJE9OHDSBnXM0lzL9aWsCVxTp0oMK0tpzVuLgw9E3esw9D6wYNHfTaK8/ekzvvN8ppAx1YwZd4CsVsCTIbjUF7K/WByzAv1j5axmkOlafhWXQfVELFxEI1wM0L8xq8k8N+F5E2xT4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EQ/hQGc5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RYp/5oCS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EQ/hQGc5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RYp/5oCS"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n19v1573371
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 13:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jHHiZ1G2Of8CDq7sIn2bONVFdln4OQz+K/2zgUurUOs=; b=EQ/hQGc5r0U+JEjJ
	rwXLZDRjg/yJx5q9y9n8AmOTYjnbhXszb4FUElud33w78rD93Eypmp1NnCYi0W6q
	PuEjUGmqiLeRE9r5VakI8DKVA9qkbxGoiWxoQgzq0Ww+J5ZjOB4c65f2K9kb3ssG
	A1QTZJKj47eZ/wB/oH/FItolhwmG2rIGD2vnmfjGl4vnQKIyyKuzKLZ51eCCII6a
	onPKtqM3y4gk72zTUDXV4o79M4E7WHnpEIL5mcr9ADcFSSg2OxNW8MWTuQmYrrA4
	eGFAEU+Yvict77KF8ItlALa2KxSnXLj8DHL5vKIdvejhUMfUSlmLpP2meIsjQJVi
	+R3+tA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f46862hhd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 13:57:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1857417aso364761cf.1
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782827839; x=1783432639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jHHiZ1G2Of8CDq7sIn2bONVFdln4OQz+K/2zgUurUOs=;
        b=RYp/5oCSqSGKmIOywIPiNot4M68g97xtxRi0V77cy+1t0dc2D2v9+xmZnL1V2wEsYS
         D+N0bv6ovxw5yP+mJSGYuRiU6KxhIXCMUWDsQkCCZcyH6Mm2dW7wKRLGoWGEB/Xo+IoA
         VnQNhSKtvc6Sg47ldrQIY2iEk1bhY7FlsHdFSVGBJYgi9nPoSZPTVEqcoxgxQk/9CBsn
         CZskP/kNLENHuiucvyCdRk6CW3FGCQDtSc+bw281RDw0JhzSvw8YoJrpI4ChqISeMwGW
         13YoMkyQScG+gfGsBeqrXa29D41Roy2j1QeTR0gDK3FOGCN7dE0AGzcZTGlVcPnEBCXw
         ZJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782827839; x=1783432639;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jHHiZ1G2Of8CDq7sIn2bONVFdln4OQz+K/2zgUurUOs=;
        b=ovPoumboMSHwJ4gnCYlEAeI2HH+88hjNtrQOU3gAbJ/7H9K7BfdE4eWdgQ3Jy4/khF
         wQtr758caZMcsLSEP/JDlpQWOa5ksoiRDlMjWid8Kn2HDGBQWRQA6rmCpB5wKj0f9l6h
         Us90lFSEiFkTK6Z6IdevY82/ql/fvsrExrxQyhRux65CB1002DKcs048RHwtX6dVlrT9
         rAW6kaSq/QcCN6gzTs5Q7M0/S2dPQkgQjXLSRBmEVwVr2yB0LcaB31vawrRMsr/ySPmR
         ExP+9PySJ67wBIpToVl9XoKZ5ed5jXfFJVWQ1saSrUzLOPqtib80gh6HI3fdvOD9L21a
         GRJA==
X-Forwarded-Encrypted: i=1; AFNElJ9P4JLkZcosepJtmhfQjcsPwKW6BB/+wJkadWaZmWphhotuAzLXYqM6Pes9ePNPTJ/oIZd9e6bx6gU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzvKfPN38NK76V4Qresd81X5eEq8Ts++Zbsxh30elGiobV3yk6
	DKWrir5dImJdCywFlJiRCFQHw+RGQZ3lX9MaOIlYHlO3vZ3q05aLyhjRxHyI1QfG0qZADfjpaE0
	1sJk6EvvM48h1v9+YEmI/LKjfMgQoKpmU3jxWYUhYuo0A4q8hOtJOhwRuK8PiQ2Y=
X-Gm-Gg: AfdE7ckOl1tM+uB5i1v+UJ7fkE/vt8lxBqFULMlMR/o7QzuUjakw8h/f0XrqyomeOY7
	v8vGRG3CEUWdA5dTm+uiGaF6egzmJ20X7f2YL2BcUPeKUk6qmZfb1svviL8uuBIUPqBZSBJ6+BR
	RaorGYxBbvS+9yKrVjc1IqMJP6LuAmRKXB/LSQ52m/R3PcPSxwukE4souJxlfSeOU3dXPhTe4Dw
	26XILYEO70e0mDfCFaB1GzYlOFvTfqmcF8ExBSkoavfibADGIIkQ/vKpgy/xLkD+ueUwLXdGSxW
	n+NamvVW3W55G/ooExyC4Ktb5iiVP5l2tyeodYfVAdXhZNCJ1r2yraQXZ8JQhPbrKXjkLxNGfmz
	XJqlA3v9QbK4skywyMSLScxxjfiCW+gC8XuM=
X-Received: by 2002:a05:622a:286:b0:51b:fe41:4764 with SMTP id d75a77b69052e-51c108197b3mr29499291cf.7.1782827838856;
        Tue, 30 Jun 2026 06:57:18 -0700 (PDT)
X-Received: by 2002:a05:622a:286:b0:51b:fe41:4764 with SMTP id d75a77b69052e-51c108197b3mr29499051cf.7.1782827838397;
        Tue, 30 Jun 2026 06:57:18 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c128917594csm132716066b.59.2026.06.30.06.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 06:57:17 -0700 (PDT)
Message-ID: <359d3d95-4756-49f5-8dc4-f24f24844f3a@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 15:57:13 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] arm64: dts: qcom: Add Shikra IQ2390S SoM platform
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260612-shikra-dt-v6-0-6b6cb58db477@oss.qualcomm.com>
 <20260612-shikra-dt-v6-4-6b6cb58db477@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260612-shikra-dt-v6-4-6b6cb58db477@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: eBtRPcjRb6JdkA8Tsh5zWkpwoPEWm-1q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzMCBTYWx0ZWRfX0KzEWUR1eLMW
 VP/qF6qd0kDyVNoQ0Nh3fSKLQdyTVe4vwIm/gY/KLUVV7ksT2HzaP6DvlFq0zDnHIpo4weJ5ydk
 8vXe6/W28wNBMofduOmYVeU0tGJwM5WtSvZDaJ+7flOyX3fO3GdVXeA9Slmpsn4iuQeaioM20R9
 /yYktkIn8KGhCFecQjb0cHhpMcRyyvhgkHmHBANvCpvYuxE4qNxhNts/gDrCaLWtft8IAI+pGH9
 rvKf/nHad72oX+oZJh5cLW/FeMdXUgzgGT4U6CdIweZHqCK4XkfQr5zLRL24GRTwS33D2rG6USu
 BT8bsmwSsz0v3+KqxKLlSIYdM1fY6uknjEnF7zQjgaBIsictWPTnR8UDcq6WP7E6sWPTe3QzxU8
 +a8o4uAJVJO/rPDpJ2RVBvOFEpIhICaq4TbNmllWFSG8PPwcHMqV4o8s5hjilAzqtt46qI6Buwx
 KN4hgd0bT10bQ4qaJUg==
X-Proofpoint-GUID: eBtRPcjRb6JdkA8Tsh5zWkpwoPEWm-1q
X-Authority-Analysis: v=2.4 cv=FbcHAp+6 c=1 sm=1 tr=0 ts=6a43cb3f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=MSeU50jLikp4iQrAx_QA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzMCBTYWx0ZWRfX6aR/Sb+brBq8
 PUT2ZKVdKBPMMkOIDluGLFZPAWnrEdzf+3THeKan87XPvW7Z2X8U32eIpYT/AhQrmkT8U0cPOg/
 CUlZULkJZ9sPFJXsiw+oFHnWxnygJuU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300130

On 6/12/26 7:27 PM, Komal Bajaj wrote:
> Add device tree include for the IQ2390S variant of the Shikra
> System-on-Module, an industrial compute module integrating the Shikra
> SoC and PMIC for industrial IoT applications, designed to mount on
> carrier boards.
> 
>   - shikra-iqs-som.dtsi: Industrial SoM without modem (PM8150 PMIC)
> 
> The DTSI includes the common shikra.dtsi and adds PM8150 PMIC regulator
> definitions specific to this variant.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
