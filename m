Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A210723816B
	for <linux-mmc@vger.kernel.org>; Mon, 14 Jul 2025 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495587; cv=none; b=EdcPpfpLs1ufJQfD9SYA/IK+qb5+sxZsv2Dv+SHXqNMNIVwKHGecAZGlHl5VVe6LSrqlzDpCUO/ryFjATMhIZNk2QMTvBy8c2JXg/sSBUnNcQ/iq+FwE1VvRKEPi+9umOfE/5H6PcNNB2uU+MYw+t4j+qy1NYD4v67TED9q0wSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495587; c=relaxed/simple;
	bh=vg1LPvtok41V62jKgVCViQqz2vZuvfhY4dzciIbvWQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILk3yUK0N3ByUrYgkOCFXCkQHhSrAs4i5in349kvr80d/jhF5rQkFzC/kwiFZ/5vj75cqQpdv9zUJFeFPRl0i25Mainl8BmFbUaGiZcU9uYIBQSRfte8qonsMZ+jNgeZyxgxy5T953OLHYmi0WaWxRUz6mSqAo8Vqq6pLnOD2wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E1uRVocu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E1uRVocu"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EBvcCJ003144
	for <linux-mmc@vger.kernel.org>; Mon, 14 Jul 2025 12:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	to+jAqKUwFsv0AkY0GQhPmlDuQ5+LAk2TMq6Z7FQa2s=; b=E1uRVocuyHFzbOsE
	SDOXrepOxttpPH3XsT7PdQ7+jLPEu7tD+Jpmzx1aIJ6UQOKjYW00inJro8y5rIzS
	Hx2PrhXS2FOqeo+g6j0Z9S13BH3dLGvjK8C8Vssh/E2Jyy1biYQvnFdafuUTxYzG
	PJR9dtqhXuuFM+6bip/DFAgMsGiprQBNz9XSHaU99RAw7D++zeXCZo8C3meXl/E3
	sMTN4UDkxV6Y7d6jX+cSasFcGY3u2FFrvS3DzRWpWsllC1jfMb39ccmMQhljPi1h
	vnUjNpph+H/NkD7/pyLbquKzOVqf4RGuBm/OmBcy2flVbY9AC6Gr5e2byhAmwJRe
	XFJLTw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47vvb0s77s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 14 Jul 2025 12:19:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7df5870c8b1so45677185a.0
        for <linux-mmc@vger.kernel.org>; Mon, 14 Jul 2025 05:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752495582; x=1753100382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=to+jAqKUwFsv0AkY0GQhPmlDuQ5+LAk2TMq6Z7FQa2s=;
        b=Gfpjdce0TWNq230kmwJBTup8m/JoKz7LsyIgzqY75tVwVkhTYD95Eu5i/d7b2tiPzk
         3z2sSCve5vrx557O45OEmLJGG94bgZD4VFh6GBL87SLzoDBNLL6dvi7x7sDqdzWFbh3B
         lxxmww1OK2Potm+Di+1HvJANEH25o2lEEdMwE0MqATlKb8QuUkafr8WiiPRY33wgekOn
         JSdfVqvMU/7SS3i9TeXaTidUNqBvexSt/jpCih6dayBAqJbJe5ogHj1zgKWxOEYHsoY0
         7OO10fuNCy8CxlFge83WIDhd4WCMz5ka43yIesEysI7gzFpbdRYG9o8+0KtKWYvUGsec
         IOgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWid9DnM7CKRegoyzza9eFBdADBO/rTGseoiaC4tfQJD7OZDlPRIXv/IldeEwdpdp3CwFejvEGG5Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0rmW2eGCX5Q8Veh/U1K0WySM2aY0qnhtAjK/6J3pKc7wUlcTL
	Jy16dI33yAe9u9u9oxnSMD/AHEGhuTbymb7JiQwKkUYAX4sQ1ydi/ZgeaF86MMYUbf+mkB1+mVr
	Skg+xdcD8Ug6yclvbNHTl6W3U7x2mnYcxUe/FFbD7m6qFh4dWq0pZ4t4lp5m4e2k=
X-Gm-Gg: ASbGncsUQNrNU4WU8RKpIuovc+PIw3i5J2lrPCqGl+dyWhhTGJvPHi2/cELrD3viSsn
	Y+BaEOYfNWl3y56SpUcX92Vx6ffDS02Bi9FA2b6IJ2VCWaFwqt3avWhGyc9jfLpxM8SLBr64bhi
	0dtvn6bkR9U5hS5wpFa8M3iYsy4m4sFbT6EmsPBHenlb/OFNrFnoHvDOXlgnpUxgaYUqa+rvhXg
	bcp6l0Gzg2AyoaZaVM1aaviZtM9MSJDiVkrpPDUsdHKt/Cb9zWyFBU8A7ZkGBvw6qzv1HS3J/xw
	+QBmLOyzdLGvjMvFLWSNwgtObU703BMAP8V1wmmNMTx0O5TtrOqmOuOk/vvmIksraNVRMMb3jN/
	z0xGFzpK01xkhk8B0s228
X-Received: by 2002:a05:620a:4514:b0:7c3:c814:591d with SMTP id af79cd13be357-7dde99543ccmr786278485a.1.1752495582257;
        Mon, 14 Jul 2025 05:19:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/vV+coe8tEVfro7qq/0wCJ9/o2FTg1Dgu/ZwIOZQR1tYnvSopD2hrjhYTvFm/GsULL9+YrQ==
X-Received: by 2002:a05:620a:4514:b0:7c3:c814:591d with SMTP id af79cd13be357-7dde99543ccmr786273785a.1.1752495581726;
        Mon, 14 Jul 2025 05:19:41 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9733e9fsm5990826a12.52.2025.07.14.05.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 05:19:41 -0700 (PDT)
Message-ID: <6f8b86c7-96a5-4c7c-b54e-25b173084d95@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 14:19:36 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] arm64: dts: qcom: Add The Fairphone (Gen. 6)
To: Luca Weiss <luca.weiss@fairphone.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-15-e8f9a789505b@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-15-e8f9a789505b@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4At0oc1dONID3LBu4TbEsZB5QMuQ5wQ0
X-Authority-Analysis: v=2.4 cv=B8e50PtM c=1 sm=1 tr=0 ts=6874f5df cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=ZwcaOx7IXxPg4YioGooA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: 4At0oc1dONID3LBu4TbEsZB5QMuQ5wQ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA3MSBTYWx0ZWRfX+6DLPAHBuNjv
 gZjtdEZX2289fkUmFtenQKxptn0qsW3D8Csti7owKV8lvLEUd4TqrF9mGat1jF4Xijv8osjkAO9
 JlqjDy+WUourw5LnxIdxNQ7Rqvwt2CLN+RaUHF/PwZEJfEeLPFPBVOVlm/KTF0xklOYAJ2MwaIG
 D836ZDyLEBYv24v15L6/ylkD7HGBet3+S2q8T89L5mNdXdCFX5sAKN67Ha4jWo2HrByrcYVyq6z
 3tgaK50rhbmjw8BKn1ZliZIWwvTNsGPwu2zcAZ4mAqWnMppNWS1FObaJJlOk2Z5EGTN6X7c4xdA
 73h36sBDJvVfRTTyr5BhYGD5IFa3pBuqhsQ82oB9rAkHCVF9he76VezQEU8Bw41RoGaLddnw/Kp
 zYTuQwiIt9v7D41OcwCdJcZ7iKQuSAlIQNwj2U4inf7tMM9/tOlFhUzHkvgVxMqL9QhP44rW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140071

On 7/13/25 10:05 AM, Luca Weiss wrote:
> Add a devicetree for The Fairphone (Gen. 6) smartphone, which is based
> on the Milos/SM7635 SoC.
> 
> Supported functionality as of this initial submission:
> * Debug UART
> * Regulators (PM7550, PM8550VS, PMR735B, PM8008)
> * Remoteprocs (ADSP, CDSP, MPSS, WPSS)
> * Power Button, Volume Keys, Switch
> * Display (using simple-framebuffer)
> * PMIC-GLINK (Charger, Fuel gauge, USB-C mode switching)
> * Camera flash/torch LED
> * SD card
> * USB
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

[...]

> +	reserved-memory {
> +		/*
> +		 * ABL is powering down display and controller if this node is
> +		 * not named exactly "splash_region".
> +		 */
> +		splash_region@e3940000 {

Was it not possible to arrange for a fw update after all?

fwiw the rest looks good

Konrad
