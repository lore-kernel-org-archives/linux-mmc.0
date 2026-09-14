Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4AE427A04
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789380599; cv=pass; b=JM9zOx5OTDseR6yfJzEm8BJyk2o6OjWDi787JQMom1qELpZ7L753PX4VLHPz3DOj9uXY9CaKU/vQPpQGoeO1FQxAshTvQFI5AkGWDTxuVRCU72akO8GFVxFjjAAAEGp/npMHHixSEviBipTQHvJTxAA/gdE6XsXMBCVAKtG2Nsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789380599; c=relaxed/simple;
	bh=mLR8HWC2b/0Wy+x2ZTaA6P1D5xxx5jsh79ar1aWQ3Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vnn21yLdyfoJhNoB4bOfx7aLNQwZFCl1/6KONnrhDTKPnKIwGiyiIqesDS2ADSczBYgsRMeR+NNjMEqUs8zjHtPitXbwIOBmwU9G54dhTE2GBF1F8VFra771149EVZShEIBHCJLJz6oewyR0yd+L//K+ixaQjKEZxOHq4G5nBug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gbF09EtJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bIhyETW6; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gbF09EtJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bIhyETW6"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E9nYpc3731565
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 10:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gKH7ROPuUK59v0r7yhCVpSHrG/dKZ12LM6etVSNwX3M=; b=gbF09EtJZidV0Skh
	GEVdym8haKwcpqTkbnIzxjHG6CT7lWGolESOqbXGMt9pjuGa23zd04rTXoUTjDlg
	XdeeAEfQNpBwbslcXQj2vB318CpyuTdYMSUj6KfWf2EDcPHuJ8uSJuoiTs3LRs0L
	CV+WCnrV4LTn7o+yg3yY7eo7z9IsqVwg1hH+Nt8l0gq0w1e675qCQj+QxoQlhAKG
	6FOtY0PXCTBP9wZ1cDIogT7hrwXhVpwFGrH1e5zhNTZI9io1Bs1EXKsJeGP2e2E9
	8xYvepfTpZiITbbitCouK3DWH0Amvwpv8yzkvHkW6y6NQpQkfDlYKptCAcUYmIlU
	gS4Pig==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpd1f0eag-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 10:09:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2db3b126c9fso38487535ad.0
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 03:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789380596; cv=none;
        d=google.com; s=arc-20260327;
        b=k1Zg0y6ey+UPY5VOZfZaWXL1o1RSYxw5oXUJc/OAIfSe+ARSDM/gF4sohf1OYYPYaC
         c6IN35+SAPaZYRUzC7adsydqbX5c4MOAnNX3QDPMWKU5Ec+igSIbRfAWjwhL+txlHv/I
         MwSzkhAyyEkPNvwCSdRIx6KVkm93ySdEcw18An3XCOu7V9SrjjTj0qZejW7ksdUDR2T7
         7CCyCZa5jZEsyTGpDsLX4Q30F2UrrUv4MWfWNe9OGNjFzaL8/J/0r27UlvWHa5qYN9AE
         9kc9FKjKVkw4MngTOi10ZvesC8K6dtXn19G5I89pc7MPezSYIdraHw8mwJ288Rx/aBps
         1txQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gKH7ROPuUK59v0r7yhCVpSHrG/dKZ12LM6etVSNwX3M=;
        fh=gZQFYhBDuVJxGJfBLxiO9tDvaIi9TiZDmdq32XRrsJU=;
        b=dKmrpHOg1p8t5ZxBgjsuoOD/kcEbXzVz/WMDnurdD18rTWjKh/Qqq6/L/U1kJ89rHL
         y5e78GPhjy1S+0eP0HkOZrC4qycisBsNnCg1LkEMU8QFdWTR+jk6Na3CUvclCJoJX9uF
         GCpycRyQpco7CDi83gA3KQ4W7XUipQpcaOhto6p4zlINyxE8b2tAZes/5ddsYJc1egvc
         5r/Ckf0pZtz8dT5tY7qChE6lyjs73JfMG+ArS2umsKWHy/kkmJ7IAVbIErefRW0l4PTW
         RxnfeJrfQOl25fDwR0HKd1mNLVJLKaooAamAo0YOPYy3e8poDSmUsEZvKR3vIvbVoZLJ
         XYFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789380596; x=1789985396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gKH7ROPuUK59v0r7yhCVpSHrG/dKZ12LM6etVSNwX3M=;
        b=bIhyETW614wwHSixI7LEanTwtXO3MgTKgpvVSRZFUzIIl/BhDrK+egIGspFu7geHkk
         feGY9HhhdVndDMYyNStlGQ13NhzL2DH0FvJ3SAMuSvjTf3rheOi/Aur2AXuWiv4HKepK
         SQwvXTlsEt3yx6nWJWUzxMB61VJ071AnH6Bab5E6/9ryATeC9JnCX5XaW9Wb7KNDFwH2
         Mr+94JNWjsTjlY3lEDaVNx38UCUe2AQxAr5mHh2WkaERfeulGlxITiStZDfJdLvMvyzG
         2Gi+2/g1mQpZlk8qSvhN3i5eLofPkERqQLnTE4R9LYCeLQ/HKWBgOVtXHVTCDAhEPoCF
         k8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789380596; x=1789985396;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gKH7ROPuUK59v0r7yhCVpSHrG/dKZ12LM6etVSNwX3M=;
        b=bP93VNwzVnkb+MjF4rZjLtOb01usvgsKGMPti0Qd6e4PblEKotY3/dr1Vnk2YisVN5
         3izwF//8rfNMqqKYMUTLRpeD0z02ZXtz0fza7zcgPVHBULSveSwFldnYhxC4nOpH/tFs
         Wn1Mvoqi2ebu9dhUv3fPpUi5PyQuGpFZA8E+ctDufR1pSnLSlhon4Mby1Tc+pbGCuoWt
         eQeiBN2kCbJdG7K5UeE4GBKIWhYuoPqdtx2v643HQIWGmso1c9crXaD0bBTjJqzKErs6
         O5AQDinuNI7f/7VMaNqYrxX0xJEm00RktlyCLckKF/f9Ix5BPqqkwFqSo8gNc11Q5OYk
         zYxw==
X-Forwarded-Encrypted: i=1; AKwUvBy35jIDMmtLdFkK3vIPqEj+REwK/y8NgXeXhWoNDt26UqSVnwm5iOjFu0VLaabDUtw0fZ/T/dY7qEk=@vger.kernel.org
X-Gm-Message-State: AFuF++mtG/LxrZfOdauJ7Z9y2QNvYe+ZIuI9rHFH9xWTjqvwkJfy43cJ
	W9FLxzCsfpFLohfyUlR37XQJZmyjZBaZjgeBRtXHBK8WQ+5LKKxxI0AgNBV/e7Qsf/S/XjFC2hy
	yu3tuPFZQOHUdNInHTWf98QJTPfE0IuD4QIKwcjzB+GIfv50YgWPt4D1fx/3SH6kTwDHf90KbQA
	HKCNlbPD/0kuZOCFm+YFEFnrDgnC+3BN/EnrOVsA==
X-Gm-Gg: AYBFou2uIATGwqBc+UMbEVQzd1s39E8Xx4hETuG3OUahz1oq+fQeH7J7dYLM7qeWXMv
	5EIwCe2M0XQIxo2qTFiw+0/hv4BLKdPzY87vJLcvz2548JhahzvqMtpxC3v9o0rEpQp8MPKn1KW
	aPoZxr1AHqhSAomqn8YOZkCGHatMIf+Pv6YjBQZZdkLWjfSHncLQcK2IxheQ==
X-Received: by 2002:a17:90b:4a45:b0:398:d292:e6d5 with SMTP id 98e67ed59e1d1-39dec10b1f1mr4017763a91.24.1789380596339;
        Mon, 14 Sep 2026 03:09:56 -0700 (PDT)
X-Received: by 2002:a17:90b:4a45:b0:398:d292:e6d5 with SMTP id
 98e67ed59e1d1-39dec10b1f1mr4017716a91.24.1789380595873; Mon, 14 Sep 2026
 03:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1789348091-82037-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1789348091-82037-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 12:09:44 +0200
X-Gm-Features: AcwNN1XK-VSguKpADW8CPP3rxgxt4GXCHjQW6LB0-tABiiJZq0zZLo1W64xCvuk
Message-ID: <CAPx+jO-KrNCnHUF4qWGSUgbpCi6RmSC-Xr2kqEugJRHXReSS6Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: remove unused slot member
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: L87HDVgWrZk3N-yn8gt16M7K1fpAyv5i
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE0NSBTYWx0ZWRfX6c0RYr8gZ/2R
 1Nylw6TVBwjFzehxP286XkROMSLAQrc9NehJoL9alcuVQQXf5UImD8myMLtuRUZ6y633LRoDJFy
 KWJonXgbaE96YvIj0FXvMGQyuYiOrvI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE0NSBTYWx0ZWRfX63HQWIeJ/4GP
 a7nR9MWY/4AViW1dwAp/0gRrW2vj4zNqex6m8LNjOFqfWZPZ38F91YjHBgjpvdTDix4Zvg5iJCp
 lI/XkuDaU3GViAVX0Tx1dQDi42+RFzdYRtaFpSv4BFF0GceDrigkRbntCBgY1P3t1RXOnOu6qHM
 9u59lSvFKxBzXs+LB29LV83ccP6DtLqklQOgied1xbQi+WjVtQH9q4IKlBrt43W+FDmNYCuY/8W
 5Susk3L814cghSOo87cFMMPQFsu3nQ6cfmt/KPdNfYWSOU6qjdKJFs93KGtKN30uqcnh0QzbKW9
 7iuzZ2re48kjL3dninb6WpRRd+dc0F6599pGJ/wyo2tEaB70oYUBw44xCubYYhEJG835xf9FQW2
 nkCwq/cJx4HtB6wrlhDVvP8VH6FdD8kG0lRhWUV9toqO95cXVXfY0ZFmJi6Y4nR+fmnTpSeYHc+
 /754J64TGt8q4dI61CA==
X-Authority-Analysis: v=2.4 cv=XKel2ghE c=1 sm=1 tr=0 ts=6aa7c7f5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=s8YR1HE3AAAA:8 a=r21QlP1MbAmFkkXyapsA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: L87HDVgWrZk3N-yn8gt16M7K1fpAyv5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140145

On Mon, Sep 14, 2026 at 3:08=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>
> struct dw_mci_slot does not exist anymore and nothing ever references
> host->slot; the member is a leftover from the multi-slot design this
> driver was upstreamed with, where the slot struct lived in the same
> header.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/dw_mmc.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 12b88e7..f4695a1 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -216,7 +216,6 @@ struct dw_mci {
>         void                    *priv;
>         struct clk              *biu_clk;
>         struct clk              *ciu_clk;
> -       struct dw_mci_slot      *slot;
>
>         /* FIFO push and pull */
>         int                     fifo_depth;
> --
> 2.7.4
>
