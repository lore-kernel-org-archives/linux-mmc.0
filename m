Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4826C3B6
	for <linux-mmc@vger.kernel.org>; Tue,  1 Jul 2025 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360693; cv=none; b=fUsa4TsXxYwOrPrcmwkE3iBnxOUwAKHWZfNVyT2lERx1V/hkyADqvLrd8dzpqWIcOXstBzyTiwCwf+wLeyZ/SeR+qNHsFUdWXN+HdY+z9klHX4IoA8gfIZpm41WeJYtksbfvQ+NUTEPQXyukc6/Bigzd6Mjm16M2SAjSPQXtYIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360693; c=relaxed/simple;
	bh=lpfLiQQ4hlhOCJz1bORSb7XRjrfYlRfnFzYM0+NnJdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJo3mLztcoRp06kUWTsXk4eQpSM9xkP66S1eSuMYxT08Smolesr9DW3HojYrj/+PYXkRwuAAtAitUzRDbydgH7U+C78gLbCdfPfVhlCkVvvRBFOYHHoLlfbavmiwAXzJrOGtuv3AaNtdeSd//4ylEhuhjlquoQaY2s6kkP1J3dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hXXH56RJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hXXH56RJ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5614a7GH002177
	for <linux-mmc@vger.kernel.org>; Tue, 1 Jul 2025 09:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lkIMxJPkQ5VcBbbAsfDLRu3BLuhWWjrI6VV4sNA6DUg=; b=hXXH56RJrGvCQvLR
	x+I081SlS8bTOI2kT5kKfyQmjvCm+i3FhSZpQ5OD8/AJmMrNbbLoohCTBcN3EMV8
	BJK/Smbl26D7apB6iNS86tYiieiA2DpUw+Yg1VGvg4RPmv4qU4JQ5hyZbjGgWMap
	f2dFUws2ucnMik4ukIV0URYZJEXOZNlBBxyjhCcGWW4lLi0qB3oqmtoxCxU7hHAT
	ZqtvvP2pdCc3cEkwVilCCa25En3NGLbfuwszQSxdlReztA0Uu64rYdK26RpkrLmA
	Doapmyhe7EsNlH7iu5pTa2UepOp2TqOKaHv2TRyCbje/QCExP9QMF6vuB4GJ9TpD
	1V3RBg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j9pcqy1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 01 Jul 2025 09:04:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a5832bdd8dso5493041cf.1
        for <linux-mmc@vger.kernel.org>; Tue, 01 Jul 2025 02:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751360690; x=1751965490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkIMxJPkQ5VcBbbAsfDLRu3BLuhWWjrI6VV4sNA6DUg=;
        b=YTMFImcuSbb84tEEVXfYWudMc/Fwwrbme87sUWv6W28tXv61pmAyfYwLCA3D4D71MN
         dBEHUayze5xgh8p3LXKuvLOfWqaHBuLT2s5FZ0t0NwyNy8SmUO96w9piAKDakYotXTnr
         V25K/xeVdBFEbaMxFclCokFWNRokk2KJkMSpQl1dlbwckQR/6dHiCyambaSB3ZHkK6x3
         vghQ0AFFE9gj+bfhKH5MQbSvdCAtdDGZew8nqFwzVYadPJvyLgO/R0MsiK3T3pEhBi6G
         5u+pc1Ig3rQB4PIwHGtnV7AT23zlDX31BC1at+bNn5CtAfg7y/Ng6GONcM9K3jUU5gIH
         C0VA==
X-Gm-Message-State: AOJu0YyUewgYqnWSXnWJPlO7Tmof2GIC3JR3Av3xVGgbZw+u+DEeN4Y9
	qMjyVjJDvukZs6FyHlrOvZVAeY7Yilrtjr39nlyhXnyWrirNBem5n/e1thIXAho1rlJxz/4unE6
	qosXz8FRO9oWy5Mv1nUTSNMP8RHqVy2GfUvWgCIWPWNMsvUHRtcXm3KRfjZlLkjE=
X-Gm-Gg: ASbGnctKAnmHx089jlewo+sxfMoVMFzVqfJu3KmNWvTl5vxqqg4oug2JFqpoc0zmuic
	+G3TZz3BFAE5JLJDyCTgb56teNUHJSjxeG9PQzLgxMW41EPuhOTcLuOeYoaxZ+YY0/zmBZBcdlv
	AbD5IblVASYoO/H6OZZffFOPLYokmxFrQaO1FzPhmnNY/dygC3wGqhWVGh3fq6n3VmCpjBB9/An
	Gd85dDXrLIhvX2F4Hy3EynRlwcUBSNjYCNYsRkgGrALHmOA4ZzRjqfvlEJxR1Bo0c8R2ZuLXbeV
	ISaoS/jN+kVKJFMbWul8bMKFAodf0ocxGG/L+0nuyi4jyZmrukGFsdFSJWdBlGUaho7mY31INHJ
	oeGpopYYj
X-Received: by 2002:a05:620a:40c1:b0:7cd:4a08:ea12 with SMTP id af79cd13be357-7d468757dc4mr99321885a.0.1751360689564;
        Tue, 01 Jul 2025 02:04:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeUDreOqmNQeuBoKNAZdsqkeA395+Jw1kTvuMcKxjfGMcdPAxGzBGNCpTkmEn2wBcAWkMuOg==
X-Received: by 2002:a05:620a:40c1:b0:7cd:4a08:ea12 with SMTP id af79cd13be357-7d468757dc4mr99319985a.0.1751360689129;
        Tue, 01 Jul 2025 02:04:49 -0700 (PDT)
Received: from [192.168.1.114] (83.9.29.190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c01980sm810958466b.81.2025.07.01.02.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 02:04:48 -0700 (PDT)
Message-ID: <a6117473-fa38-48db-94a1-892b76abc10f@oss.qualcomm.com>
Date: Tue, 1 Jul 2025 11:04:45 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/4] dt-bindings: mmc: controller: Add
 max-sd-hs-frequency property
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Sarthak Garg <quic_sartgarg@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
References: <20250618072818.1667097-1-quic_sartgarg@quicinc.com>
 <20250618072818.1667097-3-quic_sartgarg@quicinc.com>
 <6040afd9-a2a8-49f0-85e9-95257b938156@kernel.org>
 <9627ed6f-2bb8-40b0-b647-5f659d87f2f9@oss.qualcomm.com>
 <bba062a3-f96c-456b-8e9e-fdeb0dc2d28d@kernel.org>
 <5bdae07b-a7b1-49be-b843-1704981bc63b@oss.qualcomm.com>
 <ffc62906-c3bb-4968-8f7c-fa7ae5028ad5@kernel.org>
 <fd73a142-3b22-407f-8e6d-00f4e1e1c8eb@oss.qualcomm.com>
 <e0e66895-e68a-4420-a61b-98a689798ce4@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e0e66895-e68a-4420-a61b-98a689798ce4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -glCy7N-jPRFTlTB_wxhFvX0uuPNuATn
X-Proofpoint-ORIG-GUID: -glCy7N-jPRFTlTB_wxhFvX0uuPNuATn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA1MiBTYWx0ZWRfXzLtxsqeLjAES
 +mc+kvYM5nO9YsNzUbkvGhJu0aX7/XejmbqYUCrAY2PfDP5Z7CkMIyF4D49po4BbfVuyjqFC3YC
 gLLLmXr+SJPtxF5RFK19ITVF9LqThimQt/XRzmjl4ss/SM2UKaRTJzgxQ98R5C7Xi7ddyhulWlB
 pNHdR8usYPadgTqzHeLxW4RYLBIZPnhijfRuO2I5y0Ho/ZSdwCydgRdGBtNx4fd6yU4GQNk+Hoo
 gd11cCTHR+/1Hjdn1ouCIoAEvsxjdZGLbN6V+2+CTXLN23N1N5m4s57XtaQtLz/cjLRKOzxUrho
 R8MxgdDNOrzWFV80hutMkBuPrsUwO6vBEoALhKdi2mvQKaa60lH7YNspXdAE+E4/0+zpoqwHhbv
 qdJqUdXWZ9gc7xCAoToVqP+nHTgwuyQ7QfayZ8z99J58GOjE6CpiEo1I5eLTmlzldAT4M3mk
X-Authority-Analysis: v=2.4 cv=QMFoRhLL c=1 sm=1 tr=0 ts=6863a4b3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=fKQzr7EGRj+VoE0XNsDNvQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Nx1jMUExMGuVGuT9j-gA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010052



On 24-Jun-25 08:06, Krzysztof Kozlowski wrote:
> On 23/06/2025 14:31, Konrad Dybcio wrote:
>> On 6/23/25 2:16 PM, Krzysztof Kozlowski wrote:
>>> On 23/06/2025 14:08, Konrad Dybcio wrote:
>>>>>>>
>>>>>>> This might be fine, but your DTS suggests clearly this is SoC compatible
>>>>>>> deducible, which I already said at v1.
>>>>>>
>>>>>> I don't understand why you're rejecting a common solution to a problem
>>>>>> that surely exists outside this one specific chip from one specific
>>>>>> vendor, which may be caused by a multitude of design choices, including
>>>>>> erratic board (not SoC) electrical design
>>>>>
>>>>> No one brought any arguments so far that common solution is needed. The
>>>>> only argument provided - sm8550 - is showing this is soc design.
>>>>>
>>>>> I don't reject common solution. I provided review at v1 to which no one
>>>>> responded, no one argued, no one provided other arguments.
>>>>
>>>> Okay, so the specific problem that causes this observable limitation
>>>> exists on SM8550 and at least one more platform which is not upstream
>>>> today. It can be caused by various electrical issues, in our specific
>>>> case by something internal to the SoC (but external factors may apply
>>>> too)
>>>>
>>>> Looking at the docs, a number of platforms have various limitations
>>>> with regards to frequency at specific speed-modes, some of which seem
>>>> to be handled implicitly by rounding in the clock framework's
>>>> round/set_rate().
>>>>
>>>> I can very easily imagine there are either boards or platforms in the
>>>> wild, where the speed must be limited for various reasons, maybe some
>>>> of them currently don't advertise it (like sm8550 on next/master) to
>>>> hide that
>>>
>>> But there are no such now. The only argument (fact) provided in this
>>> patchset is: this is issue specific to SM8550 SoC, not the board. See
>>> last patch. Therefore this is compatible-deducible and this makes
>>> property without any upstream user.
>>
>> When one appears, we will have to carry code to repeat what the property
>> does, based on a specific compatible.. And all OS implementations will
>> have to do the same, instead of parsing the explicit information
> 
> Adding new property in such case will be trivial and simple, unlike
> having to maintain unused ABI.
> 
> And it will be unused, because last patch DTS should be rejected on that
> basis: adding redundant properties which are already defined by the
> compatible.

Got some more fresh information.. This apparently *does* vary across
boards, as there is a recommended hardware workaround to this rate
limitation (requiring an external clock source, which is up to the
OEM to implement or not)

Konrad
