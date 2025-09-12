Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542D619D8A3
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680086; cv=none; b=K8zBPfXHqN1ii4c7EAgdkMLpAVTxk30giH+z9EuL6qFFirfVsPupNVO0JhRSDLBihF+v4IMz6rjMfCvQbU2U5vUUNNxTCaExewJupKzr7Ngnx5vv7IZmViS2wh+9cJvCYGeb9yiY+eaQxUynjuM/FgiNagti0jfISH6kg2djgLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680086; c=relaxed/simple;
	bh=iJsSVwqOcKJ+jvcqQulAE5UoFoAGbSHsV9vI7EwrTJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUxQGYmm7X9/x8iQ+a0NNGVQzqIFiTJm31ICelncwtupymIV+FG+acHX7lo+yVoa2pDdWDwrbSF0o7Eo/ImZgyeNmlorTyl1MouZ9lEOSxhYlN2L1Mv+4gYcSWXKdqcDfs6TeihOXyxqQhb+NfDwFXKwN6ovTPKXJtQ/160B9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=isoXHVb9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="isoXHVb9"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fPvj012861
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 12:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hFUuM/6CWr6E6Ua8sjPcJgSq1lagiIOIVJ2nUPnOckM=; b=isoXHVb9i2tKsBRJ
	TQm4lxsHWuFDL7n3ICfQNr262hzzQiEbEnirW7xfG/7AoV8ef1UK6Oc8txWnMXkA
	uxSc1ukeqFtUkLzScgVskQLkNub7tfNBboRwknb7MMknY+C1DYWtSTbt0mEKpO/Z
	PApWevCNI/ZjOkWlZL5uoMwBfZOKfYiXZNEWLsEPPeQf/9sKmO7E9cZr0ulIzkqC
	XQoQwgJPqog8flCd5Bhxp0fZwSS2vxDQs9v9x/lo2QEEa46wKaxYKXGXXfYfLna4
	UC+J23gHmjvSNYciHYAvf4nvezoEx3vG9Z2g2XJVajs19Z2ktEeWUwgdZDQ1C+Tw
	uJbHGw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqgbba8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 12:28:04 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b612061144so2064181cf.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 05:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757680083; x=1758284883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFUuM/6CWr6E6Ua8sjPcJgSq1lagiIOIVJ2nUPnOckM=;
        b=TpeP6D0OueaM+rAA75IL+H2z/fZSBGdTL2tKE7kHKOxFCuhz1vK3+BG9F4X7S3PIMo
         oKJZoXaiDPX4a1WFuLDM8TERACoFFEf+a6ZrCQwwHxjIJDTItXO1DkMRdmR1KoB+lHkZ
         iZMUapuV9/WgRncKsHUU5BCjrfgfm1PcAbHsSB5bQfwzTN7YN4JwMxrhn6ehugG4gl2R
         ahesGrLY3A/7HnFKRmM5kYGfP5z0MHX8yPt78thVJQHG34dEgtVwwf79eciBi/ZsSMm3
         zCSCqMTqO93Roy2nhUDFj6XCBCtTVdtVg7fx1TMxXOAbyJXF8ryvoKKV5ppf2qItRxwS
         Rz9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7rprGbesq1tgpWYaqap419QdF74PY6WohJBpE3HFUFUfHFpsZir+SbKuk0c4+KJ6/CeSifLXH7h0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl+dpPknnweswP2XRSLJ4yLEazErvpUva9Uv64q5fWPCV1eM67
	jQ/DVl8GyM8hJ9koWKXveklB/2gmYD0whOmuXoTwq5ACvTtw7L7wQDulEIVjhcFcR9HbWvquoNE
	WDNJK8IDA6GfXu52R7UuKX9FHs6bsRejwXJJjJiPBSdeVVuYhxtI8vC9ml2Jl57k=
X-Gm-Gg: ASbGncucexZaJQuIi5wWpUGe4YUe7l7Hb/PNRfCtsHVxKCZLw88hmORTgU2Ubtz7NQH
	yzmASbcnMRq7b0TCfFB2HuSk/eIjOC5d9nidO4BGlm9MM5Snoijgi7C9qDxUluF88GtA75qeZ7g
	RHxJ8yscq94KMKX7xpQvEOeni58FDQKF/C/xWEdcAXPndT1z5IeRHf7m5+R2/fCeVOmD40b7gkZ
	L4IIEUW8yZGfDkJSDtP8t39ijJ9U0Y7+6OvDddYvlPsZm3GWchsQhcb510sFr5QSlU6T0xtdIBI
	uXIiCb6vJLlXRw5jl5wSofhG/HJNcJRSA+fisToKIPapXrUpEMvE792FG4p4ciZJFO5zKO6dlkg
	B4IpbQI1S2zWfYFgOC+4M/A==
X-Received: by 2002:a05:622a:1984:b0:4b5:dfdc:1f0c with SMTP id d75a77b69052e-4b77d06ecbemr20553571cf.12.1757680083066;
        Fri, 12 Sep 2025 05:28:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8QzuRduFlaCIEb8iFypsFpoHRpXBscWN+xA6q9Sfc+5OImw0a6uM7bXGrxC/zLDbpdQwBZg==
X-Received: by 2002:a05:622a:1984:b0:4b5:dfdc:1f0c with SMTP id d75a77b69052e-4b77d06ecbemr20553301cf.12.1757680082556;
        Fri, 12 Sep 2025 05:28:02 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd6f3sm359239166b.67.2025.09.12.05.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 05:28:01 -0700 (PDT)
Message-ID: <cb2a5c93-0643-4c6b-a97f-b947c9aad32c@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 14:27:59 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/14] arm64: dts: qcom: lemans-evk: Enable PCIe
 support
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
 <20250908-lemans-evk-bu-v4-7-5c319c696a7d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250908-lemans-evk-bu-v4-7-5c319c696a7d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: NPdwlOzu-uZbTgD_mbgoXDqcihJNxbhW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX5wiz7pCkKVaV
 rOcT3J+vQ7+FjRL91C21hOFcnNEVB5MCK33Qc4kZOB1pE8U3757BRDotWrYh6OSf46ruXyv1Wu7
 XHLrIzFX5kpgaRNn3I7FFXRoxECkVOFv2mN/PPwJY38WizII4U1nDHpYVECMX0ntDAnsOZ/fRb6
 /HX1nvTA4xqG0uxthgxZbhdYI8uBrmDbOENqe2a0K6flh18lG/5Uq4hH4wEPVqB5ocvn0GF/CSK
 KZ0GjobeymbCInl47n/Zu/hdyALUOhx9olYfvLazK2bB4l9Ii4wz04Wav6TxK17b18GGhXimOCB
 mEPlTwTgtTiJUwgaS2OZ0rOWVmn4JAIL0+LppGp9PG3g55FKraHJ/9QR9TYDJq9k6sD7ReysLFJ
 PXTB/+D5
X-Proofpoint-GUID: NPdwlOzu-uZbTgD_mbgoXDqcihJNxbhW
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c411d4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=nUKbQzcQiuh6IjOItDgA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

On 9/8/25 10:19 AM, Wasim Nazir wrote:
> From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> 
> Enable PCIe0 and PCIe1 along with the respective phy-nodes.
> 
> PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
> attaches while PCIe1 routes to a standard PCIe x4 expansion slot.
> 
> Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

[...]

> +		perst-pins {
> +			pins = "gpio2";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};

Pulling down an active-low pin is a bad idea

Konrad
