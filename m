Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62FC421880
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065931; cv=pass; b=h03BfV/WiXarrx72L39ZsR+kohMZEvtnziCYdSTIm5Uwd0T8dkNOcQ+gNIwCjOooNFYlkZiAzg9IKRFRHwcOgsWwj/UlO1zJNfkSDc5pGLo/4hNIxpRaeVbr2CWwSe8TO0by1JbDf48CVb67MJkobiTXRrirMAJjYcXBjvAZXOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065931; c=relaxed/simple;
	bh=aLmVyTbbokJlIA32OiWi6aEAVMRfnovKhpMwXE5kl8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3aFthObkI7XMEc2wy+k1slsPijzbLMm5WaRpVpSkzYKj0Lwom0tcUQyRt1KBc45dSVj+vwJokozh2Q1+NB7Kyp0vE/+qkEvOXddGPQWw2ty6Pt2bwe7cfllCi6uStlNjnif4Iu7CvfyNjOcVsgZVf3ODXq0FuTOcoJb4LTHAdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U0OzdDUW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kG0+0+oT; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U0OzdDUW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kG0+0+oT"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDL0S63568446
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zSUUezal5+9H1n/iZviE5ODffDw1AS5Kql6lgnKC34g=; b=U0OzdDUWGctaX4gv
	/kNb8CyxhdfOqGBWckwE8jpdKEUnU42cu2AiYQQmOofC4w9x0vb4WOzSXSf3CwoQ
	4lKCifd8nITTuiVcPH1G3RtqhTwxfeqcIJhLyoIJBbezoowyZKoge9Czyd7/wkuz
	vJy0n11cwoOZ50u7X+Z5A2R+uLM1kfDvPFOEk/t/CaXsV6himby+ngwBKTQ61VrZ
	YxQwgjdTmoi6Wp+CfXYGc5bZia1/JUKCA6AdfoZzG04zo4ZdzASOiVzVx83pIynv
	BJpaqWz1yPLMlTH/y6Wi5RmQwXFvGiDKrkj5LQItWsxkLEaRBacn/7b07pRAbxfi
	RYTysQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eevumv14q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:29 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8b1f39c5827so287015526d6.1
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 07:45:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780065929; cv=none;
        d=google.com; s=arc-20240605;
        b=HZylvqhpvhD3DOGWhFdA2zxIn25BEStu3uz5z9iejYyk9Afdzt/SIFlFeQh/HKX3fM
         m52do07J/zwm3YTEihlZKcBJM06l7uEg0Uk1fhxLXc2kWx4uZ5FY19iiGuP+Ah2Bx+6K
         MegGut/jPVc4+AY+aDaMuiSncHeXetlDnUYQGxtAgny3z9a5EPp6ZW29XY2PBfg7MMKe
         xtLrN8wv9/Z5fe7OspUHsmVWhL43Ccob1XZ7YHgGNqFXJIibIN7UVU9h6iNx2IV6zDC7
         47vWrqy6NXJynKKEjyHb2xoFQhAFyfH+Fv0HtWc0fHFRn3Zhrw+KLYXH+cfJWX8g8UpZ
         wnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zSUUezal5+9H1n/iZviE5ODffDw1AS5Kql6lgnKC34g=;
        fh=zHb7hEE+RM67NHMhUe4v7ZG872FFnRF4HUBHxyNUY6E=;
        b=GQri9oQuF/Sf9LRBxSgT7jdq4BBBlsaGpzQtetAig+tnUV2+GGPwd2nPaXCecxkxKB
         mAumNbSuMVzI23VIjJv3Sp+yf/SqBq/W4YDc1hzwiLnim3u4y7ZImER3WQeVZtY6BrfP
         oHlaUQ/1+lj8jjbnKsYHtG66eIexjhJGR7FAVhgyb/sfRr3bhMq6OC/PjMi8hgR0J4I3
         5LnPV5JjjnQCBJqgEagEI26/WKfnNvRBP3V2gO4NrEz3In+UVNpKitYKwG5TTzsCkmof
         2uqQgXeS+tNXyAGtwGRgeuDwbrWmPQFsF20qCtTJjA3mwZecOpGI29nCnVUb3kpI3S3g
         4/Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065929; x=1780670729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSUUezal5+9H1n/iZviE5ODffDw1AS5Kql6lgnKC34g=;
        b=kG0+0+oTNzGoRYNGHG3ejuvrRBC2xH2LMX/Yuyo4aTkblvCbdBp9shCWrMOvN+7utH
         XvEkSmts5tQk8dJ2DGgOz3WKp8cgxMTLGcJMpNKm0SnXbgD13BonnjRzQsHpd/CtVhR9
         mhiy1v+vvhhKXXCsGqWirqRNjOlQJD0e5bB2srMQBaK6UEUESrkjYMY1hNIilsZCtvPT
         yheTyC5vp8sMybqy7LffrMFTEBtxbyOXXI7WK5g3rNpLg0RDJj43xOWnt2fHjhI/6fUI
         qxscXi6JaK1HMPF3jTEuYPC8j2tigIOd8JNB7vrgaRQGKpMIAFOrJh/GN+l/ZF8RNk2x
         yXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065929; x=1780670729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zSUUezal5+9H1n/iZviE5ODffDw1AS5Kql6lgnKC34g=;
        b=rVxY6xPpXFrQX4iTVaUVmZMdifUWEYX2MJM84pzfcmxN4N8Ln84Zv7mliX0bp25TfZ
         uiEugjWBerQg3BQyTVRqpHIN6rko6+Pt8UOND8mZMQcNdE9zPxxgAuhfvbb8XtPY2CN4
         rZPd5umlOCUZ0c1j+nlFoexIn1raC6Muq39dmM7rNVcH6cH2a8O0exQ++Rjk7avmG1eS
         R8l8QtMvwR63UEUbR5BaueyGntSnwNV5VjndGZoXC9aRHmmHwaN7PGUu7oDLCL3o9poV
         HrbQnF5TMtPXWpDCzvPwLxqn/wWE92T/TpP9XifEcIPfVLccvAHu+MpflWlFM74V0/CL
         qy4w==
X-Forwarded-Encrypted: i=1; AFNElJ/gFYFHogerpr0jXvHvTu0ZLxeaQz7O0jPeSqOwpXW6YmNtz/gOuuUp+G4JIl3l6rVIkilcZCBHhw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzV/NDpXtFbgwjBdel3Y4Ad3J/IRa0w1Wxcoa5AJLb32CzRlLP
	o+hua259tfmnqzniE79kullV7UO1pjL88J1qOryn5ukvWUESQ+6gjam8QleWtROvQDYnm6z0Z/M
	B8rADIwIUN8URxvuohTyqEh9331MsghrLK17d0Z+AMAqXAnebeAdlT1DvmoBirIabQZuYoDak4w
	HhQcmacuDHWzv7mxthPKa4CbgVaK5Y2O+n+eEwmg==
X-Gm-Gg: Acq92OFnswW4RksG/OxH9LuYhpxcZK2tuANmHy1MZnzZItL641bmzYYzzoJz2BgTHDO
	qVBrmxZiXSstw8AdmT6R+tSRTfdlLTO0E7LMg8wS+IfOPohsYwLeMr4u9Hw4XqbNLbLSYkgpljJ
	zR7dYUNya/89SW6JI8FYUkkUiBRcyOqUs4b6kfTS9B+IltosyT7eZNBPofC6/GZARbutpbvLAh8
	2mITlT5ff+9ooscDA==
X-Received: by 2002:ad4:5bae:0:b0:8cc:cdc1:fe97 with SMTP id 6a1803df08f44-8cce7fb7c61mr48294656d6.19.1780065925311;
        Fri, 29 May 2026 07:45:25 -0700 (PDT)
X-Received: by 2002:ad4:5bae:0:b0:8cc:cdc1:fe97 with SMTP id
 6a1803df08f44-8cce7fb7c61mr48287326d6.19.1780065921223; Fri, 29 May 2026
 07:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510162941.704940-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260510162941.704940-1-osama.abdelkader@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:45:10 +0200
X-Gm-Features: AVHnY4KvBM0-jstLuD2rWaHz5YKLaXLm3XFsHQrtHmTC08CZ0T7vGmQxSPEPbx0
Message-ID: <CAPx+jO9mkbtVoVqjU8q4PJMz-Mtx8EMEd=jL00=7BkZjJsjvaA@mail.gmail.com>
Subject: Re: [PATCH] mmc: davinci: fix mmc_add_host order in probe
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: bartosz.golaszewski@oss.qualcomm.com, Ulf Hansson <ulfh@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Colin Ian King <colin.i.king@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 2qldFjaQ1ZwijbdjMpxSXTnoFmJsuAwt
X-Proofpoint-ORIG-GUID: 2qldFjaQ1ZwijbdjMpxSXTnoFmJsuAwt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NyBTYWx0ZWRfX+GcE2Bh0XS2M
 4+HUo1ZsrXH7Ha+/hnM11MXrivmkrWIuodP/lQLuzDIJAMabd2/rxxWiy7d5yvSOpzPzxC1gU0A
 Cxu7SBt3ZeegOjqQF6V0iakxCnbOqOFkbCn9NDi8Q7S2T3v8kX/FH5G7NV3FgfDMmrGaJiN9Yc2
 4ctf/cI1UmR0WYA/1pyeylga6yJGe083pRpDgAVPF2DBwAt68jploCgAzvYtK4WVFIoFG2OI3eO
 q1sswEp/83eR6R/IrOg5UB43pWOqRmwYab0r0YteaXjBKhPWQ0vy725yyGzKWw9RtqoQmf9gsQ6
 Cee64JLx4bp0YMiUK+9WdgMFkg5e6q4WHSYu2qHjf+j4lijh6FBYr/21sTOkUxwNUjutrMgHJ+W
 tonW/rqce/MDO9jDkZ3sUuVTe19fBcgaLlFgDN2IxAiscwu9Bd+qh7t5UmeJVi3O3JQ6lsb7QmV
 wOnZPMSV7cL5GcE+jVw==
X-Authority-Analysis: v=2.4 cv=cObQdFeN c=1 sm=1 tr=0 ts=6a19a689 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8 a=LEW1qelFR1SCUj1V6F0A:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290147

On Sun, May 10, 2026 at 6:29=E2=80=AFPM Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> mmc_add_host() makes the host visible to the MMC core. Register the
> interrupt handlers and advertise MMC_CAP_SDIO_IRQ before that, so the
> core cannot start using the host before IRQ handling is set up.
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mm=
c.c
> index 42b0118a45a8..a598febe7332 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1294,14 +1294,10 @@ static int davinci_mmcsd_probe(struct platform_de=
vice *pdev)
>                 goto cpu_freq_fail;
>         }
>
> -       ret =3D mmc_add_host(mmc);
> -       if (ret < 0)
> -               goto mmc_add_host_fail;
> -
>         ret =3D devm_request_irq(&pdev->dev, irq, mmc_davinci_irq, 0,
>                                mmc_hostname(mmc), host);
>         if (ret)
> -               goto request_irq_fail;
> +               goto mmc_add_host_fail;
>
>         if (host->sdio_irq >=3D 0) {
>                 ret =3D devm_request_irq(&pdev->dev, host->sdio_irq,
> @@ -1311,6 +1307,10 @@ static int davinci_mmcsd_probe(struct platform_dev=
ice *pdev)
>                         mmc->caps |=3D MMC_CAP_SDIO_IRQ;
>         }
>
> +       ret =3D mmc_add_host(mmc);
> +       if (ret < 0)
> +               goto mmc_add_host_fail;
> +
>         rename_region(mem, mmc_hostname(mmc));
>
>         if (mmc->caps & MMC_CAP_8_BIT_DATA)
> @@ -1324,8 +1324,6 @@ static int davinci_mmcsd_probe(struct platform_devi=
ce *pdev)
>
>         return 0;
>
> -request_irq_fail:
> -       mmc_remove_host(mmc);
>  mmc_add_host_fail:
>         mmc_davinci_cpufreq_deregister(host);
>  cpu_freq_fail:
> --
> 2.43.0
