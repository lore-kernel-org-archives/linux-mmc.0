Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D04C2FCC06
	for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2025 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764488; cv=none; b=aoiJWjYRVOZ3rbLE/3HvsfJ5454iy+la9TIBuaQJ0iCV/qGWI73k8HzBv9aIn6yQ/hO8Z5ZpY0MInAOdMPQR9HjI7A2x3HZOfJa2J2MZd1nJEtdG3J7GjyVF6AFmgyu4Z+hokmFjKJCtvEd+O2V8SzZewbciyMo8ibGWro8ZCcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764488; c=relaxed/simple;
	bh=/09ubiYSvNP90owkjG7kLk/4oieQ68xZfw/hAWa8hFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6NZy2QBwFpl7w99y02ZcfznldanvoKERoBP+DfQrWQM1Z/4ch0z4Ss4sO8zubcdBY5mBLhAldiw2pDaU8KGm5TNW8rOVDBHkvrj28gxiLSorH0t8ZUukKse5F6ULQabSRj2sXD0KlOY08q6bapOOZ89lxHuP04EXID9OeqvePk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IIMGygyt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XfnyEdFI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IIMGygyt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XfnyEdFI"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA6SSPc2407879
	for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2025 08:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9nGxk6cvPgoYAgcOQslEIVapMqVsIaVsOVTbE/MMoYI=; b=IIMGygytKwBRvUW4
	cm3BTV4joWjcSyVupv4d9kQFRR3EVVUJ45SEybdi6dtIC28cCnn4+jszUlJ75LDR
	qt89aafLAXMXV67TIe0V68Nvuc5NULOzfXgaXgU3azJifI6EjwEas8dtzqZNpvQx
	oodL80rpT8N4FFso0SCrTC+tVcuKg7jnRoI4KPh+eO7bcuTcccmA2yGBisaksVT8
	DQNHUtnZGsviCL3wN+z0HT5wHATiEQWolLvG12KypRZJrNYb5lK3cykTP1bpqT4J
	UeCY/j6DEEpp1D+7LLYipGwFGogsmXFvLJP27q2TF9UisysqoI95mvU43JuQQtuO
	SVurYA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abatd8c4h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2025 08:48:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34361263b93so449565a91.2
        for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2025 00:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762764484; x=1763369284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9nGxk6cvPgoYAgcOQslEIVapMqVsIaVsOVTbE/MMoYI=;
        b=XfnyEdFIhM24kL0SJiLbHgLY4GkxXA+NqrXO1YqAmi2T79n2s+zQRFKm9D5n91p6MG
         S7ztCZttB0t1D5WgKSI1pu+K1C1dqMpWTkI+V6Sa3k9Wf3zSfymUfynO40SIFiku4NDa
         oh7yqmQTm1mwiraNoxdBIa9vcSl6ma03EZchWNxsrvQKFSM0NmsBS208F6NxH1o55jQw
         WJYzJKQP7U+4GaFltf4LrlQl5WWs+7hxWDwRWIFXLZNgQhZcKaiLX6HZyYw83c2SzlyM
         mes7KbSRy/snBLuDG1VhPpPSRn0Dd4KirxaYyZbbKxQY7RmLogear5bg7XOmsPBcSRov
         grjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762764484; x=1763369284;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nGxk6cvPgoYAgcOQslEIVapMqVsIaVsOVTbE/MMoYI=;
        b=eGUlvV6i6kqnPAlmp3FDpz3lzd0YhUiTQIa++yKs935G5APoA1WihjtLpXV4/cBEl0
         F2JPcHvRG6vfZ6/sowbQKXC9uDxs6AZIlmhEpbzx+GY8xgKbflVrm5QCQ4m3WvuPPID+
         33rl00pc8N8YRuxibNKDvOXqO18/nMomU9Fma4ke5jYaRYbWvOxxvWUrekoKjUov8QDX
         e4Df+A4bNge0Zi+6DtGZsBUtQFDDgPPc+f5yJXFnMInY5IL8RhVLRUy3t8Eg6gM+8NT3
         zEY27DPkuvdYn4N/t0SfPC3Owzc4q9EKze9KynZbdgB6JJm2+Fe6Ja1A0N1xroHmjlAT
         ppbQ==
X-Gm-Message-State: AOJu0Yw+lCKaA6avfQBgvninnnsRf5TEw61SEjxiBjIihuGvpxDCMt+Y
	w84uE7JJgLthZZL1lKRmnrNHRIuTkvGPO3//Dtu1fD5iYUULU14NU9UxgmNZ1T4h2oMqkcgcQZF
	CYsxhVL93FhyPShKZwAXU8UGo4f368gNCg6L5s6/sUsTZGZmUAaexibcd9cv0mg==
X-Gm-Gg: ASbGncvgNqMqkYWiiLKEsV7fX8RdaNr7Re83IWVw5Om+W8qR9LvRemoMhAP+rDgbpwy
	nXnDCBJq0eg2auD4/glOGlyGdCdHJbiLjdiTI/AM1UlbegzQxJ9xCVvH8zqWTKW5hfoCcA1Ry3j
	kAX4zdkKmBlLD2pZPS3Ylg10TQJzNx38Df45fCf9nIju5dnHMWtLPVqsuleS/Mizg31RpUhcj4/
	lrTfPd1ONKjJSQQM++M6vLLUSF7aPFw3bbRrEjAeWGYINHt6Qbvx9p++cwd7G85rKGDO/cFA9Jv
	ezFqE9CmdAv48tHZrsIl5Nqyp4VavlI88a0ONTYtyDp243oDDcytPHrzx98ldMAvN7shYrIvW+r
	g7S0RXkCQLSrRIOL1ck+M5FbSpCI4
X-Received: by 2002:a17:90b:3b84:b0:341:124f:4745 with SMTP id 98e67ed59e1d1-3436cd09f90mr4674123a91.6.1762764484005;
        Mon, 10 Nov 2025 00:48:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJwIzD534772Ry6R4QdPTmPOBMOUdlbjY/PmzhZ8/CXG+4tHCfvMhyh5bIkeKoYzMjfqRUww==
X-Received: by 2002:a17:90b:3b84:b0:341:124f:4745 with SMTP id 98e67ed59e1d1-3436cd09f90mr4674108a91.6.1762764483412;
        Mon, 10 Nov 2025 00:48:03 -0800 (PST)
Received: from [10.217.216.168] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffd3f6easm12380935a12.21.2025.11.10.00.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 00:48:02 -0800 (PST)
Message-ID: <74123422-637b-4209-96c1-81167e51df36@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 14:17:55 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/4] arm64: dts: qcom: sm8750-mtp: Add SDC2 node for
 sm8750 mtp board
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Abel Vesa <abel.vesa@linaro.org>
References: <20251026111746.3195861-1-sarthak.garg@oss.qualcomm.com>
 <20251026111746.3195861-4-sarthak.garg@oss.qualcomm.com>
 <4394142b-c96c-464e-9e12-80904755026e@kernel.org>
 <ccce6ac2-c744-4b94-abca-f5710c712bc3@kernel.org>
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
In-Reply-To: <ccce6ac2-c744-4b94-abca-f5710c712bc3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MPhZGPhmuELl5xnMz0YqS_AS47MCiRlI
X-Authority-Analysis: v=2.4 cv=eZowvrEH c=1 sm=1 tr=0 ts=6911a6c4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=QHloIlzF21OiCPf7oj4A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MPhZGPhmuELl5xnMz0YqS_AS47MCiRlI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA3NyBTYWx0ZWRfX14r8132JkgE/
 fKQf+ZpVX33tUgorSvx8m2HjcC9GIPkZKAH7hKMOiro4rPplRLIRPDmTWuJ6S0p4912bsSbSFp4
 5Y5OYswl4PI1KSLmsgpA25qrzTfnTJWyqcb5XmVAWA9NqpDmJNUcR4V4MkVZUtIQcl3j8T9RQFR
 jIYWSRk1GpKKqmhWnHwp61bH4P/Chb9crI+APO5Gky0TyiWIU8aDsVr2Lu3KwehCNayQPHag7dS
 fqRIFwp/2a7IaIkCuNUw1Pi3/XxRkQciJNDoqgeH9l4S+LT2c8IZfv/ry1ulMzSyRwSrxYeck3Y
 qdATC4Mxp47T2L4I7jeD9otYnToWShJ2/Jf0tZ06nRzEMNwTlDoygrUCIl2UB0jzVfUxsCC9YZd
 PgWs4xYXa5FVqk4LLVbS/V9wN8YOYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100077


On 10/27/2025 8:03 PM, Krzysztof Kozlowski wrote:
> On 27/10/2025 15:31, Krzysztof Kozlowski wrote:
>> On 26/10/2025 12:17, Sarthak Garg wrote:
>>> Enable SD Card host controller for sm8750 mtp board.
>>>
>>> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
>>> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 23 +++++++++++++++++++++++
>>>   1 file changed, 23 insertions(+)
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Actually un-reviewed. Here also ordering is broken. Please follow
> Qualcomm style for ordering properties.
>
> Best regards,
> Krzysztof


Sure will update in V4.


