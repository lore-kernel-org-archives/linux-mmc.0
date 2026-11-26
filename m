Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795710680;
	b=ycyNJ4EdrjLSL2XRTWUzMBQGqkTqLxiUY2F1HC+SL5VgojrBzq2KwZfSeMEE4nVx3MYe
	 MENV79A9jjc0ZDzWDleNcsA2O3wPclc7hsSNOWYT81gHIVcsLQlnzihEhbX2CPpoJapqJ
	 DvrkXol2GcRFS/r+mHQvEP5zhPI0FZCeNVRTiKNON8hDHaBSwUSL6HDbtdBkS7TR7hCCF
	 FT0HI2yRHvF4/7drL8Nc+u7wEtrhXmrzKKycqesC7YqqFUCnbSh3Zf5A1f7nMZ+wq4Hbd
	 9lFxbBqQ3eW63BaF2nMbpYfvPF8l3mlfTB7ORAMuxq7pgyUM7xlgoYycWJKcdWBmpiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710680;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=pmn0FtXxLKA2R9aU92JYzz/Y8uvInEGF5Y8VG+PgdjI=;
	b=VtsUZ1tSilNS7xq6iV6SbdKhEIhOAOGanXi2wc7XoDm8R/A4J2WV5H7yfIK6UuK4rdvE
	 3JvzN9SJeT1PR7nK5Iy4awF+EKMlj73WARBCu4pyY/7ZilJZ+ccOawRmMfwOfDclj8/qB
	 1Xhe6Xh6pM2wY2EoA6q2tW/KNyTYetFjHKZxL1VTPp8AO+6TJ6IARtmtPWxd4sLzLozEk
	 02Vu+pHgkwHnoldHqyzW+AlIo0IppAW1zb2T7WI4Owg8Qklw+ccTmmmLkD1OwO4R2U1B0
	 p67Mx65NIq2/KJiv6jCMaTmBP+ArZ7W8UGozc0fUyLp9Ibmgmp5Yu+lHgx4U2ua/Zfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WrIRQ8hL;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WfnLPKPa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2EA606A31C
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 16:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF2EA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WrIRQ8hL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WfnLPKPa
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQFu13D1847724
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 16:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pmn0FtXxLKA2R9aU92JYzz/Y8uvInEGF5Y8VG+PgdjI=; b=WrIRQ8hLwmS0resS
	ZYtDjIHPzb49P3KaZI9vVriH1FsCrR1nrfxdxDE5r7RM5gAveMkLoNsLyYPwlBTJ
	VaP9iYcw9YxkAl4EIbwvJyRkZ7na8pDLbLYJ9FHy0uGW+zda7zKX8HrGpPWh0yR2
	7Any2OJyaEse+cgAGPnwYxwP80q8z7jrsj2gjz34U3dyKLz9Kuly4iCf4j35COuY
	RuNZ901un8/HbtlI7aOEAE748xo1XN4MmfK5wdJjAEIaNlAIfabFDcaC8esiMT1n
	PkZNTV9VWv5VCla5x14iqMBCvWkt3yJ1vLhz06IdcewWAwgh9EoTzVgl361/z9xv
	5gBvkg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6fw7t1sb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 16:31:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2f033dc37cfso68336755ad.0
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 08:31:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795710678; cv=none;
        d=google.com; s=arc-20260327;
        b=dmZr0KGFh8lgkYl3N681FzsFGoNc1U9ATpNZM74jBZi7vjjGATBBpNfRJeTBU8BpG5
         l/Jfdn/2TKkYDBbA8paSIt6QvV9SwWJ5mt91THa8EMdv5E65pRbQi9PW3wTLzxPz6oYa
         yq3JXIzVQbsVGTXvJV/dJ2+l6sLiNcQTXVaAgCPM+dPHKxm2CXAIWf+cFAy133sDbdP2
         L6AeVu0BeJFKsJw+1SKBwlI6qYYhhkqswe5z6ZQh/d1U3f0D2zVjMiVvSeSjOr/AhGlZ
         6yYUfO63sHxDTruay0Ssb0XrVlAOd03K6IFgYUPeGUYr8am+49RBSW+qb0p8ZjHSCr+d
         FZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pmn0FtXxLKA2R9aU92JYzz/Y8uvInEGF5Y8VG+PgdjI=;
        fh=kzTrYs0Y51idDSxb9vFU22VIV6YVRmBC0UX/dYsF5Vk=;
        b=c9JPKBCazy9FVDugK5VKjeUeKOuBcesLSxWPt9k3e4O7Nb3qsr9EhzZ7RckAWfD2Yz
         Tqpwit7Gm7LJhtdxIA/C9adNUBwQNzPZdGo2wT1byaAV0Q9XdPS/Jo1VMlmwWE/IDi3V
         PMT2POcHCDqHq8BbWdlD/Ab+Np+eWWyv5Kv4GFUT0v9Y8iZPv8qSWgWNmdBUYbLA+eK0
         QdMNteSj7r2Oq/8ULB94j1923fEVIrs7ukxF8f8mDJLhVlx4+8+o0xTgEYC9C+CdGUuH
         4b0MPRZroz0g2tRVmO5RrpkppKtkYoLlkNPz/1Cu+ztltlljJdmjP+kXJRbRtxaoPrB9
         B9bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795710678; x=1796315478; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pmn0FtXxLKA2R9aU92JYzz/Y8uvInEGF5Y8VG+PgdjI=;
        b=WfnLPKPa7fL1N1l8DpZE5C9AGJMUeO2xb2xJukNt1p4LCP4pjPknJr1S+omK7okgC3
         jXSKjd9u3yS2Sfe4rAFd3G0ViGhWYDbf8OHMmL6ugODAyVfhPkFMSX7Tf27KTw959IBb
         /XuiDl6l0Taqs0a4eO7uuUwSBv8B5X+fM2hQZtuPSyp4uBBQeoYO+N3EkiAAa0SP+5AJ
         b2nWWl9eMNPLP3L3wSRM7MOsyN0pZqmg40Cj0R0tRtlMJ0SORu1d+BsVUkboe5OUSBDZ
         JDmHom1Vwreq/fk6+yPT06p7jlkgCbD64NQ9ZogNzOCnCpwdQraaze+ihgBLuUEgwIzo
         jDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710678; x=1796315478;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pmn0FtXxLKA2R9aU92JYzz/Y8uvInEGF5Y8VG+PgdjI=;
        b=Ddh6iDks1VJCta5jFbO41YzbPtARrzSM8Gu4xSw6xdYc0wCyOPzT67jSLTfngKbH/3
         9YlZcanG75/FAzclPHfIJE+EN/kvghGZzGhSpnKoIAZ0eszslNMs2lOgx0NgGoL85e+Y
         Cp4AUB/KrBThzdMRxKxpXdvHgxPEpdgO2PkmY3g2S9yNDXzSDvyn0pA001zcnW1qvjnw
         PgIWvjA8akkmQv8JGEBbkTk5gYIaMDkJ/Bmr4ChQjap2but4H0Ab3ng1pTCfBFDVXmxJ
         4FjfxTdMjvPg+V1G+3kU6Xlnq7EdSboE2rXPVJd0uGsYeF15fzAiauQmJDDmQjQhueoa
         uUqA==
X-Forwarded-Encrypted: i=1; AL+hErF2cFEMNfCDl8mH6PGKdmnaIbHXfF9Z1Ik9SoKkI9/NiJbsDjhYXzcDocXbVXjIDyBoEqf+Frcc+bE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UP9B0PnmJ7ZSZx+IcwXRzuFTUleC0q40VJ9AYhpxqcJsoUpNt
	rO/oUVc5JyKP3NxJSZxMg53KrEOkqP9uswvKjHSzQf/2mkSOxcYHztfxfPj90s/RiV1gZjO8KIt
	wg/GqHcUISELbqZy1MBaoe3pBFeJxm8HZTwBNpIh6JKt+VxEHLdm0rzKmT/wz/rktabProSYKjV
	30jAISxAG4xB0wuu/Ly0v3HTKp+4aozOnnMK+cjA==
X-Gm-Gg: AZFdTZevQQrs8FovkMmZ5AruR+YXF9P+m/iddbw9xeY7udORUepMHTbYkYbqy1WT7k4
	o3A/PiJYpmucRYf0W/yIop0DrbPLXWo//OmS6F6YA3ftKjru5BfkNi8GjdhuiszprcQ/E09x0L9
	IHODyGULG8YoIUMrAj/59nDQOsH7oScl6rijK1ChUHMePeaTTPE95OFs5DlQ==
X-Received: by 2002:a17:902:c443:b0:2e7:ff72:203f with SMTP id d9443c01a7336-2f03f1a52b5mr138232235ad.61.1795710677282;
        Thu, 26 Nov 2026 08:31:17 -0800 (PST)
X-Received: by 2002:a17:902:c443:b0:2e7:ff72:203f with SMTP id
 d9443c01a7336-2f03f1a52b5mr138231995ad.61.1795710676661; Thu, 26 Nov 2026
 08:31:16 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103185344752TLpWp9rb9fhJW6zaJT5TX@zte.com.cn>
In-Reply-To: <20261103185344752TLpWp9rb9fhJW6zaJT5TX@zte.com.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 17:31:04 +0100
X-Gm-Features: Aa3M54oMAs16SdpNYGtEr9578Sq-hyWptfNulukrcUuGONM4R1Hmxei-ZXSrmF4
Message-ID: <CAPx+jO8n=0mY7ASqA1Be-sVgsCw8ZaTf2F-Jne9hMHwmJCrvsA@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: check mmc_blk_get() in the sysfs callbacks
To: shao.mingyin@zte.com.cn
Cc: ulfh@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA2NCBTYWx0ZWRfX+wepsiEd5LGf
 88qAr9aPWrh4++/9FYeAWRPrKqyGHKyKp8wnNGcgoDlQsBH8Vzo+hnATwJvugVfVGu+FycpUggO
 NsBMWPGKfnpuImJAi5a4zXimEoKXt9Q=
X-Proofpoint-GUID: YKNaqumt4G4GrOxg_yF-yOa-rbZPLlF-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA2NCBTYWx0ZWRfXwAvUAyx5IW2d
 ssdCe/hAy+LwqMCEBflIf4tyS7FTb3gS5BrkAhzeOCDg9KYKMkV1RuAamp7DeKGe1qSp9b17p5q
 xBV0+WBAZQvgbAvRvFX5eDJQ5eyQkYJknH+mtcQ0XcswreMn1sHFfpb/hmJ/cAwB5Dy7DrebsTU
 xvcvbUgnuwmD8U7i1bAeiAeGLrGNEsRUd4tvDlWzsFBwrCspEqLdQTWRPcKQLkcmj4PDrKXUxvw
 2n0Kioa4hcxjl8tdtCVt/H8tLxj08eNwjkTn/OUuy4ps2X0uMH/upf+NlgsZql2qJHcLVCK1IZO
 HJyUBMMkK8saeIAm9pjPpGYrKnjo0xr60BDzvtdePye5dWNRjjybFB+nLqqxNHm2FxEyhbOUuco
 pyf2VvjjAWHuHosGUUB2koE5LKTzvjPaHteMfnVu9EXZznX0gnN+FnTNv1pOD5rQHGDl23noOzJ
 vRCRrPLsuyEZ1B5xfCg==
X-Proofpoint-ORIG-GUID: YKNaqumt4G4GrOxg_yF-yOa-rbZPLlF-
X-Authority-Analysis: v=2.4 cv=ePeGH3p1 c=1 sm=1 tr=0 ts=6b085ed6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=1RTuLK3dAAAA:8 a=yHZN7Se_Px891H_nw7kA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260064

On Tue, Nov 3, 2026 at 11:54=E2=80=AFAM <shao.mingyin@zte.com.cn> wrote:
>
> power_ro_lock_show(), power_ro_lock_store(), force_ro_show() and
> force_ro_store() dereference the result of mmc_blk_get() without checking
> it.  mmc_blk_get() uses kref_get_unless_zero() and returns NULL once
> mmc_blk_kref_release() has run; an already open sysfs attribute can still
> invoke these callbacks after del_gendisk(), for example.
>
> Other entry points in this file (mmc_blk_ioctl(),
> mmc_blk_alternative_gpt_sector()) already handle a NULL return.  Do the
> same here.

How did you reproduce this? Did you verify this on HW?

>
> Fixes: add710eaa886 ("mmc: boot partition ro lock support")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Kind regards
Uffe

> ---
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index a02bb2fee874..a1e942435575 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -235,9 +235,14 @@ static ssize_t power_ro_lock_show(struct device *dev=
,
>  {
>         int ret;
>         struct mmc_blk_data *md =3D mmc_blk_get(dev_to_disk(dev));
> -       struct mmc_card *card =3D md->queue.card;
> +       struct mmc_card *card;
>         int locked =3D 0;
>
> +       if (!md)
> +               return -EINVAL;
> +
> +       card =3D md->queue.card;
> +
>         if (card->ext_csd.boot_ro_lock & EXT_CSD_BOOT_WP_B_PERM_WP_EN)
>                 locked =3D 2;
>         else if (card->ext_csd.boot_ro_lock & EXT_CSD_BOOT_WP_B_PWR_WP_EN=
)
> @@ -266,6 +271,9 @@ static ssize_t power_ro_lock_store(struct device *dev=
,
>                 return count;
>
>         md =3D mmc_blk_get(dev_to_disk(dev));
> +       if (!md)
> +               return -EINVAL;
> +
>         mq =3D &md->queue;
>
>         /* Dispatch locking to the block layer */
> @@ -305,6 +313,9 @@ static ssize_t force_ro_show(struct device *dev, stru=
ct device_attribute *attr,
>         int ret;
>         struct mmc_blk_data *md =3D mmc_blk_get(dev_to_disk(dev));
>
> +       if (!md)
> +               return -EINVAL;
> +
>         ret =3D sysfs_emit(buf, "%d\n",
>                          get_disk_ro(dev_to_disk(dev)) ^
>                          md->read_only);
> @@ -319,6 +330,9 @@ static ssize_t force_ro_store(struct device *dev, str=
uct device_attribute *attr,
>         struct mmc_blk_data *md =3D mmc_blk_get(dev_to_disk(dev));
>         unsigned long set;
>
> +       if (!md)
> +               return -EINVAL;
> +
>         if (kstrtoul(buf, 0, &set)) {
>                 ret =3D -EINVAL;
>                 goto out;
