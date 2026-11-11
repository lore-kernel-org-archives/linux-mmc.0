Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794399558;
	b=BEFq4aGXKdWRpoxoaQpvlwPTCP6jIva37VMRjo+s6xBovWb85/Fe4hSt0Q5aXjjeadVo
	 pu+Jt+ps12j/rhHJe20vhzybN68bawBaxowDjUDg/yddgJHSCGlJIOGZ813r3Hk6ZBKx/
	 8pZoSErPDRPwGo0gFnBf+lpj7VcA6kf82FJL7lgar6O0IT8YRIy/iwNv9ct0jC5Eo4Ew+
	 qZNKNbi2c+rd5Ej5TCbhq8xT3/p66h43+oWrvFwZQdBPxeazgo0vy/bcJvbeRdIxJEV8v
	 wvlYsePANvQEq4QD/K3f/MIgWlYQwhygXfTXmUkNrbKIEMbxm+EVVSYcihuKlGqkCyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399558;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Z1TCNs1smOCp3Z56q7h6cFW/kToZwEK3IDBGLcQoIJ0=;
	b=EcrHURk8rN78bogyrSOYgNFLMUR4s083tuAep3zEwjKM3/XA4wh4t8sUephLFkmLbm4Q
	 o9tPdmaXsJqNkmsxSKoKr6mZ3x+BNNEAuQj0S1XB3VMtg6qbR3INUhonuz+n5Z2Rp1xlA
	 GxP4cAc6KfvjoaTA6t2eHzEj3yNGCxdpVobvbLlmDbQpgMASk40HQyh7mCj+LJZVKQmM4
	 sQSmjgJMYaNiFUveazgocidZT6cPaFPfOLosKNhxa7iPbucE1vHhLGDs7sKy+1paRhFe5
	 Hbg2QIrMD55XsuNxJ/QkSJ/z0qHfUGLcPwZdVCg/DT0GH1R8b8aA/wknxirLjQ+6ULQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hvb+1f5j;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="MHlQgSn/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77D2606A33F
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 12:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D77D2606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hvb+1f5j;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MHlQgSn/
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB7DOso1590033
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 12:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z1TCNs1smOCp3Z56q7h6cFW/kToZwEK3IDBGLcQoIJ0=; b=hvb+1f5jwZYKCwEb
	sFVeoXbL/PmuXkm/knPitOedzCAytCOWKB+lxAoiuqSp9ZRqYCFG+C65Sk623pVA
	pGEdZ2F0NmNeNiJSE10oHM3wctp1zuDDLl0qkMZoDlHm8x/KDjqHaeF+uAXpbwgl
	oadUfofG8+Fdm3ac9uIlc59N7m8XKOYyyjVtqeS2Oh4cO5bxp0RkpOs75VgDjMmO
	9sMs8iuU641GyoOGAl6TCxWFApRntYCvtBqimmye144DJ2b+TdHbnHhuQSh+xsp8
	Ysdx1hyOYPngeZbJgJQ4sxuwlfom+NtqbdWUNj9H/hiK+LGEODxxPg14BPddZwSz
	XGaSbA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvksm94aj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 12:19:16 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7d2ca2a4489so706164137.3
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 04:19:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794399556; cv=none;
        d=google.com; s=arc-20260327;
        b=MG4Lw5+QcChZSC+P1VyUbM7Pv+w0twM1dFkS6i2BvaEUWfwwsWCQzsBV6w1v6FaMKs
         eclYMQc3fxIFpYFyUyueaBlumlkuDyvHI2BjVS3T6uHJPphTtANVRxBd/13s5X13Iz0k
         4pbnpdP22g64YLNGS0ShE9yRMIs9YA4lJR5I1R5XLu4HLhskWKsvdBSuVrpDLuONgYt1
         Z3EUgPzYRH+pHiKGx6gfspOrJpvVDzKlGeTcEs0vW9tyKu/QjHUkm8ljbyHjEloIHTqN
         bvkEgz3AvscjzmSEXexLLPeF5FPkRFy4Kma3qgmx+IjlBmmX/fqTq/Vav+RQe+0SMZ4P
         auVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z1TCNs1smOCp3Z56q7h6cFW/kToZwEK3IDBGLcQoIJ0=;
        fh=lr2iJVJQSYoJ39NyS/4+a2jNkTGOUt45sbjyNP1kwVE=;
        b=GhYGz7m5r0UBluAlF0QwIA++VatK+9MQjLOG05tpdabdtt6gMbvZyUFfWkkOROxRh0
         2qnMf9H8HW6mGETobliDSj5Tu0X+uRTRWd5S9tHZBdHlPXA6fDCaFdSra+ZMO1lTs8Lq
         xd5U4Um0fzy42lc6CABbPmEKedXcqgR5gs3zVmBMtKcjScU1ikXVAsP6rk/lBinM7tml
         5jEmgDAc8IKeIf3aQE+Cy52H2+WFrgbWL9A8aCy+ZkHS9OJyunOLVe7nezoDYTFkPAhn
         SpkJejgIl4MJIhWZ4CC9XUPjatGaVStG1Z6TOxvGAQr1dpTPjkKxS4hRggRJ5vP4ZOVT
         /0fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794399556; x=1795004356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z1TCNs1smOCp3Z56q7h6cFW/kToZwEK3IDBGLcQoIJ0=;
        b=MHlQgSn/qc0TU3pjyhcQ2egydg6FlkU2muvMQwQ8KWxSODaDjZttFq4II9LlZ6zkaW
         7LdTRQ2oXTk68pi96roLl7L0smRVGrgdQvW0IKPoQVTMaHRORTlbbfE0KEg4B/osjDAg
         MBqX6SVwcJZbXgCl7HekYFy3Og43bmjyhL5bdgza2vdvXK64Pt3w0Ejrt5Y+b5NUAVAX
         LjjauVM3o+WpZVzZnF9ys1v2APaQvaptHqkNMAayzC0NkDfi+WbPb0NMT9cmZsHtb+jl
         HiQJ1FqXe5xXvsv1kdk8O5Y1UjTTMhkKV0Ed8nD+KpFou9C0eovjGfjsOhq4tJfudW+i
         0FLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794399556; x=1795004356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z1TCNs1smOCp3Z56q7h6cFW/kToZwEK3IDBGLcQoIJ0=;
        b=zot7nAcyI4GOK8q+apz9klNiRwWsphK3Ilai7L59lWDzADWfqkCGeeo9y9S49byJMJ
         +qniHl6BRqPmJdKDft/HrCQzmPoDWhAgurz6zKMmoahW5+8KiAe0PPi5FoEvPE1M+huQ
         15lf36CX7IeNXJSZsA+HAvLANIzHXmSG7sVF8DYynRrN6t2f9DtnOZO4o9/QHJ21YbGo
         6W1HPzj8Y/90QCh8KIWiyduIlFFasXT6YG5pFOlgIZGP/rs6mbVjmkPvu7940a+2VBQ2
         YY+Jq4Fdc/kIeyZFNaiSnRKuslEEsEjQa5DirRisnF6NUXedSj3UUlfgCq2lP7FWW+vy
         frOw==
X-Forwarded-Encrypted: i=1; AL+hErGdDPhfOugnWFtdd3hiz8SDLTfDJR1VC0paz7C2Dnouz+v0MvwgymJDuhSlcerd9zybkUGSyPidrdI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+L9xL3/NmcjNf7tr69gDOS8jQQh3p+V7Q6pGkqFqch7WS5r/QX
	Iqn+2BHlLLzB3c9wYkO8kXmmGktnjp6PWqgnjoAAEqZWUgB7HnipMKhk4YJ/dAsw3r2BgtJ6hg6
	Dm19R0wn4v1V1iLtfeY0NIBjP+NlyudbIg5EdhCwMMZ86ryTS2DI9NOp0dc2LuRCNgKasp6Al8H
	ezi0qp3ji9iuQ4RqoQ7RgNSRoKO13bvvO0lhPAv87Mye9wmg==
X-Gm-Gg: AYBFou1YsfO+M3VMbNTJVI28UfMardKwA145NyzWFHvpkS8b8SdnOFr0NPHawHRAwF9
	6r8hsjrmPfaTtRg7Qeu/FGcXa5VmyLH9B6ijkQB8yULU1n4EeZhg4m2H1dscv9OypkO409gjzvx
	7DsN/PjO7uZft4x3/CEbgFvI8nsu8wbXwLcN2jzdYWWMNZNbXhXbqVaK6TLw==
X-Received: by 2002:a05:6102:6e89:b0:779:5049:87b2 with SMTP id ada2fe7eead31-7d4ed9c43aamr397415137.0.1794399555827;
        Wed, 11 Nov 2026 04:19:15 -0800 (PST)
X-Received: by 2002:a05:6102:6e89:b0:779:5049:87b2 with SMTP id
 ada2fe7eead31-7d4ed9c43aamr397408137.0.1794399555154; Wed, 11 Nov 2026
 04:19:15 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102171603.368298-1-pmazzini@gmail.com> <20261102171603.368298-5-pmazzini@gmail.com>
In-Reply-To: <20261102171603.368298-5-pmazzini@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 13:19:02 +0100
X-Gm-Features: AclHuK9L2i5QMofYq-DCHvqZDWhP-djf1yvf5YQeg9uH5hqyPXlLD5ujeUlfzIg
Message-ID: <CAPx+jO9uDvEyrT9ij3Rrb0=rmKzn+TK4AH1zqrM1Gz=_eW2pfQ@mail.gmail.com>
Subject: Re: [PATCH wireless-next 4/4] wifi: cw1200: add XRadio XR819 support
To: Pablo Mazzini <pmazzini@gmail.com>
Cc: linux-wireless@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: zKgodopNTr9aFKmhR7nWTdO6bYNKUHB2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0OCBTYWx0ZWRfXwCDbK41vjqkR
 KsOVYONqoN6K3RQWOI1QdJ6AumJHI+80ceSdPBuwFvig1W2LxIouOtgrskTTE5rUJb6vWiXSs2F
 bM+EBRNAG+Ow2p31HC6X06JRPWs/MId/u/gyWkxwL9OZu2xfe49PD8+sBl+5gsH/P3Q8+CLWR8O
 NEQHF+1tOSyzs/glc6utEHoOePXgtGa2Xj7jsDgqOL0We52uVJxRpHRRgnxX9ycmdKBGbOtXaTE
 pV7fiW3SQ2wBogGtLNpaQzDcjTkJ9/bRap208wp9pdoVLR+NbSmmU/pF4qTnalIgJ6xwflK9Tsn
 FgFZDk1EFb9fe7MTcBrTiUCMes3tPuqyStMD9308X6DXljkVoQmyrUo0tws9GAYOayOEqi7UfOV
 HaQBLCghejY5/7eXdaOiOhhDQJzpvuugnSSSV8hchQHF63GGDYkV1Ez0VZDKJHuQy8n8QctLhPt
 cspgi9wv1J0OfinIzAA==
X-Proofpoint-ORIG-GUID: zKgodopNTr9aFKmhR7nWTdO6bYNKUHB2
X-Authority-Analysis: v=2.4 cv=O9isLx9W c=1 sm=1 tr=0 ts=6af45d44 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=4gwp0c1PgdtURhtzPC4A:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0OCBTYWx0ZWRfX19iFsmtft5++
 S3+40ltBNpGWV6z8vtE5JT4nZyR8pjxJcMd/lqZtE8cdodjy5KPjKv9MVYlZXrTb62WU+EO6ZP6
 HokZwVkMWoqmR+PcvwX4N9zbd8fvw+A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110048

On Mon, Nov 2, 2026 at 6:16=E2=80=AFPM Pablo Mazzini <pmazzini@gmail.com> w=
rote:
>
> The XR819 uses the ST-E SDIO vendor ID with device ID 0x2281 and
> reports itself as a CW1x60. It starts from a bootloader written into
> its memory, then takes the usual firmware download. Its modules run
> from a 24 MHz reference clock.
>
> Give the CW1x60 entry the XR819 bootloader and firmware, and load the
> bootloader instead of the NOP instruction.
>
> Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>

Please funnel this via the wireless tree.

Acked-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  drivers/net/wireless/st/cw1200/Kconfig       |  3 +-
>  drivers/net/wireless/st/cw1200/cw1200_sdio.c | 13 ++++-
>  drivers/net/wireless/st/cw1200/fwio.c        | 58 ++++++++++++++++----
>  drivers/net/wireless/st/cw1200/fwio.h        |  7 ++-
>  include/linux/mmc/sdio_ids.h                 |  1 +
>  5 files changed, 66 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/wireless/st/cw1200/Kconfig b/drivers/net/wireles=
s/st/cw1200/Kconfig
> index 03575e9894bb..9404e318137c 100644
> --- a/drivers/net/wireless/st/cw1200/Kconfig
> +++ b/drivers/net/wireless/st/cw1200/Kconfig
> @@ -3,7 +3,8 @@ config CW1200
>         tristate "CW1200 WLAN support"
>         depends on MAC80211 && CFG80211
>         help
> -         This is a driver for the ST-E CW1100 & CW1200 WLAN chipsets.
> +         This is a driver for the ST-E CW1100 & CW1200 and the XRadio
> +         XR819 WLAN chipsets.
>           This option just enables the driver core, see below for
>           specific bus support.
>
> diff --git a/drivers/net/wireless/st/cw1200/cw1200_sdio.c b/drivers/net/w=
ireless/st/cw1200/cw1200_sdio.c
> index 2b6afe221268..3db937785cab 100644
> --- a/drivers/net/wireless/st/cw1200/cw1200_sdio.c
> +++ b/drivers/net/wireless/st/cw1200/cw1200_sdio.c
> @@ -35,6 +35,12 @@ static struct cw1200_platform_data_sdio sagrad_109x_ev=
k_platform_data =3D {
>         .sdd_file =3D "sdd_sagrad_1091_1098.bin",
>  };
>
> +/* XRadio XR819 modules, with a 24 MHz reference clock */
> +static const struct cw1200_platform_data_sdio xr819_platform_data =3D {
> +       .ref_clk =3D 24000,
> +       .have_5ghz =3D false,
> +};
> +
>  /* Allow platform data to be overridden */
>  static struct cw1200_platform_data_sdio *global_plat_data =3D &sagrad_10=
9x_evk_platform_data;
>
> @@ -51,6 +57,8 @@ struct hwbus_priv {
>
>  static const struct sdio_device_id cw1200_sdio_ids[] =3D {
>         { SDIO_DEVICE(SDIO_VENDOR_ID_STE, SDIO_DEVICE_ID_STE_CW1200) },
> +       { SDIO_DEVICE(SDIO_VENDOR_ID_STE, SDIO_DEVICE_ID_STE_XR819),
> +         .driver_data =3D (kernel_ulong_t)&xr819_platform_data },
>         { /* end: all zeroes */                 },
>  };
>  MODULE_DEVICE_TABLE(sdio, cw1200_sdio_ids);
> @@ -295,7 +303,10 @@ static int cw1200_sdio_probe(struct sdio_func *func,
>
>         func->card->quirks |=3D MMC_QUIRK_LENIENT_FN0;
>
> -       self->pdata =3D global_plat_data; /* FIXME */
> +       if (id->driver_data)
> +               self->pdata =3D (const void *)id->driver_data;
> +       else
> +               self->pdata =3D global_plat_data; /* FIXME */
>         self->func =3D func;
>         sdio_set_drvdata(func, self);
>         sdio_claim_host(func);
> diff --git a/drivers/net/wireless/st/cw1200/fwio.c b/drivers/net/wireless=
/st/cw1200/fwio.c
> index 1a68ef6ed2fa..6b885fd717db 100644
> --- a/drivers/net/wireless/st/cw1200/fwio.c
> +++ b/drivers/net/wireless/st/cw1200/fwio.c
> @@ -66,9 +66,10 @@ static const struct cw1200_chip cw1200_chips[] =3D {
>                 .firmware =3D FIRMWARE_CUT22,
>                 .sdd =3D SDD_FILE_22,
>         }, {
> -               .revision =3D CW1X60_HW_REV,
> -               .firmware =3D FIRMWARE_CW1X60,
> -               .sdd =3D SDD_FILE_CW1X60,
> +               .revision =3D CW1X60_HW_REV,      /* XRadio XR819 */
> +               .bootloader =3D BOOTLOADER_XR819,
> +               .firmware =3D FIRMWARE_XR819,
> +               .sdd =3D SDD_FILE_XR819,
>                 .sync_join =3D true,
>                 .no_switch_channel =3D true,
>         },
> @@ -85,6 +86,38 @@ static const struct cw1200_chip *cw1200_find_chip(int =
revision)
>         return NULL;
>  }
>
> +/* The bootloader is written word by word into the AHB memory */
> +static int cw1200_load_bootloader(struct cw1200_common *priv)
> +{
> +       const struct firmware *bootloader;
> +       const __le32 *data;
> +       u32 addr =3D 0x08000000;
> +       size_t i;
> +       int ret;
> +
> +       ret =3D request_firmware(&bootloader, priv->chip->bootloader, pri=
v->pdev);
> +       if (ret) {
> +               pr_err("Can't load bootloader file %s.\n", priv->chip->bo=
otloader);
> +               return ret;
> +       }
> +
> +       data =3D (const __le32 *)bootloader->data;
> +       for (i =3D 0; i < bootloader->size / 4; i++, addr +=3D 4) {
> +               ret =3D cw1200_reg_write_32(priv, ST90TDS_SRAM_BASE_ADDR_=
REG_ID,
> +                                         addr);
> +               if (!ret)
> +                       ret =3D cw1200_reg_write_32(priv, ST90TDS_AHB_DPO=
RT_REG_ID,
> +                                                 le32_to_cpu(data[i]));
> +               if (ret) {
> +                       pr_err("Can't write bootloader.\n");
> +                       break;
> +               }
> +       }
> +
> +       release_firmware(bootloader);
> +       return ret;
> +}
> +
>  static int cw1200_load_firmware_cw1200(struct cw1200_common *priv)
>  {
>         int ret, block, num_blocks;
> @@ -136,6 +169,12 @@ static int cw1200_load_firmware_cw1200(struct cw1200=
_common *priv)
>         if (!priv->sdd_path)
>                 priv->sdd_path =3D priv->chip->sdd;
>
> +       if (priv->chip->bootloader) {
> +               ret =3D cw1200_load_bootloader(priv);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         /* Initialize common registers */
>         APB_WRITE(DOWNLOAD_IMAGE_SIZE_REG, DOWNLOAD_ARE_YOU_HERE);
>         APB_WRITE(DOWNLOAD_PUT_REG, 0);
> @@ -143,9 +182,11 @@ static int cw1200_load_firmware_cw1200(struct cw1200=
_common *priv)
>         APB_WRITE(DOWNLOAD_STATUS_REG, DOWNLOAD_PENDING);
>         APB_WRITE(DOWNLOAD_FLAGS_REG, 0);
>
> -       /* Write the NOP Instruction */
> -       REG_WRITE(ST90TDS_SRAM_BASE_ADDR_REG_ID, 0xFFF20000);
> -       REG_WRITE(ST90TDS_AHB_DPORT_REG_ID, 0xEAFFFFFE);
> +       /* Write the NOP Instruction, unless the bootloader runs instead =
*/
> +       if (!priv->chip->bootloader) {
> +               REG_WRITE(ST90TDS_SRAM_BASE_ADDR_REG_ID, 0xFFF20000);
> +               REG_WRITE(ST90TDS_AHB_DPORT_REG_ID, 0xEAFFFFFE);
> +       }
>
>         /* Release CPU from RESET */
>         REG_READ(ST90TDS_CONFIG_REG_ID, val32);
> @@ -483,11 +524,6 @@ int cw1200_load_firmware(struct cw1200_common *priv)
>
>         switch (priv->hw_type)  {
>         case HIF_8601_SILICON:
> -               if (priv->hw_revision =3D=3D CW1X60_HW_REV) {
> -                       pr_err("Can't handle CW1160/1260 firmware load ye=
t.\n");
> -                       ret =3D -ENOTSUPP;
> -                       goto out;
> -               }
>                 ret =3D cw1200_load_firmware_cw1200(priv);
>                 break;
>         default:
> diff --git a/drivers/net/wireless/st/cw1200/fwio.h b/drivers/net/wireless=
/st/cw1200/fwio.h
> index 9925d4bcedda..fb66d564c304 100644
> --- a/drivers/net/wireless/st/cw1200/fwio.h
> +++ b/drivers/net/wireless/st/cw1200/fwio.h
> @@ -14,13 +14,13 @@
>  #ifndef FWIO_H_INCLUDED
>  #define FWIO_H_INCLUDED
>
> -#define BOOTLOADER_CW1X60       "boot_cw1x60.bin"
> -#define FIRMWARE_CW1X60                "wsm_cw1x60.bin"
> +#define BOOTLOADER_XR819       "xr819/boot_xr819.bin"
> +#define FIRMWARE_XR819         "xr819/fw_xr819.bin"
>  #define FIRMWARE_CUT22         "wsm_22.bin"
>  #define FIRMWARE_CUT20         "wsm_20.bin"
>  #define FIRMWARE_CUT11         "wsm_11.bin"
>  #define FIRMWARE_CUT10         "wsm_10.bin"
> -#define SDD_FILE_CW1X60                "sdd_cw1x60.bin"
> +#define SDD_FILE_XR819         "xr819/sdd_xr819.bin"
>  #define SDD_FILE_22            "sdd_22.bin"
>  #define SDD_FILE_20            "sdd_20.bin"
>  #define SDD_FILE_11            "sdd_11.bin"
> @@ -28,6 +28,7 @@
>
>  struct cw1200_chip {
>         int revision;
> +       const char *bootloader; /* NULL: write the NOP instruction */
>         const char *firmware;
>         const char *sdd;
>         bool sync_join;         /* no asynchronous join */
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index dfffda3d8002..35789be747a5 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -27,6 +27,7 @@
>
>  #define SDIO_VENDOR_ID_STE                     0x0020
>  #define SDIO_DEVICE_ID_STE_CW1200              0x2280
> +#define SDIO_DEVICE_ID_STE_XR819               0x2281
>
>  #define SDIO_VENDOR_ID_INTEL                   0x0089
>  #define SDIO_DEVICE_ID_INTEL_IWMC3200WIMAX     0x1402
> --
> 2.52.0
>
