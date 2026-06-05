Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EACB395AF8
	for <linux-mmc@vger.kernel.org>; Fri,  5 Jun 2026 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647297; cv=none; b=rosRwHTnQTDDWx4zltbJIgniZDiEfhqGwvXeiDNiZBWlJ1zL/N/EzuWRaXUzwRhFLsbiWLlH6oOmXCCYXjrNveUgrDkujSNsZTIEWmIjoH0yjYjIdlW/X4DGviUJy/UzLe9eFNRF7kaWkXbID8YEFmiQeDPE279R80zaI3lLrlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647297; c=relaxed/simple;
	bh=BHv3rmL4c+xpusDAqHop9aJRkPe3z2wi/ycyAj77XhI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DjRMq8fxZFaButGLXDbtTw7qk/D8ZzMRASqJHHm+TofD/W/RW0ylSSNemOVdkK/e7lhRIaPRkLbU4ey7q9D/R0uP9SZkz6Ka0c7hMu/66iPo3+WaD3P7fCOqd3RfaZhKPuPcTPbUXj772+6n+KyTgyzk+80u5dk24GNr48NUaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SQ7NSEJu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W9U6juiw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SQ7NSEJu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W9U6juiw"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65584dAQ021067
	for <linux-mmc@vger.kernel.org>; Fri, 5 Jun 2026 08:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3hyN4FWQ42UtCdi3stZ8OuDHs+Nvt6sgvZFCISUmdog=; b=SQ7NSEJu2/NdgmeJ
	H6Dk16Etiz6jZBcxkJazYjnEtGqQYByqrBDXZL5bcLOH01GsgCbFEkqB314QTbj2
	sTSdeCqL/b6TIedH4R0zAqzWjUQbwq0XSCsm3nEmRtzExjZARxRVYGwqCCIsq0wr
	DAtEATIwPsy9EiISrbxHIfPFciOt41ckIhyaGqvSQt4vr5977326HahTgRjaJoL3
	osJuxcamitgfLK3yzj5G+EY9OQB2OoZ+mWwDTU2s7WWDjyyKh1X0hI5/Cxsn7OST
	VdwVFDQD9UB9NqIoD7ge2grOHe8DWFpanP/+chE42a+v837UfHc3PrsHYemzaEUf
	nSi72w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ektmf817j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 05 Jun 2026 08:14:55 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d99629fd6so2738620a91.1
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jun 2026 01:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780647294; x=1781252094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hyN4FWQ42UtCdi3stZ8OuDHs+Nvt6sgvZFCISUmdog=;
        b=W9U6juiwkPI/kU/60XS0+FxQ1FZF1pUmDnqJRzMYsQKvCJURTIxh8NO1VSnziL0GvK
         c3Ll55X/uDAln6KruMEglFu9649hUNAHCCOGUPJPLc7wC3Z1IrjM5koRX9930fO+zEq/
         1iMdOxevaSmADDtXq7rr1ZSbpYZNoZ/ahI+Br0E86TnFObB9UWlK4HmKUXxOf0fx0QS0
         Y6w/OvSrRKOWwyHsQRCdpXnMTiEw902Tx0HomECdALy409kaWjabckKMMtgYRCabyX+4
         ISlIiRCUZj0cDNEQtTznu7VEKIQkgU7lsvZTuzNruknje5i3NE+Q48oZ78B2JcNZkntF
         OPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780647294; x=1781252094;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hyN4FWQ42UtCdi3stZ8OuDHs+Nvt6sgvZFCISUmdog=;
        b=eh+C7jnwippDBY+DA+TViAg4MxUlBy0bKWT+M6Wnsq3qohdPlZzbI0g+eU4Fx1A/+J
         1qRdi4qJe5IAiaxD3y4qzrKO2AZ34fdwCrIOvniBim4mp7TdHb8Fu58w+XSLFb2BSwkl
         E8r5Hphmfov4V7JK9PTyQyrAmZ0GzkfDkhH38bErKeZ0sckdC4pHlb1Je/EjJLF1u1W2
         RosFucrAMfNKn0tSp1Y67utqyKvkvSEYRLOpBcoTiZmakVDZ45m9wBiEfuxRk0TNX23u
         dThzr+rEPCUUMzG9DWSx8ktxprsBu3d7zp5rT5CtWijMbsOlgfeiGVeAtb2n6ZDD2uKs
         1jLw==
X-Forwarded-Encrypted: i=1; AFNElJ+lOw70fPADX04XHiOQRq9qtHwhy1p80GyBz+tTdpDH5IL6C6lmp5LwCVsWkKY6wzJ+LF0tpv39lnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGhRRdCT4Gn1vhJO0fJms15QWt4PUeQ+V5L/SDgjobtH4Jh+OF
	zTA0lk5fOemX3nJhiQR6Qiypt8h5ChedHv0F0P+ELdJGgMRAHd5Lj862ZegWDd8bGkrg9l2RN8d
	PCJZl9els6RDw0YbDKVneXsViZm5b33u5UBC+n/b8USm9TNyn9G22uqxV/UwXKIQ=
X-Gm-Gg: Acq92OFtUO5yuEXFqI+2G1r6fYnpMAGw3QO/dU7BxDGGyRygBQ7KHrDMG6/216K+Rd0
	kuxA+qvJJg2l9a+SgVCOEIege3xnRuJYyMcoMA3J5l4dFdGwSqCEDA3MjH0NLnAXdX0nn/6zkOE
	IQTPSHOrrCDC8ZlJ8Zr+dYD+860JPrE9tAvQhJWC/ZjWj2hwpw6npbHF8SQbUwpMLlZMyM2nn/G
	Lfr5+U4a51o+4F38/P2PUcQYOUzGAMeSgyt6gA8QoSpz6RAQ7nAgAaX29IOcv4/ZqyN/AoJOAvr
	/p/9aVjFeYBKpdaCb6O4FDvWags92zB5VsK9rbJWnQE5AbqzCB/N3LnnVHI4Rjd7cTjH0Tu3LoI
	NjQOH+2gfaht487aMKT0azbMbBL8bG3BqnFLLRCM6279CWGXkHD2Wc3sYMcYK
X-Received: by 2002:a17:90b:5707:b0:36d:63cb:cf63 with SMTP id 98e67ed59e1d1-370f0f44b04mr3107395a91.20.1780647294317;
        Fri, 05 Jun 2026 01:14:54 -0700 (PDT)
X-Received: by 2002:a17:90b:5707:b0:36d:63cb:cf63 with SMTP id 98e67ed59e1d1-370f0f44b04mr3107359a91.20.1780647293870;
        Fri, 05 Jun 2026 01:14:53 -0700 (PDT)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04a0e9sm6241744a12.13.2026.06.05.01.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 01:14:53 -0700 (PDT)
Subject: Re: [PATCH v6 0/3] Enable Inline crypto engine for kodiak and monaco
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        ulfh@kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260310113557.348502-1-neeraj.soni@oss.qualcomm.com>
 <07a7d2f8-4a6c-d9f9-71b5-49a1dae693fd@oss.qualcomm.com>
 <CAPx+jO9kc7-QCV+ZgeeQQGdTaLAcvedLgvOpdSxqt4ezz-Lxhg@mail.gmail.com>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <cfd0d0df-055c-1e8e-3e54-4e781480796a@oss.qualcomm.com>
Date: Fri, 5 Jun 2026 13:44:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPx+jO9kc7-QCV+ZgeeQQGdTaLAcvedLgvOpdSxqt4ezz-Lxhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KL03rnLiXtEH7gi-y71SM8B1OoIt9CxZ
X-Authority-Analysis: v=2.4 cv=GolyPE1C c=1 sm=1 tr=0 ts=6a22857f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xTBwjhZbDR9UlUe_VggA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: KL03rnLiXtEH7gi-y71SM8B1OoIt9CxZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA3OCBTYWx0ZWRfX9gLkWQYtpXfw
 s5KoYky+GjI+zjPv1bIU2Ac7JUttm7XkNoQzQllhEnrZy5bRBfdm16YUK/qzsoHN7agShT0ziEQ
 D10wBDsF3VJlwiuz415QZ1YDEw3+Bt1Z971E77zDUbeSm5HAUTKxYJ+Pw/LT7bQzyuxT9pCWjb3
 Vxy9QXAKNbLUDG5IMpOz9BVjsF5fZ3PvqCXBWShPH+bFB8YzX34dCx3UNxNJ9HQYVtqCkPRR4jr
 R/vS334PKEF2yuW2TSMNyK5AVLsAMMdBdqYiCLxFohjXf8Skox494VBdmiWfN6l2qFTRUHj7trc
 GUtdgTV9/gu1KOLax+t/cmcADYKeRNEg3fUvbQpbyt6IoVQ5k0PTxuqaMUj0iDgUyGe9XE/5hqb
 eR5MezKMRBgicu7tLTTlhCXRZ7t6haZgf0CD7PVdjELu7dxZdp22ff7ynhDWN/U93S1/+/bvKlu
 VLhagPkrKkQeLFT/p/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050078



On 5/29/2026 8:26 PM, Ulf Hansson wrote:
> On Fri, May 22, 2026 at 11:34 AM Neeraj Soni
> <neeraj.soni@oss.qualcomm.com> wrote:
>>
>> On 3/10/2026 5:05 PM, Neeraj Soni wrote:
>>> Document Inline Crypto Engine (ICE) handle for SDHC and add its device-tree
>>> node to enable it for kodiak and monaco.
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
>>
>> Hi Ulf/Bjorn,
>>
>> We are looking to target this patch series to be part of 7.2 merge window
>> if there are no further review comments.
>> If if is fine, Ulf can you please ack the dt-binding patch (1/3) so that
>> this entire series be picked via Bjorn tree.
>>
>> Bjorn i hope this is fine with you.
>>
>> The v5 of this patch series was "Reviewed-by" Krzysztof for dt-binding changes:
>> https://lore.kernel.org/all/20260307-llama-of-massive-downpour-2e512a@quoll/
>> but i missed to add it in v6. Requesting to please apply the tag while picking
>> the patch series.
> 
> It's been a little messy to keep my backlog up to date while changing
> employment, please re-submit a new version of the series.
> 
Okay i will post v7.

> Also note, I don't pick up arm64 dts patches (unless very specific
> reasons), so that parts need to go with the soc/platform maintainer.
> 
> Kind regards
> Uffe
>

Regards,
Neeraj
 
