Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD2438E100
	for <linux-mmc@vger.kernel.org>; Thu,  2 Jul 2026 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975297; cv=none; b=i0jF0ImjkMjrUBDkgAscheZ27lkBGTHTNURe60ZUb9JGCr7hD1aOhbG2AtzJstVb3gowUp+QbV2rGBr6NywQHzbZjOnCgzo5TPp2Z1yEvAICPZoqjKy2B9AnBVujMJnpvSURzSVJqdKVxGuTIthriQaEcpf3apXqm3Jy5HrAA3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975297; c=relaxed/simple;
	bh=k3OMu/kG3Qb3bQIzJDCFvOqhRe1SvLCI9dnjLJ43KV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeIAEIE4drQeb6DjPvRUZxr8bYtSiqZPfEEyV8J8fYUlEB8A0EaErPEr86qlCr8Q1zyK2QBzJD3f3VIikngC5jPZdFnONncXFV0227zkAtMl7s6M3lDzBbKWEDSaadl0JACTPsYMqHvacwr7fBtCp/sQjGp/trAhGqemDD24UJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KSQTflF1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ui2/p9i0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KSQTflF1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ui2/p9i0"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6624iDst3591605
	for <linux-mmc@vger.kernel.org>; Thu, 2 Jul 2026 06:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xL54Sy2yQPlXBg5Pq6yC+W2EIfKsiwbAkMZux+PXiAY=; b=KSQTflF1Oo+kkin+
	jQuhJ5/tyxM/cbm2hPNZ/2I3lad6QYDlwsjVvnPQq9No0OE9H8tinINH0vm6lm9t
	Ug8Zxgz1jhfi81zWt2L3ipWwdWEWxTXjuBSZ/RZ3eTpjljkOe1rfVueu4t6v7Pv2
	I15xdMzalBaHfF2CpEJTCuDyayh/hN1uNfbRc+h4/Oj4yzg5U0//NguCs3NjMMPc
	O4iEBs6ub34FdOnsJGJx4UgSah33jdMji9FcYX+R/9wvOZl3VUq/q+RDfxdFpJxn
	WHnhv2a+H6yM0kDCfsYxanjF+hgHRz9nkrYMoAjlcwZIlQik+7m6frRnQKpgndiB
	o09VKQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n8dmr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 02 Jul 2026 06:54:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c9b1b608e2so25553235ad.3
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 23:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782975295; x=1783580095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xL54Sy2yQPlXBg5Pq6yC+W2EIfKsiwbAkMZux+PXiAY=;
        b=Ui2/p9i06X8W6itB3ItpARtmla0ZGX5FrUKDZ0AU5d7QBHzAZzqk7H6HumYZ7FBjOI
         Qqv8FQEkW1DBQdd3JKT7gWkfCp76SGD5jRlRATVj48kcv+eDgz0pblRwdyuYKOxssKje
         6PXxqpKoa3LhVmMqtDYX42Nw+iAKr7ixuzpkQ1njflrds6oWpcTOi1Q5l0Wd5zmz8ouO
         r1bBli8TTeAgX3TXXLmIUray20Boge82eh8RzxV31XIqHXeU+0sRB7n07oZ1VU5tw1bs
         zVYsCQg6siDMjzs5Q+eaMYaM83FBA1zj2IxQqdPmpXwLCLWKa/s7Gnv3GuwEeEActQvv
         SXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782975295; x=1783580095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xL54Sy2yQPlXBg5Pq6yC+W2EIfKsiwbAkMZux+PXiAY=;
        b=hm1jQTwNixz6yWrYA0qbZ00jSRHpqYCehOiUmPTCh1gFmtnIe8eBNUuAuK9qOI6B8L
         SizjVBHyGuDuStzQ0BYdhOtKHb/GHEuAv6UTmU/0HYHFHe4WJy0ZVGoUUuvSq0C4Oshl
         tO2qsTtiWruqVdfQv+uFQcUSuaqqgNOu1iQdl96rpRV32Ek8k5mTXzOEFRVVkRBRG9aA
         csKdLGk7nziYkcbZ4hJercRz2mBEDnx0HQHLRw7uULJZ4NspGCQv5Gkkyv1JZEeNdlSB
         EOEvScJS7y9Wjp3r3/iA1aWyBxW46ClTKpr3XGJW2CjixpUWegqjsnmF7XJULlPiRbHl
         rp6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrs3btko1El/O38mqEX/nimeNsKKAbytLKXkK4L9JWK81rWpt1skvf8UY2XbNLnMdDEY65MFaJgeSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkp7UgsI+DqXbsSJjb0x7GdLX/YgaTCT5KLFtgv0aPSi0ptD5L
	FSTnl1WKp7hdMBOQFPalXEpj5P8gpCrlKI5dXz0LGyEP8J95UyAE2pGMsOcZb/EqKLcFFulQioW
	eUPxxsq8WeSZO/COV6A6FTGrZWZj0JtbJJ6p8hH1Mt8pgC29WtTq++dfDzlSDjvY0r6deLF8=
X-Gm-Gg: AfdE7ckXxG7S8yAxMOzshFVorlmGStY5hWYWjVSEZC3d2/bTSb+lbW8+OBkQnqokOhm
	7oeXj2HywhhLdHTBXpyqkadfhyp8mKzCoRycym4x93ruCUj8R/m3FOUIu2mVHUJNXUa7HG1BXI7
	XZDMksiZd93tH4dQCBKDDWNhpOlZk0IDKMZ1SkYoWnroKPul16XNp3eY9IZYOp11iOiQ851itsZ
	klWWbFIlPEYl5Rv84BtJLITkobG+a5X6rmXvgb2dKb3Or5jYNtmZ++z2QxsCLKLj3s0+Cn4nQuN
	ZZmpNwP+RYBbrM6I110Jf+lOdij0vq18otIuLr5Ivk1BZwjnZ8iHYuFbkglHqw/gnrLzUiBl4S7
	BYMJk9omfb93nx+m94YWU3q7lS5neKAnw/XLv5qff
X-Received: by 2002:a17:902:cccf:b0:2ca:329:3da0 with SMTP id d9443c01a7336-2ca7e682ae3mr51356995ad.3.1782975295395;
        Wed, 01 Jul 2026 23:54:55 -0700 (PDT)
X-Received: by 2002:a17:902:cccf:b0:2ca:329:3da0 with SMTP id d9443c01a7336-2ca7e682ae3mr51356665ad.3.1782975294853;
        Wed, 01 Jul 2026 23:54:54 -0700 (PDT)
Received: from [192.168.1.6] ([182.77.29.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a9e94ecsm8786515ad.61.2026.07.01.23.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 23:54:54 -0700 (PDT)
Message-ID: <9e2f649f-63c7-4058-92c8-55960c96ced4@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 12:24:46 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] arm64: dts: qcom: Enable SD card for Shikra EVK
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
References: <20260630165700.1886608-1-monish.chunara@oss.qualcomm.com>
 <20260630165700.1886608-3-monish.chunara@oss.qualcomm.com>
 <f5b75410-cf75-4bfb-872b-81b6180e386e@oss.qualcomm.com>
Content-Language: en-US
From: Monish Chunara <monish.chunara@oss.qualcomm.com>
In-Reply-To: <f5b75410-cf75-4bfb-872b-81b6180e386e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA2OSBTYWx0ZWRfX/okj4uaaHUll
 fXHI+4sewLAEdPQLbF+jfE6w3/D9HdmGr7+Xjzkc5jBPF20BM9VBo2dTJQ8ajFsREICqHtAbNW3
 w3urCLb7ZTnHdOgW4krjdR+zxWU3Ap5jB5762HqHqJLu6wVgeo6saelS8YyU1/BPVXTtHyn0fPS
 QuUGBNEl9f3HXIvCFLcAC+tG6NBvuJI0DdaAqSPNqp82gw2OQDs4kVkL7oe2+v5mfRQrLf17Utb
 LFKR+xlLCLDwVGTdn5c7CYUH1KzOr26MDXiBTyZ5K9JekSuysAcg4b71vSPP4roZjIIWU0pBk1J
 ITXLo0q66IkJxuhKcJiiwO7g+q3E1lssZweQaJ+xqKxVoM89PIAzaxex5QtK4FYl7Hindd9Ld7D
 mLzmZ2cam+/L0eivjDJBsp5VyFIDV9DZsdWlxDqqZBa2QsxlT4yjm5URgyqeoVW7GnbfXqyMh+c
 pi4LSFnBEOgqBmeEA7g==
X-Proofpoint-ORIG-GUID: neKwnMqpBNjMNq0qhrK_i1clyi5ZcS_-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA2OSBTYWx0ZWRfX9VWDBuh1YtVf
 4DeCW5cs5rPagGdx2U85NzxiE53FFgidNNzZ5ypKI/I3Swkjxz9jUCDRPyMrVB5eZbLucRrtbTs
 FlCWQT4sD9TpAg56FOwLjchACzmE8gA=
X-Proofpoint-GUID: neKwnMqpBNjMNq0qhrK_i1clyi5ZcS_-
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a460b40 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=1qKOYMtCOh3zOq8T1Y2cZw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=uQbOR76-EmcejrgPhaIA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020069



On 7/1/2026 5:08 PM, Konrad Dybcio wrote:
> On 6/30/26 6:57 PM, Monish Chunara wrote:
>> Enable SD card for Shikra CQS, CQM and IQS EVK variants. Configure the
>> vmmc/vqmmc regulators and gpio-based card detection for each board
>> variant.
>>
>> Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 18 ++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 18 ++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 18 ++++++++++++++++++
> 
> Move the commonalities to evk.dtsi and only override regulator
> in the board files, please
> 
> Konrad

ACK, will re-arrange.

Thanks,
Monish
