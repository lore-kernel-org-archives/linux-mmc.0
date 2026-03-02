Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019AC54774
	for <linux-mmc@vger.kernel.org>; Mon,  2 Mar 2026 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772437553; cv=none; b=sB4rrYzLTQzJs4X4JyAac6gETf28yi2c3dBcYVEDWRm1Ai4HHVo8IvyalZR/zAz4WH8iv2SzozU5FFZlnglECQLNpmITuKu9h/UVcPg6gG7fzTKbzXW4OAPTwib3BlPk002gkCqtALTxZp4560XI88+UdBTrcGkB3pCJIghYZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772437553; c=relaxed/simple;
	bh=ZXhMoIY/mByUSep8LfZAL5/GlLaEI2/1amRcCgonReo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rvuDVCVNQTGX//O4KHSbJ9It6GWUJ5Fe3fxekfkE9pOqFX79GpI3bPB6qHXTklLSbW4RDaBVqZOdYsivJHten1gk4vJptQbhn6LMNJ4td3kcL3JbfHWK5g0S+hBgwDqKmI+iodEg5TGfmp1t4x71XuEP/huYie7BOlyppyZ8nw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IdfBxTNl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UFAiN2L3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IdfBxTNl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UFAiN2L3"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6226hhqe3002850
	for <linux-mmc@vger.kernel.org>; Mon, 2 Mar 2026 07:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TvdWl2qshnFrh34xKMqFLyy9RImD0NVQXZ6JouBga2c=; b=IdfBxTNlSd2cDNkn
	R8QPD2LxwBvJmQO157JvOF/zRsQotEX2wJXAWBYlLe5EJbDWQAs7C+4VdgwJoGjb
	7lx3G0EgfKvp7aMKsm5DNJStrGfn32hIF0qed5KB8SReWWzzQJtnJZFPlIF1RhAc
	ZVSHo9I4cLXAOkAmtGzTjz9IjXVaBp5857dyIBMtAtdF1P4NQ+2H8mcAam0k44uM
	rqa9z1NaqVl8L7Fs2VFIugricbPppkK91KrRXbuIgpf9OP+K3UmBy08oSB0Y/pQx
	ZrPzic7z914PLo+/wQpBvi/Qy3eKNi/aoJI4MtpLDEs1PcNBODEpojovPdctZxI0
	RBhJPQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckshcmmm9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 02 Mar 2026 07:45:51 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82743548918so3176958b3a.2
        for <linux-mmc@vger.kernel.org>; Sun, 01 Mar 2026 23:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772437550; x=1773042350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvdWl2qshnFrh34xKMqFLyy9RImD0NVQXZ6JouBga2c=;
        b=UFAiN2L3xQZGb6G6C4bOn+UtoFJtjWPOBYEzVxNsnB80xNp8OOoGEtjFXbti7WAJrE
         hnXdRySbbmMX2qvWp5XhzD3JC1k4YG1q17JlXuRHNlUAiqIGl89H3JlQhuZbn3GWLK6Q
         98ChMBMCVguq0OzJ/t1dSUEFXistUoSxoCT+gXZYh6q3TiUmBlltO3MoCz0tuUqxTURw
         WoDezXlpGReIN/NoM563l2J7//VGz788uixj56FFDBCpmLg6C3Pw8ox5rMDU6LUC+tzD
         v/pvMpzq51aeQBhHnutYuJ97lWNKZOkHI3swvBLFRTaOPkXykD0hWFyxuSNKPKgJ1pSJ
         Y6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772437550; x=1773042350;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvdWl2qshnFrh34xKMqFLyy9RImD0NVQXZ6JouBga2c=;
        b=esQ7HhZBpy+8iD23lCl8Eq91vP3dRyFtltU6aa7UDXZGclqNvanQ9fBj7BY0J+F229
         yNm1nZEe4EPyJdMI4FgJ+bvuiKGP6Rpr7IxE+CKDBzcX/wYdEVLtiEKlHj7XYDm6oMJn
         BRBu9mbF8r1h6KWVBQFz6hLpbL4Ysa2DJW6oRI6wS4c2EfB9CnZYIgmERY+CpWElWezK
         W2S05OTIZsbbZDKi46bRnhtPQPPwaGK2blgGHv31zTbyrCzLL8wegBlRuEBZdVSk/xUi
         bp9OZQlbRhqffYpYiiNDLnuFVAjxugKTcfEfsfMJZ2NI1PER6WTqvKLWz1vqCStedHVA
         J5Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXmUd9Lh8MyTKbqlVxfhYs+WNX2vnIUkqtBDtm7SVix8tfLTU5TI70wSfnyVw/HMihPZaNOaTKSas4=@vger.kernel.org
X-Gm-Message-State: AOJu0YylJk4JYcRzqZlT0HEbDuPuzNgIV4KzkSgU8AtBHy1ukcrlArgf
	c4tL3QVzXxCeKf6I4v9CzFU1B5BrkbKIFAUheoIg5bQp+GbyUZ6qxZjAUZ3sKQIFLgu8rZjO0vz
	CElMiDerviwML78jqvaKia9eUecfjxkR7uIE0/sqVmLyh+Lah9eoXURs9j0KlhHE=
X-Gm-Gg: ATEYQzzAXaoKNku2SJuVia+Wsi/zwu9Ounz2J5rkzieOj/ztKo1jUhHDwJtZzoeM5Ng
	JpwTmAarpmerjjioAxRyhmIm1ks0xjWgkOKY5v7EvW5VBxLetB+EO1gHq3FsOp4QxJJ8AMz1U1W
	YDObSuQwNOdm7jKJ92yhek6zVyGVxsq5wiJtKNPq0xLkOM9ogi8fa4jZvoceXwLSxgYdQkJCjEL
	0GSqGDDI16YSxgr2wp3ipbdSuOM1Pwl7EDEb8Y9IfBdzZTJW3oHPBQUiG7WBojw4MOjHFn2Tujx
	UxewfQk7mMbQ1xlENQS5pYJT+S16KtBHxNKIHb25e67D0jVzx0Gtl0u1XtIsvGfGaZoTWInnqlP
	qX78UV+n3VkpaK3Kp99EnyKvF65Wb7u47Phgm13g6xZCloKoOPA==
X-Received: by 2002:a05:6a00:ad86:b0:827:282e:cb1d with SMTP id d2e1a72fcca58-8274da24aa9mr8591361b3a.66.1772437550547;
        Sun, 01 Mar 2026 23:45:50 -0800 (PST)
X-Received: by 2002:a05:6a00:ad86:b0:827:282e:cb1d with SMTP id d2e1a72fcca58-8274da24aa9mr8591346b3a.66.1772437550071;
        Sun, 01 Mar 2026 23:45:50 -0800 (PST)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d87e78sm14474046b3a.17.2026.03.01.23.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 23:45:49 -0800 (PST)
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
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <544925d0-cf32-6b2a-548e-d6f7cc517581@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 13:15:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <21a87714-cd11-4217-a2aa-82fddc3a8530@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -sDzfrMkvWtWjjaedl33OmBdQIVANbs8
X-Proofpoint-GUID: -sDzfrMkvWtWjjaedl33OmBdQIVANbs8
X-Authority-Analysis: v=2.4 cv=SO9PlevH c=1 sm=1 tr=0 ts=69a5402f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ySAB8p-ER1aEGw4GsmcA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA2NyBTYWx0ZWRfXypCJ8+PwXhb9
 wyC1FF6Wv1XjfKJ6w4tJHg2LELpoYaGOxl1yoa6gg+I6MBHkgsbEFHa6LQDOJw7e0Gn8kBi66lU
 UkIbZMzdgSkltMU6LbfSpMbZW3aal0kobuWj6yc45Z1Rhw51UhkeicyfRypJOUdgNQ2oPw+R9iE
 ipFoNESPKohWwNAB1oi2iYhJS/6nZkklOiRV8iRnC9tsEo6TKOutxGo9wTrzRTZsOj6swixY+vJ
 b28BumnliAm+BcoLqLBq9yok6xZ8xURnnqx931r9Avbgjss72gQwiwrRu9e/VxuS+cdFV1H9Nv3
 FKv4+ZuBTn5oQsEJxfHuYuQjuJ29JMyti9hJIhqwY3Enp/sJULzGDJug3QAmkjuz/FDJG0tceAW
 WK6ZvnHQTXFWbGlcDLDDdOhDSj7GEe3c1ga37Etqb921Nn7X7GezP/I+NX03aHC6Qb1JYAgXdNA
 o0V17C6iIPVwiDq+lEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020067



On 2/19/2026 1:57 PM, Krzysztof Kozlowski wrote:
> On 19/02/2026 06:38, Neeraj Soni wrote:
>>>>  
>>>> +  - if:
>>>> +      required:
>>>> +        - qcom,ice
>>>> +    then:
>>>> +      properties:
>>>> +        reg-names:
>>>> +          not:
>>>> +            contains:
>>>> +              const: ice
>>>
>>> And reg is still 4? This is not correct syntax. You need to define
>>> proper and final constraints per each device. I would write example, but
>>> why... more things you could just ignore.
>>>
>> I had included changes for reg in v3:
>> https://lore.kernel.org/all/20260206112053.3287756-2-neeraj.soni@oss.qualcomm.com/
>>
>> but those were not reviewed so i assume them to be incorrect and dropped it.
>> Will fix this in next patch and post.
>>
> Patch v3 was also not correct, because SDHCI v5 devices should have 1 or
> 2 entries, not 1-3 as previous patch said.
> 
This is not clear to me. Here:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml#n80
it says the entries should be 1-4 and there are no v5 specific constraints.
So i made it 1-3 while adding qcom-ice constraint.

> You need to embed the ifs:
> 
> 189   - if:
> 190       properties:
> 191         compatible:
> 192           contains:
> 193             enum:
> 194               - qcom,sdhci-msm-v4
> 195     then:
> 
> here you add one more if:
> 
Acked. Will add in next patch.

> 196       properties:
> 197         reg:
> 
> 
> 198           minItems: 2
> 199           items:
> 200             - description: Host controller register map
> 201             - description: SD Core register map
> 202             - description: CQE register map
> 203             - description: Inline Crypto Engine register map
> 204         reg-names:
> 205           minItems: 2
> 206           items:
> 207             - const: hc
> 208             - const: core
> 209             - const: cqhci
> 210             - const: ice
> 211     else:
> 
> and here as well.
> 
Acked. Will add in next patch.

> 212       properties:
> 213         reg:
> 214           minItems: 1
> 215           items:
> 216             - description: Host controller register map
> 217             - description: CQE register map
> 218             - description: Inline Crypto Engine register map
> 219         reg-names:
> 220           minItems: 1
> 221           items:
> 222             - const: hc
> 223             - const: cqhci
> 224             - const: ice
> 
> At least that's the simplest solution I see now.
> 
> Best regards,
> Krzysztof
> 
Regards,
Neeraj
