Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1591C4EA38E
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612044; cv=pass; b=FsfN30axj3E5AoDOpmOJyrO6HndeGoco+0B5K1/r/jkPdPZUXxGUwUV3NRztfPRAqbQO44kh1fMLbTECnoJjg2M3kTahDo7zDjOAczVcObT5Ok1DpTu46p15Ubtwmnm4N67Fz9EziGRvr5ikTZwhAZGwBA+ulbPCAEAk43LMtBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612044; c=relaxed/simple;
	bh=O2sFKAuF5fVE5ExBFOL5OtEIQbF/L5JdHgY1Jitui3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWFybpfVBj4/hX2TCdkGqvKjMT9cPqgl9639OXzVHta5fU38r8QipKdh/8SMxvvRANSx803fZpNb5+QG3rm/A6m+sLA7hptf12EWSF9r6nhxog8n4bDT+uqVbrsHf82zStNM5ZH6cvXbEctX06wRRNl/Y1Adbg2OmPvvIdvo0wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o19Zj+Wb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XyXfxTar; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o19Zj+Wb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XyXfxTar"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEeADb1244057
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jnfYONFNsW41daTLG7twN5DndyUQVqOidHbzZNq5TCU=; b=o19Zj+WboEj2hdUE
	d11OpV//dI27/CZdeE5WhWtVeBRlIPaP9AklCVrSatIyXPIbdgAMOHpGme1MV9ck
	QfemR7xpxU8mZMQgyESMyP61U4wjoinL/kqV/Bwn6iyDE8Mg2nbTaUynK2hpMfJq
	tF9CrhTxa8HpV8I8Gr53sQZbcjuLGm0BF4aLcEA9Yl+GdKClq8nU8bk2lA0+pwL1
	O2YGvlypV1p1pBJRVeN5LnW1M74nXlEQsXEfnYcr04xDYR5H5mS4tf1RGieN0OZH
	j/EU2XUyEJ+987dGZ6S/sbKYRN7lf5AIgA7S4jW9wXn95GbzkeONt/dePyr8LQWd
	h+v0Cg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyav4be5k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:13:53 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a0be20102fso2864026a91.0
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 09:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612033; cv=none;
        d=google.com; s=arc-20260327;
        b=miCbrOTwr7fraclJhwyoXFsfJOFHlVyGwpuu3D/opZ7P0MzwPwq1iAIvTgACZ0ilHj
         oDxVAh7WnzU0pGuq0buQMpXwgPSE/d8n6BtoVAdcCzbDnrrvzrr3XJs96fpLWupjzraz
         H+M7LOYLyiSAGnIXFj+dRAX+QZhZeRcxp+7EBs6tT8O4QksNhgq21cDqPHEJQqsY6nfO
         tJJE+5Fo/wln3n2ub1EXA7b2lx1/vsKmkOhNgbMQFhCBPHyASwI1EdTjl6jA2aLGDorM
         iRsA8aBLjHTix3Q99lMC2C+LpzaUDIMlsDCWnqoroKaYfpQt2uxtPz1+Kkv8GTPDRVNF
         C5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jnfYONFNsW41daTLG7twN5DndyUQVqOidHbzZNq5TCU=;
        fh=DeAY3PXf4ETHdnUvNY6JWlIci4LS2Z3brQk8i77vRIY=;
        b=d3RlQAZDyGpxWxTYXWdUHKOiXDZZDxg6xWp7CwZjZXWlXv5ckxMeEoLfqguN0S8ToF
         l/UPUeHddk+/QsDJ0EBQZtjGH9BwHljMlt9o8Jof+QhpuZNG2X5JM73D0kAQYFKB6Zpb
         id45HJqiu048vdHataf0SCN8n3ld5lrHiRcLs6GBk2JfDzCnQ6Pk+jHt4n40Gw/P653s
         fZi+g+DM4KFkQhhbFMqkjH1ho+Dya9n4Sm3Oo6rPW1M3YA/06f3VCypA0VEu1+y8Kzrm
         96FQtkYaIMUITwT1v7moupBbpbkVaNUlXM+0vkVKHb0y9hl2x0k1kmTv2g2Nwrf8fUXX
         AYWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790612033; x=1791216833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jnfYONFNsW41daTLG7twN5DndyUQVqOidHbzZNq5TCU=;
        b=XyXfxTar+O6Ev4D2uWFEfqgfHKRMu40bvMNJOODprTY9b6kiF2JCXODKI8lr1ydDSa
         IN+8H7hbCNyEZD71ZQYlk+gWkfN/qHqX8ONatYo8yvSBPMIR85UDDW+XCtGAK2WYeQYD
         O1G++0Y2XtC//na9t+IcMzcS6svA8eUDV0a2nexCKl2hSSnw+H6SsF6c+61WEafbHSLK
         MhdbqKrrF1N8xS0U5Sfjg9BCY+jV0knha58A5kyIpj52TuIQwSppwFNRW2xkXvJE7mvn
         Yhw0X0FdvF5BeVDWpmXm3PxlziuwQQSnMP+ztU5ZxwW3vyOMA9M4riwwG295uJuCrbSr
         Fceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612033; x=1791216833;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jnfYONFNsW41daTLG7twN5DndyUQVqOidHbzZNq5TCU=;
        b=tQZqXs7V2IjN+ryc0Ac8r9vyrtfQW+1RpnlVl8JlHK7aFZKRSNfupYqIIf1GA+8Nbb
         3KWqzfDeFwQPvmuNeNqp8AWElXNFI/b98nCozysLIwaJRlJERMs5BvMz+yJGg3M6jngT
         YCwkH8ubLfPlDvy6/IAZlaMchYbujRN7KAaHxFsGMRMWAU2fes3PbkyDfIRm+4XPmi7d
         6QVFjrlQC8eSogIl8E7r4pCxU36rywGNfr1NgLOi1pqtKzCGN+wswv298kmgPAw1gRjH
         yejr8u9w7A94lW/hcFYTpJP/TOjMDX43hhgUlasZ/DyUAbdlwtU1ppEisRB/1vpFoiKp
         w3Wg==
X-Forwarded-Encrypted: i=1; AKwUvBys7KFthPDEtGL9n8wTPHH9a2T27zZBF1mFF0FIRpLb921Y6YLWuwti1GrWfgwQyzS1AuhDQ7Ww44c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvOrUvwjlhR6D3KDX3bMrGr34tUhRICzYeCBOZ/weX90GR+qYn
	a2oksYc+ZSfMNFs5Am4pOqqM6P6ELc2TcKzCTuaRUPFXi6YUJOoQY8Y2IzaJglb68UXJNEP9GIN
	VbaJ8kdeK3uq1p9wnHSHmIFAwWQ5Z6d1diEZnlM6ZjI2bEOYVgWR2prnGKqnTq9S3xfgFem+8a/
	qV45ITY3P6OklcS5EAbp6HR7A5c4AOkQOkdrl76A==
X-Gm-Gg: AYBFou0xekt05Rfq/HvfSGV0voJvkE6gfWF/ktU9KhG2IcpyDeCRdMbRNUZ93p58bRG
	3JdJEOe5XWbj1oVLUJ6cwwR/Xp3zIebIw21u093WZmHw2mRKiuTjkDrmnsOMOivOk6ncGBhaoJy
	TboL9pU62g4hzo/usgNl9NmKgG4nw/57DHoAqK2/It+a6/LDjIId5c0AR+aA==
X-Received: by 2002:a17:90b:3901:b0:3a0:80d1:28c7 with SMTP id 98e67ed59e1d1-3a098d508f7mr11230397a91.62.1790612032589;
        Mon, 28 Sep 2026 09:13:52 -0700 (PDT)
X-Received: by 2002:a17:90b:3901:b0:3a0:80d1:28c7 with SMTP id
 98e67ed59e1d1-3a098d508f7mr11230361a91.62.1790612031984; Mon, 28 Sep 2026
 09:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915161310.2477406-1-lgs201920130244@gmail.com>
In-Reply-To: <20260915161310.2477406-1-lgs201920130244@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:13:40 +0200
X-Gm-Features: AclHuK_-RQJmDvLec1TfEk7xn7z5cIpkgIWKnhqPUSU3rlslCjBnluxRdv8jcNw
Message-ID: <CAPx+jO9GY+35DSuRB1jTa7C4SQuAaoZTtJirFfykrDM-7bAmeA@mail.gmail.com>
Subject: Re: [PATCH] mmc: cavium: destroy slot platform devices on remove
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Robert Richter <rric@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Jan Glauber <jan.glauber@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 4Om46WEXw80cAvV0i8QGpTPwDhFLptC0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX7iuohGNHDOZl
 0Gl5CI0/ZEiWRHZTZkClR/WtQ3f1iHYKGyx4NtAiVZepIN5fTZiOEb+oLYCiczN8y2f7VIdOGv/
 O1SwKJySIBb5h/175bvAVppCLJeoDv9tFvZG15H6MLgPeKZu7BvP5V91gm9dr0xAN0m35y+QIOP
 SOyCiQs4LK1ckzS2bbLJGSNdO0g7fFR3QOK2UpcSEigTWah8kUPdWoW8VMauwLQOlLbV/VXH6Qw
 Ut38SQ5hD59h5VJ+5uwN//yC3grQEIFNxsTQGmWfVTFv+IaYSrIxDzGpefyRl6zzCCZSVsvs8+F
 AFn2CeRcuZKpKrKgYA7cxw+3/wQGKIzuko45E9HtSkCaOgW3Ylckk3E+5rrNIrxunNMQUv6krXF
 K2Eko4lzo/zHab0AIy0Ldd5xxtuL1WLIFvB85VlPeP/4Gxcvya2SfVM2wYZKu6Kpmz0AH9mAGoK
 D7SjTzEo+ui9Csq2TrA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX4HZ0vlMCgonA
 28uZLJpohTXSP7DueAbxLav/c9HIUa40uLGtupOVcMrMATbE62k3QD+7yVyUWWbXFb4/abmOCP6
 GKUi6v2tWoMQCktd5Gu/Vm2jObuLCds=
X-Proofpoint-ORIG-GUID: 4Om46WEXw80cAvV0i8QGpTPwDhFLptC0
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aba9241 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=OJTvEzr-pr90GyvokQgA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280064

On Tue, Sep 15, 2026 at 6:29=E2=80=AFPM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> thunder_mmc_probe() creates host->slot_pdev[i] with
> of_platform_device_create(), while thunder_mmc_remove() does not destroy
> the child platform devices.
>
> The probe failure path removes each MMC slot and destroys its associated
> platform device, but the normal remove path only removes the MMC slot.
> As a result, the child platform devices remain registered after the
> ThunderX MMC controller is removed.
>
> Destroy each slot platform device during removal after cleaning up the
> corresponding MMC slot, matching the probe failure cleanup path. Keep an
> extra device reference around of_platform_device_destroy() as done in
> the existing error path.
>
> This issue was found by manual code inspection.
>
> Fixes: 166bac38c3c56 ("mmc: cavium: Add MMC PCI driver for ThunderX SOCs"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Applied for fixes, though by dropping the redundant calls to
get|put_device(), thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium-thunderx.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium=
-thunderx.c
> index 84ff6d82ae3c..c80907aaf51b 100644
> --- a/drivers/mmc/host/cavium-thunderx.c
> +++ b/drivers/mmc/host/cavium-thunderx.c
> @@ -173,9 +173,15 @@ static void thunder_mmc_remove(struct pci_dev *pdev)
>         u64 dma_cfg;
>         int i;
>
> -       for (i =3D 0; i < CAVIUM_MAX_MMC; i++)
> +       for (i =3D 0; i < CAVIUM_MAX_MMC; i++) {
>                 if (host->slot[i])
>                         cvm_mmc_of_slot_remove(host->slot[i]);
> +               if (host->slot_pdev[i]) {
> +                       get_device(&host->slot_pdev[i]->dev);
> +                       of_platform_device_destroy(&host->slot_pdev[i]->d=
ev, NULL);
> +                       put_device(&host->slot_pdev[i]->dev);
> +               }
> +       }
>
>         dma_cfg =3D readq(host->dma_base + MIO_EMM_DMA_CFG(host));
>         dma_cfg &=3D ~MIO_EMM_DMA_CFG_EN;
> --
> 2.43.0
>
