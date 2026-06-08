Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E936366DC1
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2026 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918175; cv=none; b=VGiaOcPTSijg/7vlOiIcrG3bE4uCg20xxzO4zPVoUMqaX19lp5KtbvJm/U9mBcmxlvmeIrfZ2zY42oGrHovQROgCkOLwiAr9685H+o61YYGTXUvriOQrFM+Eajib+2oXAiszxAkxNzHXr5WjfNxStUSoz3Zi7SZZe+ahmUbPjVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918175; c=relaxed/simple;
	bh=J3+cUGQtV296Sp3DrkXESZjqtBQ7EsKWbxudP8Kp5wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Di4WSY1azFx69kB9uJrK4yXVmcit/v6OIynUFzHv2hwGs1gZB5jjLCtGNACHjzZqfi7zH3fkXIbtXqEpp20nH6kaT/uYZyNxIWeEYInvsG+1f0iOKVEeFXKlOf07eRvbNVXe025DFQF3BJ4yOgoTuc4dQWEAVJcxpXlinvh9vN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iRwVfBpm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZJlELmD+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iRwVfBpm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZJlELmD+"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658BBGCa3417500
	for <linux-mmc@vger.kernel.org>; Mon, 8 Jun 2026 11:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kfS3gOfl7UBIyYndiCaeSVmlIF6ZDOAgaactyCrKDOw=; b=iRwVfBpmn9UWi8Gn
	iMoh/T8wBP2us0Rs8mluNRVdeQKRZ11cqeP0rF/hm+cyM1jtljsbqKKzUEc0vM9H
	ijnpWH2vG/fVsIJM+U4Guz2meoXIsgmh2HT+U+EOdEqfrRvyl4Pnr8fW7IVl22vD
	NVGlqnfuFuNgPEQH2vpmczSCZmylyZJ2/mdlHDEXZtbIDSZKhxNn76PWWG4IvR21
	uEynevaOERdAM7stoKdbQdKNJdclTBHnbN9axSkfvr2YxBCP7VtM7VvxLtGAVOra
	GAi49/J5mJBvzrlsK1fkd7fvYzuFIXKi9uU/p32AeC+OP+ZyszftvVV2ybJ+Hvug
	TyO2Cw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enuptgb5h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 11:29:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-915a4ca0a4aso136539985a.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 04:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780918172; x=1781522972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfS3gOfl7UBIyYndiCaeSVmlIF6ZDOAgaactyCrKDOw=;
        b=ZJlELmD+9hX+McTEqE8KPs5XREt85CUJ2PnLVDwatXqGxFJRlMpm5J61NbFUhQwC63
         bzUV643Ab+w9y790kfXtldtYJZZCFdjWBMRWQikkICzlHn34lvZh+vuxlg1UWo08xTJd
         1bChpldO/+v65ew3gR6pdIEuSfZpYJougrMrGUEEOVjqKlLl9ztsKH/gbWim8fEAo6kf
         9V9JzNyP9DnCo8djPfl/7Fw3wrg3t6BM832DKE2nrD4s6zD7IfkO7Y7IX3gORopJgXt4
         nYfQ3xwAptQLDVsCeNwDiNk/GF8xR7m5xPqGQ8QSS+q6Q9wckoT9msk1VIlaPWfi1GPg
         KVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780918172; x=1781522972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfS3gOfl7UBIyYndiCaeSVmlIF6ZDOAgaactyCrKDOw=;
        b=KEZvj1zFqr/bsDP5foyic9dBf5K+SIHEqBVRody/FMdZ9sG2QmadDeTwKUDL+q6Wq+
         88zknWu23wUKtlvktvL9Ehp9kKJqM+Fq6gRHh0M7qSV4INpi8pZ9R+dHULFjD5UMxUrX
         ZhVfPYNNz86jH9sof0j0zd41fuZP8T4GM9UAd/nlYh/z5NamnSRMeqxcfvBlbR0I9sBp
         tk9Bi3Fxp+VAEjV4q/XXzcMChR01xKq0VVUXvr3wl4veHf8/2ahvv8ZyY1ZGnpbdggy+
         IBXtPlSMWNgTv+BAcw8myOIw+VY2eEmf1QatnUuHP/VbMcMSYngHGathckUCWiZyXU6O
         p82A==
X-Gm-Message-State: AOJu0YzCTE9qEyFzwwR1bYZinx0wckQKRSRQuGqv6/r0J3A9rNFSFoOs
	+tzBTnWsuiM6G5qepT43ulVO//stvRlZoKVxyp5cAokRUK8c7mHfo+xdtT37yM8e2CzoHgT63TD
	2YJ+FQ9JVZ2oKQEhM3YavWs5wnRt6DD6HXG39VZRIyYjD5NHZrLsDbegYGBQJmJ4=
X-Gm-Gg: Acq92OEZBBAMXxH1VtxGJAVnWWbyiaDIutvxRfCK7sn+kKMSmThqGfpFJQ5v+ivkGAx
	BAMHcr5hZp5gs/JiHhwZV2aFQZZ/sJdDWLwO5lENS7x3/67FOsh+QP2Yo0XDB02ciaNqeNfEq3i
	csq2jtY4vhkIkNw/9T/u72oJb/f170xe/fAEKz+jNmnFvhbDZf8MMW0/hpBckMYSLFbKWBKDxjn
	WiKJlIjGeA6Uo17suAunmtdiY9AB/iIAFYJTw2gH2L67l6YeVZCN8+GE53le1wWQwRD5+vpADla
	Nq5JCCuQIq2KoSuT42uaAWkCU5GAUjYbhqJDi0itH9cVP1WzqvgLmTBCLSJSS0nnrq8XqM4ZlvI
	Ew8DbFFW8Kp5wyEqh67CmRDlI/uMpg9Js/Ed+hCIG2V31eRCWHhSld2V3
X-Received: by 2002:a05:620a:2692:b0:914:c589:7945 with SMTP id af79cd13be357-915a9c76410mr1405356685a.2.1780918171977;
        Mon, 08 Jun 2026 04:29:31 -0700 (PDT)
X-Received: by 2002:a05:620a:2692:b0:914:c589:7945 with SMTP id af79cd13be357-915a9c76410mr1405352585a.2.1780918171578;
        Mon, 08 Jun 2026 04:29:31 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055309368sm844667266b.49.2026.06.08.04.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 04:29:29 -0700 (PDT)
Message-ID: <f528672e-ab4f-4844-bc7c-1f8f1c4dbd3d@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 13:29:25 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
 <20260608-block-as-nvmem-v3-7-82681f50aa35@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260608-block-as-nvmem-v3-7-82681f50aa35@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MvScs6NokI4fuulN1f2_fIMfjLNo20JR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwOCBTYWx0ZWRfX56Pf10sCBG7A
 3YAknOumykQ4GjLfo9sxl7rXAaU1bFu0DHzOTI+/i+rteik6Unoi1rEMvOEHYjqc9558cvLaEUF
 G+nlbDKz3CvjPjGAJlo7Xs5RWuspylVgooBwD+zCgAVPJ4TkCtRAy+XGZCheRbNiThhQKBw4z4D
 R6CGndltwteMfgCUGNkT0JCFqfl8w8o7EseLK7+ZGYiCCB4ys8H1wFKQQSeClp3NYZ6MgCk741c
 0VTqfrHkJ1k2erILaYX0uPbp76n/EoAV7l9ztTjgT0iDd+wcEnDnKWctOo9xxXO3Lws+VX1DatV
 iri/hrkKQ9lKAzBT13OMzfXvZXpNAYh0RKzbapogvDR6DkmHsswFN33hzL6ZoGYp3t/o0G1TZkL
 zLDkDW98u2W38+YvqpI37E8DnzEfbnxgF3tTKWpnOBXy/zy4ZHgCl+dOj3PBN45pnIUiaw6wfeg
 X7nZquGQ1Mt1mh3/nJw==
X-Authority-Analysis: v=2.4 cv=XKAAjwhE c=1 sm=1 tr=0 ts=6a26a79c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=m9cM9ScjmTDVYK95jDAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: MvScs6NokI4fuulN1f2_fIMfjLNo20JR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080108

On 6/8/26 12:50 PM, Loic Poulain wrote:
> When the controller BD address is invalid (zero or default),
> set the NVMEM quirks to allow retrieving the address from a
> 'local-bd-address' NVMEM cell. The BD address is often stored
> alongside the WiFi MAC address in big-endian format, so also
> set the big-endian quirk.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 39 ++++++++++++++++++++++
>  drivers/bluetooth/btqca.c                          |  5 ++-

Squash mistake?

Konrad
