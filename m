Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DB73E168F
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810415; cv=none; b=ipaDXq0hcyd4MBh+sx9L8dAit3CiqjrIaKfrT6vzR83gVg4Zog08L7kNAAFuppX2tvBey7Vic1Ka4xkbY7FtxowU+QpNpXvnPDP/ObaavQU5wQY7Bw1B1Z57uXFN8C5+1eXhMhoKvBpF5cVfvre00ZQ2MOwwyRGyOGFwYlZeCIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810415; c=relaxed/simple;
	bh=sfshIF0RhF/xtW9nVefxWAOalPUL9Z+YWrGdIhMX47k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jV1vEx9diT2+c1LrBwYY1gncWyfvHLfPskwj/Sv75Y64oGD7LvtqjGr/Ql+rUvb0agW7gETTZun7AIWZMTqiPkD0dt80g0wrBkT7dtOZfM3xh6VUw9Ikhr4I2EQdd+7ubRPqeLjhv07gMxV3dCk/38GGvv3sRX22Ye2rqKyJhuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hlf84YcY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TjodovCt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hlf84YcY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TjodovCt"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U6CKot1089388
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 09:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ngPOQwjwk5Db6ClM0CyokY5GomZFoDsLXDPpDvOhZEI=; b=hlf84YcYkWaYWPot
	W28s5AjP/9pYWQ03Susl9ECzqPRyWDSPCRq2r5Bnyp3gOMLMRUa/CyoFL7tp6lHO
	YdNXuNXfIPn7EBJOkUvdoY+3zhpmtZF0T7LG2jhic6IyMulwJHEnoucZQ3/RpTpy
	3N51YYHPlLqkfQpLyFejn40i0QS1Zur7WfilZKKtg7BD+5KYxjx9obEymXNnKKiu
	JJ89Pc/4KSlfd67r4NnTODf1iIoCIf8KVh9FbtaKy1CwWKn7Gaw7T1UbDymYhEw8
	6BfyN0pBnsDqAa2pKeRNwWmGn4hx8LFnNW01tSxOzw1g6PJYJuULOhu86O0/Y6vd
	ntT7AA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f43vfhqsf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 09:06:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e6cb57d25so963685a.3
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 02:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782810412; x=1783415212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ngPOQwjwk5Db6ClM0CyokY5GomZFoDsLXDPpDvOhZEI=;
        b=TjodovCt40OfuyckoZzNNktsjQlJO62VOqU/zaEOmnW3UceDkNlfvUcR5murMNzJze
         fjFOqpG75hkRAqYmZ2g3PelzNfcs0O2XK4wzEdI2V0jIr1lxtWQBncjByP7NiGDY7xx1
         gB8NRtL78AjKVRKk8rfeYzn+j9HYFRlGKJkZKpbDVh93S/zFN5Las/S5Q5BZ9lIw4z44
         vgyJtpQ/MAk/B8o1oGVHBXARhDITBRsjCj7L/1q65eKJLd6J8HpwaBOgZBBJsMJEnxyX
         MwGnjK6DXgVNh21nYYECNMsg3hTe8o6hppLnMWM+FvnJcp6/DzkVSqLCtndUWESWhg8K
         WuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782810412; x=1783415212;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ngPOQwjwk5Db6ClM0CyokY5GomZFoDsLXDPpDvOhZEI=;
        b=s/M2Bcz/AX8I5vIHarUxj9LudM4I5UlJ41VJgUdtdsRLnuucJjX6AaWBEWSHrNkyZ3
         NDFpsWQCzrWH+Nhg/ZFSujAU/tBBSZ2ZaocaIqyreeIwjAjNQzLn0376xiJTLrFBrEfK
         3qEO9jsOAg35FxpOWZRR/4M/nU3wcisqXUTCOyaq+/ZEoFU6WshT7AMBEIQv82P38Daj
         I9iq3Edua/Ks/JMSweWd1V9Y0h4gKG8GQChcVgc4yZaHojULLRyyTUzYB6X3CkvmqMHQ
         vs8gvx+Kl0RWUlasxlrDlFzMSUnwCnq+mkSlROV6KBva2RFhp0JByrC/XAiwEaIJUSED
         WlkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+lpHuzAGGsLd1noWomhElrCZ4Usr3MiDnYMX90mAFGDiM0BpRkgTvniT2Z0n1Wzq/IdDCDDOCTC7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFhXPSjfNmqUcUM2pEWz4wz9SC4XaOSp7ipKpjEDpf/ZByY2F4
	Gs6yMn64Ym5syoo/ITO/5+dEHA2RymqC/iQQimoYEShbOmYQnB9t130ucioJ0Jv0A0I6k7gsE4/
	jpav9IXbCeYnD3fjHCE24oQ2qhJFG6U+LNMaQDSni+iSjo7ZMl/j4VBWav9xAg7I=
X-Gm-Gg: AfdE7ckluo3Ji5W0Segw8/+NpOO1FF2/fJx4/p5fB5dczdN4IqcYKnabVLu+27CtbEF
	c6UNu8WcERlqzAd6jx1n8NtuIQknDqOrm2sIxbKt0FUNdc+yYUFb5utSkS3ao/senonEBb3g4xY
	nGmHyTGHBYA5Gh0u4JfGrnG+LR0SelVS3EfvOho8kzpEGHl30Muj1ovM76lZXjoUpFibu99WzKA
	X+kvqMhPgu/yyxqhzy5GiLBy8IEYyd9ugPxLN2jDilhPQS/tKuYq4LvfLgdO/0JXfuM5AHZD9JZ
	gxP13v7vV1+rf4asKVV+XhHqfi1ZSLs2HG+oJlrUGE2dOSQSOxIRLeY+SIt0DYYkKug4vWx8l1O
	DSB4VoqE6DIuN91sP0k4gbON//7sA0zk64Ig=
X-Received: by 2002:ac8:5909:0:b0:517:5e32:f3ac with SMTP id d75a77b69052e-51c104ee712mr23691231cf.0.1782810411943;
        Tue, 30 Jun 2026 02:06:51 -0700 (PDT)
X-Received: by 2002:ac8:5909:0:b0:517:5e32:f3ac with SMTP id d75a77b69052e-51c104ee712mr23690931cf.0.1782810411352;
        Tue, 30 Jun 2026 02:06:51 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1289176ee2sm88818066b.58.2026.06.30.02.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 02:06:50 -0700 (PDT)
Message-ID: <7348d7e6-18b3-4064-9fb2-932cce76816e@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 11:06:45 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: net: bluetooth: Document Qualcomm
 IPQ5018 Bluetooth controller
To: Krzysztof Kozlowski <krzk@kernel.org>,
        George Moussalem <george.moussalem@outlook.com>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
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
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
 <20260629-ipq5018-bluetooth-v2-1-02770f03b6bb@outlook.com>
 <20260630-wondrous-lean-stoat-be0b9a@quoll>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260630-wondrous-lean-stoat-be0b9a@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: IPTJbaacfz-vuFrSJ5veiPaALzNRpEGK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA4MCBTYWx0ZWRfXxKg8QTvunmbj
 OIVYZrTiR/lYuewrmXugLKtP3r/jmhcEDsqM9rhEfL2v9zGSg9APTx6FTgFUm24FvIejeL6UJZ3
 kq7OOtDXA2w4OyLASY01bxFdiMdZpexYXyZE8iIDQmavFuPCoAQdL9bNiHy9esWY9rmi+xBh1kT
 HXdOAdOlw5Us4Qj2uuUhp9ImqLsMXexZDgJstWxfChIq1LhGJNj69GSdKVj9ocX4LUozfQNbrdX
 7Zak2dtR+RWLPHk8bRiqr67z5kaxwMIkFm0oTbFSm9x0UL5pHzNvjQTd8dDS0+M1CempzIi4hBj
 KiTSL0wpJ6PQxxH69Hdv8FNRRUOj6OwQ/o59XgDmUD9daI1De1xlC1DwW48lQT8B5rf2pn8u9i8
 JQzSTqi/W0pZfshb4ZdImiMT5WWlCU7BVTe46nkFStiB7kT4EDMnN1cud6ZWrtflpiOBAbbfB8D
 Uavl0aiLhwydd+i9ylw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA4MCBTYWx0ZWRfX7AOJ7ZXaQhqY
 3a2Gc5YlO0frsGqcbDj8O4tqxNNRt7CgaANcmMvnj2yL7MRZKGEXuCrUBNf1BbMc2SsLL9WRdH7
 RfnDtpJsBF68TQGajnn42H4BDeYL+sQ=
X-Proofpoint-GUID: IPTJbaacfz-vuFrSJ5veiPaALzNRpEGK
X-Authority-Analysis: v=2.4 cv=PcXPQChd c=1 sm=1 tr=0 ts=6a43872d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=oV5YwiDV2Nt2AUhp6S0A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300080

On 6/30/26 9:15 AM, Krzysztof Kozlowski wrote:
> On Mon, Jun 29, 2026 at 05:01:44PM +0400, George Moussalem wrote:
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
>> +
>> +    bluetooth {
> 
> Don't send new versions while discussion is still going. I need to
> repeat my question - what bus does that sit on?
> 
> Device nodes represent real devices. Real devices sit on a bus, usually.
> Do you have here a bus?

+Kathiravan would you know what the remoteproc-driven bluetooth is
connected over on IPQ5018?

Konrad
