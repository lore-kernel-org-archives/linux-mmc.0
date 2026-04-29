Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172D638C42A
	for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455051; cv=none; b=mZqA/NcJI5Jxuss3Jj1EZL0pLPFaNxg4S83wcJDaWMtcuB+iH+ON/pOl3/tkgVfD5sfQ5FV1E/yAZzQ7ihGvycp/qgaFSWCeabL5jsPY05Lkj7/TKzf5XOZIV5MIHmca1EHbr2fxgR0QEvy8m/0cblZp/3dNtLIYdTRtnY/1up4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455051; c=relaxed/simple;
	bh=wC9jrPQBmpCZbW2mnXn6p/4PAelbyjfeh2Yka1RlPpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBzGLZhSnJ6e9LYY6Y89xXPMNc3pccWv8LhHL8klIS9bQht5xiMw7YN8vjYXzIQzhVrJmoVJFQ9ka2hPhb6ZKcYIovQnJ5if7aJBE72Fwm33oevn6usbKK1CflYYLMXsKdi8/PvABsa/aIYwKbjXhzDd66anryY/1IAbs4ph6ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W9VWA6S3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V4Wf0eoQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W9VWA6S3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V4Wf0eoQ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8qFLK1642726
	for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 09:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gTbNCeRSUqu4zDmkAqRY6ARTuww7wMu5rx1tnXDAf20=; b=W9VWA6S3iqRyvA7f
	IQsLcQMaUAo6MrX9KGt2ltCHppKvhII5yVDzVpDzHK2kuP0AaZslI8qh0v3tmdex
	IHtPapbJQePeiqdCjlTAhAHyEtwfT+4h6Zf8mY9rL59hDCZTT0mB7QUXD6jK/LEX
	YPlvGlHt/g2oCFgtmk6x9RRZqHkzt+idAJZfRqmiEEqUOF9drtciI0/PpY5w+sH2
	wGojjqWxaAsCUJXiE3JP1jCqQkACKt3T6EDFIM1KBOrrB9G53FbimPaNVhoSbKrh
	h3vOEeWBL3aHeQUyDP5coXfAtAd1BplIgxkVknbEbhHroHuyOjpgWPgJcKcqpcyx
	cjXoQg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj80uak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 09:30:49 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-56f7d6e7a31so661622e0c.3
        for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 02:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777455048; x=1778059848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTbNCeRSUqu4zDmkAqRY6ARTuww7wMu5rx1tnXDAf20=;
        b=V4Wf0eoQAMEva3tDdlrX9/Zl9AZ1bYSngQg/oYmbri4DFawPnSwKNq3piwSd9kYUpE
         wJMOp9YezrpOeC69LdgSX/znAt2WaolwaiJKh1MceLb025yYmwEvSmSta/Jcq35nK+WP
         wBjGkelpYxRvdJkqEWpA+vLyGKMxCRc06xoyTg6Erw8FT1e+87RjsjHtDXshS6VNG2Kt
         Vfw6sTmLtrIWtP/Jrl+IbgfcTIJU+GcNoDXYWEx8Bj3C7x33mRyb6OzLQHgUhwZUN3ui
         dNa9CIjrWBJ9N0vDukQG8M/ieGF6fxPlbBSG3TD1Wc1A6l9DWi40S3VcUuWjfYoECdMb
         W28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777455048; x=1778059848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTbNCeRSUqu4zDmkAqRY6ARTuww7wMu5rx1tnXDAf20=;
        b=gDu0dUlz8vYF7qNGLTUebUAX0PF8cfRsNSP9emwetzlU/MdkW2/slYow0bS2uN6AV2
         92WAaj7sT6XhZDiwT2KBSrH1UrPuWfCa8MsVSAPB1NHRrvkCYXjwRTZeHGSodcOKHu9o
         Cxmsrg4k3slbvOuFfU/sk7kBW5g5FRy6o6SO+G9CbNl/rUFK2G/hvCWml7bjMHzRINqY
         JNIOSVdq7Ro1PkPRAsn8lRl+AEMkWDZQOqA2/nylLnJNLEQhUlA3IXAiEr2GO3oN2sg/
         9E28gvfAVaeAKPnos0r56t2jybqQacdwM+QSiVP9wby5Enu0bn1JxGljUBEYA6cdZhyt
         PFLg==
X-Gm-Message-State: AOJu0Yw7J08hkW9KfqdzOC5xHG+LbaMhFf1/aESnCDYa41YQPRpJ3BmR
	JRgHm3pDhL/Jpqn5/VE9ooR1bvZ03oTIWSHmPK+e8LK4EYqpdFKTxcx409jJkt27j2i6i/qCW/q
	/xdk760nE4N9Gt8qeogjybaBlahqg0mVvTAruS3YrGGJGSnQD5oQXJGl9e2kpjy0=
X-Gm-Gg: AeBDies/RxL/r6Omwh9xc4mA8RIkiAN1Asg0C0ffYeK04OBH7GHf9JV+6gFuEPJcyBQ
	f5geRVvfNZ+5db+IHsyAxCpPXGOtwjgpqrg6ClJ6c1NgajEGEk8mFnI3HUOrVJ515Ckted7nWDF
	cinDMOp5auju1sa9MZ2d3G5MWqPJvFdZu/ZkTUO2fMNNbRJExmSEjX5yfmchcU80kp7MyK0/a3w
	5828a2paoT6Wm5uqa6wpNziWa2EI/50JohSbIqrZVv3xobj+FwTBraFGBrZuByO5Vwa3RKu81Sh
	Z/3u0HKBDTx7b9qHySkklEpEQ2MM1vPIJ00O2KE0GlmVor9mQIjDCaJmeF4UzoWY//MZOlJjem4
	vbRYrHPh7WewfLDxIs2zdFdHy2+B8OWcagE3Hitm+0vTDy4FrM7b0ro6M2ytiaNZFO0Vl0htxM9
	RTKo3dhIAVg+qUQA==
X-Received: by 2002:ac5:c894:0:b0:56f:6edd:77ae with SMTP id 71dfb90a1353d-573a293d531mr1234267e0c.0.1777455048472;
        Wed, 29 Apr 2026 02:30:48 -0700 (PDT)
X-Received: by 2002:ac5:c894:0:b0:56f:6edd:77ae with SMTP id 71dfb90a1353d-573a293d531mr1234254e0c.0.1777455048034;
        Wed, 29 Apr 2026 02:30:48 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb985e1b108sm65753866b.50.2026.04.29.02.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:30:47 -0700 (PDT)
Message-ID: <aadfa862-a99e-4214-b19f-6854672dc8d4@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 11:30:43 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] arm64: dts: qcom: arduino-imola: Get WiFi MAC from
 NVMEM
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-5-6ad23e75190a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-5-6ad23e75190a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: e5c8JHAfNYIKR5LPC5od0y020N_8eMZX
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f1cfc9 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=vtxEUVkT7waMBiOsAPUA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: e5c8JHAfNYIKR5LPC5od0y020N_8eMZX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA5MyBTYWx0ZWRfXypCKYvaYcIau
 YJhvmpzJH4Q7fvb3zHCBRYyrk3s+o8AmdEwbVW2Z4Ln+utllpTjbatlo0cpYIV9jSbjGEB/Va0Z
 S8q8DDXXEzwEaA9eZZtwGi/SR1xdk/WlwbeXTtZd23RhKY3cbRRl9F4voE3zjiU8JlU0VY1cnPz
 T5YD5ybGNm/7WXyx8mc+jRpV3xJ/spHf+WYH8yP5tUzuo9ihbhyvB2j+6SvVNzko/pqmAvf7O6E
 r2TompZlSTVbF0nKyShoejOovmyzQ920pzxPAVMFiaCgxFBMC9s06064quBt6aO0o2NJprbyJvw
 FaTqQilqRf3mYDnWxMlN0/eGRePZYUwVqOseD/d/j01HzyCcaYf0JdD6ozeo6qH8GTr7QWO+uXU
 24irD0+vgGrq/kkpV8fMP0E4Pmnorsjz75hMRIRRvq4jV9Gk665pGqWqHHECDCTPaeKoCg6O+yw
 C0GCikCFhrlXpS5U7lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290093

On 4/28/26 4:23 PM, Loic Poulain wrote:
> On Arduino Uno-Q, the WiFi MAC address is stored in the eMMC
> boot1 partition. Point to the appropriate NVMEM cell to
> retrieve it.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
