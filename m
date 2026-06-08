Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66763016E0
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2026 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780899017; cv=none; b=Hz6zEXZh9HSMk70i+MgwlEmFEMNclXKtGekWSwdJ588Q7orAGn2BRfOmG85/JqZsdXds07xbp6FkOQ+0Ak/bV+64l+ptUiqz8QYdk9WuE47uZBjogt0ePhBIgp9Yd7ZmfJ5basJHXsREFKW8UwSBCfXLPliTgm+gLmpKLsAb25o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780899017; c=relaxed/simple;
	bh=ctLJGhtKeMb1de4T37kM25kIxoTGRwQN77CF3ifuThE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZXISJhqHO0LESXzeJ9RQmCWbnr2qE4c4LCqZOeDZp9XTL8PyBmZZdC43ZBayouDBSsObMVQdhiKVfYGKA62tOdYqUvEyaj/mlGaGWdw4IU8RsI8iackNie81wPiPIRKb3Z1P+1XTo8RjfNfkAFLIjzGEaHwqNqe0eucKhzNAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UO7MdYII; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C8nkDNcY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UO7MdYII";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C8nkDNcY"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580EVh51575805
	for <linux-mmc@vger.kernel.org>; Mon, 8 Jun 2026 06:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/ZHNhdNoux3RwYcj4Lhip2X+5aAHdY5ZDuE/CWM5Cnw=; b=UO7MdYIIG+9wv0Mz
	llXOu3ZSMHBofiar4VG+1G/RgqWSfr6qV3ZciBZMHN+YzEuEdbEN5G7uD4KITM01
	C4AR0SVxWl2OAYtWdX7gBZyYm1H2+vHNo/q80g9V1T2/irEWza9GroaquaKnAodw
	T9wQIc8nFahrGHV1N4A/iKT6Xm9wRfFBMtv19DpUhPWljHDJL3tjGPCicrVKwZQz
	lYcFGICdFiarwpOvpWEGU3ySbf5yH0ht9KdHZFEno/QKu1NmMhBxXLVdK0Pe+ID+
	SY4ivMy8kwV9qYj3A01RUh42SUHICpQdQL28UhmAmjPrSXHG3j2ngO5/tBfgaz8E
	n3TUdA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs1e35y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 06:10:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bfdd99f6b7so53922415ad.0
        for <linux-mmc@vger.kernel.org>; Sun, 07 Jun 2026 23:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780899015; x=1781503815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ZHNhdNoux3RwYcj4Lhip2X+5aAHdY5ZDuE/CWM5Cnw=;
        b=C8nkDNcYi/BJAIwUKFOyy4mUoW7V9z/C1M1UAt5xh62fNtFDxqRtUz3W7sNqz4wH5q
         I1DoecbcIkqDpZkXr1tNjfeU0kKfS+znC0fLDfsCADKP9jUiJlWdRCe8MTXQ7gohBEGH
         8UVy8IKRNynHk4R/50L9QfYmTtrc8P66UXShahBXdQhQcGtg9M4r80sA6BoqkM7DIdSM
         Ntu8ddj3sF5gO9ODWOvMwHJU0tBXR67+W56Vnpx0ILLgYkvM6ZEjggJe0B1g2d+Q43Zj
         6Ppjk67SxEajOcP3pMKOVi7eeCPsPg7tlwBFps2auJT+rCO5IVK/9EoA02cgjvcmTFZh
         LKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780899015; x=1781503815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZHNhdNoux3RwYcj4Lhip2X+5aAHdY5ZDuE/CWM5Cnw=;
        b=bjDHwj2XxGngzWjTkjfYCMWEgvPBQHGn7SQi+mt/coHsmKkbRy1uyAlNs7cpZ7k7c9
         oATN+nmNsvXYuvxKxKKv8Iq4zJtAjuqapr74DL9iiJR+lCreYyDqVPwDRuXvx2x0X+gy
         AJ5eMdEuDnEboKECEp1+710Ib8b3wRB/AjS02o7OCBZOwDPA1q0L3rYlntMc0mMBtDSy
         qTtZYTJ0bwwTEhhiWOxMB16+MKBW1/zPPavl9uHSvlVT0phLM0g7OjvhxqUUJq07DVvF
         v1cPTh9dSlDqKBb/SOy/t/Hjr/Cn1CkYlZynBvE0is/jv6FSlXTLgQPxCQ7bvNEX89tE
         rHug==
X-Gm-Message-State: AOJu0Yy4B8G87NKDRbhSHrbkCSiUzM2q0L3VBDqcTtJzVdgNdidpd6/M
	YWKwrikp635ao9xBuadR3FbsrlrcTT+w8puyOuZbj4t79QR0mIc2e2EioMCnur35B+BR/w5757/
	k2m31/AT0wWTDBTxeRkEX6dWL7AlBB4HKyctKHN1RT8pkdzhNBIUwI3qrYBSipxU=
X-Gm-Gg: Acq92OGFfcIsnMIstxCXyIX5VVdnM+l6fEHOm8lP4ja57rr/Uut6hgiGs8NWD7rlWOi
	+tUG2kuroJKylGVFZudJNzNaIkMYBF9ECH3BFBclP3ydVuyvum0h9cYE9WhiAzF9+jiRWjuUWox
	cdDLjTsf8uI9Ib0XYrtsV1tw88f0UphT1+j9YZo6ufb5qztWetC0HIhjEOWxiuniLIzce7t0oEV
	OKZKQtqL9xDMYwNzpIPraUqUa3opJj8LT6LHvJIfVZoTM+gf7x3p18zMnYBYMsfkVFb7Y3f0D37
	CQ21MzaaV7IQFNyi93cqtRl/r+IUvCMCW5LVlR1zNxvCBrNMmKCFGUe8VjHX7K1JiB3FqlvnPeh
	5MrEj2p0ZZQfNwvvWQG/+QzhuBmxJbBupPU3U2NQbUt9H3Wb/XiOM0HypI+EPMsA=
X-Received: by 2002:a17:903:3805:b0:2c1:98b7:ecf3 with SMTP id d9443c01a7336-2c1e849577emr144322265ad.23.1780899015314;
        Sun, 07 Jun 2026 23:10:15 -0700 (PDT)
X-Received: by 2002:a17:903:3805:b0:2c1:98b7:ecf3 with SMTP id d9443c01a7336-2c1e849577emr144321885ad.23.1780899014817;
        Sun, 07 Jun 2026 23:10:14 -0700 (PDT)
Received: from [10.217.222.59] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629cf89sm170885725ad.56.2026.06.07.23.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 23:10:14 -0700 (PDT)
Message-ID: <dc833e56-e127-47b7-9ea5-58d6d2cc193a@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 11:40:09 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>, ulf.hansson@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260608041650.541502-1-neeraj.soni@oss.qualcomm.com>
 <20260608041650.541502-2-neeraj.soni@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260608041650.541502-2-neeraj.soni@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA1NCBTYWx0ZWRfXxreP/LwV0JhN
 S6y4QRlJfYFFVYsH6+w/8d71tnX6RQE53Dv4ctiBGPlfp0tRwEV1Jjslic0wPqJ09jovAD7YPAC
 zIYYXsK1Qbf3issFERVIwvw0LLSTTuRKZNw2TkOTltLeSJlSSdqL1ZUp9haVjxcYJNFub6Ifnpm
 O3HG+gpGmYQtZF1CaA9qB5qvptcnkYHc7V0H4OH7b6GvqBg0g7PmqQPFbL9aSh6NqsjNiGEIouL
 RvOuAQEqjQ485+NEDIPjoKMyPaIDj0jSvGfs4moh25vx00LkXKvMSGIC1c28Ubq5JrD00aLSPo5
 M0R60VEAZXlgWvkVa9L1Z2FpWF6Ba4MrIKOo8DO3/x4/Ta+aw8ytq54biGRKhsekzLFvqGlmGbW
 7caCitFJine8dA1kr0eRUlQqr4/+CgzmTaVFRfyg4bkKyy9Qcn2e/LTVvwIjc4A3A0sIVNB8vaE
 RFW3jUvOFS2hYokAZbQ==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a265cc8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Z0ZxW08zNbm2n-bVQSUA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Sw00mculRDXappbDJp8_OuhxYDNafbhU
X-Proofpoint-GUID: Sw00mculRDXappbDJp8_OuhxYDNafbhU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080054

On 08-06-2026 09:46, Neeraj Soni wrote:
> Starting with sc7280(kodiak), the ICE will have its own device-tree node.
> So add the qcom,ice property to reference it.
> 
> To avoid double-modeling, when qcom,ice is present, disallow an embedded
> ICE register region in the SDHCI node. Older SoCs without ICE remain
> valid as no additional requirement is imposed.
> 
> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Co-developed-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Link: https://lore.kernel.org/r/20260310113557.348502-2-neeraj.soni@oss.qualcomm.com
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>

Link should go below "---" to specify previous discussions.

Usually maintainers add link of patchset being merged here while merging
changes in their tree but authors don't add it here.

-- 
Regards
Kuldeep

