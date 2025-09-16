Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B9D2BE057
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020587; cv=none; b=uj8r14we9yZ01wZl+qEVM5QW3yf4LBeI4XbwBuHpFBko91JMkAlYoqhpSk7lF6S194jfv0s37P0BpdkP1PUg+OVnFa602aHVm++ZMcbIaALVqp/B0X3juAcqhGq1Nn0S0Ij0lQ/Lsu3y/vsX8+Ynnh6mzgY1TZeIWpy8ujcocB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020587; c=relaxed/simple;
	bh=jCWoiLmYKgtosl3zfnsSg6IJaEKb9HxfTKRf3FW2tfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM6iyZNiS+LceYsHnTduzWBz0/2uZO0tNkk4IZV86GGgcfesRxvyY9PmCJcT9xe15wWRUR5YvSLxoVxJ943z66nKbn/pjJdEpHZXMFwjFlVrIfCk3Djsp72wjHeQlBs6PKiqQe7nlkaqsImg6KLpfZVr3gs0WYSTBXGsAs1zkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CpKidFal; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CpKidFal"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA7MhB010827
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 11:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aGWDhUBbPiv5SXm2JrRwK9rd
	9d5oa/pXGFvpbeXT4NQ=; b=CpKidFal8r8YMEiczKohQ78k+JXRhS+yUuEIbXS1
	g6MGu9diITl0kVe1nGEnCZSzRwAuokwfR5z4b0zj31Q0ofgXf948B4wKaX9ai/FX
	pkK8DL1A0hCfXSdRGahYBnsgBAF09ooRnAYUuV6ewg6imY9qn2aIVtn05jeanzMi
	wRJ8zmGPXMbJ9CdK4hr76v0Mo4Zxx1j2TSsZmL+MIFPI0wL/btDt0lGGIl0rlVf3
	khiY+vyNb9Pd4VLsqUBherw2zb9usklcJYxRONlTBs7zSROcQ2CI6EO4J03+fq28
	L39NP8ukiqo1PCmCImYkLxj0Ii6ZlfjixaZt7+lJRlBa+A==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951snrdp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 11:03:04 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-54a2beaa1cdso2960547e0c.3
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 04:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020583; x=1758625383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGWDhUBbPiv5SXm2JrRwK9rd9d5oa/pXGFvpbeXT4NQ=;
        b=iJ5fb4nrRa6ZqIoIHxB8GGXG/3N0EEqDP46Suo8vcDvDyZLvlNCE6ZsL3fVtw7jzCw
         Ni/M4/7K2PmNTTN3v1Z12DzkAkyboTmkTx1tyrZzReXIwFMjkUwqbTZu3jA9j2KR/2FY
         1muNT9VayRpevkzsJgdrfIlhbgt6sYhb/aFl+ZLGlFqTW8u6W5LeUSGL11WJhHzl+5fi
         5Nvfw2LPO+JfDh86nMQ/15l/Q2yOIWFwISJENyHEVdUgnKx6i122A88rj7wfQ0xgELW9
         n2yQiTgdkuEiZEVIbQhys+L2izLqLXUVycp4qpMxu1eLVyZ4LKZx4GekdbXWL1TdtVtH
         AoMw==
X-Forwarded-Encrypted: i=1; AJvYcCVgBU/fMkv5Vs14oNxQ/EM/iosho+RXAF+QcvHa/i81dLbNlbhg3DYSlGz/WUbEJPWH7mAAf8Z7fmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRLhM/+1tqXqRbYoN0QmatqfwPkXMhROwbdjOBBNzeYc2HDQkm
	75xGiEykfCy7dFpTjoRS2BY6letI5Xq897jokxQobdKOvJ0g3Wx1GW+KKc5w1KIADb8mIDG28JG
	UbhdVxcypUkYbtpnFM48EspUVpFCNt0ASatuTgiO8cF096YxB8AODtN5Bx/VLsrc=
X-Gm-Gg: ASbGncu/BqQVEO3BdU+P8FPp8JqcUZ3pEIL8SGk0oS/JuwtuZ86ha22yOuWWXCzJUjS
	nNJiPvJhvJM7S6ejLlDE/Md763JwtA1oLoTr9irc98VFRwqAcU6lv2a/vLuI0TYKsE2wMaONemd
	Jw3HXPTtaHamDbadogJtUxTMxagmfypbYHSYVAyBseeCPnHKLY6Z3rvW6HoHh9K4alyq9ETXqKe
	RU6EZqj5uzIaHyuF7UIll/0jOHCVVlN1FPUKbHK22uQmkrx8KkNFW0ZiIacp/TI/rQLvAr4MgbC
	6f161LD9zIb/PV9vO1YwExfJdmmUGrl2ITFjRay/I0xHcvSV/4Aoa65sOL71gMICVZc24/H32YU
	owbylaQEURWpdzevMZS+Kg7fJFzWty5+CZ187juEECZN4qClBqHIW
X-Received: by 2002:a05:6122:896:b0:53c:6d68:1d31 with SMTP id 71dfb90a1353d-54a16d07e94mr6109253e0c.15.1758020583415;
        Tue, 16 Sep 2025 04:03:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8pmwdL5aKOwSmINEgbn2GiMkviQ7ZG666F4+/PsdQLZAgj5aiT/QrcYUMkStouRwCE6p+sQ==
X-Received: by 2002:a05:6122:896:b0:53c:6d68:1d31 with SMTP id 71dfb90a1353d-54a16d07e94mr6109209e0c.15.1758020582881;
        Tue, 16 Sep 2025 04:03:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b6167sm4429373e87.25.2025.09.16.04.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:03:01 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:03:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 09/10] arm64: dts: qcom: lemans-evk: Enable SDHCI for
 SD Card
Message-ID: <zw3efwluvdru4dyf5ijwmsewemlth3dj5oo6gcpkve254myrpw@bfuziw3jfber>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-9-53d7d206669d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-lemans-evk-bu-v5-9-53d7d206669d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=JO87s9Kb c=1 sm=1 tr=0 ts=68c943e8 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=3hZAb_iNorm4NPqi49MA:9
 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10 a=tNoRWFLymzeba-QzToBc:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: cPj8SSL8KAC2t_benHUOAIur2lHI08s7
X-Proofpoint-GUID: cPj8SSL8KAC2t_benHUOAIur2lHI08s7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MCBTYWx0ZWRfX6OvYIOvWwkV8
 qux+owd9MJZebpl/N09OVR8QwT72dd9FK+/ljd+B/K699F4FacYmISD2QkAaJcapSoLgva+A586
 wacUbuVIOpSCkiN5zKiawRVoOk1LYw0VwSBZlGj/OUj4ceaHAyix4J6Nvx10UFQTfv9NLKjrlV/
 y02WIh/adxAO7zXouFNvKhgnxBCswTYOi040sPMnzJtiET6Bm9GulnEzkHTMnr3WEdA3bJpdnX1
 3NiJSrg6/Ov0uRJ9x5E5ZIskX64z/CtDGRcWfAXi2SjZHVSLvMa10lmOc5H94yMEbMdIEeuWdQc
 fd/E1Nf/mmhyHyh5ASMMAzcX4COdTtNkg525nrfDtj3cV1nGF+RjpfOKM4WLILs0yLznu71amB7
 lWU2CpTJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130040

On Tue, Sep 16, 2025 at 04:16:57PM +0530, Wasim Nazir wrote:
> From: Monish Chunara <quic_mchunara@quicinc.com>
> 
> Enable the SD Host Controller Interface (SDHCI) on the lemans EVK board
> to support SD card for storage. Also add the corresponding regulators.
> 
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 45 +++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
