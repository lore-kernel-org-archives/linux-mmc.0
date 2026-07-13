Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201B33E6DDD
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941957; cv=pass; b=dnGpROrvcKNgcKlZssT+R6EtL+P1t9fj96HL8eYDpbxfp9Z8IGFrGT/NsykOfQWXjcAug+Oq7Ftz+wq019PwBtm3lFO4LW7sL4hFjP3csMWhVZUzaRExy7qEDDF8FHlpNWDYN4BshSVKu5AWKracuZskrWxasS+jWrgf1IWzNG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941957; c=relaxed/simple;
	bh=7uBLgf3g5dypGPbm7e07f6iqZZKwNruvoJWQBcrBNWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+I71O7/j5lxT64Kcdz1dpGgz616iXP7+gL+Yr1WT8fJyavnTDBQFE6ZJ0hwRfpHO4uRp8bBCNTmRR55BcCZ5ClSSztwH09S36hTY5YMTmm+Z6a3/SjT3J6q1fqJhRymb3EQI4JmsXKo7eM0/OoPjiCnn8NupXTSx36KdEHTxvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K+pO9+5Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fe0HaLVe; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K+pO9+5Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fe0HaLVe"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D7YpjP794362
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 11:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a1lDgNCsN2hhoPpGaxW4zpMrMpCRav/Xy/6jiKr+gN0=; b=K+pO9+5YDiOfH7g1
	XhvyWU2Q3G5mYMZXsAfMkXeSnH6IovWI6wm+N2vqK86M2P6UBCH5Rb35VBIq4n+k
	5vTWq2P5fVZ+/7FGaWWakkK2RX9lXtOHYTMubWbjM6Pz2sgTrf7nBUs6tE5QH+4T
	yz7yzc1fc775XAt1YRF0arn28D1R0sYjJI3c3L3xful65xYpnPxK+LgdUGHWW1/H
	D7PQkzM7/Hs+aQ1tfD4TUH7iyd6DDaP0iD63InCehZONZ4O5B53GjTJ8Wlu6HtGJ
	VyXIPcqZByoQno940tTC1WjqChmib9G4SUAm3pUjkoezksZh6c/l8Uxl2tXXk7CA
	8DEefQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcurn0t6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 11:25:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1d137a68so70973351cf.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 04:25:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783941954; cv=none;
        d=google.com; s=arc-20260327;
        b=Co9+4YL+UGkwmhnnpXnfCPoEUJRl+B5//YK9VqBK47mY1KReOnjVahysCDLVse2rCI
         GYtTmA9F1OZtcJiAUBbq0fRTrZ6DH+lJNw6oh+tSJER6lGz+jMX9MUpOwX/AV/gnVv6b
         /tRqhiGPdm/3khiQ/yfyyvl7TjLtTMaNrfbzQ8K9cKQKhYTsXhjagtcdbI7mZ/VWJnjR
         PZ9X46dasQQaLbVwx5hpRFpIqVRJnQxk92Vg5FdNbLwRByYAJijVRI3/O9OCT1bpKIrN
         vDQS95Q+VCFyPeF/fW7ryeQTv1Pel93GJ5hOx/IuYw5m0bziG7TnjCV7h2HAmyCXiq0R
         0ekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a1lDgNCsN2hhoPpGaxW4zpMrMpCRav/Xy/6jiKr+gN0=;
        fh=YJul34vPRzNbis/iTxO0iXVGRZ8DtP+t6wLxH/NVf/4=;
        b=F2vX5JFk8RDzJWgvmgaClw2uX1JX/kDeN6QBSe3CavCcZ7s3QWPjVn0ywyYa+69v1V
         NB0lHv2DOOEfc798+tD7wnJcmkAFAvhouOrJr5ACtoGkxFWbSSjJwpWZdiLkX1MdEnJY
         qAxmM3rUwk6IFhB+mpltKHa2yKYCT6XfAz/QajPGkKLE0iDltgtVTict8WxjE/5Rg8tu
         7NFmzzkBjdXD9Yp/Pj+lR8KkR+bJQZOSqiTpkMFy98PGyN+LJlSxQpEkQQX3f4Nw1+n+
         3efOw7UjRjHmT166UC+eVZJg6kr5qYvImhOkGxGZ+vk/enz/G1fGH9PdSdJxgd1Rd8xo
         tPUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783941954; x=1784546754; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a1lDgNCsN2hhoPpGaxW4zpMrMpCRav/Xy/6jiKr+gN0=;
        b=Fe0HaLVehfMn/KgomFXa5BySwHn+bLIf4qgxp/hN4MrDLwSqHVL7vQRhb50BA/O/m8
         bTIxF1k3zNujxJKoBLsITHDGsUIPJB7BUrvxZtMkJcXrk8pD5IdwjgyCUVhaVBOsOo/N
         GcFQJtert7LN4HuIB8tf15m0FsfoGgNH8NQYeWHXOc2yAaLldtDyroTWdua2PLTGpFlb
         dXibOUDqK77qxI9llPV5tiEtVEJD914izWx4Vyr5kvjyhTgpwrsY7mgZTzxbWP1OVp6W
         Qvtm4+kXm5Or2HzYwKwDfhUGMYK9X0ATi/ub0z+3e1M+/bNdC+JlrX+gXFNq2Bt2bfAd
         kP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783941954; x=1784546754;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a1lDgNCsN2hhoPpGaxW4zpMrMpCRav/Xy/6jiKr+gN0=;
        b=gg9Mg0pGVYpKghu0cDvYKHRh9Zz9ARXYgc9Jj4dZPLFhgAibSn6z7nk6t8BOqH2FcS
         iwljrTm/y3M9JhvNNpvOHjbpAehBZ4Uku1j1JdevfvbWb3haVgz5cViZdIF/RLNhDXqf
         +g2UHis4lZx3qVGdNIR+R1zhabMGS/nYnLG9R/u30iO4cp2DPhEf4cgsfmIzuRXKJQGh
         pkWR30WfV0cADpF5teQjxcg9mOtUoJZ5nVJGx7c0f3JVneRbXJsn4VW05amgPSLxIlvG
         YcKwVYgQuKvOfkQ/EiNzYNpLoRiE7t3h61Swvph0Z+ddiZrJivEKGe61tId4HKno/aEd
         JNoQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp/7pQx1D8RPEjxBWYeJOSyFnh+MmlSZNSrVEy5yhkQUyYsaWXgyLN/7o0btUprKYkeGtBWFxCHK0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4nqwv64lQ+U1o4ntjdqyUHdRiBd3Jukq5wBUcKTnnAx/VrQQq
	EdXNjtvf3x88M1zq7vR6tDhiZMnR7DxX5bbWRjCdrtqJS/CZJSG5yNRpHEyaqSUPvIAG0iJkOSg
	IXUohh4fnLFp4mbzgx5fzSt98i5SwrB6RRy4VrvuiksxxriWkuDiUIH1FKLp5yZanhU818FNyKY
	jxPZAl+uZnBa7GlBoQ0D6cwZiKlVloACK6FB8OQw==
X-Gm-Gg: AfdE7cnCBIz9SLCY4SC6J1SQFSlBx5KwJarFnk2P62te2ltGgqBkiYVppLSnV/N7GSq
	1CvnQq6JeKYLhEFPJkrJv2RQJH0GDHaAbaKHifS/uXDHbKaKGpUhqr5yhkqlB3ohEG3p75w6sO2
	LUbVfJjkNiyiV8m3mkBBHEuUPrCYJMm2BIaBJtWfGE83S8TKWkFceZ3szk8sPULGlsA/Vf
X-Received: by 2002:ac8:5ad2:0:b0:51b:f549:c70a with SMTP id d75a77b69052e-51cbf147133mr84546081cf.23.1783941954465;
        Mon, 13 Jul 2026 04:25:54 -0700 (PDT)
X-Received: by 2002:ac8:5ad2:0:b0:51b:f549:c70a with SMTP id
 d75a77b69052e-51cbf147133mr84545651cf.23.1783941953827; Mon, 13 Jul 2026
 04:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706073913.538598-1-john.g.garry@oracle.com>
In-Reply-To: <20260706073913.538598-1-john.g.garry@oracle.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:25:43 +0200
X-Gm-Features: AUfX_mxMKTBnJD6By66XJz4youAjOX3hpSTz_bSHHNvLaMXfLHxYbeHr9wkg0Cs
Message-ID: <CAPx+jO8KJLdpb-H_MGzbOuQA-4mMi0r03Ba-EvLCfG8Q0sk5tA@mail.gmail.com>
Subject: Re: [PATCH] mmc: bcm2835: DMA mapping improvements
To: John Garry <john.g.garry@oracle.com>
Cc: ulfh@kernel.org, florian.fainelli@broadcom.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mmc@vger.kernel.org, hch@lst.de, robin.murphy@arm.com,
        martin.petersen@oracle.com, linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 7kW46U5B-0tQyZNSYRoocWGCBEztzCeR
X-Authority-Analysis: v=2.4 cv=IcK3n2qa c=1 sm=1 tr=0 ts=6a54cb43 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=D4_rPzn252ThDp_tSLAA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExOSBTYWx0ZWRfX7GNc+3Dm48Nl
 njy8+/fxLOLwmgI34JxAMdYu4W+fv7/+Kti9uDA8y03pTg7iNVZ1p0lLWAEsUYD2h9OJbnEmNsi
 uAx8izZwOKicJ6qzHKFZOFIBol3EkEU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExOSBTYWx0ZWRfX43QYBDxs0+6Q
 +e0y1EvzUn/fdJlU5e8W4oZVaK2YHDy616U5D/wUZxSj7xwp1Yn0iXrbxOn6PBzWCaa2oIwbzYl
 mzZLStxGUtGysR8UhYan0Fkr/8ZQDmOW4ygMLSYdskhz+z6EigFf2nc/+307lezT5E10FuHS9Ge
 30dnPwAGEOraD1E/hzwJ4n6urRmlF1TvckQRShNFpbuTKExL8CNZG6+i4e8h+X5uUEXHCbDW6YK
 8fvQN35ZEfgM1e/ljNqOHMi5sDO9/TYrWvkpj2weTpy4Jcpl1xFzL8L9cxxgJ8opI3VTO3iPov7
 fEWZMLsd/HfdXi6iNEXgj/4cazGtwOv8jr0STstVKOqvnvu025P78SdRBpXgKFRu59XA6eciLHj
 vkS1LT9Q+xDtAY1C2xXmFb/VZIzCCopvrIsDFxdszfV8xdacogGMHtvcOtb8KaFCmkZc3J9G5Gf
 6zLTeBDhrlXlM/JIoyA==
X-Proofpoint-GUID: 7kW46U5B-0tQyZNSYRoocWGCBEztzCeR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130119

On Mon, Jul 6, 2026 at 9:40=E2=80=AFAM John Garry <john.g.garry@oracle.com>=
 wrote:
>
> As pointed out by sashiko bot in [0], recent proposed changes to
> dma_max_mapping_size() may affect the driver.
>
> While the issue reported may be a false positive, Robin pointed out some
> other DMA-related issues in the driver which are addressed here:
> - the DMA max mapping size is irrelevant for the programmed IO mode of
>   operation
> - we should not call dma_max_mapping_size() on the MMC host platform
>   device, but rather the DMA engine device
>
> In addition, it's better to use the device returned from
> dmaengine_get_dma_device() for dma_umap_sg() and dma_unmap_sg(), and not
> reference the DMA channel device directly.
>
> [0] https://lore.kernel.org/linux-scsi/d82926fe-4557-401d-ae58-4302fef565=
7c@oracle.com/#t
>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Compile tested only. And I doubt that this change needs to be merged
> prior to [0], above.
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index ee63835b3ca0a..a13bb39e53066 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -188,7 +188,7 @@ struct bcm2835_host {
>         u32                     drain_words;
>         struct page             *drain_page;
>         u32                     drain_offset;
> -       bool                    use_dma;
> +       struct device           *dma_dev;
>  };
>
>  static void bcm2835_dumpcmd(struct bcm2835_host *host, struct mmc_comman=
d *cmd,
> @@ -494,8 +494,7 @@ void bcm2835_prepare_dma(struct bcm2835_host *host, s=
truct mmc_data *data)
>                                      &host->dma_cfg_rx :
>                                      &host->dma_cfg_tx);
>
> -       sg_len =3D dma_map_sg(dma_chan->device->dev, data->sg, data->sg_l=
en,
> -                           dir_data);
> +       sg_len =3D dma_map_sg(host->dma_dev, data->sg, data->sg_len, dir_=
data);
>         if (!sg_len)
>                 return;
>
> @@ -503,8 +502,7 @@ void bcm2835_prepare_dma(struct bcm2835_host *host, s=
truct mmc_data *data)
>                                        DMA_PREP_INTERRUPT | DMA_CTRL_ACK)=
;
>
>         if (!desc) {
> -               dma_unmap_sg(dma_chan->device->dev, data->sg, data->sg_le=
n,
> -                            dir_data);
> +               dma_unmap_sg(host->dma_dev, data->sg, data->sg_len, dir_d=
ata);
>                 return;
>         }
>
> @@ -1201,7 +1199,7 @@ static void bcm2835_request(struct mmc_host *mmc, s=
truct mmc_request *mrq)
>                 return;
>         }
>
> -       if (host->use_dma && mrq->data && (mrq->data->blocks > PIO_THRESH=
OLD))
> +       if (host->dma_dev && mrq->data && (mrq->data->blocks > PIO_THRESH=
OLD))
>                 bcm2835_prepare_dma(host, mrq->data);
>
>         host->use_sbc =3D !!mrq->sbc && host->mrq->data &&
> @@ -1281,10 +1279,8 @@ static int bcm2835_add_host(struct bcm2835_host *h=
ost)
>
>         if (!host->dma_chan_rxtx) {
>                 dev_warn(dev, "unable to initialise DMA channel. Falling =
back to PIO\n");
> -               host->use_dma =3D false;
> +               host->dma_dev =3D NULL;
>         } else {
> -               host->use_dma =3D true;
> -
>                 host->dma_cfg_tx.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_=
BYTES;
>                 host->dma_cfg_tx.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_=
BYTES;
>                 host->dma_cfg_tx.direction =3D DMA_MEM_TO_DEV;
> @@ -1300,12 +1296,18 @@ static int bcm2835_add_host(struct bcm2835_host *=
host)
>                 if (dmaengine_slave_config(host->dma_chan_rxtx,
>                                            &host->dma_cfg_tx) !=3D 0 ||
>                     dmaengine_slave_config(host->dma_chan_rxtx,
> -                                          &host->dma_cfg_rx) !=3D 0)
> -                       host->use_dma =3D false;
> +                                          &host->dma_cfg_rx) !=3D 0) {
> +                       host->dma_dev =3D
> +                               dmaengine_get_dma_device(host->dma_chan_r=
xtx);
> +               }
>         }
>
>         mmc->max_segs =3D 128;
> -       mmc->max_req_size =3D min_t(size_t, 524288, dma_max_mapping_size(=
dev));
> +       mmc->max_req_size =3D 524288;
> +       if (host->dma_dev) {
> +               mmc->max_req_size =3D min_t(size_t, mmc->max_req_size,
> +                               dma_max_mapping_size(host->dma_dev));
> +       }
>         mmc->max_seg_size =3D mmc->max_req_size;
>         mmc->max_blk_size =3D 1024;
>         mmc->max_blk_count =3D  65535;
> @@ -1336,10 +1338,10 @@ static int bcm2835_add_host(struct bcm2835_host *=
host)
>         }
>
>         pio_limit_string[0] =3D '\0';
> -       if (host->use_dma && (PIO_THRESHOLD > 0))
> +       if (host->dma_dev && (PIO_THRESHOLD > 0))
>                 sprintf(pio_limit_string, " (>%d)", PIO_THRESHOLD);
>         dev_info(dev, "loaded - DMA %s%s\n",
> -                host->use_dma ? "enabled" : "disabled", pio_limit_string=
);
> +                host->dma_dev ? "enabled" : "disabled", pio_limit_string=
);
>
>         return 0;
>  }
> --
> 2.43.7
>
