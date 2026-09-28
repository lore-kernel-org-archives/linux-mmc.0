Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F124E36D0
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612031; cv=pass; b=izYl4HlE0YwStInMspnytRIZRU/pP+KeHFyRzFj/omGXUstVOZ99oEcUWhwxKPFQcm0Z2emFGuZy87chOtO6BDu2nV7+Z2KQJK/2ja9fmP94Vz9usnZzZxBgp1miDtVi3LhB5fX7aJoNa9Mzluho0rYBNiiDo8DA0hONJ+zdPMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612031; c=relaxed/simple;
	bh=C2R1jzLyRMLNPTcwZKMSBnFNoKFMwMYrYL44Nwq9JSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBxt+ohrKNv3jyBqgYpGcHeN4yhSVK0XncEqfyOD4Si8VlS3/NFPnElwjKGfmflP/rVpqOWi/6hZoeKZXyCFId/59yf6DmKoRitOHGefCKN7t3sn5mL3LLGATvaSFirwvX38HDcImEtyzTunlvN4Ljuxo+EHRNo9MKKJpNOdhNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RrMxEnQZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gm772tgt; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RrMxEnQZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gm772tgt"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEe1lq2143082
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KC/lCZJ7qlaSJwHrLxlOH5edVvtPTLCFOdsNX7ze6Ac=; b=RrMxEnQZYFTlNz0D
	bc+sNQNzBMjkfgEjq3T7iOJr9bGHBXN70z/6LPSW51N5yVqX7WVSPDQbT1dByWPQ
	MqVBIcSqpsrTG3In+0+Z7xTvj/RxEFfK9W30ETjPTvshMESN3m4YnIcCVhVI/La1
	FgJn1umNj0XxpJFJt8gWnNUWgkWOCCf5VadtjWwkOtHtMwGLBwRgLsLq01KLsTSp
	LD488CC0M3Mf5LEpCbKyzaEmsxFpLSb/1+/aao9iBb9g6HsC32Q7ciBsvCqmenJ9
	XzqjkmqhvSOfPXewETDcctg55dhDh/5dR15dPiBmGNP3cCVhFR0UHVUmWEkcnX9c
	NwviwA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynfksm2p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:13:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso3419476a91.2
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 09:13:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612024; cv=none;
        d=google.com; s=arc-20260327;
        b=QvAqKFeJbsFtNr3vy14UxT27OJf+HYofGd9kJpLAM6ZIUpUFFrRzYW0AreHcKzNxcu
         VJPJbzDx1D4mOnusv40j2dhEvTERrTQJPzTnTVke5quIcEdRZDy9RTf5lD3luyR80nH3
         V2qsXlzor0wIbtWJbG51Oa1/YO1UTRNuK9NHomtI4iTkJ62Pod6LW3mdEIBjVn92QSPC
         YIApZrQ/0cRkpk+e7E4aRa9QiEd0yr34x0hOyZTbZHUqDv76LzjBkavaFUVuo03RWjhx
         ykBZzRKwu5JKg4pN9y1qvpJz8KGHGbYTbVUnJkkLQiLIYNEOe/d5OGB++BW0sCafQ+Sy
         aXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KC/lCZJ7qlaSJwHrLxlOH5edVvtPTLCFOdsNX7ze6Ac=;
        fh=cU05L5snKowgYAGk3DZiZPypnG83CGsBWpb05boVnZ4=;
        b=LNKaEuEooX+/yQY+AuX5KE4Rfgg+fAD9JWgoHwMtB7UVlhk9evNtcOe63oe5+TGncy
         rmS3BZka5W6mnAIjNyEokGRwD6p0RqU1psmacFOhlOhxriQJh7Enc8pOG9VU30ozIpZG
         Oif1SLTUMZ0lXGWSuizCnKfBEhsWtBzsWQy+TVPlxLIMTRi6BwtqogIvlBbAnnCliz8S
         v4ybiEMAgBLTraxzRA1+FNrIvEn7EZnuDSaV8YBK26rYR/VMjaA/B5RjuMo1TisDqtiL
         Oi/WVD73mtlHkv86y6GIsLhi/iUgVn/16M39TOp20cPH1NY9bmHKmSXbVPfhPbhPMNKP
         N6UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790612024; x=1791216824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KC/lCZJ7qlaSJwHrLxlOH5edVvtPTLCFOdsNX7ze6Ac=;
        b=Gm772tgtPTlEGsbHoFf1v3dN71CN9hgGIlxArfmoIyiGOd0ibPOaxKIzLMs0hbCQCS
         CEqtiUg0IL1Rbuz/vcB0PrQMYZ4qcRZRe/MXk2qYYkZO5aaq/2k1Vq6SW0psx/kdXVoR
         TLpLdShg62NXa0jG7TMP1sepoblbxQ4tPMpzp5HWlbS2tXkU8WdDGCD1axw30y+APtup
         RmsX09Pk3LNUSt6HOTuiNdRZbflLno2Zd10vwbZCmqV/n+GJUzxHj4VX4Gyt8VmNfexa
         I3e0VTQrh9wWo5pMi3wZJpC+nUu2yttkPqp334LoNmuGiicXrXIJCEawT4pGozvdt6+F
         B0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612024; x=1791216824;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KC/lCZJ7qlaSJwHrLxlOH5edVvtPTLCFOdsNX7ze6Ac=;
        b=E+qgima710JZsAxqKxdzRmscFMBpZYByuy7YjGBNnJi5mEhjt3HqVtSaa3NbvZO4MW
         8htE23YnLOk2bgKd3+GpZ+9yDZu6n5XXBR2Q2VAgX2h+fq0WP5MpbqlzZ9jMIQyH/bjq
         C3dsDUgJdSOUu56THP6ebisV3qmCPJGS9Dy3f5IvIxOnygUj5mVs+YyTGoreRJKzFgR7
         xYrOorK2BVBh+PlecTJc18wsbyvkW6aZfPwRHiYHRFl8ZRJXP/mF3E+IpH0qudHLd+Sa
         CPR4/dBn+CJfxsbgHq5g7YvJleK3yN5Z5aWZbOT9H4SejXHuPTYbKt9NS7tS1LIz1SYe
         q/5g==
X-Forwarded-Encrypted: i=1; AKwUvBw0f7pAsx3evFSHTCHglxzruQ0LkMe8l11BBsklDXMJ2k8kM7ufaF8e/CZTdGwe72RubZchrYkENtU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIstdnmq/twns+6OeTGaSUrQahD0QLoxo0j4B94pj/qgy8YUSgq
	yo9SzLwLqbHh+AmD94Ct8hfMU8JbAX4FD7O7iwN09qdGeBF98ZazfhozjpMyGq3HpTzspkRzt0b
	OGcqj/qrWN0M8X9rZoaGOGhXWlS2ldgfk52eL6CWeky+t/wgXZR8ROAuQ9s2Sq6p9haWaLxA9AO
	WruDslZE0xAdf3GV69p7BiRSTqGrjJTxjxoPmItA==
X-Gm-Gg: AYBFou1mYwz5j3oP5An8nOr1zFgwyQZ2kYdmWYLrTCTbi/aBxSZR/v9uKStq+OJw7tS
	1wXNa0Oc7rORsrSKcpTY/VGe3H5nyXJUg53LnnKvAAMGB8qjKsEfVji3w0vAVAhpFMeM0jTRuUh
	KQD649EPtrUGGULZr0UG6mnuOiJC04QRrGZvxKp/Nttb1QzuYPY0nOb3Q2cg==
X-Received: by 2002:a17:90b:540b:b0:3a0:4384:adf6 with SMTP id 98e67ed59e1d1-3a09855cfa2mr10341124a91.0.1790612023409;
        Mon, 28 Sep 2026 09:13:43 -0700 (PDT)
X-Received: by 2002:a17:90b:540b:b0:3a0:4384:adf6 with SMTP id
 98e67ed59e1d1-3a09855cfa2mr10341096a91.0.1790612022801; Mon, 28 Sep 2026
 09:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150317.2444609-1-lgs201920130244@gmail.com>
In-Reply-To: <20260915150317.2444609-1-lgs201920130244@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:13:30 +0200
X-Gm-Features: AclHuK-X-BDgOMZUiT1godE1FfZ_R9GlZELj2HSpr6Kis3LC70X210-2yVnsAno
Message-ID: <CAPx+jO_ikSq=QFwuu20J2ryBigmmk_5QsUzNbp75RUddG0fH8A@mail.gmail.com>
Subject: Re: [PATCH] memstick: ms_block: destroy io_queue workqueue on removal
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulfh@kernel.org>, Kees Cook <kees@kernel.org>,
        Maoyi Xie <maoyixie.tju@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfXwzBRZ5Wqt5E9
 CjizscOEEzIZ2W/tad73z6ACNlWlgYBOQUx1/iHCHc2GZ+HM3nReusBpULJ+d1/2bkJtY85pxk3
 VP522s/V61W3IzsYbxPiSbpJTg+WPmfWn9Hyv82a26idnNMMjXU3ovcONJV7rjUkS7JbHPMWiUl
 r/CVQwCKIwY3V8qRoJu2w2e+tJTKp2/DM/XXFINYPo7RDC1TW66NU4d7v3erOBryaOrxA3PGDEL
 24f3o9bEy/pwe4ZJ7KC/GUaWcIv4UBSyac0BgdSRwrT3wtg/MxYegq7ORmNzFpjvJWFguaKKCLs
 5Vb0GS7D7ytNNsOGxnJRSGx0Xe8MTyJO/aR/6iyfjtzbTOgjOXLgCRsV9YZFIGWi37cxqlmtIO1
 zYJcF/JRCwwZbLMnykTKZC4b2u5biVpjKGbc3ECmDgzO6+wFwlWNzX+qfj1KStpFlPxJnx01mdz
 /rcEPFNAa00iUQIwfgQ==
X-Authority-Analysis: v=2.4 cv=e6aT2qp/ c=1 sm=1 tr=0 ts=6aba9238 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=Plh-MFd_Tk850DHwDTYA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: hPy65IaTB2btCOKLcEI6qdF0zu7hl0Fn
X-Proofpoint-ORIG-GUID: hPy65IaTB2btCOKLcEI6qdF0zu7hl0Fn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX0Cy3G6/I27aX
 5ndLOMKMnAanocQ7+n2gT7ZT+en0JutXQlP+MwcMyZDXO4ZbfVXsQi4EeHfPz0onuzf8tReOE8j
 pMDPD+hNkn7eqfW0xZb13t8dmkgGCqs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280064

On Tue, Sep 15, 2026 at 5:19=E2=80=AFPM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> msb_init_disk() allocates msb->io_queue with alloc_ordered_workqueue(),
> while msb_remove() does not destroy the workqueue.
>
> The probe failure path releases the workqueue with destroy_workqueue(),
> but the normal removal path only flushes it through msb_stop(). Flushing
> a workqueue does not release the workqueue itself, so each card
> insert/remove cycle leaks the workqueue and its worker.
>
> Destroy io_queue during removal after the outstanding work has been
> drained.
>
> Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

I have already queued another fix for this, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/ms_block.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_=
block.c
> index ce33907bfc24..65154e569a9e 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -2204,6 +2204,8 @@ static void msb_remove(struct memstick_dev *card)
>         msb_data_clear(msb);
>         mutex_unlock(&msb_disk_lock);
>
> +       destroy_workqueue(msb->io_queue);
> +
>         put_disk(msb->disk);
>         memstick_set_drvdata(card, NULL);
>  }
> --
> 2.43.0
>
