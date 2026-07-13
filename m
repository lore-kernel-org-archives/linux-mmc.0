Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264F4189A1
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948062; cv=pass; b=fdW4E7nyvwHeUKjMY48inXH2RFr6VSEVJcqG9BzDz58C47AQVy/P1Bv3afT7s9wGQl5v/hrQ5PABos/02cOY1DyKr/2h44I5Jnij3wY0x/Tf6qaButJ8dSHKvJeszvtRoUVRNsTq+FqonwTfiu14QhIUhlgGx+1y4hUtnWrnSuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948062; c=relaxed/simple;
	bh=9xyvV67PG1lttljRK1NbyKtFIA0s9cgKOy5yAMScgC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DH/TkYS4fOLkg6eQLRQc3s9x9r5nY+1G6UsKmaUETjtKJ2yGwxM3Vt+nzP7w57TXKpl5+AHMyGjxq03RtclG509032fl3EPh9nLAi7FZIRK4xhY2/yImkbVRXC2lDwpjrZ964jEXNRakBRCm+4a/+MW1U4lVuz62E1zPb7PvzTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e7s8CYAJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GxM7YSlS; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e7s8CYAJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GxM7YSlS"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCDXcj1299294
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 13:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	plF3bHCU+9k7IuKoJKxczRQ1hKZChH5xCwO4eyEXcMM=; b=e7s8CYAJ8ZvCWpzQ
	+eD8q99xqXE82SRO0WEeqZUZh5uUJImH1mU1p8o1gYRazpGK34AR/0cJln1GEnfo
	O7bDB30nM/sQQZnyuDNwzxSHku0sViBQ4ZlcBz1OjIBWTNEvVTulIckXLcRUS/tQ
	pqhSq0/EFelaC+pVUhRgnLvk/D8Idgv1LmSKNr+Rkw9GmpzsB8RRZ7yc6ZpVFAuJ
	kdYdweXCK2UGgoNrlAYPowAP7LMr0Iee0hjKGB7My+NpTkVhepw9OMSdpvnPO7J/
	LIWOOPcCjDre9aRFX8up34xecq7piglVBg+6y2VQEQqOexGKZPQmYH41h+UceTLy
	ypYqSg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk3gr1g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 13:07:40 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f0f45415cfso51480746d6.2
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 06:07:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783948060; cv=none;
        d=google.com; s=arc-20260327;
        b=iXpkykYJX894FZYn+7lMdj9Z3dvRuQQgasVPfVAqOEZZB+wDPqfKapgovdwq5s4CVl
         DpOBj6IWsP9nBy6UpuBZgKX/W0Er5pCAAwYAtdl2QJN+HCmTs/uBerTiejwPBDl8nOmp
         Q32Qxn7pa9fn82VbQp+Wl4wvaBngmJMZyOgfptlk3tuPy6ZAqhH/gPIpqgke/YPHNZJu
         pg2ezyMGX48IUhIOIBldFazCaoIloRsgJjJDa1h0TU5wBU/wAuu6iJwUS8XrAInHg0x9
         Bn6UmHDwbuLwGZID84LI6EJeq0T7lokVfKhuwGcBKt43NxiVbFVf0aGPRL8RSrupNR1E
         jr3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=plF3bHCU+9k7IuKoJKxczRQ1hKZChH5xCwO4eyEXcMM=;
        fh=3BUxvPXi5ulldYjqTloODyxY+zQ3dP9xs1XHmK8lvgg=;
        b=nQgSgamiMgzLbUfsdOBsOQUoQ+A+YSFVH/+zLa3rKmaNLGu6QWAVH40PJl6nVM07tY
         IIarvGETxbEAHqVL2U5d9ET7XToCCbAci9qzESm/jSYJG+1FYRRdybCPdI172fCEcg0o
         BtVI65lzxJZ15+bTTjPg9IPQ5PjGGAB0O1KJO6f/R9hrujA75k9igqIMPWbPidqGWMo6
         BzkyjpimTL3GcZdBcnxjZMPXu9Kji8IFuaB4c2CU8Aq4s9JbOpG9+K4ytLDqPOK6gI0l
         ODXCpOJcWrqI/ZaXA45MnZRkR1XS8dg26zg4zj8ESbJLcOiSnW6/bljBdcx4bHd8uDFT
         /1+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783948060; x=1784552860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=plF3bHCU+9k7IuKoJKxczRQ1hKZChH5xCwO4eyEXcMM=;
        b=GxM7YSlSUCeuPOMyU1zXp9shh52uyQnAG6ZGHe8GdMHT/n/3QGQ4GyXcuddFuoRbWI
         Mw7MOnJtMFGnIwzQuga/rCRlltj6PwhhrJrkFFsyqor/nOF8XqKdbvZ1KpkHJZnwsdZ7
         pnjgBkdEbwG7M00qp+o3QNgypgyyBT8OBBpSHRyWkf6TjFa3crLqXdlUppVBc0bYAXsf
         vxVj8K6E7usSTOVs2/IKQZ+UK5UPfOnWXgCHgSuPd8DQT2VHpX4LVFIllt33NCq51R5Z
         hrHGlk6i+AomSX0wjXFpz009WxGiGSrDXIiDPIVmUP9LTRbYP8p9Gocy/aU1EFH5yKpo
         cgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948060; x=1784552860;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=plF3bHCU+9k7IuKoJKxczRQ1hKZChH5xCwO4eyEXcMM=;
        b=ZyokTqRW7rWcOHoB+5ywO7lfqMnwovmJU/lWwXaEJySNjuysN2KAc8McEQCm26zQr7
         7mMGfATyQbih/PFEio85/Aw24t1cZa5Xf+kRy0b8f34hsKJs/yFRo9cMxnMJTlY5Wrx6
         wOjuq5pyokUAFWIK8ttVp3hVvLhNvbt3J5cKkGNODHJBJApQ6vvVLPWoURRiKc8tbZ1B
         8qjFsWdea8MGfZD27RBpQBjWQHFuNzVIQ9/aEymJTCs4Dx1I7nlX8YFlzCLYW0robh13
         Kpz3Kavot1Q+wizYOOMYeeqaMhDSPRG//JDDqtcyCBMsVv1wSgqqFEP0UI3BAq9bSKV8
         31Rw==
X-Forwarded-Encrypted: i=1; AHgh+Rq3iaXRdn0Rzx811kMxH5r/Re6iPAQM1daT1eIiVGUizbP6qeeklUQwphkjLia0vv06Ej6e7X1RFxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFRl49M6wPzJQiAUYxPUtFeVnEfPUQzNFsKtt/TjVHoTeopAcX
	V7cGerpRVNX48PUXK6EZVgxdL2+ZLEULGc+XleafClG4MGfBzR2ir0AzTA+RT454egSbnkbBWed
	B8MymkCxg+PlP3GLDVbDiZZUWEhB8mR85PN83B9XOiGXZflQlyN7H9ME5zRvTOvXDhQqk9qHDLl
	I0wznVLhE9ChQVjTxw9zWk8ZBFs3Kv7V46NnrsHA==
X-Gm-Gg: AfdE7ckuFeQE2jiNxpJtCjO7ykBMrcSjmohnHyeIlYLMUaf/Bt5crkuu0q4xLiqo1RW
	gT+rwXOSG71JzaMRtAGHpd8ZIw3OJH1UOM+nPXJjzangeLTms47O7Eytsof0LkG5fk36kDsUhX/
	8lwH9tjLCZ0aJ4NIzfP0Iul0E4NXsyGjeIY+WijE2Nn/bZhwbI/PARjdkTpAW+eVxSwQLY
X-Received: by 2002:a05:6214:4a8d:b0:8fd:6df3:b379 with SMTP id 6a1803df08f44-90402c6ae73mr104512056d6.61.1783948059506;
        Mon, 13 Jul 2026 06:07:39 -0700 (PDT)
X-Received: by 2002:a05:6214:4a8d:b0:8fd:6df3:b379 with SMTP id
 6a1803df08f44-90402c6ae73mr104511706d6.61.1783948059119; Mon, 13 Jul 2026
 06:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706073913.538598-1-john.g.garry@oracle.com>
 <CAPx+jO8KJLdpb-H_MGzbOuQA-4mMi0r03Ba-EvLCfG8Q0sk5tA@mail.gmail.com>
 <ba056712-027b-4996-9b15-8f70d630ff2c@arm.com> <2d1de9f0-c351-45cc-8b49-37780ab94106@oracle.com>
In-Reply-To: <2d1de9f0-c351-45cc-8b49-37780ab94106@oracle.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:07:28 +0200
X-Gm-Features: AUfX_myaUnEaO2lbhH-JH4FUDAEd2iHxrLacinmg_NYhhjt7zQwJpMeqvFn71e8
Message-ID: <CAPx+jO9Xv0PSu+kKg_DCtfFKx5ChnJs0C49jFvuCVAyjjW0AsA@mail.gmail.com>
Subject: Re: [PATCH] mmc: bcm2835: DMA mapping improvements
To: John Garry <john.g.garry@oracle.com>, Robin Murphy <robin.murphy@arm.com>
Cc: ulfh@kernel.org, florian.fainelli@broadcom.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mmc@vger.kernel.org, hch@lst.de, martin.petersen@oracle.com,
        linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: pnkd7iDeHd57y1R_GfImCBBrOMEvzwFR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfX+DNvrSoBR3Zh
 rpjPlQ5oAIUXyRTwngUYCXSdj3f9tiWCdkiXeA9OYx0GV+FO9gxXNgBLIpQPSrvLsLzEX22Ld3J
 HP3ssfTcnd4x4adsy4QkTr7PntPOqA8=
X-Authority-Analysis: v=2.4 cv=e6c2j6p/ c=1 sm=1 tr=0 ts=6a54e31c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=yPCof4ZbAAAA:8 a=HiNZPHoJG4ghpoqcI70A:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfX+uK7eKEtm/M+
 8EaI99VSZpo/o1BDMPV1774dU9eY4Jcd2NtNrDsY5st4Lmaa8Ri36omyoYJD71bgK84JX24sNOg
 sAEa8/ItnivMCkB+6D3cUHiEvVn0uk5knh0hP1MJI0gXcRk9Ysg6+3Zl9NHUoeXCO8oXxkgPDKB
 rfxmDAlIky2l9zFhwajU4/wKmRU5J02pdDw59iOSpJnzW9CcGNh7awV0Hr79K2MgK1JIQrGu2ni
 5NtLCSyzBjjpddsUIV5KvZ6lQsi3tevILaUL/DtfNnq3jTaL3sAgbe0GJJsNcPWKF6csTroUs4e
 PdNVjtuw0WkK89ue2GesTAjs9W3+Sw12BZhQ7vq+oFwGCxkLg2laYtRT1hlNoWX1KW7RQM/4vvs
 3vYz7VaIMCCajZ8vgQynqcWLdQFQk/grTX0zJK7sLjWl1QI+t5pMozngvyzcX3siHAHPELebU51
 6PcZZrbbcu50KbCPcfw==
X-Proofpoint-GUID: pnkd7iDeHd57y1R_GfImCBBrOMEvzwFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130135

On Mon, Jul 13, 2026 at 2:37=E2=80=AFPM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 13/07/2026 13:19, Robin Murphy wrote:
> > On 13/07/2026 12:25 pm, Ulf Hansson wrote:
> > [...]
> >>> @@ -1281,10 +1279,8 @@ static int bcm2835_add_host(struct
> >>> bcm2835_host *host)
> >>>
> >>>          if (!host->dma_chan_rxtx) {
> >>>                  dev_warn(dev, "unable to initialise DMA channel.
> >>> Falling back to PIO\n");
> >>> -               host->use_dma =3D false;
> >>> +               host->dma_dev =3D NULL;
> >>>          } else {
> >>> -               host->use_dma =3D true;
> >>> -
> >>>                  host->dma_cfg_tx.src_addr_width =3D
> >>> DMA_SLAVE_BUSWIDTH_4_BYTES;
> >>>                  host->dma_cfg_tx.dst_addr_width =3D
> >>> DMA_SLAVE_BUSWIDTH_4_BYTES;
> >>>                  host->dma_cfg_tx.direction =3D DMA_MEM_TO_DEV;
> >>> @@ -1300,12 +1296,18 @@ static int bcm2835_add_host(struct
> >>> bcm2835_host *host)
> >>>                  if (dmaengine_slave_config(host->dma_chan_rxtx,
> >>>                                             &host->dma_cfg_tx) !=3D 0=
 ||
> >>>                      dmaengine_slave_config(host->dma_chan_rxtx,
> >>> -                                          &host->dma_cfg_rx) !=3D 0)
> >>> -                       host->use_dma =3D false;
> >>> +                                          &host->dma_cfg_rx) !=3D 0)=
 {
> >
> > Hang on, doesn't this whole if condition need to be inverted? It's true
> > upon dma config _failure_, thanks to the original use_dma logic being a
> > bit backwards here.

Robin, thanks for catching this!

>
> Ah, yes, my mistake. It should be:
>
> if (!dmaengine_slave_config(..., &host->dma_cfg_tx) &&
>      !dmaengine_slave_config(..., &host->dma_cfg_rx))
>         dma_dev =3D
>
> And I don't think that the first dmaengine_slave_config() needs to be
> undone in case of failure for the second call.
>
> Ulf, how to handle a fix? should I send an update on top of this patch?

I have dropped the $subject patch from my next branch, so please
submit a new version.

>
> thanks
>
>

Kind regards
Uffe
