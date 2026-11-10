Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794319418;
	b=whrBUbuyXR4pif+4XaMoU6QWzxIZvV23GpkbZynSLTu+DVdIr4Fc7bMTkpWmgVEdSMhb
	 1GvSikDxDrdpMT0fqzRimGBL+Au3nK5M5EURayi6NMwTgy13eJ/0ZSkxng5e1DmjfcYMl
	 dMoiHUlLLWVNoyQJzefZU0RnttQ6F+TCwcGPAD28foqt80mp+QNy+8NwoGBSSevGRS0un
	 McmJiXzrzruAhJFnQ8OPDgeFPdqeBvM9K6nz/DS/SimNk2yW9PymHUMxH/1WJp6nyIwn0
	 0SGil91BLvSEJyGkrpcwgTNFu4c1ksqHmRVZ8OIuz1GJWD1iUqCtu1XfiUH3DcOEBfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319418;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ek5NNY/Kina5esSdV1eh8PHtvhY8sTVXt0HaMhKb/+M=;
	b=cr9d7xj/iG9/3ogoFYOOK/sNYFAAtniJcWrJ9FKYSh6n4IDW7xAfUNRPGvrrfyOg1Ke1
	 pxwDHIgxR+6uUbbbwqP6/kN4y+PM1Bk7dZLsIx63O/KoiUUkWqmjLePPoJtnrswGeArBT
	 XciNJcPDm4XKjnT3mA8PpgZui3631g0RsNjNlv4tJyD89saKEMFSWeIyD5ZdbNQLzTDe+
	 MQx1WLdYz2RbPYNXLxYD7kj8UFbpmrDtlHiO/QBxh5Z9tacPkbqCDoN/1RLM+zxXKJGyX
	 JdXeEETb9N4vcy/ROCcXYWKR98oxLZqMwEYV/rf1ZFiy1EO0CnfEcauqVYU7AjvcRng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=duCEkvbl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZZUliZfK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C61D60A2608
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 14:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C61D60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=duCEkvbl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZZUliZfK
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABA9vE3196161
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 14:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ek5NNY/Kina5esSdV1eh8PHtvhY8sTVXt0HaMhKb/+M=; b=duCEkvblviFFNHrQ
	BFI3/JtAG3aSmw8heuXx6P5iVUOg/m5xN7jPov5yWeqyfAR0SOlV6YFMLu5I957x
	PNqsz+xC4i9iFpyP+aOH/6USXcwJQ04TM114LyKWkyToExiWrD2+FolaA/obNvhj
	jeiST/GFCv1T4h22OAtMko1mTykkLi8BH5rUt7mmIs6a9PSal7svLt/yZFCt+1dd
	UTsqWiBYBxyhwIgNernFyDck5yF6z2MYquYjLzpaqErlJLawSNYgjZEqhPeXeIql
	TR6/k06/k2IF83JUmQ8k/59gYxEEw2MiolPq2JOSjVHJtIGiVZCyunmNs9Iu/EZ/
	zgzGZw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv03cs1ra-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 14:03:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2eaae8d29e0so28676395ad.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 06:03:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794319416; cv=none;
        d=google.com; s=arc-20260327;
        b=eFkq1+8Eq19dFH+8Lk3JlBY+Ru5dfs1fR10AihUlPBTJ8AEJlY4aWoKHo+GBGzIy8Z
         aHFL8TOCnLAaWHdgrqc61cE45fzKr/Di3aKuWyc1xWVNake7+vd789vOadHHkrZFK129
         pAmUHRPn3Me9feREtxi+eKumbKV4/7haWQ2XkAGo7np8JX+dGnmoe9o6BAcgxaI6fq6k
         nQslly0OwZjraKNSZ62EC9qtf5CsPJNXxE6yoK/JZsjGhxRTMnmN52TEciLT0iqmlUm2
         7kV4h5GDXeR+/cmAKgSQjaZRmPIKVc7ZVXqxmuU04jL3pqV4aYi/uEJNezTbWXlkNiqL
         ickQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ek5NNY/Kina5esSdV1eh8PHtvhY8sTVXt0HaMhKb/+M=;
        fh=xkFbThGybA4WD3X32Y8/v3RF7YbNbh9KHCvwdRDMikM=;
        b=XnsuZd5K6/XGc4SRtX27iqhyz/v7N5KLuA6W0r4qQeZCdhKXqLm1NaeuOtx60O0Olm
         24KlK5raGP+MdVTQIQ9Qkv9urDl6p6G/t/azlNGgmhYFNKWxXHucdEjtM6P5UFDoKoFH
         1VPj8C0IrfddBGJDmBzgAdh6wh8bBWDwCKNQtUb7LYGXNcI/fSAtsIf4XfQ9fIh3ozQT
         4So/YE1fQa9/F2l691As4Ajy7uNl4+cxgf+L+/cAIRFyQLaGIhRCBhpcSZY+fof7lAP6
         JlU5ya+9nwGmDHBz1ynSdh98BI7ekUBo8FwtkKXGumZIV+fNMdWyFHT30CjKg83V2mOJ
         5tOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794319416; x=1794924216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ek5NNY/Kina5esSdV1eh8PHtvhY8sTVXt0HaMhKb/+M=;
        b=ZZUliZfKiBmVwSXUrjbgWNZkQb0ZQLoCpVS0JYUF/2wNL5Q8VihSAFCMHkc58exuR0
         j9MmHsFHrnXYePaPrMdIEw1CKLcM14lwwSiUkU4ItAA2FsChIGjKbl9AfKLpeNHtzy7v
         GU/C6HRL23F9pOT8r8/3HC/kHBG6hv+nW1+yaTNyhdtKa4uYZtcY/9XGRE1Sqf2fwKTw
         2OnMu9lFn3Sbee0AEsvGrXXN7VSalX5MajV/7icl5wgzIoIB97Xe//yxFUr8nyRED4D6
         Mw+WjgLzoFY+VcEwgvhvq0Ann0hqkjHRxRqBlpiYKrPdWBXgrk5syfpc6nX0WVPx8Q7l
         8pyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794319416; x=1794924216;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ek5NNY/Kina5esSdV1eh8PHtvhY8sTVXt0HaMhKb/+M=;
        b=kE3DhrupJ+UDPFcjkK28Ct88tPr8pI2WasafntqochvIqsNowD1ooOc3DKFwkXD9Xg
         zhWYYkGARYsPyQ0M1HQTH3mERrU21cznFBCiK+Sl8Kw/hsrfERHKX8Jp/3iWtMDb9vak
         5ehxBk/VC/GvcLYUQ3IWk+uJDpybOSdqywBnf09iuHyWKHsJjLQQyqUgA/ixlA6Y1NRn
         gGakNp928257Hs7EUTpuqqw6y9FF3zoMSJJTSp8vv8Fy2xUCCKS5/T7lYZiyvDBiJ3FV
         dAVnCuwy+y6a0iCJOabwiGwmHp+0QTTroPYuB0MGOPkqs70caOPf5yYJkQgZ6Pu9AcK+
         xmHw==
X-Forwarded-Encrypted: i=1; AL+hErFWfIVE58pzPdQ/pvk+koSL67NQcEGRqiitJasWBsda4ukR4RG5YbFZkbaRORJpoOZIKC8hoj6QJlY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bV8qYgFpzfKMMoXzMgMMffacNIVZZmIJvbNIGGx6f9PGm5ZTl
	NtGkh7rv61tzrTdsDIvQLCsPVG4wH0p+9QsRzPkRNgDZyAoNUmJXcyf2608UyDaZa8bp6krJaA0
	Qn8ZPD2ZvoU7Tl+Ejm5Mx+cMjYimghGPgY8Wz094GB70fwu/sv9SbfHPP3zWXMGGk67s9OSUfjB
	B2pO8Ohf2XrsHQ8kh0eq9ALptwOdKZRi02mbqwHA==
X-Gm-Gg: AYBFou0hhZDvcNAM2Z87woe80fhlVzpX31IdPD29/q1NNbg3VxTJMHaYM8zp+H4ZMwP
	ExBRLkjGS7iHVwX2K87YQdQJwzVC9unhh4JjUvTC1s1UGrZbK9wG8jlFJxC71YRkofz3c4kjcA8
	jLn0nFE6SaCS45saefCgL34pT9MPVgmJdUNBNBcmYVWZl/X7WolXdUSnorKA==
X-Received: by 2002:a17:903:4586:b0:2ed:1b26:2bf5 with SMTP id d9443c01a7336-2edb929234bmr24126775ad.44.1794319415862;
        Tue, 10 Nov 2026 06:03:35 -0800 (PST)
X-Received: by 2002:a17:903:4586:b0:2ed:1b26:2bf5 with SMTP id
 d9443c01a7336-2edb929234bmr24126515ad.44.1794319415317; Tue, 10 Nov 2026
 06:03:35 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030143151.2916788-1-codex@local.invalid>
In-Reply-To: <20261030143151.2916788-1-codex@local.invalid>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 15:03:23 +0100
X-Gm-Features: AclHuK9c-6I-YAHtE9dTnl7aHjWrrxjIwBDk_O287mNrvM9-nmP2rQsZ5uVzYFA
Message-ID: <CAPx+jO-jo=1rZJ5ps127D0xoHnWmqZFmn-Nq+OkECVGvTQzZew@mail.gmail.com>
Subject: Re: [PATCH] mmc: sh_mmcif: unmap DMA buffers only after the transfer
 has stopped
To: Codex <samarth.colleges@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: oZjdQlaioKTn0k6LWHtVhSfnkk8K7hq_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NSBTYWx0ZWRfXy2a1BOkG836J
 wQJgi6saXMd73D++o+x9XdKh+ioW/6U7atJLmsiovS+2c9Y4xGOICHk1gKQoCJ2iNUknjpg/C4H
 ePOI0kcUGQo3a21/WBBk76JYbGmYl2o=
X-Authority-Analysis: v=2.4 cv=FuiQbGrq c=1 sm=1 tr=0 ts=6af32439 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8 a=e049Jz8NGw_-8GbDANAA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: oZjdQlaioKTn0k6LWHtVhSfnkk8K7hq_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NSBTYWx0ZWRfX0t/Z0McV0SpA
 OwdtOhbM5ca3uL87TsqvOupR9Nzi49V6yYUBLcwkd0TONozMZzCch1CiagkOjupj9OP4pn/EIXv
 MQ3uIwWXnn0qGGMKlUfMJ36/oRICNK9M2WpdBi+KmrW7dOrG019HfD8rk22153179tb2DWgVJCK
 b8oB+V8S7+cpBe4Ri7ts/qKNq14J2brKtB3MfllHDd1TAqHMAhzLkX2D/52TNTbOyDe85Eey2BW
 0jrOU5jBz4FckN/k3xf2XRdhlWBCbAaSM9am6l3D33vNjDFIRLa2uS0RccQmoC72I+QuJknSZPR
 Ja7Wa64AW2PJUCCdyieLqq/caflDU1Ud83H9QcR0Z84w30waRIaIay+bby8dmShXxGcymT9ftdZ
 XofQponbOJ7pTUNINGjAxcLkb5biUj48pKTZ5IyrbZj2kxj4zjJo5c+dcjY4RYxn0pUYNJOTwxR
 xFZQsGEN1+Y+N4fQOLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100055

On Fri, Oct 30, 2026 at 3:32=E2=80=AFPM Codex <samarth.colleges@gmail.com> =
wrote:
>
> From: Samarth Narang <samarth.colleges@gmail.com>
>
> When sh_mmcif_end_cmd() is woken by a data error interrupt or a DMA
> timeout, the DMA descriptor may still be active. However, the function
> unmaps data->sg before clearing BUF_ACC_DMAREN/DMAWEN and calling
> dmaengine_terminate_sync(), potentially releasing the mapping while the
> controller is still accessing it.
>
> Since data errors can be triggered by the card, a faulty or malicious
> card may cause DMA accesses to continue after unmapping, potentially
> affecting reused IOVA or SWIOTLB mappings or causing premature cache
> maintenance on non-coherent systems.
>
> Move the unmap after DMA termination so that the mapping remains valid
> until the transfer has either completed normally or been terminated
> synchronously.
>
> Fixes: eae309836509 ("mmc: sh_mmcif: Terminate DMA transactions when dete=
cting timeout or error")
> Assisted-by: LLM
> Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> This issue was identified through static analysis of DMA lifecycle
> ordering and has not been validated on hardware.
>
> Since the request pages are not released until mmc_request_done() is
> called after DMA termination, direct-mapped pages remain owned by the
> request. The potential exposure is therefore limited to the DMA mapping
> layer, including IOVA or SWIOTLB slot reuse and premature cache
> maintenance on non-coherent systems.
>
> The fix also relies on dmaengine_terminate_sync() stopping the channel
> correctly on both MMCIF DMA providers. However, shdma clears CHCR.DE
> without confirming that the channel has stopped, while rcar-dmac polls
> the bit for approximately 1 ms but only logs a timeout if it remains
> set.
>
>  drivers/mmc/host/sh_mmcif.c |   23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 8bd9cdeda..7b33f832b 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1173,15 +1173,6 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host =
*host)
>         time =3D wait_for_completion_interruptible_timeout(&host->dma_com=
plete,
>                                                          host->timeout);
>
> -       if (data->flags & MMC_DATA_READ)
> -               dma_unmap_sg(host->chan_rx->device->dev,
> -                            data->sg, data->sg_len,
> -                            DMA_FROM_DEVICE);
> -       else
> -               dma_unmap_sg(host->chan_tx->device->dev,
> -                            data->sg, data->sg_len,
> -                            DMA_TO_DEVICE);
> -
>         if (host->sd_error) {
>                 dev_err(host->mmc->parent,
>                         "Error IRQ while waiting for DMA completion!\n");
> @@ -1208,6 +1199,20 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host =
*host)
>                         dmaengine_terminate_sync(host->chan_tx);
>         }
>
> +       /*
> +        * An error IRQ or a timeout wakes us up while the DMA transfer m=
ay
> +        * still be running: only unmap once it has completed or been
> +        * terminated above.
> +        */
> +       if (data->flags & MMC_DATA_READ)
> +               dma_unmap_sg(host->chan_rx->device->dev,
> +                            data->sg, data->sg_len,
> +                            DMA_FROM_DEVICE);
> +       else
> +               dma_unmap_sg(host->chan_tx->device->dev,
> +                            data->sg, data->sg_len,
> +                            DMA_TO_DEVICE);
> +
>         return false;
>  }
>
>
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
