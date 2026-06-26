Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08F3F44CA
	for <linux-mmc@vger.kernel.org>; Fri, 26 Jun 2026 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473420; cv=none; b=EBtSoSNdionrhREN/cAXlDueB11Zw3lYHi9kkEN/kd4CFmtze44NEaRUCFC6pMEHy/GdxiOVNK0eP09BdyoiJzy+e3pd28b5Z05+EOt7n1xPoAhEMVN0GyuEnK+HvmRjgeUxSXnrHt1ukHW6Zjf4div9EHhwdEVqs6qoY2kcn2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473420; c=relaxed/simple;
	bh=xgMVoshPZPknzHZ+9CuinjN4yQSdGGJbwz7w1W7rtkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZVy08R9u6r6d/9AZ9kDrxkRZ+thvMgqLSq+FdCnCoKl8mxghM6/VWfSOH36v44f9cC3K5LlkOqaFgpD7pJTnywGbzzAn+vHh/ZrTNWooTHIU2LC1tO0VQSDK5dSchA8ULqX5czu99PEwvB5Mou+VMlB9z1gnU0qktaJd8DYqj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W47d+RMw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U+NHnjqS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W47d+RMw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U+NHnjqS"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAcWYL1052474
	for <linux-mmc@vger.kernel.org>; Fri, 26 Jun 2026 11:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TbMcTlgXVq3iWulTYE5kksxHge2wzzpefndBpLUCplw=; b=W47d+RMwTjTeZNM7
	xMtbtiXinzbPJz87HGvheabfsgn3iVn94I2ENTawJkdofoNGG8fc4ivtY19cieHG
	aPhRmH1F3YsHIfFuvzxwXQkPPyDiNGN8W2jG35fI9XP3rT1pIeUGG2px0zMXPSC2
	th9sHWIccMnG6MinJeG0xRFQZMlrM1GNOz/g+WJXmVurl1MnrUBxgO3zXlmwd+9v
	beu6+tllmi1dq77WYXqQqTJGs5ho8iQipCRjFcEUSURA0nMftySN8DhPJmluIFa3
	NH3Qu4TVsKkljVBBKIvwwbWTgr80/uUr4k2vyMwBCuCggR4iXVAJJZU52CZd8ibd
	BSa3mg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1ngggp41-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 26 Jun 2026 11:30:18 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-734fbe0e6afso30635137.3
        for <linux-mmc@vger.kernel.org>; Fri, 26 Jun 2026 04:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782473417; x=1783078217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TbMcTlgXVq3iWulTYE5kksxHge2wzzpefndBpLUCplw=;
        b=U+NHnjqSWHSnWqSm6a+nrpFTXYjjijBenODKlghspEZOvzHb8ip+vBaLQmgKWckQIe
         aU66QLA/STnYPqEr5qqAhb1KeCmBIEFCf4UdVPO0/tM5DbB6n4wk23dUNQCZpzjzpNr5
         p/p8EmpYELMJkvS+ZELmouq4WmH2bU12LnvNZwvYj6qKp56wFrsx0HvEEAnQFOsymnct
         Wo28H9ZEmTCFujdfBLOGjHeg7edeMZsw082Ka6K1nn4W2kkRufNBfsLFs8BNLSpgvA1K
         b2q2bmNlaT/RoWOLmT734G/uDJGIFdssOsIyWqLsks33VmCyGL8n3yQp9ZYLY5rJ386S
         WQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473417; x=1783078217;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TbMcTlgXVq3iWulTYE5kksxHge2wzzpefndBpLUCplw=;
        b=lB+2Dd6paXwIJl6/9VKwjJemPH9N2+fzQsr/r1RaGlYxvE96ZPGwLokUjBXlPGBGtP
         7yZ6alGG6LQsxGH0Tc2YnzBvdjrrEBIunjsSdsD49bddlcTYO6tOuAEbl7WXf7I1CuNm
         f2BCPQAdbkIgcNRM5kFIZuvadAWk2LNag6mM6S0Xx+g3jzdhHuX2mLPUH0j4yYGO+4EV
         hPn0UReO6CnBGdBFqVSt5Yey601EcDM54jWMkc0+/89yyXOQ98xw0b8EnMWYRNBUcWSY
         gaV7GEf+QtES467t1ZrSv+RNeJ09pyeu9avWYHCM5AyZTvxBlRBJzTTihRI9ECupdm5a
         TGpg==
X-Forwarded-Encrypted: i=1; AHgh+RpeAgMzv6hFkV0Mr74uGGwRGXohHzLY2CwstR8uzhqZfR4B4iXkX6cj51b3GfCw5CXUMI2IkE1S5l8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU/siFK+xRHMJxrpgvVeAfB1T3ypKbsfnqht3LsaGrCDTM/JUj
	BZhwWtegWlHW5mJY34O816Qie5BkwQDCtvarQfgfva/cnTIYFba56/NJhEYp5/OwIKGwi4zzH30
	95CH6M85isPsOmfxYsIR6qunzSkuwbTFABdBb5dGiQosxDD5lLI/Tbk30Cu6fKf0=
X-Gm-Gg: AfdE7clBz7CYIxgq0qPZUJLPaLyI/1HHQxP3HnWHAYwdUcKTglUJHiJ2V2qAZJGiIWO
	Zthi4iROHo3vi268eeXG4hAV8sBqhpFS86v88f3BtwR3OpxZabpKXSacpp9dQkX7m8IsGHGW4Np
	eCPGAPUPD2JKbEbGxiO30D3lXTq8SH/bbTKJcE2UhQd4sLzb4ej+rf8ZIH6lYXgBL/1PPxHuH2L
	WfdJ8e4v+SEd/61SDSPwL1HooFgUgz4dz7wlzPsnh861PxKTj7wCNEeoT86NqzOGKn3t+60I74b
	UYfeWCSxW0ZkX7EQWWQPe5i/8UZZUItS6o0tyyoZykdQ/PddjdoOexaNytAb4/0Yu6HwyPIIbFU
	/Z1bUZVgkPfF2GQ29Pa7su/sbnjFQG6SRgqU=
X-Received: by 2002:a05:6102:148e:b0:6c2:7d0d:e09f with SMTP id ada2fe7eead31-73433e3675amr1074152137.1.1782473417329;
        Fri, 26 Jun 2026 04:30:17 -0700 (PDT)
X-Received: by 2002:a05:6102:148e:b0:6c2:7d0d:e09f with SMTP id ada2fe7eead31-73433e3675amr1074124137.1.1782473416719;
        Fri, 26 Jun 2026 04:30:16 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f3ac4774sm2774228a12.3.2026.06.26.04.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 04:30:15 -0700 (PDT)
Message-ID: <0e0fb3af-968f-46d2-be6c-18b76c7d2a1a@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 13:30:09 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] dt-bindings: net: bluetooth: Document Qualcomm
 IPQ5018 Bluetooth controller
To: George Moussalem <george.moussalem@outlook.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johannes Berg
 <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Saravana Kannan
 <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20260625-ipq5018-bluetooth-v1-0-d999be0e04f7@outlook.com>
 <20260625-ipq5018-bluetooth-v1-4-d999be0e04f7@outlook.com>
 <20260626-discerning-light-swan-6b599c@quoll>
 <SN7PR19MB673692EBED649CF6DC9833A89DEB2@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <SN7PR19MB673692EBED649CF6DC9833A89DEB2@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA5MyBTYWx0ZWRfXzwfTr8U2XoEs
 eOznVWIhbmX28NDgHXlNYRqlSUzMNfx/qt2Zo4uLTW/YgibKI2BKwqu4xKyTWXAChVhfjww9y83
 0Ze5dcZqPe0Fif2n3lybqJhLu2ZuWYYDjyoU0v1ULNc+TDnmb2KDEVaPIvrMRQ4itDMbTJzO4YV
 2KwRjAY9lF15XhqhU1NNoer048ROdjpvtQA6VlrjIhhlazrT33A3RKGB2xcHiCy55tTlu34fI9m
 d1OzC03HJpVjiR6lYIoIfP3YSA7djMIn8/DEU8qgoZ3vtLAgE2SdsIRHmNI0xKZiF4anki8j+Qc
 dW7yS+Bfwlx+5mJhclPgh3CNK8GVBErS0E3rbsysGsr03oxOn3o1+2ec5y5D8V/+HQ//PKu7oES
 lZitK/gfO6ZGN08YE7MjN0mtNMu6LzBfhBgowCkobvGdyWpA3KNtYuiEjEHI6Jzd5GRdPceV8g2
 bMar6V5zzRLa5VEhBfQ==
X-Authority-Analysis: v=2.4 cv=KNlqylFo c=1 sm=1 tr=0 ts=6a3e62ca cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=UqCG9HQmAAAA:8 a=Q5Orqy1XeLiTHnkJztkA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA5MyBTYWx0ZWRfX4zh6RzxeSgSV
 aF/o7Gl3U4M6wx8A2vREZnkyhKPJDLcWuKH7RFhugMsl0tAiD9LHO3YCjtbwZFzG1s4hTEHwhOr
 R1N4+qRjpFYw90t8D0HV4LcgKoAjkX8=
X-Proofpoint-ORIG-GUID: Gwxn9VRBHjd3qTOG34hGps6aej4ih8K4
X-Proofpoint-GUID: Gwxn9VRBHjd3qTOG34hGps6aej4ih8K4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260093

On 6/26/26 1:20 PM, George Moussalem wrote:
> On 6/26/26 14:53, Krzysztof Kozlowski wrote:
>> On Thu, Jun 25, 2026 at 06:10:08PM +0400, George Moussalem wrote:
>>> Document the Qualcomm IPQ5018 Bluetooth controller.
>>>
>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>> ---

[...]

>>> +      compatible = "qcom,ipq5018-bt";
>>> +
>>> +      qcom,ipc = <&apcs_glb 8 23>;
>>> +      interrupts = <GIC_SPI 162 IRQ_TYPE_EDGE_RISING>;
>>
>> No firmware to load?
> 
> firmware is loaded by the remoteproc in patch 1
> 
>>
>> It feels like remoteproc node split is fake. The property qcom,rproc is
>> even more supporting that case. Shouldn't this be simply one device -
>> bluetooth? What sort of two devices do you have exactly? How can I
>> identify them in the hardware?
> 
> I wasn't sure how to represent the HW. Should I make this bluetooth node
> a childnode of the rproc? Essentially, this is the transport layer
> (using shared memory space and IPC/interrupt).
> 
> Most QCA BT controllers are also childnodes of a serdev/uart node as
> they use serdev for transport.
> 
> From what I understand, it's simply BT firmware running on this
> dedicated M0 core in the SoC itself connected to an RF.

Seems like this rhymes with the WPSS remoteproc +ATH1xK_AHB situation
- the Q6 core power sequences and manages the wireless controller,
while Linux gets to drive the device as it would if it were connected
over PCIe/ UART respectively, just with MMIO writes instead.

Konrad
