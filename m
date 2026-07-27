Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D30422535
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169520; cv=pass; b=MYZ3j0pTKtI+Ns/g/+PVRt5el8o8v4O/yJuckiKcPzad93p6d+nrlBq1hmrfZfqmrBtBSI4SQiX2LjjWBd7ASmtol1saMU4oRB51oWy7nORsqO3fv9jcaIua/BEK12PsldLZcAGakMxxtgAQL/Z+G1yQCxPcNsDhNxLFEkCOYcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169520; c=relaxed/simple;
	bh=2sXXeOUTecGSlpRBlbqBWd3+w2nqQ7YS/Yst5f7bBcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ak6fHzDR8UiL1upRfz8pmLEdEB1SMcO7qWprNllXlwZYyFLsquZgahdx/JbH+dl1v4+soxcUHhIyI3HCf6mrX6qit7fzyudV3zZ6d3igY0e8vaeqYVi1/+G3tkqAOZzVV5jmvVqGn4bnE9Tx0JvsyMfrYGPGMWPXn4R/1rAIfCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W4y4XUCb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g2VwSPTx; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W4y4XUCb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g2VwSPTx"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDm9813823643
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 16:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dUpg5WJhVxRendPtKKb3JFNO3eljQXcRqiJSSpYHIDU=; b=W4y4XUCb914pBl0W
	UtvBTl+uJxKS7M45I2ewjQReQe0ifjVZi9mrSmztJifisNXzFa93XfiYvbfXNeEA
	Tp+bGBrd3vxeEp+vAFthKTwHCFxa+kXYEPP3HzNr9EItAyytaSZTfYAPdzS9Dda9
	oe1TtzCauYfKcfF5sXHLxYN/coQqVfnd58gM7CLDFRBt0pFfvnUARvzs5KoWS28B
	PYbg5n22w5KV72IJ7XhL2E5NWyXvmyH4nZ+88KYKTFckSkh6k5A1brrcwo+6jMXA
	8N5E2wL8f2L407LGUPSMqQFHoZj5trGgW2BadOAUhV38owlpWj3xgrMjwpGmEEeY
	1vO1Cg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4nbsscd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 16:25:17 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ec45d9628aso61671836d6.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 09:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785169517; cv=none;
        d=google.com; s=arc-20260327;
        b=MZELI1KA6teaVY4rVFBxvr4lmfkc/Qqjkgr/+Wekl4fD3BHmfRsEbZzWn6uVK2wUVG
         f28BxhFScwmmD6YYv3a8mXb2lczErzn32uAUV2vDMMini33+QIq/3+zXOTFutLR7K0HK
         Jevljiu+/oTmG0Z2rXSgYSq+8/36o74cZnlG079rgWuXQOF8amnn67WNIwNabazpRDU/
         7+ACeAux1Wl9jkpl4+om1EUpG8sJ/lQVWkY4nAGpnU7n5jWezoC22M93DX51f5EgQiLr
         VYAAVXiuOiZChyd8XiNJj8eFC4pqR1gtLPXJMYWauNktqaZxUTUdmEW2IZgkndS3U2rl
         EFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dUpg5WJhVxRendPtKKb3JFNO3eljQXcRqiJSSpYHIDU=;
        fh=vi+Re5fnyxeJLTSV9ss+FesyUZAo1oWQ+V+7/8C13gQ=;
        b=Rr7doZeSrB1fHkTEDDsVuiSA5UYYxzhjikkhvrx4jqgDLXhdGQckXnqc15tUr+YAIx
         JQLjiImRPlWF6GqF35zG8gnAGIvue5wf8RJhHimHij7Z5YKWl3+x/o/zS3Bdg/qQacHX
         GdEkSmxb7uumDPShXzZXequblVzxVRONIAHljl2BWxgBn5B2WwCcVvtw3SbC7wpfiPqH
         81GUANb1SPZylMIae7qosll3YfnYacOp54Dr47ZpEd57zV+j7To2rh85WwaT4mnDteXr
         h6UHnCgTmmrNTQuZf3vHo78odmBefzdxUVv5CkZRnK8Mrgi0iHLK8rYqPaus3eGDM3Dl
         MAfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785169517; x=1785774317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dUpg5WJhVxRendPtKKb3JFNO3eljQXcRqiJSSpYHIDU=;
        b=g2VwSPTxlFkcXHRz+y7jiS5bbkdDMRBu6GSOj3TpiCDXbJgQBjTFC15Ny59lzTDR0h
         FOpDWCPp9LYjs4pOXTH3qfHq0AQBIPqmt+gPD4IR62FOLZFx8XHAZHb5I9n1qorUqSV9
         blsItjj4ZDBx6lB7q+ds0EUVgXC78Lz37pal6rID4C0AuNpqY5TkgHUyPFzzDhdgbNkh
         fTnnIBV/tKbGeBClwmHbQHnPxN1tORxKGGaji5PvasYENJ3kvWFfgZYomDWTOsLDtJg/
         sFWV4ZeLRAdvMEbcbtyaycTf2Qzn2qm2UkwgHJw4PPNZJbq8xlnGTTmYdkHa+HnUm8i2
         Liww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169517; x=1785774317;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dUpg5WJhVxRendPtKKb3JFNO3eljQXcRqiJSSpYHIDU=;
        b=S94V1HCbqYe9ryC8Hjx3Vfi+2N0VJDHlZWGVUXfe+a1RiB1G7v2bA63141omBJ/qjf
         QQ/pNm/oPq9hpwKZOhW7Kvypnjdz6/GNLCwvjXCoJTanD9nc8muAo4cmcAAMQydXtphb
         1X2aU6+3ORQ53qzoe1zo5FN9yfoFfeGLIZUgzyPvysvlbF4yFoRQj/AvDKOY8nP/60b5
         Uj/8t1udbvvEtA9gueiG/uEnbelMys1tK+MR+9Punu+sglA4V2wmQSSEyU8YL1pgXG7G
         vyLpEyQwmYFlShspjqdITvt9K/NN0gj496wz0UzIsPiMDxD4kBTUiemJt1Mlb3JPMzgc
         Gvdg==
X-Gm-Message-State: AOJu0YzF28IelhvV6ujI3ZDR9VNHRB94pkBrAqmdzLvfaNSGzWp9q246
	Aeb812vQiYP3GAosddbpzIlfbHan0AWcPfjCUdAA6fulASD1Zc8fP0AnMdJiu7qD0a5tfZcOCoT
	1OOUxuiVEMgNzKc13lgfnFzOlCGK1lsFTlepEpGsVe9B0FhWBeh3sEA08yH9dvGeL7SOXHsUMfU
	fl9QEMr2ZB7ebijv7AH+SpGZmmY9tyg9O7g4SsQA==
X-Gm-Gg: AR+sD10yazyCFl//jo8tTY5KkzMTPA99iBG2SWLKWj9HSDROXlL8zk4PzOPFtozx0/9
	/XBoPdls4HSbrnKiuOAfMzJF2VVLk0VMUlJo2nGQHE82P5D+R1rseBuIhEGGCRh7N62dHShhOnS
	0qDu67aFtXl2bP/dPNBTFJWSw+w52pIIs7Wdk/HyLXqKqQr3kfrjb5eHbMNA==
X-Received: by 2002:a05:6214:e69:b0:8fd:6dc5:946 with SMTP id 6a1803df08f44-907ec8ae409mr114279676d6.59.1785169516637;
        Mon, 27 Jul 2026 09:25:16 -0700 (PDT)
X-Received: by 2002:a05:6214:e69:b0:8fd:6dc5:946 with SMTP id
 6a1803df08f44-907ec8ae409mr114279356d6.59.1785169516256; Mon, 27 Jul 2026
 09:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722204643.502879-1-rosenp@gmail.com>
In-Reply-To: <20260722204643.502879-1-rosenp@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 18:25:05 +0200
X-Gm-Features: AUfX_mwIlILr2rkiwKFRHTdkwkW_WPdmrj8v9YFucTPbonDZhHT9qNMkK66JGCA
Message-ID: <CAPx+jO_1g00otxNP+CfFxbr2qjbH08RB3FFOU3=WnyEQC=G4sw@mail.gmail.com>
Subject: Re: [PATCH] mmc: moxart: use platform helpers for resource and IRQ
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 4h1UQtvoGUqwSGIRYW1MR1OhLWTukJDE
X-Authority-Analysis: v=2.4 cv=cJjQdFeN c=1 sm=1 tr=0 ts=6a67866d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8 a=3grdSASEes32PKoHFTkA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1MiBTYWx0ZWRfX/RJEUR+uLd7g
 ZGLOF1ohxjOOfZzaGm6gyzWVffQuBrm/2t7kEY9B6QbfZLnTKjX1fj0QCr8ZvYD/8mMzNH0xpYj
 Nr/lliZST6dRCsVt+VKal7AgVckLFOQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1MiBTYWx0ZWRfX0xPC1OGUy6/2
 rGM9a6cRA57CNAB0GZt/lWoTYrym5Y59jv1d8Kl1HIIFT0bE09dDgJ9MZGpevH1CnKDB3jwJYV8
 q0dJbh8L6WdYwBf1GPB8H2qnpL6n9DngsBRn7EyxrxMEszd3Vh2ZGm8PvZlAS17Hwz/9NzfQHMi
 I19uwq0p15dYEX+Zv6UnTlXBzTbP9rvFDruvRIwgamx1OzD4bcDa/QjMPe30vhqdlxT99linezz
 p6Uap+dLdWb70a+IUcPPvpCoSOs8NMdRstZ+xYL/uj/ASw68EGteBkfa+p0fi7sjA9mB+hjrktU
 maQ8eAeoWbDZP4yfnuKU+7AEcKOkTyHaVFs2xD6JCaUPgrwn0P2fdErpleS2DAoc3+aUNo6rC0s
 OGZrB0pcf2U1MIyMrKtbbdBqrUwEUj33trVyMSa4BxoQIMImXcVBoCvowkqJlugnuH6TSWZK34j
 HDszfWE4WhQOmP1Caxw==
X-Proofpoint-GUID: 4h1UQtvoGUqwSGIRYW1MR1OhLWTukJDE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270152

On Wed, Jul 22, 2026 at 10:46=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> Replace of_address_to_resource() and the following devm_ioremap_resource(=
)
> with a single devm_platform_get_and_ioremap_resource() call in
> moxart_probe(). This requests the register region and maps it once, which
> is equivalent to the previous devm_ioremap_resource() behavior, and drops
> the now-redundant separate resource lookup.
>
> Similarly replace irq_of_parse_and_map() with platform_get_irq(), which
> returns a negative errno on failure (including -EPROBE_DEFER) instead of
> 0, and tighten the error check to irq < 0.
>
> Both substitutions are equivalent for a DT-backed platform device. The
> remaining OF usage (mmc_of_parse() and the of_device_id table) is covered
> by already-included headers, so linux/of_address.h and linux/of_irq.h
> are dropped.
>
> No functional change; the MMC register window is requested and mapped
> exactly once, so there is no overlapping region claim.
>
> Built for ARM (allmodconfig + CONFIG_MMC_MOXART) with LLVM=3D1;
> drivers/mmc/host/moxart-mmc.o compiles cleanly.
>
> Assisted-by: opencode:hy3-free
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/moxart-mmc.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.=
c
> index 4a4d8b19b18c..28aed13549a6 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -26,8 +26,6 @@
>  #include <linux/mmc/sd.h>
>  #include <linux/sched.h>
>  #include <linux/io.h>
> -#include <linux/of_address.h>
> -#include <linux/of_irq.h>
>  #include <linux/clk.h>
>  #include <linux/bitops.h>
>  #include <linux/of_dma.h>
> @@ -555,8 +553,7 @@ static const struct mmc_host_ops moxart_ops =3D {
>  static int moxart_probe(struct platform_device *pdev)
>  {
>         struct device *dev =3D &pdev->dev;
> -       struct device_node *node =3D dev->of_node;
> -       struct resource res_mmc;
> +       struct resource *res_mmc;
>         struct mmc_host *mmc;
>         struct moxart_host *host =3D NULL;
>         struct dma_slave_config cfg;
> @@ -565,30 +562,24 @@ static int moxart_probe(struct platform_device *pde=
v)
>         int irq, ret;
>         u32 i;
>
> +       reg_mmc =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res_=
mmc);
> +       if (IS_ERR(reg_mmc))
> +               return PTR_ERR(reg_mmc);
> +
> +       irq =3D platform_get_irq(pdev, 0);
> +       if (irq < 0)
> +               return irq;
> +
>         mmc =3D devm_mmc_alloc_host(dev, sizeof(*host));
>         if (!mmc) {
>                 dev_err(dev, "devm_mmc_alloc_host failed\n");
>                 return -ENOMEM;
>         }
>
> -       ret =3D of_address_to_resource(node, 0, &res_mmc);
> -       if (ret)
> -               return dev_err_probe(dev, ret,
> -                                    "of_address_to_resource failed\n");
> -
> -       irq =3D irq_of_parse_and_map(node, 0);
> -       if (irq <=3D 0)
> -               return dev_err_probe(dev, -EINVAL,
> -                                    "irq_of_parse_and_map failed\n");
> -
>         clk =3D devm_clk_get(dev, NULL);
>         if (IS_ERR(clk))
>                 return PTR_ERR(clk);
>
> -       reg_mmc =3D devm_ioremap_resource(dev, &res_mmc);
> -       if (IS_ERR(reg_mmc))
> -               return PTR_ERR(reg_mmc);
> -
>         ret =3D mmc_of_parse(mmc);
>         if (ret)
>                 return ret;
> @@ -596,7 +587,7 @@ static int moxart_probe(struct platform_device *pdev)
>         host =3D mmc_priv(mmc);
>         host->mmc =3D mmc;
>         host->base =3D reg_mmc;
> -       host->reg_phys =3D res_mmc.start;
> +       host->reg_phys =3D res_mmc->start;
>         host->timeout =3D msecs_to_jiffies(1000);
>         host->sysclk =3D clk_get_rate(clk);
>         host->fifo_width =3D readl(host->base + REG_FEATURE) << 2;
> --
> 2.55.0
>
