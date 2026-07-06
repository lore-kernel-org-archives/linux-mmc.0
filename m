Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE51A423773
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352821; cv=pass; b=rUIgx9DKjbZHXdnpLYvfOKL+WVBMmIgujzvvY4d3SPGFmNHkYyDad3LKctOQzmBGzNO4HAZcbzBmf2DcfqjWOIbyFRQArjgO+6VHi64VBuiLHxpiItJW8xM9VwKgHn3Kwf5bRpw0FMFFL3DyIWuoXy7cKGXFanDSxJTiLIQ0Fqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352821; c=relaxed/simple;
	bh=o+fUi/zQWjIGBrT5+EJ+XtgrXnZ9l17GInF97cBeXAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQdda/fE1SKkr1FCMei1Sz3AJ8chfwwai+lUjqUfoTZTHVXXXtCs95s4Z+3J+WnmK375RcnqOvAGfoEACK2X+V+K2f9IYX/afgj6vnekEs6he11dh4zb7MsLMCiYhIbpyJx1UEtiSBFqKeeUhxWUr+ET7Sczj9gtf8Mmw+lSSac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hn2jsj5J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DXGumLK6; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hn2jsj5J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DXGumLK6"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFINf762537
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JIVXW5j2O8ttyTxbMpirlQRtdOp4ytrv9NmNMbBDzgs=; b=Hn2jsj5J51XuWc+s
	znK+3VQOPAz4vv6mW61Q6IJihNSQ50gEfH8gpXGk25xrTAUiQTnhC2pzxwzoLHZ8
	fCQGH8xPAee44fdLtFQBITLFIya0g3gv4TgPaf8Ri/FS24vtZSkyzP6IGFRqjknT
	GLKwJ1tBt7w+OK9wH0GfV3DR+ivN6Z0R6Azw/z9bmgecEg+29sLzKI/gQ9rgSgrA
	ptX1Aj3iIVtKFnZdpaaDUKvHNuKqz6vH0EQsyuMDCxAzcKZps+ukWzOscj6vFFAU
	FNcBVfUd/cvi2E4J0DUuwGPMlf6a+R70R0ITTaPW4KtNOHxRDXHmHKedMgXVb7Q1
	sBcT0A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxt8s0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:46:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ee593a5a2fso40415246d6.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352818; cv=none;
        d=google.com; s=arc-20260327;
        b=HSoGo8B4aLzWhAxoW5gn4MLXcZQ1eCfUTPtk9+OtUerMWGfh2O088ZJvJ2x2c9Td7z
         w+Ly9hhod5v6xnaAFRTQAkX+ckcSrQ/bUA5mqn0q5lfjbexUj3EephJBM7KVzbGiJMat
         rIhJ3Mr8sWzjZ5uyXVs6eWc3XeJCA3HM5uh9tBvTG7Wl8Eyw4Icbk52TMBW/A3I748Ge
         TM4qYPcnjppGsiBz1fa18IViVnIcLMVu68kGsyaIJDpriAHbxqxVUJTB+Xmgkn67oxB9
         l3nIJo0/QtUlcPXmfigOmKIJLBmWfeBUhb88YW0XDdJzO4aHRKTYAxp5TNfxnkL14EYR
         RjTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JIVXW5j2O8ttyTxbMpirlQRtdOp4ytrv9NmNMbBDzgs=;
        fh=XdMsxjWY7yRTrKyz9z4WnmUKQAbRn+XL3/ldBRcXh2g=;
        b=lhooIWMe3Es0LHj3bm42THDJ0hON4B355nuiNeFcVbEHHyeVXmg1gI1oaVSax6Zh1g
         Q3PEcpOO74FEavDaRaMRAWA2hpZuIXuYgNbCpQa+CauOdazYNgG8DNk5wvGLla7griDz
         YoYTcujJTpGMHWquJj/nvu7T0PMvWv1Wb1KB2SoKb9kfbRas0je1yWNlylSajPAIuNfX
         j6CI0iQSsRAjqFr5/ZmtdOM/0GJEmN/DB+KZqbbwitL/yBR/mjmgKT/Bz2ItLUdEQFTY
         u+BoNPfg5N75lwB9fhhijZUVRZJeSGNu3mKHx6TQbQM9C52kd3BmJypl9qio3bJvyjzq
         c1cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352818; x=1783957618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIVXW5j2O8ttyTxbMpirlQRtdOp4ytrv9NmNMbBDzgs=;
        b=DXGumLK6AF5unWaM5y9n50k7hspvfDwm1wkoeSZlUfg+OIz68jUfby9VEkWENhwYR5
         6z2bauJ/mXICKubbg/84iGqBwpzJBjYBjXjt2J35Udb27t77rXVy0LjyYbA9M0ZdG+26
         CFvzZWFJuVOLZKxB0VRX+0Ia30PbGWjCv7JvPcuSmYhKwpDwEQvOfmZBsHoNmwQswBl0
         db2ifwc0Wacsqq35LIACQBnB9EJ4Ofwj7BuL6XwsQ7en3lulq1amSeaBMdYj1UldhUP/
         yX7S0z5D8Wd5Ec6DmyQXY6r7iVZrMXdhjGMm8sOTWiDR8GkvSmfWiW3cQKKiNH0epToJ
         1PEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352818; x=1783957618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JIVXW5j2O8ttyTxbMpirlQRtdOp4ytrv9NmNMbBDzgs=;
        b=Pye4GoNoJ7xI/NXVBkAfxQDF2aUrEglR+QDygq1hWmv5jObIAEA8ZLVEVM/1bZyzE0
         LfYRvMnRWvGJRQftZFjIzn/sZBdZS2T39mRmcB3mWZXBR1qG25kejcs2INNMjhdL/vXc
         p/TGipBkKIsOtHyKqWJAS/UTY/g0Au3mirpAAdrSbUryrJFsrM2dZ6gp8uAx9jUrBjUz
         coS+1+lQCwLPzaoAGV4ltQIm8uV5YKcz8cSxB68Fm6OY/+YQ5fodEKYWhIiUqfyd0F0N
         +6GynFqFSF9/rEXZgYKTIwqlK+pVqh0xuvVrLaXwYn0po5yd4mi7CL1+6hV4WXcc4d48
         JV6w==
X-Forwarded-Encrypted: i=1; AHgh+Rpe6T1cPT0AGACucumRQFcAV9H9HBarRGhQYBHJU18VIN1yALTbGEWKDGjJ4yE6QgketJlFhoBrZgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsG+dG/fRTIEVJiro8SNJOrWSAqcL0cMs2vPOOq2rMiROd4bYs
	vt3I/qCHmTmiE5bRZwKLJm+E7mtvEb1E4LFcX5FMMjL38UXGS6fcC8kfEhk+AoaAIpIEX0Elz20
	Pj8svzPNj4BLULYqaMdIfuj7PIEZB24tYLEFTXHLW6/+h+h4W1zosABO4UE9weq5qJ/wNoEw14H
	wuMRMZXZWiZIT80RYi356mf/GBfWnxsvBN3NSalQ==
X-Gm-Gg: AfdE7cnM7pflMPR8LdPL7ZaB5aBQ7Z+TXVuDdsoK/If123KThPJxSfXVLtlZtKHrWsq
	PZSNdObPFcsaALC3IeAZKCH6sbxRkGh6f5ZXVXxeRSXIo4i/ByVqmBQpZmijFftsTW63hxnLcNV
	70hIJe3P/92bRgcgHZLDDafRpkBK6rI0qFyOs4yAfgyVjbS8LGxzF3Fgt/U7ME3XtJoKzK
X-Received: by 2002:a05:6214:6014:b0:8cd:d12a:3d with SMTP id 6a1803df08f44-8f5bf1873abmr177381106d6.28.1783352817505;
        Mon, 06 Jul 2026 08:46:57 -0700 (PDT)
X-Received: by 2002:a05:6214:6014:b0:8cd:d12a:3d with SMTP id
 6a1803df08f44-8f5bf1873abmr177380646d6.28.1783352816966; Mon, 06 Jul 2026
 08:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623061117.35280-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260623061117.35280-1-pengpeng@iscas.ac.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:46:44 +0200
X-Gm-Features: AVVi8CfrGm3jJSmwzlHTU1Ukz7OUChduglMyIMwzWluTXvhMTrM6QsuVKpBvpfc
Message-ID: <CAPx+jO85jWW4nUOSP41FbPcd43hzd_k6x0_fNE8=mK0ZXuiX9Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: moxart: report DMA completion timeout
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Ulf Hansson <ulfh@kernel.org>, Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: LUNccBMFlfyTtZn9FjpqeGCIIa9nIW_f
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4bcdf2 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=B4PYL06Hc6CGz8aCsbIA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfXwSYBH4Bz8922
 kEgi4Mv8R7x+3b8+INvloamr9ofliVR6VZhRUaqfAWp7FczNGvMj/QxsCFH4bqqMUQq8EBF2NZK
 2HqyssyFmq070V8sJ+RW9ld3awPI2rM=
X-Proofpoint-GUID: LUNccBMFlfyTtZn9FjpqeGCIIa9nIW_f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX8IOPJ2HS1LyG
 pH8sAMLsvQQTaA094EjMdW1F+v1Xs3IrHi7JlPS0C5yfJHf8UznCf8o8e28Fd6q0vZiQYJx8DST
 /bdvqabgYwV3JL81WBManNZjuq8nFeOl+P6Y1G8LDo/zxdauciDs9/aFkcPK560cTJ3QEXAbDI8
 MCug6LUxeWwUSXRyEGcBtFPnzL07w2rFUTejCO78ufC6LAnv+VGJTXnz2JGO8MlqYkit5JaIu/S
 WulIIZ5wrvUIW9Hnw4zrFGksbtBEMj/FmJ6BPZCasTXyMHMq0U+esxYJhYopVnLlP+pC2Vqrcfy
 yY1AK9T65u2ajZuNguUVuSKbqXIN8Ab+SpOE4K9yyNpINW6YbOCEZQh5f//avjBsWDssgjayGyK
 8SjofSfpU6g66kMG3HrO6sLmo7PXoUxdiiKEMCEHUM43RQfwC6ZcnkWC5BwwmyH3yS4S5GeAR/D
 MtNxmsnLgme3lMQALPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060160

On Tue, Jun 23, 2026 at 8:12=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:
>
> moxart_transfer_dma() waits for the DMA completion but ignores
> wait_for_completion_interruptible_timeout(). It then unconditionally
> reports the full transfer length in data->bytes_xfered.
>
> Terminate the DMA channel and set data->error when the wait is
> interrupted or times out. Only report host->data_len as transferred
> after the completion is observed.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/moxart-mmc.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.=
c
> index 3dd8f232052f..4a4d8b19b18c 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -264,6 +264,7 @@ static void moxart_transfer_dma(struct mmc_data *data=
, struct moxart_host *host)
>         u32 len, dir_slave;
>         struct dma_async_tx_descriptor *desc =3D NULL;
>         struct dma_chan *dma_chan;
> +       long timeout;
>
>         if (host->data_len =3D=3D data->bytes_xfered)
>                 return;
> @@ -296,11 +297,17 @@ static void moxart_transfer_dma(struct mmc_data *da=
ta, struct moxart_host *host)
>                 dma_async_issue_pending(dma_chan);
>         }
>
> -       wait_for_completion_interruptible_timeout(&host->dma_complete,
> -                                                 host->timeout);
> +       timeout =3D wait_for_completion_interruptible_timeout(&host->dma_=
complete,
> +                                                           host->timeout=
);
> +       if (timeout <=3D 0) {
> +               dmaengine_terminate_sync(dma_chan);
> +               data->error =3D timeout ?: -ETIMEDOUT;
> +               goto unmap;
> +       }
>
>         data->bytes_xfered =3D host->data_len;
>
> +unmap:
>         dma_unmap_sg(dma_chan->device->dev,
>                      data->sg, data->sg_len,
>                      mmc_get_dma_dir(data));
> --
> 2.50.1 (Apple Git-155)
>
