Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405ED43B483
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850990; cv=pass; b=h6v/2hjB5hP8gd47gGdMzPMad8uoALFYOGnHWzp86SZAKYxk7f85gRKjpcE2w77aUDEdiR3PuUk5DcpN/8tiM7rmFxLNhpx+4QEZ3DxOTdsrWbtgFtYAy+QEuhqOGtYDT9glXbhetPzzAmLvwJ9LNb9S+kA/pWIIUJlg/DtEbAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850990; c=relaxed/simple;
	bh=vWrRgLg0J40/F7IFgvutSnpLvx8wmx6h7DOuDiZqAzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuQblLwSabZvNYxn2kXHGTLXKz/z0TrG4s7xbXKoWy8jXiTq5xsrIbL1sxaoTkzqkNSj/SFcKPu5VBOeh7Dj7R5zK+h6LR3pGUoaLK9slcQKGLO7hJDAg1LVT6avk1cobNBu1gTnzEHsZ67LPIgsKkhrXknIwZPgzVEiEMzAUts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zxcghe62; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kkRxQgtu; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zxcghe62";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kkRxQgtu"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CWwWZ3211639
	for <linux-mmc@vger.kernel.org>; Tue, 4 Aug 2026 13:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JFV09JBf8TVgMgmB8u/59KCRJjmSsbdJUhQVWVSH6NI=; b=Zxcghe62akMqHxQX
	TcX9gyT4igpxPkdeCzWD6PCdSLX8b/M98LVaHTJ0v/U8WRnvlMPJHRpKazk5OKUz
	YtcQJ/QU90EJ9NQdxZ8F94Lwfvv/+Wkxzi3k+/fbpkvn2W5TRPMym2G+u6rQwL2d
	iSuyzR/h4RvBLPh5nW6XyPyK1vNiLNhEGQoaSsrSUnql8mQGvU0kK7aA2HQHbk1W
	5IYMECDQrQTTytnYNvxGH2HQWBpWbQ8NYbCz8daWePsPI1tDfDp1/G+JIeWLpJvE
	g+05ZcxX6zokFBLu6iWGdsLResGJhL3Bcv2cIv1uBGCwrqCiIp+D+ykosKqky8h6
	NdBt/Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fud23h2nx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 13:43:08 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8f0ed4fe79aso100150316d6.0
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 06:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785850987; cv=none;
        d=google.com; s=arc-20260327;
        b=oUjkVJbXK6g/UM5O5DhG7GnTpIPpn+NiJax/YOKqICzbyk4Wf/9xyMa4Id0Pk6Ef+J
         jpvGiKohe0qnj4+IrldHpvo4GHD9J8Ax5fP7kCx4/v7zY4N/U44S8IyngiB47Wq3NWej
         wMiZ0AimNSwPMpLPM3+DTYdJDqB+dALYkFnBYETDAlIaTXJTbTkSkwFHa6GOjzsK0j6m
         ohsxPtgnDz9/4N24P4CRVkUpEtYvB3ZJVlWUxoflZPI9+s8pu1Ilb6PKLytBzpPesiDC
         l4r3mfxhrI/nMpEKPnJnu6I00lXv6ZB2YE659iUcv3Lofhly2KWInh7O0sRwZ246k61S
         EclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JFV09JBf8TVgMgmB8u/59KCRJjmSsbdJUhQVWVSH6NI=;
        fh=FF8jEcgxFOcm2gG2JRY9I24Yj6oCkLNFfZpIgG48I7w=;
        b=fcAgCVz2ZQgC91tiLouGGrb9T5Gs86Mjd7qn9WSJbBXTL/cwSY40CiNpqCuIWUVHnu
         Wrsi8Clq7eKk70wvms+GmbeAGfI7L75oR3YhpE0cFY3I9BEtiSHZPWhEm4S/GEqZSPH+
         lUBBA9XGLiBjAd6qTrClyB/+pwkYBefdXe7FEgl+Hf0GHDjiJ0kYmvNMHcA9OB6vfbVx
         1Yyy76tgHecJiWJ2KMOU7B6mbPfoYsMQDq2e/XNPHqwnwq/Djr0B4mDCmlbKUuDh/8La
         MSwAGC1InzRpkjwCG+lR1chj8D4y6L/6KzNcKv5UnvQn07tskUtAFeS8eRx/BCouYTxq
         h15g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785850987; x=1786455787; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JFV09JBf8TVgMgmB8u/59KCRJjmSsbdJUhQVWVSH6NI=;
        b=kkRxQgtuXQH1+oYaGOcLFA/SttB1O72Equ+QuLK1hhPmbR/1beLb/NqW7sc7Jzf79d
         HUtopDUeQwCOhrWeCPw4mG3FoDMSv0sOPh3OI3xDwWwvB1EaUA3pLa+J7k0moVaSUbWZ
         8DgBoaFrUIx1XBPsazrdQFHMnXrJfS3XTqkL6L2pHDWa85etZolx6vHczt0fLhDRePaZ
         DszI7bSnOxVveacsJQGt1I/viMiNuSWiWqO2Mr4Iv/EnLLyPp6RntslSXjgU9iPWCbi3
         ItMYgB/Gc7enOk29VtjBvDYd2UJkDXC8jUQvUpuOCdejvBSuBsBpP9ytHERGzYiqctPb
         QiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785850987; x=1786455787;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JFV09JBf8TVgMgmB8u/59KCRJjmSsbdJUhQVWVSH6NI=;
        b=jYg2Wu4PMh+OKADRnHuIFvFVzMZ1+S9bl467MA8xnWtC0vQYqxmYH9eEHcl8I1SY+T
         BMr9/rdxhjLlvX9FmzXI4y74nBvUw3v/y3z3teuWVg3f8+avrkuOS9G5oxzXrwfjw+vi
         /2QNSCLFelBZq9qO8C+5oGTqTxKSy/OurC+O1T/W/AKOkEAxPZQkKZHuQ9aF8VGWB1FQ
         BAHUSi+GVCc+hYHzxJIw6ha7e4Cw5Oob3vJBAgUohdPX7nSmOiK5Nlxu7JAWMh90VqZ4
         242U/J1dWdUi6kugIBRSKNGCWjUkTJ3inlzuTGl0TjLqS+2xW7oFe1psJiKK9NE1FqJ5
         FqWA==
X-Forwarded-Encrypted: i=1; AHgh+RqzfwBb1NCvL//4kTZhyg85PlP6zPZCQqSQ+YoUPf4xy4pGLlg2a9AKher666Zn+4JhtDu1RBNjQGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK/3Na170VlY+PKD5XPRl4lDdisALCopLF1clXWXlqtHv8yr6I
	/ADzejverYJ+glLa4I1ma0D3M0QpJu/rX6ftROCsIplouPjxDJ2y119MgfEAIxB/q5ho8pfpl9L
	fRHFf6S4yXbQkWSBr3EoviSPrkgthuLbmiY4g86JHagEP7Zm4vY9HOP3s6zs333AQJeG8KgrpzS
	YGSpXDQ/Ly72WYoJ7YnjImzoZssEKLPXBmhbYXDEPLFE5vKw==
X-Gm-Gg: AR+sD10cR+HFHU3/iLJTlyOFVkq8j1IivOAP6+7BxJN4gpEJiO56HjRfCAq9S9NVy6o
	xO50gEjdjexQMQT73bHQgfati1EvS6ySmDKXaepde9oD4a1onqrUJiCUOWT0bG6C7G6xNjcLqr5
	Fqf15fZ3HvBYCgesLvHG6Rk7JSCt5us8mv7U4Qw67EJ7iCxgJUiqBNnU69mg==
X-Received: by 2002:a05:6214:2123:b0:8ee:fd0c:5d96 with SMTP id 6a1803df08f44-9084954cfb5mr292319606d6.7.1785850986014;
        Tue, 04 Aug 2026 06:43:06 -0700 (PDT)
X-Received: by 2002:a05:6214:2123:b0:8ee:fd0c:5d96 with SMTP id
 6a1803df08f44-9084954cfb5mr292318986d6.7.1785850985502; Tue, 04 Aug 2026
 06:43:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727140322.41306-1-mhun512@gmail.com>
In-Reply-To: <20260727140322.41306-1-mhun512@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:42:53 +0200
X-Gm-Features: AUfX_my7B5k2X---RdqnxtTsY7r9fbypq1sJhWZOEiJTCkULuzpV4YOD1Ks3_qU
Message-ID: <CAPx+jO-uVPs0xXvX=qie_pP8+L6yaWSD+w=1Jh8tCEXNYmxugA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: unmap the bounce buffer before device release
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ijae Kim <ae878000@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: _dcMZXjwjGvDaJy_quNZIGxHsRFkv1ys
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX4boeZ7JcIlAR
 bUp4eT2fErQtYgmoQacbPBHzX8veCa+idmHvCEzIPLFDcFhjaRJPoIuFEplFa28LKe3sI+7tv/H
 62UFB9MZk+ZgDjh8i8LjG/5Vzul7rxk=
X-Authority-Analysis: v=2.4 cv=XIkAjwhE c=1 sm=1 tr=0 ts=6a71ec6c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=9OAQqQgZgWU5tXGBbwcA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: _dcMZXjwjGvDaJy_quNZIGxHsRFkv1ys
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX5mrNNUGCy1zY
 OeitG9sjOrNZawDm95mA6ZxlUkygGTfgjctUCScX0/08Y9h4TkJx7ILE2n25v8Cdf5pk+ttdYs0
 9/mCiv+jlYrJDHe4VFNsBGM4wJzXj43Z2iNBrdJlxV3GCVs4XLA4KKbhW8tcauZPO7TlaHQ9XlU
 USddM0vtVs9Wer8zWP1IW1WCIBURawVtdld4dZ9uSEHsKTTQph+JdJRRUh7rxbsOZcJZd18dqXf
 yXtAMyevGHS7YdfLknCHYFFRGhhJTC/pUMoibCHbfcJYBlRzbNdzINIYG0/U6zFogTasSCUvgLZ
 VwVLmc+9ap/k5Svc8L9fdBVQV8LryWwBpC90Ya8xL3Kjcw5NBAMRbVsN5LeaHN7OsE7vTMLcwWY
 O2AS+5//0esLdjjf4DHJY2R/TK9nNv9GJTgGQ7D44ssonuHSFVGN6WxYVMoLuPxtRLgQoirJvXO
 wP3QrzJCvBV0YRVZmpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040110

On Mon, Jul 27, 2026 at 4:11=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com> w=
rote:
>
> sdhci_allocate_bounce_buffer() allocates its buffer with devm_kmalloc()
> but maps it with dma_map_single(). The buffer is therefore released by
> devres without the streaming DMA mapping being unmapped.
>
> Register a managed action after dma_map_single() succeeds so the mapping
> is removed before devres releases the buffer. The action is registered
> only for buffers allocated and mapped by the SDHCI core, leaving buffers
> provided by host drivers under their existing ownership.
>
> Fixes: bd9b902798ab ("mmc: sdhci: Implement an SDHCI-specific bounce buff=
er")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e3bf901b10aa..efb4c7742fe2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4187,6 +4187,14 @@ void __sdhci_read_caps(struct sdhci_host *host, co=
nst u16 *ver,
>  }
>  EXPORT_SYMBOL_GPL(__sdhci_read_caps);
>
> +static void sdhci_unmap_bounce_buffer(void *data)
> +{
> +       struct sdhci_host *host =3D data;
> +
> +       dma_unmap_single(mmc_dev(host->mmc), host->bounce_addr,
> +                        host->bounce_buffer_size, DMA_BIDIRECTIONAL);
> +}
> +
>  static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
>  {
>         struct mmc_host *mmc =3D host->mmc;
> @@ -4247,6 +4255,14 @@ static void sdhci_allocate_bounce_buffer(struct sd=
hci_host *host)
>         }
>
>         host->bounce_buffer_size =3D bounce_size;
> +       ret =3D devm_add_action_or_reset(mmc_dev(mmc),
> +                                      sdhci_unmap_bounce_buffer, host);
> +       if (ret) {
> +               devm_kfree(mmc_dev(mmc), host->bounce_buffer);
> +               host->bounce_buffer =3D NULL;
> +               host->bounce_buffer_size =3D 0;
> +               return;
> +       }
>
>  out:
>         /* Lie about this since we're bouncing */
> --
> 2.47.1
>
