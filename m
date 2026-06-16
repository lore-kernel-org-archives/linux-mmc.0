Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEA040FDB6
	for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2026 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608421; cv=none; b=PrhXhs/tJmYnscXvXsd2tU3M4AYlkuHaNsMQR3HBviwjM/PGgj/HS1TJazGayAy2z5DRZ28C8qGM0xu5Gp58l/N1lP/F7+kP7pYsyI9muOtOcOVbXuqeINVsuX7LGxX598f4xwQD/GjdYvfz2OfkrPW4cz8/Gw1p0IwJCWgFV5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608421; c=relaxed/simple;
	bh=55ncl2+pNbNqu+wEL/BWAxYJSg/Eb/jmWeFv/fJjbr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgt4Knjho+64EEi8ol+NTBP4Wz1bvVGqKQ4thTQNqHzPABXaMDFaaRB44CqMLL3+NTdhDTGOIIU3QA/8l8imZyeFjI6/IIWzYiD8biTSkKpJzFDIbxJtMddyL8ThPWjtaJVt+EFEWk9neNWqhHA3BbEvQZ21hzaVM9+634j2P4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lseo6HLi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hDkncOs/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lseo6HLi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hDkncOs/"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GABqus3384251
	for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2026 11:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iSr8MoasSHBE8JNNqOM36HV9oQteT/dMFprDB+IKzdo=; b=Lseo6HLiLxDnepYo
	dStkJc6pCcLu+CuV9IburIB/oYCviQbeg6XIMCB9Dha/QS2e7h5rFC0Pcf+2S5qk
	nx3SaNtkhNDJOMwygLHnkv6JUqYo0wdYyXWsQ/4pYD/1LupBk5mqVUl/VMcIK8YS
	Ne20mjXBBY4Qbyi02BqJnd281ILMo3q9I54yKddglu8+ad8pSpLKVCQr7iJvttNW
	E1CppnylcPShLDUgnOAQuxJ9QtJB/dyzGhOMJ03YXdFfKEMxt6fGPt1vjcPTf/Uz
	in/LD8J64uyZiKCDAFYM1LJs8lTEh9uohm5XZ+5kIHQkDgKlHmASHq25ImLKS/Cj
	1uxndg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1ep93tf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2026 11:13:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51968526a68so6239911cf.1
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2026 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781608418; x=1782213218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iSr8MoasSHBE8JNNqOM36HV9oQteT/dMFprDB+IKzdo=;
        b=hDkncOs//ouCDfkQmpBjeKez7HD+KBqszxB/5Pv1/0QYXBPO0Kws4l805m1XiYeA0S
         XD35WchftmCtjxCGWmeHanVE62+HvdijG35mpVHkLq15r5wF9dqMsemAUd+OVfBN59lx
         exaK1d1SGWE9ZomqNEfxCjhVRtO6s5yrEfOKN58FUNlLuL5bf7DiLXM5ovwv2xJwrJJN
         hkTGAMTZdRcoH4KIg4M9fynGr5ckH6nLyruB3ZryB4kb0xatwiYtvb9kdNMsEnvuYYSK
         5jJYS89+dSauhDm2iR6sm1Tvp77qSvxqaFRllh71WMG3aMHXDonEr06yt9mKo8ZGfs6b
         +6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781608418; x=1782213218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSr8MoasSHBE8JNNqOM36HV9oQteT/dMFprDB+IKzdo=;
        b=NfeG/cHfI1CKu2DCyLN75C/QFH8J33TV/GiUiyN6HGubnE3N87ZUEM5HyjDSzxazUZ
         iInfPmF4PvKu3vFYHHZCWppTxjJWkvCX8VnEjPxJuHnLvnYqERiiSKwNBKruZTBWIUzo
         fhVfwEnGPB0UbL4q9ZVxzBUZaqxaxcmEiTjs8BQ6QcEEtNk3jqDo88OK0w1adipZX8JL
         HpxJm1/1AQAuL0jQup7HesU//BPzzxhFGqo/NY75BkjXMU67YNefIyGJK++4wsVcgz8U
         v7ZhF0qD+TURAPXKDKZF03GaU3ErL4O154qUFz/P2Gf7SSWVgZYjyAc5VOtRAey1YXIB
         D1YA==
X-Forwarded-Encrypted: i=1; AFNElJ/1IpJE6LWVtZZqi2JY+BKa24yIzjLlRogxwSkVfSzwTjEFFCyeYJMw6J6IZO7Bk+XDajurvs1ffnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzguW0U6JNJlLP/l3Io3s82o/lA0TnP4wahUC3xuezQv7QTymQp
	5T0gOBafViC48TAjsuuKS7OW9I69MVljS0/pAndQYX1J4YVPrCN1xaw7mEv5zByeMW6/MXbEiVF
	bmPGzWANM9jgzRtOhNX0qQqR+059yWx9F0CPWr92pz+TzvRUCa2iiRsAAZl8SJeQ=
X-Gm-Gg: Acq92OEdeEealUw7cTmLaPmOOm5zBWpyBT4TDomJSX2Bdac5q9AokAeIhNpdHb7EXya
	yLEYT0DVKmVUi1r/vOaoqZcki/FygrbyoCkEnWihtDl1ZG/WgRJG8D7GqbD3sjN8IK0NTD9Xbn/
	wR7YwsuLLBQj7niRHRg4pv4nnxkhOdm+vXHrmJ4RLZXruwI5vWPT4pyrgnRYs+7LDzlE3s8u7XT
	aKUWgyQxv3yIaNq4vO1wsZiL005Xoqb3FOIGU7pKskR8fIi+WXnLZ+bG+3eNNiO1mSFxKG28k4i
	8iD3RQjGzW3hxa14DI0NQg8BJnx/j7ejGw5eCpYgKLE0E7VcdarCZwRLU8jvxcPvMq4Z72mfwv9
	IlVVuIvziP5vfNnHhcYlJ6BwW7RI3iD69QQe8tmDkfTL80g==
X-Received: by 2002:a05:620a:458d:b0:915:769d:56e with SMTP id af79cd13be357-9161bab4498mr1747054685a.1.1781608418339;
        Tue, 16 Jun 2026 04:13:38 -0700 (PDT)
X-Received: by 2002:a05:620a:458d:b0:915:769d:56e with SMTP id af79cd13be357-9161bab4498mr1747051785a.1.1781608417897;
        Tue, 16 Jun 2026 04:13:37 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb7b6dbbcsm648217766b.32.2026.06.16.04.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 04:13:36 -0700 (PDT)
Message-ID: <12b8d20e-06a3-45c3-a02f-bde79f31e8ef@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 13:13:34 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcs615-ride: fix sdhc_2 vqmmc-supply
 for UHS-I mode
To: monish.chunara@oss.qualcomm.com, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org, nitin.rawat@oss.qualcomm.com,
        pradeep.pragallapati@oss.qualcomm.com, komal.bajaj@oss.qualcomm.com,
        jsodhapa@qti.qualcomm.com
References: <20260522105020.3588377-1-mchunara@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260522105020.3588377-1-mchunara@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=I/ZVgtgg c=1 sm=1 tr=0 ts=6a312fe2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=6BLkkuY0k0j_y3qHMkoA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDExMyBTYWx0ZWRfX9SSZDzvkV3z2
 sKZupbgzo04BIeP4duwBpOOQ64jlqJ2udYA8+7tw211rm50aUSaUx6vLQf9T/qyjO85ueOZxcRp
 PyJ5esneQVnbTGsNkobLD5BYidwlJog=
X-Proofpoint-ORIG-GUID: I5Ii1IkbEDpIf_WMlZU6KWAupHU5qBou
X-Proofpoint-GUID: I5Ii1IkbEDpIf_WMlZU6KWAupHU5qBou
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDExMyBTYWx0ZWRfX0N5WtRasM8IX
 8aMcsA0fYa3tqXLTVtK9kv8g6I+wxD9kwoAJM+2nQ74COi36UPh/+NojASllHsdO/nf40c/mgYO
 htk3wo4z2n412XIGBqKJltZyvT6JulrcbPXrQpg17bnRz5kDSiqpfDw5bNzh3JFOKeZyBuxoOK1
 Dj+OZ3bvaEyOwULOfhmbqua+EWSSp2GhTclaFcxnejH7R/2M9GlruIchZhy/OLhIwtn/oo2R3/Q
 5M8YHr6JrsEvNvsEgbEuw0vAv/K4gnsdFLbnitdoDzuNdUoH3MGQN2iEqfmbfWxQrmi1uiVNj9n
 HmAbeSVUL1wleoaz0JHbsgc3g7JxHzE6ct2Y4sui1TvOOeu1/jnTiNLVbn0u4JhOwHTL1A6YHO0
 xy2bAoVU3/9trktB5C2il3kv3R+GoOo9NiepTPo0FRPxUKRV3kVwcGiroNMbVm6+PGJU44WAgQt
 30PgLIUvrxv5/uFRQIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160113

On 5/22/26 12:50 PM, monish.chunara@oss.qualcomm.com wrote:
> From: Monish Chunara <monish.chunara@oss.qualcomm.com>
> 
> SD card is detected as SDHS instead of UHS-I because sdhc_2 was
> configured with vreg_s4a as vqmmc-supply, which cannot switch
> between 1.8V and 3.3V.
> 
> Switch vqmmc-supply to vreg_l2a and update its voltage range to
> 1800000-2960000 uV to enable proper UHS-I signaling.

The way the commit message is worded almost makes it sound like
switching the supply in DT rewires the hardware power grid.. 

anyway

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
