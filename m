Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34933563D7
	for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817093; cv=none; b=ZwLhLwTvnH/dZuyI+VydBFZIM4aqlahYzOL5vDrP9IiVhdggWBm5BwST/jdufBYbGl4eO5l9C6SzJb2WgbTiCZ8Lx2Y4u8NxON84Ec7IWb62uQFewWRWzTdtVH8BaUYnmjC+iTPJlo+Kq+WwNg2xEeN7JEJpbo+0xC1GgR5btNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817093; c=relaxed/simple;
	bh=UzW5BW538QUV4Xa1w2zhDQwSa0wcN2mNavMPwQIaLcU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GpGMWatEyvZSn84u8nkbebBWD9UA+DMuAbWGd319djD1Qz1KENJ+8aMcPz9RV5UaANke4gHBni9jsJ1wcXjE9I8UCLA+z7V6gUyGYayH9Pb4QIDo6HpT3jZCA7ZSR0vyQ9FdoIpKiFS8sVHVkVF9T+uiw9lfsmFJehL5sFugcls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ldw4GC3i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QakK76z2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ldw4GC3i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QakK76z2"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J9mg9c2963080
	for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 10:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1rZaqFYpKRESrI70ry9zhxOXqJuV68w0fKc0yfVt/8Y=; b=ldw4GC3iz3L/HFDP
	PehbzbZ+xOREoC3H51hwc00H/l6Hfw2+hcJdXjRHS+EHI/SjxLxdNasTECHYRXiN
	QJqoplEptAIxVkb3jrvVXycujyByIFZxSnDqS7x+7AytmS5YaWxGJQS970rICs/B
	2tVbwZmQcecTBTimK6Asfp432+X1WiiWPVFaqfr51Hjw4ySoKStF0M4SyciDbsWC
	QjnXQ45BUceJzMMgfvYNFANNOhPnW0xtfmBaxtZ1x/fmOm+4XtN1QL8NtvBdSdkm
	hpWwjwlL7f6XkyLZ13OoGqB+zU+Xiq2b0Oxgcv22DpyuCJGjvHO3F/8WjxEJOLY6
	Zcn4+A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsjaa8220-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 10:04:51 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c503d6be76fso5335848a12.0
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 02:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768817090; x=1769421890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rZaqFYpKRESrI70ry9zhxOXqJuV68w0fKc0yfVt/8Y=;
        b=QakK76z2fvUas2pxo29ZUZtNP7EwCQLmq8xFfXpKSat/GHalK/fdMjZUTFv/UlOKjB
         LuFEmoqZQ9p8IlUHrswfqNa3qAFLaRF1rKuhzkva9gSbShaTtU9++Q1QETh9/VT3t8eP
         15C+lqVgqAkpPlGXBZ1makieP8paFU1uOg0sMetpjQZupK+mcUEN1+Qgaq9ocyQe9jq8
         ldc0t84z5CkpE/lgPJs4CvNDzMUB+aKxNz9d4osyXA+GKVLtnrrKNiBAot5ywPEMYoY9
         fzcyVX50pD0Hyx3/qsbSb4z0aSJQluTBi+B+cLtSgfIQ11oGWv+KzPEFXHZJyQtvJGP6
         Ab2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768817090; x=1769421890;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rZaqFYpKRESrI70ry9zhxOXqJuV68w0fKc0yfVt/8Y=;
        b=ByHMAafaEB7FHzbPOuWD7fSF48HdKEuAJmtxqju6DcBFaxK73ye7CuGITM/W93hBZz
         1vM22k2vqoWB3r1bBVkOOfRMDnxkKCwNb2I7KqDfDp1Zk/zQnmCuLOSU/gpxr56lh/hw
         jzs4S53VWnUtZ41qcMqPTwuQ29a7+SedArbF5VzCR/LVWmjimRrrXRelP7zxoonwZZF6
         dvYJeB++dEa3jDBKgLBS2fWVMJldftauAKGK1wu+07PR1bM1Da6LXKzoMo3F5fjM4Veo
         NPNWlg2CulwqLWzmz465HHpnyjvvyemVR6Ua6ZBoY457pzE3lFgI9gs1IsrhHDWMJXHj
         WFPA==
X-Gm-Message-State: AOJu0YzSVnrUj9ujhs81tW2zJPfZGqkcNo3bp4Vai0HHodEbOOKEqP/V
	guLICpzykiE6Cic3ZCfXSlw9lEA7M97EE67JBAcwMA4O1gUhyJEm3fuwb4HZP7Q9yWNWtdCfjSu
	dOyGxm41QwR58jT3HNYqkyslyled3tcrYch+Of/Uy+uwP1uq8KW39TzQtDhNDfko=
X-Gm-Gg: AY/fxX4GqqSanm7Pi/E/kVl+OHB6xy8yjf++YiEZy89k+r95N79ET6ErcULLZWrP9fD
	kyLiWvKzGHdAvhJswPHVdRKzztww5R4qIoPHmTxf7UIibAgMxd2OjPgY4bYg6XVC/bbnWqzySn7
	R/sdxeLM8uQ7ki4uOMFkurSRVcSUQEmKK++C4cvRtkYtjWJ4XrlDAb0g3ACgsy/06wTV3Uj7t8K
	/f75mz6nhE+fQTOdQ6p6nQYST0R9awPr1gBQzuKDzSB4AkNuLcRSDNeihCG453sEhDpd/ePe5Rs
	CNh2EG5Aw/f7Bdtxhwe+55uLBHggK0+TBlFPoGfBfqRqJHOn0nUXswxMIUC0crbAbIapwodkdUH
	Gec0Awz7nBTvRv9M4G2FfyqkOgeu0CBymfgwRXXU=
X-Received: by 2002:a05:6a20:12c4:b0:340:e2dc:95ae with SMTP id adf61e73a8af0-38e00d5ca1cmr9096378637.42.1768817090565;
        Mon, 19 Jan 2026 02:04:50 -0800 (PST)
X-Received: by 2002:a05:6a20:12c4:b0:340:e2dc:95ae with SMTP id adf61e73a8af0-38e00d5ca1cmr9096356637.42.1768817090091;
        Mon, 19 Jan 2026 02:04:50 -0800 (PST)
Received: from [10.217.223.153] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dae08sm90920475ad.51.2026.01.19.02.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 02:04:49 -0800 (PST)
Subject: Re: [PATCH v2 0/2] Enable Inline crypto engine for kodiak
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk+dt@kernel.org, ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, conor+dt@kernel.org
References: <20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com>
 <176840729246.2734238.959231359705262987.robh@kernel.org>
 <2956f2bb-7db4-4d66-aa71-2017c9a4a057@kernel.org>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <38b979a1-8499-abaf-c990-2986971ffa7c@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 15:34:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2956f2bb-7db4-4d66-aa71-2017c9a4a057@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA4MiBTYWx0ZWRfX5lERUtjrAtFY
 uMxOUWlpswRzys/eprvkz/OGIxgR/YmmQzabit0dBTiNF5KhCAtZyKU49T89jl0aD+D+eWXK6cC
 zoKlyYt3qjyKx/NVN49MKPhoDJn2loKur/7myT9YTs3t8NX+JkqZQRcaHrjrmvIaPWylfvtD22J
 IMDCJhZDm3EnJyvo1mRpTj/T47QYG8R2BGjxpkDw51H/0NuOlAsbAOWf/+XjG9pCwae8HGoM12i
 prNwg21bMJrJMsCwQKLOD2LZhEcKRZeDZCqQKB3SeVMP4ddNz4BsU2AUz0w85zTNYluPV/3H8fU
 hu9vGtjkGC1J2rejItb/9A/Sia+wTSgwH7P1zMsgX9Rp4EOIPf/C8xpO3D6EgkfYIFkUfu+amvO
 f3G8xZaQse97gvqnmuOgwgoBtCq3nMcoYpf1LmBhSryH1To5ZkR8ggURp4Hie4F0oG/nTjvfnSE
 zO+wSTBVJmoroAYGr2A==
X-Proofpoint-ORIG-GUID: H6PQfAR9HDmVxg6H0cKjNNVQuQ6nSnrF
X-Proofpoint-GUID: H6PQfAR9HDmVxg6H0cKjNNVQuQ6nSnrF
X-Authority-Analysis: v=2.4 cv=L8gQguT8 c=1 sm=1 tr=0 ts=696e01c3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=xTBwjhZbDR9UlUe_VggA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190082

Hi,

On 1/16/2026 10:24 PM, Krzysztof Kozlowski wrote:
> On 14/01/2026 17:18, Rob Herring wrote:
>>
>> On Wed, 14 Jan 2026 15:18:46 +0530, Neeraj Soni wrote:
>>> Document Inline Crypto Engine (ICE) handle for SDHC and add its device-tree
>>> node to enable it for kodiak.
>>>
>>> How this patch was tested:
>>> - export ARCH=arm64
>>> - export CROSS_COMPILE=aarch64-linux-gnu-
>>> - make menuconfig
>>> - make defconifg
>>> - make DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/sdhci-msm.yaml dt_binding_check
>>> - make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CHECK_DTBS=y dtbs
>>>
>>> ---
>>> Changes in v2:
>>> - Removed the "if: required:" description for "qcom,ice" dt-binding
>>>   as the ICE node is optional.
>>> - Corrected the ICE dt node entry according to the dt-binding description.
>>> - Added test details.
>>>
> 
> Is this another report being ignored by the author? I'll start the list.
> 
No i did not ignore this. I see this comment in the message:

"Ultimately, it is up to the platform maintainer whether these warnings are acceptable or not.
No need to reply unless the platform maintainer has comments."

So the intention was to wait for the comments from maintainer

> Best regards,
> Krzysztof
> 
