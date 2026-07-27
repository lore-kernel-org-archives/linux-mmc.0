Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C1142376A
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169523; cv=pass; b=W0PAA1uiuRguxaXqjTskkses7htRzWBtKLNyMTCU2KeZEPXxhhwnosfUycpsZmEd3Z+5YsIl2Pf+Ecm0icyHVe7ErWgigxluJf0lT40yQR00y3D5Ua3FDKMpsYU10NX0eGufbYFqW1VP1caL2Cywgv0LAB0Eu6y30SI4Vj8ggIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169523; c=relaxed/simple;
	bh=lIfbp4g5Tlq0Apfu2MZaanv5P3D1QanLfqpB53OYPvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJ8JUBi/RppsD8nkBrvptyXpveildyTx//Y2W1lSm61IeJC+f4e3ed4l9SkzfhuVJc+8DEvUoKQTpjmZSax3YMkWeuemNUSOBcFA/LkYdiFD7pj0AbRex9yzwI/NjcTd4ooBSHeIpFJ/J/K+SpckbBZ5BFrQ54QVSoHcyfJJgKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dhUSwfLR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xns2RoRL; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dhUSwfLR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xns2RoRL"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDm9823823643
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 16:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fujInK91+uJSqFUqng2bHHt2xnpCDiBg4JaBokyWa9Y=; b=dhUSwfLR4Mel9wX1
	WWcJjpG2CYJe+pOzmZ4Vl8QhCJWJnHOJY78EVI9KUvMRvuEDXpzyLU8xuxqOiiOR
	xeUbRNpN3I0AjPIZPEJ+cJqmfyjJbqnIQYeGCLwOmb4Avu3dsIhCbuFx0cXOlDjX
	hK5TncGulxPoYq/sjb4N4BWFMjNeLQQIf4seYsf0ClZQN8dxr/5k2QwhagCUsqSF
	aYcqiZwVgwo5pg0Pg3qacVt/c3GHlpaMu3AT1Im8GizQZx2/gz2hF9YYpNnDsfmu
	wL1Ohd6NjGA4xRDywMCDVTM3PS42RX9aUw/1v3ELM5y/KhP4FS3/q7RjPUH9A7uW
	Gu9epw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4nbsscp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 16:25:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-907b38aaad2so44679116d6.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 09:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785169519; cv=none;
        d=google.com; s=arc-20260327;
        b=IIlELUu4bIqSd+8SYJAY92oyrQuRkQR6NaPlU8/ueNAvNyQpSAk/iQG2W1rL3WuWql
         WISV1kDsK5F1EFWQ2eENmR9929dmveTBEKiOi5/eZ55aCaNEzdkjuT2u9dFBVVdZ2H5F
         5AhvT5vjNbc/t7zLMwgr5kogU1lJZjSOY+/jrpc6JzikBucluLYfur/yO8jVzBmn93T5
         DN0Jx1WGYdaK9o05arA9GYG+sM/p31V9XxyyZyWSJ8mExHBaFTJf4qw1PZRrDKvtbrIr
         9kcVfxvfv087wRyBwYFhTpDnN/jOJGKCO1E+GsUGMXHdqxPur2No9xVTkVvaQI6xAv8G
         R7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fujInK91+uJSqFUqng2bHHt2xnpCDiBg4JaBokyWa9Y=;
        fh=B4YP/p2iaCGJUrtpyxEEV/R9XpwT9E+tq4zuTz3UjbM=;
        b=W2wDFlDBwKuZkoqyV1SSlNvUqYsCVraHlMEUE7chQp69Oy90xLlq77rbUFAAy4x7jd
         q+k3XPsAu5SqDvmfJePcEkWPygpYwNe5y3fy5u4vHKsnxxF8f2F9iDSjrA+/1jqHwerq
         1yGb4yraOu2/BESZqqN1o9/Lg0m2nZuHDQiIzukc8oOb+yKbmVyIWSAeLze2Wrmu+YAe
         MvQOxsP9gKixPK4cdSGVxe+M0Gw0LACsHJ7DVGMdTiM2VxKx65vDh75GIhS00s7FzStb
         P6i6jGd7RgHON+yiz2wE23JAbKB+bmctfqPZQFUrWEol5dNJKioI1BVbdGJl37TJI5l0
         cYgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785169519; x=1785774319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fujInK91+uJSqFUqng2bHHt2xnpCDiBg4JaBokyWa9Y=;
        b=Xns2RoRLnw8qNQw6pFiwfHomckCgOOEtPMrN9ggBsDXCcH1X/1+Bj//BwWkkCgmWnJ
         Zxh5omfXW3D4AisFtvO4vsO3U6RCuEtZFhk4yH9ONu60n7/Uyl7tdTQeGyRQ62mVAFPO
         f6D5DSCL7fPjD1ZT1tQ9LzT3cZzIU60ZaD0VAPTmzdMXsC2uQIEQApO0ES7X4OoI84i2
         Ue8D5fjoNA1ZarBXZVsMguYLaKA0UF6JxhkyX2IXhkxcE3x7UxCMmtralNQdXIxNuCAF
         wJqBStG1NAVpckjLwRreStLSQmahmqCWqldoteFLx0/D0Sk1zfkJlW5YynauCnvL6oID
         mx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169519; x=1785774319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fujInK91+uJSqFUqng2bHHt2xnpCDiBg4JaBokyWa9Y=;
        b=lWLTPCS3JxDmwTwrB1G1SyjRYDS35H5o3gH/cSnK+EdsK4MewmNH+nH6Sp0HZx6lSS
         P/ytJQTo3ELDFML94/91FwE5mSflZsMoxARSP3ML8a4MZeRQB0MCcuKw9Zq/58DD+JhH
         02ASW0wbxyVMcT3XbponEcZ1SFSQYElZFTMfs0+aHzf0EKs1QJCmcwb08lNXiYwFp5gN
         DJI+6dDq85pf/84lDFE+vhtEt2KIDTO8PlZ/abo6EP18W+juNrv7HjkdzJRcoBEOlgNs
         eauJRAfQkWqCNu5ovJatAxtvo3/BiUltd8Y5peE4DEoHSU8jpWSZBtBSVbfRBFXDsQOf
         NAwg==
X-Gm-Message-State: AOJu0YyrGi/A4DoQA4sEmQdtWV8RxmEIJFiX2UWYwY5DjTLReNjLDK+V
	rUN8oFy75ed+yI/wdgcYwFmCDrZXzobCRG+maDwLSsm8FjFbo9kbuhqCN3Wm1ndb8+yBfOgnOtV
	NR471Y09dhueRCrbxw9W/DlK0jnuRkRUaAorL5SEzPtSxvQe7fQI16HWjFyFeBBozGIkue5OX8T
	Uew7jnUfYYGlU9NHjtxoqxfmOGGKEu5+MLdMaqI6/z4e9vnw==
X-Gm-Gg: AR+sD1070M6vH0iCLrhAQU8NiiE9eNFp8sCFG4Or3QOn3A87lk0XzdIlf8NL/cm9fh2
	Ujw6P5NHcHOY0mjdLIVFOs6OPnQpSaRUTfd445Nq3zpYIk6qQoyYCpM/v1PlYYZIX0iqmwKWUDW
	11iVMWWbp91rkbffIBVcK+kZIVtOe9+S6TsS/pLhcxn7P7p4FI/5H0b6sT5A==
X-Received: by 2002:a05:6214:5f02:b0:907:c056:d648 with SMTP id 6a1803df08f44-90812698557mr2993076d6.2.1785169518628;
        Mon, 27 Jul 2026 09:25:18 -0700 (PDT)
X-Received: by 2002:a05:6214:5f02:b0:907:c056:d648 with SMTP id
 6a1803df08f44-90812698557mr2992576d6.2.1785169518146; Mon, 27 Jul 2026
 09:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723112842.3592137-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260723112842.3592137-1-fanwu01@zju.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 18:25:07 +0200
X-Gm-Features: AUfX_mzb6CJnSNATmuSVX-ITtBNLIJwIGjfcTpgtCMAwtkjufHh4_V1qYf0WOC8
Message-ID: <CAPx+jO8kyok_cYyUPFMviOC9KsUbAhT5t4jbTGYqcO1sHZNCag@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: via-sdmmc: stop card-detect handling on probe failure
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 8glT_OUJrfNCusB8y6_-LZFtctMAKEKM
X-Authority-Analysis: v=2.4 cv=cJjQdFeN c=1 sm=1 tr=0 ts=6a67866f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=T_pAX8yLOfAJcNyp_v8A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1MiBTYWx0ZWRfXzeDpwkd4KN4R
 sftigAGfxDQA1jv1mDZNVCJXPNLeLJmGQXfEJFuieG5FhzmQajLwctbbsVpQxJKOCed06PIpEF6
 jNuZ8acwguNJfoXWeDfyKJmmpI9ZHC8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1MiBTYWx0ZWRfXwXWGhHbGe+Q2
 LQrmW2rUxcf3JcPU1IwXdU0iOzs0c28lDy537IcIzSnXNA9x3MA5d51ugfX58jCWlci5EaexJX7
 Mxs6tP+YBxh+AhYe6IYcp1s8uqFSre5k7+mqoZ+dnd7ghQl8hSqII2rdDZftCAjqgVLA/7w3PCY
 tUuh0Rzm8sa5q6CCjDgc+oIIeEMp+9E+kt5V1ngUy7oe0XZwTGZENQThdOTOshnN+8Lg6Ye4reM
 dJcVKapqpuvtjBvF9WbZ3dWTAF9kwzaKtlGNPHIOLmJKVASbH5ccNAIOkJyVp5B34gVUjbMAz7W
 xwzuxK+/6CLH008PueXiE34J7tFq4eMIRp25k2XoptbIeb3QverQwnUgAxS+uzFFrsmR2gMcVt1
 xx4Ish+D6OtbeLWx2ZUkdxSeB4o5Z2CXEJFjAwQL6QXmpjWrpEqhpQXT03r/+E2EcbFkleLCjby
 VYrsVAdDlgG8TImq00A==
X-Proofpoint-GUID: 8glT_OUJrfNCusB8y6_-LZFtctMAKEKM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270152

On Thu, Jul 23, 2026 at 1:28=E2=80=AFPM Fan Wu <fanwu01@zju.edu.cn> wrote:
>
> request_irq() registers the SD card-detect interrupt and the probe enable=
s
> it before mmc_add_host() runs. If mmc_add_host() fails, the error path on=
ly
> unmaps the registers and returns: the interrupt stays registered, so the
> handler keeps running against the host once it is freed. via_sdc_isr()
> dereferences sdhost and its MMIO base and schedules carddet_work, which
> via_sdc_card_detect() also runs against freed memory through its
> container_of() dereference.
>
> Add a probe-error path that disables and frees the interrupt and cancels
> carddet_work before unmapping. carddet_work can re-enable the device
> interrupt via via_reset_pcictrl(), which restores PCIINTCTRL, so mask it
> again after cancelling the work.
>
> This issue was found by an in-house static analysis tool and confirmed by
> manual code review.
>
> Fixes: e4e46fb61e3b ("mmc: via-sdmmc: fix return value check of mmc_add_h=
ost()")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/via-sdmmc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index c628b3bbfd7a..5228a1fe0495 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -1154,10 +1154,16 @@ static int via_sd_probe(struct pci_dev *pcidev,
>
>         ret =3D mmc_add_host(mmc);
>         if (ret)
> -               goto unmap;
> +               goto free_irq;
>
>         return 0;
>
> +free_irq:
> +       writeb(0x0, sdhost->pcictrl_mmiobase + VIA_CRDR_PCIINTCTRL);
> +       free_irq(pcidev->irq, sdhost);
> +       cancel_work_sync(&sdhost->carddet_work);
> +       /* carddet_work may re-enable the interrupt via via_reset_pcictrl=
(). */
> +       writeb(0x0, sdhost->pcictrl_mmiobase + VIA_CRDR_PCIINTCTRL);
>  unmap:
>         iounmap(sdhost->mmiobase);
>  release:
> --
> 2.34.1
