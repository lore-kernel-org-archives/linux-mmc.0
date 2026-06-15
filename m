Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7A02AD2C
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 04:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781498763; cv=none; b=fyB3QilQGUej6Lcwrj1fgI/zLv/2MUfM4WiPZQSCDt4B1rLfkOm05jszJ6QBh6T75ND9SPQI+p3w7A6IXuEAapo79PlpF2MS2yM2AdSKvo89tI2OmZyXD6qMPiVjBxD0QFk+9xbHC46h0AkeW29TYSgBKaHSzQxPbST20XFPq/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781498763; c=relaxed/simple;
	bh=JWiHeFDYut/lNpRe4jVppjxnuTFiIBDbHPlaQpSFS7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhwrZdwoDO7gbugjqKNaApGf0/NkhqqcZbhxjogw3cEcPeBfqKq4m286dwSXHaJlBXX0m7QuA3na6JNfzw6n2llBXj2QPGnlSYWTBdCYtkck5VR5Qk8HWWQGmu+4EMuJaIv7ER82JtWkYz515ALQE52DSp1Ze3zVE/Y5vib/j6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KxDVXswa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cvD2lWAu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KxDVXswa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cvD2lWAu"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F1iCUT2726183
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 04:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7B1Rri1bOKV6WrRa0Ahdi5sYNCs1jyUm85PYhWylAME=; b=KxDVXswaXB+WGYJ/
	yiCJeN8HBMKIM6XpNpdP1qgzzBLp8yOi9HbsZXvR3uC2KnsktXDA9nlkPxkeOFaV
	TxbVfu2CZy8fRFlB50H21qmpnNqk1rdnwgdOWjUSsriXPzYxRS2wTFmsNlXirKvb
	IT3MHDlPiQ8CiCYdOm8KCSWHqVisWwA6ckRkwmvevgI4mnu1s6Is6pxpNtp4Aqx8
	2R2jlB94cKfWM60/jNlK3WSs70Y8bWc2SPDDrGWl/NUpOQLu/Rf1/8687xPwDQfr
	q7u5+inO2ezS6T0HiH/RyGyd7NEF/jL/iQsGvZE2BUaMwCppAdATXVfYkq8x1i9f
	eJ6HbA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4es0cgnbk8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 04:46:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0c272e532so30664655ad.1
        for <linux-mmc@vger.kernel.org>; Sun, 14 Jun 2026 21:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781498761; x=1782103561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7B1Rri1bOKV6WrRa0Ahdi5sYNCs1jyUm85PYhWylAME=;
        b=cvD2lWAu746iWZB2hVJoPwMF60UIOOT8QFpWOX3lJjLEAe0RGuqhVr9q3bpuZncBLH
         XgUxtDe9aR6ebe/N1WxXVL5t+s1TBrabE5aDycVG8SL/zhII/V94WdzLJMO8wjmHmouo
         cm7LypP2fW+t/xQBI7Ki0Yawg1ZaflZM0C5C0bjjXUAQmzufA+hqLWg8GFhrZOmeYC4e
         wTmgA+Xya4wswpfMBeWH1aCm750bmmCYhZGFRoy6la6pD3VBQa10B8YnxgF8lvLR1/Pn
         E59M6ra2coN6ZDR7rh+G9f3pUf8e3TkbDUfCGgDBzCv2DQV0ELuHl/Yl8CXxCtknm4aU
         wAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781498761; x=1782103561;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7B1Rri1bOKV6WrRa0Ahdi5sYNCs1jyUm85PYhWylAME=;
        b=K2xx47sG4qvxnMFKJjZOxs75rmBFCbqA1FIp2FpDwhjr1gq5eMMs/Nxz25GiljewPU
         eL5K/zGh01XRCR+J9JG/vOmjbaftqs4ZHM0OqhAKDysKDF6geq3JyZaFz7iZbEuQykza
         PHuCa6eRlBlWqbpcj0Llr1le1fvA98X4vRnvxmMR1JwE3RTZ9SV6K9bhP8VxSwCWd9Ta
         BSZet61UVkGOQIDanNrSFcgKJtjqrJN+bA7F0eB6NgyO1Ak1KNXzWxNJ5+aTDLWRYDgC
         bepYHJW/J5b6fhPx468w9V2UnQmWDxbHN9/lmRIMnrZbW+J0V31E1GKDAMf5cyB2fJX/
         9Wmw==
X-Gm-Message-State: AOJu0YwJ28UnDt1ijPjXHz24+MjiuO4rhFjMNdgJJCA+m0o/0aXxKMvZ
	ZgjqJkveclCUKpGAsxFGQO29pG8nFc7qfRWfMvbJNFqhWCf9AUp1kkpnIMoxFyC+X7iZshAMq1X
	Jj9TNvSYOD6BlkWK6upKvf5T8cR4EPlNI0KvskfZoka4v2rj1/n9sUG5IHSljypU=
X-Gm-Gg: Acq92OGdznKxV1odcuc3QaGAUijD40di3p2VxRa9l0uyTI0Kds5U3KLBV2Q1A+mYaT/
	PDy2/KQTctJx1wXwcgZX9nUiBJfywNR1NM2hVks67WxcqGWD4i+pFLkYgutpczdEqCmc5wNy2Es
	IoEqsQp7id/xzDbp8WObXDlHzy1UQsy94G2lYpV2BoXCc2IsceRgIRk1YEGKGs7Iu1NHukQnY+2
	WaHrdfnXjfTK+QwgMt3A+gEkqcDztJCUf+L0XYoHbZpHOtKm2HTYtWJY0KbhBix5C7OLqDRceAi
	/Ox9ISv9A78J1KGMT6feMDPAqH8T0muMK0AWS0j1PsJrtHiUlYkNxffjz3QFP256uhrKLWZnTIB
	/jKGYZ3SdjCf+bMzxvMa+pP9+VRh9mcIGBeGlZFWvgppnkGM=
X-Received: by 2002:a17:902:c402:b0:2b2:ebed:7af5 with SMTP id d9443c01a7336-2c66416349bmr112903655ad.13.1781498760607;
        Sun, 14 Jun 2026 21:46:00 -0700 (PDT)
X-Received: by 2002:a17:902:c402:b0:2b2:ebed:7af5 with SMTP id d9443c01a7336-2c66416349bmr112903375ad.13.1781498760125;
        Sun, 14 Jun 2026 21:46:00 -0700 (PDT)
Received: from [100.70.28.15] ([49.45.133.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f2e5565sm86704935ad.1.2026.06.14.21.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 21:45:59 -0700 (PDT)
Message-ID: <432f3a3b-3d28-4130-9a9c-61be04eade1d@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 06:45:53 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, ulf.hansson@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
References: <20260608041650.541502-1-neeraj.soni@oss.qualcomm.com>
 <20260608041650.541502-2-neeraj.soni@oss.qualcomm.com>
 <dc833e56-e127-47b7-9ea5-58d6d2cc193a@oss.qualcomm.com>
 <c8da8a89-e372-ca87-cdca-396c754ef5d7@oss.qualcomm.com>
 <1a66f1a6-840b-4de4-8e65-a3456b654044@oss.qualcomm.com>
 <91a90c37-f93a-17c8-b4fb-290759645977@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <91a90c37-f93a-17c8-b4fb-290759645977@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HvocPYjIySzGULMxcQM1Oz81v_hGhfxA
X-Authority-Analysis: v=2.4 cv=NPLlPU6g c=1 sm=1 tr=0 ts=6a2f8389 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=0jymCCPDh6kUuRDdYuKZ0Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Kt5I_01B2RkASw4xh4EA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: HvocPYjIySzGULMxcQM1Oz81v_hGhfxA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA0NSBTYWx0ZWRfXy3X9z/3iQ6FS
 m5kPhm0MGkQkJmtapWNEaTBWxksFxDh1DW+6nXn3JAc10PJsEzLPMeyxMI0htnd7RWdBKd++UWb
 jIli/BOQhNYa3On2ogb2BM3A0lY2yo8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA0NSBTYWx0ZWRfX4yNLAwYtxdPf
 vpzgu/B+ZGhTZ2HQI8bcKiCAMiE39YvtQH/c6rfmhjP38kdGjmb3GBEtkTYBCPQZYQPSWypIgDv
 2YckXLS1xIuH+7QuV7BOvoDwLptGrdLjxLYgq2CPtuKlYYWLpnYKuVRZyc1gKWv/WLMKaLKNUMk
 fEsEoCCRYM9TE5aj/kDJdd/BvwJLXEWFbJUMqGqGztPhvwuXqK6egxVGXRPuRYt/5ZnJEZSRF0z
 UtI7nudMzAQ/aoZTZBm1TT4DwewBvocJfuz4RDV1Dk2aryA5cqNPKeTfF585hCsU40w6QCD6QL6
 V9y/MAljmt+4nsvnHsZY86A2R2NvD5dzXp2ghBpR6vvwn2s/0WplAEf5jx1oX7892cbsw4nqk6x
 caHgUOb6nYsUqo/ezj/AlZ0AxNKUq8b6AvvkiIwX6NCD0lHimScCiEajxBFdaR+C/gZffRl8UVX
 c+HR9MRIcyFjCXmzJMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150045

On 13/06/2026 07:21, Neeraj Soni wrote:
> 
> 
> On 6/9/2026 5:19 PM, Krzysztof Kozlowski wrote:
>> On 09/06/2026 10:18, Neeraj Soni wrote:
>>>
>>>
>>> On 6/8/2026 11:40 AM, Kuldeep Singh wrote:
>>>> On 08-06-2026 09:46, Neeraj Soni wrote:
>>>>> Starting with sc7280(kodiak), the ICE will have its own device-tree node.
>>>>> So add the qcom,ice property to reference it.
>>>>>
>>>>> To avoid double-modeling, when qcom,ice is present, disallow an embedded
>>>>> ICE register region in the SDHCI node. Older SoCs without ICE remain
>>>>> valid as no additional requirement is imposed.
>>>>>
>>>>> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
>>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>>>> Co-developed-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
>>>>> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
>>>>> Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>>>> Link: https://lore.kernel.org/r/20260310113557.348502-2-neeraj.soni@oss.qualcomm.com
>>>>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>>>>
>>>> Link should go below "---" to specify previous discussions.
>>>>
>>>> Usually maintainers add link of patchset being merged here while merging
>>>> changes in their tree but authors don't add it here.
>>>>
>>> Do not see any such restrictions here https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>>
>> What do you provide that Link for? What does it bring?
>>
> Kuleep highlighted a concern with the usage of "Link:" tag. The link i
> provided guides on posting patches to upstream linux. Wanted to highlight
> what i folloed and I did not find any specific comment/line in the guide
> which prohibits author to use "Link:" tag in trailer section. If there

This is reversed logic. You need to provide reasons WHY it is worth, not
just claim it is not disallowed. Adding 100 Links to whatever website is
not disallowed, so you are going to add them?

> are guidelines otherwise please let me know and i will correct and post
> new patch.

The "Link:", not the URL itself. What does it bring? Linus made clear
statement that you should not add links UNLESS you have a reason.

So please share the reason. If you do not have, DO NOT ADD any "Link:".

Best regards,
Krzysztof
