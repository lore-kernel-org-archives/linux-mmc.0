Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BB128C869
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781511397; cv=none; b=BJ11SHzmHEB/b5PTUGiuxwNIkrUgnM+QFryaTmyyOsQF7wf2Gk/PT9k6eRoiBLj4BfBVZZkBcqeqMjADnV40IfAr2hjbkJuXC4RXAFoKMwwQZhESsHtJqZsaA28r+MADRHzYJuPuFMavWsooF5EsR0EcAXvqyLhHoo0KlC5V4Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781511397; c=relaxed/simple;
	bh=WQeiERPaY6Shef7hbj5xBNnj39AH9DVnf6MmKY2WS9U=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CBhKRK3Nu3wKkYU6GDnh4xCevS5BKSRNDy03y8bZR0f+2fV7C2adsfXgQ0vyo5NJebWYrYkInySMrjNI4AfyBDrxFCYlPvpZKYFVElCXnbq+vuIskRPiG735je3ZEn7jZtaO8dmhpR+thmZjS/kZvbJsOY5c8E8GKKNAuhau0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gnSrvpkb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kflVSAhP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gnSrvpkb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kflVSAhP"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6J1Vj3327530
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 08:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uKAKZLHWhyZbcRvW6UFM6brpCAGbrwtPlsnkYNwsv80=; b=gnSrvpkbiXoNIy5H
	IOylNB5sLFJZO+qza79cW3ddzh0BFOkhbOu7bpBeYiz1q6bfgotHrRftoB20l906
	8/oHUbus8uBFlcPhFgE16WOSIEK3DQUlU8m3Lnx5xJI5ByeZ1MbDwE8Igqkx87tb
	7gfEmTI0mCm3Dgg3wJJ8pyAwV2mGwD5vJJodpAipglTaSO/a7Fg6mdmBq3r3Y7Mo
	nRJZ4YPq+fHCskWv4O1aLYRi/vJfsxIWcu2wbFMG8XEOEFvwLpu6u9uJ10/XNftJ
	r30xq4KG1I8dB7BPsJDJ9Arm9VeCJXoUlZ1FjbP+Zn29a+vlQCsddrn+7OS8Nz8v
	XSfTnA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4es0cgp7gu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 08:16:35 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84245e2bb00so2853622b3a.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 01:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781511395; x=1782116195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKAKZLHWhyZbcRvW6UFM6brpCAGbrwtPlsnkYNwsv80=;
        b=kflVSAhPh6zQRTwbd8IOg3naxYaSNcvkn+AAinMcjKLfJFgtGA012abvcR/6W50AE0
         Iq9r1fFYv/QeWt5J4UGQJbpw8dntjUwfZtPN5MAK3tj9KzE2jVQAMyrAEB1LzVkt4LZh
         QbWWxz+TEuPXjgfS4IMxXoEOs6cgvfdt2O6rZ/jKs005RRp6QQ8CSHo2VEcyJfkIZp/J
         n55gXq1QfArbQ3Vgw3qky3TcI8DTp1TYx9vPBC+l/fBzHv1gSNLlJzcWzsD3YwXubQkT
         racYd8N4N9PeUtsXbmWzvn8ZI1HPbAmlKWrqCWZ5BeKk8LrqiG672LQHUrq/zb0/G5B0
         0VsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781511395; x=1782116195;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKAKZLHWhyZbcRvW6UFM6brpCAGbrwtPlsnkYNwsv80=;
        b=WvQIYipYXdC6sCYk8Bw5scDIVO+FtySQGRj9Hu+Eb6W1F7g4UgJx4STjEnVWNEIfBF
         dkdXTAHGNS0GHSK2+s3XmmpD90MijFFgGuq3LGWdWaxTHjlCsjszyBjYYspqYN5+pgD9
         se3GWHoRC6lugNeF0tXOhXKb5Bpo736VPxSSiHGkgexrUIEHagLBXvsDkpAEQ7dRGjHl
         r4oMTm3eb0VCKn2XZI+Z4pSq8/DhevDO4WU7HYdbZeAGfXVO5CieAw8kjNwzTy+88XRw
         jrx1BNijt9UflSsSONtE2ike9ONX+igmgQei0eKe0G3+QEpnnw01+QCpCK0zzw5+hLlI
         A0qQ==
X-Gm-Message-State: AOJu0YwxqNFF907QvFrSv0Ce7pYnfbUkoVeK3GqIWIz8XRZruHNHi3Kk
	b5kAJh/qGjPkp9WRQ1d9EBJ6oF3iDIa+K7CBDLTEtwGst9FuFGNpu3bDj+toIjPBKkEJVbTdapD
	jhd0xBN3GADuh8fWI/GLrc3KIcf3WDldv1qa2TfhMAe5NIDaHGPC5OGgvIk4iqho=
X-Gm-Gg: Acq92OEytPEJaMps0j49M3J5VzV+6TfF/LkHyczuKTuY9CQdPq8UoPfTJ3RIWeiKKo2
	KJBZxgy3EWgL/Fr9CIJCOpN5ByUPNSSBpChj/5XgItWyvQBsed5vbalf2M93bym0pt/5gZG+o2h
	+bUUDQ+em/EnhBBlCdonfq04BVIFNZo1LLmwrllUS36TfSBf28q8dDvZh2aMRuT8VMsEmTVNY+y
	12meih2HQ5TxuaObevd7mhnLJ8cUgkV/QGhgZ8M+dBZtVPlA/Vq2Mw70YsLUQwhP46uIZZBhYuU
	o2RvsEI9q92lpChSx/YlZ4vCNAH5mLxVkNKRUNX7JaCFtGUKIwpyrzU4XQPsHI6LNhwyr4q/BUE
	+5sskt6z8fmtdsRep1vAPY793ktl6iYmwT9WDkObP5RZzBwyKFA==
X-Received: by 2002:a05:6a00:450f:b0:835:3949:3c1f with SMTP id d2e1a72fcca58-8434cf0e0d0mr13804244b3a.24.1781511394697;
        Mon, 15 Jun 2026 01:16:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:450f:b0:835:3949:3c1f with SMTP id d2e1a72fcca58-8434cf0e0d0mr13804195b3a.24.1781511394140;
        Mon, 15 Jun 2026 01:16:34 -0700 (PDT)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afd17f5sm8444410b3a.39.2026.06.15.01.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 01:16:33 -0700 (PDT)
Subject: Re: [PATCH v7 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
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
 <432f3a3b-3d28-4130-9a9c-61be04eade1d@oss.qualcomm.com>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <8c2cd2e3-434a-936d-99e1-3e96b399e8f3@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 13:46:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <432f3a3b-3d28-4130-9a9c-61be04eade1d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BmUeawmyukuV4FeETN52nzz1eBwKhoRo
X-Authority-Analysis: v=2.4 cv=NPLlPU6g c=1 sm=1 tr=0 ts=6a2fb4e3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=FC_baigHY8OP_pc6ZEMA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: BmUeawmyukuV4FeETN52nzz1eBwKhoRo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA4NSBTYWx0ZWRfX4UfTZlu9Wuc+
 kk5w3YZTTShgIveA4Yl4TrHh0CuEsBgomF+6tZHgDmpRoCQhYvZTJl4dnYcrl7//5RrYnxv0eUc
 b9nWZG+w62lQDKW2ixrv0hmHuW4pkYY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA4NSBTYWx0ZWRfX4dlnxd/hC/qs
 OriK+Swo1rPENoc2KW0gFvGY+RaAfdY/+LTtKj+D5Wfx6QE4mB/ulZSUv1Applzbs11EZfIo5AG
 8lIeorP8f647YywdRgUxzW0S8K6A0hwSP/KzlL4F8mW1vGhfHtM0cL7JlGo2DXf6V2HBMwFBFMc
 cTD9uVCsBwWU9NhBfiVBjqHFEfo3eVUtjdco3MDUvwewVNK+twIW1XxtJYDq9+gx8ZjJC5uRCeO
 fROivcnzGFFEx0sDyueapVj5WpGZXIrGYWRFsFcBJeLVSHSX8gFVy6TWz/D0J2Yn2VsCRM1WWnm
 i6w3KbedRqWeVM8Yi2H80nYjWtjoiSRps+KbQu5Ao39e4wiPjlljkcIefrhRNIBwjojXCIy8h/U
 3aZkce7Ez+ah4duRVlzMR6O0bHSF7VUCpBZSnFAP5k5BLqDQCmugjWYSGn+mRf4JbfT4cLBdHDz
 saNxtKTta5a3nh1diNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150085



On 6/15/2026 10:15 AM, Krzysztof Kozlowski wrote:
> On 13/06/2026 07:21, Neeraj Soni wrote:
>>
>>
>> On 6/9/2026 5:19 PM, Krzysztof Kozlowski wrote:
>>> On 09/06/2026 10:18, Neeraj Soni wrote:
>>>>
>>>>
>>>> On 6/8/2026 11:40 AM, Kuldeep Singh wrote:
>>>>> On 08-06-2026 09:46, Neeraj Soni wrote:
>>>>>> Starting with sc7280(kodiak), the ICE will have its own device-tree node.
>>>>>> So add the qcom,ice property to reference it.
>>>>>>
>>>>>> To avoid double-modeling, when qcom,ice is present, disallow an embedded
>>>>>> ICE register region in the SDHCI node. Older SoCs without ICE remain
>>>>>> valid as no additional requirement is imposed.
>>>>>>
>>>>>> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
>>>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>>>>> Co-developed-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
>>>>>> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
>>>>>> Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>>>>> Link: https://lore.kernel.org/r/20260310113557.348502-2-neeraj.soni@oss.qualcomm.com
>>>>>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>>>>>
>>>>> Link should go below "---" to specify previous discussions.
>>>>>
>>>>> Usually maintainers add link of patchset being merged here while merging
>>>>> changes in their tree but authors don't add it here.
>>>>>
>>>> Do not see any such restrictions here https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>>>
>>> What do you provide that Link for? What does it bring?
>>>
>> Kuleep highlighted a concern with the usage of "Link:" tag. The link i
>> provided guides on posting patches to upstream linux. Wanted to highlight
>> what i folloed and I did not find any specific comment/line in the guide
>> which prohibits author to use "Link:" tag in trailer section. If there
> 
> This is reversed logic. You need to provide reasons WHY it is worth, not
> just claim it is not disallowed. Adding 100 Links to whatever website is
> not disallowed, so you are going to add them?
>
Ack. I understand your point on Author's responsibility.
 
>> are guidelines otherwise please let me know and i will correct and post
>> new patch.
> 
> The "Link:", not the URL itself. What does it bring? Linus made clear
> statement that you should not add links UNLESS you have a reason.
> 
> So please share the reason. If you do not have, DO NOT ADD any "Link:".
> 
Ack. The purpose was to only highlight what was reviewed but i understand
it was not necessary. I will fix and post v8.

> Best regards,
> Krzysztof
> 
Regards
Neeraj
