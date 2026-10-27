Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793130525;
	b=ARdjxmGpWkVxKI6+phQp+8VXYbqWtCHYPGC7orQeFfNbhHX9f8dUvH9B2HvRvzcwFLff
	 vMwHYI0ZKicEDHlDxb/NckP1um2xrQCIq0GGaN/gTX94qtfluTYfr6Z954zB50PhLidEQ
	 hwaqh4ruW09EZKYip7RQVV4xkq0a7scqwA+mPdw37DpTiQ2q5dNFu+FJNPNSMMRYRaR3c
	 Ugefeb+HvfBAPE2+BOe7ltVI6GKrJfAaPp7wjfRBLvHbGrLd8i3izWTuhe/oEJ5MYbxN3
	 Xoww6RV+cwLd6xqKrP8Hh8rPLLiBdHfIWcVuBVHwWZ1r0+7uHXslcxOeVm6UD+iuYYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130525;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GAKDu3kc8j0CukIhSS6fAinefmQmtQ0RlUa2NxUx96g=;
	b=eMi5sXREwGm0NPfocd6NOuv8FciLYHR0uXghXlX4kGS+5KJ0yE0VvJPYo44bde2FL7Rp
	 1o5ytj+gfdhSPZjhVDdMSsSNyfFoSDoDa7Dd3BfTbRje87MkpAg0yip9HAivNXcRsQ/0g
	 aLtHqpbz8lNvGE9LV16r0pKztGzhj/M7LTKtASn+uBqpsgHTa5mvAJhSwXUKVLZlfocmK
	 L2wJz3pi5YI5y5Hz5Q1Rk0vWac4q0G6plxknSvQykJSxE7cTtIOYHY5RhjMGG/ZXx1KDg
	 Z53RtQVJEHzlViT2p3zyEIlaR2Oq+fGCiLaqikXqoPUpVba+27RkSKhoTpDx8p1Pc6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i1dGnmiq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KquNEFbU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F7D606A31A
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 19:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36F7D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i1dGnmiq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KquNEFbU
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RIHSSa3554103
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 19:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GAKDu3kc8j0CukIhSS6fAinefmQmtQ0RlUa2NxUx96g=; b=i1dGnmiqrekMPq9w
	Xzr/PTr6jE4yd2oMHGcvTZwVAn76nugVn/W/6uC361hTMN0jqs4Ucro1XRBW6gPR
	Kr8jAuvazNVKdDNQnv1BshL0gIJKtCKzTa9U549aLSSGAz6Uw9N3tlPpDHBHc4JP
	ZtVtuUhOz4Sjo8E3HN8PgdwAcqk0KOmLD5+7BU9ZfHAe14olyP5x+FaMRCnZRuU+
	q8fnGLdQeE/FAbb5iTT2RQMF8MU7mIzkC0KNFBhcV7sNJnxCuvjDNMyT6hjsZ2Bi
	QojjPSqlcPC9gOCBLOuhD+fbCU4Wif3wYAwpULApJR1eAKC1ayYcpAw5bXwQnr8Y
	GaY2fw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw22yyk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 19:48:44 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3adbc9a47fbso250425a91.1
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 12:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793130523; cv=none;
        d=google.com; s=arc-20260327;
        b=XRroJssbW/bu9BJLEQgsLRNYx8m30lvnaC4+7dD3YY2giUhz/aHOCn6SG3R5HOPmuL
         7nKHnEiKywknrJMA3xyYW4OP3S4i0rLLl0D5Cv6wRrj3q0oalS7m+q8/ykhrW32jW5dT
         3pHTPOT4Ac9xTHUfLce24ivdUck9gbiwuc483NjzPoQVSYjBZ9USRk44i9vBBSCmkyRE
         uuWnKA2qBoJXLwR7oVySs/sQwWo4IPkcQQxWfof/qsn5QmUW2c9zTgCVhVPOl77+lo4r
         pkk21MJSFvfcl8Q8N/niRC8Dl4Ju8Z0aM6Uj+FJEfGs+vrb2j8EejfPBLGQ4h/CbQWBG
         T6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GAKDu3kc8j0CukIhSS6fAinefmQmtQ0RlUa2NxUx96g=;
        fh=ykTZ7vVwIBh7aiuwV+LiV+ZN4M1Glo6KJROCm+ocyqo=;
        b=LyYOzKMztIZwpatOiKncr9+QS9fbhnCyetMQQ9Q8Ot41yi6BMLuCSqGqi1MnZwK49p
         w2ZYwgskReI/8FN2mUhwYNUfRwYE+5MV+mEhapHk/gXp0HeK3qaqxcc9E/d3hbMxiXy0
         zAFD8wAU+XROSiUR4BHqyka8KtyVoEXtFYOAQKq2+NPgh4L9zxLQi/cGEU7ak9U9ipuq
         4n7JebF/znitiTFr19vJ66yGv0hloQsrIffGoyBuR0d6C6PtjH3SrQje42J9NpVU0L5p
         2GP9nsmCgokJVs0wdUJwXtxgbTwZx7X+LbekwURTss96m9guj1zcIilqC9iOjSUsiGwf
         j0Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793130523; x=1793735323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GAKDu3kc8j0CukIhSS6fAinefmQmtQ0RlUa2NxUx96g=;
        b=KquNEFbUYeNSs5/MMo3dWqTIFJ9akt0utPDh1FD8ntSVbuWDoulkIIAbVsu3nrXywc
         LV0njWiBslk66pVaGPZBpGuExMWErvlFfKSBSsEclQib+1rTyG9omidUFGKbx1kua+Bh
         LNhwD3JNpTjzSNNCCNmOkT8bFVP9wPIUZl8rBYA65iV65hK4bE9JuT1lozIZpzHWiCw5
         4y23nRGcdzYfbMWKA93mvgpPeh3xue2y5B2bVfTENkHjkG4qfqwLnWQHB+C5G0Za06lp
         j+FeLfbJ8w8pTl6Hk9GRzhzALhd8cAJCtEsew0CVq6XdjITDVv65e9xmD0D5DS67TSrY
         pS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793130523; x=1793735323;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GAKDu3kc8j0CukIhSS6fAinefmQmtQ0RlUa2NxUx96g=;
        b=lxKFLfBY528+ECiHciVzCaCRy0y+ZSZrUmnGnGmONEIIrMH5GAf3rA1kRrqFxBbryD
         nZLAYLHd8vuFs547d6JVGbjidRYaT57j6hRIQzS+cDL6llTPitqGDJ6WyjVofVJXj6h/
         qxX5PYUimzOW7SzLdscUT+64K0B8Okg4W8ZomvzKDKxUT6ZcJX/X8kv4Z8X2h9ujvtVn
         NSFriaIu/Fdr6qzGjBsok6Y2aqyYnlR6jPkihQFzdDSA23ED3qtR/pO5EvRfDFysRW6W
         UnGTthoOGFTP3VQShYO/uSJxm+FaiH3qp3Cko+E8xeFIHPOuUMh3CcBxwnDBuSy9MUIf
         sBCw==
X-Gm-Message-State: AFq9FYLL2O3ZU1FEJp9YUAapevzGCdns1op4qTsmFKLW9vieKTTUVpOF
	tqPxb++9SFBWBwwlU/xUqEjeENio8mTs5PUmkDXN6AeWblWeDvhwxbgTRLEln/RICCfyZzqlZUc
	gC9ICJdpeb5EkHQrF09ZjLhVUgA4K8TUmkV78Tl5oYIc0cFM9KHLiOI59Mrt0xOQ6zT6mAXvmBI
	j4DROno0cNAnz0AsSmOVkpUO4uLgDkRXu2qbkZpg==
X-Gm-Gg: AYBFou0Kmjtt6QMdGoJkL1HnumbdZz3SVHQe5NxxoKQGbmABi4MLo+x6q+1T4EF06oM
	vtKecrJTekpxpJCifyr4KZYIRx/YWTGHeeEqTMYSL8dqIK1vPyMeiuZZroiFAgf9mJEsG+Zn4Q5
	Ip8Bg7UMBBZia/aZ3I2R4MTU3BRTnZVnRnOnUeI6cDYblyu07DhdAx5nltEA==
X-Received: by 2002:a17:90b:4f8e:b0:3ad:1b0b:1246 with SMTP id 98e67ed59e1d1-3ae5814f7ffmr78465a91.32.1793130523044;
        Tue, 27 Oct 2026 12:48:43 -0700 (PDT)
X-Received: by 2002:a17:90b:4f8e:b0:3ad:1b0b:1246 with SMTP id
 98e67ed59e1d1-3ae5814f7ffmr78433a91.32.1793130522182; Tue, 27 Oct 2026
 12:48:42 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
 <20261027144051.249211-2-ulf.hansson@oss.qualcomm.com> <00b63b4f-053c-40cf-82db-21a86fc485c6@kernel.org>
In-Reply-To: <00b63b4f-053c-40cf-82db-21a86fc485c6@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 20:48:31 +0100
X-Gm-Features: AclHuK8pDre3YwuaROhCo5lLvSQlS2cqt0DndLdfwRm-CMEXrzn19IcRZVVnLI8
Message-ID: <CAPx+jO821-wULVT_KbZB4oaPSYAHi3PEpM0VzvSL_7NBns1t_g@mail.gmail.com>
Subject: Re: [PATCH v10 1/6] dt-bindings: mmc: Extend keep-power-in-suspend
 beyond SDIO
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OSBTYWx0ZWRfX2lCGtNmT8LGy
 WMH78AelPaL3n3pH3ldEyfAvzA7MtHCe6LZpz+gsaf7KW9lV9zZ40woRLnnEpEMpfuPcUWZPShi
 qmktNA5sva5wSpLZ6YBQpUvZ3oqZGI0g6gJ50Tcc1HVX6qqaUUJSWVcmVSWoyy6WAkdO29inGLZ
 gbpPkie42L64oWGKwpR+EnYHNrUDu0OVTGR7Ewiyg7VWsADvSM4vBbIgJhTltxlW1HWUagWiT+q
 xc9h6wVFUC7uUAU5QKd3P+ujjbmoPh572KUJDDmjacJNO5K3fdfPxl2Qotch6tkRS3cd4CqHeYy
 3kJpdUiKi2Jk9hO53rYoUlXBnZA4aOpkXM/EeD7cc6Tq/8mFH7uGN4bTQw6NVvnEHG47YoZVKPX
 EPo5engn3XRCjOyy0Lhfqt1BWaaIGR9Af8DZpYeUdkSBKRCgYMHmFyuOA6iJXeCFYZzq3bzpNls
 dVa+invXBto0I0beI0g==
X-Proofpoint-GUID: pATNSZLEiyRyXbseBM9DqYZMoT5jRaan
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OSBTYWx0ZWRfX7v4BsXrbqjuE
 1zN+7EakckwCe9GNt5jkE1xmKLrmcajgjvbr/soNOIjf16ENOe+IdD3zP6WTe2LNFbzQ3hJNtwG
 dVrX8eOuY1etvl+kGsENCeNWmXbeGP4=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae1001c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8 a=EUspDBNiAAAA:8
 a=hX8ArNWt6CVKnETHcRMA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: pATNSZLEiyRyXbseBM9DqYZMoT5jRaan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270079

On Tue, Oct 27, 2026 at 4:33=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 27/10/2026 15:40, Ulf Hansson wrote:
> > From: Kamal Dasu <kamal.dasu@broadcom.com>
> >
> > keep-power-in-suspend is currently documented as SDIO-only, but the
> > requirement it describes -- preserving card power across a
> > suspend/resume cycle -- applies just as well to any card type. Drop
> > the SDIO-only restriction so eMMC and SD platforms can use it too.
> >
> > Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>
> Incomplete DCO.

Sorry, I should have explicitly stated that I will leave that to Kamal
to contribute on top.

Kind regards
Uffe
