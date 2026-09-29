Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6622A52BE34
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688865; cv=pass; b=VCh6ANxcaHQsXLO2FA/c3UXeQ6e59gQwZkOwEXMpzfNQNXfCMbEfnlTpzdFH53wSrIe44CBHFLB8AJdzKuoqyLzH8MuZqJH4p/uLIgO6RamttPi/5Q2ygNp+QgCHpavEv+xoN9IuOxDIkG3iHAVUkEweQFN/SSubenvZi/wy+f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688865; c=relaxed/simple;
	bh=Oxke+nUuBI3tFzzh3rUkhEXkh6EDyem4J8N9oijfJyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cF8tVxl45+re/RBvrARRlGz6hCWUWGxYOVbx1E6X6dNy5VDI80J8eas6agx2xZXtNQd/6/s8PyKqPGqXJ6D4Udw28E8wuF3QBw1JtzwmaA51+Bd8zYNzrTjntQE4OXfcqnKfGjOxz09IPXMWbJxl06OkG0Zn8xSuPvb6NQGNuJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L6B7PzQ9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IhynAvsV; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L6B7PzQ9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IhynAvsV"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqhiP4151435
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cyq/qi3S500SGfwY/Y16YA84HAzf4qjNnDv4FUrmnpc=; b=L6B7PzQ95luu6NSG
	tsplhetaATkbBDwcRKq8CZ5b99fh0r7298NXSO8pG1pbyZRNpOtnYDPyY2SUlmIA
	DXpQFOPFgcEosHgzA1mWB8f5WcaOCvzpSOn6IDRGGxMiV/7B8zL1AlNys3JmH2Nv
	uegLL5iUVnQHi3cQ3QhYyLzPRbBILozBJ2IeXFv9P371N4f2sewC3FFbR08SkC3r
	vYyA+4ej2h0ZqsQ5lwgUChjLaaAoGy8mu+1i6WJ+AEBq81Sa3ekEgGOxZvEqke/n
	Rub++tHob4UusV6U6x8zH99gxPR3/Se0HtilbUTL5Mm+WzSssewmOqO9tJimULTn
	X3u6cw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvwnc9w6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:22 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc795ad1f5aso2324405a12.2
        for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 06:34:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790688862; cv=none;
        d=google.com; s=arc-20260327;
        b=DS6LNjxV4Rj2zENmrdtTs3iUq8y0Gb9JQWzCSEu9GSsbKQTO0aR9nJi8rcgk6v9nWO
         fBRPr9yKKNd/5N1EhcKhmQmZVl3rmqTPyLyUlcPIiJ9zjA5Qg8YwpK4kFdtAnrxd+CiJ
         PxPOKmdIhY29TuPlZUACXwdaLO0LnVQu9+QTLumhzouvRiEwuQDKKViYeB8lZFINFnyj
         uGFvcQqk+VyPJpkt7x5d5Llqe2KMsox5EY0srJv0kHz9ctxCPSynLNomJFS4ypWzabFn
         PZF5oaCD0FmONoTotel7lbFvvFDYXPSu/vy9H0HJucZ2OGvLFNYnnTaSqUVSlxqMu2f8
         V20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cyq/qi3S500SGfwY/Y16YA84HAzf4qjNnDv4FUrmnpc=;
        fh=qc2w9X86J4T38FuD9gvLBO4D7M4K9wfgZhc2Td0cUrk=;
        b=Q9736zvA5VSweadpFocjMFlucL0tFZQbMUMNsyVi0+FVnBAFn5z2ueLYDPwG92/CgC
         xy0ld4LnOeauXSXsv8WJJJmDlw+XnEaedGI2Hiq4XMx+yBJ+2RO0Y/1Yv4mxVWIrob7I
         3DkTCYAovnMPCfGT3J8/EJ+aNYrtCjNyzATmANGWWuUkasTjIVhM2qUDKHsFEAGUA11Q
         +BqGZbqR8AyuBp1hH1ferdkXYfOYWCMyoQI9L8wz0bxH6riey0+xEof/uZn60dJnJQCb
         y5/ujn1AaVrdy9Ft0kImJjz7jCHZf/wYR1wxreuPJRljfuKMRHvNvNOB67KrIPxBeJQ9
         dZNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790688862; x=1791293662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cyq/qi3S500SGfwY/Y16YA84HAzf4qjNnDv4FUrmnpc=;
        b=IhynAvsVzsEkKcUJHYX2GE4gsSyCNr6fbkp18J6nwNT+QhRm1wdYrp9/3C9yLWhrrS
         BT7vvuh3OO0I19CfCib2fflKJLbO4QGqlQjej5GaGNXDinLMPCwZL/ShjsTmAFQPdvLz
         5a6HvgrAmxHhOOEuULU4GAOX3dRKUKQRC6Ir6h1hddXhneQOnIH3HNbhBQCwaCT2OTvZ
         Zuffg2OQlXLJNnvnSIB4+qC0AwsTShZFriKH98iXizpRQM7Tv7xAWcwPp+ZXmbbwnLuH
         87ooYLTdO0nxfcEAQLXau/PWBqmt2TxBLf06xzSDHOHFAemvL2gW4VaHuZfoPEHehxEy
         5/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688862; x=1791293662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cyq/qi3S500SGfwY/Y16YA84HAzf4qjNnDv4FUrmnpc=;
        b=eQa2htB7/LZbTyjaizR6YaWZq/K0ME1gwf3RfKzxjlFIygx7EK/0k2WYxjdJmy0J0O
         TgaUxvtPelH8U/DdvET/Tmiz9nXquiDksdm9VQ9xFKvxF9N2LZtz5KOVw0FHrCztKuxj
         HC4fSTgkdSTrFvnRX9mbOuKTbZVBZf2kCg1H9cmMEzEMiPiHudxk9gNjkc1yu2iCK1Qy
         In60cVqSQ5vKO4ISoleYUKV9fm4uP/+Nh+/QlIFYjSNmEPrNRhyZvogQPPKaja/iMytt
         AqclFfAlScxIhociPPG1PZ4CEs7NGYh9BPI1E0Ncc7QhyFuXi4X7DHMSDYTlfyXnfSnD
         I8Ag==
X-Forwarded-Encrypted: i=1; AKwUvBzkkENNo+gfZZdxamAIELehp9ijH8/QDXYamngGmc89aZ1FG2fY7YEGRUlZPSyRPxoPcV4Zl5/Nd4c=@vger.kernel.org
X-Gm-Message-State: AFuF++lKPWo0rfPMHnPAMWc2BYu+QdM2FfepACahrJ9oLMc4i0lbMlzI
	aPW189sV1oG3p42fYUEmQll2lWnPOrqc7dNdwjxhQ/JvmGUnbJZfpeP9WSzh7o7KE6+lk3/kSi7
	N5fmSMlcrX1iFQEJrl4BpbENYjtzBKqZE+6yPsG2nSQcZZzkraUnUCz4zeMQkhyEdEQP31qrX5U
	9SMnGTUJi4szmfv3V91xPQproaN3E/+p1aQgF2qQ==
X-Gm-Gg: AYBFou10PGCzNgwRuJyvPOI/JAhRGA7ciA6WHp/5Bs8paLuP1GAvsiekK6/+a3rpieu
	+Yf2PZmiP7lV6ymVdVYu6D7ePNfjNDG5DfOy4bflhHC1gDWr3a6zYIVQyTCE+2kO9pm+h9Vs2MF
	ghG/bfrUjVXd+Ts7APFDnRWDYBHNwUgs8WNfHH1oCLBbd8ybb+c3AB1wNttw==
X-Received: by 2002:a05:6a20:ce4a:b0:3dd:a196:906c with SMTP id adf61e73a8af0-3de0e906a84mr14829053637.54.1790688861839;
        Tue, 29 Sep 2026 06:34:21 -0700 (PDT)
X-Received: by 2002:a05:6a20:ce4a:b0:3dd:a196:906c with SMTP id
 adf61e73a8af0-3de0e906a84mr14829018637.54.1790688861357; Tue, 29 Sep 2026
 06:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918141810.3023069-1-peng.fan@oss.nxp.com>
In-Reply-To: <20260918141810.3023069-1-peng.fan@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 15:34:10 +0200
X-Gm-Features: AclHuK-HxDdPv6ZXo6bbLEOpc-R3pQ2RLvsBtUn3eOlCmwt_WjOTqzddYREOXeM
Message-ID: <CAPx+jO_L0HKe87FbLcM_VBEqrqz1gLCUwAV+ZE7CWU9v-d0vTQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: use assign_bit() where applicable
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Aubin Constans <aubin.constans@microchip.com>,
        Ulf Hansson <ulfh@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kees Cook <kees@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: fp4vdVAKLlUL0fXB0z3GFHIb_esnesyx
X-Authority-Analysis: v=2.4 cv=W42txhWk c=1 sm=1 tr=0 ts=6abbbe5e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=8AirrxEcAAAA:8 a=4RwzDxXCS1lGNT27iAEA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX86Ce9JE379QL
 0VoTlKfLYuZM5yP7y1PvZO1JjQE10+L03IowvvAhweIB4QIbTx8G6ieCSHzINB3E9kAM7fDI6E/
 aFCqqmugxFVsGIx7qZMxVknG303HRmj93KffAPPxKb2ZwPqvDD02ldaF9dvkUwLbIutv11O5IC2
 2Ui9H8ZK47a+U67o7a5xQV+GExszfofqeni3aIjnnjKJoCiRR+uX885vEmVwBJw5Rr8xAih3l20
 H9MubVooA8y4s8Ar12rb/RHzDe920L/iDRs9VZTwCAHP2+Y01kwji3bramMmwdpTD2uxsTrLq/b
 PpfSr5GrWdCSMxZqtGN8vHkgBLXsxJOpwe0AfEaKPgwQknR1w8B5m1jhmSHRaL9e+HMCVCMgAqO
 Ks1CoP2wL31GcdYA6TnvMcRkL5O3f13W6eckf11hI2j/lg1oM84d9hOgwtnEHUA0gQxNqmpIbzN
 WYD1hxzn99iYl/SP4sw==
X-Proofpoint-GUID: fp4vdVAKLlUL0fXB0z3GFHIb_esnesyx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX8ZfGyaLp31iL
 3R0YSJizC/5w7nwjEaNcSN+MYXdlNCrcbTQDRX4Y6WYgMxHIGBNf2raQfyJj8az6weyxug3wKA3
 eoc+zIrM+RIYjaxsWe9b/Agj4tqDtJE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290054

On Fri, Sep 18, 2026 at 4:20=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Convert open-coded if/else with set_bit/clear_bit and their
> non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
> API.
>
> Done with Coccinelle semantic patch and manual fixups.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/atmel-mci.c | 5 +----
>  drivers/mmc/host/ushc.c      | 5 +----
>  2 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 8f4df250a77a..98933be5f174 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1677,10 +1677,7 @@ static void atmci_detect_change(struct timer_list =
*t)
>
>                 spin_lock(&host->lock);
>
> -               if (!present)
> -                       clear_bit(ATMCI_CARD_PRESENT, &slot->flags);
> -               else
> -                       set_bit(ATMCI_CARD_PRESENT, &slot->flags);
> +               assign_bit(ATMCI_CARD_PRESENT, &slot->flags, present);
>
>                 /* Clean up queue if present */
>                 mrq =3D slot->mrq;
> diff --git a/drivers/mmc/host/ushc.c b/drivers/mmc/host/ushc.c
> index 7e8af5a06ac9..410e5bb62752 100644
> --- a/drivers/mmc/host/ushc.c
> +++ b/drivers/mmc/host/ushc.c
> @@ -388,10 +388,7 @@ static void ushc_enable_sdio_irq(struct mmc_host *mm=
c, int enable)
>  {
>         struct ushc_data *ushc =3D mmc_priv(mmc);
>
> -       if (enable)
> -               set_bit(INT_EN, &ushc->flags);
> -       else
> -               clear_bit(INT_EN, &ushc->flags);
> +       assign_bit(INT_EN, &ushc->flags, enable);
>  }
>
>  static void ushc_clean_up(struct ushc_data *ushc)
> --
> 2.51.0
>
