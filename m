Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED6361DD0
	for <linux-mmc@vger.kernel.org>; Thu,  2 Apr 2026 05:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775106896; cv=none; b=ojBYIiAs07KQ+kgRl4KvF7lMc0nsOyF2yuFtYhTjCSgrfnm0TAui8ho8si2G9XQHeh2cOg+on7J7ywUn6F+TVuzXpPPbHxaXo9jG213tC8hxMclD1xuIkoRaSQ8tv3P/2igJwNhgNTB/Lstu1rl4e5oqvrEiTri4od+L6mDM+58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775106896; c=relaxed/simple;
	bh=qvmIaMpB8VKwjCEWkXXEWkEa3PbVVnanfkVCOOFvpQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P//yAfLBd8K6hbWnlVIUyIWcjTVpjnxyAokGFeSFiaKujMQX6x3VB7YXNo1llR+BwUZXqIYPiPiiy2NeFM2V5RVEE2b0kCj9iJV1+9xFqI86Zx7baT7khkzLRiNeNr8/aWLqmsNbYZ6M5GWQupu/sTEDIs1+YG7nJ8WfEsA6Mfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WmgYwwz2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NRs7+HrL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WmgYwwz2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NRs7+HrL"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M4DO53335240
	for <linux-mmc@vger.kernel.org>; Thu, 2 Apr 2026 05:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XvLStu+nWIcIMPClCIFCdAtOii/H53hgE/Tykh3nb08=; b=WmgYwwz2QrscpI1L
	V/hbTeiRaQIVStwnZe+gIE136lL8FxI96oeb3HAlPHoS1IScmcEcQ7tZDbtfmIjO
	wnN1CJa+Kgzt/XyT4d4TCBVvittz/6YJ8ONpUgn18Pe4C9QjNMwGXiwRZ9hB0xO5
	Jfo13nUEAVwzxj4wZorbO59TH2EWfbgepniyEvJD6AA9lyC4PrcKJBcd20Nvpnc9
	n40W0c3Txj9/aXbTI9y2av+z9v9DLZ62X9tJgOxH+Y9QmPp7dRq1VS/HX7RN+Ur+
	Z9CjnyQEyK6YaquByQMVB/RczjuUZMEGm8Yp1QTlNvuSE8u62f0wMbInYfr7iHNa
	wc1kWw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xm3vn2v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 02 Apr 2026 05:14:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b24af7ca99so5214185ad.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Apr 2026 22:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775106893; x=1775711693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XvLStu+nWIcIMPClCIFCdAtOii/H53hgE/Tykh3nb08=;
        b=NRs7+HrLV+8yWKr8wykK9ccynzu1iSWh56pp9MOQHIdbqe3Auss7oYakQmU/yWQ8WV
         IBBDXAnl7ShnaKRofm+pc5OqUgMyM/I33DJnQFSmzaQwEVCmyKTQ38/npcTKf7v4bvhE
         ta1XsHmjmncd65YMVZVNVYWtq5Bu+vMQoQ0FK78oK3nVz5c8/VgplfTAyzMRHLtYdk/h
         yGS1AvN3IO9aWpkFSVWl27gAg+z/6Fveghs6U+XYlKNJ5sga0F1ZDY0t2KqmaUmPh0zV
         nXB99X1S0wb44ldpCU6IpJ0ZQhRYfk5tFnVcP5FqnWWiMBkeszwak2frXqVb3GSG7cnL
         ykKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775106893; x=1775711693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XvLStu+nWIcIMPClCIFCdAtOii/H53hgE/Tykh3nb08=;
        b=FGW+Mf/vykZ694fEuGAU9lsgI7cQbVMSx3ofEffjbQe8S2Glft9i0D3AKQgsW0Wlw3
         55qnyiQK453JdIHImbt9eizHSGhsCBh9py5I0SC52w/VqTmQ3bxQfDA2wEwEj0viMXqa
         mnqehO4Ao3elQ3MYiZyhUdFxMg7QWJp2cxXFQ2PVQiRR0rcuhtwOVips0SJkYO5zhUpu
         qHzIPUAKfHtoqrE8R7Q+njyGuXOEgnNrb55IPvzFltgVolsB4rCWNm9Vhi/I5RCvbLSI
         ZScGdRj8EJuCX5NCcBFhs5w+bmw6tQWiWQTAIThkszuFQjazHv/jnAbjTN2GkvFAPV3Y
         P/Fg==
X-Gm-Message-State: AOJu0YxBG3NWDWG0Z1goqbZyYiN/uwM17TdUfAxKedUMc/nUKFDrZsUR
	2uO+rGHj1yS4tHS2BgXkiehE8WuUb9FvlYUonaVVihKtmhFiEQ11+8blavyO+gm+UpLC/6trm6a
	RCIdU1lTwwPhgRMoq3tdh3wcvuvst53lUbj4nXP/QOyFrglBEcnIksKqvtbN76TY=
X-Gm-Gg: AeBDievSVTxTrQb89liqUvbasn4btx+JnpzRql2qOYymMK3f1FnlsM1frEVzR4XieQo
	svXccStUV3dzGcmHIZA+0kLbHaZAefqwVKkmoaCOaZHnVNknQRbCTadaiu4hctlSD+emRvdqyzc
	/LW30vUvO1Dxhqqcn7J8oMDZI57Oxdz1zmHtcxo3Q1xTjE1pC0ZepfKlhJqEF/BKM54SX33M33m
	KQ7lI0gDG1tsJN1TVFWiOyOwB770h+71H4UrpfmMEvIM9Edt4sg8CeJUKd76x2N01UnkvSiLZrv
	YI+4XucIGuvqSKF8siXUUDNSGq+gMUA4bPxI+6CUl84ybB1Oi8VXcQG70Ey2Fo8chYdztopQnIc
	RA44jLXoWJkCvJBIfp8x7EEoTY189jPXvaQo5mPV3QzuHxyXmxLL2
X-Received: by 2002:a17:902:ebc1:b0:2b0:a957:304 with SMTP id d9443c01a7336-2b269a96018mr57018455ad.6.1775106893222;
        Wed, 01 Apr 2026 22:14:53 -0700 (PDT)
X-Received: by 2002:a17:902:ebc1:b0:2b0:a957:304 with SMTP id d9443c01a7336-2b269a96018mr57018165ad.6.1775106892693;
        Wed, 01 Apr 2026 22:14:52 -0700 (PDT)
Received: from [10.217.223.92] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cada2sm13740325ad.71.2026.04.01.22.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 22:14:52 -0700 (PDT)
Message-ID: <9b23d1c5-7901-4437-bc53-91eb5ad4a8f9@oss.qualcomm.com>
Date: Thu, 2 Apr 2026 10:44:46 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>, ulf.hansson@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org
References: <20260310113557.348502-1-neeraj.soni@oss.qualcomm.com>
 <20260310113557.348502-2-neeraj.soni@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260310113557.348502-2-neeraj.soni@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=L90QguT8 c=1 sm=1 tr=0 ts=69cdfb4e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Y_tMwQXriIPcdNmw6HsA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: yMFBfRx8_QadamdD7JhxCJQuogAeIBN2
X-Proofpoint-GUID: yMFBfRx8_QadamdD7JhxCJQuogAeIBN2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA0MyBTYWx0ZWRfXzYyT3ggOVmkX
 okAmXBb4ck8s7Z6BHX79PYVl6vEJDTxlljAxEWSABiKYpexwnc21NG0YxQrB8IbUuoGgbl5uC4S
 G0lMwC05sYyTJQJdwgxleOhA7xo5nj1oWJrenRPbxyUXKjtzbM+KdChsiUt3fy+lb47AryhJAeI
 kWMvfUniNniN5oov/kKD8HUCZsv86hy3aVGEDX67HAo5f7ykqPC5RwbbwiFOlvOAdOYX1nmuPuz
 Jy/RTySZwxa/Mz7eqEn/Y1M9hwHslEroNiuB4HOUUViXZA0ARJxUaaEd3Wkjs0ZTHnbLkNsIqE8
 uAzT1hR0wR5PGGa8nMkpmQTIT6kLeTOzCzFo0BrA2DvFHgDqTPhRIfzZ/F9EAKq0IV1NWtX4hLv
 0v0dUPbdEmA+tEr9IgICOY3h6gcOPY5oGHeYabRNyBleOljJxGZYr7FYSjge+VzaIR4rqiHrsqC
 Jfd27SOY9Fg83e4WToA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020043

On 3/10/2026 5:05 PM, Neeraj Soni wrote:
> Starting with sc7280(kodiak), the ICE will have its own device-tree node.
> So add the qcom,ice property to reference it.
> 
> To avoid double-modeling, when qcom,ice is present, disallow an embedded
> ICE register region in the SDHCI node. Older SoCs without ICE remain
> valid as no additional requirement is imposed.
> 
> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Co-developed-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>

Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

-- 
Regards
Kuldeep

