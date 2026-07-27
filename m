Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3E4424644
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169525; cv=pass; b=pFrPKVOTcwqrpvbBPSTmttClFniw+NjnrPBxIklo4wmJwCMmN3jrpqO76xUcF+1pzTnYmD+JlafkgiOaMmL8WaT9SJ2NkmTGzJRKv58JTH64T/QS7HwK8XGsAmFwNZuGhfqDFFUtanncLpRIGXAAAjiTn21OtczJo8w6dQ15nl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169525; c=relaxed/simple;
	bh=VlaBBO9h9FesyS1TajLvpgzVwPPhMLDTrikepsWT7BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORp855exTOKl4jhSzsyDddOHkjZ80ijN+e7Qr1QuqG3FcCwqtx0asuiYjyYbgLI3zFD31jZAgd6PaZNz7hyJo5UaVgklX/GijiUQYWw/2q9g/Utt3zy7dSp/3B67Vj8XH7Q/fsj7FtRef9J3cJYI9JtR5KxeM+m1cmAIt3mItfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SwmTgsCx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WcoeZ5Ir; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SwmTgsCx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WcoeZ5Ir"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlbdQ3663522
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 16:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Al6aPyhnaYR+2eup67Udj9VVo/xO3BVXR+NRtIAdkuw=; b=SwmTgsCxDwvLXP3S
	WVMV1njNKxKT01+zY/sz3HhcH0YOTKif544vZWoJu2jDQ9WVQSypnYhH/44WoAf8
	y/Pe/cA9V7drYrGQZTu2UhgspbjPbJDtsbHwlAmdTs9EhOmBOiB0nBp5qdCqf/3B
	P8/y5m4pqPgwlyy04VyYWhoBn9R4GjLe+IGDV0ujSitc7xpHN3ffI/q/sTZfbJ/D
	2LFgcWUF4fqvrfnDQsvRWS8Eo69iiHG0uAvWbO6VdfkfNrM3lrCn9QO57FiviGr9
	Vnau2cJxsISL2giOWPY1uYgFuP6yO/LxewW1ahPT9ff+GQXAHqEyUUnhR8IfA+qJ
	geDmug==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp2asjgdf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 16:25:23 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8fc92c5373bso38244866d6.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 09:25:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785169523; cv=none;
        d=google.com; s=arc-20260327;
        b=ieWoTqwt/+oPKk61PWZnzOgazcS/p+S19RvTpHr+c/20GzWF8f3i4tYT3DY6fL3kMH
         hZCJaKaK5vcMUGs+4JuPpyA8RYPZRCpAcXQXZzNfW5tnwaPF93t1faagNgSO+JaS3X/3
         /IDehg2nqxmwrdzDBWY5/9z5dIqgBX1fG68i2bAzLSB5hypjlbc9nTICPdJ5a7rItxV9
         6Znz5wDdf88brWj+yShv76r2SSymHl9k6tHbgq9k8voaKkK/WlHAjIynaYBjrrFMqGn0
         YcuJGQNz6FlUdM7A9yiTMpXiezpI+RBXrSWlCzklxC1UPRZMjtFVwHqhK3UaFQbbyoti
         L9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Al6aPyhnaYR+2eup67Udj9VVo/xO3BVXR+NRtIAdkuw=;
        fh=B4YP/p2iaCGJUrtpyxEEV/R9XpwT9E+tq4zuTz3UjbM=;
        b=VVpvONB0nZQ3ImuAbV0rITkZz5PLV6gjYZ0SxKP6fbnjQq/qiExUSuAYGPqnaqY7D8
         YYYTs3V/+CZmQYinfWEjbnx4lUpgfao3UUstAOh/y/WXFsLQB9ayw84t335AB3MTv12a
         8RW+PwePhkCxft/1nhtEzKUZunhRoOgXviPN+RX6gUgv0zgGa884sxVp59bnRk0XpbLm
         fX73uhqLGpyNuAE6hHwXxbly6qMxiHQf9fGYdVqmojjgwS6IHaZ3bsO9teYjYxW0XLwS
         IGzgegwW1g6HiT+3BbUPEjSdL6VDVLBacAZB/1Go1KSUfzQT6hEaPv4M2xJtytMgUrXS
         cdeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785169523; x=1785774323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Al6aPyhnaYR+2eup67Udj9VVo/xO3BVXR+NRtIAdkuw=;
        b=WcoeZ5IrJ76BxQ+6kDaQ63cq1LzbITAIob3qqBM43/KN7sHaJBpY/de7RXQzvLEAav
         EXLrMp+QcVBzLYfV//qSpb0qfwGkj1y/eRrjhoTlhE07NfB9vAkQJLqvBZxHs4wxUzSo
         WK5AFpiUbhEPaRtDTpVhAdiU0rffKw1pVPMLlgkTfv/4mPzJ2Dpp+w9gWM6Dkd8JK0fT
         T/tY1PAy/Ltxfrkq6pk+mxMiRuOI14KxP/x5p0w9824DOhdczVcThxjSvMvnt1mZTNZ8
         8DqQYdQkGz46dxp67H5pPPQMy6wcTDX8226PBBcAgxUwQE7K0Uno/23RK3EE5hkhwrrT
         P6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169523; x=1785774323;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Al6aPyhnaYR+2eup67Udj9VVo/xO3BVXR+NRtIAdkuw=;
        b=si/YPSjP6CfxhsBE/rpPIbEGHhezBDmRS1obO/3n7DmDUi9wfgGFSLGlWnTqE4TXyB
         vZImUHnEYzsWlqUFQKp8udg2YE1THrTH0HomCUDm/diu2w3peP1fRGUcTsdQ+3xgVQUq
         CGDSM6x2+O5tOR+w/SEkh3emg8Le09s2/l1R36kAc4LBMa1Uvzaj35kvwzq++8f/gZcN
         1H7U/ma05ckHqfwrBLhn0oB2AyYVCCfmGkpje/CQOZ74ZUlQSqA7S8EJwuCqrkxorooW
         gnQbb1xBUm1K/pp3kOimBRJvgD1p+FKY0kX0CVLQFudreT9/4KUXOEgdl5F3azm9+JVz
         R6LA==
X-Gm-Message-State: AOJu0YyCP2qo4dTicoI7qYHp+LRyZrBpEdUTiFv0zphSwbgDsIyHFdQk
	ZkUI3s9JnjJaoAWoP1f8xVX25uliTuEp3UuMsUZRvx3fTym15q/Wzgc8qF1qsOOBLJ44RmGMiRC
	s9QTrrwLt3k4CP5HqGrNRJTZ6zdSH50Z1JtaeaDkA6oEfVoo5ngaNC5/FkvXmyvhUp0og3SA3PE
	EnIVk/INFrs65iObKKSTRjdWxLjUk3ySNJqH15AQ==
X-Gm-Gg: AR+sD111AyOjg9X8x2TYoTQI9ffS0uql51musrwcpKVu5cTJ6HyBmhxLvmzBVlvS4Nh
	NPfSE50dGms3xiHZq4qEjDLRilVY5n0/7cJ8DYisSjFXzeaeG9hjV5wyPrgvI9TvAR0aSokhoHY
	DLBmzNwbhjbCc9DDe/vFUpHTT0QF5Z+9UYHJmbGD7vxnvkTay7BYBD+Hrv1g==
X-Received: by 2002:a05:6214:33ca:b0:8e9:f5de:d5be with SMTP id 6a1803df08f44-907ec850b57mr106760396d6.53.1785169522628;
        Mon, 27 Jul 2026 09:25:22 -0700 (PDT)
X-Received: by 2002:a05:6214:33ca:b0:8e9:f5de:d5be with SMTP id
 6a1803df08f44-907ec850b57mr106759856d6.53.1785169522056; Mon, 27 Jul 2026
 09:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723112842.3592137-1-fanwu01@zju.edu.cn> <20260723112842.3592137-2-fanwu01@zju.edu.cn>
In-Reply-To: <20260723112842.3592137-2-fanwu01@zju.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 18:25:11 +0200
X-Gm-Features: AUfX_myDub6kHy09HZfLTxdabgd69oggUKf72RUGUgnHq9Ic5V0FuDWDDr77tYA
Message-ID: <CAPx+jO_2G8o0QGywZNLNrtBoUroaWYJWk-HW4OAHu+qwJ=VbyQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: via-sdmmc: cancel card-detect work on remove
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1MiBTYWx0ZWRfXwPJE/2XoYrKw
 Pthh570JOu4o0GyNo6rbOC878SDnsQjRA+QwvtaDIufZEtmqCENXMB4sOf/e37ARnZyAlrQ7+OU
 rqlAD8GfO6+s/gdSdDjhivoRv/sAO1NaKSmQ48L1e2bKDTSDxozevZtY9P/1tldY89RXQSAMEkw
 LtNvPU027GTUoKUgFSLQBmHxhbjHfE17IVpB529YHL1yjsg4kObX2r23szFiZ/gegBCQze1mvTf
 z2lSmS1JGmD8vdeHbLK+NVsUqdPHrUklEIQkgSEjC9FOHUEV6sISJA7xKj9QnN7BLcTBCdDNuxH
 6JcqRQ8SBLYpIIFrtztcwlR5BmDFNmoyoIaMWdSSzXhkf8Ap5uvWdKySsulUiz6DUmTTcFr59lu
 TjyfdLjHoKi6va1wlgcBtC22UMOd5kmtIKVnapB9L9f9+XIstNGfUorgiN7AGfVJ+nBEToZjs67
 LsbRu+v3PUhQGsU9J1g==
X-Authority-Analysis: v=2.4 cv=UPbt2ify c=1 sm=1 tr=0 ts=6a678673 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=qW1FBTmRn0AbZ7jd4rwA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1MiBTYWx0ZWRfXy84za6Yx9frV
 qi75oIH6CVpAuN6puDUXnNAW+ff2iClDy+p7SbKfBsZygoPy6xMEMP/mYyIhVzQri/cFA3HJ/1G
 ZIo6q/dczBSjOkLKODGKhcjwPaYWEpg=
X-Proofpoint-ORIG-GUID: mIvhZ8EKvFKJXSwFGgRQ1rT9vvh0RGeB
X-Proofpoint-GUID: mIvhZ8EKvFKJXSwFGgRQ1rT9vvh0RGeB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270152

On Thu, Jul 23, 2026 at 1:28=E2=80=AFPM Fan Wu <fanwu01@zju.edu.cn> wrote:
>
> Disabling the device interrupt and freeing the IRQ prevents new card-dete=
ct
> work from being queued, but carddet_work already queued by the handler ca=
n
> still run after via_sd_remove() returns. via_sdc_card_detect() recovers t=
he
> host through container_of() and dereferences its MMIO base; once remove()
> returns the host can be freed, so that work would touch freed memory.
>
> Cancel carddet_work after freeing the IRQ and before cancelling
> finish_bh_work, which the card-detect handler can also queue. carddet_wor=
k
> can re-enable the interrupt through via_reset_pcictrl(); mask it again
> afterwards.
>
> This issue was found by an in-house static analysis tool and confirmed by
> manual code review.
>
> Fixes: f0bf7f61b840 ("mmc: Add new via-sdmmc host controller driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/via-sdmmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index 5228a1fe0495..cf7b74835aa3 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -1206,6 +1206,10 @@ static void via_sd_remove(struct pci_dev *pcidev)
>
>         free_irq(pcidev->irq, sdhost);
>
> +       cancel_work_sync(&sdhost->carddet_work);
> +       /* carddet_work may re-enable the interrupt via via_reset_pcictrl=
(). */
> +       writeb(0x0, sdhost->pcictrl_mmiobase + VIA_CRDR_PCIINTCTRL);
> +
>         timer_delete_sync(&sdhost->timer);
>
>         cancel_work_sync(&sdhost->finish_bh_work);
> --
> 2.34.1
