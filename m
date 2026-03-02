Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E5B35DA48
	for <linux-mmc@vger.kernel.org>; Mon,  2 Mar 2026 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450764; cv=none; b=kdzlMfOm9fwvVd445mI/11NcPlIi04LonWhm5XGW4QICY0xM0eWtkNKQduWWsyla/8XlxckeXDKFHBW6cEmtFgwb+26ctiFkzv+2BQcu4kNPVJrT7vbbaMz7ATi2qRZTGJYyixoFEy5bTMKYaNJzxZfIXHm4aKOA8da5apgTT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450764; c=relaxed/simple;
	bh=zkf4rTc+nc5uIOrgr5u4Jb6syRr+y5A/JyBO+FBgAJ4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IQTcu4M0qt33W0evriqp4bDrO12kxT0w8PRseylSUX4myCMwpiQLsY4nnrhSiV5bxjPsng+kX1wCc+/ZToJDP/9Iy2KIRt3yfzVge4lxwBMtdC5Dur4zQVsptKC9dCUZrCJyAcEAwg8cuh3JTNcm1rqyPn1414rpRkyXt7Q5cas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g5yBSvmM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KxHeqeYT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g5yBSvmM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KxHeqeYT"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62294WZm3752703
	for <linux-mmc@vger.kernel.org>; Mon, 2 Mar 2026 11:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kL0GBX3M5EUOIFB3IDifGu35iWJBpOeIwSooFpQIjkE=; b=g5yBSvmMJOgYj5ON
	Pd+3rgUXlqnhmfw+Awv7xsVnl0e8rS4asBaTpYGU8D5N4aQbLYBzI/qOtRo/RBfV
	utH6daqpFI7q2hG6HK3cCRdqEdrQLS+D4Asq2+dXtwO5EOlvTAX56fNruni96pP2
	uDUAf9ObBdMRqhoaK8IqacwP6Rdr6Gt09RXJ4NJwRArdlELhDDSSChsBnd0pjbvY
	95t/BXNPx+Z5gAce6qRE9CrzhDMeFlLV2WRe8WBQMnDxMbrsilGJvrlUKKymKJbX
	zq/W2sE0os73/Cu3gKiviQQ0mCQ2+IefQKW7zFTFdU6NikMv1bgTRUq/jBgtBFki
	0EwosA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7kq8ggf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 02 Mar 2026 11:26:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354490889b6so16697075a91.3
        for <linux-mmc@vger.kernel.org>; Mon, 02 Mar 2026 03:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772450762; x=1773055562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kL0GBX3M5EUOIFB3IDifGu35iWJBpOeIwSooFpQIjkE=;
        b=KxHeqeYTPWsaQ3TC7XYU1UCYujNnjghAW2A0WbS7rzSmJ538T7cB4EYeCELI/2mWDD
         rY4kmD0dF7gfrimR0q1USNBSuCWf7BhtR1ShrKGqN363Z61iXUztdVEsPPHfoM4We4+H
         3PgJwzzUSuQIdGth1fN/wgxrJZLYKpEZXaZOHHTpj27zXH9dZsz/hdThvze9e2HQtVkl
         DTypHZ4KKnad1/Qr1EFEMRJ2gFH+G4VpY8tcM/WsLRmlRZFgheM3A5LgtVcQvi7kurPQ
         MQ0fplvSD+TxxLRU51HXTvbZViBCMVCpn/Kdp/eL1Vmt5cXNuZ16OOvYHPKh3dnFsRTH
         FlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450762; x=1773055562;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kL0GBX3M5EUOIFB3IDifGu35iWJBpOeIwSooFpQIjkE=;
        b=DQ3OHgz5bVoqM91sijeEcgAwz2nZSFw28dnMyBs3Y8H9GneubNWdrGsM0NzNj46OBw
         o2h7MYGckma+JRMCVbGMupOEesYyMPFiRYEAXt6pGIZqJ29L1Xx3dXmIChI46U4dx64+
         NXd/oQl7r3vdrM9fN8mOxbionwHnamUeH05tAbcKCh4pPUHzW30oFY+77BDZZG/BKOOd
         CRMIjgOp59OZ0vEcPHCXimY+fUHdTNmKdqDazWNatlGFiklaUAxW7Z2g8+Avt+P8mjtG
         DBFqZCsf9AfsmunGwqGPB0ENR1hcJT4/Fn85uLenMsQ7xkXQwqXAWfGDQ+E1gczsefSe
         iqbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTfk8E7YlgZiEKcXdjegbWbMuYNQCvM0/mIcVWiWSw5I6s1KUdpzLX6c9wc3d3Vt6190TgsoPfU7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO+jsd779mX70pQWL3Jf7h9VwCThZJYCeGSRl/AbRDFFfIxfOl
	5YBKsckoh4cYS36Tu8VKY0rPxfoOFYtRUFRHi/h6nmmTy8WG1vWJcRhlD/hKcrzVZBNNW2emeTN
	wRe5ukCPKrld97qoBxIpK8RSWOjNBlQKYIgJFES/9PDzJZB+XXhrsM8Y151r67ko=
X-Gm-Gg: ATEYQzwVaZHLHVlnjEbOhgiuouTj89/FHeB4ff6JrITtMdTIkJ1wnQCZ7c1IHG4MFuH
	B6y5Q2crP8b+2F/DpCYUUdfM/xk1PriThiSL+Zblb259JMTo8N/U1oOyzutWllVvY7g74Q2r/Ct
	7LRz19xhnSx4SxKTeDaan0+p1xIByvLqxanreQFkKa1Cc7mVvHVuMEjGa/ekZS5ehvpGSsGX+uX
	6+L858V1wk2oCliOss/x4RHNdBD8Mid/zVFvMQCsWkf3W70vbd3DliVXh8L4BoI8Yl5K/abnvDs
	XsStErqqpvvR2yg49OkQNwzXVJZiNxVqDe4Pik5Mm7FRMle58M9+9RbLy+/1T0KJDh9M3IvmkuF
	okReaS6iTZ99S7DcKvOGUfpaBVkDLZKpgvnhpZ0BKnTwuA7Ywfw==
X-Received: by 2002:a17:90b:590e:b0:354:a57c:65ec with SMTP id 98e67ed59e1d1-35965c9043dmr8800980a91.20.1772450762132;
        Mon, 02 Mar 2026 03:26:02 -0800 (PST)
X-Received: by 2002:a17:90b:590e:b0:354:a57c:65ec with SMTP id 98e67ed59e1d1-35965c9043dmr8800958a91.20.1772450761672;
        Mon, 02 Mar 2026 03:26:01 -0800 (PST)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359858ca871sm4552392a91.10.2026.03.02.03.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 03:26:01 -0800 (PST)
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
References: <20260217052526.2335759-1-neeraj.soni@oss.qualcomm.com>
 <20260217052526.2335759-2-neeraj.soni@oss.qualcomm.com>
 <20260217-berserk-puma-of-focus-bcbe82@quoll>
 <e3ac0681-605d-c1df-e4f0-78a2c142fa66@oss.qualcomm.com>
 <21a87714-cd11-4217-a2aa-82fddc3a8530@kernel.org>
 <544925d0-cf32-6b2a-548e-d6f7cc517581@oss.qualcomm.com>
 <01085021-c116-46de-a0ce-730455620cb2@kernel.org>
 <32b7763b-ba44-4341-8528-be97d6607354@kernel.org>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <06967254-7fa6-218e-db8a-8e4a118a7d24@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 16:55:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <32b7763b-ba44-4341-8528-be97d6607354@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JKdCB6wxBnO9EdHEx_QSVP6FLOl0eXQP
X-Proofpoint-GUID: JKdCB6wxBnO9EdHEx_QSVP6FLOl0eXQP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5NSBTYWx0ZWRfX25VMvTxOM9jV
 A+9tlngmCnjZ6+p3wmf8n11spZncAldrXYytQxasA8Cryb5iidWDnaRDczFqA6a3qtwb5kDRH+m
 /vhD/qbWl8UlePg+OySgn6DyIx2JmRluD49p9qTKp3u0alZ/aCU52JRXAGvzsS7zd5UerebPbOx
 +aV79mMlcK7l/we97JofzZVCLTxZg9zIoN4Nu10hZZt96GLTfvHFgI5MPK8i6HSw5evB1Vmxfhe
 22zaNMnsyGcnMnv7JQGzmwNks2wOXCHsR4UYCKk2Arl3CqisCiDR82qFlEDDTRNBEenucjKMERp
 7SveMKFDFHsH5Z9pXNPUX5DHZXBuMboZvL107qQYcu+wzm01JTTODLU0eIWJsbGGAwu947V/pw5
 Tih8TDk9NRiGcKgYok1GZ0MQq7DojLzH2vN7O2XmkL13pInKyk1LUHhb1TjsY0ovInC/rnP0oek
 LjztNQ4X34z/GwedlWw==
X-Authority-Analysis: v=2.4 cv=GLkF0+NK c=1 sm=1 tr=0 ts=69a573ca cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RyUJWM3ohA95taQL8aIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020095



On 3/2/2026 2:27 PM, Krzysztof Kozlowski wrote:
> On 02/03/2026 08:48, Krzysztof Kozlowski wrote:
>> On 02/03/2026 08:45, Neeraj Soni wrote:
>>>
>>>
>>> On 2/19/2026 1:57 PM, Krzysztof Kozlowski wrote:
>>>> On 19/02/2026 06:38, Neeraj Soni wrote:
>>>>>>>  
>>>>>>> +  - if:
>>>>>>> +      required:
>>>>>>> +        - qcom,ice
>>>>>>> +    then:
>>>>>>> +      properties:
>>>>>>> +        reg-names:
>>>>>>> +          not:
>>>>>>> +            contains:
>>>>>>> +              const: ice
>>>>>>
>>>>>> And reg is still 4? This is not correct syntax. You need to define
>>>>>> proper and final constraints per each device. I would write example, but
>>>>>> why... more things you could just ignore.
>>>>>>
>>>>> I had included changes for reg in v3:
>>>>> https://lore.kernel.org/all/20260206112053.3287756-2-neeraj.soni@oss.qualcomm.com/
>>>>>
>>>>> but those were not reviewed so i assume them to be incorrect and dropped it.
>>>>> Will fix this in next patch and post.
>>>>>
>>>> Patch v3 was also not correct, because SDHCI v5 devices should have 1 or
>>>> 2 entries, not 1-3 as previous patch said.
>>>>
>>> This is not clear to me. Here:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml#n80
>>> it says the entries should be 1-4 and there are no v5 specific constraints.
>>
>> There are, just scroll.
> 
> Here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml#n212
> 
Yes i had looked at this but, as i understand, this constraints the minItems: not the
maxItems: and in your comment here:

https://lore.kernel.org/all/21a87714-cd11-4217-a2aa-82fddc3a8530@kernel.org/

you expect v5 entries to be constrained to 1-2 and not 1-3. So, as i understand from here:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml#n78

the v5 can have 1-4 entries without "qcom,ice" and 1-3 with it which is what i had posted.
 
>>
>>> So i made it 1-3 while adding qcom-ice constraint.
>>>
>>
>>
>> Best regards,
>> Krzysztof
> 
> 
> Best regards,
> Krzysztof
> 
