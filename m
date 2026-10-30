Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793358045;
	b=iEKmdKNfvF/HFnwLvqYJrl8+CfGuzQCi5j5cZ4v0Nd0Lqg8ISRa/3yCkzGId8TGKfyA6
	 zAwi5gK6GfHMlFZ9QtAjGBdsvrGxB6EB+v80Bw29KRKOWMLJm7ld+KI35Sw+ptEjm+Zk3
	 dg+NBp0c3VrVBshMlMlFupIZ0vt7vIUTvsMkI5SdKbPq+3+1sCFoT7QyyeUXF44WxkBrw
	 LrOOnsC5E6wK6/rz6xhBw+lHMDSb+yyV/SYolJKou2O+OcmEgGa+RkDrm3Qq5oPMIl9xV
	 Ph9xX+7JH6djrQZke20wdkgokGSKpZ7mYr4JimbGihjk5bOXf8vcoZS+rLrTlFsZb/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358045;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=S7Xg2vGeJzK/amaGgwLRI/lApgi2Uub6jwZHNBWQ3u4=;
	b=dluleUepWS8rRvYQcX3Grsm/oi14tV91ma1IMfOH0im2DZtN+mgf+OneqehmCNkfzaHQ
	 TtUTyFbR4g95Pri0SopvgwvxzRRhJExEOWunh7cgXb2AavcMrPds4OlFksrAUKM0Npxtj
	 quXOAQCzANBScUfnwNbgCnxRr/f7PEfAq60p2Kre9AUSbHMD0vev8LPmYzalBg0yUTdBK
	 ddEuXdoNBVfsuHjTXldKm+a8UlQpbGaAZSwiVI72QvTVXROEPBwN+IKNs7bGWke5WQ1Yf
	 IK4uonXm426Dmc/XOTk8a+BOTbszmq0akX8fssiy+Bnf2ZrYGhnwsMfT5ibb40/eCnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Re4nznSN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z8FfQ7g5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFFF606C6C0
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CFFF606C6C0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Re4nznSN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z8FfQ7g5
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8F9iD3267865
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S7Xg2vGeJzK/amaGgwLRI/lApgi2Uub6jwZHNBWQ3u4=; b=Re4nznSNXCExMHMm
	9m9s4nt2irbhXDYytwghS+frh2ODnBR9PC7dVYIMdgcGrD7Tsv5FtblauPJDb5CN
	RN+ApNHAzdVpA1lcXHDHDnjjPA16Qefq2urBpL2LWzv+mQSPYr7cKPCtbajK7R22
	JvGeRvuGeJesNmSi/3HPOi5iRYaCLVZ4CXDe6k6mW2McRyFkHu68yNBV0+B6mzrQ
	7fBGfk0Q78xP//M3NxUrxxep729h2K4kijeDXwJai5BzRSB1+VQmOhoAYb052wm8
	kZKha3wRDwoPtXyRJOLVBk8Hnsp1f0MjFbhadl9pdOfd5L6iY8pX7E9rTX44aSHN
	hmcXJQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qjkrx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3adf71ee6a5so820931a91.2
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 04:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793358042; cv=none;
        d=google.com; s=arc-20260327;
        b=AWHliXv7ysL8OulnHFTmtLFNXCFK5jdkrbRRACDKacVjn+dlCFx0vdheBd8+vplCgO
         q70vaJvv0wfvJcEZ0Zilsx1vCTTnj4TPyosTsOmnpmCIeQJ7vQcYAq7MuejjU3r0QMus
         NSx7hmEjmzi/gu5c10+X7CRV1p7Wb4UXTHcktMFP8uhB058kMLsYRk97VWF+kWTzIN1/
         C5hqPDEV7EvMitVD2wsr5Jl7uLuCC352AQTQtXW1vppUDgNblgAWeqXaSZ2lS5UIhoa/
         LARoTe/PAZfrtBeXdO6ftRcFFgdYKWyWVAOWc9Z6RZlPpglw34wLf5bp+v+MgTSBPiav
         HnCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S7Xg2vGeJzK/amaGgwLRI/lApgi2Uub6jwZHNBWQ3u4=;
        fh=8szs+g8xb4hiGznvVEJ42dTVlocnLwxkw8RFTQKoFb0=;
        b=U0b3XEvQotMhGoFZlr6/Hbuw2dDWuh2KQKnjTtAxkdGnF34NnSVblopcn3P6Vx43h5
         Oi7utIyCVBuX7Zbu90OcJvgzsElOYW4E9EfN3s6/lSzGMUBWEUXh2MauFUgs80gTjuc8
         raIaeudaP0562798JjG1sYpAdiCS6rh5leR5lpfEPKEAZEV2exZjLffsILUP44njkX9q
         wqSH9WQKtmvFGIPHnb3+h486PXAt2+9K+SAHE/J7BPWUV0hpi40/0xBa9E31Y2Cr6NRl
         yfBVcYZH6ulgQ8BlOj+harLHInSHYanpOZ8LmNlWrNi3XQ6szEuxPedO8VkhyHUMY1cv
         habw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793358042; x=1793962842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S7Xg2vGeJzK/amaGgwLRI/lApgi2Uub6jwZHNBWQ3u4=;
        b=Z8FfQ7g5bbCHIHkZuI3LJyyxjJDRyaw0uFexvwxJMcEJtnxyyD/DlGXJf/LmpG1un5
         kNRqsvkGG/2KT6elkCT6smtterY/nhVsitCuRRYLgX3EEy6LLWQ8nTDI0z0lnpAA5A1F
         TnsiaEfogQkHeHcJY4GvSLvshxqxmaSppwKNnoQekF7Q6LAsjLrUj2uErU0yRSRzIusH
         f5HU1//YETQLx8mJKkm/LNoU5K3pJKxR47t6cAohjawrCJJOG+dproDlu/Hoh+uR863O
         t9Pn+8GGfEkRisCLZX/NRudX42zwlgNzKYe0xU7O2j2RHz+uxTRGb7IqUj3cKoF5qBwf
         lr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793358042; x=1793962842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S7Xg2vGeJzK/amaGgwLRI/lApgi2Uub6jwZHNBWQ3u4=;
        b=YEnM6OrIRyzEHGKQewoCAEtWVWeAnCPirH8Yg8rmLi1pffGkiqeJw692fS4unZbtdc
         8UNOpE19xDFO6/wK6iiIK+86ynSUCXRjdi7MQd7pnrTR0vHnC1bivsJrB1kjubN+3LnI
         I/+L7UPvdanDtEyzbRAFdHhYn7ZiU2A6s9iw7pCGA8VV82pmml0MhDru38c2ZkAPTeyC
         GRcdUmovR6qXyPfXDXvUtkaIJO69LZSKsU/k9qEoHu6d4yx4SoX9YsIzzIGUakYl106N
         ZGcGU0mHspBzBXXrEAD+UxjnjkPMlf3iKQVas69TNkSLe9PFE+eNlT8ocw0Uxd0oKjKA
         RgAA==
X-Forwarded-Encrypted: i=1; AKwUvBwWcGr9HXAfmk2amVVXejwO1rpw5lqqiv4VqccdzXw2WYDHyTW4KMOqnfTX5sR3dzfb3NaRTRT92Bw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqDyOrMv7I8D6QIDWKogERvq8SNFM1kOKgdAfksBjkzkWKTl2a
	S9UCz7drKbz5TuC69buZWX/Wf0q9QDguZmjfgXtG4t/HNd+R1U5ON9orcb4jzNQokDJBtH/a58V
	aVFAGCFezarltci8nUtEe+lvFsh7bg9SAgr9swlqz4lCXtDQVN2xG66xubSNepbOncy7JDMXyL9
	gm7o4x/+5uUt7I8stmrNUA/cNn6Bhd966vlFpQIw==
X-Gm-Gg: AYBFou1NEfiwEmlAucNHh42+mhbPTdS3EVCYaHgvt+ZgBSswVqjiMwtoXK4W0j1TY0H
	yjj9hCx45khqLv+J6mvaaKSRF3ElXUEBQcrZ+oyLef9wNjnMRC0QXgjgxv5nUuK3X98nELu4IZx
	mzQjyvOTOORh+fHB14bJXggX/ZHjjHZ3eEs7gdk92BUUn9L0vREJbzInXtsg==
X-Received: by 2002:a17:90b:584c:b0:3ab:d26b:c2d1 with SMTP id 98e67ed59e1d1-3ae89724955mr1586111a91.11.1793358042376;
        Fri, 30 Oct 2026 04:00:42 -0700 (PDT)
X-Received: by 2002:a17:90b:584c:b0:3ab:d26b:c2d1 with SMTP id
 98e67ed59e1d1-3ae89724955mr1586088a91.11.1793358041880; Fri, 30 Oct 2026
 04:00:41 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020140743.2765011-1-bruceli20040604@gmail.com>
In-Reply-To: <20261020140743.2765011-1-bruceli20040604@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 12:00:30 +0100
X-Gm-Features: AclHuK-8I4I6OlbthS0jN4vk_MeSDsmg6sB27-NI9aRz5ijsyEpNPQ6o5hrWtN8
Message-ID: <CAPx+jO-fVQ1kt=aeOG9fkZGo8qBNVBdNk7PdKNOEFWfDAPkXTg@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: fix PDC bounce buffer use-after-free
To: Guanxin Li <bruceli20040604@gmail.com>
Cc: Aubin Constans <aubin.constans@microchip.com>,
        Ulf Hansson <ulfh@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfX1ZaGWGvV/2wz
 oE2cKXNux9pX5WtIjiu8AfWbGKhkzHG7mFjDBl8SllYhLQO6ICytvUxmpLVT2qa9FWtUKNBxi1K
 XeClN9Q4BKbmu15kjUBuPnU+EwDaZ6rvcgISAmyQwqNrHrV4/dzVli3in6mmJYwIC+TDG+tvIhi
 ZhEFa8RgCyM48W1xeajnQJdGHnepALoC67H5bhEaJlME5UTqrILkoVdzNUozBcqqlVwJeB+U1E7
 2pz3q8OS5z7zlBp894b9UyTYLyKzvUGMGpp9xv8KdIX3ecFS+NmmPBYjT4RNWtsgvPPCR8rC5nT
 pL3ZeNfeZN8fpFlCYCNmxnZTDIULn72OWjkpEFZbkA67T3bFN+dQnMRrOAh7JozmMuUiKj+m9SO
 RmT82qVhYoy0ALQmNWo38Wp2lCYfNCHRCjXHOHk5ZP9q1fwqh3AGCbK22cPCqe1NoozgUbyAPqI
 dYAIeKiRLP05BcwVa0g==
X-Proofpoint-ORIG-GUID: 5pSGVbrEUFbYOM_xAjT5kMaRARk1AYzz
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae478db cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8 a=gKiUwDw30W1Mxb9jGGUA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfX9wdUyv4a17pr
 xoPNYQC3/tXSLSvXmiEin6crLTm2Ar2PP4C8aJZvvX/IK+1lyLerQgrXkd1/guVnx7ypLd7Qf9R
 jBz+52REYzSV+peEsAUtC20Ed8NTYls=
X-Proofpoint-GUID: 5pSGVbrEUFbYOM_xAjT5kMaRARk1AYzz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300043

On Tue, Oct 20, 2026 at 4:08=E2=80=AFPM Guanxin Li <bruceli20040604@gmail.c=
om> wrote:
>
> atmci_remove() currently frees the coherent PDC buffer immediately
> after pm_runtime_get_sync(), before the controller and its interrupt
> handler have been quiesced.
>
> A pending RXBUFF or TXBUFE interrupt can enter atmci_interrupt() after
> the buffer has been freed. For a completed receive transfer,
> atmci_pdc_complete() accesses host->buffer while copying received data
> to the request scatterlist. When data remains, the interrupt handler
> can instead call atmci_pdc_set_both_buf(), which may program
> host->buf_phys_addr back into the PDC and make the PDC access a freed
> coherent allocation.
>
> The buffer must also remain valid while atmci_cleanup_slot() calls
> mmc_remove_host(), since an in-flight request may complete during host
> removal and take the same interrupt paths.
>
> Move dma_free_coherent() after the controller is disabled, the timer
> and IRQ handler are synchronized, and bh_work is canceled. Keep the
> remaining teardown order unchanged so that in-flight requests can
> finish before the buffer is released.
>
> Signed-off-by: Guanxin Li <bruceli20040604@gmail.com>

Applied for next, thanks!

While at it, I noticed that a similar problem exists in ->probe(). The
dma buffer is allocated *after* mmc_add_host() is called. You may want
to fix that too!?

Kind regards
Uffe


> ---
>  drivers/mmc/host/atmel-mci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 8f4df250a77a..7f1a5864da96 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2592,9 +2592,6 @@ static void atmci_remove(struct platform_device *pd=
ev)
>
>         pm_runtime_get_sync(dev);
>
> -       if (host->buffer)
> -               dma_free_coherent(dev, host->buf_size, host->buffer, host=
->buf_phys_addr);
> -
>         for (i =3D 0; i < ATMCI_MAX_NR_SLOTS; i++) {
>                 if (host->slot[i])
>                         atmci_cleanup_slot(host->slot[i], i);
> @@ -2612,6 +2609,9 @@ static void atmci_remove(struct platform_device *pd=
ev)
>
>         cancel_work_sync(&host->bh_work);
>
> +       if (host->buffer)
> +               dma_free_coherent(dev, host->buf_size, host->buffer, host=
->buf_phys_addr);
> +
>         clk_disable_unprepare(host->mck);
>
>         pm_runtime_disable(dev);
> --
> 2.43.0
>
