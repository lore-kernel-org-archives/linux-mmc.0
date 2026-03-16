Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF2D336896
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 04:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773633822; cv=none; b=tXaQUnk1DRXyOo6mmISYP7GhOyCblf2/NHgnB6eOCMRBxW2Xi8Biy+sb47/jX+A2OJTZLSx7mkSXSBQHFcHivJHxBmcqQVgvZ+XoOht7qnSUHVfXH8g4347niAc8nwRmMUm7jh+yDrZjcF8RbuS2IXOpClAo/L0rjyLXCn4MG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773633822; c=relaxed/simple;
	bh=2+RvJPy0KxbR5xYDOT6uHmarhn11brcJ3+78iAXkyQk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pMf4oHPgJfEQHJEL9+d7WAk64OEkrcQLTAjYN3F3667DPDE6SPmam1bUAcBpLJlW246LxSf9x5K/jt1T+kBbg742lvt5/kCgFOi6xge9fAPrqmXya7fbrXIdMuCrQb63VKP49mOIWA1eLkI61vb13S9Rts1n6prC5bH47szFatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YrgPYMDk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GE5XhfJi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YrgPYMDk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GE5XhfJi"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G3A1LG1629580
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 04:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eIBFnoDtEL/PKUmHBsZ/DXJ9XMTbQDaS8ED5UkrUtPM=; b=YrgPYMDkSuNKn/FO
	w++L4L9UQKCboKBkJ+fZaeY7swz5vQK6an0Sj8WzpyUeX6YvD20kSzxrnsV4pkmk
	b9uxs+GQJYFN4sO/Cpid5mrcwLISjT46+0uow5KRkXzELynWDGcJdSviGxH+4e2S
	a5Z3wmBpoGqNc6MlRDUEMUuj9M4UzVsG/5PoW3aSJjxNocWoedmnTXjEYpkrDQk8
	Yzl+YPe7aefqvWeJb6s4eZRUjWJqESEL+wfyP6k/QWxZ7ZW46EexdNMi1cDbkcBd
	5HgA29/xG9OjEAWHZQcO3D0T8ZhPfkSdpQKO3hQjHSNpRH1OM/id+zpBdsQDU3Ls
	w6+9nQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw03qm5aa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 04:03:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aec3f67844so41351645ad.3
        for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 21:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773633819; x=1774238619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIBFnoDtEL/PKUmHBsZ/DXJ9XMTbQDaS8ED5UkrUtPM=;
        b=GE5XhfJizvKcFi/r8YxeQPP2+2NBJ4laoeP1NqsRGe059ZbYCDjvGQLPWwdEyXBvyL
         kekKN2dskLewnYSkYGwEjGF6pDQuW2g8PktdpB/+jUvimX5bNH+G0G/mSFSLZkzJAC2k
         VAtM1uQa9Cnz/JCJFk/DuaIDWGZBS4bRnUJnhPOWdZ0ezEHmKqbPrNmd0p0EehtLJinh
         MRoVcMsxNsB12hO43Dnu/jQwQeQo0Q1xdwBleSrbaEz1DHMSrYUAmb14qW2Mi1VS4u1+
         lilnIYJV1aFb9ObIFoaJxD9/DkYOe0IDcAsaFquMYGU86yFDolSVUsMrWSc+IJFO7FnW
         WNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773633819; x=1774238619;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIBFnoDtEL/PKUmHBsZ/DXJ9XMTbQDaS8ED5UkrUtPM=;
        b=lP5axDvig6jEmlbUcoJKhs/LBWzbaJkXFolLVho1d3eUc9en98qyNVL7RMrqgCR67c
         DANTDSWIZdYLVUiMF9bNxwJwUS1iCP21kLjEFqGUmTE3cSSvqSM2TX7xr0J0nxYp5GuM
         jB+Lhy09yWDVKGdsnLHRqSLl6rDBhEarswj+iPqQVcRXw2SARSPmr7UJvlVnGAmKLb39
         tGy0EUeUSpSNcm7uFj8JpeUyAmBY/yav5zrebfMGmVPpvG60HgpEsIPdL+sUdpajW4pP
         KE9iM0mSpyhGzmQtvFieJ2/J1Hm9ae1f34pM6nxQfROS1g5I9//edC8KkmtXhVlK6IOG
         QjWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWME42vaWq4hplp00VBRlIDkmEKZK6RYo4EhbpYb/OmbEVY7co+N8P/pjVbxahQmhKU3uIVecXWxI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwOk+9RcUvwrYpEUguR2SJBAFwYMTTIuunb1AjIR8NHQ+ryCB2
	Hkqv1pRwCEASOYyCpLr+8BSKzV4oaUIS9I6+g3jNsBCeXEFWbSN5cQUon13c3Vrp0Kczb8/fvJd
	H6o+NdsdhHCj80/H1X8fFETZL9Wrxk91ivvskKH2nt0Jwd98ksWMzAhZ6NAk0TXI=
X-Gm-Gg: ATEYQzy4Nhypko4EHkYyRclnuY43pdm3Iy7zhCM4tZpwozGj5PBJJm7vTrrJ/+ynh8p
	xtXpXbhM7V9NJaoZxrHixiV6MJR2ZLFjfK2tjyiE1PZZ49OhmsSlon3+8taY7jOG28AgG+gjbFV
	P5srpniwWiJO8vmRXyssZPToCKFu8HMdKLP9atAZvtoHgWnpBi/FjV2qQpJJbD0/MGG2hZukdQP
	nyN+XIFbESXYiPiHTFCvMwa+V+ZZAfY8WUnYfTofzC6JupY3uIZWLur9eCVlJMLMPOZBWU75zUW
	ys4ZXL3MzakiaWS5GYA4Wx3/xBWXw/eK5D9bvazwckgHMVPpgAlnv/aa2i/a9IXC0hWiHht1JAg
	0kZv2Umpw6LZelBbLN4bQp3ixpt6ekDgi2HdxvZicsr5EaKTgfA==
X-Received: by 2002:a17:902:f54c:b0:2b0:4b3a:9b49 with SMTP id d9443c01a7336-2b04b3aa307mr51558635ad.51.1773633819255;
        Sun, 15 Mar 2026 21:03:39 -0700 (PDT)
X-Received: by 2002:a17:902:f54c:b0:2b0:4b3a:9b49 with SMTP id d9443c01a7336-2b04b3aa307mr51558325ad.51.1773633818770;
        Sun, 15 Mar 2026 21:03:38 -0700 (PDT)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b04ccf9bf1sm40652795ad.24.2026.03.15.21.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 21:03:38 -0700 (PDT)
Subject: Re: [PATCH v6 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
References: <20260310113557.348502-1-neeraj.soni@oss.qualcomm.com>
 <20260310113557.348502-2-neeraj.soni@oss.qualcomm.com>
 <20260311-fascinating-qualified-whippet-d6d450@quoll>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <96de4cc0-32a6-77f9-680d-5841bf6f1a30@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 09:33:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260311-fascinating-qualified-whippet-d6d450@quoll>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JnvZ87YrGIQGQM33E4bclBAA22cbAZ8Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAyOCBTYWx0ZWRfX9CPdPv8FZx2C
 tNltx4sK5wPs+ZPn38ST9qDUUAMCGO1FeGa7E02en+GfKm7PEI0jSOQVsXdez8Yd//Elq64eGRv
 6kxsnxXR4Y3EVIS8xMFdQJ6yUeNrVm58NYZVTZ+4hZODYNVCJlMdIrLzjUrDjBbehckBzMM/faz
 vDqJvhMv+rNYry+v/ubh/AQnahGPtR29tPzVVC7yO8EjkDO5nTq+MVkxtemgCJR1WwKIDa4Gw9u
 bIN52tMh7PWTa3IIXvZ0AGXBbGGexyKZN7TNIthuPuVNEE2r8bgO8vMdmYcqKD9lKdwQ9L03Bpc
 OZeGdjiHiYxB5AfxR9lgDmN6OsSOQ8BwTiOPHHDqZrknP/slXAqIq9TgfiQyMOB5EpkS9gDJxdK
 01qa9Gu3pNACoMXndpc6KN4nnYdYpXbWLh0cj1N0mJOd7B1Njheve7pI5BzhlaZ04a0nYLPGYDT
 Nz8clO5XSioH8P852PQ==
X-Proofpoint-ORIG-GUID: JnvZ87YrGIQGQM33E4bclBAA22cbAZ8Y
X-Authority-Analysis: v=2.4 cv=ZbQQ98VA c=1 sm=1 tr=0 ts=69b7811c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=P-IC7800AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=9LdzbCIaiD98xdY6Y2IA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160028



On 3/11/2026 11:46 AM, Krzysztof Kozlowski wrote:
> On Tue, Mar 10, 2026 at 05:05:55PM +0530, Neeraj Soni wrote:
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
>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>>
> 
> Can you please finally start using b4? Except errors in your process I
> don't see links to previous discussions either.
> 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions of patchset, under or above your Signed-off-by tag, unless
> patch changed significantly (e.g. new properties added to the DT
> bindings). Tag is "received", when provided in a message replied to you
> on the mailing list. Tools like b4 can help here. However, there's no
> need to repost patches *only* to add the tags. The upstream maintainer
> will do that for tags received on the version they apply.

I understand that a repost is not needed only to add the tag but in
this case whether a repost is expected since a new patch 'v6' was
posted without 'Reviewed-by:' tag which was provided on 'v5'?

> 
> Please read:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
> 
> Best regards,
> Krzysztof
> 
Regards,
Neeraj
