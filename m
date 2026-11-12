Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487469;
	b=1uV8ncpr3QX5Lip2RG1aphvVASQPHlqZf8OPcjCO5VybQPPOTRN6+HXnzhR+TP5IK0yi
	 iMnjl5B0b3A0zVMyKhoZINEJ2eIOrlYj2/pmqwS8aU4nv4rZcRj5DXbjsk477F7K10aWI
	 UYMPivH7P5cpZeD5Zyhqd8Yyaw/VGBU7bE62jxwZgmhWufvsOxLyTjb4TcVyjEGOfQgeK
	 hMndEcVoVMbo1yIKC8W00z0DBVIqiZa4k6hAGN5U/fJGeo1CZbnPdzrF0R9c2+X0//M5p
	 xaXYq2LRhIlWaqWfNqQVyQE4IXEHvMxYAsykHKcn60RVuNX8xdjYfN0U9SihpMig8XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487469;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ndzm97UXjzO2zWg0pRqAS944/ioKxwQrd2IcT2DMm/I=;
	b=JpwtnNlc2+iodw9VrxP0BadozCre01HMJKUKZT9eY08PT3lppmBWz2r9VlaLyRIwUbFP
	 FJtJG+FODCyQFnpnV6yoKj3HysfOpRLXzfhWMTVpqouxofXdlPnDWLIp18saA4VEdHwVl
	 tpXxxDIGg+je588YLInaubtaVh7+wYBJYUWwV4XqH0cn1k3TFwaxMwT+EUpMUouRhi0sB
	 JF/o+qEtowM5C4c8GbWL7DpCZHv85dDGmDluLOZGKovWM8IkeN+aUQkUhyA3KxSisHqQi
	 UnXQzrIJAcbYGJrB9iOIr2s1DTV4rjStWKECBF9GI/ouBfIun4o6FmsRTX+l7weBKXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EVNZUlJR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DhQoIEKh;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FF6606A31C
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 12:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73FF6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EVNZUlJR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DhQoIEKh
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACAUQVM1629024
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 12:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ndzm97UXjzO2zWg0pRqAS944/ioKxwQrd2IcT2DMm/I=; b=EVNZUlJRRrUaCrcB
	/JbhhqVCCHzdqixAxcdBYkLaiWK+0ihpKvje+kAyxOgngfHJdBvxbbBjSocVcqcN
	ZICIs58bFXITVRg9yQNzDycA293cZDhYEWK1uBtWPi54IvtD1gK6YOuxw5TrjmLu
	6iWQAZukSBlZ2srV0C42fB7XAw4G3SWlLcTkGkF1M2kDpQZUd86AZW5s4xxhvdPi
	i5Z70HMr2HcDqgedocFyBA++aJkAgjidL4BnDEhyOgoA8mhno/5+LLBZGGmhLGIo
	SiZ/uppAK47Uf0URtW9qlxKvh+LDhs+G2C5Qtvl36lWAWLy8CcfR0SU38LEpY5uQ
	4uBlTQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs00e62-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 12:44:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cbf2fd504so821864985a.2
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 04:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794487467; x=1795092267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ndzm97UXjzO2zWg0pRqAS944/ioKxwQrd2IcT2DMm/I=;
        b=DhQoIEKhTerOLm101PS/LHm2K5naeH+zx8s0GiikpokQ6kXx0N5LO6BQlNvvr8yCJt
         H4bqiJ2o9Ms39xR2w4Zp1aO7F4KeseukreEnoKPUybx31L2M9uk+NHQFv2P+AOeL5Fbh
         MWN1ji53c2Caim6WRdnVhpd+kmCN7QAksmlW5sm7+Y6GgQKpHgxurMbphsMDsYcNFgD1
         4K53l+J5/pA6wPmryK6LRo97PDN1YdUbjOorkkcduQtwwlqgFE5Pt7pfbN/o523dECJm
         Jd7fdHfeY05vjy7MTEDHVuVNt35464YxRhdYkz7tgTkw4JFm1DSbWt4klqen4DVcY63f
         KDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794487467; x=1795092267;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ndzm97UXjzO2zWg0pRqAS944/ioKxwQrd2IcT2DMm/I=;
        b=gT7FH0uTUxJ51whnehA5BshwiBTf2iCudeB1jw+OfSr+O4OQzDmN0w1kPCvFgE/Fn1
         TS//n16XWOh7/7NTGGYfgqH+16mBsVVjK3sm6QY2SnqW2xPd6FFtcBT+4SFY0APMI5Gn
         yu5g/vTYeBPZnk2+VE82lHpwYKY9Mf/SOYzCMiWkuog8P4U7+Oppc+atPiExWj0r/vRL
         kZMsY+OVJmZHQFe2wAKqRgrKoMzZvl+6bZJRlQ/WcYX679VsZiQWiLLT+eIs7BkUWo5a
         bTfw0bI/r3fXiBnSYgRFbd+Bvw5ltc/5RfyfAgWPcnR7rrChjCgFGpip3cvvaNcnSOK/
         DFog==
X-Gm-Message-State: APuU4Z/0rAffSO35LP+a7rwEq7jaNL/t5hcc/mL8SAc1+LZkM6VvZmuE
	P8uwq0ZRnyUyzocH7xIm+pBzrDcJiFnCcx1b4ugGEgb1rEheFeaf3o2GftUGsVKgDPQ8nnbC1jO
	voDHpI9Lio4DxuL1Rj6nSbenBk7qlIkidiY+24ViqBvzcnuda5lZYefOTcllO5n0=
X-Gm-Gg: AYBFou3P0OpYBmJnROTH2oiuAVZzjTZDc2876pxDNJiO+Ecv7eQ0uvJDn1N+GjbUACH
	XsWtPDHMQSn+e2cjEaotz5TRZflRRdHUkVmtyaNdeAzuwULPFYOqw1QXQPwy2ayY0VToccU7/eX
	2TXdNFoj7cPx34SnINl/lF+CEnRhF+9TNi9nu3EnQtmOOXT5PaIfNZLncMVyz2XVGZ07Uo1oyUl
	YtloKdr6FG30by1XZj76fGPtwb/Vlk7fko+IeBZZN7kQpi2QBqRZk/UU9MKPBkrF2JvUUcYYLAD
	zQ7fyiS9lezYy/2w5AOmxlIKQcu41JrqVYgeRHmIrRX473yVrLHfxE5UfKxAXE48+HSLLPg58xl
	wZieuTn915bF5jIZ/dMzj58fGGBS/9U89PcyntH4UVDzZ1evctyyYzlOMtBD6ropf3CvIil7wDW
	Pvc2iYlaHj+fluxXla+m6qZUp718U5gXdaB/vwgo2SUORUUcXWF51lpsUKojHIs9nfwqYuCKLvx
	qjq1E3vYlHqr4db0c4177FEzkTFZvzduJH8Bem7R4U=
X-Received: by 2002:a05:620a:1a09:b0:945:d852:15fb with SMTP id af79cd13be357-947b000a75fmr860379685a.69.1794487467549;
        Thu, 12 Nov 2026 04:44:27 -0800 (PST)
X-Received: by 2002:a05:620a:1a09:b0:945:d852:15fb with SMTP id af79cd13be357-947b000a75fmr860375185a.69.1794487467038;
        Thu, 12 Nov 2026 04:44:27 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a593b5esm342166066b.34.2026.11.12.04.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 04:44:26 -0800 (PST)
Message-ID: <132d4e81-93f6-41a1-a3d8-e6d6e43e14ed@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 13:44:25 +0100
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/1] mmc: sdio: Set
 acpi_device.power.flags.ignore_parent flag on sdio_func companion
To: Luka Gejak <luka.gejak@linux.dev>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20261112120204.98633-1-johannes.goede@oss.qualcomm.com>
 <20261112120204.98633-2-johannes.goede@oss.qualcomm.com>
 <339AA265-E4AF-4C6D-8886-AC14A8E32545@linux.dev>
Content-Language: en-US, nl
In-Reply-To: <339AA265-E4AF-4C6D-8886-AC14A8E32545@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MCBTYWx0ZWRfX6ZXVVojkRgMd
 4VNNLGjt74SYibgbvmJkcUoFC52BOxmg/Qh9P4xgNS077hW7WRxodQ2ESpUIIDTOofGkS25nN5x
 jeX54zOQ3g1kSn5FqM+EOh68aDuI2aK5flJbZcXbOczkfoOQGcfaTlaevBZxWWQ5mq/Bheg+Wy6
 6f7rlTwQkH3TTxPzuudxly6tuEQIZzvUfDVqfVV+LkoYQfbf1cnDwKK2WS/fzw7BzYZR65lzXFQ
 GQE7CJGVoaiAI6d4ULNeHqVTT4FV7HUqBLHffIJ/3+XeqPiBI3fbrFoyday1Q+RXo5sU6QtM56h
 8RbtRxB316IQ/AHViOuh8kB+7GIRI7h33ICFuaXgmN38naJv+MY8Tpo57vaah6Q2mi89csFVkRv
 ZoB8pZ5B93P7+n4Y81AxpvrTOgGO55MEl/reLZzYhoqwe3b4iq3VRjU290NDYxBl40r7d95TCpN
 p3yv8rzOO+x3ULictLQ==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af5b4ac cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=QWvNHL0soY4QXwqiDp0A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MCBTYWx0ZWRfX2SuTC+5UJgZc
 dXiwlPyKUmMu+vpRpvlrIM8pScNl//xfqeLpoygrQiifyDsvgIa+kZmc3/IXrvSWaxl+ajsLarq
 I5Rs+gYkb28Rh7ZH0GrRc9O0MEULT9M=
X-Proofpoint-GUID: RgrXox0AbXRVtz3lne6WHMzQZYAoXrnz
X-Proofpoint-ORIG-GUID: RgrXox0AbXRVtz3lne6WHMzQZYAoXrnz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120050

Hi,

On 12-Nov-26 13:32, Luka Gejak wrote:
> Hi Hans,
> 
> Thanks for the v2, it looks good to me.
> 
> On November 12, 2026 1:02:04 PM GMT+01:00, Hans de Goede
> <johannes.goede@oss.qualcomm.com> wrote:
> 
>> @@ -402,6 +423,8 @@ int sdio_add_func(struct sdio_func *func)
>>       ret = device_add(&func->dev);
>>       if (ret == 0)
>>               sdio_func_set_present(func);
>> +     else
>> +             sdio_acpi_clear_handle(func);
> 
> This clear seems redundant, since on any sdio_add_func() failure
> mmc_attach_sdio() ends up in sdio_remove_func(), which clears the flag
> again. It is harmless though, and I don't think it is worth a respin.

You're right, I missed that. Let me do a v3 with this dropped.

> The commit message has a few typos:
> 
>         looses -> loses
>         safe todo -> safe to do
>         wills -> will
>         inline with -> in line with

I'll also fix these up for v3.

> Reviewed-by: Luka Gejak <luka.gejak@linux.dev>

Thx.

Regards,

Hans


