Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793990498;
	b=Gt1C5bebJhOqLAtsckCnE32PKF6yWtRoNN6Q5huTBP7rdpiHQMJSrVJ1Ar6OF/p9dDRP
	 SABJRqOEbtYuCGrrK0CQDHk0GNbwHpzxrZ5Lv3Yisj/yu5OsQJ9rtTZ81QrWFLbJ/UFdd
	 JP88HyzkBk2m/mUSPJ74aiSH4nydmiGXApyKUwJeTjRxlg9hMLSn/vrAeTI0MVUwYOFBi
	 NFcR/RIuTRYEgLwQrmyOitzpgxiv+BGOy5NIsg7jvIZR4/k1vqoUMFmA4cvS3gvUWxJ65
	 GJgYv/8B1qUFXTq3yaL2Ouqgw5sRiKBL1Fkzxk+Q0Am+1IFh4lcnhTx8NIFuKra1r9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990498;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CUMcAVyOirUSnIO4z8+9Oid/43N5zWiqbL31INqDBvs=;
	b=Mt5cb6vHC/JOwSPzFI59PuBJXPv/6FxAVH59HTm9M39FpGOP6kkjg7Ingc/uOHJ8r7rx
	 MK7noSQm33s0y+UMbGf2R+f8diWmEgGC6iDIOGQ2gZqA1ZaHLodSmq102fiXpgVSv1V6Y
	 rLOb+4a6w5JC04Wmb1Ngb1vZ7IptvqN2yzWMjJW7BsXfBINQr+P97t/leyfGpRuFslCTO
	 FwKmLCeIpPk79xtQ4CRDue9/fHg0yihQyMEj+gOM6PrO0ZL7r0Fmi1aZu5MpxIh/ilaGt
	 uT5iBit/APOw1RJ6L8ofsKJCnBz2FZJBPueqlzz1AJ+6azjeqZ9+ZFb4sPw7HwMly4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c7OqdLX3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f7DVpUc7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D3E606A32F
	for <linux-mmc@vger.kernel.org>; Fri,  6 Nov 2026 18:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51D3E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c7OqdLX3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f7DVpUc7
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6HtI3M1100827
	for <linux-mmc@vger.kernel.org>; Fri, 6 Nov 2026 18:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CUMcAVyOirUSnIO4z8+9Oid/43N5zWiqbL31INqDBvs=; b=c7OqdLX3Uj+TBpdC
	oqL865Tb2uVszHJk3qkJYH6kLQvGw/yVPe6PI9eIRv15udAcLLqG6UR0v9x34VPd
	rqOFHoWdX+ilvD3r5k7pEYe1VI5n7B3aAYZKqLOE6Up552R/UgXhV6aSMi9iR0yA
	yXzoSy3dAHKYFyDGYsjF0bFbKFzX4bSWKc4hAqH+2ALaFsFQFLjcpV1DtQ72eo+9
	qTjYx7a+EgbYBZorVurnW67Rzb+RnfTxqD2C91mr/i5oAQvuO5qVl3Xc774QSeV5
	+Vgo10VEpHJG4XtK3CxlUVQaishxG9jh3seF7r1am1bVcchbbT5EwlshXAn8bfsy
	ytBfMA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pav6r7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 06 Nov 2026 18:41:37 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a06da65d92so714005b3a.0
        for <linux-mmc@vger.kernel.org>; Fri, 06 Nov 2026 10:41:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793990496; cv=none;
        d=google.com; s=arc-20260327;
        b=lnMt1rsIMTy2CshROyzS8XZzby7aYjfsRlPo6WnQ4z9rSinSPgrZbedmdVekBi+km3
         aTqtOvhw3bho3s7X1r4K5zYkbm5sid3oR9hR1D/LoBX+HK0dRspoikCO26Jpq7tsSuXn
         l1nx2dttQgDu2/hVk7Sn1J3pJcaqSAm3GPAHF2TcYUBFwIVx589dXBQHWTXCe/J2cm5L
         7CG3RDfPPOglUblOY5h96wMrCf6VwTB9exTwGeKH3TAL3gMmn+M/MP0pdBjq1x1aiOf4
         m4AsbsR0aJMErciIPpxJZItHTdeEV4i5bE3cpdIflJHSqNr9QnCfuZ60Mi58DnwuVzzk
         aDfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CUMcAVyOirUSnIO4z8+9Oid/43N5zWiqbL31INqDBvs=;
        fh=fq82BfcEqCZbF0nO1/Ylw6/8DcIirLzbEH/HZSinNXY=;
        b=q551J8E6WQu+jVUzl10gZEKXINUNoBwoHJT+cQQasBM6Jc0RCdVf2RdwFgdniygeoi
         EPnE9ylFoYJ8/C8hTg7E/uhhsmAsI7riyBD8M7FCTFe+a9BCzu8KPuSh3K9u8geTH1XH
         TyelsXlCrcAjhqzxR8R6/obhym8TGYcTO86H2/V0MyKFQdd+NlCqLkxjaV/wDfDglvGi
         wznAEzFFI1MvYd3wEYpmFwQcLfgaBRnmUN12ppGY9jgZ/GBqT1mBEx0VWHPfCb8E1M9G
         Se3k1ar7Z0lj7J97RQpwYb3Mr8D/qAj0nRp9BvhSydqFOM96h2lUt1hytPTtZMZuC1k9
         GZ7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793990496; x=1794595296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CUMcAVyOirUSnIO4z8+9Oid/43N5zWiqbL31INqDBvs=;
        b=f7DVpUc7TvmBk/GlEqTwwF5Fjd0F4WISWb4EdXmwCQ3SX5+AXNnFeMkj8RJ4/yPZ/M
         I+v+Jzl2ngCP3dDtqTEHahs53ZsHjSlKehAizG8Mq7zaEa2nQYmJYrjg22Q5tRmxiqs3
         +SVNV52HhmqFWTWFAkE3T6INy2CvS90tNzfemE3XP0p2UhhaQcoQjbzi0Y6yfAbGQ/El
         +0BKjYm2pEPgG0u0J9394c7qY84rOVDrrpJ8/eat5vRrR4x/TcAqf38hD3s5idnK/VXy
         PKFGjmzFBKCWO1FAW+0SfezAoWr+Lbj/yUAxak44wk1to3/WoJMd+r2MUHPB7ez4nRU3
         RGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990496; x=1794595296;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CUMcAVyOirUSnIO4z8+9Oid/43N5zWiqbL31INqDBvs=;
        b=gJ/6n0cjS/zLO1p2a29cq/KaDHebISdoDX3Z9hYKUz6nKXnv16fqSESeBkcR3frMUx
         WHtUqdNIDA+74ofCkxcFBHBGbojAiO88NnK/2nOp7W9gwJjXgXd9apWl6qRKVhHOq6ea
         EXKS6kQ7AFRS3JvI02QTbcxp+1JPiJF0a5/p5RUtyYhhfHpWO2M04uOSNZEMAvF5HC46
         ugk8YXyRUiDWZePgtVEjV+OdZlQwNOt6a3K3MgwMvoCyE5GnRBVueOZmnO4Wx1w/7h2K
         6KN7WTzneaBQLm4ztuPveZ7bf/Lx2WDB7F6Nue7CbJxd4jdNrpynZ17W0f1JTtUD8fKB
         KTjg==
X-Forwarded-Encrypted: i=1; AKwUvByCSYL5+uSlF3RanUYz5dOlTINBLLxdhx8fv8rOB9OAxdpTwX6O4l8hY6Md0FaA+TdOR0DibS44BUM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HxhbQ18gIzWrzJOwhuQs5VRibZ6ynpTYFegDkBOlUSmbjtmXL
	o79tp4RL7BnQopH3O46i0xeTOjyAX+QAOqE5JCeR0LvmogSdLBYFMqG25Rxt1Jz2XC/Wc2R5hYY
	ReEU4EjInBeJ2fOFvmOxQHCx6g4dfzRIDjXzkTitrNKHPSltYsYyAGjSjALW8wUerotIq8U3DxV
	9KcqjveHfn4/dQuKI9yQ/99lgxwKT6gD38CjVfeQ==
X-Gm-Gg: AYBFou3FCL4TxT+MjPhWAKOb3gfc2WoD9V9cItUsHH4vaSPOcCQPpvp57ji+ipQ6rtD
	WqEWdc/1rwyT3WR3RUNoOyjvDOjeGvIGATfJtkhw+NVTGVgB/SgoR+CvXpulsp4tClhz1J+gnjM
	8ADJERLVlKPU9QsaiQUTAS8zFGxffCTKyompBj6kloRrTB0xGtLINN+Oo6gA==
X-Received: by 2002:a05:6a00:3d0b:b0:881:9f52:ca00 with SMTP id d2e1a72fcca58-8b37bd5461emr2936014b3a.42.1793990496141;
        Fri, 06 Nov 2026 10:41:36 -0800 (PST)
X-Received: by 2002:a05:6a00:3d0b:b0:881:9f52:ca00 with SMTP id
 d2e1a72fcca58-8b37bd5461emr2935994b3a.42.1793990495661; Fri, 06 Nov 2026
 10:41:35 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-block-as-nvmem-v12-0-f4a2a681087d@oss.qualcomm.com> <20261102-block-as-nvmem-v12-1-f4a2a681087d@oss.qualcomm.com>
In-Reply-To: <20261102-block-as-nvmem-v12-1-f4a2a681087d@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 19:41:24 +0100
X-Gm-Features: AclHuK9emUwSj3_sGAuhi1FbbmSEvMQZ92eVANQc1PZljiIDDYIawbYL0H56MVQ
Message-ID: <CAPx+jO9Hwqn__vdZn_2yCAy9nuMHR2=8shjjQdWQ4S9JWUknQQ@mail.gmail.com>
Subject: Re: [PATCH v12 1/2] block: partitions: of: Attach partition fwnode to
 the block device
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3NCBTYWx0ZWRfXyq5DzfpacGKq
 Xf8d+/JdNtxLq9y4f6PQQN5LkSfBu/1ENmUcQP7G5H3tPSShMG39JHn6FXNTubsRppF+YFtHL8k
 C7AKlc5UaR8oGYaGaBX+uATCfy2I+aRLCQqSltER7zzM6HPyHFPYW8t00CFaRmPR6B0R4l1mk6W
 Y3S9F/SEwmUHh2mYmyB7HSIpsnf4d9lbvidmYvQKo3/8qwmyzRst/2Sp79rkSQZHLbrAy134xVQ
 gimO0ysg+2BIc4j5PnUb0T+1QIaz0csHao4w1y3YoJHnTUQZMnp/oUYPocTu9BwRvDYAELxyDdY
 x3iuoLDCQQ32XXfjdqRrqQXqv4Z5gkLXobLD0tl1Ed1KAl1T/am5uLPOKK0d6p4wWoVcZQilI2s
 DmEpSFJjjaPCDEmiqzG0Nj8N7ekcBFsHfM2Lf+C4OYJlDq3+4WoOue5s0Px33rhRzqMvYysE/Jm
 xZS2sF8zuIOagr3X7KA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3NCBTYWx0ZWRfX3ysqvle2kwHL
 zP6OUGhfG9YaQvBqEDYU7uY2Yh4LEd3L+LaHGoAY0wiEu7qhpyq1uv/I/zKBZkttkLvFEPDP3tg
 DAgPck+I+TeJ3mHX9xdXS7H5rcMRsYk=
X-Proofpoint-GUID: JCQ4eDrrpotxHLFGakevk8Tm7eG4OEHd
X-Authority-Analysis: v=2.4 cv=P4ivFSAu c=1 sm=1 tr=0 ts=6aee1f61 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=YqnSXwVskR_DcSjeyREA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: JCQ4eDrrpotxHLFGakevk8Tm7eG4OEHd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060074

On Mon, Nov 2, 2026 at 5:27=E2=80=AFPM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> The OF partition parser reads offset, size and label from each
> "fixed-partitions" child node but does not associate that node with the
> resulting partition block device. As a result a partition has no
> of_node, unlike the whole-disk device which gets its firmware node via
> add_disk_fwnode().
>
> Carry the partition's device tree node through the parser and attach it
> to the partition's block device with device_set_node(), mirroring the
> whole-disk case. This lets consumers describe per-partition properties
> in the device tree (for example an NVMEM layout on a partition node) and
> look them up through the partition device.
>
> No functional change for existing users, partitions without a matching
> device tree node simply get a NULL fwnode.
>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Reviewed-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  block/partitions/check.h |  1 +
>  block/partitions/core.c  | 20 +++++++++++++++++---
>  block/partitions/of.c    |  3 +++
>  3 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/block/partitions/check.h b/block/partitions/check.h
> index b0997467b61a54a8a621b9c155c8329289649460..326081499d9a6be730dbd659c=
110449cfa06921f 100644
> --- a/block/partitions/check.h
> +++ b/block/partitions/check.h
> @@ -17,6 +17,7 @@ struct parsed_partitions {
>                 int flags;
>                 bool has_info;
>                 struct partition_meta_info info;
> +               struct fwnode_handle *fwnode;
>         } *parts;
>         int next;
>         int limit;
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index b5c59b79ca7cbb28d4d93478ee1c80908f76ee9f..eee954df1ac6ef7dd4f02ad5c=
9d49aed778bf015 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -11,6 +11,7 @@
>  #include <linux/sysfs.h>
>  #include <linux/ctype.h>
>  #include <linux/vmalloc.h>
> +#include <linux/property.h>
>  #include <linux/raid/detect.h>
>  #include "check.h"
>
> @@ -110,8 +111,17 @@ static struct parsed_partitions *allocate_partitions=
(struct gendisk *hd)
>         return state;
>  }
>
> +static void drop_partitions_fwnodes(struct parsed_partitions *state)
> +{
> +       for (int i =3D 0; i < state->limit; i++) {
> +               fwnode_handle_put(state->parts[i].fwnode);
> +               state->parts[i].fwnode =3D NULL;
> +       }
> +}
> +
>  static void free_partitions(struct parsed_partitions *state)
>  {
> +       drop_partitions_fwnodes(state);
>         vfree(state->parts);
>         kfree(state);
>  }
> @@ -139,6 +149,7 @@ static struct parsed_partitions *check_partition(stru=
ct gendisk *hd)
>
>         i =3D res =3D err =3D 0;
>         while (!res && check_part[i]) {
> +               drop_partitions_fwnodes(state);
>                 memset(state->parts, 0, state->limit * sizeof(state->part=
s[0]));
>                 res =3D check_part[i++](state);
>                 if (res < 0) {
> @@ -247,6 +258,7 @@ static const struct attribute_group *part_attr_groups=
[] =3D {
>
>  static void part_release(struct device *dev)
>  {
> +       fwnode_handle_put(dev_fwnode(dev));
>         put_disk(dev_to_bdev(dev)->bd_disk);
>         bdev_drop(dev_to_bdev(dev));
>  }
> @@ -294,7 +306,8 @@ static const DEVICE_ATTR(whole_disk, 0444, whole_disk=
_show, NULL);
>   */
>  static struct block_device *add_partition(struct gendisk *disk, int part=
no,
>                                 sector_t start, sector_t len, int flags,
> -                               struct partition_meta_info *info)
> +                               struct partition_meta_info *info,
> +                               struct fwnode_handle *fwnode)
>  {
>         dev_t devt =3D MKDEV(0, 0);
>         struct device *ddev =3D disk_to_dev(disk);
> @@ -343,6 +356,7 @@ static struct block_device *add_partition(struct gend=
isk *disk, int partno,
>         pdev->class =3D &block_class;
>         pdev->type =3D &part_type;
>         pdev->parent =3D ddev;
> +       device_set_node(pdev, fwnode_handle_get(fwnode));
>
>         /* in consecutive minor range? */
>         if (bdev_partno(bdev) < disk->minors) {
> @@ -449,7 +463,7 @@ int bdev_add_partition(struct gendisk *disk, int part=
no, sector_t start,
>         }
>
>         part =3D add_partition(disk, partno, start, length,
> -                       ADDPART_FLAG_NONE, NULL);
> +                       ADDPART_FLAG_NONE, NULL, NULL);
>         ret =3D PTR_ERR_OR_ZERO(part);
>  out:
>         mutex_unlock(&disk->open_mutex);
> @@ -564,7 +578,7 @@ static bool blk_add_partition(struct gendisk *disk,
>         }
>
>         part =3D add_partition(disk, p, from, size, state->parts[p].flags=
,
> -                            &state->parts[p].info);
> +                            &state->parts[p].info, state->parts[p].fwnod=
e);
>         if (IS_ERR(part)) {
>                 if (PTR_ERR(part) !=3D -ENXIO) {
>                         printk(KERN_ERR " %s: p%d could not be added: %pe=
\n",
> diff --git a/block/partitions/of.c b/block/partitions/of.c
> index 53664ea06b6540e3d1155141adaafac7286f2d21..4fc7c80c407de42b2b31be2c8=
2e0e6bc2a30c9e3 100644
> --- a/block/partitions/of.c
> +++ b/block/partitions/of.c
> @@ -3,6 +3,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/major.h>
>  #include <linux/of.h>
> +#include <linux/property.h>
>  #include <linux/string.h>
>  #include "check.h"
>
> @@ -62,6 +63,8 @@ static void add_of_partition(struct parsed_partitions *=
state, int slot,
>                 partname =3D of_get_property(np, "name", &len);
>         strscpy(info->volname, partname, sizeof(info->volname));
>
> +       state->parts[slot].fwnode =3D fwnode_handle_get(of_fwnode_handle(=
np));
> +
>         seq_buf_printf(&state->pp_buf, "(%s)", info->volname);
>  }
>
>
> --
> 2.34.1
>
