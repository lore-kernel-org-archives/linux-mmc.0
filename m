Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793358000;
	b=17yggHqwUFY6ymj96jSlEXGlhJHOMUuEU2M8uFX5WcHX6na88yzgyjIBm63gpzG4Xx6D
	 AkMuOzlS1m4hm4UME+2Z8Dy6l/jzDgKBhJl3eW8geShXjQYi0l9N+Up0xNpEQwHq7dFAw
	 U5ckCsXKQPRVs3lzxtfuqOZO42VuC8D5kS+1+eicRWRDwu4fCTsX/04JMBopJ1wT0usD4
	 4r2NdtnPss04aKGaWqlIWClFFEspWq/6V4eIKfyW/0M6HYT9M33/fEs2KWwo96Zb7Z50m
	 uKU0OaxB9M3Yg5W9BIn9+u4BED8B9a57w4E3hXx0iniAKvoNn00ujVbiddBqbglRgPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358000;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=EcLCsoU7qX638cxDk0Jd/yubXQHRR3XeJ9m/9WOyvSs=;
	b=jIzD57xBbuK0ooJNkxJnkeT5zFbuQm0zEEwUdKC6n9B4nG4IBXa+Ev69yg08xxbzaUsh
	 +kIha9hWg8z9CclBGyhHHAkvSAzADf9uS/QcE+aoAbnJ+k2RyTmMttPQvL9/ZGGrxk0Yw
	 pSNUKZBEDgsq05wyXT57AUYLb1wa786JOsLFgqlpMrM5yN+L2akgDtcWfhJTDdAeA+8sp
	 eSV2pRqAftm/uzgtB/D207hZHdS/ObSm5slI17VSuesJ5uOMnF83VcQoPHm30sTeQq05c
	 nZFSwl8RCJSMTLffOe3fdIsF4a3G92tSEOm+yj24RLEkGDo6opyLUlI8/UcmvErYcZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZXhLzYuk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aesnGZtu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229AD606AC33
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 229AD606AC33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZXhLzYuk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aesnGZtu
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8EvRF1761692
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 10:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EcLCsoU7qX638cxDk0Jd/yubXQHRR3XeJ9m/9WOyvSs=; b=ZXhLzYukr7bRodcp
	7FjdszwOLwwhhddZ5mkLRr7V2Xr0S01L9vr17r5Qo9+W92E27JW/x03551CT/Ceg
	1pUgElCaL/hPgfwfSI3bAFLLoUH9W+HFRBveyY4Tx8Voo8DYnfJPTdnurU+DrMh0
	MfRLMo3F+CMnUIAed0I/AinSC5zSTTdCrpWDtL0zg3xbGwDly4uJwFE43CE//Iiu
	tfxdV5f5nW/lGegRnzb2AoeMXrGhbLBvqYqusTOFGD6PeUm6E+TB0nMgZ/OeiUr+
	GjNBXY9J4KRBNel9CcE1p9Zeqge9VcVHf/lj9GKqJTamq2ay1OY+Z5Fl4CLPGve8
	zX/J3A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6paj7e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 10:59:59 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ae72da2f57so1006618a91.1
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 03:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793357999; cv=none;
        d=google.com; s=arc-20260327;
        b=UXZhTF10G66juI24Y2kkBIF/is2Mf7iVyY2hIquukPSLzOdRwMv7faijQRFz0LvDxK
         Ny2Bwu6jkR8Ks9I8NmLshkeM4Dd+YuyKWaZi8xVNMaVESnk4ruAUKmwsf7MLng+ud4sv
         WJTJXZTFpEJwEI747w8awdnjxjq2g15CtHacQ+f/4BWEZbboALuNs926Dp2VwKK4gwqp
         4x6LWIBeNlnPUCi49IUXmQfWX7ySUP4As4qJsCOa8narveMRIkfCpL1DdN1LI+88hYDX
         oVMPM7SrDRv4VVPhFORfXN6Gz+aTbmTe8GEB6aR3MMu+1tQyO4FWGmasLc5VyHtsbBfZ
         AbWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EcLCsoU7qX638cxDk0Jd/yubXQHRR3XeJ9m/9WOyvSs=;
        fh=xNdxa00BHB9UaQPIwJr3vEEyR4FyP+EdbOImOwn2eqI=;
        b=mb3EDUnM2AJBxVk8G0UH/ZdBGWnrn3kjJqM2oX5WJSmz77C7jxG/vCTBDy9ehIdGQd
         iVJ9dmg9i3Ifq8w2cI2HJVFzin1q/rqJGj+R9mjcK/7WH+UjC4xivGqW5u+UK0EJUq8M
         LkeaMOuU1r8AR59jwJQmFGUvKBTam6oTwRVA/ke6Tg4d7rVb04n+4/wKAdkDPml5RMIR
         vRetwFpjlPmomGLv8T8LujhgyIOmBmjIWbSmZzDD6xwf2wVsEWxc48SPmmx5VQKa+DOI
         lfMw55nsY6vKIICrXXvK3s/uFhJOOVhFbQok5ifO4NzLFkXE/ZoMK183aY3PVYm0sGlZ
         Nc9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793357999; x=1793962799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EcLCsoU7qX638cxDk0Jd/yubXQHRR3XeJ9m/9WOyvSs=;
        b=aesnGZtu3RqWp3zIchK+VbFOxHdOXpm2qmPJNhIABRM2KmQlPr+3PAvxFXnm0iYIIZ
         r4OOcimTQ32cHV9Qb+hLS33EZvHAol5jqLc/AldRO4hVRtda8x4flN5NIEC6mLoP+ECD
         hylyJsHhoSFdSkcS2H/Q+pNdvAn1tYQ+Jh5WyvPD/4cR/NN2ZfM+EPIejVOCHdv5EPeD
         BybHizPZr62tQb5eBMbEhOjBhX38kZSRukzEVX/JIMFMPh3iS9cP1XoGCdWrQKsSYAqu
         k/dYiCOyvpOjyelVc1EEICEQgwG0VTKyqH9JAORHSVUdrtxA+T/WEFQLpN02oKyWXGht
         C7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357999; x=1793962799;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EcLCsoU7qX638cxDk0Jd/yubXQHRR3XeJ9m/9WOyvSs=;
        b=CerQk9PyBmu0JEM2Ylr1wNSE11CFU+zNW9goa8IT2dF5l4qi+4DToJsdLXeVPel9X1
         sDTuTfvUxNT9S//gsJx+VgvP7ScZjsi9xAyhItRcjZrBtq470yp/bcmyFOMagNLbPqan
         BMLdrmcswRKUj6+hj10O0tRoVdP/RtmpeS1Ov2QVngzzUvGoT+MCtpUy/LEeraE2Mj3e
         w+UearBnKLFproyIH/5+w9vVz9CxLpxBHoAUJ5JPN5ewAo0Pr9ORxTNFjN0oNmdPnydr
         zHHhhKeOAJW0y1o8B81wvoVzUdgPKWB4u8UbwNto0L7DXklD+onTkBK1gUb93LWFtpul
         SbdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxS/JmUV+r9zpmDFKIecrihyzgmZSy66kLWePJYwrvnWEE2NEDsbYMMZgSbZlm3VYQ0erDRuiKJxFI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkM1ZO53h7mSEWYB1S4z64Blk73uvg/2ejeGUNQzuO87nYzrdi
	ZmwTaVAAEhATHDnO6qG9e1+73vzH4o0N+fFAtFi+1g6qnCd9iPcydCReA2BkZHK/pC9Jd4PG1in
	T9OxDHp4LwH4Bk91bRPm5KemhPQDt/xXox6oY1pNL5/tOFGGnr1gznnkKO8OKwBZFq4MO89P0k8
	hoPrJFXFjdhGfKmHbDPP5eQM6/oPK+87VqFUCQ7XW8uYFm9Q==
X-Gm-Gg: AYBFou27aa294DPaPUoM8B6/ckEPZWrNI7CLvB+9S6fo2LtnEy1ooOuziOW1PksL7YV
	Kvaz9nVxW0IW1a77rVJm/K2YCY5we2ElmgbbIC6o2iljlkyo0Al4FZbEmxa0XcHC2zWX877nxaU
	Nil3zWcbvS9heGqBNPzK7umUc58OCTmZunYxpNfC7icMOiGu4MPTBCNspQ/Q==
X-Received: by 2002:a17:90b:390c:b0:3ab:e588:c2a8 with SMTP id 98e67ed59e1d1-3ae8985c4e4mr1479444a91.64.1793357998949;
        Fri, 30 Oct 2026 03:59:58 -0700 (PDT)
X-Received: by 2002:a17:90b:390c:b0:3ab:e588:c2a8 with SMTP id
 98e67ed59e1d1-3ae8985c4e4mr1479432a91.64.1793357998487; Fri, 30 Oct 2026
 03:59:58 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014-patch-ektor5-dm8168-mmc-v1-1-2d148ca0f948@linaro.org>
In-Reply-To: <20261014-patch-ektor5-dm8168-mmc-v1-1-2d148ca0f948@linaro.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 11:59:45 +0100
X-Gm-Features: AclHuK839QpP0W8Kp5Bw8lXv87QTBV3y28VjWmXAjWXxKjbBKuJA2Nd7uXoE2uI
Message-ID: <CAPx+jO9ui40cF6yqZdEQxx8FcHfrmCtKO44GVKcjwd4FxnvbWA@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Do not log error on probe defer
To: Ettore Chimenti <ettore.chimenti@linaro.org>
Cc: Ulf Hansson <ulfh@kernel.org>, andrew.goodbody@linaro.org,
        rouven.czerwinski@linaro.org, linux-mmc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfXwzlpiydniqT7
 jC5AD7kyZC+OKxroOuNfIi1Rm1h0dtYHlviSiHKfVZfO5XYodkFU9p0DFf9J1soVzkNiOFud9VY
 bxCuMNsVLWz0GZvLvgC8yprZB63s4umCGENj6D5OywB+0B2zfzkNJ2cgUqadbGtP7q9Fb1wX6yz
 jaXowyRqez6YowmAjjcfYVqPRLIKI8Gi8E2ckICl5mZiKzNdQlIVPTlDsqLlQ0DBGsDboYWSx3H
 K1Zd7AyX1zbqvSvZbLB9pj428hK64AqmXiKP2+rS+jXAiIYfx6S3JFrydUCRfOTcLShUmj7/Fcc
 Pi2rlfk6Rho5HzHYx9D63thzxQDbRZvF7IhVZVNpZOf1pZWjHVbsvLo4YH51dlfYpUvNd36Gg1u
 T2IJVwhLAopYG8GQausrnezMlFGtkx8z5+i5CeMopsr0nE74234FKegW0po1wJo8XMnZPAlIUfJ
 2cjSrBZD1NtORhsz0/w==
X-Proofpoint-GUID: BkRWXA9jhpUBOpkEhRD2lHRogEjUVSUM
X-Authority-Analysis: v=2.4 cv=Lp4HWXdc c=1 sm=1 tr=0 ts=6ae478af cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=KKAkSRfTAAAA:8 a=V6vyg7vV4w0SYrr6CqYA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: BkRWXA9jhpUBOpkEhRD2lHRogEjUVSUM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfX8HvdtF5CudKi
 6oYfEuJMdT4zTpZP69SCZ4EMfF0YwUDTIzJ+L9Eakc5C4mfXag1jVnsy4iNuGl1vEX06LdpTV6N
 nNug5G3hT69Fwlvp9DYUid9Jg+OhyVs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300043

On Wed, Oct 14, 2026 at 7:44=E2=80=AFPM Ettore Chimenti
<ettore.chimenti@linaro.org> wrote:
>
> From: Andrew Goodbody <andrew.goodbody@linaro.org>
>
> Do not print an error message to the log if the return code is
> EPROBE_DEFER by using dev_err_probe instead of dev_err.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap_hsmmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.=
c
> index de5a3b70107d..ed52adb38fd5 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1892,15 +1892,15 @@ static int omap_hsmmc_probe(struct platform_devic=
e *pdev)
>
>         host->rx_chan =3D dma_request_chan(&pdev->dev, "rx");
>         if (IS_ERR(host->rx_chan)) {
> -               dev_err(mmc_dev(host->mmc), "RX DMA channel request faile=
d\n");
>                 ret =3D PTR_ERR(host->rx_chan);
> +               dev_err_probe(mmc_dev(host->mmc), ret, "RX DMA channel re=
quest failed\n");
>                 goto err_irq;
>         }
>
>         host->tx_chan =3D dma_request_chan(&pdev->dev, "tx");
>         if (IS_ERR(host->tx_chan)) {
> -               dev_err(mmc_dev(host->mmc), "TX DMA channel request faile=
d\n");
>                 ret =3D PTR_ERR(host->tx_chan);
> +               dev_err_probe(mmc_dev(host->mmc), ret, "TX DMA channel re=
quest failed\n");
>                 goto err_irq;
>         }
>
>
> ---
> base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
> change-id: 20261014-patch-ektor5-dm8168-mmc-138c9ab3f014
>
> Best regards,
> --
> Ettore Chimenti <ettore.chimenti@linaro.org>
>
