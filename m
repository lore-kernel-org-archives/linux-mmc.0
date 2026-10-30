Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793358009;
	b=p04Kr+qn7C8vLVz84SC/909Hpe64BNHyi7U4gBZVtuL2k1eKH1JR8fwRDvbbWz+ChCf+
	 GzhAhFGbUxZnWKoUONDo/5pzCr6TvL4ezXPW2D7PWx4Z/2AErTNboV6wkySVTE3LrUt2G
	 8ASAYUxmzyd8M4/bo2H1+/ff72gYguSXEKJ5jY6Hia58Dm0+NSb33yOFqOceo/WONl09G
	 xajmxY1Qh3UPa8p69z/PtrEGIhhp0yLyE65dC4b5krKPLQRJmG6MPdyJ1kOoywg42FXL9
	 NRhJVdmfesHAcGrqlHOL1KVyCyXjjYwkt5tEg71PzQjWRikOCpOOW1fz8MjqNpIDwng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358009;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PIuOCX0AHVQZHCW56MurqyskT5/roJv4n8HNkBO1lr4=;
	b=ebD/swD/6MW7uxvPSW9XrvRn7l6E9Cvf4eqn7lXfBjHNx4whYNGlp8NceD6wL5Ilqocb
	 ZdxnhRMqRl17mEhGAB+wXZLN1q+7NuEJnU5Tx2p1q8JLaOOy4GrdpxHy07GkwwN/AjDhP
	 aBdWnTPuFs3fshTrvhmlajRXvw6b5CanUYpYj3eLUfomss49cplITIAZng6RVi38aBNye
	 b9LAPlwe5i3TdAfhY6KfzUEZD2ibZQEC5CCh6yyf469eYBYE+Jm/IGoT7+5k9VUmJxSwt
	 jJILaPlpVjZCq4agDRljoGdO/9Y6IsQnyruFYo73VeV7LYYeEjTnLh42CxNK8fX+blA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aTzOVivM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LmluDg78;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FE8606C6DE
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52FE8606C6DE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aTzOVivM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LmluDg78
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8F3aR3308880
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PIuOCX0AHVQZHCW56MurqyskT5/roJv4n8HNkBO1lr4=; b=aTzOVivMPp0yWKdU
	9LGLEv6Ecdv5Kov+N1E3GZC9BjPJVT9lzoQmm5SLp4p1w7SbyzWmSKKV9ZdI6vGV
	MvBhZveSuOzvdzRSWF1fiSEXOw+zp0rE+dXiWlR9aYBJqvkHlUPtpSZx8tfnTRT7
	WOTpxYWBMbhmqqcSVIMnabloXlQqW+b0bpkWRBztpaJEQGt6PaZPtg5mR0jYpPJx
	FmOAqUW/84QlIfhRZAQMPNy5MEnaABH786sBNXj2c4es1H+sYf89OXA/h40VgajG
	v7h9/zjWQIsHZwBEXPSIM/4Ht3+PlxxZd1EccLcPKF8omnZWfDobgWIL1gSkj1V3
	zM97OA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qtjnu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e941532594so7195125ad.3
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 04:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793358006; cv=none;
        d=google.com; s=arc-20260327;
        b=JtRzMIIMmEF7m/7mHPgj3IEL7OTh5ccULvrYfy6Szg000sX5iwvuYhaPe3frNnKsWX
         XpUpVzzxHn/nIhEkf/m2wAkRYd60oLSn+AoX+CLp6VdNUuHzulzIuSYrDfEY++xWEQtV
         mfcVmHEG3iLv9PdeTCfP7yGt4Gw9JPGQTDxZTNJxRX64UQpVv62gMo9oJfp7P7XHY24Y
         ZCnqUOSa26xcn/5zUDq8c9CbKyxJ0QjGgOW8zyRAbgEweZY86E5HCsCGIw4BuDZf1+U8
         uho/ZF8heEgzQQ+1nGg4kqQiNLbIHVeQ2r9hQUTJcctCnVAeED9BhrAJyeq+bTFL5ef5
         loig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PIuOCX0AHVQZHCW56MurqyskT5/roJv4n8HNkBO1lr4=;
        fh=DjfcPl8BtKnWUSDhb+BQAfTHQwr/WI304Nsx0PCf5bQ=;
        b=n4lQe0LLJCiNITgNzFrBdJoQZPOmc5pBFVYM8dlvJpp46nGFEgNIVCWQ5key5z86eF
         CYZRUkjomL3O3kcHe2IgwG5aSzA9VvP0BpJxJqKbr9akKF6Ph/uUygNLyKDOmfA9nZg5
         4z1rbueUx3sPiteOtAlvNZt88uwyHC79gc+4m8VeqXMDOb4051a87WbbY7dPlsK/gYVa
         LUOTIiy57s+MFj8DIiZkynNuudawN04yUJL80fVtLTu+2uwzpeITkrTTOZTrQTbmsQYZ
         duoiCMDidPpuOdtjh+rf4nu98e9rULgAYghgXFQwaDM4nl+9rZOD8uqbsPiJwHvcV8M7
         B1hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793358006; x=1793962806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PIuOCX0AHVQZHCW56MurqyskT5/roJv4n8HNkBO1lr4=;
        b=LmluDg78lOffrPR30CLZKM7PkpMEWJtTgCh8w4/4Kn0PDP6S0BllKRt6R68To9+vSO
         wxzwkly0y9TMLqGeTKKrHfTG5h0ovfVGTiEzFvHqsLU1Jr91uUJQrmmZ3+vKEIykf3Q7
         vKWLSz+XLXeVXhvnWTB9he0sEAMc1m+OKOlUMWs49rr2aTCjDYq/W+4GuibP3Et/ZKv/
         DoN6ZK8mymkSIDiOcS9WgqiHZb6uFIsumCHUoUk7HWRzezbZwKKYERogfZt6mAujo7ID
         8DbeyGVqhNSQLrUkkZd2TTRr6WyQK29vO2J2eWKATLZg+fkNJ47BdRbu4TqhbON2l4e0
         mt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793358006; x=1793962806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PIuOCX0AHVQZHCW56MurqyskT5/roJv4n8HNkBO1lr4=;
        b=rNj+YduhRIyGZg9dkdeTaptzX6FuqfR19onY4lu2mjASh3QTj0TNKUkV+3cUP5D3OH
         Oe3b3mKig9ov10Gmtf1Q4G/eTsTurcRl0Ck5XBU/rgrfhqaMnT4tFrT/eluiVmykuK6F
         oME9IC4wDVPJxY8yMVQ79GC+k1nw0DdDNIXMhGIQfVtp8Mcsg0Lrgpyi5+82Adqdtj3F
         kzRD/ME2JG7+R9UxBmLLR7NdHxZ8tsezA5ceIwJOVEQsKwYIrDRfQJ/xRh/YBGtnr27s
         NogFe1GjOU2CPybu7dwKqngoB79BS5s0RJ2lmbWn8ll0hDL57bh/qlXee/qA7hmyEhNl
         DdvA==
X-Forwarded-Encrypted: i=1; AKwUvBwheKWGrgH0OKNI8jCEBGrdxE7Grz+FSfrHddy9coHmgXZtUalrSxhTWkr91aelZXGpqzXbMvE73wo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvOFoli0Xw24PNaXwSeHpuSvdYirxJjej/CJPaWJx8MeiUlc8m
	kGvSziMrGdUG4iCkscvfMDvxP/sl7ksxqb8S7CxqNjrM2Jso3a/6fe0vlOdipFDRsHXSj9D6Zj6
	KETyTQ8IOGEGgjfFlWsNqnIThcXLP4t3D5bU2fnmA6z/1crCb56MXICxpWvdI3f+tYMoMxSU2wZ
	TGVZaHu1AW7cAFE88AVSBBI1yrm3B3sQpfNVEJQQ==
X-Gm-Gg: AYBFou1ReprQ7oE4z4e1zfZeSecmzxOsd5/RJgmuBDANADgXveMap1gxoQTT8sEN8qE
	IHFvU4uKwjPrBvEdlv2olPN/TRNL/tmkvZCBtRykclor3V4zK8fYzwlKw2Nf1zlXtqyxR0cywZt
	mTLVyKxWi9qgMOk3U+b4z9T3NhBZpJcImCcw2boB/lPeHxOWQY3c9/GsDphQ==
X-Received: by 2002:a17:902:f785:b0:2ea:238c:4451 with SMTP id d9443c01a7336-2eb364b499amr21193605ad.30.1793358006461;
        Fri, 30 Oct 2026 04:00:06 -0700 (PDT)
X-Received: by 2002:a17:902:f785:b0:2ea:238c:4451 with SMTP id
 d9443c01a7336-2eb364b499amr21193275ad.30.1793358006004; Fri, 30 Oct 2026
 04:00:06 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016163707.3508-1-anferneemelokc5@gmail.com>
In-Reply-To: <20261016163707.3508-1-anferneemelokc5@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 11:59:52 +0100
X-Gm-Features: AclHuK-BvDlghJYUIO9TuDP8Rn85PebL2VkhT0kLOMXOR76evk5RCctsK-_4c1g
Message-ID: <CAPx+jO_FV4Cfms7HmfxGxhtNuME6NJ8Vgov1P+AT+4UtJOsqAQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: fix DMA channel leak when mmc_add_host() fails
To: Anfernee Cao <anferneemelokc5@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulfh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: bhXQw_AzD1nMmOHujEa_zqRnhzb_hT7J
X-Proofpoint-ORIG-GUID: bhXQw_AzD1nMmOHujEa_zqRnhzb_hT7J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfXwaJ25tcsAJYx
 Pap93Zwk2+8GlUVu87byo54BSfGFR80o55OmUFa9+1yZwUy8w3YdYsJaRiRDslK7g15vHm/7dPD
 t7vsrgZHirnEwtUkOVIwjLV4BQVZ/fmhPWG3swB9u7haDtyvnyNNxfa0YBIK+Ql5/8ejuwr3AJ/
 u3nutgW4s8dWp46Xvj4KJqorlXnVEacHZ58EYyRsljHuBeg7YSMw3VYMR6dyJ4HPH/79M6k9V1h
 3iIcsdGsHp03z+or7EBux9jYOc9IC2cZIyLsyJZAhNPsw/t4UxZZtMlAWwiANbSTwMvu3+/686V
 FSXv9GXn0N4T5Ekz2LsPWSovS6aYliWjgIA6XuYm81zMDlCt9g8jF/nHzZRYYSydleuhyNLXa6A
 etr25XPx6kxdBBDA9wVcW356j5VCc9DNUKcTqU1tAVOfMjpcUorDBkadSbS9vlFus7HCPOOzlkF
 cPnk3NK5gMLFEXRyhAQ==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae478b7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=rFPXIUPvEMN7u70KbzcA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfX2OKOFl5qfMuV
 atIgiOoN55w8T/+80X6ScC4DchD64xJErFkm/xYj5SUcZv5aWl6QCpM5tAuIg60rLRtOfsrlxpG
 tqok9qEEk1tSzCLPs1Hh9lQ93/OA12s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300043

On Fri, Oct 16, 2026 at 6:37=E2=80=AFPM Anfernee Cao <anferneemelokc5@gmail=
.com> wrote:
>
> mmci_probe() calls mmci_dma_setup(), which acquires the RX and TX DMA
> channels via dma_request_chan(). These channels are not managed by
> devres, and are released only by mmci_dma_release().
>
> If the following mmc_add_host() fails, probe jumps to the clk_disable
> label, which only disables the clock. As probe then fails,
> mmci_remove() is never called, so both DMA channels are leaked.
>
> Release them by adding a dedicated unwind label, reached only after
> mmci_dma_setup().
>
> This issue was found by manual code inspection.
>
> Fixes: b38a20f29a49 ("mmc: mmci: fix return value check of mmc_add_host()=
")
> Cc: stable@vger.kernel.org # v6.2+
> Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 416bdb184ed4..4db5c55b2700 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -2477,11 +2477,13 @@ static int mmci_probe(struct amba_device *dev,
>
>         ret =3D mmc_add_host(mmc);
>         if (ret)
> -               goto clk_disable;
> +               goto dma_release;
>
>         pm_runtime_put(&dev->dev);
>         return 0;
>
> +dma_release:
> +       mmci_dma_release(host);
>   clk_disable:
>         clk_disable_unprepare(host->clk);
>         return ret;
> --
> 2.54.0.windows.1
>
