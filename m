Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793358058;
	b=3yvh4YUMATYVL48oBpvbsKvhoVU/zWhm/FOmodcWHT2pXGFa9kO41TYxWqQYtge8BQtZ
	 dJcZxHPDKZ5iPLkN+OfnNg1frDd+9jlbMrhuqU+L0/JEhkVDG1M5IB+5EQNbXt9KoT5gX
	 lv4+zc+inDu3sRsYxOCTomAp1g3VsumEwIeyUHjLxwW2jHMt50zviOEirwxzwyIr5fcVK
	 QyoZD5grBm7V0iVoyRhViUMCBU6FCxGIoAkBoA8Qhyv8LAQJ9V/7Yjv1bc5/oRJm6ZQK4
	 rAo11UPwyrncQWdwVUsrfn21DlE0FC/2GlYPXfT4yIbnWLga9Z7mtZZPYXbzXe5dmcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358058;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=pa/7lUjDdXTS9RhoIzZiDYW3IqD0/QbxRwCrozSE9pw=;
	b=4My/NuXaJeH0Q5lCMuKzyDu005shI3io8L5WHE1Xwh1ul6zfLjo6wXoGut+Yp136o2s9
	 hFuH/sYD4EgowzottNc8x9l9KZP7PXSW/4UEM3vK8f90+HCLFjCC263d+vWjKfpZpE4Nv
	 TNlTIxeX77WW/E3o98QBiYYyPTSS8TgWHNCAaAcbcYJEUbTM2aK5RvBMH1g7DqJp2aQ5u
	 V7OZQZuazpsyqUXwrFyDo0TNlMC802I0hDUsK/x5YDUTP9521Vm01o8QZBuFf+M84tyya
	 0RCAQXTiBPIupVV501dsGpQ2wsQq4rvPbQD/lqHrGyyxUTSfkryQbCsb5kyIvxI4Icw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KrP87kak;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KezwIImJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05C1606A33F
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F05C1606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KrP87kak;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KezwIImJ
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8FSFD1663351
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pa/7lUjDdXTS9RhoIzZiDYW3IqD0/QbxRwCrozSE9pw=; b=KrP87kakQJ2XDvf6
	GL6qn+zOC3yayE14cU+AJMUjXvXNSvOPqM/kkFGF61cFM0k6rI3y/ACIDiaCrnoN
	XXh9+Yo2gV6lw4CqxaZ+A070oBeTCiv9vmsPeXDJoKRjFFuitb58Db2EMvB0MTwS
	60v+VRukaAd7mawTtFBkUKYo75BzEssj4j2mZlubPxEw8UeT6aw3OhvuxXe5mQnt
	A0p8LEfFDi/E7BcTOmRSVF0E4KH/coAREYXCD3/qsJ1QSZnCf/bGoO5EduJc8QBV
	zdpzdGhIJkuLRNRi8MazeIlip/90dHznxqIosw6Z6duXu+uL6L0P+2UDeeZYat3Y
	jAzF1A==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p2n0b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:56 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7cc06b9cb33so107080137.0
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 04:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793358056; cv=none;
        d=google.com; s=arc-20260327;
        b=JcN5Lh7x2FyQrfSwONsNO40Ncd45wOdkyVmon+00qSMB8HtyBTbkOpLhGDoUv0xxf8
         JDrwhDWiYkGqujbBy1pA+xGagplD210ng5U0uanQkV72xKl5nY7bKiKMpWc82BQjWBV3
         yNpMEJH0YxCKZk8Jgr9lVFH5ypjW9/zTqazMV8mapENe8mn9P6he+CTKTbTpoI2F3qFH
         TnCc6k1Z3F7V2g5aBtjvAaOe/YOPbMYym7CS7c8jEuOSVtbhsGjYWvgURyzf++17nu2m
         LO+CiI7/JfYbIQ2BZudVSQ/VeyacpLAhYUlTW9rnHgTbq31Dy7k4cwAFDr2uC2TJPsEf
         iQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pa/7lUjDdXTS9RhoIzZiDYW3IqD0/QbxRwCrozSE9pw=;
        fh=mJwM72dLQoMW5shZMxwkTNKSG3wcA1YTU4PNbeWvO6M=;
        b=oiroPplaady+JzF+ldUOS/vuA4waVtmn5L+AX58jq9rZczuSCARLPirfZBk9Ym4SDJ
         +eRRSWcT66l5C2EFTH+YYKKOM/BZ6LFHLSh11uNJbjUUU/eqmfjecGMFy4aYO0+UYr+X
         QHCTHjQ5GXkyWAJ0dGeB+UJ8Ym0VDWOCs8LlU8rITXpg9+o3CNC5n3PhAwO5AxcgiBjy
         7zfAXSN2y6Ctm1RL43GJJWDKszHFpQtdDa7pjx2Hua2z3thzUgISasqpJvg9aW2xk45t
         Lpeze2BV9T86a7KXm3DYBBAMBsBs8x4PkILLcAJOPqgwig2Ep13vBIbOJJyr4wDag8Tg
         oc5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793358056; x=1793962856; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pa/7lUjDdXTS9RhoIzZiDYW3IqD0/QbxRwCrozSE9pw=;
        b=KezwIImJYMuqKpMnlufHthCXyx4fdBPwSYpeA7FFDb23UrBKI3FGqCi6TxA9iKMrKR
         xEsGfPzgaCi0Orn8Ygx8XRPbJfNZhprgRQGevtTfezwVdzeW4JAv644vZ2dty+QcdWJA
         dvrcS+o5JQ/4qLNfs7kVWvDCbrPzYzEAy8UgeDjrifTb6zYajk9zLjfZNRVO2y7U1Ce0
         z4ahc8Sm8sN6t5jNIlCOuIyThSstpz2F6CgQ8ErLWtiyYGVTVeBIHhz15fmEiM93dKDp
         WSxXQ4wgZdL75vCGoYjlC+CjuHrhMFDpA2zlWFv2H99FbDEIUHjXgIWQezfOLri7CgRC
         PVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793358056; x=1793962856;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pa/7lUjDdXTS9RhoIzZiDYW3IqD0/QbxRwCrozSE9pw=;
        b=a7B4kh3TxJ1jLeMPeeDXnpDcxDsd+tauVKmFR2tHsD/bK6EjYAmcYbPPiDn1zuLnix
         5Dq9jOj12c61JCiRIgHMI6ju0jZ4rZ1mV9ayS4hNGNTRZ3Exs0durEjV3uTGesIa9gEh
         cVR8XcSVNblbubpTZZNQy5YaqaX6qcMtpZZicqBA5DyWOAsIlyrnVcAdDoaIcmzzGK5l
         9x+HLaGyTjbZvS3lSJAL8jS7QfYYf/Xds59pF2Lx9MtMh0i2hQ5KjpIuzlLKqtzdcP3j
         yRdIHki7aNEbjl6Fb1zpvODg5Axrko7AIBGZHgG0Rv5jFOLdpKb8DtVxxllK1ZnWTpbq
         0c6A==
X-Forwarded-Encrypted: i=1; AKwUvBwNEjakW1xdgq6AAgZNycXko9GMp2M2ZvBnkAgKNgd8v7ZVQGaUHbq5Hm5rEHhKFRpfsDSnzLdKA8A=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZxsPhUzl8m/gx/gb9PokYBPm/PJT/7/ZrTYjezb00d+2jR1c2
	t3tCDcOO7Qew8ITD0LpYUtWMta/FtKwtH9efF7n/vfkskKmzKmUN8YKnfQJsFA+FhHNecPPj8NF
	d91KPFHkAt8C0x3MtoB/C5KktLqefbLeJEaAu+NtOn5IpFjvyAXdeeJa/oz2vDFT8VDhLh7cIpM
	8xYgp8E8QDMr+kPoNNU0K4URsGkbxehkeOoL3h2w==
X-Gm-Gg: AYBFou0DGU94bIupU/IyGNLk/z8T/7OaKDACJYOjVJ4emsmbNCcj32WO0SLoDfogp+S
	uMuQkyKOBZtnZzoFPazmeozIQ8NPMy1b36pxN7i1M8NFzUdEG/8saSTgQ7rryv3BrhHc0ZtOcll
	1NjP1oDA155J9O/WeMzrOi+Qo3gYh6x/7tJQnm6mNmxad2i67ZF0bgZz74tA==
X-Received: by 2002:a05:6102:3eca:b0:7b1:6028:5475 with SMTP id ada2fe7eead31-7d072552480mr844828137.12.1793358055162;
        Fri, 30 Oct 2026 04:00:55 -0700 (PDT)
X-Received: by 2002:a05:6102:3eca:b0:7b1:6028:5475 with SMTP id
 ada2fe7eead31-7d072552480mr844758137.12.1793358051740; Fri, 30 Oct 2026
 04:00:51 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021130625.1616753-1-bruceli20040604@gmail.com>
In-Reply-To: <20261021130625.1616753-1-bruceli20040604@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 12:00:36 +0100
X-Gm-Features: AclHuK9H-GW3hcfuq7Vj7wFrWZ7OS9x0oiGneZjy6o6H06oS_BtIg-QIKT5naok
Message-ID: <CAPx+jO8DrjkbjhC+zXpYPhshgmexsXNZULTjR-yyY9b5-mAswA@mail.gmail.com>
Subject: Re: [PATCH] mmc: moxart: Stop host before releasing DMA channels
To: Guanxin Li <bruceli20040604@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>,
        Rosen Penev <rosenp@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfXx9pK0Mj7pWlg
 XAWaMC0Ly+8kIK8yPfYum+g+IqMtpyduf3jDwEoIE7XvuMSbIqGd1IMpAn+Z6fhGKKjT3OsaqF3
 1y0xCBZRk9szc6bUj79N4a344RabWrYIc1TZGy2SC1tmtCA+bLAXnHsMJ8l2a5F1Ujz2SYh20aM
 87Akv1/k9IdEv1SF92WEZQIG3r6EfVfo0cfiNJ4yw2tpVIv7NZv+W+1zEhTHEBu0TJ2f+p49l3t
 D8/10evA8LJw3tr2kRAN4SFbzF2uE8Fkuk/QFuV4TmdQYY3A2rEZRgPyp5lHNKh84Nk8PWqV8w+
 AQhq0aYRA0rYRm3ZhdwC8laZ1XP96ksfm8ak7KfSYBvwk6dRL8yLIDUnPp/d8tMtvm8Rp6msKbN
 SY6Kv+QT8My896XP1EDW8U5YsBh74x6IQ+LbY1xWEaX+ebcJ04mz4JmfYKsxOnW9a9L4VZMQkPA
 0uwAej4RKQVTS8DKr2w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfXwOlzVv+aGcVE
 lzwfWwTQSnVY7cqiPFCjiMieOhzcp/v6b+0kLbkuDet2Vu57sjKuyIMuG5lzGpqjPMZDAzjv8Zf
 mX0sVKVsOQLVF6Ab2UUyvdYZYB0+2Nc=
X-Proofpoint-ORIG-GUID: uEm-Era5X_QbVKJUQ53e6uGFXYuNNeph
X-Proofpoint-GUID: uEm-Era5X_QbVKJUQ53e6uGFXYuNNeph
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae478e8 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8 a=q1By_c-HthyZdKZ-7M4A:9
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300043

On Wed, Oct 21, 2026 at 3:06=E2=80=AFPM Guanxin Li <bruceli20040604@gmail.c=
om> wrote:
>
> moxart_remove() currently releases the TX and RX DMA channels before
> calling mmc_remove_host(). This allows the MMC host to remain active whil=
e
> the DMA channels are being torn down.
>
> Call mmc_remove_host() before masking controller interrupts and releasing
> the DMA channels. Terminate any active DMA transfers before releasing
> their channels.
>
> Keep the power and clock shutdown after DMA teardown. Do not call
> mmc_free_host(), since the host is allocated with devm_mmc_alloc_host()
> and is released automatically by devres.
>
> Signed-off-by: Guanxin Li <bruceli20040604@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/moxart-mmc.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.=
c
> index 28aed13549a6..bece33f4792d 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -684,13 +684,25 @@ static void moxart_remove(struct platform_device *p=
dev)
>         struct mmc_host *mmc =3D dev_get_drvdata(&pdev->dev);
>         struct moxart_host *host =3D mmc_priv(mmc);
>
> -       if (!IS_ERR_OR_NULL(host->dma_chan_tx))
> -               dma_release_channel(host->dma_chan_tx);
> -       if (!IS_ERR_OR_NULL(host->dma_chan_rx))
> -               dma_release_channel(host->dma_chan_rx);
> +       /*
> +        * Stop the MMC host before releasing DMA channels.
> +        * Keep controller interrupts enabled during MMC teardown.
> +        */
>         mmc_remove_host(mmc);
>
>         writel(0, host->base + REG_INTERRUPT_MASK);
> +
> +       if (!IS_ERR_OR_NULL(host->dma_chan_tx)) {
> +               dmaengine_terminate_sync(host->dma_chan_tx);
> +               dma_release_channel(host->dma_chan_tx);
> +               host->dma_chan_tx =3D NULL;
> +       }
> +       if (!IS_ERR_OR_NULL(host->dma_chan_rx)) {
> +               dmaengine_terminate_sync(host->dma_chan_rx);
> +               dma_release_channel(host->dma_chan_rx);
> +               host->dma_chan_rx =3D NULL;
> +       }
> +
>         writel(0, host->base + REG_POWER_CONTROL);
>         writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
>                host->base + REG_CLOCK_CONTROL);
> --
> 2.43.0
>
