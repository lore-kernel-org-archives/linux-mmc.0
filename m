Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE41346FA4
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165422; cv=pass; b=eRq+6FqeoicoJOA6mTm8f6I4AUlIJ4E68otHRYYbg916qqsDwdYEzoCCY51AhJfx+jiXodgD4GeXB+dwJGgD+rPlRScw1rHDpUCxMgTL4hQGe4+azb3Bm5ypb76gDUlzujyX3BJWqDqWiigMuaz6taDutI0U7V+Df+yWCQP9f7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165422; c=relaxed/simple;
	bh=upcAxlK/pJxiGNOpFfkmTSfZpXzLTLC4M8zkiBNmxDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHkrFG+3osvQm5EdOucMknr8DMx0SrCJqPcSWZMNGwnq4tb047Ng9DvDOYHkec8St37SkB8icZYJn1k6G1QQ0aRqPTOrYV9J34MwEx8ktkicBxZcMpjqOV9R5L3PdXaYAq4fAjfrW4XyAN9VNp/R64VR84VckCLEVT+SxKEQmuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NmgdLGJ9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LpX9QJVl; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NmgdLGJ9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LpX9QJVl"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlfWU033188
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 15:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TsB+fBvryEs98glnklrZSnP8jIeujXx+Rk85PKBUBk8=; b=NmgdLGJ9KzuC+ka6
	HPlQzhUJ8doQmfSL4SgBBlkJBMNzucRQyPUocC0K4uufu2yaEP/ZmbWnuL+qbZzU
	Tv+KQE0oKCCURQHJKmGjK0WhkBMZ2GgyE8415jQAAKLiN2BeGothQP1U4M7+Jafu
	MBRQ0SbxxXFjC7BYwWQirbquq2TA9HA+DIYmIzKpsDmxwD+E7Ww4scMMd4LlzshC
	e9jKiFwIwKNEMcAaHtQh2rF0uIWdcVT8Mgh4ZIktbVngPIce8EA3htVKPx+M5Ma4
	cCYpRRRehTOEJMb1l6ZDK9p2X0vr3Z0kij7ZUbX38hBGlxtzt8FX7mDBC36i08+a
	Tg5cWg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4c61gf3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 15:16:59 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8f08560ea44so39141526d6.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 08:16:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785165418; cv=none;
        d=google.com; s=arc-20260327;
        b=ZbMUtFgb8sQqWLaLcsR1R6+mrWtZaeVMleVX9Fv9Szwkuw9wZZsSeZopVKvwkej3Iw
         9NTQ0GBtzjGiaynbDAM2gScvYvpvEl58uLQ0NGZRgY+gQ8oBYGF18d1YhTJMCjAPgqoQ
         guzO7+T5GcZ5H6uHge000BZgguMMN+J9+M1958IY6FdpPAx8UYcETlJp4gENvWN8ABvE
         MOPYwU1BjPTHnkl/SPLaf2BblZaTv/AcbwflGp7u3uwhbqORcpj+vXwuOEi+puumPvQU
         1VW626v/WqzgR8Lru/iWV7Nxi4PnaC/xLAVaEpEx9GIWN8tA2PrOkqwhLIdX7AuqnBbK
         tizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TsB+fBvryEs98glnklrZSnP8jIeujXx+Rk85PKBUBk8=;
        fh=hxf+F5dd/+X78hwcYi10X/6rIoqRLxIn0k9/Aj26z4A=;
        b=YjP8IyqTujoiNTc+JP+QwFUAhbtaqonPh21Oxo6uTlj/az3JNsr6mgXefddAPhqIc3
         k5jiFu7AeU/DRd8ohIJXx6F/V9IzDoDldJapWeQHXogXU9dKcn2Q5fEpur9KY4hufaFl
         sfSczpodKxw5LDvgo3T3q+9QCe5SySNB5br9T+m+snsd1wgdMDPGugPi/e9B/zFb68oR
         4RLRV+hvovqCTBYpmIpsHUDkOshwRN1jGdyesCYgyq29d12rJV6IOh/SPapvSGH39mJY
         3KsUtn10elwm0QAdE04917WS6tEsdoojZq/LXHcxB3+icViM8EzO9//HckgT+GoV8iuR
         9G4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785165418; x=1785770218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TsB+fBvryEs98glnklrZSnP8jIeujXx+Rk85PKBUBk8=;
        b=LpX9QJVl7RisoCVOgWXSyDg/UhfyYZ2HZ5CrdOY+TvWAtywlkqL4J7JJNdjRgT5KHt
         YvmfaHzGpD6+x6mGN+OL1vD9W1uiXq4bcfzlfR31/Sp5dWNLCQTne+YeDG7+mJ2pQIyM
         3bwwud4kntiPjjQJDPBPlWD9H3PF8Fl7ZlaXxo01guvL6gOmVoNnkyYXJ9SPZZ+hXbRu
         vGwjlvxHSjxjN/AW0i8Sy3AT1bevQ+husHzcbRaJQMI/AXmrrWqaliLAAQZQuLKYDx60
         1Slc/9ZzvhxW3FW+3nTBdpxiCuPB1IiWBaEOlsD6UlppfgiTuhKISvyb3K0D+0pYtQ9l
         3TCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785165418; x=1785770218;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsB+fBvryEs98glnklrZSnP8jIeujXx+Rk85PKBUBk8=;
        b=iaEpf7au1bLWaxDZ+mjDaF97sxUFbfAb0yoB3V7mo/gkVygeUQyieD4vn56W0+YUGt
         iF4lcasZHjtJunlLlc1ngMgufKR2nKjRazfBsSVw9ibLNEp3MSUeEf8V4nHYlXrR991Z
         lqKJX5VYkCTK9c0ZQ7YoZ9j56S0GKO4hJYoRHHzRMmM4CwF2FoF0V0vmpaCnhp2pvEzq
         tAymT9AgL2GU+LJdlyPlUpEQpQFEayuQVd3XddXmv5/CsF9uUUHYcXqJesy7pxHS76R2
         tblO6y+u4hJ5Ghp/fglNwqmVYqPLKNTGXMMNQp2pucbFSyQAbVfClWzOcMNYUNraKqo9
         npsw==
X-Forwarded-Encrypted: i=1; AHgh+RqdO6+zOzcmJbaVoGuunBVSp91+g46BWE+neNgjjWeN99d/V0dTmJFPiAF4EYN20B6zfdaGvfhVJg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0JeEbCuoGF6M65YoTIO3iBQ6vnt2Q62poLZ/vYzTH3nVxxWZp
	Z9SH6gKRb9XUUl3CkdfzXupyWxa/CxCVUfShoDJWzW79A7qn81ir/CoMHmBtMgyp6i0daLw8CUz
	K+UZM9lcEBrBpXcqmvrijtJXw14oM+rUeJkTEo3eT2og3d/HkwWGLz05njFT1yDurArv9nvtwj+
	4EchQm+lXtfZnAN4DcwA9NhvqZTRn2uX4wAyo1sw==
X-Gm-Gg: AR+sD124Cvoi3xCX9LMZcqLtopceyJmQhQFgz/yZLKJYWoWpA+cJyvahtqrKXAkF1lA
	sjlVSdjiG4aaAalrJ/XPJ3496k4MXCblmp8uhuM/jDvR0RcgfUvSLVPSedBbGUk9d5s37hJ3d4a
	cfERLB6ELK86nw2IGsbMedZlOLc/Rmd3vlIEybkArfCQZ73+3l7U5YXwir/w==
X-Received: by 2002:a05:620a:4101:b0:932:e030:dd26 with SMTP id af79cd13be357-932e030dd67mr898068085a.8.1785165418441;
        Mon, 27 Jul 2026 08:16:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4101:b0:932:e030:dd26 with SMTP id
 af79cd13be357-932e030dd67mr898064285a.8.1785165417981; Mon, 27 Jul 2026
 08:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722205701.372789-1-jm@ti.com> <20260722205701.372789-4-jm@ti.com>
In-Reply-To: <20260722205701.372789-4-jm@ti.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 17:16:46 +0200
X-Gm-Features: AUfX_mzbZaUBnQEX06GqMrpHJi7Vn1gpbWl7sEjT3spkw5OUl0dS0c-9S2d03G0
Message-ID: <CAPx+jO9w0utg5BhsKnUSgdCWeM1prOqoV0gCrTpaeuaWZouXoA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: core: Add power-off-delay-us support
To: Judith Mendez <jm@ti.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=eYQNubEH c=1 sm=1 tr=0 ts=6a67766b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=sozttTNsAAAA:8 a=4A_6DvDk7c3mpj7IUuEA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0NCBTYWx0ZWRfX99olWeR7xtck
 tPF03cuKAJyC7hY3Ic62zgM9/kySZBpuy2srSTnjwaU4rjXUeL7L0Esu+Z/acA58H5cYPrzvgCW
 TiJAyb4DFmj/rYQYquykcEwMXHCoLko=
X-Proofpoint-ORIG-GUID: zx3NWQbUsRpsts-LGeLWaprPGSvDwwEw
X-Proofpoint-GUID: zx3NWQbUsRpsts-LGeLWaprPGSvDwwEw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0NCBTYWx0ZWRfX1vS07SoSvb3k
 8oGJ8kTprsLPYSLGYP0jWwZD56+KVrMblhU5c1b5vx7o4DaOxe525voPag18gf75uqS1G/kj1EM
 42IeHyr4avYcYtkKDKowwVC6jwkqrnEbUfd9aIpo+J6mnZe2b/hkuX9XKDQ/yD/QGMFsrwZN3z2
 ZN1fculQj2z4i4p/Xmb/zCwp/crDuojWr4ofmkO5knybMeOtneXzoIO5MbLpNE5cbYG7w8DPsW5
 tCuhRZnOF12JpL7D78pJQUi9FC4M2EB3fshZPNZlKfMoBGISG+JP9ggmsoSwLV4xTcyQEY3Wikx
 uZNC9Kco5DHF5SjaES0M3Jel22+rAdewvNFbNrARwpdwfceKO0aKEIVL908Bm7Ib4ZwIGCT8BTR
 nn3VOe8H2iCBRUFgeR719Ydd8tWgEzFWCRBraHvCjJM4wca2HwwSxR46CTZPK/o2Xi6MCdzCJnB
 h5lwlwN4Zm5hbTL+Y4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270144

On Wed, Jul 22, 2026 at 10:57=E2=80=AFPM Judith Mendez <jm@ti.com> wrote:
>
> Add support for power-off-delay-us which shall be used to specify
> value of delay after deasserting power during MMC power cycles.
> Default for delay is 1000us but custom delay can be passed in to work
> around hardware issues such as slow RC discharge on MMC VDD rails.
>
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
> Changes since v1:
> - Move delay to mmc_power_off
> - Fix dt checks and remove print
> - Move from mmc_host struct to mmc_ios struct
> - Rename post-power-off-delay-ms to power_off_delay_us
> ---
>  drivers/mmc/core/core.c  | 2 +-
>  drivers/mmc/core/host.c  | 8 ++++++++
>  include/linux/mmc/host.h | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 29e80e5f928e9..9472041fe1c20 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1388,7 +1388,7 @@ void mmc_power_off(struct mmc_host *host)
>          * XO-1.5, require a short delay after poweroff before the card
>          * can be successfully turned on again.
>          */
> -       mmc_delay(1);
> +       mmc_delay_us(host->ios.power_off_delay_us);
>  }
>
>  void mmc_power_cycle(struct mmc_host *host, u32 ocr)
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index b7ce3137d4529..fac50a2860211 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -421,6 +421,13 @@ int mmc_of_parse(struct mmc_host *host)
>         device_property_read_u32(dev, "post-power-on-delay-ms",
>                                  &host->ios.power_delay_ms);
>
> +       device_property_read_u32(dev, "power-off-delay-us",
> +                                &host->ios.power_off_delay_us);
> +       if (host->ios.power_off_delay_us < 1)
> +               host->ios.power_off_delay_us =3D 1000;

If power-off-delay-us is specified and the value >=3D 0, I think we can
respect it as is.

This means we need to treat "0" a bit special and bail out in mmc_delay_us(=
).

> +       if (host->ios.power_off_delay_us > 10000000)
> +               host->ios.power_off_delay_us =3D 10000000;
> +
>         return mmc_pwrseq_alloc(host);
>  }
>
> @@ -574,6 +581,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct dev=
ice *dev)
>
>         host->fixed_drv_type =3D -EINVAL;
>         host->ios.power_delay_ms =3D 10;
> +       host->ios.power_off_delay_us =3D 1000;
>         host->ios.power_mode =3D MMC_POWER_UNDEFINED;
>
>         return host;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ba84f02c2a101..714417466707c 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -23,6 +23,7 @@ struct mmc_ios {
>         unsigned int    clock;                  /* clock rate */
>         unsigned short  vdd;
>         unsigned int    power_delay_ms;         /* waiting for stable pow=
er */
> +       unsigned int    power_off_delay_us;     /* waiting for power disc=
harge */
>
>  /* vdd stores the bit number of the selected voltage range from below. *=
/
>
> --
> 2.54.0
>

Kind regards
Uffe
