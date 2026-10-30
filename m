Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793368116;
	b=OfEYV0ypAZEXPuM99LfJOEfh31MPcPqhaa3nvo7r5mFf75bEjJHY4mhVSGSyZpW1Kp+9
	 MOuLaoHESKy3eLHdwGljA1/jK909x+iLqWAAj2gX7nqoOFwCrgFKZIDn/xZourMh9r+JG
	 2LBvc8a099n0POtaSnubPaFyo5+lmTc6oLQsmv49MiR1UJV7E+SpHr5F1qngfjp7cdubi
	 R7T0dRZcfUbJF6jGqYKOdX+dYpTNX7eG14VlJhN938sPIsJZXxwQo1vxMCFFOUWwV0qfC
	 5P7o3CA4ORPPHXXlkNSyUelyFV3eVaM6AbFTUS+Y3MzPdReIn4+621W1I65O7OLkY6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368116;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=SmUXIOYlZlxH85m2DVy0bxyeuAHl0OHWFMsew9sjAhY=;
	b=vLMW0hiWmbBl6gfwcc8o9NiQ2zmG2S9xFbPaAC/6SW6MLW/eYX56U3jpvF2zzeRZAK0r
	 cihYcQ39goMV+Q5wdHl3a4Ddf//lmufhwaz5VX/Bb8JifJeG09egyfMHhE3CsogoHvIsk
	 BgL5bj8Gk5d8f7SpPv+kFVcWpbUX4YVL8M3ycF/N9QqjglDXafmcC6kVJJThNjxrt6OiM
	 9XouRBHe9ubzs0U1qR9cyoyv6KvDEvPkeRSirKpTvuvLarg2dRt/dX62AhOeBkxYqitVX
	 G8BHkKUWXqx30ZmTQ/jNUCsId8ljR+5Q6rgfsOGIqs0EISH4nVwk5ygrFUWmemsnpkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="c/DM/FsE";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="PHP/3giT";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3FD606A31D
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 13:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD3FD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c/DM/FsE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PHP/3giT
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBG4cd3142141
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 13:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SmUXIOYlZlxH85m2DVy0bxyeuAHl0OHWFMsew9sjAhY=; b=c/DM/FsE/PvGatCB
	uHka36ASu+RBqlZXDh5c8v44vLCvMz2Fnr+EuIlLGWP2mMLccbfKE+cOMDb3uuQz
	JtFSPlJv57t9N87udPL5JGi5jaQVD37tfqZsJVQSJzfgyp9yKJpmhaJH0pT2ndzF
	S7A2M1SDtNhxRq8PXeAw23yGyoLTMp3sfAWaCWi/ZurIet2YDe0WmR68qfxlJ+XS
	bgrGbP522PgSkVI85u73Z60H3ULAg2bgQ8e+a75pK4Dlisjw1S9yAkZO0jRgNEex
	ZY5Nrsi/BKmyhc49WC5EQl+1lyMzNnRdz1I1yn9zSusITE5lyA0PEOH9neHB4RVX
	BGsZ1g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qk99f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 13:48:34 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a0619b1fe5so615018b3a.3
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 06:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793368114; cv=none;
        d=google.com; s=arc-20260327;
        b=PCpbhV4oMH8DkNym7PbMhwYdnOOZdv3x+VWU6HzhlkxEdOVUmSbRZ4Wr0VRUdmzSc0
         5HpqYJb5peBlA8L2buS8xX4smun/AQZepYgn6DYs4frSwNXHMXzsbMmeRhHy+hVGNF1+
         24CC9jmTYHA5sEQSZbk6rR3D730VHuU4jxpOaajmcOUsdrQTKmnavX5AbpLELzFmBsKR
         WGMIGIiSRNI3c4svZXxNRkZeAvfj/gVFg7Oil0rwicWREIOC/C60wlXoV9NESrhG6ZA7
         gNiXmA9E8GBPijxfzGAubDdy+bR32k2BUW14TzmL13UBopPfILKvrLTwnpw00xfeF92E
         EG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SmUXIOYlZlxH85m2DVy0bxyeuAHl0OHWFMsew9sjAhY=;
        fh=dXdVEiz5lpMT1KSbB24g66Ep3xQlBUXzcrR0W6FsE5A=;
        b=OaORVXvpp2Esw9ggE0XiAK1074cyr3Ok0BE3sD35WGZxvqhbJOMNSAClvI5urGsKmI
         ufsYAAgGXu55LakPuy/pCuGr2vqlGXAVAsgUGKimVu99tQkfr8HNhbOcWCuXpO48bLmu
         tviVLgn1tD2McbLs3hJZg60tlKy+JqDwQX+inWlts6Qt7iGXe9O1socuWXLdzj6cOQfz
         s1mAE3Ao07xH+5Uep6PMkANMhfNiqVJihw5DXpPckFtYVMz47g/FufDTHgy7A0eQDTDZ
         QRP/pdVaQdYSAOcMg09f6HE2sAhHtWzsiA809ZL/rH5XtnGw44TL9AR2S4+msiYrZuGl
         m2mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793368114; x=1793972914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SmUXIOYlZlxH85m2DVy0bxyeuAHl0OHWFMsew9sjAhY=;
        b=PHP/3giTjMF7lKWza8bh+CiK/BFOIvtrR+339gILA4p1/LALnjUX2e4K7B6LcXSlVM
         R+G/uh+XluMWaYMFmZT904UKTJvGWDd+lEvapAKIdNf+8/UP3l9lfor2sr4zSpaLEJAL
         LcDr63kqNW5OY+xig4kbPGqOfwBaddFNRVBshFx/J2IWVmKfYVaR2rKcscVCrtQdB8Nd
         wrE4LpTyKZFWHrCgmUSsNVjuv9XUpVTrTqXm3B97Ca+BxggO+W8RJhBCYSP27aIOoPrX
         52zTkFCP8LZ8N4AiN1Wv2EAJvJ4E9HsCD75TKbOJlCtN3hPUSn/l3miVbRBfH/X28hMT
         0Q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368114; x=1793972914;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SmUXIOYlZlxH85m2DVy0bxyeuAHl0OHWFMsew9sjAhY=;
        b=x8NYfpgyPCIB5DnZbeMyEzhil3+1cPDuE1fschCWX+qw+/kEPw0YrLMvVkWxmeOAvn
         NqZ0t9GcTpIqg8EVhDQeiwf+kb5PBYsaQ6ZUl8zIe8Ii8J+WUgIepJIiCQaneqt65Aks
         JqfriouEo8wEub/OZEJimfnyzR5nue76kANmhh9RqGpvJaNR7EOZZgCdbWlkaEfphjEP
         ZhB6sj0DM3yBBzE08/WEaJ4gCWOFXxaKgccPPSSFcG/h/2sEZpH7k3uUI429mT2QitkY
         LQFLNdPw8mKr7PP1iQAAxRH6/mL+LCCs9Jv+WwDOgYxUm5S490yJR/0dqHBFwZ6FCC9L
         uW6Q==
X-Forwarded-Encrypted: i=1; AKwUvBwU7Oi6sm/dVVdHQaQ6+an7Lhzyji/ywThpIBMMdY8n9bA0FvrugTiWTLsJROAQP37lgH2sTtZpkYM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhr4Irgwxo/BD8xZUQn/wYKRrB/cxx51KxtaP0q8ALU8PIHZnV
	3P8GitJ8icKJeeNG17ooeGXyn7WbknRD62V5K7ZeW7jpCGhn42Mt3cQR2miFCZ6ct+ZR6ZtKi/z
	9Uom+InteQCGOpKW9ZYPGDugOXYDKWI1HNNR2879m/qvsvTfU1Re6jA76C+55iDjgeYQSCiiPN9
	W8X1VxCnL7BDwabACnDeapplgFXu01qB/UCOrxtQ==
X-Gm-Gg: AYBFou2QqfM69kd/G5ReZwdNEftTaPzaprXDvOYQCpOfePMehrVLwMo2eeGXcRGk6Jl
	qS7wB5BwZs8iwfxmRZCHF3i2Nk35pOgvLuC2nYWpVKA5jIcdSIxhUXkFTXGbqMw/259J6MLrcW4
	Y2mEgJ5dwsYXG8otJOWVhICnJCsgZJ4ueo7gyEmQfkoVO4puYPjTrK5HkHyQ==
X-Received: by 2002:a05:6a00:419a:b0:89e:e781:eec8 with SMTP id d2e1a72fcca58-8a9bea6ab26mr1853279b3a.27.1793368113554;
        Fri, 30 Oct 2026 06:48:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:419a:b0:89e:e781:eec8 with SMTP id
 d2e1a72fcca58-8a9bea6ab26mr1853252b3a.27.1793368112912; Fri, 30 Oct 2026
 06:48:32 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179318778660.81375.11263258280496155344@manyhobbies.com>
In-Reply-To: <179318778660.81375.11263258280496155344@manyhobbies.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 14:48:19 +0100
X-Gm-Features: AclHuK9CCkGJy9uu3I3U-z2HN0uRBI4HDWUAxzxMZ9SG5mkVVBtQ_beC3L-ge70
Message-ID: <CAPx+jO_VxJctXCZMVdzeq4CX-Ru7ACM6=wQ7GMdG2+4F1pOcBQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sunxi: reset the controller after an update-clock timeout
To: Tam Do <tam.do@manyhobbies.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, linux-mmc@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: k9A6ThYSjV5Nk1OKr_TZ6En9Dy7wxMfo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX1TZhefXP+/2t
 kqnUWZ4hsChpdbdo1tgNEBJtGzHpaz99O85Pw/6OPj6wf1XBJgqho7vPRUcneMDNKiGfqhJyroh
 0V+5UStdRNJE3Xiw11eshffyTQXfQck=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX5V3pekxAiOAc
 9yVdGECHBhmJ8m2EsWu+5uZy4GcBUHXMy5jkzeAATL3Vlp5kL523/XSRLy0mdLq9I59CRt0nQ8Z
 m5h9yqKJSW1ZSA2hv5xHpJgCHui2VyVAYqPwK0LbN3EfKTVgw7lt3xAg4XZ0caisPbflkyjHIwX
 fdu+nx33yZWdsflS8xS/DeaEfuOiPlSRbGvBIcu+0NIafyfN7mY2t3tMd2fsXNhHbYdtVg+n/l4
 IDmTM4tMbATOdKTFGCGO1xJIdhS30yLKiDLGLVmaSYu1fK1KRmwIqdblEJErzEtSLxJ0+GfMvtt
 7lvdKrZtu9kPeveBE3ZKaqXD0nWooTKUsUtg7yt0B9ssKxIoHNFTTXEBYOHrlQJD3wqbaspKrdx
 G5XMqkukEGjhYAPHxK5GopKYCHTXueCoFDhOTiHUBt20F352tnPA2FhMnwTt7EO2XwCYKTICxrV
 mY+p7qmBGMUEQGJgdnw==
X-Proofpoint-ORIG-GUID: k9A6ThYSjV5Nk1OKr_TZ6En9Dy7wxMfo
X-Authority-Analysis: v=2.4 cv=TpVzFzXh c=1 sm=1 tr=0 ts=6ae4a032 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=w2OPf45SAAAA:8
 a=BQrJblB4Y1Zt2l009CUA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=-iXIJKm6ftRzmWoHelNS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300054

On Wed, Oct 28, 2026 at 12:43=E2=80=AFPM Tam Do <tam.do@manyhobbies.com> wr=
ote:
>
> If the clock-update command times out it stays pending in the
> controller, and every later clock update times out as well, so the
> card cannot be initialised until the next probe.
>
> This happens on an R16 board whose SDIO Wi-Fi holds DAT0 busy while
> its supply comes up during the first clock update.

It would be nice if you could elaborate a bit more on what goes on here.

I assume it's sunxi_mmc_oclk_onoff() that is being called and it's the
loop in there that times out. The question is then, under what
circumstances are sunxi_mmc_oclk_onoff() being called when we are also
waiting for the SDIO card to release the busy indication on DAT0?

>
> Reset the controller on timeout so the next attempt can succeed. This
> runs sunxi_mmc_init_host() with the interrupt enabled for the first
> time, so write REG_IMASK from sdio_imask under host->lock, as
> sunxi_mmc_enable_sdio_irq() updates both under that lock.
>
> Fixes: 3cbcb16095f9 ("mmc: sunxi: Add driver for SD/MMC hosts found on Al=
lwinner sunxi SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tam Do <tam.do@manyhobbies.com>

Kind regards
Uffe

> ---
> v3: take host->lock only around the REG_IMASK write in
>     sunxi_mmc_init_host(), not across the reset; v2 polled the reset on
>     jiffies with interrupts off. The return value stays unchecked, as in
>     sunxi_mmc_runtime_resume(): if the reset itself times out the
>     controller is wedged either way.
> v2: held host->lock across the reset (not posted)
> v1: https://lore.kernel.org/all/179307312104.39863.12372814163472848752@m=
anyhobbies.com/
>
>  drivers/mmc/host/sunxi-mmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index fe4c0f6d73f3..55313780d06d 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -322,6 +322,7 @@ static int sunxi_mmc_reset_host(struct sunxi_mmc_host=
 *host)
>
>  static int sunxi_mmc_init_host(struct sunxi_mmc_host *host)
>  {
> +       unsigned long flags;
>         u32 rval;
>
>         if (sunxi_mmc_reset_host(host))
> @@ -336,7 +337,9 @@ static int sunxi_mmc_init_host(struct sunxi_mmc_host =
*host)
>         /* Maximum timeout value */
>         mmc_writel(host, REG_TMOUT, 0xffffffff);
>         /* Unmask SDIO interrupt if needed */
> +       spin_lock_irqsave(&host->lock, flags);
>         mmc_writel(host, REG_IMASK, host->sdio_imask);
> +       spin_unlock_irqrestore(&host->lock, flags);
>         /* Clear all pending interrupts */
>         mmc_writel(host, REG_RINTR, 0xffffffff);
>         /* Debug register? undocumented */
> @@ -688,6 +691,7 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host=
 *host, u32 oclk_en)
>
>         if (rval & SDXC_START) {
>                 dev_err(mmc_dev(host->mmc), "fatal err update clk timeout=
\n");
> +               sunxi_mmc_init_host(host);
>                 return -EIO;
>         }
>
> --
> 2.39.5
>
