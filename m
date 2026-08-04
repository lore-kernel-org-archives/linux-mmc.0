Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D846AA68
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851006; cv=pass; b=kgLAl9+hXEfiY5Tl8E1DmOxVFYykFZX3GnsivTZvrKw8jYcVJM4GukqNPBd2b5uGAE+ltcoypUGwjNlvAld0GX3NqTl9kDZFtSY0MNijaRChsk+JK6TRqEcXMyDQhDIVWHNEkydbmMdrqV/rTnamZQb8ISisdAO3kINs9SZSrTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851006; c=relaxed/simple;
	bh=6dD6Avw3p/9xzikD+B/WrFmvjUtHV2ReEf9NjuiMq4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYIJZFQp6t0vbJ5PsYybYJ3y6x206vt00BbsAs7BYzk1AK0bFZcYddq7OF59tYzQOAu4QawISMY2rMBLEaXrum2gUOZGOMQGw4IfLsOCRPqxqCq4VIvTeIGphH6rIFO6eYnFxrYFfryQda7NsfSXkSdPY/T5Sr84de8rNJPECXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PA6mgmD5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YOJsKrUB; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PA6mgmD5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YOJsKrUB"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674D31HG3693342
	for <linux-mmc@vger.kernel.org>; Tue, 4 Aug 2026 13:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hT3AmEbN2vurKoFN0DTag3WEcZxOJm33zrcyZd6E9hI=; b=PA6mgmD5hOqCrDwU
	7kkXCDAj6n0okMUAx5VVCmgfRLsGmAsxLQIG+ViKmI0aZds0Ciasv+oK3fvWE2VK
	ds9nBu6wghv4kh2F7NVBdck58GQkA3bqDIt1n1A/P1UXGPgEzQ3cwUe7XdwjiT9I
	+Yp9emUDqHc+2VRpA/fbfCYadXZA2GLwsXqJ4E4SoY2lXGGgjFPP2Z8m25gRLJn5
	0cPIByjTWXQe971NabAcTZwzakT7eArxqCu0S5UQMizy0nw5hzrwP1gOP63yoRZ6
	xZ5pzVz1koY6eh3rYuQkf5Z/+NlNAVHzh3V6aTzCDIvIvpzAUSOyUAp0PooLVIRL
	bupZHg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fugmgg5eq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 13:43:23 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-907b38aaad2so50313546d6.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 06:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785851003; cv=none;
        d=google.com; s=arc-20260327;
        b=q3LxAo8lY2WRbsYIMCcgkOptUIJrvYDaBfAM/IPXtFpEvDdpADxYrYz0cpOpcZUJvk
         xna3CaDgUUQr3VPIbz/cfmumYnnzeMigKDz6xwX43pmBB7kmFL5jmFwb66h5L0HLYBnp
         4iU9RH2WEs9nmF3pCTJCbkZRLqOpXIwZAStpQh+i6cHMhkb4vtetaEoqXSK9H0qLXnf5
         V9zAM5x823zxeZZV4+1Wbe+Axd7QEzRq7wU3nTfv1rXWGNqZnbBMgNOqGz5Zz4Q/kfYE
         VRsYnivd9cKPG92DfzrOuPrV8yVYJKxHW1mXv6/0TNJFf1qtvrFviz1lc1Nn5VzqtclP
         K4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hT3AmEbN2vurKoFN0DTag3WEcZxOJm33zrcyZd6E9hI=;
        fh=nYP95J7n4/HgyHelgzcsVa+W5ppaxiPctGGPjgNTjO0=;
        b=nO4FUQ04RXgq4SjZ6i9LIScs/7NwaJqbror2AFsMm0e43UJlaAMDbuyDUZnX8BLXNK
         U3GR4DTfKP7SoRpWzsY/JE+5/GqaafB0K6UDAiZBPnJ3ih1UVgKgaRvNjkg4HU9xubhR
         YDDLTbKz5FGIG8rrd/crYd+kO03MyZMUoI1ADhVgoEHgy7zauWCHoQ1BfiTbMeMMTzNQ
         S3y44yfd7hGqeNSYVzHwhulwJ1+03EFP8Q+in7KMjQsqTCfRLESV46ZdSYyWEoPf3OeK
         e+UdF5+AKdUL7MuVPcDuNn/2Vf83za/dNSW7axAHo+VVPDak3pqdskzmtlZ+9qbV6v8A
         OLXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785851003; x=1786455803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hT3AmEbN2vurKoFN0DTag3WEcZxOJm33zrcyZd6E9hI=;
        b=YOJsKrUBm/ctyBaDMH3QJdKWDSJjiR2NDlm+9Ly+2+HG3BnmYF9rENwm11CWkB2REn
         pHCOejSDsDVOgUMGXjtUYV9L3uTbWOrXUuW2vWnoG+R+x4DvzLMSSFlCmUVbdpNs+0Xi
         ADpnz5beC33dyX1HXf/4PkKnXQfCbPgcbXvSviguSsRq2pNbZbJQXoRT8E0jcGT244vw
         lS1qiqAEs3VepywXv1Lo6mG//zVvhkpW90QAHfnRvFD7ZwRyVeVs5m33lGwAPUl4Vugm
         0cYTmEZmoNQmh66KHosUwgN6H094VP2h2Uc36/q7e7fTtbV4o2qi+UVUVMCvVa1xUVc+
         KvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785851003; x=1786455803;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hT3AmEbN2vurKoFN0DTag3WEcZxOJm33zrcyZd6E9hI=;
        b=NurCiggPZUa21bViL+fW6+9cvvcFC3nFo3PE4bl8BKA2i1n53xOxozLZRabFfvJZFn
         UnGOe/lBADWcf/o8jfpMQvK1n8eryzrCNNSkLdZNUKWShDUPe3fAfovjVakINSRVKVCi
         o9dEAEi/r007D8VZ0TBUCOl+quFf6dmEClRYzFnnT6Ys/0fUwhJRIrCB9KGyx5rpoHJb
         1KPvv3t055+XtZyQfspZfWCoj2vLLmdSiv2iumcL9+YrJvbCVwT5cEicRav58pXq2MAE
         slGP8sesZH4WkfSPPWrWsOh3UZvhaDozTRgKReaWhGkZHVynOL7kcAmLrEckMYTdlP9N
         SHXw==
X-Forwarded-Encrypted: i=1; AHgh+RqIOyLNPl3bQwUjQhRLvVADRVxK1ZofhSNJtrgEijlzgYNa5Uk05BpQzNqi9Imm1mSvpo3ATbqGkss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNFfKpaSYKgk8FzNDI0OLkRGA5FxHo5ngwUhEafk/wsXTZUEYE
	FGrfATSObvMJkxfM6zmQLOt0tD30T2lDKqxS3UoeWiobaI29b2iBBcc2ZH/RHkMs/o1UH+cbpd7
	RRHFC/F+g0dpSnhFnCS/qmH/TUZobu3QqJ3TS1KeAOkvjunAnJpCaihJDWyWQEtzp4emg4UwKJt
	rcnh/iksqIL4jiLJocVexbicQqLMRa36OdMwvi9w==
X-Gm-Gg: AR+sD10fg8+SWViAS2Fg6qaoudL54+Q7lfB9zoDrsfv/MXt3uXtlOUNnG+uj7iQ/UGi
	Bu0B3/P056Y1Up/zcCpVs01ICt2qlMxKHkIFD2BwVVRm/PO3hmjsgtZYcvtc2y9vPiODN8P2skp
	XfgRvVdY0uw0rhSGM+3itmDoaHa4cT/0I9lfvQReiy7TtHPrZJijy12F1qWA==
X-Received: by 2002:a05:6214:4689:b0:8ee:cee4:7497 with SMTP id 6a1803df08f44-90849633f52mr303443026d6.16.1785851002990;
        Tue, 04 Aug 2026 06:43:22 -0700 (PDT)
X-Received: by 2002:a05:6214:4689:b0:8ee:cee4:7497 with SMTP id
 6a1803df08f44-90849633f52mr303442586d6.16.1785851002614; Tue, 04 Aug 2026
 06:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804061200.3897779-1-zhoubinbin@loongson.cn>
In-Reply-To: <20260804061200.3897779-1-zhoubinbin@loongson.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:43:11 +0200
X-Gm-Features: AUfX_my9G4GMj9t1tipBgw864axA381Z_4yd99gGO1XwfRclHVSZN0NTfBqW_6U
Message-ID: <CAPx+jO9p4ALxFfU5eeTUwfoC03LEFTHH6zVicVtiu7BjBeFK-A@mail.gmail.com>
Subject: Re: [PATCH] mmc: loongson2: Fix sg iteration in data reorder functions
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfXy2fh6DdyA29Z
 7509zVVuv6hvohsXrvNcbI5ladyzYU77LM1dOAGCSOTtLOHC+yG8OFFGE+EoV+Su8I80p6/Yd9z
 kvFTM0v2Kas+CCNv5STBen/0224wVbZE3+htZHc+vewj4VJRg/O5hODEO/MinVVYb4iw/ptX56n
 RPXYdboyR0UypeVlhKXUz6JToDQWLREEDBBhZZCdNH9z+3cWYOJJO9r8m6DwH691SvSvbol1C51
 pK09sas8CGY45RZhavEkrEOtas+dVHatGiaAau0A7w6zDsy1HwRna7itrtFqE0Xn8+Z8kisdqHq
 8TAaRl6BMrF0BvahaoYS63y5FM0gQOqnV8ZR3s4Hgc2FF6664wJYlwofLLA8o1QZr5qARnFALBU
 OtSa7q8Myv+RYb3A4iXEbfig0X7hWeEBlmGdBtvu6aKOKfNUI4yCoGwbxyGaAkpMAy3EF21S3QW
 MmsoGn50nZXacM2eMfA==
X-Proofpoint-GUID: wim_1KKgqOdoLDHNVM9O7Du8GsLuBcUl
X-Proofpoint-ORIG-GUID: wim_1KKgqOdoLDHNVM9O7Du8GsLuBcUl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfXzXowac2YCdOF
 SomCaC+6GOnRSL1JyxMrx3sQ5+Qxp/RoIHp54GOiDzZvrXDtidX0ATpmhKjZlSWcHZdkjSHx1RI
 +v7sL/OUq8az6Peoa3qIHGdMsLtdBdY=
X-Authority-Analysis: v=2.4 cv=XYC5Co55 c=1 sm=1 tr=0 ts=6a71ec7b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=X4fetLzOTNcJ9inZm0IA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040110

On Tue, Aug 4, 2026 at 8:12=E2=80=AFAM Binbin Zhou <zhoubinbin@loongson.cn>=
 wrote:
>
> In ls2k0500_mmc_reorder_cmd_data() and ls2k2000_mmc_reorder_cmd_data(),
> the for_each_sg() macro already iterates over the scatterlist entries,
> with 'sg' pointing to the current entry. However, the code incorrectly
> uses '&sg[i]' and 'sg_dma_len(&sg[i])' inside the loop, which treats
> 'sg' as an array base and indexes it again, leading to access of
> wrong sg entries (or out-of-bounds if the list is not an array).
>
> Cc: stable@vger.kernel.org
> Fixes: d0f8e961deae ("mmc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC co=
ntroller driver")
> Fixes: 2115772014bd ("mmc: loongson2: Add Loongson-2K SD/SDIO controller =
driver")
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/loongson2-mmc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson=
2-mmc.c
> index f553e92fd9e5..118eccbaf8cd 100644
> --- a/drivers/mmc/host/loongson2-mmc.c
> +++ b/drivers/mmc/host/loongson2-mmc.c
> @@ -641,8 +641,8 @@ static void ls2k0500_mmc_reorder_cmd_data(struct loon=
gson2_mmc_host *host,
>                 return;
>
>         for_each_sg(cmd->data->sg, sg, cmd->data->sg_len, i) {
> -               data =3D sg_virt(&sg[i]);
> -               for (j =3D 0; j < (sg_dma_len(&sg[i]) / 4); j++)
> +               data =3D sg_virt(sg);
> +               for (j =3D 0; j < (sg_dma_len(sg) / 4); j++)
>                         if (cmd->opcode =3D=3D SD_SWITCH)
>                                 data[j] =3D bitrev8x4(data[j]);
>                         else
> @@ -758,8 +758,8 @@ static void ls2k2000_mmc_reorder_cmd_data(struct loon=
gson2_mmc_host *host,
>                 return;
>
>         for_each_sg(cmd->data->sg, sg, cmd->data->sg_len, i) {
> -               data =3D sg_virt(&sg[i]);
> -               for (j =3D 0; j < (sg_dma_len(&sg[i]) / 4); j++)
> +               data =3D sg_virt(sg);
> +               for (j =3D 0; j < (sg_dma_len(sg) / 4); j++)
>                         data[j] =3D bitrev8x4(data[j]);
>         }
>  }
>
> base-commit: e27c946b589c53520409a0956b33d52ef7a0898f
> --
> 2.52.0
