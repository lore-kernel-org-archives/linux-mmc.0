Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EE93A9D94
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352784; cv=pass; b=OfTlm1kVNrp/h3U9fh3JmkCbtuWfTtqAQwG0uLnkeiqbwBvLnEbt/AmK3lgiUGHECutlm2pTpA/Qre8pnWZyMnpSygVUq4lAQRXCiCzZ6cH8wChEosES82D3uGyVhw4EKLVaf1SYmJn/5u0dhhAizL0ZlpYXbRk3elnCzdcCeIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352784; c=relaxed/simple;
	bh=RdTxmvt6M6SbFNolujjOPkNEbDkpG02Lh7u2mtV6T0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBsHOiqXeG51oHOSkmGTdV4oFMAB3sZJzu+X08/b//vd/rnfrbo34w9vpJsoZbcCL3SATUh3B4cUZKRpNQsLfysYoJOU+02AEvq/p4tcWMqg4nQY0UoCs435UM3sWiZo4BP9ktagKqRx/iXrz8EJ9MeCzKK2cYl74JJnU3/Tx+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bSjtcDDV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QTy6kPEe; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bSjtcDDV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QTy6kPEe"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF16H980532
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k8q/VwpMDoHXIOM80kKew7t7j7EJF5A2rIUUimBPlS4=; b=bSjtcDDVGtje1jx3
	kI+d2m0vRxPPpVhtd4+UL3c4JWPEqKYZfQKkCs+mMhkafZ2ukodEu/rzEIUPSc1A
	nZgoqTc7qIQNbzkMnrmEMSF+3oi20Zi5qAfy5GZAXsprLiFJtd7oQWjjFst0Bd+F
	2bku39JGaJzm/9lzUYYE426Dobogsoa1bs2jX5S6QPrADnlkmKoGkrKUrzSFHdXv
	7L/Zo2svGzpULFzHSt6/5ftxWyaAj0yr6V4Tfcg2Z2+wi3EwwdJjT17Qg9IeXiEn
	d5qZ2EG6kGKo4vH2d3239OppHKJB4nUMvvIIuzDzGqcbPrxVjGwbzqs+JBNSOXIF
	BATjRw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgsqye-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:46:22 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9693878131dso2976161241.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352781; cv=none;
        d=google.com; s=arc-20260327;
        b=hpmm8G5B0FfmMsRPk7ZA5csRa0zXgYQwfXEnL4v8Q8YgONtXeYk/eO/tKEjse+2wcQ
         YgWJym25O97hVjbrsEQblFWdN/PlIr5eqFX7i8FI2GMRDs4qECD+jKzGOwSqY50li5ru
         O2CJX/y2515hMVJREI/eON/D96PYZQG++sdgJmbsopTSpHeot8jhm0UKVUWu6wrLe5mG
         5+cnNT5k3UB1yXbtpSx+1mhoMiR/ldaIWFw77bIfTPhXz2OkTSb0ne9nbOqkJdrdZleX
         Xaoss3Ql2vOni/UAF4BMQiXKFE95coi3Z67TCrh386rLT8U0Vma6v4V+z0N2gocILnil
         20Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k8q/VwpMDoHXIOM80kKew7t7j7EJF5A2rIUUimBPlS4=;
        fh=aajazjKg8ns9C/3sN3t3AlSotHQ/obbPbPCHh3OUdpk=;
        b=JsxX+08xav6smiQdEje0nqur4GMMyTCqd9rDAXG9Ty2N0F0IYtZlrejUmuC81H4lfi
         r0DrWddzf1HvSbqZpcnPzL/xaWzB14Na9dRxCwzYG6UwZU6rtL+iesrlwDJ24DpVvW4n
         1ZZMcS+wothq1/GtcwwYGFl/ezHSekTyrmf1eDvW9S8QCidAc1889jkGdkor9kbhmpyQ
         jyLFRaerfuZC4KJMhG12fNCiU900I9PDHFlL4jQa+l3+26ZG9Gq9qGqrtz2IWACVLWte
         k5EpHe+5dFCdf2tqfPDTG1tu/lVSajjf9emEYBqgou9bZSIW387dIJxh0uvt7rC5lA56
         Vsmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352781; x=1783957581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8q/VwpMDoHXIOM80kKew7t7j7EJF5A2rIUUimBPlS4=;
        b=QTy6kPEe3MycdlGdGAd1EnUm3W9iNWf965EroSdwSUL4I+E75PRhdqF2ZkErE6yI5Q
         KqIe0fTFdmr9zxEuTPZ0X/KMFq7EHca9exu4lONpchySSqUc8sABn54d7daDmhBuGYzv
         EvywHSwHNXtFeVTfZelAb14ttfQ8dmZi3GLyAVrT6lD1aM/gNd3E28TQytyZQJfKfJCI
         29LOMRoC7pgWPavQ43M+SceyC6wMEgwBWCN5PaGTsNvXEJyJVnRiLpIPtMWsT+x/lItn
         PLpnm9nc7OTeeLHFZGlFLvh1uFTlBESoKkWRugGNGtyE9pmA2UOgIJCd91aHFN+ZBiXn
         /4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352781; x=1783957581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k8q/VwpMDoHXIOM80kKew7t7j7EJF5A2rIUUimBPlS4=;
        b=EA8n+vs+nSE2+8NJUUyGfROdplJPLmVaCMQt3o/DqqlQAjLPI8iEAs5J3vMGCER5dC
         1McE/IFCfaRBSouHBpPKe4RF48AuOMs8fkW1oaGopSIixq69G2kv/TmwJFLg1BJ6PMTU
         rhR9u0zABJ5ddrnG/t3wF8D4kAmq/NAWdYdpDNMdENETSDXzsO7+64MKrlU2y8JWsdAW
         b+TjAio5QVhQH/tzzrW+RtqPooCJGA9wGbOlU3G0++2TaZ8eXgTsDssdMtyL5rIn3fcO
         GTHLE9ttytN9Rj+Glm0qinLS2ygl5bKIFJSPTZURfKAbH5hw4hbwxrtyv1NRAlCpbMdI
         m2bQ==
X-Forwarded-Encrypted: i=1; AHgh+RqvFD/NcabNffKM4x0yJY50iyqVDmjJNTmxVkfs5aCEmjXhS0rpmXiXey9mZ1bnBehxmRQ5A969Rg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv59yK+/18IEdal5uqbHCNaRaiD/LqAVMSTNLEvKHd5ICyhO3i
	UEbu+Hw+c6DZiMzJWNfp5Op8swOV3Gyx+mPoT+Iv9BcKYPNEOGnTTpa/Or6mZQOufx6QPzGv1u+
	e7j9FxH4cgzHdfzTJt7J7nZCXktKKCnahT31BCtcDqmEc2kZR4l9y8ocLlTQla6+XtWhuX/Tsrk
	CRoNwTA+KKJ71TeTOYqud+x9StI6eOSr76o5Pg4w==
X-Gm-Gg: AfdE7cnbZYJz8APfjss4WFygkPOpOxqnxowcxqk6QOqZvsfYJcnua6kl3rwPXpmPxs3
	puQCNTqs25jGt/R0Crudu3clacb2+BDOY38JO/etP3OHH/uYwasAgdNQWQSeO/bci29NozfUfG+
	/0cMibKWsjH1pxNCY+7n5C4lVwxJMwQYegvG6txlBHDr3PUmi1e7rSgEKTmNTqw7G41L/C
X-Received: by 2002:a05:6102:611b:10b0:738:f5fe:3c42 with SMTP id ada2fe7eead31-73f645849bbmr4366599137.9.1783352781405;
        Mon, 06 Jul 2026 08:46:21 -0700 (PDT)
X-Received: by 2002:a05:6102:611b:10b0:738:f5fe:3c42 with SMTP id
 ada2fe7eead31-73f645849bbmr4366569137.9.1783352781002; Mon, 06 Jul 2026
 08:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dd3aa530-d06f-4733-ba5a-ccc95d8fa91a@auroraos.dev>
In-Reply-To: <dd3aa530-d06f-4733-ba5a-ccc95d8fa91a@auroraos.dev>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:46:10 +0200
X-Gm-Features: AVVi8Cdr2zL_mEapWUcrkRepE_4_rAa8rt_igjBNURaSW1_AYoKCTSW8oGWGjCI
Message-ID: <CAPx+jO_MxS_qetj1nf_u_AGx63X+2-oZ+no_x769JgLqJirB+A@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-of-dwcmshc: check bus clock enable result
 in the probe() method
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-mmc@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: t0M5iZBFK91D3ZvM-7mHTOh7xNU5XYzY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX+WzAAf5Wu0Lq
 r2JPDeDty2LG6X7PtwyDEJ/fbn0H2PjIXTGrjTEtoR7nNfY+JyGRZRHJKK0QkF8AgDPFnZHHMGq
 5nAwIrAmobj7PeRjrS/YEnH0sU9HxZfaEUAIQy/0tkbgB1/8lKj4PmyDPBdXEpiw4EnBZN0hctI
 tT8GJax9znR8iLnnqp6kJhxrFzH+P8F4R9VYUT9f0/cbFlQT9pNDQaAjRyFYmV2E8faRNKMBQIY
 uiNMgvBSUqZMZdKOJ4UHTElyPjZzXFn98L1Euunjfix8FHGlGzLNuJQk3dnnmce7szo68GdtSA6
 1gYoknZZJsOyfGbSwMGWHdOltKAj2hWztE9ztlomiJNH2i29OIlCSSIXK4Q3/lflUDtihql8fOw
 fYb4fw5/YM0fP3LjH1pVasr2UntSYv8n5W1K/2YnI4XS8FNoiTLVfr4RER1RovG08+8g7p9Dr2M
 bHjxZX6EXuPtL+TdJCA==
X-Proofpoint-ORIG-GUID: t0M5iZBFK91D3ZvM-7mHTOh7xNU5XYzY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfXztKBaPE0ZOEy
 mWgvChe7VWjRUbBFCd2+PzGY2VOZvvgW8hzE+9GB/r1oFySDAyWM1tOroW6c8KOy79ccjV79AD1
 Y/ma4FOqzpfDEJA/4AnlawRO4INeTYA=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4bcdce cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=HH5vDtPzAAAA:8 a=g6UdFJjC8Am4eBbHc6AA:9
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060160

On Mon, Jun 1, 2026 at 4:49=E2=80=AFPM Sergey Shtylyov <s.shtylyov@auroraos=
.dev> wrote:
>
> In the driver's probe() method, clk_disable_unprepare() for the bus clock
> is called on the error path even if the prior clk_prepare_enable() call h=
as
> failed (and the same thing happens in the remove() method as well) -- tha=
t
> would cause the prepare/enable counter imbalance.  Also, the same problem
> can happen in the driver's suspend() method; note that the resume() metho=
d
> does check the clk_prepare_enable()'s result -- let's be consistent and d=
o
> that in probe() method as well.  BTW, I don't know for sure what does the
> bus clock control -- if it affects the register accesses, the driver will
> likely cause (e.g. on ARM) a kernel oops if it fails to prepare/enable th=
e
> bus clock in the probe() method...
>
> Found by Linux Verification Center (linuxtesting.org) with the Svace stat=
ic
> analysis tool.
>
> Fixes: e438cf49b305 ("mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MS=
HC driver")
> Fixes: bccce2ec7790 ("mmc: sdhci-of-dwcmshc: add suspend/resume support")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


>
> ---
> This patch is against the fixes branch of Ulf Hansson's mmc.git repo.
>
> Changes in version 3:
> - dropped stray comma in the subject;
> - dropped unneeded word in the description.
>
> Changes in version 2:
> - mentioned the problem in the remove() method as well, somewhat rephrase=
d
>   the patch description.
>
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci=
-of-dwcmshc.c
> index b9ecd91f44ad..29af07561a86 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -2441,13 +2441,16 @@ static int dwcmshc_probe(struct platform_device *=
pdev)
>                         return err;
>
>                 priv->bus_clk =3D devm_clk_get(dev, "bus");
> -               if (!IS_ERR(priv->bus_clk))
> -                       clk_prepare_enable(priv->bus_clk);
> +               if (!IS_ERR(priv->bus_clk)) {
> +                       err =3D clk_prepare_enable(priv->bus_clk);
> +                       if (err)
> +                               goto err_clk;
> +               }
>         }
>
>         err =3D mmc_of_parse(host->mmc);
>         if (err)
> -               goto err_clk;
> +               goto err_bus_clk;
>
>         sdhci_get_of_property(pdev);
>
> @@ -2461,7 +2464,7 @@ static int dwcmshc_probe(struct platform_device *pd=
ev)
>         if (pltfm_data->init) {
>                 err =3D pltfm_data->init(&pdev->dev, host, priv);
>                 if (err)
> -                       goto err_clk;
> +                       goto err_bus_clk;
>         }
>
>  #ifdef CONFIG_ACPI
> @@ -2507,9 +2510,10 @@ static int dwcmshc_probe(struct platform_device *p=
dev)
>  err_rpm:
>         pm_runtime_disable(dev);
>         pm_runtime_put_noidle(dev);
> +err_bus_clk:
> +       clk_disable_unprepare(priv->bus_clk);
>  err_clk:
>         clk_disable_unprepare(pltfm_host->clk);
> -       clk_disable_unprepare(priv->bus_clk);
>         clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks=
);
>         return err;
>  }
> --
> 2.54.0
