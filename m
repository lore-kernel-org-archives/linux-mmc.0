Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64243D522C
	for <linux-mmc@vger.kernel.org>; Thu, 16 Jul 2026 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207960; cv=pass; b=oxPCk2e/kd855/U/+FA3SThwMPTuLieMNMrkCkPvgEGcLIByR797IDi32ylcl+QDME9EbEmA9tOpvVrLQnE0a9XTszuCkIqJtc3EE7qFMKYidq3cbp1j9JFINHFLggwrMdoaTW4AO1QvyaYXK69IB8KacHOMXe4dCtEeSe9K0G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207960; c=relaxed/simple;
	bh=4AmOO+7rlx+hHuvnOSyX2KGjLFRqTfMfxKZd2BRafhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aY9dvYUX3cpSE5zrOu5vjqoSqEgw8ChgTNGg7aHKVDNMB9clGScezwDdaHdo1AdM1HPS7LZb1KJyOfg6xtyTRxS4JjrX8kODiKdA4dhzo0I1uG4ProbOzLs15g/AfeGcrc4LkDmCxiXzQ3VTEh+wM6ITCfLXeKTEMZ4CbhsoT6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gRkSNtrY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K/VBiLED; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gRkSNtrY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K/VBiLED"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GCl4Sv2882352
	for <linux-mmc@vger.kernel.org>; Thu, 16 Jul 2026 13:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e2r0ZQVrpmQYd+PGofyii1I1ut1cDt900FipSd0NNhc=; b=gRkSNtrYgbJj7xOg
	6KMzKkxYpg5IVHCbemqnFtev5KWrMf28ahCCDAAAqn1WA/YCVOnZw7ib1Oym/Uea
	trHysU8l2XKMLICINuKgrS+cRbxdOIYat+8KnXOixOOqjlh2EGQgELVDDMdFcCH0
	dlGU9XhRVeMzwt9RV2+r0GmFCgFYHIvX619Fgj3jK7syUmECimicoGIAFWTSBTNf
	SOHK39winweClUt39l2X+CAIejEOa6LSenzXLkQZxChRUKka9V+qrWC+ohcsQRQ/
	T7ttWy6e/aQUMLj6H2u22llktOa0YxuztIsVqyhAJ057ns2bhGFxw/19ynZjxnTe
	tyZPIQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym18431-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 16 Jul 2026 13:19:17 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8fc92c5373bso109192206d6.1
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jul 2026 06:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784207957; cv=none;
        d=google.com; s=arc-20260327;
        b=ppxW+Fme3alYYlj+ZKRS2Vbp6/r0FOJN7Zqc3MlaKV9LS3C2tx6WjJWE1QCdtP5qJR
         YrqYt/YmntpN2U87uN9ckx8CDUG/8CG4G/k+rzOPyxon5+4UEze/b/OrUovjUMq0IyfX
         s0UVrJHjdEiqCQZJ1KYnqzwnxM+pfLLemgbXmLegTz1m1oa+3waYMFna8KoAsgn045gS
         EAUgPjq9okKoYVv4Q+7lnq0EzcYR8aRlm2l7EAuQhEjY9Gw8o6y/lDdgMJ9Yqq5Bfk9j
         Kvh7c77VzkQhX/41FYmSMWjCF16JSQYuy/AToo9Q4HRXwIcTpAi9V8f8c/OyXjFsKAAO
         Rv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e2r0ZQVrpmQYd+PGofyii1I1ut1cDt900FipSd0NNhc=;
        fh=71Lpt6IbkzTCECKidLtab7rHQsONqjhn16Dm55GjPj8=;
        b=XyGsYhd28jfzYDpC4U/ZQKAjyDmOE69XNlz7nxEd8Z4t1Jz3HYOvbajWM51U7xcfp+
         CmSMMCL/lnYfELdrbE6MQ+3c0K02OOz1UksVMcMBQH2r6En3vAHz2lvJnJjWc5V9LJLC
         dbOsEgMK5s4ylwPUo7o/gMPThCdWGr+0XBJeKGlAY2wQdxIkzSRrDij2mIelWMIurgyF
         O6Skq+zoKM/YC7ZxxJa43YqVXcF7h8Dy9dAZ57tkak67qDJEf4UR+5sjs4N2ZKelTAdq
         zMDXBdnKuduJ7/2klASyHpUwpFmIkoDX32ZvbIUjFHPkmn0NThuSqDCLTGo/3JQt1j8+
         BWtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784207957; x=1784812757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e2r0ZQVrpmQYd+PGofyii1I1ut1cDt900FipSd0NNhc=;
        b=K/VBiLEDZsuFngiBfgO+2uQxkQgbc5UHItpzrEb+hx/y61vnunY5sKCTmv+ZPrxKOt
         GWADqWa6Iw4vLIA/Lcf5iicNMzHx0psYPlZF6g1t/Q4Jw/RRbRXtKrZ1llknjmSuh7Tp
         iTNJmTE2vj4SQCcvcjk22R0I8eRGDtGidcmTsctB1HcQe0WuDQjBMD009XoZh0v3ikqZ
         cBh/aYPpigjTbf4YtfZWBGlBZvMbqg2KslsnmOQh1lDBk6YNnv5nszmiz5g+mpWebX6G
         A0pDi12XkxsMXJrLP2O0RM9l4rlSlZiauZFJ2x43esZLBRijtUAb4vrVkMGS5KG2pFr5
         dc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784207957; x=1784812757;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2r0ZQVrpmQYd+PGofyii1I1ut1cDt900FipSd0NNhc=;
        b=A/WKMa+Op1K9NOStaPkP6nf1BGofDDnvavHJfRFjonha50G+HzbVVQ4raR5GaSZIGK
         O6gqgTJbsvoTt++hzUZIqNnTtaNSglxzv9Fw6eKo/T4vALEY5ySHVs3FdoxRryc+3Hhv
         YNdFkDK/OpSHwHiELQAA8BFzrr0vtf0XmdMfA+CajMhmZkeYidhXLc7fHRAFKtTJdBmD
         TvAaSW21v8Kw2E8zTeSEUppo3VvkVq55fcf8m9Y/LSbGhY2M09KehCrwp7eYhh+QGUGU
         wd+5ErRrQy387YROPQ9bWt76NecmmBY662zc8WWImO7evGgEfncRpomepHwVIQeeEUvB
         940Q==
X-Forwarded-Encrypted: i=1; AHgh+RpGsczwp3C7XgksTD4p1fyxiYF/mQ0rkm5KUP+mFA5U1HieleWeibo4ydbgV30ZRwWrc00GvI2q6UY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ISi8BJdZq7lPvCS3oA6F67AetimZokwLPoXKmDB8wsrAyof7
	jtcp4ozsNufFdlcWXlZ4AQ5epB4RMXc9gEdjSzKyZxDvH0/gulEaAyK8E6no5CM1w0plN+T1zDf
	vNLfZYG8Ks7ocrmgMFO1ezkim8h0hkHkcIo3lRqVPmOPUWYZAQBWvByzy0MV1tnXjEKLN8W+aTb
	4x7+wZ806NWnwum4KBD29S1edXaIu+anKV6sLQVA==
X-Gm-Gg: AfdE7cnQ3LnrO0ZpI/iVF/h/ROiqsJNAVnnoIyF64X/0uGzZwhZXaORAXsHB2KC2OrG
	G3IZ1nbSQuzz2Pkc8qG6VBmE3HvBMxrR86Fypvb7belt1aNC09NqGGN/yjhxvrHl6dtBhZWdShV
	YVCk8x6mKPmLw5CwhE4Jbi9d91gp21WdvdxgjHUdVCH3QuDQR5kCOjMgpIoQ==
X-Received: by 2002:a05:6214:428c:b0:8db:5f:c588 with SMTP id 6a1803df08f44-90758cc04efmr95850046d6.3.1784207956687;
        Thu, 16 Jul 2026 06:19:16 -0700 (PDT)
X-Received: by 2002:a05:6214:428c:b0:8db:5f:c588 with SMTP id
 6a1803df08f44-90758cc04efmr95849526d6.3.1784207956218; Thu, 16 Jul 2026
 06:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714084456.3356354-1-john.g.garry@oracle.com>
In-Reply-To: <20260714084456.3356354-1-john.g.garry@oracle.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 15:19:05 +0200
X-Gm-Features: AUfX_mzPdrJGCsG9s-kQ1f-ok162sDoteL7q9rt9naKA1QCMqVu7Bn80L-NJHAo
Message-ID: <CAPx+jO8ZeheZrOk536XbNVnbLu9ue8kZ8KEDMvnioBsQX2D1Sw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: bcm2835: DMA mapping improvements
To: John Garry <john.g.garry@oracle.com>
Cc: ulfh@kernel.org, florian.fainelli@broadcom.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mmc@vger.kernel.org, hch@lst.de, robin.murphy@arm.com,
        martin.petersen@oracle.com, linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a58da55 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=AAfwrZ--nDAgvqgJmSgA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzNiBTYWx0ZWRfXxyf3d3KzJeLR
 6u3IClw9q3PB3xcmG3Pu83QRgNMsYEFgZGffuw35qbWeGhF6BavAG2fQNKAn6QNv1ZiD+X1UeGM
 pVzq+WrwHjSjNrWpvL4i6vze6rprlGN7D5nJJgrmy/Lz3yETuxctqgeqHQ+rn+jyJhUfMsrtTzd
 UwhZ5Uu9rr3kShgzJBlIbREM/hP8A5HjQJSkLtRSMYrdVsQRqaDFfTT4TltaRCcixwZb5fAORxK
 Xlj3pU5PnBz0PDpKrTFPs3uaZdliXwaPwF3IbsdrERB2HAnN5GW4KApVeV704kSAvUjduXgV9rI
 hCkPG6XmUGGBOtF5qxdmf0BIRYb5wGueYiKQxZj+zxt7T5GgkymNvpbjZ6ZWeQMjMpTBAOXbrvh
 tlcLhU0SRyQo1zc3P05+VsqGogYuVhFrIpzV/uCN5nECOJ/s3mJXyODpXHgH6fTOhRblVTWjXJV
 Ub0Y9TMQyLqU0kvA8/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzNiBTYWx0ZWRfXyVepZGK/KqYs
 K8za+fXtDGzWWdWAFhUku/wcDm+FXW0qbWkpr6ITzfCepmnOAiKv4+YQW5Au2NRNnOmirrj6kGZ
 6iDvRYHJ+I5CNwIs3Otclwjbfn2r2W4=
X-Proofpoint-GUID: bXZ5_M2_hXoG6cPRB6QsFsWD_iioN8wp
X-Proofpoint-ORIG-GUID: bXZ5_M2_hXoG6cPRB6QsFsWD_iioN8wp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160136

On Tue, Jul 14, 2026 at 10:45=E2=80=AFAM John Garry <john.g.garry@oracle.co=
m> wrote:
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
> Compile tested only, so HW testing also would be preferred - this HW
> seems to be on rpi1 (which I don't have access to).
>
> Differences to v1:
> - fix logic in bcm2835_add_host() (Robin)
> - stop unnecessarily NULLifying dma_dev
> - use dma_dev pointer in bcm2835_dma_complete_work() -> dma_unmap_sg()
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index ee63835b3ca0a..c949a3eaae794 100644
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
> @@ -1057,7 +1055,7 @@ static void bcm2835_dma_complete_work(struct work_s=
truct *work)
>         data =3D host->data;
>
>         if (host->dma_chan) {
> -               dma_unmap_sg(host->dma_chan->device->dev,
> +               dma_unmap_sg(host->dma_dev,
>                              data->sg, data->sg_len,
>                              host->dma_dir);
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
> @@ -1281,10 +1279,7 @@ static int bcm2835_add_host(struct bcm2835_host *h=
ost)
>
>         if (!host->dma_chan_rxtx) {
>                 dev_warn(dev, "unable to initialise DMA channel. Falling =
back to PIO\n");
> -               host->use_dma =3D false;
>         } else {
> -               host->use_dma =3D true;
> -
>                 host->dma_cfg_tx.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_=
BYTES;
>                 host->dma_cfg_tx.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_=
BYTES;
>                 host->dma_cfg_tx.direction =3D DMA_MEM_TO_DEV;
> @@ -1297,15 +1292,21 @@ static int bcm2835_add_host(struct bcm2835_host *=
host)
>                 host->dma_cfg_rx.src_addr =3D host->phys_addr + SDDATA;
>                 host->dma_cfg_rx.dst_addr =3D 0;
>
> -               if (dmaengine_slave_config(host->dma_chan_rxtx,
> -                                          &host->dma_cfg_tx) !=3D 0 ||
> -                   dmaengine_slave_config(host->dma_chan_rxtx,
> -                                          &host->dma_cfg_rx) !=3D 0)
> -                       host->use_dma =3D false;
> +               if (!dmaengine_slave_config(host->dma_chan_rxtx,
> +                                          &host->dma_cfg_tx) &&
> +                   !dmaengine_slave_config(host->dma_chan_rxtx,
> +                                          &host->dma_cfg_rx)) {
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
> @@ -1336,10 +1337,10 @@ static int bcm2835_add_host(struct bcm2835_host *=
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
