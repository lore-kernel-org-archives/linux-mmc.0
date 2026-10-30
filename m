Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793358034;
	b=UzU18yQa6ks26SE6jcUlrB1n60sscfEwOyK1/Ed6GZwfCq/uq4jAYrQjuA0BRvf27Lhm
	 t5Sii76vWcMsNwWuwFb0vrZM9pmEUZMMJpynchrWukMN/IyJhvp8McKKLJiZgeR8xfdXb
	 F3h8c0wffio6zu/gkQnA079Yn6pPy2z34/mqG/Eu4/fbc8NvEl6+f5HrF1ltlFkj11VYl
	 IWuvFJJUMOUncFNHvh8v1LOSWYykKnrRNmCQ3GRJejJOY6f40Aa/G4pelC8hK0hYKCr5M
	 tiSz4mN/NS00tY6gzOEdyl3PKEqQFvs0mAMwrtO3oJkwTnenm/gWbKK8GNsDIxivkLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358034;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=IgLsF++4YrDHxiLkxSaC+mUba5OUh/3qh0E4AJY47EQ=;
	b=1At0iFRvqY3MTANUDGTMIFnBQ+JzXVB+mgGC7s2/fgQOOsg5Ni4vWWJIe1UXWSsdwhtj
	 nJW2DQ2vn70qnFJOWrYpi/lkBjC3puxAMSyakyrV9EvlvvUYHUMjiD3MkvcIeoLKeemoF
	 Rr0BHtIHY9+IBeG5QO/sXnvQZsbquc2KkAwpx1rjinuln5MDSYJG5YFNnPGZ8GLNRZyFH
	 ZAT1TvECH6vJ1fqscHLCGrwNbc+bf7t7gGB8qWA/pHJ61LPqjl+Pw4O1p1QWJ5F+f3bkx
	 MXiI7qfA80VpP76HOpDFBOy3nE5GQRGyoAuormOcImNKIWuXK68+Z3E5nBN59RR+3uQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HmIUtBvE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KfA0Hr3W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5B2606C6E8
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE5B2606C6E8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HmIUtBvE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KfA0Hr3W
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8Fb6Q3311533
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IgLsF++4YrDHxiLkxSaC+mUba5OUh/3qh0E4AJY47EQ=; b=HmIUtBvER/Y2SW+i
	q5qyGmDoHSPZdndt97PH0rykbu1/4QX7YiVLErRJi6rCe7850+rpnwajQdu5VUxp
	pIAPcjEXNDjPn+uQ1AtxgikcP/JNvGpX0H0YUVLl4OKVGBD86MAxL7/TcGsHBfjF
	VVCq697DkSz3vVq5I8JzA+m7+1xqRzrV2tEhmavl7NPBoWKP5n3xz0tuRm/66EsW
	CvFuCc81VYGmkzj51FYXmakxs7M5Qp/mtS32JBEoDxcFPhzbqqcvRxTakgGf/DU/
	nJWhukWUiGKGSNCZ7dqHeO6JbFzq1igI/QrfoxM1gpX35sZBWPP9eq/mcO/KKPJn
	emqnOQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qtjqx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:32 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a06750c74fso518807b3a.0
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 04:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793358032; cv=none;
        d=google.com; s=arc-20260327;
        b=Q6KKW5d6mdW9fG63gCy8CohQlWauzAiTL6It3cg5Z5fbObU6tgYoQvaG/KwOKAYRuB
         hd6uer7D70VNEGLmU1Z22qB/TkUFrIaAN8CS7D2taDulIotWR3mzBcSxImZ8F3Uu2IYn
         hqE5SoNpoUXgWrVpYM0ux/qepLc0djib02FF9qhTKyrBFu48D4t8QepCjlTUQ5LB6+UG
         H7x7o54DSdPeqqftvu1L9chBbUAU6xL9Oundc//ORHR91OQFhNCt0XMON9QQNEARwaoG
         lit4mclioS6lUAAFvieVjWqNNoUqOLN4Mo/dDzFgpGZ6Qt+NIa2EIIRS/hLNmqJf6CGg
         bOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IgLsF++4YrDHxiLkxSaC+mUba5OUh/3qh0E4AJY47EQ=;
        fh=xIvIldLO2Yl3mUqk9iqNi3Cp+l6muwNqFhp8RVDNViY=;
        b=m8xFEu92peyq5oleEJ3AmD0QgrK4hTbFZUI131HrUTJWElGvjcHr1LEjXNLQ1Wj6JH
         /vM0aeHxYPzsuKNrrk3WQMQCPQvv5dgv1/aSZwDA338Kfdw9d25ebHcNyvNds4YPG2We
         bBOfWoI7KUMQfVX3rYozk49qIbRLZVFhNun2ua5u0yPBrYORGu3niGI0RSjhNNBuvJRh
         yQTNDcRpvayZgZawDpAp04lFPPcgbnFi/bySDdCJ6svk8QpnzlxpYZ3NasxkmE2/WfCn
         k6bl60awsBhVlbTMWDbDmWUfA1hQVEp7TwoIey6HaT2Cs5K0cUqbuULCEt1d4HeXrXM3
         +1uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793358032; x=1793962832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IgLsF++4YrDHxiLkxSaC+mUba5OUh/3qh0E4AJY47EQ=;
        b=KfA0Hr3WhBknyfzqyxL31TMubUcP6kNcMUtnYVcPrSigRfCr6xSo4oWLlS1lkphdLY
         ZA+wp7A3TcEIYv2qMdwlFkkc2aVCgu8gxadlLyWzQ50bMFj5Njcj/vWxxeOEsHOLXfqj
         xJHuqWww51o+e1wm0HCrj8trLZ3GRw93MKV51A0wDfpBt5l+kMIMSx2ABzrws7LtoLmD
         8iXP1bRHgIu0BLVucwlWlLs4VJkWmqOwK9ASZUPvX41IW8RmXSuOPEa2dJuayaHvjdsb
         BFGPJ2m8YS9GM2vhO7DFWGSNLoYRB8/7Ua0rUApqMTecgOhmdKotqapxVP6W+MXoPKF6
         9j0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793358032; x=1793962832;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IgLsF++4YrDHxiLkxSaC+mUba5OUh/3qh0E4AJY47EQ=;
        b=g3VG1GVZNMfLo0nPz9wTaMTILYODV6PjehcIb0LwJNbdY1JIDNYfTC9Jsx1ej9xvJg
         QrQbtMyUCbzapJmYSDq0t00uaVay5RAh5Km5JldvClDer3wzkXJfeVrl/Ho6XEt/kCQv
         HyfxRYdLeRswx/V9XZXxmhrYYb+vo3/RAx5aO+0B7xOI27wT0WsPTvRGb41ZKb6vclGo
         CPjqkMR2mhhXWP6tsAJVKhV6DP3o7X5cyqHS/+065478JupWwh01gKbTp20d+7HDe/Vn
         GKttz1IcwT4j7ZeLTq+UsQUe3kW40YHLTKs99zQICbYjbCyCyChJEp7mpf+5WO9RnJhQ
         i4jA==
X-Forwarded-Encrypted: i=1; AKwUvBwzc2yt2wDWM2a42owcpGicehZpeoj067CnolSxKxk0SKiWq8lbmdUzOJw01we0/bziP8ELo6rM7r8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZmoQJkNfXsuTvStnScfD1+q4A/uQlopIG8U6vUJ1zPmR5f2cu
	fJ6iEUTpPbKMgmRbD44YP1eDT2+WMXoQk4tUUmEK3qEWF/Qt/nI9CzTHQz01cRSZxxTvXK+CtZ5
	HxCgs0DvhFwz+yx0hUomT8QeJTg7bBCCYIurSfahjaEgLGQulKpZq4pxNXO5++nMKPAbD2ZeGpH
	jmpIXAuhrx+FPrsBcscThZf33aYBfs26tk26/02A==
X-Gm-Gg: AYBFou18rKtmk7yq7KjU2226bw24XxGYp+KNsVLpknNoqNdm1zTdGFSdqVnANh5vST9
	BStOkAGfOsFrED0ILBVSt8LBU3myIgBBTsbv0kHWx6OQQdbtPGWtBcKlLcwLNOAPV040s3r0YQH
	C83z2IroSTb48GXFrfgZS9UKRbwpf3zQlMR2qoAFPU5KE5F/+H3IOPTyHArA==
X-Received: by 2002:a05:6a00:4b52:b0:89e:7bfa:f880 with SMTP id d2e1a72fcca58-8a9be4912efmr1664300b3a.11.1793358031455;
        Fri, 30 Oct 2026 04:00:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b52:b0:89e:7bfa:f880 with SMTP id
 d2e1a72fcca58-8a9be4912efmr1663980b3a.11.1793358026227; Fri, 30 Oct 2026
 04:00:26 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020220140.31752-1-anferneemelokc5@gmail.com>
In-Reply-To: <20261020220140.31752-1-anferneemelokc5@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 12:00:14 +0100
X-Gm-Features: AclHuK9cDn85gWrusMMP-W9L41_UYwMzVXdFFjFJTDQP7QMovH4WYgXI-UJFkXY
Message-ID: <CAPx+jO8ZmctKiQntoYrrYW61zwFXkT0_jR8Uqgup8iB1m0C8mQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi: fix clock and runtime PM leaks on probe failure
To: Anfernee Cao <anferneemelokc5@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: mmHCLGrrrRBeUtOHP5Aj_1aCTEN8V-u6
X-Proofpoint-ORIG-GUID: mmHCLGrrrRBeUtOHP5Aj_1aCTEN8V-u6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfX65S5ctfg6frh
 ROInLeesttBQRYLT5xsly8cpJJToSJXi4m2jUNC4g1Gp3fQFO76opStEUMRcOc/R4YXbI8YxAjM
 ArHHBljNY2z4yL/dhxMO3KNwK6y44uXMnaSwGgRGLgfRpW0QRVAW0Nx/k7s73Vfc1pEqV07DKXM
 8VIsBJEGaU3ruiQaIGRd0UgFBHG/klZeRthtHqRNTYxfCT6iDA7wHZ/ZgDQTKTCtoCnkna6PdTh
 KPvZ2ns98VKQGAv7MIuegyXxA1FWfGhCdyyFpse8CUIFgDtmGduFayVA3+tJr4RHHMPONlZR5ym
 uWOlIuPCPofDp+hh9ZjOUr8kEGK5iv3fB15DQLWavqKKjgyN2wz4lYSaVazckVyq4PAKT91ezb/
 zqBgblj8fC4VjdGNZOGWzXo2LCJAyau381HsX4Rzne+vpCNoosahTeVovOe0uvrONketWkR3ONm
 Wq+BPCaFZx31yN6UR/Q==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae478d0 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=BnDUjJD_-KrmPbzgTPgA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfX/346tCOeOtXp
 qQ1lkkEweGr0GxHkbyHU6iobPW/P2kLVehlfv4x400cm/tWSzUP/qELVRsC6FqpuiIBuCutg8hh
 6oKhaY60pIbaCDtQ1g4/5nmJZdlWr6g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300043

On Tue, Oct 20, 2026 at 4:01=E2=80=AFPM Anfernee Cao <anferneemelokc5@gmail=
.com> wrote:
>
> sunxi_mmc_resource_request() enables the bus, card, output and sample
> clocks before returning. Several failure paths later in
> sunxi_mmc_probe() leave them running:
>
>  - If devm_request_threaded_irq() fails, the clocks enabled by
>    sunxi_mmc_enable() are never disabled.
>  - If dma_alloc_coherent(), mmc_of_parse() or sunxi_mmc_init_host()
>    fails, probe only frees the DMA buffer and the mmc_host.
>  - If mmc_add_host() fails, runtime PM has already been enabled, but
>    pm_runtime_disable() is never called.
>
> Besides leaking the clocks, this leaves the clock enable counts
> unbalanced, so a reprobe (for example after -EPROBE_DEFER) calls
> clk_prepare_enable() on the same clocks again.
>
> Disable the IRQ and the clocks in the probe error path, and disable
> runtime PM on the mmc_add_host() failure path. Also handle a failure of
> devm_request_threaded_irq() in sunxi_mmc_resource_request().
>
> Tested with QEMU's orangepi-pc machine: with forced sunxi_mmc_init_host()
> and mmc_add_host() failures the MMC clocks stay disabled in clk_summary,
> and a normal probe with an emulated SD card still works.
>
> This issue was found by manual code inspection.
>
> Fixes: 3cbcb16095f9 ("mmc: sunxi: Add driver for SD/MMC hosts found on Al=
lwinner sunxi SoCs")
> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
> Cc: stable@vger.kernel.org # v4.18+
> Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sunxi-mmc.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index fe4c0f6d73f3..437fdadb5950 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1354,8 +1354,13 @@ static int sunxi_mmc_resource_request(struct sunxi=
_mmc_host *host,
>                 goto error_disable_mmc;
>         }
>
> -       return devm_request_threaded_irq(&pdev->dev, host->irq, sunxi_mmc=
_irq,
> -                       sunxi_mmc_handle_manual_stop, 0, "sunxi-mmc", hos=
t);
> +       ret =3D devm_request_threaded_irq(&pdev->dev, host->irq, sunxi_mm=
c_irq,
> +                                       sunxi_mmc_handle_manual_stop, 0,
> +                                       "sunxi-mmc", host);
> +       if (ret)
> +               goto error_disable_mmc;
> +
> +       return 0;
>
>  error_disable_mmc:
>         sunxi_mmc_disable(host);
> @@ -1385,9 +1390,11 @@ static int sunxi_mmc_probe(struct platform_device =
*pdev)
>
>         host->sg_cpu =3D dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
>                                           &host->sg_dma, GFP_KERNEL);
> -       if (!host->sg_cpu)
> -               return dev_err_probe(&pdev->dev, -ENOMEM,
> -                                    "Failed to allocate DMA descriptor m=
em\n");
> +       if (!host->sg_cpu) {
> +               ret =3D dev_err_probe(&pdev->dev, -ENOMEM,
> +                                   "Failed to allocate DMA descriptor me=
m\n");
> +               goto error_disable_mmc;
> +       }
>
>         if (host->cfg->ccu_has_timings_switch) {
>                 /*
> @@ -1467,7 +1474,7 @@ static int sunxi_mmc_probe(struct platform_device *=
pdev)
>
>         ret =3D mmc_add_host(mmc);
>         if (ret)
> -               goto error_free_dma;
> +               goto error_disable_rpm;
>
>         dev_info(&pdev->dev, "initialized, max. request size: %u KB%s\n",
>                  mmc->max_req_size >> 10,
> @@ -1475,8 +1482,13 @@ static int sunxi_mmc_probe(struct platform_device =
*pdev)
>
>         return 0;
>
> +error_disable_rpm:
> +       pm_runtime_disable(&pdev->dev);
>  error_free_dma:
>         dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_d=
ma);
> +error_disable_mmc:
> +       disable_irq(host->irq);
> +       sunxi_mmc_disable(host);
>         return ret;
>  }
>
> --
> 2.54.0.windows.1
>
>
