Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331AF47ECC2
	for <linux-mmc@vger.kernel.org>; Wed,  2 Sep 2026 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365262; cv=pass; b=McyglSpgbI3c2ARXAX1ASNAudIBxHVvUIDpX9jRsBLgmGCzrRZZBYxS3OI/GFNz3hXCvSZ4eR88LETSlhJt8Pqdsn7plwtJuOEOOVdatA+pdpsP7+tSC1JRTZv2NYUk0EU2DmUyRXwUc3Vks5osKBuYEWJqjIhxIfQjqjjhCNds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365262; c=relaxed/simple;
	bh=aFaxytIBIB1Ve5kiF/Sc2vEjb2OUXD8sz8lmuf0g5Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoH/6DGNPUoUnKwPOdN5WBkyVQ5Pptz+9RijBAf9b0noEDLUs/QqK0Hb6WisniUFBzMLXSmM5yQB0eVUqJYrIfIbskeKWqKhqL8wm6seX49VgQZJvQOSweI6AA2RtjCc0uXtapENy2u7/5TIGj4KlIAF4NC0RItKzJ53WKJJqVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YsipzOKZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HKRbx1K6; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YsipzOKZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HKRbx1K6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682FZ92d1967761
	for <linux-mmc@vger.kernel.org>; Wed, 2 Sep 2026 16:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DAPmwpOVMYBIF2IijOmIRShxJK4mqn3MwoKwfXdUyaE=; b=YsipzOKZ4KL8slmv
	7lfUIOmUegtvaHe9Q6n5DfrEnbHMetttDM8JsiMptpyFqCWJV5piU+VqF0TpWPGB
	5aJOWc+CF+houMN3k8AD3259qR5ufX2Sj22hlEhnK5029+0Fipr2pbVM5CDfc+JT
	nqa/5zGIjLRLEKYM70juFAX9H2/WHygWQNXie65vVEINziPvR602/ktfEG3b1MIH
	zgniwmAEpQZG7TnGNlJLJ7eQTX7NHKXC26cFpbLMGl3v0NDPsk5OpsZHYrRIueBF
	+vpUf2iu7tNG9aPCRMduPxXedUwuHUcDu0bHXJmlJj6MCxMOjt134Hp50/yoH7qd
	TkF4bg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gej2c9b40-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 02 Sep 2026 16:07:37 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc21bc2923fso1663934a12.2
        for <linux-mmc@vger.kernel.org>; Wed, 02 Sep 2026 09:07:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788365257; cv=none;
        d=google.com; s=arc-20260327;
        b=FPFnRmaR++hb0rJ2t7iWE27uDHKVv+Ja6se+pMHi7FQdWxj78Ni3Pzq8l8lkgTtXQa
         JxqB4VtRgvpaXDZRbV+ko54yxHKZROZJeWpyiCnqBoevPG1uYP0R98LCYGA9q+0YVW1M
         KTlFZ33Dgco8a91n4tkFfIRB+75XM8qXsJ4MLeS+uMRAl8pHidkgr3GveCxthGyRxIAa
         lCsTa5D/1C/Qaljdz5EJOQ3lS9Rp+En/2SghSVKe3SW3QKWE6e3Svy/lJpp4Mb3J7Pzu
         kz2GrBfPy8TkgqGXpfThXqCz2S1YZ8pPZxZoS4qYWiu5DQv6SyYrX7g/RbZdoXcidEhT
         8s4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DAPmwpOVMYBIF2IijOmIRShxJK4mqn3MwoKwfXdUyaE=;
        fh=OQVu+fq0LPRN5okBSlU0PpJIDIZoMUBXQ6rfO5tIMWY=;
        b=hkt0mlTPJtvX6EycQsX1Gz30lREwhKJXwu9P5v5Ar3JvsYsqmbE5ADSdgBf8rMyNfk
         ka7bS5SOfqz3USOybgrXUCpWz7SKUBV2EYnUTik3K92d+oWhoxg+gMXGi34ZYB3ZhL2a
         IGWzRHLm6Usrd+s8G4mr4cl9r3/93KC0BLhAeyk3ICM+66eopAYIbCK6ybOaQUiOO8kQ
         e8GZaIXVRDtc9f2/o5hmFZomiNAT+0hkrnSrBYK9Nf1PC9d6COiWr7QIRPan33LIQ4mR
         257yylWQOYUJddYwXxFUN6Xk/NYNgdi+w4yinBQ+69NmJBfiQzsgZ5eyMLE3UTV7aGQo
         1pBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788365257; x=1788970057; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DAPmwpOVMYBIF2IijOmIRShxJK4mqn3MwoKwfXdUyaE=;
        b=HKRbx1K6nPCPx66SSA6oN+Jh8jaE8UoViUO/6XR7ny6Gt3XwZbWjgYe2yO7hljFdLB
         CYgNDFUoyf87Sjwc3TUZl7tR6NkbkN88qDQBSTuEBcCDGUMM3NoTdfLj46KoB0mVQzd7
         Q2LRTXIWlHMArbP/m+EbYZJO1zYjEOrkC8p14IY67UU3b6IpMvBp2scgNnrcp1eOYr9t
         WotPwd//RL5HWfhO7rbLN5PBdD8y2IJws+vh6s8+xfpZfNj8m12FTBWyBqy6904Yw/+p
         GRz+smv8kOsuqeIqso5mV/g3oI4OdxVyU3D0GWgaYeUjElrVY3Scpd1kV4FbAkPidedV
         t/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365257; x=1788970057;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DAPmwpOVMYBIF2IijOmIRShxJK4mqn3MwoKwfXdUyaE=;
        b=Ry/VyNTYaUj8z8xB6hji47iZjKu2vmDc73S09GTWRMqjZIfesP5i9bLkDYfYxi+UF2
         E/Fkt6/7Cg/SMo9YOS8zMem/L6MnFxIkxSGJs8sqbpL7CHB+evuvbo9lSVQbMz8D5vsC
         cxL+JspTWIXbs9RABwyuSXsFyD95rJ4dmbgWY3f1mGFqd1axxIQ9Es42+/vFSHH0O0NA
         oxqnSMWvEwJ1vallmSGYnGyzJwPNxkzqfjzHi87z/fGHwAxTKjmdUy8swHUYwKQlHwU4
         nm3+g+eeV2GYnbh5MEnUuP9LY0zBwU+rUU9IJjmWB8sjtYypxuFXieRylu2gZeOE1QFq
         07bg==
X-Forwarded-Encrypted: i=1; AKwUvBzIpwTt7uMzuji4YpTzkPwj4kIAhmQfXhI8fFcFlMRdYj4UTSErJRO7TeSrlxI5RYt9JA2m1s3s1QE=@vger.kernel.org
X-Gm-Message-State: AFuF++k0phTBIHJKz4eNX5h3o5s3D+ng8ZbpXQJwM1ot294ShgofjpJv
	7Vq42kGrskjNCsJIEVoFS4BARG4HT23g9U2gJrSKTe+wJ0yx6rVP5HBmGAN4SL0W335dm6/CJ0P
	7val6WjfPqfQdVvzuZgOdzJoEPKf245wwXT8S5FRgOgj9fetYAL3tKmqtYgx5/ELVzicgyeCrPW
	754kdFEGRXkHHzevsIJwj0m7PhrY6qBqtZcPnhFw==
X-Gm-Gg: AYBFou16cmMIErK1pl5sOfj8GEm1qA1n8mDMi++sHQyFXjNeuZFW9AMms3pZz1ymbZi
	446sIRWHJwEHE1YB/tB6qMq6/UvSEoik68KvA0/kgGrv1Seteb2i5yU/pZAYBynyfGzO99pJvvz
	yveZVPjV/snCR4jrUI3NX7DR5X9AuufWwG2NhbgF5QerVknJ37w/xp9dD9Kw==
X-Received: by 2002:a17:90b:2e50:b0:398:b426:ca4b with SMTP id 98e67ed59e1d1-39aee1a9994mr9843024a91.22.1788365257029;
        Wed, 02 Sep 2026 09:07:37 -0700 (PDT)
X-Received: by 2002:a17:90b:2e50:b0:398:b426:ca4b with SMTP id
 98e67ed59e1d1-39aee1a9994mr9842890a91.22.1788365256476; Wed, 02 Sep 2026
 09:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625003525.22594-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260625003525.22594-1-pengpeng@iscas.ac.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 18:07:23 +0200
X-Gm-Features: AcwNN1Um-bxia3REdAXf8m-38tcHtMIEpV7_v--sQ-7-GTkWwOc4grrEf97NRUI
Message-ID: <CAPx+jO_6jWt2YAjzHnD56_LX5mAFkxwOiUy4Ka+BRG9WX2M0PQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: report DMA stop timeouts as data errors
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulfh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MiBTYWx0ZWRfX/OmdNzKXcW35
 AMLrzFuPdgzbZUCVnhWh2smhQK7ZLUZRfNH2HvvuSY6lNtmjnPMu24aRpAOyP1w3VwY4yjxnS5R
 aSYPXP4KXXXuYZGOhWB6cHBO3A2R5pc=
X-Authority-Analysis: v=2.4 cv=G+ss1dk5 c=1 sm=1 tr=0 ts=6a9849c9 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=CBFGLoz9tPvRy0Ij70wA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: eGCQbzSNICfEdOZ9cy-pr2uFARarXIKj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MiBTYWx0ZWRfXzZLSk05AvVvl
 qyCqbt/epaodeNybCL2e5V+LoDFJMVckc+AFwDdA3L7NhWJbH0K1sCix4CqzcAth2P88kpr4rF5
 1+2cB0rqEjxUplmqGhf2cTXgfnHGBpO5n5gOFFo8I7AXm0hxiUHUJxaCFS4nNQjV5PgyhhFFsQ1
 DI8nEjeI2Dgp6ph6qnjLaQ7SuZLt/sP86LVlodyRx5HBCctVFHvnOuW4C/SNJICsvbzZt8hQDJC
 qHq4G2E5LXHEBYXcZ+9C7rg0i7Mff+zqGYaNwMOakH8fFtLCJGx44gUyolWnxsDfsuWhfFFmcSP
 D9Qejn3RK4LjfDXvPlXo6wMwuXE8cirUFYNtIwGzarNDmV/omJH4nb2stJs9fz9xojgUd8lbikg
 Dfrb9oVGkGbOpxHwG1Pv+VIbnOJIyPFMQkj1s32ThCGv36QiIU2qo0PGxrpi5rYkSigtSNa7eP3
 HAOPACqgycP6/EYdCtw==
X-Proofpoint-ORIG-GUID: eGCQbzSNICfEdOZ9cy-pr2uFARarXIKj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020142

On Thu, Jun 25, 2026 at 2:35=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:
>
> msdc_data_xfer_done() stops the DMA engine before completing a data
> request, but it only logs failures from the DMA stop and DMA-inactive
> polls.
>
> When the interrupt status also carries MSDC_INT_XFER_COMPL, the function
> can still report the full data length as transferred even though the DMA
> engine did not confirm that it stopped or became inactive.
>
> Treat DMA stop/inactive timeouts as data errors.  This reuses the existin=
g
> reset/error path and prevents a timed out DMA stop from being reported as=
 a
> successful full-length transfer.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Hi Pengpeng,

Did you verify this on HW? If not, I am leaving this to the mediatek
folkz to confirm before applying.

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index b2680cc05..e3caa9c32 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1583,7 +1583,7 @@ static void msdc_data_xfer_done(struct msdc_host *h=
ost, u32 events,
>              | MSDC_INT_DMA_BDCSERR | MSDC_INT_DMA_GPDCSERR
>              | MSDC_INT_DMA_PROTECT);
>         u32 val;
> -       int ret;
> +       int dma_err =3D 0, ret;
>
>         spin_lock_irqsave(&host->lock, flags);
>         done =3D !host->data;
> @@ -1603,18 +1603,23 @@ static void msdc_data_xfer_done(struct msdc_host =
*host, u32 events,
>
>                 ret =3D readl_poll_timeout_atomic(host->base + MSDC_DMA_C=
TRL, val,
>                                                 !(val & MSDC_DMA_CTRL_STO=
P), 1, 20000);
> -               if (ret)
> +               if (ret) {
>                         dev_dbg(host->dev, "DMA stop timed out\n");
> +                       dma_err =3D ret;
> +               }
>
>                 ret =3D readl_poll_timeout_atomic(host->base + MSDC_DMA_C=
FG, val,
>                                                 !(val & MSDC_DMA_CFG_STS)=
, 1, 20000);
> -               if (ret)
> +               if (ret) {
>                         dev_dbg(host->dev, "DMA inactive timed out\n");
> +                       dma_err =3D ret;
> +               }
>
>                 sdr_clr_bits(host->base + MSDC_INTEN, data_ints_mask);
>                 dev_dbg(host->dev, "DMA stop\n");
>
> -               if ((events & MSDC_INT_XFER_COMPL) && (!stop || !stop->er=
ror)) {
> +               if (!dma_err && (events & MSDC_INT_XFER_COMPL) &&
> +                   (!stop || !stop->error)) {
>                         data->bytes_xfered =3D data->blocks * data->blksz=
;
>                 } else {
>                         dev_dbg(host->dev, "interrupt events: %x\n", even=
ts);
> @@ -1622,7 +1627,9 @@ static void msdc_data_xfer_done(struct msdc_host *h=
ost, u32 events,
>                         host->error |=3D REQ_DAT_ERR;
>                         data->bytes_xfered =3D 0;
>
> -                       if (events & MSDC_INT_DATTMO)
> +                       if (dma_err)
> +                               data->error =3D -ETIMEDOUT;
> +                       else if (events & MSDC_INT_DATTMO)
>                                 data->error =3D -ETIMEDOUT;
>                         else if (events & MSDC_INT_DATCRCERR)
>                                 data->error =3D -EILSEQ;
> --
> 2.50.1 (Apple Git-155)
>
