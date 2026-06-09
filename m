Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2409F384233
	for <linux-mmc@vger.kernel.org>; Tue,  9 Jun 2026 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993111; cv=none; b=Lt45xwYZH6tYh39qbwlXL7NIh3aJ3bs8iJIX84Jhhg84kwCqVrguSUFM6Xssor1liXF9aid8DYMg9NJPz5J9XfxjroV/6Jog7gAsAoCOvPadtikE6wT+Gz6xtaKUGO3vLbZoMYLPhvqd3WMfHjD4SzkzwStNLhLiHarY9I7fVQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993111; c=relaxed/simple;
	bh=d3GZnN8UQfkikNLz4vsXIpHvkczGRKdSLAEdeDoo9lM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZGFJjTcgMFALd0kPzmo/KcLiShnszogDWlZtGqO/YYHdLUdxpf9Xa3kLpaJ3rqlIjyy7LOmkfr/O4XCIIatPqKVwtBI64xgZsCl3G8gldn+THEoFtF975qm7ijnxg9MeWez4F85Xju3LxJGGkOAgTMTILGgtVe3YhTlwxQP8rug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cK/DhW4j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ts7rUfTK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cK/DhW4j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ts7rUfTK"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rMMQ1584100
	for <linux-mmc@vger.kernel.org>; Tue, 9 Jun 2026 08:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1dRMGTV9py53MZ2FkCK9l45pziSarp0xLb3O9u+owlE=; b=cK/DhW4jUYza6lHl
	CFTV9GA+N+UuU0cQYAbgs+3575BGaAqUWCp9EIhv6lmlulEC7khNzgs/i8kXkcfk
	eNnH8HQF0m1a0Cxk4TiJ5LJ+Xhz/eA5yyEGi4XqRmbQO5LC0muD5q+SCLYCGFhxS
	5nXVXMe5IeUx4yh+GAWCR5PyIsuXNjaHhVuKKCrUgfSh78tMmr5ceXnpUJ1T6DX/
	KnUMz64IKgf3D12+utXcgpKjBg3W5Y+WN2hpBJ0KgOEU7IDhMwZyObOBbbxXmkkO
	m5LgQAmAjHlHxW9N/JDd0vIfFYgYs4yM1wIwsZVu4qwg6jKOuQQvRB6VpisPvr2Z
	EZ9QXw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epdeergf1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2026 08:18:29 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36d99629fd6so8810954a91.1
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2026 01:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780993109; x=1781597909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dRMGTV9py53MZ2FkCK9l45pziSarp0xLb3O9u+owlE=;
        b=Ts7rUfTKbzQp7bL3nVozi7gqQypRBE2dugvs3U9HDCAK8dUvFGFzZrexKxnRIqGv24
         bgeBakXQMuNx7fLs7IBSVTXK4wwCX7Xvc3cButTQ9be9c2lt4LBxJyeBYGDXmJZG6gCm
         XTT57KEod6BCTGCWq21sZUkXN2nkPUHFh+Cv20ZfD1bV6t8ey20BFlkqsuRnXVpn2KwG
         hARdCCVfmKfvf31RSaVFVB/Hzn4m4ceTHBAoTNsgQ5ANuVQaXF7TeBSta9oio11D8r6f
         VmBkrVjWoQ9TsCJcWi8PaDkygO8FtMhFPAIalk1cC/Gyz25+mzJsK14X5RLERQwRThuw
         8yUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780993109; x=1781597909;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dRMGTV9py53MZ2FkCK9l45pziSarp0xLb3O9u+owlE=;
        b=b2L5gTzhL8hCtQ1pj6vPKeN8zfr/zsjJ89mKbV6KXu4vT/QPP9Clr7VaXxMTDIrGsu
         z21eAcauYyrMsyjYov5N82Kf+Jgz0TXbAwUjmj7rKsE+O0rPPvRLLFpgubfAlzSuHz8V
         mpfrDIwHl3PIRHPkBTedzCqeIejJ70H+xTF8gF6dvuaV+3O35iK5UByPhL9GZm6JU7Jd
         hcwWZY133hCX7uPVJhFm1KJ5Hkxlka8+ObQ4uEJfcqxdoWUY5zbIBx6i9YSp7tx83ZWJ
         7GG4/hZ0dMjipey01bm9qyaLgvHARxvEtkuU1LsayZklMiXMQNpODgvkamGqyQD7uwZd
         2HaQ==
X-Gm-Message-State: AOJu0Yw/7+d5KWx29G723i95FM3srPOmOM+Zd9TXhZrrcd3NqW6NtiUm
	Gc0D7t4AiyuqMFIuQejwreuivNKkGuipi/Pd7Ms065GvYpikADUGM9++X3kL73KsnpTcJSE4gDn
	VKSBrxFsB3e7XhXdC1bKIcy8PlGhJx/3IpW81TaaHl2L+BvTyjmLvO8IyoA+9SDY=
X-Gm-Gg: Acq92OHr76VJCU4vc/1uzPA69HP0TinsNfo7QqwLFWj69rwwYzyiE27qBSWvQlC2eSZ
	6SqSXX+EUn0jNOFGYqIBjz9R2nYEwVfPs7yCKY8i+caWbJ2DD3z9xWckIQlITXrkXmhFK+LA/gU
	VH2hGt6cpn0/XRfclCifLcDDpIdS+/EAaHah5udHyQ9RlDK/tRH1p1ORZ4qbg7qkYV90uuBEu8T
	uEHx+K56r+yuhwkmoRvlkLUJnwqeFKRLfaWNwQIpUUylLI943CrqIh1ewX9WsbCvltS/t0eDY6v
	mxYtIaO1xlcMMXovmLhJ0eYwzUvPsn/oMlnFPYof3fy6+GnlvTEStTfo0mF8m7nCB7ojtXctpzE
	93mfCGhoV6nBa72xCCPr3t+008YoCTwMCTGFCDOgMHb1i+LmqLSPMBFVtpuL6
X-Received: by 2002:a17:90b:554e:b0:36a:8ce7:b879 with SMTP id 98e67ed59e1d1-370eec10e2dmr20921345a91.5.1780993108919;
        Tue, 09 Jun 2026 01:18:28 -0700 (PDT)
X-Received: by 2002:a17:90b:554e:b0:36a:8ce7:b879 with SMTP id 98e67ed59e1d1-370eec10e2dmr20921311a91.5.1780993108480;
        Tue, 09 Jun 2026 01:18:28 -0700 (PDT)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf90a32sm22515470a91.1.2026.06.09.01.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 01:18:27 -0700 (PDT)
Subject: Re: [PATCH v7 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, ulf.hansson@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260608041650.541502-1-neeraj.soni@oss.qualcomm.com>
 <20260608041650.541502-2-neeraj.soni@oss.qualcomm.com>
 <dc833e56-e127-47b7-9ea5-58d6d2cc193a@oss.qualcomm.com>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <c8da8a89-e372-ca87-cdca-396c754ef5d7@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 13:48:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <dc833e56-e127-47b7-9ea5-58d6d2cc193a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H+DrBeYi c=1 sm=1 tr=0 ts=6a27cc55 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=KxNIBlHTTW4pjOSnca8A:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3OCBTYWx0ZWRfXzGb802KWPtz5
 rTWiqXApjsyTzrFVyL3CKhuBeQ6kFkWGspK34Ssi6ZbvkTBV1TE8+qki0eap4kGIQMy5SncZeyw
 ja9bzMr43q0YA6dY6thC9293PNphANYmY+j6NmHD89V2b+1TvD6Ow/EjMg3H5f7UvwP+mQX/wes
 3auGSNus5HzHB61TYQclElnhjHdZ9+6Nn51Gp39y8jv3E6Zbv54wSmXv9x+JZieR+ip3BfBaNOI
 sjTLGzIjvhLiFP+rLyOzqs4wBN/wTxOOq/drnIpUw5ZxSgbQVc37e9KJhS9zxkx7ZICVj8+rpZO
 6sIpEW+DNweHKtWl5bKwYFB+ofyCwFKN+oCSpWmX0EY35wUfxS+laDwr52h6AOqrMVu2IqKIG0C
 NHW2KybNhnIjcXJszb2eqZhYdKm8eSnFxt77ckwMtyQRWsyYWJ+NhDccQGm6QtbxSngDnUvUPCW
 n+xuFUeDpxl7JYZfB7g==
X-Proofpoint-ORIG-GUID: rYd5xGVsb6ZMptWEzvMy7nBdOSWtQYp7
X-Proofpoint-GUID: rYd5xGVsb6ZMptWEzvMy7nBdOSWtQYp7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090078



On 6/8/2026 11:40 AM, Kuldeep Singh wrote:
> On 08-06-2026 09:46, Neeraj Soni wrote:
>> Starting with sc7280(kodiak), the ICE will have its own device-tree node.
>> So add the qcom,ice property to reference it.
>>
>> To avoid double-modeling, when qcom,ice is present, disallow an embedded
>> ICE register region in the SDHCI node. Older SoCs without ICE remain
>> valid as no additional requirement is imposed.
>>
>> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> Co-developed-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
>> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
>> Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> Link: https://lore.kernel.org/r/20260310113557.348502-2-neeraj.soni@oss.qualcomm.com
>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> 
> Link should go below "---" to specify previous discussions.
> 
> Usually maintainers add link of patchset being merged here while merging
> changes in their tree but authors don't add it here.
> 
Do not see any such restrictions here https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Regards,
Neeraj

