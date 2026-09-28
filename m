Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5B84EBAD4
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612071; cv=pass; b=ntLwBNDDBwS8MUd8VJyWqhFZJWN09M3Klxd9lZUxFlX5zfbDaKi9+7kNFlkZYi213OkBYoYny8aOpkw+95FVJYIociNACNVHypSijk4NHTiCECRFvU5fSXS+Je/c7/RKjp5yDcKqbgRgLBnuZyl2tuaxiRmYlcK+twAW6vj4ztw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612071; c=relaxed/simple;
	bh=t3ocf52Q+sxwlNU7sDw/sQsHiS3xPKtl9PS6SCcb/Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3RnAyYl5qHy1fzu88Dnk2SahaWNjWiVfAejPJ8NU7sMdWz/sx9aD9u/GWjZ5CXypI6bRkrrMHM5b+HDVBfbGArkEAGD92UJqAJuq77hAxIXJRrQ+hKLeM+1tCWhdiXnuGA82bPTbhmGXW2xEqZmeRPjvI+61cZCLsyISubkXLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VCoM/Hh0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=alVqXrYB; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VCoM/Hh0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="alVqXrYB"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEdvlC1908612
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d1J8s0RNGGUxlDL27PewBkTjSNKM2h2OxW2sl/yrvp8=; b=VCoM/Hh0XIxHSNNE
	FqanhQ/ehAyRBAk/KHM5nDfDJEQWGpi5OaQpEs1u82XBXTPZbVQmVgCZg0ESPV7h
	It7DC/lddQ0XmK2ZNxkARSYbPYurhsXNdZrYP5nO2E5NUHorONcGKW6qdPVHkS8V
	Fmyt5mkBPTOyPT9EjkdDVGZ7lXMYXPE/MtaZo/k/Uf8upY3oiykM9RJzsO8Pyhoo
	fPrJlibDJrga4nljh43zYB+HgN66Z18ZGad7PgMGhKjgh/pVY5orDFkqyMr50Heb
	pmK/EgJPB2eW/RKIHFz5IVBlebNFEan1HBmqxYuJAYmisOkNAyh3RoDro0xbqRYS
	pOBMqA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjkxjchx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:14:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39e3f521346so3526883a91.0
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 09:14:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612063; cv=none;
        d=google.com; s=arc-20260327;
        b=VJFQLQJxQk/CNPbMg+6OKZ0xEMezth/hjs7t04gguCB6DzxKKqHitkryW99zFvnGT/
         nJpE2S15WDKDlkiOaxRftvuOJgXSDA6qvCKPYWyjUiJaQf5TfChrAwmVEEk+sV9DqPcA
         z7JPLb/F0+yXq5aGWcXbepDp6rp/oQ1adqrnnmwk8OFdrYA1xNTWlOt7ICfiwLt/AhnI
         7gGr5zhuxmUpdPijmTPDQjz4HBNddwts7lSrz7kMGAlRX+SMKnrxvBjsmLohg2rAUzKR
         OJYKcIvb9pQz+kh/jVOJr0RmvqKZknqsLygeGN/8R2F2ZamTWuOsYhsiAH6uA1EqDpQ3
         Ah/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d1J8s0RNGGUxlDL27PewBkTjSNKM2h2OxW2sl/yrvp8=;
        fh=3cAj9kOmQkk5FTl3kmx7FXrIEAKK79IVizyLdGe5ScA=;
        b=jSiupTfDtG3MChVSHfPMHF/f3tV+EMkNHbk+BISbSIINqxQYgq/vMWP/JIbVViwO09
         Di5FErw9dT7B5k6lcmAonc9gX7FlkoslxC1c+UCm29n6IYzKHGvMBQS6o297Sl4LzwgL
         kU4gIwPRZKgfk+WHXqjwJGF9d7nWD/bpQz0xJu0Marl/YN1AnANvDxZHLMgEzbmf5R/8
         GFxNpGS45J7wSxD/PK7FnCftip//wOnjO8lwxY1Jh2zNbsSHzBGVOJLWlV/ZfslURuUr
         Mahbau3kzTQcOLExDeC1wzOlWqxShZvNac6wlorq0pNwPG6efwbSFA8FKI0oHa6LDfjL
         kXhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790612063; x=1791216863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d1J8s0RNGGUxlDL27PewBkTjSNKM2h2OxW2sl/yrvp8=;
        b=alVqXrYBeKxqxFRc1v5fCykxXGVRLQ+5G8LvgO65E5nnwERyY5qwE/svm/RJRMpkis
         fb05XucTzMsOtpluENfX5igvlnN9sWDQX3cMeyhkGVs1NGLptl/P8YascFbIL6EAdL9K
         yJJWYeALXjSVtGA18s3Rkhka55SjIFkQA3gykjgXXaTJYF8wG+8oicY8c/sHSdLoIdzy
         DFgEbEnmvj5jcIf1kQmR9OwvXIYenmec1wwK3rR9oU9myYIceRZqTuDTe9CTqxQJ8B+V
         POwj+74XBgIoIJka6+t9L5UyOov4dNthptbroU3gb+Guvc+n7o1nC+2mCTqk0onumBzJ
         Of7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612063; x=1791216863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d1J8s0RNGGUxlDL27PewBkTjSNKM2h2OxW2sl/yrvp8=;
        b=HO9mttFcp+GUM/WLHDrZKBp3XukpC6ZBrkcD19bcKwpFUVuwTdEBnBqrGvpLJU181S
         fyZzQEtziA4qq1ehMweOvqM2U3E98uyj25dWAkPCT1oMp0G05A3uIbGUWetawCWndKXR
         epcoV/3ZhLPkamOmmIxrdiVdWeJ0nu4iyh8ZoxKoK5p/4BA28nr8GHupcRE2CG7y+xfO
         blpyFs/+X4tKs//1MVUPJf6+j7ZY4PDXavWyUdxcGh3Xn9ItOwxVMrWVDTCZcm1OrS/U
         /lAe/e5ZwP13PqvtgqQIRQhT2tt7+GxsMOyXtwx5FkDCEC4ANFuKI1302vyhGkqZZFij
         2crw==
X-Forwarded-Encrypted: i=1; AKwUvBzPg795HZzq+Ij2b36MSumfQ7MyQ8ZinJ7ruLGkWXqqlTWXs8vl/Qx8woeRMHLynG9igLeOczJogJ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFK0y2SD1Tk8dhDp78N8dmudz+tJIluk77IJAaTI4daMB2yJ5G
	uS2Om+EPA0fYvCXgWJ5hdQG0l3ftP1RZrMtl2UU+bHtt8RRrDmMZcZsSzYwWTYkRDDYg8wNiR9O
	WPNS9ikfwBgEA9jVTYmyc0on5uyx9vP+kgcx9jDYk6KX7pdvXt/AxZzXNWHU9wriUgEnMOhKzB8
	7R7OCMVSfO0wQIVTgGeZM+PIqMEulwBHlFtCunfg==
X-Gm-Gg: AYBFou143j9DQDBW7JapZsITxC8Rzff5bdNQvLDru8he1uwUcTXWA5k1kiXfVGtT2KP
	x+bjC6QEU1fbaax/D2V3XqJZg39T3EaEt4vJBUggBbOUwd3oOH9RSh4PohfINZJgjq7AOUHmYoL
	X+6mZWl96f92oMz6ottXO2HL/q5gUDLtvjk5amQU+3tbCbAyYAxaxJFR42DQ==
X-Received: by 2002:a17:90b:3c8e:b0:3a0:dec0:c0d2 with SMTP id 98e67ed59e1d1-3a0dec0d44cmr6443422a91.63.1790612063115;
        Mon, 28 Sep 2026 09:14:23 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8e:b0:3a0:dec0:c0d2 with SMTP id
 98e67ed59e1d1-3a0dec0d44cmr6441541a91.63.1790612015533; Mon, 28 Sep 2026
 09:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915161947.2479111-1-lgs201920130244@gmail.com>
In-Reply-To: <20260915161947.2479111-1-lgs201920130244@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:13:21 +0200
X-Gm-Features: AclHuK-rCSkbx6ET_8ztVCrCgQ1IFSY-9oEQLK62J2Ir0H3NwcNF5BRthCX7OXw
Message-ID: <CAPx+jO_1wuE-zTxQB+-k-yKTzFfpLMGwvae3mKnG7v-ocB8b2w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sprd: disable runtime PM on remove
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: EB_pSUGEqhiUnLcAFE4G2OFLjz6IgXjH
X-Proofpoint-ORIG-GUID: EB_pSUGEqhiUnLcAFE4G2OFLjz6IgXjH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfXx/4/dLEE3hRN
 j4fCYlEjI6oVL0N3ct73fF92wFlTP8D898vmEyWsUqKekbDfnw/pn32RAs/QMoVPJO0TRV9R/MP
 i37Cc8V/LMPeY/X5YdRzK/vxB/AhqKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX/B+lWZcutFmz
 qf2WiBV0mmfQjKx9UFhqUitodwWF/5YZh5l5OjpXIqZU5V2GHGD85pGuufdZn/9akLPDM26YcSF
 KTpMK5bxxDR4u8Fc1FLKAy47hhUJYqcyneBLtwk9i91XsbT9VCCvdhvQi3OGaVD+w1/WXFrLoah
 pkH0W55uhoGSCLczd4pWYaYFrZKz4qQrBc2BYSKnRY/Ywq5WXYSjROy88Nq4EvAS+jfXw9MxBow
 g4uY/rz/6XX5VU/KxPhqGYsPxUpZSeMm9tS+RKXgQaT/p0Du11pS99XJCCDGbR+tWe/FGh39Hr0
 w/rLUqAhzLXEC8xQEjz4gHH3vXM6Y8o4G8uAUAV9/D4ErYyiNXE0aB72XaFZ3VyIaLjif0WS8Az
 VjnFKl28Roc70skEokNnxX30kshP7ZniQOS9xib0qibXQfif+Fq9I0GFy2Y3JmcUkAynQPJ/Fb2
 QnSx1FTh7kic4s6Q8WA==
X-Authority-Analysis: v=2.4 cv=QZfzLcbv c=1 sm=1 tr=0 ts=6aba9260 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=ntNj6TDCI3ddbZwZ8hEA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280064

On Tue, Sep 15, 2026 at 6:31=E2=80=AFPM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> sdhci_sprd_probe() enables runtime PM, while sdhci_sprd_remove() does
> not perform the corresponding runtime PM cleanup.
>
> The probe failure path disables runtime PM before disabling the clocks,
> but the normal remove path directly disables clocks that are also
> managed by the runtime PM callbacks. If the device is runtime
> suspended, those clocks may already be disabled.
>
> Resume the device before removal, disable runtime PM and drop the
> temporary runtime PM reference before disabling the clocks.
>
> This issue was found by manual code inspection.
>
> Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host cont=
roller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-sprd.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.=
c
> index 3584a2b314a9..0c8f389fe584 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -890,6 +890,10 @@ static void sdhci_sprd_remove(struct platform_device=
 *pdev)
>         struct sdhci_host *host =3D platform_get_drvdata(pdev);
>         struct sdhci_sprd_host *sprd_host =3D TO_SPRD_HOST(host);
>
> +       pm_runtime_get_sync(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
> +
>         sdhci_remove_host(host, 0);
>
>         clk_disable_unprepare(sprd_host->clk_sdio);
> --
> 2.43.0
>
