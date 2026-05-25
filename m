Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C5E383C64
	for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715088; cv=none; b=iPvH1An8awiflSRGjX/F0EKiEEAh+2szEC482AN9YLSvPQaysrQhptaHsiGFzA47RGnh2a+njLEVt66GOCf1InnzZDUsxsfDGAHJ+M/+ZCOlMKmjpzZO36LU5IHcum0rTWFw/eXE7D6x6kljk9lERCerNcuMq//XNTPxOxw1bNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715088; c=relaxed/simple;
	bh=6AhL2Gv+ijddqqx15lHdrdKo/NdDZbe2xZ4xnLmFRNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXOlW6j7TBKaPzgiaADjlb1Pkuo4goISOeOv3ONLjdNgVDrhJJj2xquOAFVCDiF8ctqWwXB6lqDEB4eX79qUfddd681fnkl95TOTf78j/keT8w/Z5B8DFs/RSISQR2Aqp7L7uOEgOsamLhcdUyspX8OF7VhijgSo+fyLZSRZKfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KxzpXi98; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UzNii3Ol; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KxzpXi98";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UzNii3Ol"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PCooQh1098010
	for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 13:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ybURYAZAK09wyFO+bp7VbLScJXcQAPWGCyuQwes617Y=; b=KxzpXi98vAfDD7Ok
	Dtx/Pd+T5NgeL6NfqYBrlmaLQpP4+I2keRIS/IteTFnwocTsHROwTUwlI2UkghRz
	bC9FVXdRj8Sz4u5v1dNeIJga/13xSLTTHDLrUJYCFkaDnMss3o6+nzS4En5cnd3q
	dR5EGuoF7bZp4EbDBwyLudDVxG5l9yqggDCE8TwHbUufTix12kt/MHtot8gw3WnA
	p8ZkcJ+PoS3+JJJnBbG06VSREKJyCPZemw5OveGzDaz1ntb3+LGXzY6Zol2ALv4R
	vJdx9AWxrSiXK3ps5MfBEdkj/NysFQjexOugo7qzNLDQMj1Wv2z31XnpHWSDMBZ2
	HUsIHQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4asxtbw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 13:18:06 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-90f6e66879eso219071085a.1
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 06:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779715086; x=1780319886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ybURYAZAK09wyFO+bp7VbLScJXcQAPWGCyuQwes617Y=;
        b=UzNii3OlBWq8T0zllpp8x5ca3ABGAo3RjqOAfR6FQja8+vcX3PjZGLmpcxNV9yCE8E
         bmUqnQzO1+DuxOL9cobgMJUGPOX9BtBkTVlGrNx6iyF0HLt7LuY/WwFX08UuIqa2iD6r
         Tj6wPy3UWc4vlP84QVPbsyZzGg3aij0+SB+l8YFK+kyCJU5VB7Pb5V4lz7MpIWNjeKpq
         liDzBKR7s4G94EjPTl5Nc370rryXebMU2UWRcCCAvWZ798g933ZB6+RUEYXi63xoOKEk
         jLC1w0Ra6XLfwROLfWNAULgo1EAXp9y+j7Oxvcr0CLkX7g2bFJCjReC8UYMpuQVjN5/6
         I1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779715086; x=1780319886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybURYAZAK09wyFO+bp7VbLScJXcQAPWGCyuQwes617Y=;
        b=njsASCV8wCkwcpXKIXywvj0OhH89xIkhF01Bx8LDoRdHbXEzjwbuEU3pqpQIGdMZ9j
         YrXxIeRb/lAG3ccK6aQD9wrmexFJj3+mM7m90k9VX+XfBmpTv3YREginHf9O+yoVYwF8
         gQuIk3SyY3Ww0bT3pjLcMMu1/gkCFCuoSm/wH2glyipQHu5Y5MB+te0rM0SjNlSCsfvk
         5hlW8SOopGb0T97aUGEFC+2WuCuecJYFT0UpmZs5xo5TwCP0dKtInNEOEcJ1/+yAOyhS
         GctKPYOBwXKa5eELSjOhuocZwkQspTiUHOf0cM23lnQjpssTEbUZX/GzxCPVxDWf65fU
         W10Q==
X-Forwarded-Encrypted: i=1; AFNElJ/LjwcQuZtMih1ihFfWYOxb3LnDq3CGooa2RjBW6G0XSEuwPSB9L2ljiNRUMnjozXmXFZ24O6GAk8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmEOoJIcOdwwom7JhzPvdh1R08E2sxJCj+z+xpjI763GrdXFzZ
	EHK8+RI2E8cc+VML9hI+FTBtRrdZIZeBX8j5YDa2KPoQYWTVfR2HVwTjRF9NZtfTi/NoSKKfmZF
	36ujkYH8wMBZy27ker5I/yQCMpqy2VOIjH8WQ4jb8LV7Na2ABtsI57eUT+xmBzrg=
X-Gm-Gg: Acq92OHpio8uTC34JfuxHcbMjlyQvqPSTi9dgP1PjNJFyRsxp8sMQw2mR0afXGp0Xdj
	PJYGgINiT6oOaRaaKjXkVZIJDZjM6qbkION7ckwbotXnaJrBOGXlleLYmh1tjqzfmv2Dygz/yf2
	mtbKCPN3AazkaooSVVzFHXs3lNhjjzhv5Qbz63zTIy0j+Jkraocop1WAAwddpcdsnnmsAJmI3vE
	o6bw3JJNFxZs9gZmJI6IsXI+mXvCdx1ldXmvgCLhbUdulK+bRSn4wauPgahR/qMGQiF7ZTkPE6o
	SQjfh76VUzadmYa6UOijzv1VYiYuTWlAxJB6X9o4J9Nd9TlD4fOaP1+TvsC3JxRKfD6uRWdjYX/
	jO/YSQvtJ/GQAAFs22ymt3Ajj4TicA8EAIVmE3bamyML8dQ==
X-Received: by 2002:a05:620a:6485:b0:912:4e97:5e63 with SMTP id af79cd13be357-914b48c09bamr1312632485a.2.1779715085671;
        Mon, 25 May 2026 06:18:05 -0700 (PDT)
X-Received: by 2002:a05:620a:6485:b0:912:4e97:5e63 with SMTP id af79cd13be357-914b48c09bamr1312627485a.2.1779715085062;
        Mon, 25 May 2026 06:18:05 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688b9f50364sm4126356a12.8.2026.05.25.06.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 06:18:03 -0700 (PDT)
Message-ID: <7d61b15c-b303-4b66-973f-b30d2314229b@oss.qualcomm.com>
Date: Mon, 25 May 2026 15:17:58 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: Add Shikra EVK boards
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
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>
References: <20260522-shikra-dt-v3-0-80ffde8a3dc4@oss.qualcomm.com>
 <20260522-shikra-dt-v3-5-80ffde8a3dc4@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260522-shikra-dt-v3-5-80ffde8a3dc4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEzNyBTYWx0ZWRfXyC1227EHs0m7
 Vogcrn3BXlTYrZS25zHOg+UqjBdsg5vfCBX8LLe76iktYxBlZSwT2nrS4VFM0Muxq4kJBRHHD7e
 V7TFPCZr27bLwPEaxULedLg4/YO8XNX0QbSXhcSomV9QC2TrZlu2UR5rmpypX0GN9J1iwYrDtGC
 pMq7J5ASqljJCS47r593yvsvIZKeIyjJcTg/SXOBzln/tzEFF8edIzjkyn/m6XgkTcCk1cYhIzv
 nuQX24zRq8ybOlt/PUAdPm2ps9RAbrN+cgmW789jdRsuKBeFweZ8yTB6bYFRiL+RDppgmFv5N5C
 VmcnEScX9HbU697ssGNyTw0SVIHYIKkibFoQgfj0vgtLpE/vsdB1fraDIGpRMxy0ZLDP7O2DFhv
 rXStPBdooMRrrBadbfbPS50s3co9zw9jWaylbpB/AqcZMzHyu8Yr5UCEulbls8K3fiU2YPV2oXJ
 mfobo76eEvXxmSww6Ng==
X-Proofpoint-ORIG-GUID: ayZpozdBmUlNUC7oTTjQ6x8niex6cEfN
X-Proofpoint-GUID: ayZpozdBmUlNUC7oTTjQ6x8niex6cEfN
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a144c0e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=ljmfqE2-A84B0niWMNwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250137

On 5/22/26 8:02 PM, Komal Bajaj wrote:
> Add device trees for the Shikra EVK platform, which combines each
> of Shikra SoM variant with a common carrier board.
> 
> Three EVK boards are introduced:
>   - shikra-cqm-evk.dts: pairs with CQ2390M SoM (retail, with modem)
>   - shikra-cqs-evk.dts: pairs with CQ2390S SoM (retail, without modem)
>   - shikra-iqs-evk.dts: pairs with IQ2390S SoM (industrial, without modem)
> 
> Also add shikra-evk.dtsi, it represents the common carrier-board and
> daughter-card configuration shared across all Shikra EVK variants.
> 
> Co-developed-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Co-developed-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> Co-developed-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Co-developed-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
> Signed-off-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
> Co-developed-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> Co-developed-by: Xueyao An <xueyao.an@oss.qualcomm.com>
> Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---

[...]

> +&qupv3_0 {
> +	firmware-name = "qcom/shikra/qupv3fw.elf";
> +	status = "okay";

nit: let's add a \n before 'status'


Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
