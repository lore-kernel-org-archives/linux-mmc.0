Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB73E42CAFC
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352863; cv=pass; b=M1UMi4jQGk/YSlTwn7bqqgkR3sTxzJF9QHDcfZ5zWD8AhTk9xyzvTPxTQNTY4yC4zyuOqpS6UEgFLoxytCYCDwYWUyh33VhGbjjkdY3AjgAcLbhROVq1ruGtwH5Q4glJ3WsTKoJ9g4dnvkU9RQUhVRz9SOx3gAh2RJDW/YVlQtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352863; c=relaxed/simple;
	bh=29P9VPgGX7mZTmd6b5qXu2N1U635wudkPvDtA9fCQRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m49yJhaMUavpgxuiQzZtygfLd8X2qPui0XV+jIHgXWHvwZq9IwFFPAjolgx24H9au3O5WVdzCbYD2mS9e9Tr6U1OwL4gB1NMrC32FHEGZhrCgfhJYntq24G/AzFpcWpD/vuWXy5d8k+V/7LDqNcMKT3vFuYB/f0OMNnmctLDrMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K72XTYNX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kaC0yRvU; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K72XTYNX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kaC0yRvU"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF6Rj832925
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nY11remPM00ox2dUT5/JvGExCsLIzC4d4gDZ9QNSpkk=; b=K72XTYNX+HH+aZ/c
	bAWy63/5HecWdJrCwUNyW1XXNejZTD0l81/MbTpUTxVJX1EB5ws8WlBtLWUmHrz8
	2V1GK7Zsb+T1WX5cfizym3lxuO9kYrRbY9dT+dzxBW1K0HAnnnEuyQvl86G1Y0FG
	pTket47qp4zrsL2H+FZ8V9Peb7hzqUDM69qvU2D3NlZCtKnBsuHYvFd/AHNAOix6
	DzuAvg08xwPDo30Sw8cVPJbxOV32hbQMWIEX/eBCPWcqeN8xZRPclwqnvLVvpPQG
	JWlCj53ntu2O3CpEN+fPyuOGFoEKI5IGDjIkHD7Qjfe9ljhSL60gkr0lKgM+hjww
	2AYvlQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98hh59-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:47:41 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f0f45415cfso39825696d6.2
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:47:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352860; cv=none;
        d=google.com; s=arc-20260327;
        b=he2R0+M3i865nlIQBWv0XCgbt6f4sOhJ1Sr++kA+U5uxS4K9s4AfYctHvj9anp++62
         saFnejPF+rOdJlUVJLp6zG7ySDEdmzrYx/XP5HHi7hFOt/7O1DpVb9S8efOxzUxCeG7T
         J/SUmtkdqAC0q/SjYbqbLhY2ICUQ67PXgTP+WFmzL/8DPWoiAQ53TtIlA3sTpW2o7dmw
         wQ8d6HqYItX+g/pr6mQ3ptiNaKjknTRACd2cwsvaaLP8E5bY9cOwecgK8NHQuF3zAxms
         KsIQowbfY0QyffeA3AzfYjnqUjrVOLh+6cBMnQj2WqAEpo/UArkR36BCQkHKyHCqjFWn
         1kJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nY11remPM00ox2dUT5/JvGExCsLIzC4d4gDZ9QNSpkk=;
        fh=RDPh2shQwV3QcT9crU2kx0uq4FF0V3a/jnDcPehwMYM=;
        b=cGYfFDAOZdijfehCHej0v4+Q1WPXQ4QGKf6ttnS36twF5JTgS5yf93AC5QorwWlco4
         Rgua0ggsxf0v7DPQqpykziJR9yt0R3JPZYBcfqYS6bC3sQnKN51QTQG7bfABP7EOaoak
         5qiw617SS5odV1VPUAhIHrQKopvBmytT0qQMSpcniM6pzR/FAY47BpxLDum9lc5Wjln8
         ygyfryctuEJ0aAQRTj75kX8ohXEJn7eO2JAu1fU+jPnvQkCNkoG3LqtZmovFEyx0mPP3
         jdbj44lCqO9+Z6CJT94ooQ3mRpyDrp/FPmM5+VUfiwrzgmHALYT1YSchKpTgKWI83wjz
         RFIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352860; x=1783957660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nY11remPM00ox2dUT5/JvGExCsLIzC4d4gDZ9QNSpkk=;
        b=kaC0yRvUTMP+gGHTiGu+Yqkqqm+441b5urhUrI7/th1pPr7iFr5mwd4IlZaGZ3bO1V
         gYdL7Np4pPDiNzLIg9A0wUcCiKxeYjud8CQ9ind1+sgh5jF0tGu1YwSUy3NToflmIOVY
         caEITNxdJFYnIQvn0D2A9ijgi+5y5Qvo0vROWNvFIhs3vSkKGLoVQrObjaUyxHYlAAio
         w9PvmFV+9wqY9i6ze6SzuqB6FQ2gJWApjEo+Rr4HHqmL6rgI4fPegi6GaBGfvoo4wn6R
         +ygWFgEa55Eq+SGd6v11r175UuoolzOe1qfXsspH0dUTV5xzSPhvpzdq0hOX3lkk9KkZ
         qRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352860; x=1783957660;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nY11remPM00ox2dUT5/JvGExCsLIzC4d4gDZ9QNSpkk=;
        b=g9omV+AhxZpBM3jua1jGvbrnVoFqGKxyXDsaAh1hrJ2zCuo0sBYVvea7J8SyMBmtFA
         DEsf8Scs2ocvsLhoDtFI6SzQ7EJPKPMoS/GCNjC8SrBYRPuTzbV464Bhix16ORNI2p8Q
         eMdfzSqBKTfKmveMGYAITwmoaKuaU8qh2wVBq/0vP/QisRVOQP+mlFkX59m/OAxWEIi7
         YgzTgk9TxYZ5K53RLKwyJa0nUBTsplOOOb14YuneD8TVwh2J9ijMp+GFjriA2FTvg4D5
         4yeOVJeJ8VvSwctQP+nXv6GsQtYcuIGlIYMG+dXr2/W84+HCM0rCojMxeeAtA+ZYgLpw
         srwQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzVRyRApbSruQn7aRV917Thur8IhggQxM2y4JTNJhehcXc5EFgMQt69F8VQiPwFjO+c9FAPBGDDGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwnheYEC1RFRNgBWj5bXP+nutCFyDXIWrr7g0JvtX8eZ31U9yw
	HmTN0ZRYwkrKUauiE2ZKx2tYk8y+7gaykw5r+0n6SqRpjlYNoadADu7wBeh1/FPI/gx3+VSFO0u
	rE+7DqoSM061WGgZdlBnq1K40WpVVLlvlsrfxrDWUbAVqwOISdNaUhtPo60L5eLydDBdAExNXE9
	LK4Q0i3FxQd0I7Zr3DAVlSMOjSBRWSP71YlJgu5A==
X-Gm-Gg: AfdE7ck9c5KWInC07+tqKFOl8xt+em14GE+XIGj32jwLejF2pLR/oKdUvnCQBfaBSxI
	BK2H/UvPPUylcV6CLRDZXTGyC+eVqmf74jLRwHlfmGKECVCrsA5eQ+3k7X2KK8ms7RBf4cAg/eY
	cDLns8pq40COyMt3fishM/Kd/jFAXr9dIs0ZRm7jeJv0CteIcYXSHNr+DM5E35tTMOrrgL
X-Received: by 2002:ad4:5d4a:0:b0:8eb:24e8:8d28 with SMTP id 6a1803df08f44-8fcb4904bd7mr14700056d6.46.1783352859954;
        Mon, 06 Jul 2026 08:47:39 -0700 (PDT)
X-Received: by 2002:ad4:5d4a:0:b0:8eb:24e8:8d28 with SMTP id
 6a1803df08f44-8fcb4904bd7mr14699246d6.46.1783352859313; Mon, 06 Jul 2026
 08:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702082745.1887848-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260702082745.1887848-1-maoyixie.tju@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:47:28 +0200
X-Gm-Features: AVVi8CcxoicNxfQJwCTBEOzDpsFYzI3jpRVrUyh4UgZ-JJselidihhu0qwz8JxE
Message-ID: <CAPx+jO9y4+g-JfavOTE61ySBETUMfDzb3q1_B835wyW0nR4uUw@mail.gmail.com>
Subject: Re: [PATCH] memstick: ms_block: reject a card that reports too many blocks
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4bce1d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=tNl43hWXhZtbijcVpuMA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MSBTYWx0ZWRfX1goaBiwfzP+x
 e2mNZbW9mmFnSzjFlzMmO2tF9E+ZckNOVNNQUTJkFA2GhSlouyolID+3Rd/yJF4haG9Jd1u1btk
 M8N8deD3OO6Uwcv68MlN6O9etynR5uj14nhUnmPCRisYNEUuzo6LdKobFcs/GOwyJR9M8YsctZg
 oyrvHJQ8k2F7F0hff+xNZ3TxZDt4uUMsJ8cwP1ty0llSX1B0/ee+g81p7fTeAfzaKfjw5ZkDtAR
 dMtGvS4P0cK/Kn1oqBTT/KuKuZPaVlwtq6839hJetxzF4gkp8h68XlgRX0sOWz53newspoB6v7a
 kOmziQp7bU9cTzeuvcW1MxPws+80umDfstDUo9MC2mKo2rQNyOadXPh3a6lOIECdj6WnzQzTLjt
 HaXY7hkKEcDjKBh0So4O2QMqhtsB7xBavmQeRmW+TBMtq3tdafi5gYxok+LSEvtpfMuTTlNvfFk
 TQA/eIS9bRtxIEv+fVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MSBTYWx0ZWRfXwXG86nlVXeIC
 vWEZ37R75MpXqRCTWbqHx+JuQ60NMst8SUwNXBSkJ5IbpLeQPlnxbLlo249PCz3wP4rAp7sHbAw
 sfjXQqmpxzd8akmsfl8VuNXWXiDEXbg=
X-Proofpoint-GUID: qEi0aPn8Kmm3IT8IfAwrbQwkPbiIVHhx
X-Proofpoint-ORIG-GUID: qEi0aPn8Kmm3IT8IfAwrbQwkPbiIVHhx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060161

On Thu, Jul 2, 2026 at 10:27=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> msb_ftl_initialize() computes the zone count from the card block count
> with no bound:
>
>         msb->zone_count =3D msb->block_count / MS_BLOCKS_IN_ZONE;
>         ...
>         for (i =3D 0; i < msb->zone_count; i++)
>                 msb->free_block_count[i] =3D MS_BLOCKS_IN_ZONE;
>
> msb->block_count is a card value. msb_read_boot_blocks() reads
> number_of_blocks from the card boot page and byte swaps it.
> free_block_count is a fixed int[MS_MAX_ZONES]. MS_MAX_ZONES is 16, so the
> valid indices are 0 to 15. The init loop above indexes it by zone_count.
> msb_mark_block_used() and msb_mark_block_unused() index it by
> pba / MS_BLOCKS_IN_ZONE, for pba up to block_count - 1. A card may report
> up to 65535 blocks. A block_count above 8192 (MS_MAX_ZONES *
> MS_BLOCKS_IN_ZONE) lets the pba index reach 16. That writes past
> free_block_count[] and corrupts struct msb_data. A larger count runs the
> init loop past the end too.
>
> A real Memory Stick has at most 16 zones. So it has at most 8192 blocks.
> msb_ftl_initialize() now rejects a card that reports more than
> MS_MAX_ZONES * MS_BLOCKS_IN_ZONE blocks.
>
> Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> I do not have the hardware. I showed the overflow with a small harness.
> The harness replays the store loop into free_block_count[].
>
>  drivers/memstick/core/ms_block.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_=
block.c
> index a01fe31355..ce33907bfc 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -1338,6 +1338,10 @@ static int msb_ftl_initialize(struct msb_data *msb=
)
>                 return 0;
>
>         msb->zone_count =3D msb->block_count / MS_BLOCKS_IN_ZONE;
> +       if (msb->block_count > MS_MAX_ZONES * MS_BLOCKS_IN_ZONE) {
> +               pr_err("Too many blocks: %d\n", msb->block_count);
> +               return -EINVAL;
> +       }
>         msb->logical_block_count =3D msb->zone_count * 496 - 2;
>
>         msb->used_blocks_bitmap =3D bitmap_zalloc(msb->block_count, GFP_K=
ERNEL);
> --
> 2.34.1
>
