Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EB53E834F
	for <linux-mmc@vger.kernel.org>; Wed,  1 Jul 2026 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905900; cv=none; b=XhTxg6hdDLnW2SdGrPsBhH51clO0sZbmImqrG0X3hXRysgKH5+b6zBfhjRlUdlPcunBKciSH7CEkrlUTJSIlbxODeqaZsnWy5/diYUgSuONyDf+HBZDaeI75Km3VNnNw8tcOYpbcDigoxrAyYInRrnv4mVeeY0bdou0IrE2Usbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905900; c=relaxed/simple;
	bh=is6ARwVtdt2qH6o7wrGQSf++Qa8KCC79NEFAFUTZbbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGaHGVnybSkVyg5uYgYZlO634I5nuv5kwRGF4+rw9XmXKpUVpKUHjATRFQKcbYaVecfdpwRhy6aVVF2RRpR6t7VC/qZISnDrpbSwxG6XPus3BD6rLr3u0YF5F6FUXuKpuGknnI1eKGhgeOJ+bMTVZCznbaf/H3UP+QMHN1HbQh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RBssWh6d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Uk/XGZE0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RBssWh6d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uk/XGZE0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8WOR744296
	for <linux-mmc@vger.kernel.org>; Wed, 1 Jul 2026 11:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o2tQu9z54t7ghzjghFzoCQXBSaxkCwXxy1yiopSDUo8=; b=RBssWh6dz0rhDH9q
	NuVQSARMkh9mgAXUpPHQlP5M6Nm0cH9iPfdfJI6U5BX1tVQKRdMTGB/mdRwRsbS8
	6+Ve2ifGjFsRbMO2ZP1QaD7uwQ0x7eE9IaZEmmkjMCydiq/TzLSUkt9tVkC8MCOy
	6PWendMh6zk4XLxEMaEw96RicWBB2fqwSagvcwI/oaAKCf/y8iRNfWInZI6cKkc/
	c0omdeHY2sXF6aBnFiGbWDCU6ljmVlx9lr7Qt0mPvu/OgXdnLMh4M1D6Jx+AMlxt
	U/oLH/DMShTjkIYFEeFTROapeTuo+tZcEc1DAMbWCVY0mIpMtQuRVgV6puf6Ygkd
	gf9hxA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4x0th90a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 11:38:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bf9df2eabso698051cf.0
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 04:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782905898; x=1783510698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o2tQu9z54t7ghzjghFzoCQXBSaxkCwXxy1yiopSDUo8=;
        b=Uk/XGZE0H70pTFyjRHC3iSnmOyzOiIbAL87/V5wtRQ1krg9VLdZwZXPksUfiFFqh7w
         Ak6K3uF7E8Jl/f5REJraBe9ZhM0mCl72JX1V59hVLhN1M4ZNAi5mMhNqMT+i0agZV4oC
         t/tHnTWx4lwpeVkNYqjz1+x7+yild/DnIB0cmLXxebdT46NWBl+Wdc1/PeSvQreskAyG
         wJKVv/XXgRk4ifbgiG6kp6liK8Rr2jIPF7G8ta1CO8fA+q8JN/k6FnmtlZ0PDwCqmKcp
         zmyUD7bdyd4jyo8rplg0ClFqg3H5CA3HPwTvG5zT2Ig59YMCTjnMz8PqTaOipTVFSU1N
         85Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782905898; x=1783510698;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o2tQu9z54t7ghzjghFzoCQXBSaxkCwXxy1yiopSDUo8=;
        b=FlY6c8hiUfUFhgdrMZ4YSmnf9pigkPI5y8GUD13qkWMaOiGN54vxMy3XinDG+0p87l
         5MW87bQC8eSKLiuxTXVheXHJrGPpy8vG9up/mx9UecATraqsJfEoObMoCYYlNwpunVr5
         LSQFovC+3Oy3S70dHGXXwaF9HrYyY/ui9YIUo61wtAI1kqPy4orZCekVGrD0YRNP7idj
         MWsAUTS+2gaTyyWuT8S2J/JIJxix+83Erm2ElduiTWkggVvwKjJe3isaeLEoY1GrVDiT
         7WMAggcD+O/6gv6YhPZmQuxmH2yP3IFUqp8wFo8gx1366kgFpJOpCDRN7xt7mbhQ2Rie
         m2sw==
X-Forwarded-Encrypted: i=1; AFNElJ9OfA0xGl6wUDA8FS5nZ/UjccBLmgA4kW6HoI0e7D8J/LFN65PZJZu5f2ugPNuMnJblrtkGMJxHC1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRWPVYnbRsMQM6m0BWeYlDsKFfmT1tQamXG5YY0ov7X2mpMa2u
	TQpAh/EHBq+GeK1UIi1dnFjD2ZY82Bz8U7htz7YqYrAb7CiCCbxWeLb7iuIElOo8el85jEhSQeE
	qeioVwlfLWLmvL6A+DPS1KaE1wv5OA93hE9t1HNB8YshBV7gxdWO17ac+8fakCcw=
X-Gm-Gg: AfdE7cnUU+KUyQC3mkJmP7GiIRVI9vxo6MUo+4gDYfVrQyP0cof0eF0AFxQ6yMfxe/X
	+eAsEYSmKgO2Nd2oITlWIMCa8CbH+n7M6b6Mm6T4z4QV7QLFyCnF2ZNv7tb7WgKUr76T7BPO0jz
	x+lkYfp+n5BDGyuK+hlv1xLe4ZOx5HL5zkanMWJunQU4JXXF/sZWZ/SBchm/aic/BCzHgBST1a3
	4XtN7kDmx7RNHNnTSL0vQIdmXGUz05TSGIphkzTrw5MfanzpUq2D7RdsgOpEyHAH6EGvviQnt80
	CSHBl9TLgX5iRbH8PV1PCEv8HkHeASLfZag/n9ksd250lJJHHM/BAl4iBByXg1q3KsvtKHor1ud
	gm8W1NEICvgzCEBfJED+1Y/2AY1ZlsZ6CK3U=
X-Received: by 2002:ac8:5f13:0:b0:517:5e32:f3ac with SMTP id d75a77b69052e-51c2693f551mr10261821cf.0.1782905897825;
        Wed, 01 Jul 2026 04:38:17 -0700 (PDT)
X-Received: by 2002:ac8:5f13:0:b0:517:5e32:f3ac with SMTP id d75a77b69052e-51c2693f551mr10261531cf.0.1782905897416;
        Wed, 01 Jul 2026 04:38:17 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c3b6526sm2656719a12.8.2026.07.01.04.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 04:38:15 -0700 (PDT)
Message-ID: <f5b75410-cf75-4bfb-872b-81b6180e386e@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 13:38:12 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] arm64: dts: qcom: Enable SD card for Shikra EVK
To: Monish Chunara <monish.chunara@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        Kernel Team <kernel@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
References: <20260630165700.1886608-1-monish.chunara@oss.qualcomm.com>
 <20260630165700.1886608-3-monish.chunara@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260630165700.1886608-3-monish.chunara@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sFxKS9YqXGfUxuZl15Hv3pQQJIUf7dev
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDEyMyBTYWx0ZWRfX2/WKaEx6CQA3
 2gjc46rnyEYo1xu9F436DZFbqgYJRsmqya/E3KWma8hKCcJEyXGcHQctUoAxhR5Wn8XCoFAvqcm
 lFCC3+ZOJ0aUn8rUsQGus2MJBYA031s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDEyMyBTYWx0ZWRfXxdEvKdphx0EN
 pTDPe+u0ARO/CFrDSAa7yRk9Ifw0akl1kEySScXtLG4N6nRH8zeJbjKpiXmrCYd3bYQWYQLOWJV
 vXcY0lyY7c9VyhTDhu5k3W4Fq7lUwX0D2z05wOmpZXiUC0ykepl0iFANYq4byLB9thE2luCGFhv
 pj8ynZNViLXNxDT4EsIeEKmPBwq+mb49M6dA60/ukfz+BcKvZOEGa5Dl4DExOtCv4/bsFKqolNI
 VxQMa79X/A4CXxUFSg/a+wJDP3zPqk7IshI3Uixjx2xbS8d3VllatTqQCaMWIQ4BWiKzPx2+Oo9
 hqwaL4Soir6cLa9NdY07V8Do0MZUWYT50KYKDa9Is73Ofj/WoyDRKSQ3t1U+H3m5mQWc+Y4/ylc
 3OrZX/PNfw+VAPtDRNLtBD+hYM3lA/46RYBMO7Heb2sfrTC9xCY8YdKpz4IBpBDlIEXQEwM7w2D
 rGIg/KXzI0dUyiEFZ0g==
X-Authority-Analysis: v=2.4 cv=T5+8ifKQ c=1 sm=1 tr=0 ts=6a44fc2a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=pnqc_4j3uO5S_kuVk7YA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: sFxKS9YqXGfUxuZl15Hv3pQQJIUf7dev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010123

On 6/30/26 6:57 PM, Monish Chunara wrote:
> Enable SD card for Shikra CQS, CQM and IQS EVK variants. Configure the
> vmmc/vqmmc regulators and gpio-based card detection for each board
> variant.
> 
> Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 18 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 18 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 18 ++++++++++++++++++

Move the commonalities to evk.dtsi and only override regulator
in the board files, please

Konrad
