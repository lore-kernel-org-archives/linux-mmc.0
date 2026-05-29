Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859D42DFE0
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065974; cv=pass; b=iDJew12Tg1r4rhI0cP8Jxpba5ZtssheSiuzTxBi537UyEovpG66knsjwm5WRUgHoC45u6eKN3u4CpfCwoKBLpioMwhwsdvZQufIkIoi4kZCRreKs11GamBtsruhUr9irw9kQnjt8TW/KkekWAs/uwlXrYYwLpY6kTqbdDu4w4AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065974; c=relaxed/simple;
	bh=sL3TEBiK8pi9WKBH2RjoQ5oA+3SvEoPSW26Ozhbobic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icvaRygefLvUV/l6ABLrRd/nEqHVtP4y6sUKEIA1RgqyJ7bz+aZcYD19rcmwhbb5aqc5vLe3ui3AnO5QCC/OQZ5x9ouIuQkjV/vR0fsZWnOneABKWMzvzr3UHHy9UDEYJewofuS/oOUW5HnFgspdcjZ8XCNKWTVujzOERgv+wMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UB5bsCMg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wt2kIAcV; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UB5bsCMg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wt2kIAcV"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDKdlM4119232
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G2G6naXLs9q3L27kz/DiIkgF8rDF0Dd6YzjwJ6Clo7E=; b=UB5bsCMgodPDA2kL
	Jzr9FpoYE3pLSJxa82Ke6TaIZDysPWyg/U9LvsmdwxwGdXQJnyjJLe8pki5LllVC
	c/4M/o2g/TANpj4k6eRMKyqQWo4MyzJrNQYNBgO6POlgTgO9QwUWpH99DELwWO2H
	f5U9jdtC3/CU8KYMDeSYrD4ctEo2leMkeLW0uhtD8OJPq+qeOtHZ+CuX3kixQHdY
	co5LKS1lBTg8HkfDsXbxun13ZqAeXdRMfnlhJFK1/zCyH8Hq+gyUBziQv/7Qt5HO
	cP5WHlxEwY0HfRweFxuI4ErDK59LEdpfmcCcF/z9JXOBA0PV8g7Kl+v+P7snMzFk
	4Naq7Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef8rch2pp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:46:12 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8cce230de8bso25701146d6.3
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 07:46:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780065972; cv=none;
        d=google.com; s=arc-20240605;
        b=NVYcbbjRrpWc9zJFfXpHGIAQ9T8Zd3fYbymRiPaXYPSEueJ/joB1w1B5tk237vBPAp
         FFvdstxs5iUDr+sPSIFs/ZCX8U0p/xBk4QmPTUC67AMd04y3VBtpdoXBTuZNEmWzpVHP
         XVfxM/CyqGdgHiPZkIphQvfSqMmlgEhmnPO0fgxSAxscDzCSgFbrSQzhrHIarliejcUy
         fxI6Ib6dnpY1r0GhDi8ne6Q3xP4RP+i7sjEOZT4z4BpVIJP0ofCFTHBuSoeEAwrVRfL/
         cHOqApiR+omCTeN9iFuOgEbUEMWE3udpt2pG/n0CtrurUkoN3BhCd1HdY2aTePvAbrj3
         vK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G2G6naXLs9q3L27kz/DiIkgF8rDF0Dd6YzjwJ6Clo7E=;
        fh=J+QJGvHsoVDDBpizp8MlvQ9HKU2GCweP320LcYru8IQ=;
        b=hm0iwSgYnfz2yp1FjA46yqSwGlZW6zxlv0fpuwbrtiKxBTLuHAn3OzAL/XTl7B/MG+
         AKM0i9OSH9TuVE59oFrVRS8prK3X/nschEoKCy6+JZE/rYJmQwdA4OkrybFn1M1LOMZr
         ofqMDLfhsIr+MTFltu4GMDqw20CRtm27doi3n+F4TMFisguI1PC0L8fISBtRIIyaEs80
         Ck+bVH5Hc06U7P4nQbqmHSqvuLmrQSbatLiyZPvfd6BfphUauj0kM+06plugPuL3NVA1
         nfYg7IIrQOFYOrJmXE/KAUFeUhklsv141Ed9qFiqKBPB2IqAhbM5m1Mh/VoVQUx1w3Fp
         jgXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065972; x=1780670772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2G6naXLs9q3L27kz/DiIkgF8rDF0Dd6YzjwJ6Clo7E=;
        b=Wt2kIAcVVdp+zJls4RpIOqKbHcZ0UdSx0fY+T4EqhGL3+I9yoxpKZ0gLHekyYkdUeD
         tziTdMT493i5dXQP5MbTU8+ap2xNbDf3MZlIo9PzoFyULLGE9FMyK4By3qYEo79hosb6
         lcNhcbB6vrSTw6Uzc8+UQPpOniRBVHfk3dDjIH6AyMAglMLMuEHEULUjBXPZUupIllD5
         j7Ntr8GlM8cqXHM83bSbbDPReH0mvWGmIYZfHeomLUSrXgiZhs6MzCBjy6q2i6HR3HRf
         yArIpLbSTYpOGws/HNlkfi6yZ2DR6uEIP3uSWY6j71xTBavWzzXNE6N+Qwl6ZYiqDmPN
         lzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065972; x=1780670772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G2G6naXLs9q3L27kz/DiIkgF8rDF0Dd6YzjwJ6Clo7E=;
        b=bqQM70HQGtCCLsZGWKjg2nezUv1ZWVLXiOp7KTgeFvCTBfpw+zU3WSjixx6P57Ka5Y
         qYoD58rRH5Y8RqypOtZXmINkq48PfWqiyBeQfS9qoBTTgz37LiyjP+HCw77CRAce1pIA
         5GRtxxTdV2zcbEL7UHNNE6i8Oblj6xsoNHEr6/6MZfE0vjzqb784zN+IQ9ve2OSIrWXv
         K5Lk0hiT4tN9SKxxLc4iftVcYOUe8Dr3UDG0MxFsiQ2SovnWCo+WwIwDTvZqjUJVAtNi
         TMBCqLGEMb4TL0WLWrfi/OkV+AKgCvgr5m6Py8JhXClmxyrhyAmwhay4y5s+CyHaK2iE
         7Sgg==
X-Forwarded-Encrypted: i=1; AFNElJ/PRCIO8r0W2h+Z1En0zeC0wGwSbDNfTThOVKuTXHy07igX9qX8wh9lQD9jfEgzV4LbRhwfXWrSdqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMiwiLP2w1cQZ0vD9gCzqvnev4FMSX7zth946J4iIc1UeSLB+n
	SSkVBO6iG1770CgWz4bK2mHfCgetD8UmfnWAcx4PWr/rptR6WrsuY2j3ZD5W2YhBipSpEjxvgiS
	gzZYT06dR/GGa1Gn/k/3IBBzDt08s0RS2m8g/qNQifuBXWevHf9zlH4uNOE+/4aG3G/fSwfuY7m
	tit00HMPBH2C5IelJPnWiGpJCLaTQf3pUfdwW94w==
X-Gm-Gg: Acq92OE7pNkxceljh5DHweRL/vICO0FhCg8UdEGb1XQSjzsSBaq9uvGfAq/bIoF9c5U
	aMoCkvvhSULZIOTgqDA8FGqGbQFv8Sj/ELipL4XVEeR0b2Te4JzyQPgz2uzMErNqMdlQ4t7pmCe
	9w9Bmp3kx0/QA0MAV4ZYJU7ui4XH2wb42g9zBcjqPkcpvVwRRXRbmtdHXS7m9LFZw+U26MRd6Mn
	oOZqM9Op67p56utKw==
X-Received: by 2002:a05:6214:450c:b0:8ca:164c:a851 with SMTP id 6a1803df08f44-8cce8268fbemr37798406d6.41.1780065971807;
        Fri, 29 May 2026 07:46:11 -0700 (PDT)
X-Received: by 2002:a05:6214:450c:b0:8ca:164c:a851 with SMTP id
 6a1803df08f44-8cce8268fbemr37797846d6.41.1780065971191; Fri, 29 May 2026
 07:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529011739.4381-1-shawn.lin@linux.dev>
In-Reply-To: <20260529011739.4381-1-shawn.lin@linux.dev>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:46:00 +0200
X-Gm-Features: AVHnY4KNY9h5A2UcaphJFuGCL-L17d2kY_-BhzhTPrYBp12fDu2VoQ4VwjQ0a_s
Message-ID: <CAPx+jO9cP8rYVDKtg5wn_LR5gYeNZ+yBvWZbO+artHOcphHPFw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: Add desc_num field for clarity
To: Shawn Lin <shawn.lin@linux.dev>
Cc: Ulf Hansson <ulfh@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: a8WWqf0v3bfNAdMY1VCOGkzD2P_4_LC-
X-Proofpoint-ORIG-GUID: a8WWqf0v3bfNAdMY1VCOGkzD2P_4_LC-
X-Authority-Analysis: v=2.4 cv=DuNmPm/+ c=1 sm=1 tr=0 ts=6a19a6b4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=s8YR1HE3AAAA:8 a=6ieH-XyiOJXlrzV7WCIA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NyBTYWx0ZWRfXzIzCmRjPO1z8
 BEo0JOK6YF8coBGZ+plnsh2Z9LRm0tIgA5u8ECRROxuPDLogAp2ApEJEZyhn0H7Nxs/UIlgpG/m
 iuU78bFFKB27wUhU6e7DL8/oHJMUGUO0ofGgMsKCt2L0oUhDYyD5F+xUTStjf9QNLnwbCiVfbM1
 cfssp/McAyqFz4Lf6axwSb2GyPQiik0uyL0B9T2zlRJxOavKp0nxtR5RYYqXp3H8AlkDvGFHzI1
 +4uqg5Zrescq53ZhnBgRAWLt8qijuiMTB5AZ9Vs5i7X/hdA1UTwAE8t2QlJm6NEHkAhBVXnmn8C
 MtdWfl6aso7gJovmhYFtPEEGtiALG20B8JBM5QQ5ip0Zk/rSfaOOzvx93bypDujVBJNnNFcNlHC
 9nA7mqZ9jlLp4ot69EZCIIxCsJ50+Hd8RSSVsPGSSr0djbocr3n9EaW5DP6V41W9jHaDTpUifO6
 whk5QECTOUaKSbj1SqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290147

On Fri, May 29, 2026 at 3:18=E2=80=AFAM Shawn Lin <shawn.lin@linux.dev> wro=
te:
>
> From: Shawn Lin <shawn.lin@rock-chips.com>
>
> The ring_size field in struct dw_mci is misleadingly named.
> Despite its name, it does not represent the size of the descriptor
> ring buffer in bytes, but rather the number of descriptors allocated
> within the fixed-size ring buffer.
>
> The actual ring buffer size is fixed at PAGE_SIZE (or DESC_RING_BUF_SZ,
> which equals PAGE_SIZE). Within this buffer, we allocate either
> struct idmac_desc or struct idmac_desc_64addr descriptors, and
> ring_size stores the count of these descriptors.
>
> This naming has caused confusion, as it's also used to set
> mmc->max_segs (the maximum number of scatter-gather segments),
> which logically corresponds to the number of descriptors, not a
> size in bytes.
>
> No functional change is introduced by this naming-only patch.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes v2:
> - remove ring_size
>
>  drivers/mmc/host/dw_mmc.c | 16 ++++++++--------
>  drivers/mmc/host/dw_mmc.h |  4 ++--
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 3b4157f34d11..d734d010444d 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -490,12 +490,12 @@ static int dw_mci_idmac_init(struct dw_mci *host)
>
>         if (host->dma_64bit_address =3D=3D 1) {
>                 struct idmac_desc_64addr *p;
> -               /* Number of descriptors in the ring buffer */
> -               host->ring_size =3D
> +
> +               host->desc_num =3D
>                         DESC_RING_BUF_SZ / sizeof(struct idmac_desc_64add=
r);
>
>                 /* Forward link the descriptor list */
> -               for (i =3D 0, p =3D host->sg_cpu; i < host->ring_size - 1=
;
> +               for (i =3D 0, p =3D host->sg_cpu; i < host->desc_num - 1;
>                                                                 i++, p++)=
 {
>                         p->des6 =3D (host->sg_dma +
>                                         (sizeof(struct idmac_desc_64addr)=
 *
> @@ -518,13 +518,13 @@ static int dw_mci_idmac_init(struct dw_mci *host)
>
>         } else {
>                 struct idmac_desc *p;
> -               /* Number of descriptors in the ring buffer */
> -               host->ring_size =3D
> +
> +               host->desc_num =3D
>                         DESC_RING_BUF_SZ / sizeof(struct idmac_desc);
>
>                 /* Forward link the descriptor list */
>                 for (i =3D 0, p =3D host->sg_cpu;
> -                    i < host->ring_size - 1;
> +                    i < host->desc_num - 1;
>                      i++, p++) {
>                         p->des3 =3D cpu_to_le32(host->sg_dma +
>                                         (sizeof(struct idmac_desc) * (i +=
 1)));
> @@ -2857,10 +2857,10 @@ static int dw_mci_init_host(struct dw_mci *host)
>
>         /* Useful defaults if platform data is unset. */
>         if (host->use_dma =3D=3D TRANS_MODE_IDMAC) {
> -               mmc->max_segs =3D host->ring_size;
> +               mmc->max_segs =3D host->desc_num;
>                 mmc->max_blk_size =3D 65535;
>                 mmc->max_seg_size =3D 0x1000;
> -               mmc->max_req_size =3D mmc->max_seg_size * host->ring_size=
;
> +               mmc->max_req_size =3D mmc->max_seg_size * host->desc_num;
>                 mmc->max_blk_count =3D mmc->max_req_size / 512;
>         } else if (host->use_dma =3D=3D TRANS_MODE_EDMAC) {
>                 mmc->max_segs =3D 64;
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 2ce8585e2c1e..9ffcd3946cff 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -79,7 +79,7 @@ struct dw_mci_dma_slave {
>   * @dma_ops: Pointer to DMA callbacks.
>   * @cmd_status: Snapshot of SR taken upon completion of the current
>   *     command. Only valid when EVENT_CMD_COMPLETE is pending.
> - * @ring_size: Buffer size for idma descriptors.
> + * @desc_num: Number of idmac descriptors available.
>   * @dms: structure of slave-dma private data.
>   * @phy_regs: physical address of controller's register map
>   * @data_status: Snapshot of SR taken upon completion of the current
> @@ -186,7 +186,7 @@ struct dw_mci {
>         void                    *sg_cpu;
>         const struct dw_mci_dma_ops     *dma_ops;
>         /* For idmac */
> -       unsigned int            ring_size;
> +       unsigned short          desc_num;
>
>         /* For edmac */
>         struct dw_mci_dma_slave *dms;
> --
> 2.25.1
>
