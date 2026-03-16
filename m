Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C05138C2A5
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658717; cv=none; b=gf0XgTUwtB3yA2T8SyR9mKuT1CKVY3aTZZKidVl+1vBqrU0gnkWQvQUigMnl1ZcPySv9yMs6GJKKy75hmH72QadebCp6DfnEKB4WTPdY5YITRMoGU7P58eycTZzz4ecJ1CS9xeUEBnwoFvvMdcFkwwKePFY4hVyrl97bbv8iWrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658717; c=relaxed/simple;
	bh=3lmRRGmBoVA8sV3x08L17KDSoA6WDoBOETeBfd3kmNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAh6cAhFul9OttnFwPFgxdPM0sJg/M6Umu1/i4HZIQNzD7TJTdkIgWA6MBXPcHTFK6O2j2rRqSqbYofdyJ3UZkT6aRrarEWbQ89vda80DjpKVC5DHCY6UXkJ+ovyg6Op4wbOCl+eOb1YPTdCo7Uj75LmHiHfiOlKW5It+sZVy9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n1EuqDqU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bov2nNIO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n1EuqDqU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bov2nNIO"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64g4A663079
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 10:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3lmRRGmBoVA8sV3x08L17KDSoA6WDoBOETeBfd3kmNY=; b=n1EuqDqUsnNLyT2n
	mp4eU06qOVxKTbUSTLZXtEOoT30hLYdu4+IXTG9duifStyq/O865gmauvlaf2ElC
	XGsxmrGftnKF9AhQFsVsi7I6OdMwUdim6+ujro2ekgfuDgi78E6XvhXqlI3pPR7e
	db/aejPz7ifI4F8ZgRhTxJdl0lotkchtb2zmSdIeV0+BmG8UaxgDBjQmSR8TQkWY
	TomVAfXiIUuZaS3clpT3KXOMfW6tysh6SjxZl4GFvSJ9+HD8IzDJuZHTM3jYKrfk
	S3I+ZtfriFIweDflDiDKjedSx63FXK7lJwkrWsTOlLvqXk6ewElTE9pcGL2fQcJ4
	qJousg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw043naca-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 10:58:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82a1436347eso1462822b3a.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 03:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773658715; x=1774263515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3lmRRGmBoVA8sV3x08L17KDSoA6WDoBOETeBfd3kmNY=;
        b=Bov2nNIOU1CsrcIFGLk7zYUBdO7XIWQ/iz93IzkQ+f2L1k3YgyYNCs5ZwqDNnsP7Ne
         jUYLkxuWZe+B7AwpB/ktQW5jW+soE/S/JjEKn5hs35POMp82VaCeUczcvoEXXf3eyz+Z
         RcFCDjSxcqvYwl/wzlxAHTwPj3CjdEo47ZhzLWxITbptZiJZhzT2Poelhr4NYROYlgQT
         fkrBa/3u9hxAsFpbQJMxaDY5JYHwdZeddqte+PLw7Y3tuVkw3V8qH8ZkXN2Pjuyc0SLh
         L7w2b25lVtH40S6Kl4DSpQ7RYT5/RQOCVWoU8G7J7UcCgbqT/oZwossbi+9jJKxpqwxH
         t58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658715; x=1774263515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lmRRGmBoVA8sV3x08L17KDSoA6WDoBOETeBfd3kmNY=;
        b=bh13rZ689LHDRSc3TvwmpTPpW2QjTtTn/groq9uPcvG5gcO23kMLQrHTl32FW42daB
         LDeEennCDElz4vFScVS/WAQOidwD7/jM48msz0qFy7P3LsVrEn0ImTCELLopub40rP8w
         P5DlNIdt93p0QAwRXb1RVLMlyKscTqmnPtvMP8Q1MTJnx+YGqoS6EjKbj0iLK3e6kRdO
         Wrvl2ZivbbxQh6k3Qf0IB3wruNGwWCQCcn9YUiXEIsEQa04gDhIP4WKWDNwxDvu1IDi+
         GM0kCDFxp/XMD+EbIkskVD6BvaO+9jXaUMUkvruReCISMl17hbzJ6M6BC+r7cvdf0w2E
         3uHA==
X-Forwarded-Encrypted: i=1; AJvYcCWpGolCFqgEryrPeI9OBXse6vfot/sFi4wfgsX6Gi1dyiNBR9B+c2qZZQMi5/tjejI/YC0NJv1b3Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhni0G4qV6RWCriYley3ZHtXRg88NfgAqbTfBYNaocurrXGlN
	nPc2bDSDLUj7VxmyPxVyEUl5bZvXOGG+yPCnVGaeAKBGnZJTYb33FoUOH2arF2FZ2Iqu11vezhK
	wdvG7Kvu5F5HUzpfcB1QgRHKRveXnt1HjIs1DoWYXreUij3Nl/Z6zjE+fga1FYoI=
X-Gm-Gg: ATEYQzxtYvC6U21xvgZnISrObX0eQwkBXwGek1cf75RLaNagm8qfVVLVf0AIA9p3oX+
	rRiODgypaH8wm82lTwX3Q1aL9kat4B1YgGQB683sIxwR+CDIGIwj37wmUAdYOJDdL/W+0MEBPo2
	ZtLS/WAKoqFnPc6+gl5mmD2nQI0zjMFoEuIWcxY/LWP3EwAGv0XvFO928W1cKBSmNeirPf0M141
	tXz+BUH3VP6yJ/UQKrBZMqcBMK4uUYSKZnyCXyCpQOUx4nGMA8oUtGjyKd4AdDa5T2wLy4adg1l
	eqv2l8rFaUPPJMFmADX3gdMhbAc8gWzv+44k1uX34b/JHoAzit1EBWjB8YiqE4oMr8YvIXi94EW
	ORwlyowks9hMYdMLh+Vx4075XGgOwJdAg3X/iQXPdz4i/TCISClFc11a0BqpdYrx+FA==
X-Received: by 2002:a05:6a00:908e:b0:824:3bd9:aac6 with SMTP id d2e1a72fcca58-82a1970830emr11249605b3a.16.1773658714580;
        Mon, 16 Mar 2026 03:58:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:908e:b0:824:3bd9:aac6 with SMTP id d2e1a72fcca58-82a1970830emr11249570b3a.16.1773658714102;
        Mon, 16 Mar 2026 03:58:34 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07366974sm13390277b3a.48.2026.03.16.03.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 03:58:33 -0700 (PDT)
Message-ID: <384f366f-b2b6-4bdc-a2a8-ba86714aa094@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 16:28:26 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] pinctrl: qcom: Introduce IPQ5210 TLMM driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
 <20260311-ipq5210_boot_to_shell-v1-4-fe857d68d698@oss.qualcomm.com>
 <05a1dcfc-7df1-4b20-a504-468814a87b3d@oss.qualcomm.com>
 <1eef0fc0-d33a-452a-9da5-3d0903b1712f@oss.qualcomm.com>
 <c89449b8-f28c-4364-a1be-5267f0d99c01@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <c89449b8-f28c-4364-a1be-5267f0d99c01@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA4MiBTYWx0ZWRfX6l3TxSI/II85
 oGtI8dO+xUDe+kwMdMKv8btlje+PHR8Fw28F25Y/9ODLvrkjnnC9RmznJppaQDeBLlzsgOFDfYT
 xoviLRwNTqixt94wVcaTYWu7dlnVCcQIeUdzP1BTLdEc6N203NHBqzgewj0oeNQHQn6s6/i9Uv4
 gr1qWj8DjTn3iFYKMTkE2CGHbNpVeimtHYhEEoriwZAYUG7BjZNCrvJO9p6QLmdK0WjKkGzd25I
 ZC2FrBeyAODnCG8x+ASF374ICG1/TqirqlIIcSVWMhjjHT1l4qeXLUofHzG4s56E7ki2LG6EQPB
 Ybu4al3mBRVOyRcH9MKxnYyJHAXSqMa1I0p7dVHYSJi7y+NwEHyXr8xFsbROffJeTz6L03ec7wz
 fCoeMfREQbzhcIcYTvsntsRpmGCqvCFoVyOr+b/1qMkY36/JFJ694lXB8wTaoKkPeUYBGBthv0y
 U05OrckGTWzM85izqPA==
X-Proofpoint-GUID: hbgV1IG7JahiSjo6jH9KGrKxLfODBsp_
X-Authority-Analysis: v=2.4 cv=fLs0HJae c=1 sm=1 tr=0 ts=69b7e25b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=f6eOa__KeYMFnH1f_rcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: hbgV1IG7JahiSjo6jH9KGrKxLfODBsp_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160082


On 3/16/2026 3:16 PM, Konrad Dybcio wrote:
> On 3/16/26 9:58 AM, Kathiravan Thirumoorthy wrote:
>> On 3/13/2026 6:24 PM, Konrad Dybcio wrote:
>>> On 3/11/26 10:45 AM, Kathiravan Thirumoorthy wrote:
>>>> Qualcomm's IPQ5210 SoC comes with a TLMM block, like all other platforms,
>>>> so add a driver for it.
>>>>
>>>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>>>> ---
>>> [...]
>>>
>>>> +static const char *const Led00_groups[] = {
>>> odd uppercase
>>
>> Yeah,  in HW document also only this name has the uppercase. So I just left it to align with the HW document. Do you prefer to change it to lower case to maintain consistency?
> Yes, please - I would assume the original author had made a typo and
> didn't really intend to have a single random occurrence of an uppercase
> letter

Ack.

>
>>
>>>> +    "gpio23",
>>>> +};
>>>> +
>>>> +static const char *const led01_groups[] = {
>>>> +    "gpio39",
>>>> +};
>>>> +
>>>> +static const char *const led02_groups[] = {
>>>> +    "gpio6",
>>>> +};
>>> What do these 'ledN[012]' functions represent? Are they muxes for
>>> getting activity/status signals for eth/wlan ports?
>>
>> Yes, that's right. These LED functions used for the eth/wlan status.
> Can we better group them, e.g. into threes in 'led[012]' functions?
> (or whichever way they're coupled?)

Ack.

>
> Konrad
