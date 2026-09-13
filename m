Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0714357D07
	for <linux-mmc@vger.kernel.org>; Sun, 13 Sep 2026 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789312857; cv=none; b=ugqtPVXa8AQIt26TIuNUPuKP51SZExQxyEYendD89Ql4wqxjuSvlA8dN0vcgv8+MHg53BuWGDY32kcnxOo9LzuuqHMwQxQRUd3WDXVyh4vQRDUYXU5ZuYnGZNU/Gmc26EPCVyEAUcM9dZBtWJlw5GopO4G3cFNnonfXg7HvIUuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789312857; c=relaxed/simple;
	bh=t6s/awq4RoqBFyOqvzNKS/rkyBda1l+Yp9s4hTmPxgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOADNggfGMIQ9QUIVBZkCPY+dvHuuXpgpxK+rviXK7C4nGPtNg41FbN+n9RLk1Cd9OuNdgYIdyThkvrcq+Qj6WFztHHznI4XnxD0LxgmAONUSHTSYH6NM/qoH+wbRpT49CefB1oczwAQVc72GNujZa3WnOD/P6Cb9FDrFeApUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ESO4Uu9h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GVyl2CEU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ESO4Uu9h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GVyl2CEU"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DDxvtT1897454
	for <linux-mmc@vger.kernel.org>; Sun, 13 Sep 2026 15:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t6s/awq4RoqBFyOqvzNKS/rkyBda1l+Yp9s4hTmPxgk=; b=ESO4Uu9h2cfPvt6d
	Eu5FFCSNztSvxXt70SCxpeGJI9tEVzTKu3mHfycBSkZ/Ll9bNNhwqHRXIOep8SlR
	gXkvYTyyWSoCQzrBQZPltKc8mDKGz6rqTo1Ukyd2HKRs/JwCLJg04X114sT3TxAr
	A6ZAYdtHXcLQ5hkwBBhC2/WuOoT9baNM0JFmITwUnA8QU4wIvVciegvIW8hmiX5i
	rlWV/8xv8OWe90rXbaKzvOSRtUnqhbXOw6TyqdN5squYvTFBt5cqKXB6NDFsEFyR
	Z/AAnTZJKsXatujA+h1kIrzWgI4hiqfBPdgeSMxpGZMHH+PMt3DGMTeReBoh/ok9
	s+c1vg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c3j01-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 13 Sep 2026 15:20:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cec4226c70so31625135ad.1
        for <linux-mmc@vger.kernel.org>; Sun, 13 Sep 2026 08:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789312853; x=1789917653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t6s/awq4RoqBFyOqvzNKS/rkyBda1l+Yp9s4hTmPxgk=;
        b=GVyl2CEUU9k5aUZO/CfI2gOTNAOk6I+8GhZNjXHXNDppgodTCPQ5RC0drusRz5thCG
         IcpEC2brw9vvj86TPl7B/2VOjP1sP3Jgy9ZpGoXGDJoce79c2t5QPriGtoNAhaiQdDso
         lSDMyPa4258YcVOw9m02ltOj2BA1x3CF+Y7M+5IfQQ7eyAQkPGcwpLLIFGhfVIbQOS2Y
         4mtpjDbJ7qNJwyclQB+zGPF8vlvW4SgGx+g1MK4AS2Jwjj4nvLDJ0vzpALZUaXAFyF6P
         7c5CiGBDlpcoAuEl2ForipZ5Q/zolIvhRw+SZHY3INzGPDoXP3OP/W135o+sG0htfNx9
         d/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789312853; x=1789917653;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t6s/awq4RoqBFyOqvzNKS/rkyBda1l+Yp9s4hTmPxgk=;
        b=otmyRnxaQQ7AH4PsDPtFxXHax4QhWdpkQ7EDY2G16dFa9lMIEvfZ6/gG4oKrXu+CR2
         EtIQRDqky9RY4jZF8fCZP4L9uXT7jiik9UXUaTnW1qHNtVpaGjM0aJYKjvMNAvE54fbL
         87DPqFUFS8JK1dyFM28JG1HRC+sYXFWKZpkN7VXTO/RqZ8tXaJ8wICMD5f/leYbFKENb
         npnbbVy6SXreNcibj65eRNjJoeKePJ0VUASHy5Q14RdHOJiVPimHiDFf3fZ9DINQtAS/
         HLesTxXxMxY6lQngjckCHqi7aWstGWT8lBuk4zSQS4kkuaRPoBsHkQxHPjFjzC8G+fZW
         /8rw==
X-Forwarded-Encrypted: i=1; AKwUvByjENSkGzxFS49jHADQ8gHz3b0Nldiblxqwlg8X9nnq8FTKLN6dCNgUN+DIqkuoc+jouqTqHrDqlvY=@vger.kernel.org
X-Gm-Message-State: AFuF++n3SlZGzJkEuYLzmnOAW1Mu34QjDSD6OMk1FqtrvNUHUnCJyCfI
	4I+AW280ZbQksj9KXXrma55KS1EJ1dhHckre9L/LGap+9mQNQcmv3z1HJkrFPzOzFdckqTFu685
	LfWxbLdKk4p3p5WwnARabUl33tQe31G8Dr2gRv/g4fa+t0oyKTawjgATn6sUJdWQ=
X-Gm-Gg: AYBFou0iga9GPxDK90GdS0i/MR0E1ns2ekoj4FkBvQBTbzK54yVckuFAu9Py/y+mcP0
	7wfeiojwqPhbJP+JsrhC1vUYcEPsrih9FdE24qEOcx3H/nyIAd5d5ReYRr/DCwVYCgNittSEC+x
	GmVwg5OuzeUjloMaIs8A6NzX3p+oavbtONjsWFmRBPbC/ZuKKtjWoCH5voJ9xpdjUA5PBz9i5xQ
	LNpvcjMeNZvCGmeZ0SFWaZdzzQcAfFgOjJh3nLN94iJxm13hz+H+3a6zikfim5oLy4p+IAhUVTG
	Vzkv5x2ri+k7Zv84G4BYhThZbjP+Mq2b7747NOVkMkhUxWb0ekm57Qf8mmXuk88olzPDTyPF/99
	pqIJw6c/OPxrHF/w/M/XCbaCH7HVJww==
X-Received: by 2002:a17:903:1a67:b0:2d8:d4d3:da4d with SMTP id d9443c01a7336-2dd2a35dd20mr223181895ad.17.1789312852787;
        Sun, 13 Sep 2026 08:20:52 -0700 (PDT)
X-Received: by 2002:a17:903:1a67:b0:2d8:d4d3:da4d with SMTP id d9443c01a7336-2dd2a35dd20mr223181195ad.17.1789312852339;
        Sun, 13 Sep 2026 08:20:52 -0700 (PDT)
Received: from [192.168.29.166] ([49.43.233.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bc03778c7sm9983061eec.9.2026.09.13.08.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 08:20:51 -0700 (PDT)
Message-ID: <71c309f7-3017-4c2f-b2df-82cd1a8019d1@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 20:50:44 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Enable SD card for Shikra EVK
To: Monish Chunara <monish.chunara@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        Kernel Team <kernel@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260911093932.2376058-1-monish.chunara@oss.qualcomm.com>
 <20260911093932.2376058-3-monish.chunara@oss.qualcomm.com>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <20260911093932.2376058-3-monish.chunara@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hIAdwGXoDN_jh72gYBT7NGZFPtlWqW2X
X-Proofpoint-GUID: hIAdwGXoDN_jh72gYBT7NGZFPtlWqW2X
X-Authority-Analysis: v=2.4 cv=c5Y+0h9l c=1 sm=1 tr=0 ts=6aa6bf55 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ygYGJKfEQ+goyyaro2Znww==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=UvUgRuKAC70QvhXwD9sA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDIxOSBTYWx0ZWRfX/x3eD0e/AyUd
 AsgVn3pL9gxRKz1oq2V68bQndYUYONFc0d4JlWpJ6tVwrgBkgZf4asWdNxRP3WLYEQraTKOlviy
 JModxN6pXM7Nx5ywv5IoZHE4w4ORZfxNn5NRnhqz98n3RnPAnesQ2+ip18E22mBT0EuVQXINx2H
 oudlfny056VDCrUXRxTcCQBLrSX8qDZKSsBX2RdgmrtBzj2Ij0QMLVvStdVau0xWJgihLZXphIz
 6YV7AFhU/BZtrN3iyF/8bzEWdciO7CQpZiPGrrmjp/tGhWuQdOKiZIIeCIjrIc/LMniLgFHnK0i
 DJLaGh0sSwkz5DE/gOq7K81SdKIgPTLlH+oTamQfEebz2hLV+YypoVqZjP8TDOawKAGhyiorPfy
 htHNLoQOkA/Bsa7ZnxQlRowWUntekotzSrEmE+AlsmSZglBHk7T49K+BakHOmcMc86x7/0pH3s+
 1J/KYHN56jg1kvKXh+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDIxOSBTYWx0ZWRfX488UEol/IUOs
 bcTGJD++MEhNv12jL55JPOvjrhwgun+cL0ZAA1CfG1CuuDW3PUHoep33KQ4Y/RFzpg9fQfCW58A
 Rx7pA2BV4DN2B46WUrThuwub9UMcI6c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130219

On 9/11/2026 3:09 PM, Monish Chunara wrote:
> Enable SD card for Shikra CQS, CQM and IQS EVK variants. Configure the
> vmmc/vqmmc regulators and gpio-based card detection for each board
> variant.
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>

Reviewed-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
