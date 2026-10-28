Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793207694;
	b=f5dQGDwUQdmO8G58VqNGW6zS8zXX/+smkHkxz/3SByNAlYC9gBMN8usGcB1nYnfsVi6F
	 23OrWMbCxE229PkijxOBlBxt0hPvJZZXxyHD9/H1NcRKgByjq66fmi4GM9lQNA3vBgBcd
	 NPcRoiAkJOmvuRKfD3uH7drLTtEPA7fbN+HKmH3DjF+mOgi+jemJBZYWIXkJ0FfLhzeqI
	 btxczQ092tgOUOhS9pXtgC3Z+/8KIv5ioohKtLczS1WKrUac5fFEKd48rYWjxdaysxXU0
	 myhqmSNgR9U8SVhCBFIjt4huShBbZ2TWxDsEld2x3v5a3A1uv/eF3ZlHdAUMexk0zKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207694;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yS6+yqmCO/Z+9Hwxo+UG43eJfa5XgYXkK/nQJzs6W+o=;
	b=joAA8GTTnUp36/lYO5ei8Sph07MwS18SCCuGjDFQegGdNd2QGb3Dz22qGVK+BmIUUg8D
	 gNIcBWEjDmwnSN1It6ujW/7fwp9WHXA5rgv72JSYGSQYZG/kKaje9/kMoOrWEv9VkJ7KJ
	 PgSARG9+vXKF3mh/sQJkU+7dSeIY1pQ6pzoL1fRoZZzKRj/5zHtzTmM7KrdQF6YA9H+/c
	 wN5WRTzVHHsIDUjqLTt/dRD/LxQACs6MsIJIbXTSnI4FnQ3l+C8SERZAeNy4k7NIAg2uW
	 AqcVmcd2qlM2RAeySdUxr8Vgjw4RUKYY/zTkvusmI80jyDxwoeFWMv6utvA06O65rBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="iRx/cHJz";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NarLSL3f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CC3606A31A
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8CC3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iRx/cHJz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NarLSL3f
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFA3Ml1471774
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yS6+yqmCO/Z+9Hwxo+UG43eJfa5XgYXkK/nQJzs6W+o=; b=iRx/cHJzTqSXbnd1
	EW3bP32/wrfXEOSOuU77enf5hCUcTggU6ya/hrvzNSMUgjsuC6lXdTTgyhqlHwz2
	FWkwmhdMjw8VVKcjIEbzYxbPy8oanDTRhKZ2EGuSlvEHXm2Sev6VDKwfEcFiU0PQ
	7Yf/Jj+GOjTb26gUfTRKcg5bJ3iV7J9qkgE+X15PswAU5aSMqiqCPR3I77Zt0Gb/
	A4RTIe3B1dyoeNLI38LPq5QkwzYLzeQ8DMbZNwEYBnVjlWDsYSHtOhCDPg2MmO5J
	pixrbkq45iRF/3qnKtySL2l03ZHCv3QXtl80Je9mG/g2uwATw3lPF+BtbiKiy7rd
	nuHwGQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkfehhnva-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:14:52 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a0865e4282so455591b3a.3
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 10:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793207692; cv=none;
        d=google.com; s=arc-20260327;
        b=lAumUuGS7BFPN1q6vLog94oPjqprr3pvOnH3n6Ci0o0hH5f10VjZCqr98PwXMhX7Fs
         SRgxuDb67pjPSPgHKz8veik/diND+8Hz5bZFGYhVFb7w1GDtG5M0cwUSjpvI1IzzMG7n
         8CyiKu3qPwa4By5AaM0GLyBLLHWRdD9idqAoRblG9eF9XnGVj6i7o8C5HpSNYHNv8CwR
         N9NCuYWW6QL5TSFtWzv/mMGqD0tSoeww+WwzdY0nNjQvkeX4riyjNjT8fSMYIGrnbZNX
         SCo2JMa8RceRnyx8YN92NtGHfYnbhZkiRo103XG6MoBR0PkGjdsKdwKLnY1GOeEwli28
         /tfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yS6+yqmCO/Z+9Hwxo+UG43eJfa5XgYXkK/nQJzs6W+o=;
        fh=OiDrDAif5K9vDX4xjHTLttUiSVK58pKy55myeNbQHGM=;
        b=B/pkdXIeM2VTKzXc/Js+nSKGqZDAFiKXQM6BNpkzBDXQy9M3CxXDnQH0LOeXN61FYs
         iCfDoRvj82YAksMCo+tgf2yZGjFayAFgR4iUoqDk9tk4Z+TZm//FBMEwPMGJUeAcPsnq
         kgoSfP89Nr2bia9+VK66E+p5Xb8yDDiGpJ+YhlloSGZhSGLM/RNiIg2oab8pLaJNV4hk
         ucfSNwb0J85NUafWD3j1l+8UPf+Plx7ZAvTQNI80MBjlZh2JNlonLFF+5OEG7XHR40mX
         wsXjWQONJeMMjMwIedbvHdNIf0qgWRudqMl89WJwDIHLvGl9z1qNsJSDp45+JpymiNQx
         43HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793207692; x=1793812492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yS6+yqmCO/Z+9Hwxo+UG43eJfa5XgYXkK/nQJzs6W+o=;
        b=NarLSL3fQSwvAx099tbHHoxIxEBj2QGMim9VohsnJNYB6ULicVUZxBD18+xAk70wY7
         +W4f54noecwrkJhWzeoVeC24EQcJNnwLYMlTyXOPyzTLSWQ9yCx/ur+VlC45E3K4JhBh
         bLbA83a5c+nTMfmFoPkF+WNy0bJte42r+iO94eIt55JcbUxzN4Ns9FFyurSQql1rHBBr
         0ogbdvqumyWsNUK64zGv6bcX+eyUMx6kwcpVDuLtWQ/F10yTatXj4LdMXoYLzvA5LbXz
         TOSsoo7sQQRbYrlG1H68l5Z8BbZqupsyujqrSen/7aYZd2pJeI7Qn/E/ztqSVX53pxeU
         qrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207692; x=1793812492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yS6+yqmCO/Z+9Hwxo+UG43eJfa5XgYXkK/nQJzs6W+o=;
        b=Oni8DJmCbdP/TCUZtFjh3lzQBG7wjR8lwxJTsErhBilopVB4WnucCuGuzxNQZnmq0/
         qT5UBZAUH3klUswTtgXmKMFulvM30GBkqFotIqSafSI4W6rcVWr5S4xlmcgD5Qh8vC0/
         ahzP/OoHfGwtCX3h2t5J+qA0s6zePfh/kwOZjCnfcYa4D6QMPORlIUQ9fb+0eW4ktJ5H
         0eYV8Xsh8mXjWiqbj1G31G8aTBplsw6rWQuGTiLGLYwrFHJgpnadOBSp+W25R3AuNY5r
         fvrPYyMGKV7ButQWgX7xSxscwFpbKZqs+pp4yULqY73X2DTeEpaWIginrbI02BX+Pqpx
         gGYA==
X-Forwarded-Encrypted: i=1; AKwUvBzfc1iLCxYEmEIMeOTzKoR19c/8kFSoMsdIww7mMRtbaOHunOnkNUxUbN8nVrJySUI02nn3xqaQLfA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIU3TXddQNkdrA3f9qN16gc68V7tSZU/FcyenfCkwjYGthtvaVn
	qvriQmm3u2jDeyrm8uzCl+AvWmgFwd1/iVnehcPg54A4cFKGcBhJcMNezhnIL0sJjcsuGNgcRjx
	XlJGNEDFFDXMy5bCKxesrzP1jXugAcitd3ohHgQGotbgZH2DtRJonUgVKe7MnC1TwcQ3dmbmxI1
	uVsit+AFm+Jdv8smSdVySm4+6v9j8lDhDwrd8bFg==
X-Gm-Gg: AYBFou1yRvwW6Rr36WEzaZaAOni0Sv75NQo7gWNuHTdle+3RCcD1eOMsf/UyKquoU7f
	ZnrKP9PSUNAxYrVRQ9wF8O0TmBlPylZHAQWD6+qhGyK0hYoVDDRw47/tGDdf/4UcWOXBiM9MdYx
	F7yYuJw6Xq8kzf2cRQGDeHQdsbG6krOBk3Zhf988ao/QYDya+j7htAssMM3w==
X-Received: by 2002:a05:6a21:4995:b0:3e1:a4ac:2d5b with SMTP id adf61e73a8af0-3e9023a615emr1998168637.41.1793207691808;
        Wed, 28 Oct 2026 10:14:51 -0700 (PDT)
X-Received: by 2002:a05:6a21:4995:b0:3e1:a4ac:2d5b with SMTP id
 adf61e73a8af0-3e9023a615emr1998158637.41.1793207691380; Wed, 28 Oct 2026
 10:14:51 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260929124522.2141124-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260929124522.2141124-1-runyu.xiao@seu.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 18:14:36 +0100
X-Gm-Features: AclHuK_ZWeAQi2Xa-B21F76suzhqXwNnsAdO0BsvOyeyMH6jBWqA5XunpZY6OxY
Message-ID: <CAPx+jO-9DXrH+b5Y_TMmiyydLTkCQcNZKrHEy39OK8iYkZ3JOQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap: synchronize clock timer before disabling fclk
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Ulf Hansson <ulfh@kernel.org>,
        linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX2eytfkKk7wj6
 oi/ZNH6KTPiZAQMoVMkPSBniFpMpye786Y6cIxj9YvLDwfH2g2MetYmuPOjO4HJUbi1vygh1yiI
 lIq3mBweCu0Zjvd+uOxcNBd6G8CDM4fembjMkX9mwLytrEQh6sEM1f+pQ3d115IURZxQwijS5kX
 qUcE41G/oBJnmfxsqkEDq0+5CYce8ADZX5XEtENCRpjlWAFMoEY10/YC/Sdb+NADbBKkF0Xtoci
 BygBodbGQZHBpjXK8GRN73cMTC6PF+2PbF61coZ5C/53SPJgqfP9nd4fN+3uDnC+zbvm2yP94R6
 qFNY0oUD+VUVaEe/WOfRNpIHsF1BpigBoIuc93nTMCGsd0T5d0XmzjVfEoEp0d7M0MoA+c/GGwa
 hlW6J1Ft+nqHRHlmWUwWEHOJTCFBwdKYu+FGWzg8r+MCgxIKXP6dw2Uux89oGtKy7RxM3TSg1xe
 SDfuXJcT4rTCj87c9/Q==
X-Authority-Analysis: v=2.4 cv=A/T5rKWG c=1 sm=1 tr=0 ts=6ae22d8c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=ywtp7fW4YtRplKC3Ii8A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: 1fHbN3AdSd0HIWT2M5rG87rtknwQRDmc
X-Proofpoint-GUID: 1fHbN3AdSd0HIWT2M5rG87rtknwQRDmc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX4LdyQn4wXAIj
 4r/BLw0gmwFjEkbR3XerN0rLW5Bl6HdASleRtYw2grNXMNoObT4hfC+ZbGo83rFWNHGIteQw0+q
 /aVKbTcaOgSRB565DTPs4HI7S1tunTY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280068

On Tue, Sep 29, 2026 at 2:45=E2=80=AFPM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> mmc_omap_select_slot() removes clk_timer with timer_delete() before
> switching slots and changing the functional clock state.  timer_delete()
> only removes a pending timer and does not wait for a callback that is
> already running.
>
> If mmc_omap_clk_timer() is already running, it can therefore call
> mmc_omap_fclk_enable() while the request or slot-switch path changes the
> same clock state.  During host removal, the same window can overlap the
> final clock shutdown.
>
> Use timer_delete_sync() so the callback has completed before slot switchi=
ng
> or changing the functional clock state.  Keep the timer restartable for
> normal request handling.
>
> Fixes: 0807a9b5739a ("MMC: OMAP: Lazy clock shutdown")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 527b89a5e..02d288e4e 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -214,7 +214,7 @@ static void mmc_omap_select_slot(struct mmc_omap_slot=
 *slot, int claimed)
>         host->mmc =3D slot->mmc;
>         spin_unlock_irqrestore(&host->slot_lock, flags);
>  no_claim:
> -       timer_delete(&host->clk_timer);
> +       timer_delete_sync(&host->clk_timer);
>         if (host->current_slot !=3D slot || !claimed)
>                 mmc_omap_fclk_offdelay(host->current_slot);
>
> @@ -273,7 +273,7 @@ static void mmc_omap_release_slot(struct mmc_omap_slo=
t *slot, int clk_enabled)
>                 /* Keeps clock running for at least 8 cycles on valid fre=
q */
>                 mod_timer(&host->clk_timer, jiffies  + HZ/10);
>         else {
> -               timer_delete(&host->clk_timer);
> +               timer_delete_sync(&host->clk_timer);
>                 mmc_omap_fclk_offdelay(slot);
>                 mmc_omap_fclk_enable(host, 0);
>         }
> --
> 2.34.1
