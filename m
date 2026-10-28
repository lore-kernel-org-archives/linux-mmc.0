Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793207732;
	b=gTBUSRuXMSMC/JQB4ry67ZoE2zHS3/SpGLMswcCI/1mNUr72MySvoDX6+EgtLIZUPy0j
	 vcxRBoA75YK4fjyjtXPfOuZbHGfv1e42vq6U5dPgfxiyU1W0oYqFcJVUTsnvJdJE+oTeu
	 U4CQxBtKy3b+N/YrUq7z2S+8l36a1+JvTe/cUWnHsTjUlTIdqqQb3wA2hYfAufgmgtjVQ
	 ks6cmG5AkuOiqzN6GtNZ3nDZBAgQHxoqgDMbXbggs7gA30FgbxSBDVwQUU1uDtBRuZMor
	 UA3pjEPFJLiJUVVGmcGYkVynYSQrnsM3EgxHlfjQIw3Pd6+L1Wkz0W4WdPQJoWHnxRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207732;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=YmpkSWqeYoXJLNmVPmN3QN8gq4888rDnBVOunPZHDro=;
	b=zAGYzQj/BAEgcgJlOSN8uY1BKT3E2PrTJoBue8Ra7hVkgiJixfZMyV2kIDy3TDGGok9U
	 QBpxtBw8swTKwCWMqfxRNKdfg4jLlLxMDKATqg/Zx9ZIcEkIErWz9zxT8SQeModes1twG
	 MZKuYIcqMMoyq+p3iNh9UQzVytZdJ5Ddy8jDQEKRUMX4gHwAsgfdnnJPnLBNK7RZQAdAr
	 uL7+t5Pty+ICfMPPCeMEx2X0C0fL2Rz7MLl5aWKWl28U0kP81xdkw00C3HQz+8PQnHQgH
	 e5p9Y1sbMjtz315aOrzxUKEqKZ2VojUka9rmtYlleqavNCrle39La004555APuz7MXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fMAeb7yv;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TSJ1Rcd6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1245606A31F
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1245606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fMAeb7yv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TSJ1Rcd6
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFA1QQ2543023
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YmpkSWqeYoXJLNmVPmN3QN8gq4888rDnBVOunPZHDro=; b=fMAeb7yvYXlKdJ/c
	dQ9g7I20T5Tu9QewcR12EqhNY84W2mFo7R46rEE+SrUkJ3V9orTv6CqWFOJEbk7d
	AeiFltoVYrMJMo8O2zpevTHSlQOmh8e0rxK8UedK1fsuZKLnbWm2flTKe+zWC4Up
	f33lio3t/Odoy3yCkSeiuND4D3LijAWbpu5Fv9OtNkNVAjbLP8B2w7RapxevcFp8
	g/49ngx8DA4gbv8sSz6pq+JKI+ZF/GbltoGYHYo+/xepcKgNlCY4wabKTBiZCaJO
	HOg0UR96Y16/5GEDqAmh22NjsE13tqIGMydffn3PZcsvxIXbVV9hEC63hHtOJL7K
	ILbK5w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkkehrkd1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:15:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e80f7acc67so13735025ad.2
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 10:15:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793207730; cv=none;
        d=google.com; s=arc-20260327;
        b=hKTISQL9fhBxJpnAmTxvsjQFq+gIlVHEjnXnwaJj4etXYQz87BdR6oybrQd6XTUxLI
         VZuxBo/Eu23ccsnH3K02UZoS3w3RG3AvBcP0m93EZCCZV3NOk8/KxRLOuhezojAVNI1+
         fIuDG2l6aJxpFcH8R9ZFIOgsZLy6Cg9/UEnd98CR7Lw8u7H6Ahp/UrwBxw8twMw9zaEw
         X5wHRXMxC82w4a0TBKTc4EZAVhWsbkGGBrPhDMKfn+W1eyr/Hmld3l/tDfHG48S7prG4
         w3wM1JO/pKYfNA28FC5qg+Ulh4qL64wPlzewHEYzMGKkZzv5wzaB5a1Au4VoP8OhqKOc
         E4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YmpkSWqeYoXJLNmVPmN3QN8gq4888rDnBVOunPZHDro=;
        fh=Mp2ut3Z7YTZDlVT5VRSY8l/Mgv5DyWCD5xoai12tfjQ=;
        b=nxL5dzJnoqVYwYEni6pKl/IvwggS0dI3Vut1MwHd9O7JFWXis7qR2dqils6kAxUFQY
         vf6XWygO7SNfC507sef14NDmNzanwmSGMbpib+JdwSGcb6ioNlBD/S3ciPBFN04psPuZ
         c5yMoOafSR4JVPt84+EXXt4W0DvubVgR29fDYwDqKd1HExJJ1qTJaUF7KvOY+EOZk9Fg
         eRbjYx5kKdEuXjRbhDHG+tTJCTApDQMv1czx91ZJN2P7wv0FHO3Zy9N+PczQOPxCopI+
         whk8DOv5hlLNtFnZkQ5qZHNpXGpMO5ObI61P/haPWzunsdC/JWECt1CO40ae2v5fDHKb
         OIAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793207730; x=1793812530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YmpkSWqeYoXJLNmVPmN3QN8gq4888rDnBVOunPZHDro=;
        b=TSJ1Rcd67p+a7muIL+bYa788xuUNd4J8XY0CiAlrcEsMpoUSM8IipweDTVGFhSAszj
         YUavdp8fRQ+GiUU0qfStvVSEMThsvaPh7bn8WgQpDuRekLW9pZwPyaY6UzkOw/rM9aOO
         +hPX1szXlfGb205Lsz/6oGm+nLUyvwjayASP1ATSoo2vrwLgcIbyUuig8YSOZ1XOPCXG
         VyoFRMUKgK2yzoUF9oORBAhJEGVO9vJCUdoDFas/HsM7wc2OTRk3XOw4AjN5MNT7uI1c
         uU6prtpXy7XAElIfx9qHeDa/9eN7Yxv3T/R86KHSVLB/NncUF+D1xaQksMksLQKkueRA
         I+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207730; x=1793812530;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YmpkSWqeYoXJLNmVPmN3QN8gq4888rDnBVOunPZHDro=;
        b=Urz2X3sfVzr/pkCxB1N0s073J8zpaEvv/cRAsJKukxLpvtebfHzHj2Yfb2RZeNuJld
         jL5H2GBbmHHxSV+g2lzemA/YE90LJdjdlGXqff8ttNwRUR1SCx6+HlscPfFmgcgjKJBA
         zG2X4b15ZIcdAtoamesrnqB0PoLo1JtS/qoWRa1qyvO+NDk9ucLf77micN3C1NgJI5uY
         8q+jPk5ePHYDPTqrP8TxsV3gXCwHdj9EFZSNgqf74LbfAQ8S3mLuLiPfRlwVuogBfiuR
         JVnyywYmrCHI3X477MzVu4XrVfuRDi3ct7VeMs+cxVsQFyiGKNX/Z4Z8uOKVEIBVU8Ls
         QvmA==
X-Forwarded-Encrypted: i=1; AKwUvBw6s9g7OhcZN12qwVlHDSdSKYK7Svlm7ZooVyjzDC4CymxCVu6rRz+k272BadOhrKuE/QwkRqJRiAM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsEKU374wWVXIUCsNyPunAklVx0VsI9zHIIUXPclwmpJ1k5Eq0
	6lbIZRck/j/f/morVaKir/5B9bhItbk/lBLuJ/gDFR4xULFTFzmxH2rXmb7bu48IVGAZNEx+yKE
	bGTDLwQOXTpp9QmpSF6cx6mJB22wziz8Ka/6+N2aURQvK2Dy+kcIyRkrbfDRLMpZt7eN8seAlav
	WPSVaIjsoiWU/t0p7jOR/+MLdyg447Plmb1iuQjg==
X-Gm-Gg: AYBFou0Et5dAEjRlLvpMaIaEW9zOUXvTNp0SnFb02oDMIgHllz1D/19QdURHCHnzwPF
	MHQzn0est+JLmDTiZsFz7UIEsemp3a6rRBI6i2dkAMAvutWliG3aYdUDGSEkpWWBAYSqwH4Z7qT
	O4wISDtRPEUwTxxU2Wrye7MwlXMgG5VdGGoZC6UIrbmkXKPqTHkFs7Oc8r0A==
X-Received: by 2002:a17:902:ce83:b0:2e8:f4f:ad04 with SMTP id d9443c01a7336-2eb003d8f19mr24877075ad.12.1793207730452;
        Wed, 28 Oct 2026 10:15:30 -0700 (PDT)
X-Received: by 2002:a17:902:ce83:b0:2e8:f4f:ad04 with SMTP id
 d9443c01a7336-2eb003d8f19mr24876735ad.12.1793207729992; Wed, 28 Oct 2026
 10:15:29 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261004102848.34563-1-joshuamulloy@gmail.com>
In-Reply-To: <20261004102848.34563-1-joshuamulloy@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 18:15:16 +0100
X-Gm-Features: AclHuK8gWfIFKp-b0kY1y4_xJzO5XJ-X_4HlEsDbtq_-rxGRjXpdy3mzMkpCL1M
Message-ID: <CAPx+jO-kr4gE=ixWA60QF8woRJCJcX0oG3hFBEETJi-XOO091g@mail.gmail.com>
Subject: Re: [PATCH] memstick: core: don't clear dev->driver in memstick_device_remove()
To: Joshua Mulloy <joshuamulloy@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, Danilo Krummrich <dakr@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Bgl_Xx76I5HE60XD0Msmwci7Pnt7P54O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX95vaVdN/IsBu
 7vClq19mh0QQVHWOcLo2lsnVDFBAR5EMl26ROvtxvJi2v22Vb3AbvllEB0uIyFxah12vJRNukod
 tX7F4QvZvOCPGxAGvI56Vj71hqcJTqwpgaxXbzBZqTChwjDBKvwqr7gEEWxNg/PaEIrLiceEs3R
 7rEhF6+S+i3w/LRNuZq+nDbFFx7/r9dLiKYbsgVf2zaUpaZPWRPb+NC8NhRvD71HNqCVURqOLyV
 AAWPuiYIvEGVKnCQves/F7itYzYeS/VFn2/vO2Nkq3IumD9GzgJsOgIpHZe61zAinNY1DlGaaiO
 3j8nKgJjz54QlWrM80DWqeKaUulsRTfBDnzzoPNSZYwaMPFFxfUv+DNS7lPfjjyeIXNJOzCC75Q
 6YUsZpZKuBazHktZ+M03G4dsWMVkJWt5KrtG7eofWsVbys0eC4HiREIevEsNoDDnhghpajMvzto
 1+fJ+NI+qavjHunGZhA==
X-Proofpoint-GUID: Bgl_Xx76I5HE60XD0Msmwci7Pnt7P54O
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX3xv5FkWAc0Mu
 fXtWclRbpuJIv0mrFiD37JFfhv3CZMdtEVvDrxGAjxgSwge/J5l4VkL7NuhcpuA+QuLA4U6kDCS
 /m2fFqP2Ud2x1bPth/aHBLfn4QR1DZ8=
X-Authority-Analysis: v=2.4 cv=bYv+w+PB c=1 sm=1 tr=0 ts=6ae22db3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=pnkmKwQGO6ub1VrLFOsA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280068

On Sun, Oct 4, 2026 at 12:29=E2=80=AFPM Joshua Mulloy <joshuamulloy@gmail.c=
om> wrote:
>
> memstick_device_remove() sets card->dev.driver to NULL after calling the
> driver's remove() callback. Since commit a995fe1a3aa7 ("rust: driver:
> drop device private data post unbind"), device_unbind_cleanup()
> dereferences dev->driver after the bus remove() callback has returned,
> so this should result in a NULL pointer dereference whenever a
> MemoryStick card is removed or its driver is unbound.
>
> The driver core clears dev->driver itself in device_unbind_cleanup(), so
> there is no need for the bus code to do it. Remove the assignment.
>
> This was found by code inspection, with the help of an AI coding
> assistant, after hitting the same bug in the TI FlashMedia bus code
> (drivers/misc/tifm_core.c), which oopsed on SD card removal. It has
> only been compile-tested: no MemoryStick hardware was available.
>
> Fixes: a995fe1a3aa7 ("rust: driver: drop device private data post unbind"=
)
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Joshua Mulloy <joshuamulloy@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> Compile-tested only (W=3D1, no warnings, current mainline); not runtime-
> tested. The same fix for drivers/misc/tifm_core.c, which was tested on
> hardware, has been sent separately.
>
>  drivers/memstick/core/memstick.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/mem=
stick.c
> index e03989c4e..06ee6faed 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -100,7 +100,6 @@ static void memstick_device_remove(struct device *dev=
)
>
>         if (dev->driver && drv->remove) {
>                 drv->remove(card);
> -               card->dev.driver =3D NULL;
>         }
>
>         put_device(dev);
>
> base-commit: 6addb4f385570ebc11c4eb499a4f1c149f313e84
> prerequisite-patch-id: d9a5a385ce2ccea3eec18ee2168d603e951c6374
> --
> 2.53.0
>
