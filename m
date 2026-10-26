Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027526;
	b=zUFCZrBsBwGHQhlmEUYWmTZHexiw/ICtt8iKIIbMpdE2lMDsCugVdvLvFELSAZQr8/ae
	 dS9ze+SqUqTAtTpq0u4laECkTLzaf61evVReRTSR3Pfe9Ap9s+QBiDZlgg5vQqqQsfR83
	 72MnnnnL/guMO6jrYcoaaJGdCAZwJBnsQ1OZRa4iuZyIYAWfNuEo6n7ofvNGddgp5l7Th
	 UZaBXOASph4hQYnCXDhf5SP4X8HxxhJ11HmMOc6A3hf+wIaXf4nKrJSf1E6fiOgMP7Ruj
	 MFDL4++tzbJeG7JhPZUvjPdwC/QbEsgWRfKcWLSKGndaiRB6nh0sEHRXwXrqhko112Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027526;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Siz2D5vkVqZu7iFgwk2tA7kIq5v4uUSOUjK1Fa1sAkk=;
	b=dyOc6aj5DyotCoO789p8f2mT+HyZjY2JPbSNgRULxpdBJv5WfcUZn+IY2dyqDmRBPT7/
	 O+mzjSyOyFJlNmZup9DQeiPo+cKFusQW/p9eyBm5GGqzGV3Shb8I7eoGX+Exeiv6FlBIM
	 oMFU3AzXKfcHdZxLyLJUjgXi+86TymQlMix7/cEDprn4WnLnbpHbj8Eb5IWNrYs+xBSSp
	 Nd87jUtikyZfeSBVaiNXAW8csNbmM5kd9hravSJyqTXDfiV+F03BlIjQqFbf9V9mqKbs9
	 aoahd5KLhSvcifOSojz3OxA7vII7t+u9C4HAI5OzAu5nSGHTaAGk3JE+L5JlXW79inw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mefbt2FT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BeQel0Di;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4BA606A31A
	for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 15:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB4BA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mefbt2FT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BeQel0Di
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QEvtPX2544443
	for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 15:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Siz2D5vkVqZu7iFgwk2tA7kIq5v4uUSOUjK1Fa1sAkk=; b=mefbt2FTJ+upAxLN
	veJjYdu1o+tJ9DEyyULCLvgjWnzeQ4HqySarcMoTaumrnuDxegpMu2/HiaO7vVoa
	hlD0/EDATR46YBTmcUzKQiWp/SjWY0wrBfpTF54+iYvLd0HK674EvvT4FTf4CH+/
	llKx/zkg+2rA3+mMU4wjaSuaGoT1bsE80Hdo09NYnZXoA1d9f4RpyblIrE4qfczP
	ntows3NPP5GEidW7B8k4AcQJXkUjuwS+QKI8Jblg797qaefN5K8syAqBo5UB+ARj
	a9ytIOEYtPDLlP5Mz3kMUDvlsi+JFjYNH0L2581wkkQhnrxnbgz/uileMB6/A3v8
	SXwQUQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj8smr527-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 15:12:04 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7bf97f74492so106690137.2
        for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 08:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793027524; x=1793632324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Siz2D5vkVqZu7iFgwk2tA7kIq5v4uUSOUjK1Fa1sAkk=;
        b=BeQel0Di6yLoDXltTsS8fdXhHZHmjNg+0zOlfIBacjXcMdS1RBVmQp8aSh4ATXrjzN
         k3FSnEw33Bt8tr0mwx9BRatHAtVtgMy/vXcDCoKlGB20TRyrfs9Cgk9Op8v2G7CunQnD
         LeM4yN9KQxD/LjqdH9FH4nmj3lJiC+VwnGFIKknJxUuMO9ustAnclJiEG2FSThUuFFxw
         haYdhrfxf5EIx04exMSjs/yGtb2Jp/jPrQ3YdbPfaRT0n+q6177tZ+ftl+3Y7q7vMcSb
         c4Ij5pulfVk/EB0I5UDQolpAhLTSjAuh1CEevARb+uOS+KaGfXfEeT6N3HsDp1qpr9Q7
         FhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793027524; x=1793632324;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Siz2D5vkVqZu7iFgwk2tA7kIq5v4uUSOUjK1Fa1sAkk=;
        b=FiBWaQsz4c/7IZGuoTMuiHLS3ducuhvNHZ/2D4PDMGDDB/QlEzLD+qwcKM6zTXhoQl
         868gnxZM/XcF1ViOaKg495tz2B399QcKc+51IOVOikwAhu3DeGhRunNZWv/rFoGpEB34
         rzF45ri6Nselu8rVdzSd+lpCTjeFnZ0v8f0816Bt/itIlm1ANf70NPvLtrgwK0F917+Q
         yiVNk38zznps/4z0Urm4gBIn9H1Bxl7nfoOVi6A2TBqf7nEShCqEZTpyYf8DwMIAwkTE
         UFcIDv2xmipCmzLxxJjJ4mkKUycl//cSg6wa0ReIxA6Rv8rQqnRSyxb4CNDJzhZwqxtR
         pI9g==
X-Forwarded-Encrypted: i=1; AKwUvBzkMoiOnymYmJLxiK5lkQym3X40xbJRp6hjJTLPC4MSP081qPdetuK4a0MM0QL4LU2BlW8rr3igq3I=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6rlkbs4kEoR2a2JfoaC5+6606lYO8NOZN+0Q3GZpOQRhZ2Onk
	8tAoHSCBmD7gF9wo8mRZJ/T8rXsYKW91WzgcvQ5XwRiDfqlLzJVe84E/iHPbW4YfFE/fXF9h7p8
	bAiFGqx03nfhXilVL51N6vaJMQqMju8fVWYQ9m8RAGmeRF5c3IwIm8yzTFjJ+h98=
X-Gm-Gg: AYBFou1M/o/esFckrIj2/S7lLlCZQRYkklXFJM5FsZpLbU+0MbEk1X3RjWlxuw24crj
	hFWfIohLx/bclroZRplpL12/3jniqpd7SN16JSI7jYOXEP4GwfMQg6/b+qtT2LF5Tp9WweIDeaX
	Q3R4HJn+PN1gkcDcO6AWVTP+6VlYZdE5O4lqiCVRdGMIrs38YNhAbi+zmCp6onlCLEbjZvObusx
	5q6fOVTfgkvDdI1saFm/JhY8avUpdD9YITffblxukwmKngVYu3Kby0wiZlNw4AJk/imgy2FBdQ+
	jdjYgxwEcUj+WHxTryiMcfnwouYcNnt9scn5rylvgYp6HFqZ8RWwNbgHwGKgqNbhBNd3tEY/iS6
	NF27ZPxtZit9H2OsbWS0qow==
X-Received: by 2002:a05:6122:106e:b0:5e6:6546:84c7 with SMTP id 71dfb90a1353d-5ec230f8433mr2339070e0c.2.1793027523913;
        Mon, 26 Oct 2026 08:12:03 -0700 (PDT)
X-Received: by 2002:a05:6122:106e:b0:5e6:6546:84c7 with SMTP id 71dfb90a1353d-5ec230f8433mr2338960e0c.2.1793027522944;
        Mon, 26 Oct 2026 08:12:02 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66c6dbsm327506866b.59.2026.10.26.08.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 08:12:01 -0700 (PDT)
Message-ID: <436398ee-4bae-42ae-9137-1a4d7d0582da@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:11:59 +0100
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 6/6] arm64: dts: qcom: lemans: Add OPP-table for ICE
 UFS device node
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
 <20260824-enable-ice-clock-scaling-v12-6-09271f583dc6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260824-enable-ice-clock-scaling-v12-6-09271f583dc6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pztITCKVh8zqRNmM4gGP4HSGYKPUdbt7
X-Authority-Analysis: v=2.4 cv=Sfti5fRu c=1 sm=1 tr=0 ts=6adf6dc4 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=xhZcOr--89cURCpmMK0A:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: pztITCKVh8zqRNmM4gGP4HSGYKPUdbt7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2MCBTYWx0ZWRfXwahGPDfXdOTW
 gKpYXTIitxXFv2bA4p4leGWXdktjhIiv7eMzqFwwEVPyfVKRiJLnz/2vTpZiKcaaZ9Tx5y2/sy+
 e42d+GRS+dJ5LQb9/CWx71ytvm7K+80=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2MCBTYWx0ZWRfXwdWB8pJD3r3c
 jkJgjMBbnzIhhqSBcCg6y4uEgqIjJhuLEidPRCDgJgaHcmWCOiOZk2dLWYW7yHlIb2tEOWUs7Ki
 X7Wy8e6PSrkMI90ceDza/T0zu6ws7B8i0Ixu3yUuaGjDfO8Uks51Hg3hjKjgo3icuUT4kFGZTo2
 60LzkqR9/ffEg52//lqs5il14BmnRmzDNFqC6CMTVpd2FKL6uEq0ULMrJaUKRa50WBuDsvkFOU4
 UMuHlcU3XEjIks50vwO4YYNu3TpVrYB3u8NOOx9LxStmNScDgMdOJoIVTQDJwyEsIMB9WBoj6w6
 uLK0aLV9BFUD7bQ7EU03Zf2ODogz+/XbZppuK0Hn2PIotvOfV1c7Gf4a82AlG73tOI/M+aPMI22
 ULU+v38FxMhRT6cyCkayxRhNiWN16Y2QnVcgVj/AK2/+0695d0ds8jYxXExL2G3Sd/tJsv721Dy
 ywDaEjuBMuYyZP1hN9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260060

On 8/23/26 9:47 PM, Abhinaba Rakshit wrote:
> Qualcomm Inline Crypto Engine (ICE) platform driver now supports
> an optional OPP-table.
> 
> Add OPP-table for ICE UFS device nodes for LeMans platform.
> 
> Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
