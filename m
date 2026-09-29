Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0DF529414
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688861; cv=pass; b=DeYeD5gtGeD3s56/ogp4XoLq8ESVWADH7FkG4z+ALQB9+yizomvaKdCcH3WUZOASbONr2tXVvhjcT0SPsPXZuaZZUADYgWkizU9phyGxB3bTCAsq/GG7dCX+eRGaGMQZ4q/ATYsZ2n4OIj86d64wLMZKKfWako3bNIKT5hxlTcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688861; c=relaxed/simple;
	bh=2OGmFXG3DYZMwvydYyaIZVCI+BOxnZH5aX8XIP2ecRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knqDFZVJO961nwRJJkQ6NRhp6HQFJNpLahTVsF7KtBdGnqq+TGGfB55KEfEsebLHJuNof/z3QE/HXbnm5pJXvnZhzc2Aok1mzv+n9+M3eOCuycRVSku6YuQqF5hL8RqSWdptIt31m3L9AZma6rTNmgoV7He5ZdlaLGXeVeKLt5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ox6yFBmt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jkZ+M+Tu; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ox6yFBmt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jkZ+M+Tu"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqd1R3936711
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VpweFa/y4KpsyGFUqUTnYjBFWiL1204+HXtmP/jH5gA=; b=Ox6yFBmto9tA1+LL
	zMpN6oxaVCVDUr2Bfe3jGL+LhjwkEkg/nrhb+LElc0F3EPJtCoaimGO+6DS5VGdL
	S4wkl4cpPIOrao5d4XrCzj62xQvN64cQaH3r1HRsjP+pI6HTusemtCqw0/P2ok6p
	AZpoNTaRJbPANh81SCKkqX7iPlUdugAUUhNnbxrlK4XxqCda3D01/dNSMbFgSzaO
	KmUVjtzpqA4LSjXvK0XuiEvI/6dbP7iEAPOCSFZMMh1KFyHSCVQlKHalHXNH2Grf
	Lc8fVmY9gkdqCX8jgfoRml9xn0lyVipI5Z2ewS/Z5BAk/EQrN7NzVaaEADg8hxWN
	vECdhg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0bn1grc8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:19 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc51591102fso2976451a12.1
        for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 06:34:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790688859; cv=none;
        d=google.com; s=arc-20260327;
        b=Z+NcTejkFIN9fQi1rk6QA90+AWBfVW9blScTEO/r8AlDrxPAaQRnBLE62a9cCp0LK9
         Tg2v39KQ3ZX4c9KW0TuqjFZGF9eLpYejMRtKPmJHRkFiko6zXj9P6SyQlDAGXxjRnDT+
         6pLBqlIiNu75ciXE3L3aU0i6mHWiN2iHJcZvJ8bcpkqU/9zc1s0fKxrz79nmPNvBWToC
         jdn+0VRzPQxklj9YUR0s0BbDpietxy3NKd3tvXCDcDnv3VFeWR2m436xfyX1I7DPhXkY
         w2zRTStAeY8X1lLtjzzqMmhl8B+HGa/ek8DU2B5cXk8IAORUWBXIXZCu/vtk2vFdrEUU
         rdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VpweFa/y4KpsyGFUqUTnYjBFWiL1204+HXtmP/jH5gA=;
        fh=c/BgPjOgGZPW/5KNIC8fdEBnVWda4v01KxevhE+nZiQ=;
        b=qtHk4p68JdN+3Lm6L3BzSM04kCwWsNJ1ghSsjUAkyWK2lhuvL15996nir9b7869uDi
         ALBs6WbdSOveYVgLFpHtKMVmescGeKbWzZaySkany2GP5PFKFY0q9tC0RgIGzL3o+1HD
         dRWGZSLuszJHj86KadY6ETlcqgs3cEtBRtSxpwtqi4okp44Uc4SufP7Rf7bqy9bBlJI1
         LmyLLk5lWE/GQnv7sjf0ilZ6feJoLjE9XoVf8dbpBkhYjp5BCLrI+uxFEgG2b66OFGW2
         r3EC7Pi903+6/l2/peHVNNI9IEpkA1pHc7LQCDaD2qMDLRWKaD/OydmXADp5b2eBDmje
         ex7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790688859; x=1791293659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VpweFa/y4KpsyGFUqUTnYjBFWiL1204+HXtmP/jH5gA=;
        b=jkZ+M+TubF1iuZfbGtgVqKW/yN5VUTAQm1wyoCzy1DoJUTCc9Y0EnHj2c0g0dHm9Uo
         Axqcw+9GLofC2f5q3Szijb6y8RTQ6d6WQfBnw6y9AxNy6r6Bc8l4xyqNsVuPfQK6MkPH
         L3Oj9H/aFQEc9QtsiKJiw/Fqz/op6hjj52E+lIlOSvtBRICbc/QRy2AcmKHhZdpF0ySC
         pQayUIZmXe7AYlqA1K+gtXEacHlBjUNTn938Nzu7HTI20hrkujfbjIIN5lZhaXynb+b0
         JygtYImSIkjz6vX8GsCXqYvp/7V5C+SfsyAeo6J0BFsqifMxQ3c9Zvh3pY3xXQNGmXr+
         45rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688859; x=1791293659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VpweFa/y4KpsyGFUqUTnYjBFWiL1204+HXtmP/jH5gA=;
        b=pWI+q7FujIUf/jgJSRcePxg9SVj2cajrWkXg39R1esyWvG/t/6935NMau6y814CXAZ
         0CWSA8F5Rg7rl3lfzBUra5EZe/pYyF73VvRpOIyaJgRDbCWxZAxaSf7T3sOygJlrQS0W
         P6OKUfQYffi6YgQW+zV3wE4igZD3LtO1e234OOrNzw6YYvSZL9r/AOon6O+7xcSqJRG5
         s45HDmZIB+tkKg9x5pz7CQmgptqz8hrNaz2+X8R5GAWWPx+O6SnQ3+otEislaTSGXLtU
         0rcsQ1Mxry7alsM3U9zaPwPzM+9XEm0BphuiTntWz/5p8fSBkRLVzpEvyCvy/kVhh9yA
         4N3A==
X-Forwarded-Encrypted: i=1; AKwUvByNUQGu2uu8lai5NtpZ/5LNX9hAzVo3EY9gWYZyMbY+MnWJxBsvkjTWYbZUkfzO+txx3YF17/w80ko=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8qua0SWmnNyEGBorqWeUJfzHVUOUdMC9/0IE/f47HbAp+M1Q+
	Cg8zZWIRVPNjBauKgJKK4jiC2JtUAmHcYnd+JHnjRD8hkZK5tzke4S7GwK//psiMUWVkAEzsYYL
	d9/o9U46J2DTXG/LelcCcAaDy4BHum4IAP8dKQ+n163qguPhPs88gHlBTXbBMmma/bEg3hiPQCG
	2p8kPU5nU/x9MqSJC/caKOawEPpQvWVoWgp3u7KA==
X-Gm-Gg: AYBFou2mYrlnSGln1mNLoxN6PimphsODHYN2wQzqBvT5br5g/H0nTyErK7SrXsulauy
	VNxp6fFLwfWS7WcOUfRe9pM9fn2ruxYrkoh91A+5Z1HnKE1lEpqAKr67H+ykuHVfCoBnx9u2MdY
	uRFOEFEcxoNCvrTnWabyzyYSOdcUSPRSbZg3wmN5qymM3mwFrkuW4F4Lzoxw==
X-Received: by 2002:a17:90b:28cc:b0:3a0:d440:7950 with SMTP id 98e67ed59e1d1-3a0d440b3f7mr9299653a91.4.1790688858955;
        Tue, 29 Sep 2026 06:34:18 -0700 (PDT)
X-Received: by 2002:a17:90b:28cc:b0:3a0:d440:7950 with SMTP id
 98e67ed59e1d1-3a0d440b3f7mr9299622a91.4.1790688858468; Tue, 29 Sep 2026
 06:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917111336.1102829-1-alperyasinak1@gmail.com>
In-Reply-To: <20260917111336.1102829-1-alperyasinak1@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 15:34:06 +0200
X-Gm-Features: AclHuK8eT5S6imaBC1PAf2Y5yvpSSam3RXN2sFQd-suCh7u0vJNhiizYX9a4FNE
Message-ID: <CAPx+jO8UePACt0+s-Kv_zWVJh-jRLX_uNH7XYRDhJoRaS52U6A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Replace deprecated PCI functions
To: Alper Ak <alperyasinak1@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX+mlmZjy46MRt
 LYr0WFSluKfYpezm7znD1dDar12Haql54Uc3jjdZh8WqKhbQqk+RnJNwZhvxeaUdLszv3a4kaRd
 LPHbGOGh3YvMh9MS3g8VqUHAjqbXDAU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX++8BXEsjMxo6
 +YG2peLUfC+Drdsk83Z7CERiaHRGnhu2G/jXOUJwCMq8o+/RI4F1LjARAM5rnpnPwnb0gfsl1q6
 qzdlErScwYekfXh5+jdbQs8CeyqWJuu4JWXwouPKiDnxDks1wmXTiymRArrbIS19cJ7iTNM9sF6
 DA6KxqX3kTI1BP2SlZZClKlMosdzvGOgZcf7SgX1+WlPAiMFOcmmzDfJ1uP2SgkoM6GrnvzO6Fe
 GKVhTEbbEOE/5oI1y57bcajSzuUIm76ZpIxrE5DmrwKhkY4+H46N0fsfpJy30YmVy3BtAwXjgrk
 NPFDxE7/eN6oOM4cjLUpzAN3uk58K0Xpigkx56fXRx0MGzQAs9Fb2l+seeL5110A5Vt9QPocM9W
 VGwmfaojLKHH4Xg/XfgkT67aR6oxKjE+LfnAnG4buArGG9mlC0gEAKl2ylcSmeZ2rgabh1Cbmg8
 xKeZAEgp/NAnVCK1+nA==
X-Authority-Analysis: v=2.4 cv=JMiuIMKb c=1 sm=1 tr=0 ts=6abbbe5b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8 a=M4mkxfSRnu0DQSwdiYgA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: 0b50RLCnivaEWm0wbu37ZhvxOFHje10G
X-Proofpoint-GUID: 0b50RLCnivaEWm0wbu37ZhvxOFHje10G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290054

On Thu, Sep 17, 2026 at 1:13=E2=80=AFPM Alper Ak <alperyasinak1@gmail.com> =
wrote:
>
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated.
> Replace them with pcim_iomap_region(), which requests and maps a single
> BAR and returns the mapping directly.
>
> pcim_iomap_region() returns an IOMEM_ERR_PTR() on failure, so check the
> result with IS_ERR() and propagate the error with ERR_CAST().
>
> Signed-off-by: Alper Ak <alperyasinak1@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-p=
ci-core.c
> index b121d896a804..a9000f3bd419 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -2170,14 +2170,12 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slo=
t(
>
>         host->irq =3D pdev->irq;
>
> -       ret =3D pcim_iomap_regions(pdev, BIT(bar), mmc_hostname(host->mmc=
));
> -       if (ret) {
> +       host->ioaddr =3D pcim_iomap_region(pdev, bar, mmc_hostname(host->=
mmc));
> +       if (IS_ERR(host->ioaddr)) {
>                 dev_err(&pdev->dev, "cannot request region\n");
> -               return ERR_PTR(ret);
> +               return ERR_CAST(host->ioaddr);
>         }
>
> -       host->ioaddr =3D pcim_iomap_table(pdev)[bar];
> -
>         if (chip->fixes && chip->fixes->probe_slot) {
>                 ret =3D chip->fixes->probe_slot(slot);
>                 if (ret)
> --
> 2.43.0
>
