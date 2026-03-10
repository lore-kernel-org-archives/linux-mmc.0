Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8F1211A05
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 04:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773116154; cv=none; b=YqK+X3t8j5YppDThVa/Sg5NVb4Dsw+BTG4AziNgM/FSmRJjH81FIE1xQuYarStPnHBMPyF++pnPQGyXmVHYFy3X9HIyIeYw0+ewLMtiNSS5IUiWqSD7bcbsWEYVSNAsTUd9Z3bAXykWH7YEBqrhAK8KVtYWeHbV8jEISCP0goLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773116154; c=relaxed/simple;
	bh=f51VE6sJX/RXYshcjYQsXKsEcNE3geQPu6lKeol6qGs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DONQKhZaEs6ZlqakuinKc6YWS00+tU4xp90y+6CHCbWeC9fmutucrG3VAWE/DQNR7WqxP182E/JxjSyasgGW5boaXprT1skJq4WC0oIF2opm6VR3PVP+l3mN+Zr5iLtrqM8K7nA7tNebw+EGyOP/v77JbXzVamfKl6JASsSwO0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZLNERmQ/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fsFJDZOo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZLNERmQ/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fsFJDZOo"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A2EQCk2460646
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 04:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C2hG4y6CSLvagr3xcq/Ogt7zvKTJuHqWEL2nllvvJGc=; b=ZLNERmQ/K+0qF7aG
	gyL4s+m2PA8XZaVe7lgIRtQ/UiB//qyUmj3GSYHLqegV4qY2oJySrYmSOWHZUJAQ
	9Ywqkl8RS+VQN6NUo1mEuqPXrTpPJmQ3E6dMvCfzV5TRel+QyMNI3dXRjpVSrlQL
	PnQTL8mbcwT7IFjQrP0j3ESAyoeQAGLi4z9awOaKpxTnScEMIkPMv/4keeAP49Zf
	YzkaEyaFuE7a7qyIUqYY8+TqCOulz0o3BMy9O5MaqohA1OI6mUY3inSOD+3282Ud
	lKRYjnuvb7xO+j7aqhSg2ufShGUdLJxyT4dzD1FdH72yEeYLkk5gCcfsL+lL5Kne
	7zxQYA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyv1agx1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 04:15:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3594620fe97so63606624a91.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 21:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773116151; x=1773720951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2hG4y6CSLvagr3xcq/Ogt7zvKTJuHqWEL2nllvvJGc=;
        b=fsFJDZOoEwxSXNx7ITSLe325UTnbTaZ5npRvR9HEtuSAnJpXEdS2lJJTf4DFp7m9CA
         VfYr421erPedPZpFtSGyaR3fLW4yvk2dosVsea9o8DLHlF+HTmiPmdodTuzDJMT7Kf3A
         9i9ojzwdfk4o/ESt0Q7hiUoDEfFgcR9nBtptCUcKiZyUtaxdjGG2PhweufJkmfZR90gj
         W4D675vu/9ocBM5eVhuIWS41sZY36CjjWllTmjiRDLg+ZsYnZbN9U7KhCivWF4ZlDGI3
         hd5zueTEtmjRA+gD2xoWmWaOF9vfJ8Elj3hCtCTdqUMGCydACnX9BHPOsBw38IxhduNA
         MCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773116151; x=1773720951;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2hG4y6CSLvagr3xcq/Ogt7zvKTJuHqWEL2nllvvJGc=;
        b=eEJT7fwYPOAVPi+GL82XXrdiUnrHHVLG1QdWutMYRtoDY9SgG3xMnACT+i0dWKI/oB
         hj65yrPKDeOujfPVW4hsO6Zs6tWdnKd3C/qdSWpQ+8Bz8q3v0LL+pXLvlh5dgPoGUDQI
         JpWtSSvnJiD5ErhsgRDPERkQxxtFkXReEUa4Fk7Plp2tpQ66SpJ/pJD3j5XKSGYdc3no
         43/DxdbQg4C8Gs0Il2Eao8TYzB++vkMs/FstdcBFhY0HceB/EV6ucT2Pwa4TONHvjfYg
         lmNXPFnHmOhgtlCzP2kpRrQKcitFSxbzi6ZEEAmHG1yRjbCgjZVzTXEb/nMtB19eTVsL
         MEsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYAUH9Rj0DH30Byfi9vrfOT0a1qK+SGOMxjP24CeYikD3BxAS2NVrIChD7kYuNcn13Z6un8o56ch0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp71JwxtGfnvCzszCXOLSVxoFlcnvet9e9ZYdMejKAmyhIfLnB
	m6RjSqVyX7sSSPZ5XEW14VFELyGKmem5lu97BLS4ksYkWISCJnqxBWpKouA140yCsiD52Ie6Kka
	OJXzpYrtkeve0UyXKXcGgTqDg0QTX79A3dbPcs9Ott4Yet9Bx4F7HO4Vy2+/3nN4=
X-Gm-Gg: ATEYQzy6mpq7/QsxiIyNsmaXInOvviMs9JmBqHkJDP3YzAtpAIkLU71cU1cGXsLjYEQ
	WUz3v6FNwr86BMBWLnAsNIFv9nlC/F+4L3qef1sThpwMrNOsOiIIUx36D6/0656P6U5o+YB5Si/
	RjD4xgcMAcpI+TNN3Y9CNoojXpWmbIsmHXRKtHgld+wWr+rIf8qckrQZHd5Tu6xGe9VTDr/GwJG
	iIicQWXETe5h5X5ahLA7DRX//ZQrQoMgdpxrTonCVxsFhXRv7QsUYiRuoaMv8fXXt4dH9ypFd7d
	Qiy2/1VdhDkuTRASGexZfvRRhA9rhm2dnwz618CaNwGB+hHPsjhW7/JwekxWbOLr78wVj2IDJtd
	4+KSxZ3G6hxkUMiSFAR/OR8p6XvKFBbrkBT7gjAqPhIxRDEdHjw==
X-Received: by 2002:a17:90b:3947:b0:359:406c:49f3 with SMTP id 98e67ed59e1d1-359be32e852mr12428051a91.27.1773116151612;
        Mon, 09 Mar 2026 21:15:51 -0700 (PDT)
X-Received: by 2002:a17:90b:3947:b0:359:406c:49f3 with SMTP id 98e67ed59e1d1-359be32e852mr12428025a91.27.1773116151174;
        Mon, 09 Mar 2026 21:15:51 -0700 (PDT)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359f088e3casm1332498a91.11.2026.03.09.21.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 21:15:50 -0700 (PDT)
Subject: Re: [PATCH v5 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
References: <20260306093332.4193993-1-neeraj.soni@oss.qualcomm.com>
 <20260306093332.4193993-2-neeraj.soni@oss.qualcomm.com>
 <20260307-llama-of-massive-downpour-2e512a@quoll>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <704b2d33-102e-74d0-781a-a9c7475ab0f2@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 09:45:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260307-llama-of-massive-downpour-2e512a@quoll>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VF1gj2a5UR6ImOAgwz0iy4isJnBy-bqW
X-Proofpoint-ORIG-GUID: VF1gj2a5UR6ImOAgwz0iy4isJnBy-bqW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDAzMSBTYWx0ZWRfXwM+TwQL3Z6f9
 4q9rBObhz1iNX6KeE4GK+Oi84aOEz0P+VXerrXTDCTN3yNkTq/3xeeSMa0INL+uOtuxbA5f7BFj
 gsHAn97S5DrXAwKL55KhO8RMDY7R5L0PKp7Jpe0n+m8X/kUbEHDeyNPlfRwwez5Ll1zhci7r52s
 E5WmEsbWdoTP5zEc4fGqzSHWZdKVu87H0bN9921vUMWtTc76rEBw2wzn27eM0gIFzNTbdlQtKYB
 1Uz4dX9j/Y0cE+jrOMXSSfvk4059LDSCLIkkhfMOo+aZvPGz6KRqD5Nt9c9f6+MPoS95mqQflF8
 8BzIGLd/lYumG815HQ04tVNryGjZfLBsGCYcJyQuLYn/Ttt6E4fTujVb/qu/ipqht2zG3jkeDl6
 GpCrSoazOVJ6DlcgZgURD3f/ICyL2i4ScBULs5PqkUyJ8WRMYNBi+sjChFeC1x65zyVPYa15Vbq
 pYKC+Y+LfyUpcruVsxw==
X-Authority-Analysis: v=2.4 cv=Cuays34D c=1 sm=1 tr=0 ts=69af9af8 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=9FgRAxV2nyzNKyt0_24A:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100031



On 3/7/2026 4:06 PM, Krzysztof Kozlowski wrote:
> On Fri, Mar 06, 2026 at 03:03:30PM +0530, Neeraj Soni wrote:
>> Starting with sc7280(kodiak), the ICE will have its own device-tree node.
>> So add the qcom,ice property to reference it.
>>
>> To avoid double-modeling, when qcom,ice is present, disallow an embedded ICE
> 
> Can you finally fix checkpatch warning? I have impression you ignore
> checkpatch in each posting.
> 
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
> 
Sure I will fix this in next patch.

>> register region in the SDHCI node. Older SoCs without ICE remain valid as
>> no additional requirement is imposed.
> 
> With this fixed
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> Best regards,
> Krzysztof
> 
Regards
Neeraj
