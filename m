Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C023B367298
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787822; cv=none; b=eh1DtrZejmKXjf5afIw5Tatzf/0sp45MA7zrxKgZ+892gWaUnmsFqrURGLo1JemXhCJ20ewS1q/SxKam6A2+2jAxCHCkzUFvTSvixPneWSvfqZdNxu3kjq5JWjukbQRcvjNMpRulHwpSAMobhPSFb/zzqQ1OTccbJufbiyVC3SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787822; c=relaxed/simple;
	bh=PSCZlzz5fjxTGq9uKR6wX0C/ymeqII0/PUc/wexBbHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFV3qzmqUjQWdPjAq910xNG7O5dXQUyzw1p8v0rj7evhnqJ3r4B5NpSl2jvcgxYuVXa+APAtWN6Iu3DUP06IyXTQHjtQVRcHSeBTR4BERiBtMOBY0Ad3JnSeEIqnJYBo9p9ZE929Y9Ku5WzHuN6fzLfTB/Y7yVES8Tu75obRx5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AsXDiPjm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dfXWJ7bM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AsXDiPjm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dfXWJ7bM"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ICuWf21638869
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 13:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B7JX5X2XTD4Cde3MxSmPYTnPXo33idXZtjiWq+3lvLA=; b=AsXDiPjm/cJN4pZl
	RdSpC7JwGwSCoWCLzG/B6XJfdw0jsEwluMJtdPBCO7BR1CeHBLRRcJoOawvbkGtA
	PTlQQBA4OQ+s+Oe8uA8cu8Is57MrIYpst1KglQE8+j115BcqhHO9cxU9TtBCyTSg
	nN1qmb3ySMkYFpWPi5wd4yi/GdM7vRtbM4caAbqz4WsFuuDDiG4nafF+xTUdIwU5
	mrsrplcD53iSG49rxOW839guDzA1/hwZbNqtSJF115qQKjaNlVJeiuKP2MFd3dki
	SaxgB0FujY/xEYTQEuEQFkY2aUIT++WiiMREwRO/CwYAT+UKehbchoZ1F9Hefl1u
	jn8ASg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev1rtuacv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 13:03:40 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-48779bb8b39so238973b6e.0
        for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 06:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781787820; x=1782392620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7JX5X2XTD4Cde3MxSmPYTnPXo33idXZtjiWq+3lvLA=;
        b=dfXWJ7bMgUbJcldIz3vq07I74EpPN2vmTdmK7m/GTtcLvhsPQJ+TLE0C/FTxG78pC6
         9sTmQAh9pUctk2vxWuomYl5g0RuhZQ1nGdg57rkN12TUxrdCGWv/FU+v2V50nGHup7Sl
         bTcylULNu+O/EvjwvCwtvwHjJcWxG0RtD7UQXaEYkFI9gnZ4ppr2Oe9JMLvO13fodhP+
         t3ffNfcJsOwen9ChyB/EEt9TdwwT5kMZofv9Walc5iInxUPblLrsWYBXe3z1kBePSeaE
         3LH5sGAqxem5znxQJ/xpFotdZ7Wid1SzR0ordH8dnzR8Y4WW++SqoHOkKD7M1oQcBtPj
         Rx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781787820; x=1782392620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7JX5X2XTD4Cde3MxSmPYTnPXo33idXZtjiWq+3lvLA=;
        b=Q3xe//QCRpVgBziyaeA+HE002d/NVpMTr7QcZ1w0iuNsOywMkKovPQPfX36nn69xAr
         nRt8m6E3d3AAPvuYv2gev8dB3iRHut3l9PxlB7KN4TgVpQAboDDDQ0eqaZp1Gyvk3sbW
         EQ5AJJxlDtvs0mJcMthCQ/yHgtHQ3TRjhvZ+jygWj7kbpUtiQqNT2jcaeoPYyn1o249e
         br+sHrW2+dM3GE8/4xP3PKdYYBqev4hjiBT4DBsiSSBANg15xU7MjohxcFbs2oPOhjFE
         8uRZz3xP8S2oFv6qBnOX5C/s1ccBZhtz95fQ7+2Q3JHP9c0XGlLA5LsDWALd5/pbz1op
         Oblw==
X-Forwarded-Encrypted: i=1; AFNElJ8u4q4xiePQfZxc4xz9Q+avbuWv5kzj5MyvUxae49whBVGJwknC6Ep4Pra5LzzuH6w84sEBokZGeK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAkOpNx3PhJ7OXbCfAtaQZH7udGCEJE+25kf/FuRY9z0BgS/pQ
	9+qpJUJvfzIQlRAgGyhrCyQx7r2QosNA2IkfcSFeB5xCwXbRYJ1vBpw+8cLAolo87R7M6mgm2ed
	4TiXuGPDyUQhfPGYiT+OQtj9hvGtp+61xesjak3QJnHom1owCJDH7HYQDNcDUErA=
X-Gm-Gg: AfdE7cngnQGAfhgkEg7PXlN7v1CBmCVPPk7GPf8Al8x6mwo4tAQs2JHwaNuxISifpoL
	ehdXkaPXsy9frkod1d0Ls40YhuUl0DYfcgxcoPMWKi3NxDpJEmXNpqZcY+pgOEdCODe5hGql8cq
	sjh3i4aWpVasNVyUd1voqFSCwaiuUJPYVY7U7T6eTVj2YYMnJ+/sGTFoH5kvcYDMUKUvuWgMejI
	WzhCwcoFqDfWDYfx4rbg88MMNUTcJQtq3J52qSEMVHrdCxnvcQmVQ6ZQ6qDNHTK7wyH/caH1xqs
	bHGS69BoC32bvQpJxsng7z+mrMPrpmPzqlypBUJGgO1xaXyFxVCUY6raprJIr2lWd1CakkKxoRm
	kcgWnHqKz+1pdYrhfeGkxlNLBpvpcH4Vm/2o=
X-Received: by 2002:a05:6830:43a7:b0:7e6:6f9f:7445 with SMTP id 46e09a7af769-7e90c7497d2mr4384694a34.3.1781787820200;
        Thu, 18 Jun 2026 06:03:40 -0700 (PDT)
X-Received: by 2002:a05:6830:43a7:b0:7e6:6f9f:7445 with SMTP id 46e09a7af769-7e90c7497d2mr4384650a34.3.1781787819765;
        Thu, 18 Jun 2026 06:03:39 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-695836d7e78sm1997961a12.18.2026.06.18.06.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 06:03:38 -0700 (PDT)
Message-ID: <c008fa1f-55e9-41bb-8ef0-8a9d85f2614d@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 15:03:36 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/6] arm64: dts: qcom: kodiak: Add OPP-table for ICE
 UFS and ICE eMMC nodes
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
References: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
 <20260609-enable-ice-clock-scaling-v11-4-1cebc8b3275b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260609-enable-ice-clock-scaling-v11-4-1cebc8b3275b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MNpQXsZl c=1 sm=1 tr=0 ts=6a33ecac cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=-W0wxAWcNmATYll7EfoA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEyMSBTYWx0ZWRfX8HbTiGke1kbU
 S6b7SdQbR2CBYMQXKaUu+8C2S9zYqij+qp3Q8BH4sTIKthbJtpcKz2EC/cYo3wNJ9g127AbFMr5
 ochAdS1kWTzTrzvoINwF0qOeAim7J+nXiWp2xFoi3AbezhhBiJHmqCJKPuQXsOZr9z+GqpBXYrN
 3qEMjVv/JSyf+CTJO2TVnQyRSs/hGElIPYGY+HD3tBJSgrmPq0rgRjX3LL8t2UGQrUKLdt1ecxJ
 HUsCFWtOZQ/aFwushloQrt+/cPf5oGS4velvu19JraV1ocjOMWfujWPB8kzvmMBCpFgJpM3LOUi
 SpsNNu0fBL8+CeNMYyI2Ko6SCnvqtwpzXa4c3aNhhy8p1qZBXQ/ZswiHS5GJPK21StNLjo5Qp3k
 4w6AVlttFP/oW80jsrZ7DSLE+06d+DkiEru7AigaQW0PyyG0dsFN2qGDxA7wFzxVfbgk3Apq4PR
 RninB0aoYGO7nlT286g==
X-Proofpoint-ORIG-GUID: khNDVDdlZyqjcp_Oldt2bk1oplCYRO_5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEyMSBTYWx0ZWRfX4ddNRiguBrqj
 hyC6UZzx2O/6FntPgZfPSD+3t6FuJqAc52WAe5bV3yimosansOtJpeqC2+pQM1CVNH66HLOd/AW
 GHTyZT8mRCvm9pdE5NtD0L65JG008as=
X-Proofpoint-GUID: khNDVDdlZyqjcp_Oldt2bk1oplCYRO_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180121

On 6/8/26 11:47 PM, Abhinaba Rakshit wrote:
> Qualcomm Inline Crypto Engine (ICE) platform driver now, supports
> an optional OPP-table.
> 
> Add OPP-table for ICE UFS and ICE eMMC device nodes for Kodiak
> platform.
> 
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
