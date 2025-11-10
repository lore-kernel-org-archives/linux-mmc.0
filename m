Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF15D2FD1CB
	for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2025 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764517; cv=none; b=u6ncGKR3AaO+o0SNBgEIcFRDLfkftSjMzSsBBpxHBSrqQx5B11zIShBvONW3oisQu5DkzysNM/p6aLKopIc1CxXf6gC1eFwFGK1hgtREzr7Gxe4X0M9QrAPRONUbUdGHKNU+DBOHTL0F6490vZnc7h04iio4BUPnDNF5PsdKcc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764517; c=relaxed/simple;
	bh=laOBFdZdF6kgt1Nl/qfybsoYbD7vZYVLOcK+XoJFrlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoVXPnQMAvn/tGfYyy03kVSZmvDNSu8H6ezD6BgTJm/9U/cComrQPKX7ECwtYxtFBh3fk5sllejdGKho6GPyI+ExglNI3wPkjaJpYiln7AquJ8Ymo2BNjLgD8lcu3GvYdMVjpkeQ9Aez2S5PQmzQ4WhONWduwjy3tpBjEcXRfX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m+Z3Lf1G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZZvxji+y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m+Z3Lf1G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZZvxji+y"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA6SLFB2407319
	for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2025 08:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	np8BFd2leJr9qp9c1WrvYL7Km/AP9ghIZ2N7cPw8mDY=; b=m+Z3Lf1GIEjWZ4tK
	bQ0BeYSlUfphMJmp7pY26yG1u3b0SLaCuKFIB4//xs4/SJJ8XYJ/2ltqMjQY7JnT
	SfBdnsLSDj/l/3flDQQEFOudY6sssOWhE5kVIcFxqsRGIiaVYdABfKb6fTBiq1AN
	kIwF9hZ5NvQ7FhMEueUsHhxTA1Grg9H54cTehRO5HQ6/3bgvKaPRE6yfyKadcStF
	ljoNmumLR6vIUzaFzEcRqN1Ecp8XyJ8ZTchoJFViY22a6/FbBuzVFyXAogecfd0V
	L6u+FtI8kLIJX08p5Xaw9FNNsz1xk3Pij1fgHbKpdIE6//EN8adVVntdiqVK6Yam
	607zhA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abatd8c70-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2025 08:48:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297df5c10ffso9565255ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2025 00:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762764514; x=1763369314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=np8BFd2leJr9qp9c1WrvYL7Km/AP9ghIZ2N7cPw8mDY=;
        b=ZZvxji+y/8sR+S6VfL9onAH1MUqUa5ZH/pNYZntxUKlRa7FzLfiK+veitL+cY5rAwb
         d4cLw64/8jxh1V43afa3n9XFd5dkWg4MAfbQp8JT6eHrmC/1dfePYq2adc4UKBVJOthB
         jHTKzOwqxzNgJx/IsBPUfnfT+N9L2UvAvbVdtiXyYjvgRH1lRIvt85pOjDy3oGQwiQ9V
         amVEWc0lqBjbEMnb8ZWHQWebVIyWzNb2jOS6wzOwa/2f4InTSSxIVxJb2czcqkZQFI9w
         3HPUGsK37ruENWJbyeBVExbMU7zLWzcIlWRHy51SUXAli+2NPHD8RobUtAX6LOwY/8nz
         AjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762764514; x=1763369314;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=np8BFd2leJr9qp9c1WrvYL7Km/AP9ghIZ2N7cPw8mDY=;
        b=oG4CI134AxwBBS0ODi7TaxVcbJ6KqbcoSYSMHaLy/pAjEHITncKtmKYQZpz/i9QS1g
         mzFFxFE+sYBWxaWOXp/+wpswwLATFB3vBiVIVLt62cajyMOnrZjG8fxNyUZoC+NP9VYa
         GhmcPelbx7JqhsAGvx8CyJzLbeyizVvvkosu+EhhtKPDH7mYaw9lSVXE2ckFm7llI45l
         53I/7O+FZNPrE8WK+v09fsj7IsomdlCdtfg2/q+Y2dJQIHWn14tI9fu/yAldbkKCNQLy
         RbRuyksdzcmTq7NVI9+hVs9T0g5V04b3vyXksTQXBXZaOBDRaVd1iaP4zzYQMXc7IHoa
         vl3w==
X-Gm-Message-State: AOJu0YzgNWuAL7O1fORQgchjMw7iE62p6YVyjTzjTfw7/eLhQFQt4UfB
	394JpRcmrn4zkYvN8GNsPk0zakszWTB6MqdGBpfGwW8os79tK5byzzqwuR8RT1OVCtTsStv77Jd
	f4UmjVOtGZlBkoykvDRv7peiyjFUgYcouhSYVzeNhBY39rs8TAJFU42gdRoOEsQ==
X-Gm-Gg: ASbGnctZ3Rl4SPPdHRGXXJlba18Ze61c57Op9AfnJPpkWJRZ0dAzavpcmd3cSvll8JF
	4cZS20oPLZSRO1joLNwCakTYOVybX1osTfJPAE5VzGXKa34ZxZ+jf//HbzRdLI9qy4Q+j6x1YJR
	hkcExhHreUkH2AtgopvOeJDiOcGzBEh7dnb+3OJ2+G5MsRBOSXH/apR4JKPaQwqZc4xvKLge9/q
	u/ea10toGYsLKM1joUr76hW+4xnsBkPANVz0N/B2MmFZzc0A9b3BekXAO4LFU/MCvt8gRGtwB0u
	j5kfWOOeQ3pQZLKOHR4FcL7w2kHsuHc0xjJbpxWZZhgN4rdpfbrz7rpDYQnYr95Mk/bpXV3jtrg
	FjS9TTuI9bTtwonqZ/sXh3TGO0Vmv
X-Received: by 2002:a05:6a20:9188:b0:334:946c:8ef4 with SMTP id adf61e73a8af0-353a2f3d9c7mr4957160637.6.1762764514267;
        Mon, 10 Nov 2025 00:48:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYN++oAFbO2ZWEA5lhEp/eZEf4Ohql2dsdu6uheNC/E3zbINXVL4iwByQ7NReQxBPEV/6kPA==
X-Received: by 2002:a05:6a20:9188:b0:334:946c:8ef4 with SMTP id adf61e73a8af0-353a2f3d9c7mr4957139637.6.1762764513730;
        Mon, 10 Nov 2025 00:48:33 -0800 (PST)
Received: from [10.217.216.168] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffd3f6easm12380935a12.21.2025.11.10.00.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 00:48:33 -0800 (PST)
Message-ID: <1765edf6-cacc-4829-9ac6-2b9dd98ccc40@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 14:18:28 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/4] arm64: dts: qcom: sm8750-qrd: Add SDC2 node for
 sm8750 qrd board
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
 <20251026111746.3195861-5-sarthak.garg@oss.qualcomm.com>
 <99f951e8-b6e8-4b92-b55b-341a2f3f070a@kernel.org>
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
In-Reply-To: <99f951e8-b6e8-4b92-b55b-341a2f3f070a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: i3chkQjTosMPQwHgtE2ERTIdkOgeqmI8
X-Authority-Analysis: v=2.4 cv=eZowvrEH c=1 sm=1 tr=0 ts=6911a6e2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=nosftV4G4FSUV_QDBQQA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: i3chkQjTosMPQwHgtE2ERTIdkOgeqmI8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA3NyBTYWx0ZWRfXxPX8ZnsHWgMR
 9jzJE7pJ8Z2IRJ7fyaDXlONlV/Lo5ter85LnJkmh4q6j0YrfKuB2zBJBeJTfSc1vvPdOyONS38m
 IMow/A3qPs2L+POIhlnJ9LBqd5nqGNv4secuLc4hLta3Ya4ff7SMxl4r9MUJ9DC04QQs65PfioN
 XtXvs/3qd+xua6GlRpWpwmh0Akw/S8dkNpbLekqqe1VJTwWlbkmu0xs1UCgjklxIhG6rYK7Z1sy
 Qe4aEhW9YjR2cOuyJj0yvXB4OQ3n1H5ZsBuK1fV2ceonUd5mIBfpdmmD4aTlQoUNl9XkuIQdrWy
 MfUtmOca1mWHvg9dTlAAKN/XNJ5VasyPO/NqUeLzYeHm+JjTqE82C/4IVYKamJ5rjJZ8n1j9tCp
 mdCJRw64pG5DS61eIQJ3a1uugSNTnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100077


On 10/27/2025 8:04 PM, Krzysztof Kozlowski wrote:
> On 26/10/2025 12:17, Sarthak Garg wrote:
>> Enable SD Card host controller for sm8750 qrd board.
>>
>> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
>> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>> index 13c7b9664c89..c2ab39744a0c 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>> @@ -1031,6 +1031,29 @@ wcd_default: wcd-reset-n-active-state {
>>   		bias-disable;
>>   		output-low;
>>   	};
>> +
>> +	sdc2_card_det_n: sd-card-det-n-state {
>> +		pins = "gpio55";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-up;
>> +	};
>> +};
>> +
>> +&sdhc_2 {
>
> That's random order. Please follow the order as expressed in DTS coding
> style. This file already has broken Qualcomm style, but you do not have
> to bring additional mistakes.
>
> Best regards,
> Krzysztof


Sure will update in V4.


