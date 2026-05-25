Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24E031ED7D
	for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779714861; cv=none; b=ENUPh8MBSE5RDKCLV2NZJzhTbVqoBAxHyd0JCDh4aoj2pbvWAeePUorRdvr3d17Iq4OHg4LnZsCBQmjFrVXuLVRSX2cDyyjJkFrHGpwfP9pDNKRsC7Tw7EoebVtQOuOh0Knhf2HdSe6zHCG5U143qtkbo849c39dNOwUhauV0W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779714861; c=relaxed/simple;
	bh=qE5EJYc1DlvLU7oXvi03MMUgVrP6joq6NrvGONO6KK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYGjZP7XuMOcZRYg5LNCvPs7El0aZcVbcHdtmocXlnssFylN/q2BDK68kh+zEk5g2CbJKMfBImKJTrCeC9Whp3hc3iaePzcOu69D5/7AOseWe0qilc9obdq5JWgbe02hYEFj7WZaju+iy/7A9MvbPwNQ+wiiZfvuig442en2dH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kg8ItYbl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PdeWFohV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kg8ItYbl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PdeWFohV"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P9EYjf079445
	for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 13:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6b3DrpErweAr8LUzJdL3m0TUMj29KLE3BG5Cv+ijrck=; b=Kg8ItYblBODUolE/
	exqk3c9YhXQaEglM3cSAlIMksEKTE+zu/vPxxn3Ma9YcqRSLnQsTHFAFvj5ijt0r
	zHvzzpDuxlXNBKQfy0PmH3O0oRZ5dr2qGZaVX22AmfZ0SVGTd4mpvVOAgheF66+Y
	86V6KX49y6GkJ+TBp2EOo/4OdXAJzMURGKhgPAdjkBlOfhT2QTUrmDE+Ef1oQT5I
	67QvZRFWRVnyzo6FDEBB66v4fiverOsksZFYvgkLAKfJPyQ5FDzEKyG1QWNyq9jd
	ylieoyp68CzThnul4lub+/hRBYbPM+C6WCXyUNs6t3joKGN8NM1HjqyRjGvfyQNg
	OaOUeA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eckma8rqk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 13:14:19 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-57747d72979so827675e0c.3
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 06:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779714858; x=1780319658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6b3DrpErweAr8LUzJdL3m0TUMj29KLE3BG5Cv+ijrck=;
        b=PdeWFohV8gQrTB0C4N4cn1JXGhcAL26wMfOGBJ9Be2xDKROBMDkfQ+EgtSJvrXh86m
         NNHftEDX8o4j1rPu0tKW6R4/u5pzVDx3WmTONAhb3IhZBXaWA0kEvjHVJiacn9H77uVT
         mXMFurem4poqi2afyplSWdhp2Ov/boYfit5699y3od3uUykxMIg1dZdUoimjpy5Wa83Y
         wMEzMLVGDptSGMdY2z5t+z1X5XAB2GqrwqIcpsxYT6giBomhjkBrTFscUPfQZ9nqBeoH
         Pnei+uX6C1ZO30jhz1myU273gFWguQEEKlZBA25fKdsUyuxiHxji2AtyFwUqMIsxR/jS
         qwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779714858; x=1780319658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6b3DrpErweAr8LUzJdL3m0TUMj29KLE3BG5Cv+ijrck=;
        b=ReX/hDDD/+8BLsM00gK1oc3SF4pH0vFL3vt4TLxaeD8LLoIH+0c04OSoOYDXSX8ZIn
         7rB7sod/CRW2eBYeLHcLLETyUuSezo9l58qXz0gHglRfT+COLTd7deUoC/zGed2mHxcB
         3fZDo3+8SpU1qWM3XRBXz7VoGkzXumoXve6M+2H1JRgJHvw+JLJW0pXCffIMLCs7oPln
         6AF9R6UC5mdCZIUGVTEjhOG2huoLRQ7pvYVoCGjAFlA6Ebu7fP0YbUElPN4sQaxW9CBR
         HC0IerDUsTmGrtsMlpyuQKpQY3YGQmz6XnWOiYx0jDBjnaX623hnRdgS2ljB8Vu8Va8Z
         IkSA==
X-Forwarded-Encrypted: i=1; AFNElJ/BCeHc5UTe3sxV/ECm6zRYRT7VtsAjrlg06yoGcI5CkDuegaEPrnvd3JdDbzlb52+EjDqxmfbv2a0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztMAFXxZev+tYiNRXR6uOZ3a2uhmhcxVc1j+WSrROLgXPV/bzt
	CVODVi+u7ujPDksQN6FX7wgAfcMPSyu4GT7xIW78qwUD5ciYRaK911spA89d65F5QB/J3bB+Tcj
	W3uPUreUG15yBCiajOElvPSuLeueUOuYKXk7od2sIEWXiN/tF6FShkkOA+QS4kUo=
X-Gm-Gg: Acq92OFopCTggLq4iekwBmyzMZB2xRYem8stukG7bFKm33etwmK/MK7GBpnEJ4roup+
	IJcBM/A7tUs1PJHyBiBNFnbaZs0mVLSr4tOx0I3p8Q3M6PilmR+tVpcx58cA306yE+PbfVaxD+P
	rxz5kYnQxBLFnz8ELaL2V+CH1CZE/VZkfRF3DAB6LzkN/joCp+nJmP3dW32hK13Oyful9cb9rM2
	xfMj8PiQkLH9IX3NQ1twY1Di9nwCENie2EBgHjl8VVC0ayk4/+bcGlmmUshbfj6aKRowUGjkDyV
	KpfYLLLjHoHGEHm2H4sDwacuB+ElsuiQq8aYCE6r/A80I6SvpTIneSRmwQTqhTfDSpfd1fSI0iH
	nqPm1/oH9AjrlLOFsu0cJYOyI/XtfuR9YhWTIjVGk/lPqvA==
X-Received: by 2002:a05:6122:2ac3:b0:575:35f9:66b7 with SMTP id 71dfb90a1353d-58663e43d1dmr2314188e0c.3.1779714858162;
        Mon, 25 May 2026 06:14:18 -0700 (PDT)
X-Received: by 2002:a05:6122:2ac3:b0:575:35f9:66b7 with SMTP id 71dfb90a1353d-58663e43d1dmr2314168e0c.3.1779714857596;
        Mon, 25 May 2026 06:14:17 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688bd00e751sm3915244a12.27.2026.05.25.06.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 06:14:15 -0700 (PDT)
Message-ID: <ad5e2d91-6166-4fb6-a9da-1464b161da24@oss.qualcomm.com>
Date: Mon, 25 May 2026 15:14:11 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] arm64: dts: qcom: Add initial device tree support
 for Shikra
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260522-shikra-dt-v3-0-80ffde8a3dc4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a144b2b cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=0ejU1cMun9qC18S2p54A:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: RmXY1aIXN9wRWcOsJIBBekcEgvyfcTci
X-Proofpoint-GUID: RmXY1aIXN9wRWcOsJIBBekcEgvyfcTci
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEzNiBTYWx0ZWRfXyJHWZx2oGGux
 vdMQvqRtDWW7QckyDF4VSRSr58j54+PIEVMgAplee8hnCZzXEiNEsX8SiNI2zGGwkO13BJu/0FO
 /QvNULlGoS6CI36ag191CSEAiVbWq2QGOFSAEmdFKloMdE63iTjRpR0hFvYn3D2rpNGYO199oro
 fCtQ8+ReG/iUqcdG8IhBIrHqzZNSAejhsQ//TG5M8vfAoaEfiZ04whWB531+7k6bpolrwCIZTFg
 7ZGgWjvIiLWAoLD/C8Yed/0UAUwfowhpd1rZ96Fcn2CXEElwBLJernVVcxYIlBR63Ya8p3RIB0Z
 dIw/+PPsZeCrKp4mcpIvl3uk8lNklgStM1n7cImCojcYCJgmNVKT9hdXY7JMB5mb42Cfi8sbi4P
 q4z21hAdH+goDQLdMQHR2SdOICClmc6VbNhx05XfYywNabS9q7+iGQyBNFfuEUbZyJbKpk/jMoF
 0JJ+0Xfzn2ZU78aurTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250136

On 5/22/26 8:02 PM, Komal Bajaj wrote:
> Add initial device tree support for the Qualcomm Shikra SoC.
> Shikra ships in a SoM form factor; this series covers the CQ2390M,
> CQ2390S and IQ2390S SoM variants and their EVK boards.
> The series adds:
> - dt-bindings for the Shikra SoC, CQ2390M/CQ2390S/IQ2390S EVK boards
> - SoC base DTSI
> - CQ2390M SoM DTSI with PM4125 and PM8005 PMIC regulator definitions
> - IQ2390S SoM DTSI with PM8150 PMIC regulator definitions
> - EVK DTS files enabling UART and eMMC on the carrier board
> 
> Note: USB support is intentionally dropped from this series. It will be
> sent separately once the USB driver changes for Shikra are concluded.
> 
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> 
> ---
> Changes in v3:
> - Drop USB nodes from this series; will be sent separately pending
>   conclusion of USB driver changes for Shikra
> - Fix CPU3 reg address (0x300 -> 0x10000)

This part seems to not have gone through (have you verified it at runtime,
e.g. via reading the MPIDR_EL1 register?

> and memory base (0xa0000000 -> 0x80000000) (sashiko-bot)> - Fix power-domain macro: QCM2290_VDDCX -> RPMPD_VDDCX for sdhc (sashiko-bot)
> - Fix MPM interrupt number for ss_phy_irq (8 -> 9) (sashiko-bot)

Hm? I don't see a 8 or a 9 in either this or previous revisions

Konrad
