Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795790648;
	b=5B9jEVN3sBEaT4iY3bsLrmUe3Tl/eQGeEgxaWHTu/XbUJp2OFFn8POJ1CP6afXpsATPm
	 DBjdPzmhFnozorZyjrP8BPtHOO7uGsMvcOH1SyY+WWPjcL/nHVm1PkFW8TXEhSkFUGCWH
	 PH4kvlC3Ismv6CSO4xc8yPCCqEqbjHlml3KG5UBpR5lVRtGyPZ+hycJOSGeEnhbrqJwtV
	 6pe5a6k/+3On69tDt0IJvFsjHttk8FnR4a0jVROXZVikNSnyc7C/tiW0CxwCNIMeu5mEE
	 kIdAqBAiIiBgmwy2nhs12OD3hP8DNEmHHhCiHfyALdyljK4JWciaKqm9dvZA2Y4aZHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790648;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FUslzatqdG6yHIQ62LqDyuny1brH16kWHD481raY6IY=;
	b=ExGYqXs1I1+Lb8T4q8fJ7rdWm2dmyb6dHh1sxTHcskV0Dbt6PQBIAXuI1SNt1KZ4bHPy
	 eAUFPAnHsOt+C0gndy6KFXzWSyXcz4Hh5Ctfqj79ccsEdWUvKcprs+d29grnH6O6HwMxF
	 RTDMxZTpdYjn2X1Xwx9SgAZYktvUulsf3RTdWeuhiYnlWNDgCTwl4HmSGxYekWOyz6I6W
	 dpl8dgeNNbtvUi2PaZs1I2ri4tOGFGtpNPsLzP67UGXk68f8GjVOYJG7bzeGiKqRwA7E7
	 NzlE6o81tfAA/AkPzuAp2Ks//LPOUgFM94c5dWKoTMyv1+YqNbeIw+4DCpmLUJP/KiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="MUBBIfN/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F+icJszI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B14606A334
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70B14606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MUBBIfN/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F+icJszI
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1kvj1971571
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FUslzatqdG6yHIQ62LqDyuny1brH16kWHD481raY6IY=; b=MUBBIfN/be88TIir
	fasOz+NvWCa3PIjJphBck1R53yVcKjJuOX2Oz0kLoGPcamxCoo5R7m4JvXpEPnsc
	neJWckvP41A0w9Zpn8OYCGb/DiLMy2CTdEfr73p5NdvkU5FDAW7Zov+Bpon0+5l6
	d+tE++Lo1cM/cjK1z8ZE3SoW8OUSoFeewREtVTke5Y/YOsohnsUVdY/i9GBDCyqC
	SHO14/NlaLRbxp4oz+amfNXFh/BlhYinasC++YyYbCs1NWfIljQoTthQidaaaz4a
	Gz7JAODYzPqYnD8p/2RKB32NVkdGf5IVXa886VZge7ys9566TyBJN90TGqvPFN/p
	Mx5MGQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u55udy1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:44:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b4139b7abcso7072662a91.3
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 06:44:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795790645; cv=none;
        d=google.com; s=arc-20260327;
        b=f1c8cJDTmS10iaou80ORN6DbJ5DE65ng/9OdlQfFkKEsdWbJa1U7VaUeryeWOgLt6n
         4TVTMh+MvTWldKg1WoZVNoqINEn876aJJe0ghKlqR93XfljEHRN7wF2x4J28g6/O6tQ1
         3JmtwRSdD/0J5pkcFG+SjzoEfEXhHI57hqgCuRB5EqCuH05Ns8SwHrMRv67turoSrTMo
         JuQ0fsb3oVO60LinOiaRq/3t1YR+We2t30Dv/t9oZ/I6re13Lw41SnxJIxoPviKguJm0
         Dy9OKsaeWUvYl3Q08BY9Kuwuys1gGIjRRPWTAghEOXRcL6vKG/Y2g4bFYryD2VATG+oG
         DznQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FUslzatqdG6yHIQ62LqDyuny1brH16kWHD481raY6IY=;
        fh=4HNyBA5PE3EWavByqOMHAVnlJxLXtTSMVewpaM31N9Y=;
        b=eeO+BTM3wERJe1gWOJfiU3XAUlvxuoo2U/LLJfGotOwEC6Fu8ASoL7dFKCrrMZp4G2
         bbc7IUOA1aJg8OJ0B1LRrvfziOjY6g1XakWmCsRs7Xm9ocdBN/tg816UmE8jwqmst39X
         HzfCTRP7oSDwPaTMNJkn468pIo/9s+8Pn8T2kCqw0tjCsBuGPzUy5N+kx3Iv8nm0g4tu
         rUvQ9nnf7GmkloH/E/2ilK3ZxnCBQT134U/CSV2nxtZn1hKtXqTQAq7TUeIdOIfdr/G0
         FfJcYb2ZU4uc+OWt/fAekoBmjhDfKTaY7D6iQ2QU3tNrmgQiZ1SFPIHwez1K/N19mDWP
         MAEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795790645; x=1796395445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FUslzatqdG6yHIQ62LqDyuny1brH16kWHD481raY6IY=;
        b=F+icJszIq/rDdqM91+kb0wjke/4KhJpizGS8tcUYz2MkXKntAaKpxaDj4W/zbN9KsG
         JvmVOPMjyG+2epSYxErSaYUeZsSkaaO9VwQs4xOHuGC2cwbZPamwxpbZknWcKKAdRQ46
         mDtj8JcncNCehcXqQS8PmuiauO0NrKoZe2GNhbqCH522NWLzUkdG5MSP7Kg/dcjdZXhM
         j8MxFk0DernScxzx1ICsikBC9lRi8P8hz8/++/92DeFDXzUzOlCDLuPIYmGbjTn80Rty
         28YCm4wWpoTtoBqrPE+T0NSlNBMqMbzJoskIDxt4+gtxR8LnQB708qHSLLjcv2xEoLAV
         a8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790645; x=1796395445;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FUslzatqdG6yHIQ62LqDyuny1brH16kWHD481raY6IY=;
        b=LU+FEMfshdtFpZiL14VAdfZZn5p2LWiHm6J/2vlDtzZLnG4YYf0wTOwVg71sMhUDGY
         lUm8L+2pu+8jyjsrVRitdUp1uX4LL0vPDld1gsnoLIHEW8eNGpHn98of6a9DviY3REME
         NVezXNm7xneZ+dn27I5kWLLGPe51d8xJJfOFyyHke+DIFNVD1C2EUyhiubhrra5fcbAg
         AcYt5yhaq7bQuKpmbbhAYcIsMuTSacDeTeGsfYHLKpNLSP+o1Mbwj7ZAuREGTMN0vxao
         PIFdsOxIcFTM9feMMtOTMweez+gj6XCLM6kRPnYW4gGXofAkcpLMK+7R8eLmsjLexOlj
         qhLA==
X-Forwarded-Encrypted: i=1; AL+hErGtW+bN7yPxCqG3VAM1Ib23apHabey/BeKgdyWImzsfUWKkwBMnnSaWwtZ+k31AWB8vfA7rtZ8yzY4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WbWNugf+qpuil1Cat2rCaH4X2SISNl9oP+sVgBlqmvHfgNyX7
	cm9plHgW+590lMUWIK19foVcVdYyoZq2dF0RRWv1t1lJ0yH3AIFsnriGEBfqrDc1rlTWIKB2blH
	oaY0CBfO9XOsRJJ8zK1qW1Kj1Rp4S12Xuzp3hvA0eDMBCNeMVoPr0z5WnSfHxNG31hpPTt7rStd
	5cKZHHC6b7dxUt1dFd/mpW8eqkyW0F98sUZdf1nQ==
X-Gm-Gg: AZFdTZfwHIoAa4LNjlOlNYYr3w81gEWIWXDMH+Gf1n43Pp3BizarHVSScqRmGhE3z6E
	luZg8Nn6+QvGRBhkDYclhDCCVM3rTn65pKMbjuJB/Jqei6T6KFPmwROLaZl5e6osZJl5476XcGr
	uhEnV2xOmgxydHHMBLp4RQk/gDM5pWIzLcYGzZ/zF/v/EDSPh95u/ICUSprw==
X-Received: by 2002:a17:90b:4a47:b0:3b3:fc1f:a5c4 with SMTP id 98e67ed59e1d1-3b41c8dc821mr24414651a91.20.1795790644652;
        Fri, 27 Nov 2026 06:44:04 -0800 (PST)
X-Received: by 2002:a17:90b:4a47:b0:3b3:fc1f:a5c4 with SMTP id
 98e67ed59e1d1-3b41c8dc821mr24414564a91.20.1795790643639; Fri, 27 Nov 2026
 06:44:03 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111123548.10571-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20261111123548.10571-2-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:43:48 +0100
X-Gm-Features: Aa3M54p7zRr-QH2LrkBzM_El0jRilqhdqKkvSPNWM2waYVo536_Gw41fT7rYwVU
Message-ID: <CAPx+jO8b7K7A6nE4XZRwS+AMoKheiJVoxrJyi+A-hwa=w440Mw@mail.gmail.com>
Subject: Re: [PATCH] mmc: usdhi6rol0: remove driver
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfXzDR4PmNhVtaK
 /63o5RB2nmrqK5LahYbLmyDzNDrV6Gmo0Kz0x8kDD6BLhfdD+a6TlPtm/LYBBGB/4zJD/0ncc8X
 ESpipGW0eRaWivJP90C16+x71cWqWDw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX3YVHuJIgp5By
 aFGYevZAg04f9qFccaKzPsRkOjpt6W+c6UPBsL7Eq2LFTkswKzQT39ZVgrMY84Wj3AzBOH94xxD
 753/qer6G2OK5ppoeD7OkvJFdyRFVoa/+32LzMai0ziuzZ0rYGm2Zcopuupnqj7xMGFJUkp9UEP
 SOn8FYmGG1/+6Tn0TV1OKUXyrbJDb1iqPMmGbBwGEU7v3nmTTkulzYvFFkC2ZULLcfx/Ur6Zmm/
 5udjjFs5Qy6CEb2sfvklceQNzN8tFOt+Rn7sekFw4mOsKOpd+GJQn+4Y160+1VElWfZ2CW4C0av
 J1s6q27p8dC1/CbbbLqFpGwLl66T1wFEp/75dZeUmS4QPNomNudnVqiCBCRdtecdT/WIP91AjKY
 /jgpxRIDMRIysvNiLupULfqgyIYvNTkZr89l3ByScC1Al6yJ38GYPoaZVZ+zO1LK7qrf7pdglCh
 y6I/TaBWNUwjCE5guOw==
X-Proofpoint-ORIG-GUID: tn0jJkRgJdyq7c2nsQTtp2hnQZdyMlzP
X-Authority-Analysis: v=2.4 cv=Z795j3RA c=1 sm=1 tr=0 ts=6b099736 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=LDBv8-xUAAAA:8
 a=c-n4J4-pAAAA:8 a=3-RhneuVAAAA:8 a=7QqxBfCn9rm4oUHoaaYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=DZeXCJrVpAJBw65Qk4Ds:22 a=VLVLkjT_5ZicWzSuYqSo:22
X-Proofpoint-GUID: tn0jJkRgJdyq7c2nsQTtp2hnQZdyMlzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270058

On Wed, Nov 11, 2026 at 1:36=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> In 2019, Yamada-san already tried to delete this driver because no user
> was known. Lars revealed that it was used on Axis ARM32 Artpec-6 chips
> which they planned to use for another 5 years[1]. We agreed that this
> driver should be merged into the main SDHI driver and, for the time
> being, added a MAINTAINERS entry to make the connection to Axis.
>
> Now, in 2026, the 5 years are more than over, and the merge to the main
> driver did not happen. Nor an addition of a SDHI device node to the only
> Artpec-6 DTS file. So, regarding upstream, this driver is still unused.
> To remove maintenance burden, let's remove it for good.
>
> [1] https://lore.kernel.org/r/CADnJP=3Dsg1Kp=3DTAvUD-ofQje9Y6mWWE_ZnQM_eB=
85uw3z6PHrVQ@mail.gmail.com
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> [wsa: rebased, bring commit msg into 2026]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Lars Persson <lars.persson@axis.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Jesper, Lars: please speak up if you disagree.
>
>  .../devicetree/bindings/mmc/usdhi6rol0.txt    |   39 -
>  MAINTAINERS                                   |    1 -
>  drivers/mmc/host/Kconfig                      |    7 -
>  drivers/mmc/host/Makefile                     |    1 -
>  drivers/mmc/host/usdhi6rol0.c                 | 1904 -----------------
>  5 files changed, 1952 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
>  delete mode 100644 drivers/mmc/host/usdhi6rol0.c
>
> diff --git a/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt b/Docum=
entation/devicetree/bindings/mmc/usdhi6rol0.txt
> deleted file mode 100644
> index 6d1b7971d078..000000000000
> --- a/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -* Renesas usdhi6rol0 SD/SDIO host controller
> -
> -Required properties:
> -
> -- compatible:  must be
> -               "renesas,usdhi6rol0"
> -- interrupts:  3 interrupts, named "card detect", "data" and "SDIO" must=
 be
> -               specified
> -- clocks:      a clock binding for the IMCLK input
> -
> -Optional properties:
> -
> -- vmmc-supply: a phandle of a regulator, supplying Vcc to the card
> -- vqmmc-supply:        a phandle of a regulator, supplying VccQ to the c=
ard
> -- pinctrl-names: Can contain a "default" entry and a "state_uhs"
> -                 entry. The state_uhs entry is used together with the de=
fault
> -                 entry when the board requires distinct settings for UHS=
 speeds.
> -
> -- pinctrl-N: One property for each name listed in pinctrl-names, see
> -             ../pinctrl/pinctrl-bindings.txt.
> -
> -Additionally any standard mmc bindings from mmc.txt can be used.
> -
> -Example:
> -
> -sd0: sd@ab000000 {
> -       compatible =3D "renesas,usdhi6rol0";
> -       reg =3D <0xab000000 0x200>;
> -       interrupts =3D <0 23 0x4
> -                     0 24 0x4
> -                     0 25 0x4>;
> -       interrupt-names =3D "card detect", "data", "SDIO";
> -       bus-width =3D <4>;
> -       max-frequency =3D <50000000>;
> -       cap-power-off-card;
> -       clocks =3D <&imclk>;
> -       vmmc-supply =3D <&vcc_sd0>;
> -       vqmmc-supply =3D <&vccq_sd0>;
> -};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 986e23fcb020..16e533e9c684 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2810,7 +2810,6 @@ F:        arch/arm/boot/dts/axis/
>  F:     arch/arm/mach-artpec
>  F:     drivers/clk/axis
>  F:     drivers/crypto/axis
> -F:     drivers/mmc/host/usdhi6rol0.c
>  F:     drivers/pinctrl/pinctrl-artpec*
>
>  ARM/ASPEED I2C DRIVER
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 79bfc425e7c7..4352fc95cce2 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -942,13 +942,6 @@ config MMC_WMT
>           To compile this driver as a module, choose M here: the
>           module will be called wmt-sdmmc.
>
> -config MMC_USDHI6ROL0
> -       tristate "Renesas USDHI6ROL0 SD/SDIO Host Controller support"
> -       depends on HAS_DMA
> -       help
> -         This selects support for the Renesas USDHI6ROL0 SD/SDIO
> -         Host Controller
> -
>  config MMC_REALTEK_PCI
>         tristate "Realtek PCI-E SD/MMC Card Interface Driver"
>         depends on MISC_RTSX_PCI
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index fd043afab57e..43100a3185a3 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -68,7 +68,6 @@ obj-$(CONFIG_MMC_MESON_MX_SDHC)       +=3D meson-mx-sdh=
c.o
>  obj-$(CONFIG_MMC_MESON_MX_SDIO)        +=3D meson-mx-sdio.o
>  obj-$(CONFIG_MMC_MOXART)       +=3D moxart-mmc.o
>  obj-$(CONFIG_MMC_SUNXI)                +=3D sunxi-mmc.o
> -obj-$(CONFIG_MMC_USDHI6ROL0)   +=3D usdhi6rol0.o
>  obj-$(CONFIG_MMC_TOSHIBA_PCI)  +=3D toshsd.o
>  obj-$(CONFIG_MMC_BCM2835)      +=3D bcm2835.o
>  obj-$(CONFIG_MMC_OWL)          +=3D owl-mmc.o
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.=
c
> deleted file mode 100644
> index 74888260e85c..000000000000
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ /dev/null
> @@ -1,1904 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2013-2014 Renesas Electronics Europe Ltd.
> - * Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> - */
> -
> -#include <linux/clk.h>
> -#include <linux/delay.h>
> -#include <linux/device.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/dmaengine.h>
> -#include <linux/highmem.h>
> -#include <linux/interrupt.h>
> -#include <linux/io.h>
> -#include <linux/log2.h>
> -#include <linux/mmc/host.h>
> -#include <linux/mmc/mmc.h>
> -#include <linux/mmc/sd.h>
> -#include <linux/mmc/sdio.h>
> -#include <linux/module.h>
> -#include <linux/pinctrl/consumer.h>
> -#include <linux/platform_device.h>
> -#include <linux/scatterlist.h>
> -#include <linux/string.h>
> -#include <linux/time.h>
> -#include <linux/virtio.h>
> -#include <linux/workqueue.h>
> -
> -#define USDHI6_SD_CMD          0x0000
> -#define USDHI6_SD_PORT_SEL     0x0004
> -#define USDHI6_SD_ARG          0x0008
> -#define USDHI6_SD_STOP         0x0010
> -#define USDHI6_SD_SECCNT       0x0014
> -#define USDHI6_SD_RSP10                0x0018
> -#define USDHI6_SD_RSP32                0x0020
> -#define USDHI6_SD_RSP54                0x0028
> -#define USDHI6_SD_RSP76                0x0030
> -#define USDHI6_SD_INFO1                0x0038
> -#define USDHI6_SD_INFO2                0x003c
> -#define USDHI6_SD_INFO1_MASK   0x0040
> -#define USDHI6_SD_INFO2_MASK   0x0044
> -#define USDHI6_SD_CLK_CTRL     0x0048
> -#define USDHI6_SD_SIZE         0x004c
> -#define USDHI6_SD_OPTION       0x0050
> -#define USDHI6_SD_ERR_STS1     0x0058
> -#define USDHI6_SD_ERR_STS2     0x005c
> -#define USDHI6_SD_BUF0         0x0060
> -#define USDHI6_SDIO_MODE       0x0068
> -#define USDHI6_SDIO_INFO1      0x006c
> -#define USDHI6_SDIO_INFO1_MASK 0x0070
> -#define USDHI6_CC_EXT_MODE     0x01b0
> -#define USDHI6_SOFT_RST                0x01c0
> -#define USDHI6_VERSION         0x01c4
> -#define USDHI6_HOST_MODE       0x01c8
> -#define USDHI6_SDIF_MODE       0x01cc
> -
> -#define USDHI6_SD_CMD_APP              0x0040
> -#define USDHI6_SD_CMD_MODE_RSP_AUTO    0x0000
> -#define USDHI6_SD_CMD_MODE_RSP_NONE    0x0300
> -#define USDHI6_SD_CMD_MODE_RSP_R1      0x0400  /* Also R5, R6, R7 */
> -#define USDHI6_SD_CMD_MODE_RSP_R1B     0x0500  /* R1b */
> -#define USDHI6_SD_CMD_MODE_RSP_R2      0x0600
> -#define USDHI6_SD_CMD_MODE_RSP_R3      0x0700  /* Also R4 */
> -#define USDHI6_SD_CMD_DATA             0x0800
> -#define USDHI6_SD_CMD_READ             0x1000
> -#define USDHI6_SD_CMD_MULTI            0x2000
> -#define USDHI6_SD_CMD_CMD12_AUTO_OFF   0x4000
> -
> -#define USDHI6_CC_EXT_MODE_SDRW                BIT(1)
> -
> -#define USDHI6_SD_INFO1_RSP_END                BIT(0)
> -#define USDHI6_SD_INFO1_ACCESS_END     BIT(2)
> -#define USDHI6_SD_INFO1_CARD_OUT       BIT(3)
> -#define USDHI6_SD_INFO1_CARD_IN                BIT(4)
> -#define USDHI6_SD_INFO1_CD             BIT(5)
> -#define USDHI6_SD_INFO1_WP             BIT(7)
> -#define USDHI6_SD_INFO1_D3_CARD_OUT    BIT(8)
> -#define USDHI6_SD_INFO1_D3_CARD_IN     BIT(9)
> -
> -#define USDHI6_SD_INFO2_CMD_ERR                BIT(0)
> -#define USDHI6_SD_INFO2_CRC_ERR                BIT(1)
> -#define USDHI6_SD_INFO2_END_ERR                BIT(2)
> -#define USDHI6_SD_INFO2_TOUT           BIT(3)
> -#define USDHI6_SD_INFO2_IWA_ERR                BIT(4)
> -#define USDHI6_SD_INFO2_IRA_ERR                BIT(5)
> -#define USDHI6_SD_INFO2_RSP_TOUT       BIT(6)
> -#define USDHI6_SD_INFO2_SDDAT0         BIT(7)
> -#define USDHI6_SD_INFO2_BRE            BIT(8)
> -#define USDHI6_SD_INFO2_BWE            BIT(9)
> -#define USDHI6_SD_INFO2_SCLKDIVEN      BIT(13)
> -#define USDHI6_SD_INFO2_CBSY           BIT(14)
> -#define USDHI6_SD_INFO2_ILA            BIT(15)
> -
> -#define USDHI6_SD_INFO1_CARD_INSERT (USDHI6_SD_INFO1_CARD_IN | USDHI6_SD=
_INFO1_D3_CARD_IN)
> -#define USDHI6_SD_INFO1_CARD_EJECT (USDHI6_SD_INFO1_CARD_OUT | USDHI6_SD=
_INFO1_D3_CARD_OUT)
> -#define USDHI6_SD_INFO1_CARD (USDHI6_SD_INFO1_CARD_INSERT | USDHI6_SD_IN=
FO1_CARD_EJECT)
> -#define USDHI6_SD_INFO1_CARD_CD (USDHI6_SD_INFO1_CARD_IN | USDHI6_SD_INF=
O1_CARD_OUT)
> -
> -#define USDHI6_SD_INFO2_ERR    (USDHI6_SD_INFO2_CMD_ERR |      \
> -       USDHI6_SD_INFO2_CRC_ERR | USDHI6_SD_INFO2_END_ERR |     \
> -       USDHI6_SD_INFO2_TOUT | USDHI6_SD_INFO2_IWA_ERR |        \
> -       USDHI6_SD_INFO2_IRA_ERR | USDHI6_SD_INFO2_RSP_TOUT |    \
> -       USDHI6_SD_INFO2_ILA)
> -
> -#define USDHI6_SD_INFO1_IRQ    (USDHI6_SD_INFO1_RSP_END | USDHI6_SD_INFO=
1_ACCESS_END | \
> -                                USDHI6_SD_INFO1_CARD)
> -
> -#define USDHI6_SD_INFO2_IRQ    (USDHI6_SD_INFO2_ERR | USDHI6_SD_INFO2_BR=
E | \
> -                                USDHI6_SD_INFO2_BWE | 0x0800 | USDHI6_SD=
_INFO2_ILA)
> -
> -#define USDHI6_SD_CLK_CTRL_SCLKEN      BIT(8)
> -
> -#define USDHI6_SD_STOP_STP             BIT(0)
> -#define USDHI6_SD_STOP_SEC             BIT(8)
> -
> -#define USDHI6_SDIO_INFO1_IOIRQ                BIT(0)
> -#define USDHI6_SDIO_INFO1_EXPUB52      BIT(14)
> -#define USDHI6_SDIO_INFO1_EXWT         BIT(15)
> -
> -#define USDHI6_SD_ERR_STS1_CRC_NO_ERROR        BIT(13)
> -
> -#define USDHI6_SOFT_RST_RESERVED       (BIT(1) | BIT(2))
> -#define USDHI6_SOFT_RST_RESET          BIT(0)
> -
> -#define USDHI6_SD_OPTION_TIMEOUT_SHIFT 4
> -#define USDHI6_SD_OPTION_TIMEOUT_MASK  (0xf << USDHI6_SD_OPTION_TIMEOUT_=
SHIFT)
> -#define USDHI6_SD_OPTION_WIDTH_1       BIT(15)
> -
> -#define USDHI6_SD_PORT_SEL_PORTS_SHIFT 8
> -
> -#define USDHI6_SD_CLK_CTRL_DIV_MASK    0xff
> -
> -#define USDHI6_SDIO_INFO1_IRQ  (USDHI6_SDIO_INFO1_IOIRQ | 3 | \
> -                                USDHI6_SDIO_INFO1_EXPUB52 | USDHI6_SDIO_=
INFO1_EXWT)
> -
> -#define USDHI6_MIN_DMA 64
> -
> -#define USDHI6_REQ_TIMEOUT_MS 4000
> -
> -enum usdhi6_wait_for {
> -       USDHI6_WAIT_FOR_REQUEST,
> -       USDHI6_WAIT_FOR_CMD,
> -       USDHI6_WAIT_FOR_MREAD,
> -       USDHI6_WAIT_FOR_MWRITE,
> -       USDHI6_WAIT_FOR_READ,
> -       USDHI6_WAIT_FOR_WRITE,
> -       USDHI6_WAIT_FOR_DATA_END,
> -       USDHI6_WAIT_FOR_STOP,
> -       USDHI6_WAIT_FOR_DMA,
> -};
> -
> -struct usdhi6_page {
> -       struct page *page;
> -       void *mapped;           /* mapped page */
> -};
> -
> -struct usdhi6_host {
> -       struct mmc_host *mmc;
> -       struct mmc_request *mrq;
> -       void __iomem *base;
> -       struct clk *clk;
> -
> -       /* SG memory handling */
> -
> -       /* Common for multiple and single block requests */
> -       struct usdhi6_page pg;  /* current page from an SG */
> -       void *blk_page;         /* either a mapped page, or the bounce bu=
ffer */
> -       size_t offset;          /* offset within a page, including sg->of=
fset */
> -
> -       /* Blocks, crossing a page boundary */
> -       size_t head_len;
> -       struct usdhi6_page head_pg;
> -
> -       /* A bounce buffer for unaligned blocks or blocks, crossing a pag=
e boundary */
> -       struct scatterlist bounce_sg;
> -       u8 bounce_buf[512];
> -
> -       /* Multiple block requests only */
> -       struct scatterlist *sg; /* current SG segment */
> -       int page_idx;           /* page index within an SG segment */
> -
> -       enum usdhi6_wait_for wait;
> -       u32 status_mask;
> -       u32 status2_mask;
> -       u32 sdio_mask;
> -       u32 io_error;
> -       u32 irq_status;
> -       unsigned long imclk;
> -       unsigned long rate;
> -       bool app_cmd;
> -
> -       /* Timeout handling */
> -       struct delayed_work timeout_work;
> -       unsigned long timeout;
> -
> -       /* DMA support */
> -       struct dma_chan *chan_rx;
> -       struct dma_chan *chan_tx;
> -       bool dma_active;
> -
> -       /* Pin control */
> -       struct pinctrl *pinctrl;
> -       struct pinctrl_state *pins_uhs;
> -};
> -
> -/*                     I/O primitives                                  *=
/
> -
> -static void usdhi6_write(struct usdhi6_host *host, u32 reg, u32 data)
> -{
> -       iowrite32(data, host->base + reg);
> -       dev_vdbg(mmc_dev(host->mmc), "%s(0x%p + 0x%x) =3D 0x%x\n", __func=
__,
> -               host->base, reg, data);
> -}
> -
> -static void usdhi6_write16(struct usdhi6_host *host, u32 reg, u16 data)
> -{
> -       iowrite16(data, host->base + reg);
> -       dev_vdbg(mmc_dev(host->mmc), "%s(0x%p + 0x%x) =3D 0x%x\n", __func=
__,
> -               host->base, reg, data);
> -}
> -
> -static u32 usdhi6_read(struct usdhi6_host *host, u32 reg)
> -{
> -       u32 data =3D ioread32(host->base + reg);
> -       dev_vdbg(mmc_dev(host->mmc), "%s(0x%p + 0x%x) =3D 0x%x\n", __func=
__,
> -               host->base, reg, data);
> -       return data;
> -}
> -
> -static u16 usdhi6_read16(struct usdhi6_host *host, u32 reg)
> -{
> -       u16 data =3D ioread16(host->base + reg);
> -       dev_vdbg(mmc_dev(host->mmc), "%s(0x%p + 0x%x) =3D 0x%x\n", __func=
__,
> -               host->base, reg, data);
> -       return data;
> -}
> -
> -static void usdhi6_irq_enable(struct usdhi6_host *host, u32 info1, u32 i=
nfo2)
> -{
> -       host->status_mask =3D USDHI6_SD_INFO1_IRQ & ~info1;
> -       host->status2_mask =3D USDHI6_SD_INFO2_IRQ & ~info2;
> -       usdhi6_write(host, USDHI6_SD_INFO1_MASK, host->status_mask);
> -       usdhi6_write(host, USDHI6_SD_INFO2_MASK, host->status2_mask);
> -}
> -
> -static void usdhi6_wait_for_resp(struct usdhi6_host *host)
> -{
> -       usdhi6_irq_enable(host, USDHI6_SD_INFO1_RSP_END |
> -                         USDHI6_SD_INFO1_ACCESS_END | USDHI6_SD_INFO1_CA=
RD_CD,
> -                         USDHI6_SD_INFO2_ERR);
> -}
> -
> -static void usdhi6_wait_for_brwe(struct usdhi6_host *host, bool read)
> -{
> -       usdhi6_irq_enable(host, USDHI6_SD_INFO1_ACCESS_END |
> -                         USDHI6_SD_INFO1_CARD_CD, USDHI6_SD_INFO2_ERR |
> -                         (read ? USDHI6_SD_INFO2_BRE : USDHI6_SD_INFO2_B=
WE));
> -}
> -
> -static void usdhi6_only_cd(struct usdhi6_host *host)
> -{
> -       /* Mask all except card hotplug */
> -       usdhi6_irq_enable(host, USDHI6_SD_INFO1_CARD_CD, 0);
> -}
> -
> -static void usdhi6_mask_all(struct usdhi6_host *host)
> -{
> -       usdhi6_irq_enable(host, 0, 0);
> -}
> -
> -static int usdhi6_error_code(struct usdhi6_host *host)
> -{
> -       u32 err;
> -
> -       usdhi6_write(host, USDHI6_SD_STOP, USDHI6_SD_STOP_STP);
> -
> -       if (host->io_error &
> -           (USDHI6_SD_INFO2_RSP_TOUT | USDHI6_SD_INFO2_TOUT)) {
> -               u32 rsp54 =3D usdhi6_read(host, USDHI6_SD_RSP54);
> -               int opc =3D host->mrq ? host->mrq->cmd->opcode : -1;
> -
> -               err =3D usdhi6_read(host, USDHI6_SD_ERR_STS2);
> -               /* Response timeout is often normal, don't spam the log *=
/
> -               if (host->wait =3D=3D USDHI6_WAIT_FOR_CMD)
> -                       dev_dbg(mmc_dev(host->mmc),
> -                               "T-out sts 0x%x, resp 0x%x, state %u, CMD=
%d\n",
> -                               err, rsp54, host->wait, opc);
> -               else
> -                       dev_warn(mmc_dev(host->mmc),
> -                                "T-out sts 0x%x, resp 0x%x, state %u, CM=
D%d\n",
> -                                err, rsp54, host->wait, opc);
> -               return -ETIMEDOUT;
> -       }
> -
> -       err =3D usdhi6_read(host, USDHI6_SD_ERR_STS1);
> -       if (err !=3D USDHI6_SD_ERR_STS1_CRC_NO_ERROR)
> -               dev_warn(mmc_dev(host->mmc), "Err sts 0x%x, state %u, CMD=
%d\n",
> -                        err, host->wait, host->mrq ? host->mrq->cmd->opc=
ode : -1);
> -       if (host->io_error & USDHI6_SD_INFO2_ILA)
> -               return -EILSEQ;
> -
> -       return -EIO;
> -}
> -
> -/*                     Scatter-Gather management                       *=
/
> -
> -/*
> - * In PIO mode we have to map each page separately, using kmap(). That w=
ay
> - * adjacent pages are mapped to non-adjacent virtual addresses. That's w=
hy we
> - * have to use a bounce buffer for blocks, crossing page boundaries. Suc=
h blocks
> - * have been observed with an SDIO WiFi card (b43 driver).
> - */
> -static void usdhi6_blk_bounce(struct usdhi6_host *host,
> -                             struct scatterlist *sg)
> -{
> -       struct mmc_data *data =3D host->mrq->data;
> -       size_t blk_head =3D host->head_len;
> -
> -       dev_dbg(mmc_dev(host->mmc), "%s(): CMD%u of %u SG: %ux%u @ 0x%x\n=
",
> -               __func__, host->mrq->cmd->opcode, data->sg_len,
> -               data->blksz, data->blocks, sg->offset);
> -
> -       host->head_pg.page      =3D host->pg.page;
> -       host->head_pg.mapped    =3D host->pg.mapped;
> -       host->pg.page           =3D host->pg.page + 1;
> -       host->pg.mapped         =3D kmap(host->pg.page);
> -
> -       host->blk_page =3D host->bounce_buf;
> -       host->offset =3D 0;
> -
> -       if (data->flags & MMC_DATA_READ)
> -               return;
> -
> -       memcpy(host->bounce_buf, host->head_pg.mapped + PAGE_SIZE - blk_h=
ead,
> -              blk_head);
> -       memcpy(host->bounce_buf + blk_head, host->pg.mapped,
> -              data->blksz - blk_head);
> -}
> -
> -/* Only called for multiple block IO */
> -static void usdhi6_sg_prep(struct usdhi6_host *host)
> -{
> -       struct mmc_request *mrq =3D host->mrq;
> -       struct mmc_data *data =3D mrq->data;
> -
> -       usdhi6_write(host, USDHI6_SD_SECCNT, data->blocks);
> -
> -       host->sg =3D data->sg;
> -       /* TODO: if we always map, this is redundant */
> -       host->offset =3D host->sg->offset;
> -}
> -
> -/* Map the first page in an SG segment: common for multiple and single b=
lock IO */
> -static void *usdhi6_sg_map(struct usdhi6_host *host)
> -{
> -       struct mmc_data *data =3D host->mrq->data;
> -       struct scatterlist *sg =3D data->sg_len > 1 ? host->sg : data->sg=
;
> -       size_t head =3D PAGE_SIZE - sg->offset;
> -       size_t blk_head =3D head % data->blksz;
> -
> -       WARN(host->pg.page, "%p not properly unmapped!\n", host->pg.page)=
;
> -       if (WARN(sg_dma_len(sg) % data->blksz,
> -                "SG size %u isn't a multiple of block size %u\n",
> -                sg_dma_len(sg), data->blksz))
> -               return NULL;
> -
> -       host->pg.page =3D sg_page(sg);
> -       host->pg.mapped =3D kmap(host->pg.page);
> -       host->offset =3D sg->offset;
> -
> -       /*
> -        * Block size must be a power of 2 for multi-block transfers,
> -        * therefore blk_head is equal for all pages in this SG
> -        */
> -       host->head_len =3D blk_head;
> -
> -       if (head < data->blksz)
> -               /*
> -                * The first block in the SG crosses a page boundary.
> -                * Max blksz =3D 512, so blocks can only span 2 pages
> -                */
> -               usdhi6_blk_bounce(host, sg);
> -       else
> -               host->blk_page =3D host->pg.mapped;
> -
> -       dev_dbg(mmc_dev(host->mmc), "Mapped %p (%lx) at %p + %u for CMD%u=
 @ 0x%p\n",
> -               host->pg.page, page_to_pfn(host->pg.page), host->pg.mappe=
d,
> -               sg->offset, host->mrq->cmd->opcode, host->mrq);
> -
> -       return host->blk_page + host->offset;
> -}
> -
> -/* Unmap the current page: common for multiple and single block IO */
> -static void usdhi6_sg_unmap(struct usdhi6_host *host, bool force)
> -{
> -       struct mmc_data *data =3D host->mrq->data;
> -       struct page *page =3D host->head_pg.page;
> -
> -       if (page) {
> -               /* Previous block was cross-page boundary */
> -               struct scatterlist *sg =3D data->sg_len > 1 ?
> -                       host->sg : data->sg;
> -               size_t blk_head =3D host->head_len;
> -
> -               if (!data->error && data->flags & MMC_DATA_READ) {
> -                       memcpy(host->head_pg.mapped + PAGE_SIZE - blk_hea=
d,
> -                              host->bounce_buf, blk_head);
> -                       memcpy(host->pg.mapped, host->bounce_buf + blk_he=
ad,
> -                              data->blksz - blk_head);
> -               }
> -
> -               flush_dcache_page(page);
> -               kunmap(page);
> -
> -               host->head_pg.page =3D NULL;
> -
> -               if (!force && sg_dma_len(sg) + sg->offset >
> -                   (host->page_idx << PAGE_SHIFT) + data->blksz - blk_he=
ad)
> -                       /* More blocks in this SG, don't unmap the next p=
age */
> -                       return;
> -       }
> -
> -       page =3D host->pg.page;
> -       if (!page)
> -               return;
> -
> -       flush_dcache_page(page);
> -       kunmap(page);
> -
> -       host->pg.page =3D NULL;
> -}
> -
> -/* Called from MMC_WRITE_MULTIPLE_BLOCK or MMC_READ_MULTIPLE_BLOCK */
> -static void usdhi6_sg_advance(struct usdhi6_host *host)
> -{
> -       struct mmc_data *data =3D host->mrq->data;
> -       size_t done, total;
> -
> -       /* New offset: set at the end of the previous block */
> -       if (host->head_pg.page) {
> -               /* Finished a cross-page block, jump to the new page */
> -               host->page_idx++;
> -               host->offset =3D data->blksz - host->head_len;
> -               host->blk_page =3D host->pg.mapped;
> -               usdhi6_sg_unmap(host, false);
> -       } else {
> -               host->offset +=3D data->blksz;
> -               /* The completed block didn't cross a page boundary */
> -               if (host->offset =3D=3D PAGE_SIZE) {
> -                       /* If required, we'll map the page below */
> -                       host->offset =3D 0;
> -                       host->page_idx++;
> -               }
> -       }
> -
> -       /*
> -        * Now host->blk_page + host->offset point at the end of our last=
 block
> -        * and host->page_idx is the index of the page, in which our new =
block
> -        * is located, if any
> -        */
> -
> -       done =3D (host->page_idx << PAGE_SHIFT) + host->offset;
> -       total =3D host->sg->offset + sg_dma_len(host->sg);
> -
> -       dev_dbg(mmc_dev(host->mmc), "%s(): %zu of %zu @ %zu\n", __func__,
> -               done, total, host->offset);
> -
> -       if (done < total && host->offset) {
> -               /* More blocks in this page */
> -               if (host->offset + data->blksz > PAGE_SIZE)
> -                       /* We approached at a block, that spans 2 pages *=
/
> -                       usdhi6_blk_bounce(host, host->sg);
> -
> -               return;
> -       }
> -
> -       /* Finished current page or an SG segment */
> -       usdhi6_sg_unmap(host, false);
> -
> -       if (done =3D=3D total) {
> -               /*
> -                * End of an SG segment or the complete SG: jump to the n=
ext
> -                * segment, we'll map it later in usdhi6_blk_read() or
> -                * usdhi6_blk_write()
> -                */
> -               struct scatterlist *next =3D sg_next(host->sg);
> -
> -               host->page_idx =3D 0;
> -
> -               if (!next)
> -                       host->wait =3D USDHI6_WAIT_FOR_DATA_END;
> -               host->sg =3D next;
> -
> -               if (WARN(next && sg_dma_len(next) % data->blksz,
> -                        "SG size %u isn't a multiple of block size %u\n"=
,
> -                        sg_dma_len(next), data->blksz))
> -                       data->error =3D -EINVAL;
> -
> -               return;
> -       }
> -
> -       /* We cannot get here after crossing a page border */
> -
> -       /* Next page in the same SG */
> -       host->pg.page =3D sg_page(host->sg) + host->page_idx;
> -       host->pg.mapped =3D kmap(host->pg.page);
> -       host->blk_page =3D host->pg.mapped;
> -
> -       dev_dbg(mmc_dev(host->mmc), "Mapped %p (%lx) at %p for CMD%u @ 0x=
%p\n",
> -               host->pg.page, page_to_pfn(host->pg.page), host->pg.mappe=
d,
> -               host->mrq->cmd->opcode, host->mrq);
> -}
> -
> -/*                     DMA handling                                    *=
/
> -
> -static void usdhi6_dma_release(struct usdhi6_host *host)
> -{
> -       host->dma_active =3D false;
> -       if (host->chan_tx) {
> -               struct dma_chan *chan =3D host->chan_tx;
> -               host->chan_tx =3D NULL;
> -               dma_release_channel(chan);
> -       }
> -       if (host->chan_rx) {
> -               struct dma_chan *chan =3D host->chan_rx;
> -               host->chan_rx =3D NULL;
> -               dma_release_channel(chan);
> -       }
> -}
> -
> -static void usdhi6_dma_stop_unmap(struct usdhi6_host *host)
> -{
> -       struct mmc_data *data =3D host->mrq->data;
> -
> -       if (!host->dma_active)
> -               return;
> -
> -       usdhi6_write(host, USDHI6_CC_EXT_MODE, 0);
> -       host->dma_active =3D false;
> -
> -       if (data->flags & MMC_DATA_READ)
> -               dma_unmap_sg(dmaengine_get_dma_device(host->chan_rx), dat=
a->sg,
> -                            data->sg_len, DMA_FROM_DEVICE);
> -       else
> -               dma_unmap_sg(dmaengine_get_dma_device(host->chan_tx), dat=
a->sg,
> -                            data->sg_len, DMA_TO_DEVICE);
> -}
> -
> -static void usdhi6_dma_complete(void *arg)
> -{
> -       struct usdhi6_host *host =3D arg;
> -       struct mmc_request *mrq =3D host->mrq;
> -
> -       if (WARN(!mrq || !mrq->data, "%s: NULL data in DMA completion for=
 %p!\n",
> -                dev_name(mmc_dev(host->mmc)), mrq))
> -               return;
> -
> -       dev_dbg(mmc_dev(host->mmc), "%s(): CMD%u DMA completed\n", __func=
__,
> -               mrq->cmd->opcode);
> -
> -       usdhi6_dma_stop_unmap(host);
> -       usdhi6_wait_for_brwe(host, mrq->data->flags & MMC_DATA_READ);
> -}
> -
> -static int usdhi6_dma_setup(struct usdhi6_host *host, struct dma_chan *c=
han,
> -                           enum dma_transfer_direction dir)
> -{
> -       struct mmc_data *data =3D host->mrq->data;
> -       struct scatterlist *sg =3D data->sg;
> -       struct dma_async_tx_descriptor *desc =3D NULL;
> -       dma_cookie_t cookie =3D -EINVAL;
> -       enum dma_data_direction data_dir;
> -       int ret;
> -
> -       switch (dir) {
> -       case DMA_MEM_TO_DEV:
> -               data_dir =3D DMA_TO_DEVICE;
> -               break;
> -       case DMA_DEV_TO_MEM:
> -               data_dir =3D DMA_FROM_DEVICE;
> -               break;
> -       default:
> -               return -EINVAL;
> -       }
> -
> -       ret =3D dma_map_sg(dmaengine_get_dma_device(chan), sg, data->sg_l=
en, data_dir);
> -       if (ret > 0) {
> -               host->dma_active =3D true;
> -               desc =3D dmaengine_prep_slave_sg(chan, sg, ret, dir,
> -                                       DMA_PREP_INTERRUPT | DMA_CTRL_ACK=
);
> -       }
> -
> -       if (desc) {
> -               desc->callback =3D usdhi6_dma_complete;
> -               desc->callback_param =3D host;
> -               cookie =3D dmaengine_submit(desc);
> -       }
> -
> -       dev_dbg(mmc_dev(host->mmc), "%s(): mapped %d -> %d, cookie %d @ %=
p\n",
> -               __func__, data->sg_len, ret, cookie, desc);
> -
> -       if (cookie < 0) {
> -               /* DMA failed, fall back to PIO */
> -               if (ret >=3D 0)
> -                       ret =3D cookie;
> -               usdhi6_dma_release(host);
> -               dev_warn(mmc_dev(host->mmc),
> -                        "DMA failed: %d, falling back to PIO\n", ret);
> -       }
> -
> -       return cookie;
> -}
> -
> -static int usdhi6_dma_start(struct usdhi6_host *host)
> -{
> -       if (!host->chan_rx || !host->chan_tx)
> -               return -ENODEV;
> -
> -       if (host->mrq->data->flags & MMC_DATA_READ)
> -               return usdhi6_dma_setup(host, host->chan_rx, DMA_DEV_TO_M=
EM);
> -
> -       return usdhi6_dma_setup(host, host->chan_tx, DMA_MEM_TO_DEV);
> -}
> -
> -static void usdhi6_dma_kill(struct usdhi6_host *host)
> -{
> -       struct mmc_data *data =3D host->mrq->data;
> -
> -       dev_dbg(mmc_dev(host->mmc), "%s(): SG of %u: %ux%u\n",
> -               __func__, data->sg_len, data->blocks, data->blksz);
> -       /* Abort DMA */
> -       if (data->flags & MMC_DATA_READ)
> -               dmaengine_terminate_sync(host->chan_rx);
> -       else
> -               dmaengine_terminate_sync(host->chan_tx);
> -}
> -
> -static void usdhi6_dma_check_error(struct usdhi6_host *host)
> -{
> -       struct mmc_data *data =3D host->mrq->data;
> -
> -       dev_dbg(mmc_dev(host->mmc), "%s(): IO error %d, status 0x%x\n",
> -               __func__, host->io_error, usdhi6_read(host, USDHI6_SD_INF=
O1));
> -
> -       if (host->io_error) {
> -               data->error =3D usdhi6_error_code(host);
> -               data->bytes_xfered =3D 0;
> -               usdhi6_dma_kill(host);
> -               usdhi6_dma_release(host);
> -               dev_warn(mmc_dev(host->mmc),
> -                        "DMA failed: %d, falling back to PIO\n", data->e=
rror);
> -               return;
> -       }
> -
> -       /*
> -        * The datasheet tells us to check a response from the card, wher=
eas
> -        * responses only come after the command phase, not after the dat=
a
> -        * phase. Let's check anyway.
> -        */
> -       if (host->irq_status & USDHI6_SD_INFO1_RSP_END)
> -               dev_warn(mmc_dev(host->mmc), "Unexpected response receive=
d!\n");
> -}
> -
> -static void usdhi6_dma_kick(struct usdhi6_host *host)
> -{
> -       if (host->mrq->data->flags & MMC_DATA_READ)
> -               dma_async_issue_pending(host->chan_rx);
> -       else
> -               dma_async_issue_pending(host->chan_tx);
> -}
> -
> -static void usdhi6_dma_request(struct usdhi6_host *host, phys_addr_t sta=
rt)
> -{
> -       struct dma_slave_config cfg =3D {
> -               .src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES,
> -               .dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES,
> -       };
> -       int ret;
> -
> -       host->chan_tx =3D dma_request_chan(mmc_dev(host->mmc), "tx");
> -       dev_dbg(mmc_dev(host->mmc), "%s: TX: got channel %p\n", __func__,
> -               host->chan_tx);
> -
> -       if (IS_ERR(host->chan_tx)) {
> -               host->chan_tx =3D NULL;
> -               return;
> -       }
> -
> -       cfg.direction =3D DMA_MEM_TO_DEV;
> -       cfg.dst_addr =3D start + USDHI6_SD_BUF0;
> -       cfg.dst_maxburst =3D 128; /* 128 words * 4 bytes =3D 512 bytes */
> -       cfg.src_addr =3D 0;
> -       ret =3D dmaengine_slave_config(host->chan_tx, &cfg);
> -       if (ret < 0)
> -               goto e_release_tx;
> -
> -       host->chan_rx =3D dma_request_chan(mmc_dev(host->mmc), "rx");
> -       dev_dbg(mmc_dev(host->mmc), "%s: RX: got channel %p\n", __func__,
> -               host->chan_rx);
> -
> -       if (IS_ERR(host->chan_rx)) {
> -               host->chan_rx =3D NULL;
> -               goto e_release_tx;
> -       }
> -
> -       cfg.direction =3D DMA_DEV_TO_MEM;
> -       cfg.src_addr =3D cfg.dst_addr;
> -       cfg.src_maxburst =3D 128; /* 128 words * 4 bytes =3D 512 bytes */
> -       cfg.dst_addr =3D 0;
> -       ret =3D dmaengine_slave_config(host->chan_rx, &cfg);
> -       if (ret < 0)
> -               goto e_release_rx;
> -
> -       return;
> -
> -e_release_rx:
> -       dma_release_channel(host->chan_rx);
> -       host->chan_rx =3D NULL;
> -e_release_tx:
> -       dma_release_channel(host->chan_tx);
> -       host->chan_tx =3D NULL;
> -}
> -
> -/*                     API helpers                                     *=
/
> -
> -static void usdhi6_clk_set(struct usdhi6_host *host, struct mmc_ios *ios=
)
> -{
> -       unsigned long rate =3D ios->clock;
> -       u32 val;
> -       unsigned int i;
> -
> -       for (i =3D 1000; i; i--) {
> -               if (usdhi6_read(host, USDHI6_SD_INFO2) & USDHI6_SD_INFO2_=
SCLKDIVEN)
> -                       break;
> -               usleep_range(10, 100);
> -       }
> -
> -       if (!i) {
> -               dev_err(mmc_dev(host->mmc), "SD bus busy, clock set abort=
ed\n");
> -               return;
> -       }
> -
> -       val =3D usdhi6_read(host, USDHI6_SD_CLK_CTRL) & ~USDHI6_SD_CLK_CT=
RL_DIV_MASK;
> -
> -       if (rate) {
> -               unsigned long new_rate;
> -
> -               if (host->imclk <=3D rate) {
> -                       if (ios->timing !=3D MMC_TIMING_UHS_DDR50) {
> -                               /* Cannot have 1-to-1 clock in DDR mode *=
/
> -                               new_rate =3D host->imclk;
> -                               val |=3D 0xff;
> -                       } else {
> -                               new_rate =3D host->imclk / 2;
> -                       }
> -               } else {
> -                       unsigned long div =3D
> -                               roundup_pow_of_two(DIV_ROUND_UP(host->imc=
lk, rate));
> -                       val |=3D div >> 2;
> -                       new_rate =3D host->imclk / div;
> -               }
> -
> -               if (host->rate =3D=3D new_rate)
> -                       return;
> -
> -               host->rate =3D new_rate;
> -
> -               dev_dbg(mmc_dev(host->mmc), "target %lu, div %u, set %lu\=
n",
> -                       rate, (val & 0xff) << 2, new_rate);
> -       }
> -
> -       /*
> -        * if old or new rate is equal to input rate, have to switch the =
clock
> -        * off before changing and on after
> -        */
> -       if (host->imclk =3D=3D rate || host->imclk =3D=3D host->rate || !=
rate)
> -               usdhi6_write(host, USDHI6_SD_CLK_CTRL,
> -                            val & ~USDHI6_SD_CLK_CTRL_SCLKEN);
> -
> -       if (!rate) {
> -               host->rate =3D 0;
> -               return;
> -       }
> -
> -       usdhi6_write(host, USDHI6_SD_CLK_CTRL, val);
> -
> -       if (host->imclk =3D=3D rate || host->imclk =3D=3D host->rate ||
> -           !(val & USDHI6_SD_CLK_CTRL_SCLKEN))
> -               usdhi6_write(host, USDHI6_SD_CLK_CTRL,
> -                            val | USDHI6_SD_CLK_CTRL_SCLKEN);
> -}
> -
> -static void usdhi6_set_power(struct usdhi6_host *host, struct mmc_ios *i=
os)
> -{
> -       struct mmc_host *mmc =3D host->mmc;
> -
> -       if (!IS_ERR(mmc->supply.vmmc))
> -               /* Errors ignored... */
> -               mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
> -                                     ios->power_mode ? ios->vdd : 0);
> -}
> -
> -static int usdhi6_reset(struct usdhi6_host *host)
> -{
> -       int i;
> -
> -       usdhi6_write(host, USDHI6_SOFT_RST, USDHI6_SOFT_RST_RESERVED);
> -       cpu_relax();
> -       usdhi6_write(host, USDHI6_SOFT_RST, USDHI6_SOFT_RST_RESERVED | US=
DHI6_SOFT_RST_RESET);
> -       for (i =3D 1000; i; i--)
> -               if (usdhi6_read(host, USDHI6_SOFT_RST) & USDHI6_SOFT_RST_=
RESET)
> -                       break;
> -
> -       return i ? 0 : -ETIMEDOUT;
> -}
> -
> -static void usdhi6_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> -{
> -       struct usdhi6_host *host =3D mmc_priv(mmc);
> -       u32 option, mode;
> -       int ret;
> -
> -       dev_dbg(mmc_dev(mmc), "%uHz, OCR: %u, power %u, bus-width %u, tim=
ing %u\n",
> -               ios->clock, ios->vdd, ios->power_mode, ios->bus_width, io=
s->timing);
> -
> -       switch (ios->power_mode) {
> -       case MMC_POWER_OFF:
> -               usdhi6_set_power(host, ios);
> -               usdhi6_only_cd(host);
> -               break;
> -       case MMC_POWER_UP:
> -               /*
> -                * We only also touch USDHI6_SD_OPTION from .request(), w=
hich
> -                * cannot race with MMC_POWER_UP
> -                */
> -               ret =3D usdhi6_reset(host);
> -               if (ret < 0) {
> -                       dev_err(mmc_dev(mmc), "Cannot reset the interface=
!\n");
> -               } else {
> -                       usdhi6_set_power(host, ios);
> -                       usdhi6_only_cd(host);
> -               }
> -               break;
> -       case MMC_POWER_ON:
> -               option =3D usdhi6_read(host, USDHI6_SD_OPTION);
> -               /*
> -                * The eMMC standard only allows 4 or 8 bits in the DDR m=
ode,
> -                * the same probably holds for SD cards. We check here an=
yway,
> -                * since the datasheet explicitly requires 4 bits for DDR=
.
> -                */
> -               if (ios->bus_width =3D=3D MMC_BUS_WIDTH_1) {
> -                       if (ios->timing =3D=3D MMC_TIMING_UHS_DDR50)
> -                               dev_err(mmc_dev(mmc),
> -                                       "4 bits are required for DDR\n");
> -                       option |=3D USDHI6_SD_OPTION_WIDTH_1;
> -                       mode =3D 0;
> -               } else {
> -                       option &=3D ~USDHI6_SD_OPTION_WIDTH_1;
> -                       mode =3D ios->timing =3D=3D MMC_TIMING_UHS_DDR50;
> -               }
> -               usdhi6_write(host, USDHI6_SD_OPTION, option);
> -               usdhi6_write(host, USDHI6_SDIF_MODE, mode);
> -               break;
> -       }
> -
> -       if (host->rate !=3D ios->clock)
> -               usdhi6_clk_set(host, ios);
> -}
> -
> -/* This is data timeout. Response timeout is fixed to 640 clock cycles *=
/
> -static void usdhi6_timeout_set(struct usdhi6_host *host)
> -{
> -       struct mmc_request *mrq =3D host->mrq;
> -       u32 val;
> -       unsigned long ticks;
> -
> -       if (!mrq->data)
> -               ticks =3D host->rate / 1000 * mrq->cmd->busy_timeout;
> -       else
> -               ticks =3D host->rate / 1000000 * (mrq->data->timeout_ns /=
 1000) +
> -                       mrq->data->timeout_clks;
> -
> -       if (!ticks || ticks > 1 << 27)
> -               /* Max timeout */
> -               val =3D 14;
> -       else if (ticks < 1 << 13)
> -               /* Min timeout */
> -               val =3D 0;
> -       else
> -               val =3D order_base_2(ticks) - 13;
> -
> -       dev_dbg(mmc_dev(host->mmc), "Set %s timeout %lu ticks @ %lu Hz\n"=
,
> -               mrq->data ? "data" : "cmd", ticks, host->rate);
> -
> -       /* Timeout Counter mask: 0xf0 */
> -       usdhi6_write(host, USDHI6_SD_OPTION, (val << USDHI6_SD_OPTION_TIM=
EOUT_SHIFT) |
> -                    (usdhi6_read(host, USDHI6_SD_OPTION) & ~USDHI6_SD_OP=
TION_TIMEOUT_MASK));
> -}
> -
> -static void usdhi6_request_done(struct usdhi6_host *host)
> -{
> -       struct mmc_request *mrq =3D host->mrq;
> -       struct mmc_data *data =3D mrq->data;
> -
> -       if (WARN(host->pg.page || host->head_pg.page,
> -                "Page %p or %p not unmapped: wait %u, CMD%d(%c) @ +0x%zx=
 %ux%u in SG%u!\n",
> -                host->pg.page, host->head_pg.page, host->wait, mrq->cmd-=
>opcode,
> -                data ? (data->flags & MMC_DATA_READ ? 'R' : 'W') : '-',
> -                data ? host->offset : 0, data ? data->blocks : 0,
> -                data ? data->blksz : 0, data ? data->sg_len : 0))
> -               usdhi6_sg_unmap(host, true);
> -
> -       if (mrq->cmd->error ||
> -           (data && data->error) ||
> -           (mrq->stop && mrq->stop->error))
> -               dev_dbg(mmc_dev(host->mmc), "%s(CMD%d: %ux%u): err %d %d =
%d\n",
> -                       __func__, mrq->cmd->opcode, data ? data->blocks :=
 0,
> -                       data ? data->blksz : 0,
> -                       mrq->cmd->error,
> -                       data ? data->error : 1,
> -                       mrq->stop ? mrq->stop->error : 1);
> -
> -       /* Disable DMA */
> -       usdhi6_write(host, USDHI6_CC_EXT_MODE, 0);
> -       host->wait =3D USDHI6_WAIT_FOR_REQUEST;
> -       host->mrq =3D NULL;
> -
> -       mmc_request_done(host->mmc, mrq);
> -}
> -
> -static int usdhi6_cmd_flags(struct usdhi6_host *host)
> -{
> -       struct mmc_request *mrq =3D host->mrq;
> -       struct mmc_command *cmd =3D mrq->cmd;
> -       u16 opc =3D cmd->opcode;
> -
> -       if (host->app_cmd) {
> -               host->app_cmd =3D false;
> -               opc |=3D USDHI6_SD_CMD_APP;
> -       }
> -
> -       if (mrq->data) {
> -               opc |=3D USDHI6_SD_CMD_DATA;
> -
> -               if (mrq->data->flags & MMC_DATA_READ)
> -                       opc |=3D USDHI6_SD_CMD_READ;
> -
> -               if (cmd->opcode =3D=3D MMC_READ_MULTIPLE_BLOCK ||
> -                   cmd->opcode =3D=3D MMC_WRITE_MULTIPLE_BLOCK ||
> -                   (cmd->opcode =3D=3D SD_IO_RW_EXTENDED &&
> -                    mrq->data->blocks > 1)) {
> -                       opc |=3D USDHI6_SD_CMD_MULTI;
> -                       if (!mrq->stop)
> -                               opc |=3D USDHI6_SD_CMD_CMD12_AUTO_OFF;
> -               }
> -
> -               switch (mmc_resp_type(cmd)) {
> -               case MMC_RSP_NONE:
> -                       opc |=3D USDHI6_SD_CMD_MODE_RSP_NONE;
> -                       break;
> -               case MMC_RSP_R1:
> -                       opc |=3D USDHI6_SD_CMD_MODE_RSP_R1;
> -                       break;
> -               case MMC_RSP_R1B:
> -                       opc |=3D USDHI6_SD_CMD_MODE_RSP_R1B;
> -                       break;
> -               case MMC_RSP_R2:
> -                       opc |=3D USDHI6_SD_CMD_MODE_RSP_R2;
> -                       break;
> -               case MMC_RSP_R3:
> -                       opc |=3D USDHI6_SD_CMD_MODE_RSP_R3;
> -                       break;
> -               default:
> -                       dev_warn(mmc_dev(host->mmc),
> -                                "Unknown response type %d\n",
> -                                mmc_resp_type(cmd));
> -                       return -EINVAL;
> -               }
> -       }
> -
> -       return opc;
> -}
> -
> -static int usdhi6_rq_start(struct usdhi6_host *host)
> -{
> -       struct mmc_request *mrq =3D host->mrq;
> -       struct mmc_command *cmd =3D mrq->cmd;
> -       struct mmc_data *data =3D mrq->data;
> -       int opc =3D usdhi6_cmd_flags(host);
> -       int i;
> -
> -       if (opc < 0)
> -               return opc;
> -
> -       for (i =3D 1000; i; i--) {
> -               if (!(usdhi6_read(host, USDHI6_SD_INFO2) & USDHI6_SD_INFO=
2_CBSY))
> -                       break;
> -               usleep_range(10, 100);
> -       }
> -
> -       if (!i) {
> -               dev_dbg(mmc_dev(host->mmc), "Command active, request abor=
ted\n");
> -               return -EAGAIN;
> -       }
> -
> -       if (data) {
> -               bool use_dma;
> -               int ret =3D 0;
> -
> -               host->page_idx =3D 0;
> -
> -               if (cmd->opcode =3D=3D SD_IO_RW_EXTENDED && data->blocks =
> 1) {
> -                       switch (data->blksz) {
> -                       case 512:
> -                               break;
> -                       case 32:
> -                       case 64:
> -                       case 128:
> -                       case 256:
> -                               if (mrq->stop)
> -                                       ret =3D -EINVAL;
> -                               break;
> -                       default:
> -                               ret =3D -EINVAL;
> -                       }
> -               } else if ((cmd->opcode =3D=3D MMC_READ_MULTIPLE_BLOCK ||
> -                           cmd->opcode =3D=3D MMC_WRITE_MULTIPLE_BLOCK) =
&&
> -                          data->blksz !=3D 512) {
> -                       ret =3D -EINVAL;
> -               }
> -
> -               if (ret < 0) {
> -                       dev_warn(mmc_dev(host->mmc), "%s(): %u blocks of =
%u bytes\n",
> -                                __func__, data->blocks, data->blksz);
> -                       return -EINVAL;
> -               }
> -
> -               if (cmd->opcode =3D=3D MMC_READ_MULTIPLE_BLOCK ||
> -                   cmd->opcode =3D=3D MMC_WRITE_MULTIPLE_BLOCK ||
> -                   (cmd->opcode =3D=3D SD_IO_RW_EXTENDED &&
> -                    data->blocks > 1))
> -                       usdhi6_sg_prep(host);
> -
> -               usdhi6_write(host, USDHI6_SD_SIZE, data->blksz);
> -
> -               if ((data->blksz >=3D USDHI6_MIN_DMA ||
> -                    data->blocks > 1) &&
> -                   (data->blksz % 4 ||
> -                    data->sg->offset % 4))
> -                       dev_dbg(mmc_dev(host->mmc),
> -                               "Bad SG of %u: %ux%u @ %u\n", data->sg_le=
n,
> -                               data->blksz, data->blocks, data->sg->offs=
et);
> -
> -               /* Enable DMA for USDHI6_MIN_DMA bytes or more */
> -               use_dma =3D data->blksz >=3D USDHI6_MIN_DMA &&
> -                       !(data->blksz % 4) &&
> -                       usdhi6_dma_start(host) >=3D DMA_MIN_COOKIE;
> -
> -               if (use_dma)
> -                       usdhi6_write(host, USDHI6_CC_EXT_MODE, USDHI6_CC_=
EXT_MODE_SDRW);
> -
> -               dev_dbg(mmc_dev(host->mmc),
> -                       "%s(): request opcode %u, %u blocks of %u bytes i=
n %u segments, %s %s @+0x%x%s\n",
> -                       __func__, cmd->opcode, data->blocks, data->blksz,
> -                       data->sg_len, use_dma ? "DMA" : "PIO",
> -                       data->flags & MMC_DATA_READ ? "read" : "write",
> -                       data->sg->offset, mrq->stop ? " + stop" : "");
> -       } else {
> -               dev_dbg(mmc_dev(host->mmc), "%s(): request opcode %u\n",
> -                       __func__, cmd->opcode);
> -       }
> -
> -       /* We have to get a command completion interrupt with DMA too */
> -       usdhi6_wait_for_resp(host);
> -
> -       host->wait =3D USDHI6_WAIT_FOR_CMD;
> -       schedule_delayed_work(&host->timeout_work, host->timeout);
> -
> -       /* SEC bit is required to enable block counting by the core */
> -       usdhi6_write(host, USDHI6_SD_STOP,
> -                    data && data->blocks > 1 ? USDHI6_SD_STOP_SEC : 0);
> -       usdhi6_write(host, USDHI6_SD_ARG, cmd->arg);
> -
> -       /* Kick command execution */
> -       usdhi6_write(host, USDHI6_SD_CMD, opc);
> -
> -       return 0;
> -}
> -
> -static void usdhi6_request(struct mmc_host *mmc, struct mmc_request *mrq=
)
> -{
> -       struct usdhi6_host *host =3D mmc_priv(mmc);
> -       int ret;
> -
> -       cancel_delayed_work_sync(&host->timeout_work);
> -
> -       host->mrq =3D mrq;
> -       host->sg =3D NULL;
> -
> -       usdhi6_timeout_set(host);
> -       ret =3D usdhi6_rq_start(host);
> -       if (ret < 0) {
> -               mrq->cmd->error =3D ret;
> -               usdhi6_request_done(host);
> -       }
> -}
> -
> -static int usdhi6_get_cd(struct mmc_host *mmc)
> -{
> -       struct usdhi6_host *host =3D mmc_priv(mmc);
> -       /* Read is atomic, no need to lock */
> -       u32 status =3D usdhi6_read(host, USDHI6_SD_INFO1) & USDHI6_SD_INF=
O1_CD;
> -
> -/*
> - *     level   status.CD       CD_ACTIVE_HIGH  card present
> - *     1       0               0               0
> - *     1       0               1               1
> - *     0       1               0               1
> - *     0       1               1               0
> - */
> -       return !status ^ !(mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
> -}
> -
> -static int usdhi6_get_ro(struct mmc_host *mmc)
> -{
> -       struct usdhi6_host *host =3D mmc_priv(mmc);
> -       /* No locking as above */
> -       u32 status =3D usdhi6_read(host, USDHI6_SD_INFO1) & USDHI6_SD_INF=
O1_WP;
> -
> -/*
> - *     level   status.WP       RO_ACTIVE_HIGH  card read-only
> - *     1       0               0               0
> - *     1       0               1               1
> - *     0       1               0               1
> - *     0       1               1               0
> - */
> -       return !status ^ !(mmc->caps2 & MMC_CAP2_RO_ACTIVE_HIGH);
> -}
> -
> -static void usdhi6_enable_sdio_irq(struct mmc_host *mmc, int enable)
> -{
> -       struct usdhi6_host *host =3D mmc_priv(mmc);
> -
> -       dev_dbg(mmc_dev(mmc), "%s(): %sable\n", __func__, enable ? "en" :=
 "dis");
> -
> -       if (enable) {
> -               host->sdio_mask =3D USDHI6_SDIO_INFO1_IRQ & ~USDHI6_SDIO_=
INFO1_IOIRQ;
> -               usdhi6_write(host, USDHI6_SDIO_INFO1_MASK, host->sdio_mas=
k);
> -               usdhi6_write(host, USDHI6_SDIO_MODE, 1);
> -       } else {
> -               usdhi6_write(host, USDHI6_SDIO_MODE, 0);
> -               usdhi6_write(host, USDHI6_SDIO_INFO1_MASK, USDHI6_SDIO_IN=
FO1_IRQ);
> -               host->sdio_mask =3D USDHI6_SDIO_INFO1_IRQ;
> -       }
> -}
> -
> -static int usdhi6_set_pinstates(struct usdhi6_host *host, int voltage)
> -{
> -       if (IS_ERR(host->pins_uhs))
> -               return 0;
> -
> -       switch (voltage) {
> -       case MMC_SIGNAL_VOLTAGE_180:
> -       case MMC_SIGNAL_VOLTAGE_120:
> -               return pinctrl_select_state(host->pinctrl,
> -                                           host->pins_uhs);
> -
> -       default:
> -               return pinctrl_select_default_state(mmc_dev(host->mmc));
> -       }
> -}
> -
> -static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *=
ios)
> -{
> -       int ret;
> -
> -       ret =3D mmc_regulator_set_vqmmc(mmc, ios);
> -       if (ret < 0)
> -               return ret;
> -
> -       ret =3D usdhi6_set_pinstates(mmc_priv(mmc), ios->signal_voltage);
> -       if (ret)
> -               dev_warn_once(mmc_dev(mmc),
> -                             "Failed to set pinstate err=3D%d\n", ret);
> -       return ret;
> -}
> -
> -static int usdhi6_card_busy(struct mmc_host *mmc)
> -{
> -       struct usdhi6_host *host =3D mmc_priv(mmc);
> -       u32 tmp =3D usdhi6_read(host, USDHI6_SD_INFO2);
> -
> -       /* Card is busy if it is pulling dat[0] low */
> -       return !(tmp & USDHI6_SD_INFO2_SDDAT0);
> -}
> -
> -static const struct mmc_host_ops usdhi6_ops =3D {
> -       .request        =3D usdhi6_request,
> -       .set_ios        =3D usdhi6_set_ios,
> -       .get_cd         =3D usdhi6_get_cd,
> -       .get_ro         =3D usdhi6_get_ro,
> -       .enable_sdio_irq =3D usdhi6_enable_sdio_irq,
> -       .start_signal_voltage_switch =3D usdhi6_sig_volt_switch,
> -       .card_busy =3D usdhi6_card_busy,
> -};
> -
> -/*                     State machine handlers                          *=
/
> -
> -static void usdhi6_resp_cmd12(struct usdhi6_host *host)
> -{
> -       struct mmc_command *cmd =3D host->mrq->stop;
> -       cmd->resp[0] =3D usdhi6_read(host, USDHI6_SD_RSP10);
> -}
> -
> -static void usdhi6_resp_read(struct usdhi6_host *host)
> -{
> -       struct mmc_command *cmd =3D host->mrq->cmd;
> -       u32 *rsp =3D cmd->resp, tmp =3D 0;
> -       int i;
> -
> -/*
> - * RSP10       39-8
> - * RSP32       71-40
> - * RSP54       103-72
> - * RSP76       127-104
> - * R2-type response:
> - * resp[0]     =3D r[127..96]
> - * resp[1]     =3D r[95..64]
> - * resp[2]     =3D r[63..32]
> - * resp[3]     =3D r[31..0]
> - * Other responses:
> - * resp[0]     =3D r[39..8]
> - */
> -
> -       if (mmc_resp_type(cmd) =3D=3D MMC_RSP_NONE)
> -               return;
> -
> -       if (!(host->irq_status & USDHI6_SD_INFO1_RSP_END)) {
> -               dev_err(mmc_dev(host->mmc),
> -                       "CMD%d: response expected but is missing!\n", cmd=
->opcode);
> -               return;
> -       }
> -
> -       if (mmc_resp_type(cmd) & MMC_RSP_136)
> -               for (i =3D 0; i < 4; i++) {
> -                       if (i)
> -                               rsp[3 - i] =3D tmp >> 24;
> -                       tmp =3D usdhi6_read(host, USDHI6_SD_RSP10 + i * 8=
);
> -                       rsp[3 - i] |=3D tmp << 8;
> -               }
> -       else if (cmd->opcode =3D=3D MMC_READ_MULTIPLE_BLOCK ||
> -                cmd->opcode =3D=3D MMC_WRITE_MULTIPLE_BLOCK)
> -               /* Read RSP54 to avoid conflict with auto CMD12 */
> -               rsp[0] =3D usdhi6_read(host, USDHI6_SD_RSP54);
> -       else
> -               rsp[0] =3D usdhi6_read(host, USDHI6_SD_RSP10);
> -
> -       dev_dbg(mmc_dev(host->mmc), "Response 0x%x\n", rsp[0]);
> -}
> -
> -static int usdhi6_blk_read(struct usdhi6_host *host)
> -{
> -       struct mmc_data *data =3D host->mrq->data;
> -       u32 *p;
> -       int i, rest;
> -
> -       if (host->io_error) {
> -               data->error =3D usdhi6_error_code(host);
> -               goto error;
> -       }
> -
> -       if (host->pg.page) {
> -               p =3D host->blk_page + host->offset;
> -       } else {
> -               p =3D usdhi6_sg_map(host);
> -               if (!p) {
> -                       data->error =3D -ENOMEM;
> -                       goto error;
> -               }
> -       }
> -
> -       for (i =3D 0; i < data->blksz / 4; i++, p++)
> -               *p =3D usdhi6_read(host, USDHI6_SD_BUF0);
> -
> -       rest =3D data->blksz % 4;
> -       for (i =3D 0; i < (rest + 1) / 2; i++) {
> -               u16 d =3D usdhi6_read16(host, USDHI6_SD_BUF0);
> -               ((u8 *)p)[2 * i] =3D ((u8 *)&d)[0];
> -               if (rest > 1 && !i)
> -                       ((u8 *)p)[2 * i + 1] =3D ((u8 *)&d)[1];
> -       }
> -
> -       return 0;
> -
> -error:
> -       dev_dbg(mmc_dev(host->mmc), "%s(): %d\n", __func__, data->error);
> -       host->wait =3D USDHI6_WAIT_FOR_REQUEST;
> -       return data->error;
> -}
> -
> -static int usdhi6_blk_write(struct usdhi6_host *host)
> -{
> -       struct mmc_data *data =3D host->mrq->data;
> -       u32 *p;
> -       int i, rest;
> -
> -       if (host->io_error) {
> -               data->error =3D usdhi6_error_code(host);
> -               goto error;
> -       }
> -
> -       if (host->pg.page) {
> -               p =3D host->blk_page + host->offset;
> -       } else {
> -               p =3D usdhi6_sg_map(host);
> -               if (!p) {
> -                       data->error =3D -ENOMEM;
> -                       goto error;
> -               }
> -       }
> -
> -       for (i =3D 0; i < data->blksz / 4; i++, p++)
> -               usdhi6_write(host, USDHI6_SD_BUF0, *p);
> -
> -       rest =3D data->blksz % 4;
> -       for (i =3D 0; i < (rest + 1) / 2; i++) {
> -               u16 d;
> -               ((u8 *)&d)[0] =3D ((u8 *)p)[2 * i];
> -               if (rest > 1 && !i)
> -                       ((u8 *)&d)[1] =3D ((u8 *)p)[2 * i + 1];
> -               else
> -                       ((u8 *)&d)[1] =3D 0;
> -               usdhi6_write16(host, USDHI6_SD_BUF0, d);
> -       }
> -
> -       return 0;
> -
> -error:
> -       dev_dbg(mmc_dev(host->mmc), "%s(): %d\n", __func__, data->error);
> -       host->wait =3D USDHI6_WAIT_FOR_REQUEST;
> -       return data->error;
> -}
> -
> -static int usdhi6_stop_cmd(struct usdhi6_host *host)
> -{
> -       struct mmc_request *mrq =3D host->mrq;
> -
> -       switch (mrq->cmd->opcode) {
> -       case MMC_READ_MULTIPLE_BLOCK:
> -       case MMC_WRITE_MULTIPLE_BLOCK:
> -               if (mrq->stop->opcode =3D=3D MMC_STOP_TRANSMISSION) {
> -                       host->wait =3D USDHI6_WAIT_FOR_STOP;
> -                       return 0;
> -               }
> -               fallthrough;    /* Unsupported STOP command */
> -       default:
> -               dev_err(mmc_dev(host->mmc),
> -                       "unsupported stop CMD%d for CMD%d\n",
> -                       mrq->stop->opcode, mrq->cmd->opcode);
> -               mrq->stop->error =3D -EOPNOTSUPP;
> -       }
> -
> -       return -EOPNOTSUPP;
> -}
> -
> -static bool usdhi6_end_cmd(struct usdhi6_host *host)
> -{
> -       struct mmc_request *mrq =3D host->mrq;
> -       struct mmc_command *cmd =3D mrq->cmd;
> -
> -       if (host->io_error) {
> -               cmd->error =3D usdhi6_error_code(host);
> -               return false;
> -       }
> -
> -       usdhi6_resp_read(host);
> -
> -       if (!mrq->data)
> -               return false;
> -
> -       if (host->dma_active) {
> -               usdhi6_dma_kick(host);
> -               if (!mrq->stop)
> -                       host->wait =3D USDHI6_WAIT_FOR_DMA;
> -               else if (usdhi6_stop_cmd(host) < 0)
> -                       return false;
> -       } else if (mrq->data->flags & MMC_DATA_READ) {
> -               if (cmd->opcode =3D=3D MMC_READ_MULTIPLE_BLOCK ||
> -                   (cmd->opcode =3D=3D SD_IO_RW_EXTENDED &&
> -                    mrq->data->blocks > 1))
> -                       host->wait =3D USDHI6_WAIT_FOR_MREAD;
> -               else
> -                       host->wait =3D USDHI6_WAIT_FOR_READ;
> -       } else {
> -               if (cmd->opcode =3D=3D MMC_WRITE_MULTIPLE_BLOCK ||
> -                   (cmd->opcode =3D=3D SD_IO_RW_EXTENDED &&
> -                    mrq->data->blocks > 1))
> -                       host->wait =3D USDHI6_WAIT_FOR_MWRITE;
> -               else
> -                       host->wait =3D USDHI6_WAIT_FOR_WRITE;
> -       }
> -
> -       return true;
> -}
> -
> -static bool usdhi6_read_block(struct usdhi6_host *host)
> -{
> -       /* ACCESS_END IRQ is already unmasked */
> -       int ret =3D usdhi6_blk_read(host);
> -
> -       /*
> -        * Have to force unmapping both pages: the single block could hav=
e been
> -        * cross-page, in which case for single-block IO host->page_idx =
=3D=3D 0.
> -        * So, if we don't force, the second page won't be unmapped.
> -        */
> -       usdhi6_sg_unmap(host, true);
> -
> -       if (ret < 0)
> -               return false;
> -
> -       host->wait =3D USDHI6_WAIT_FOR_DATA_END;
> -       return true;
> -}
> -
> -static bool usdhi6_mread_block(struct usdhi6_host *host)
> -{
> -       int ret =3D usdhi6_blk_read(host);
> -
> -       if (ret < 0)
> -               return false;
> -
> -       usdhi6_sg_advance(host);
> -
> -       return !host->mrq->data->error &&
> -               (host->wait !=3D USDHI6_WAIT_FOR_DATA_END || !host->mrq->=
stop);
> -}
> -
> -static bool usdhi6_write_block(struct usdhi6_host *host)
> -{
> -       int ret =3D usdhi6_blk_write(host);
> -
> -       /* See comment in usdhi6_read_block() */
> -       usdhi6_sg_unmap(host, true);
> -
> -       if (ret < 0)
> -               return false;
> -
> -       host->wait =3D USDHI6_WAIT_FOR_DATA_END;
> -       return true;
> -}
> -
> -static bool usdhi6_mwrite_block(struct usdhi6_host *host)
> -{
> -       int ret =3D usdhi6_blk_write(host);
> -
> -       if (ret < 0)
> -               return false;
> -
> -       usdhi6_sg_advance(host);
> -
> -       return !host->mrq->data->error &&
> -               (host->wait !=3D USDHI6_WAIT_FOR_DATA_END || !host->mrq->=
stop);
> -}
> -
> -/*                     Interrupt & timeout handlers                    *=
/
> -
> -static irqreturn_t usdhi6_sd_bh(int irq, void *dev_id)
> -{
> -       struct usdhi6_host *host =3D dev_id;
> -       struct mmc_request *mrq;
> -       struct mmc_command *cmd;
> -       struct mmc_data *data;
> -       bool io_wait =3D false;
> -
> -       cancel_delayed_work_sync(&host->timeout_work);
> -
> -       mrq =3D host->mrq;
> -       if (!mrq)
> -               return IRQ_HANDLED;
> -
> -       cmd =3D mrq->cmd;
> -       data =3D mrq->data;
> -
> -       switch (host->wait) {
> -       case USDHI6_WAIT_FOR_REQUEST:
> -               /* We're too late, the timeout has already kicked in */
> -               return IRQ_HANDLED;
> -       case USDHI6_WAIT_FOR_CMD:
> -               /* Wait for data? */
> -               io_wait =3D usdhi6_end_cmd(host);
> -               break;
> -       case USDHI6_WAIT_FOR_MREAD:
> -               /* Wait for more data? */
> -               io_wait =3D usdhi6_mread_block(host);
> -               break;
> -       case USDHI6_WAIT_FOR_READ:
> -               /* Wait for data end? */
> -               io_wait =3D usdhi6_read_block(host);
> -               break;
> -       case USDHI6_WAIT_FOR_MWRITE:
> -               /* Wait data to write? */
> -               io_wait =3D usdhi6_mwrite_block(host);
> -               break;
> -       case USDHI6_WAIT_FOR_WRITE:
> -               /* Wait for data end? */
> -               io_wait =3D usdhi6_write_block(host);
> -               break;
> -       case USDHI6_WAIT_FOR_DMA:
> -               usdhi6_dma_check_error(host);
> -               break;
> -       case USDHI6_WAIT_FOR_STOP:
> -               usdhi6_write(host, USDHI6_SD_STOP, 0);
> -               if (host->io_error) {
> -                       int ret =3D usdhi6_error_code(host);
> -                       if (mrq->stop)
> -                               mrq->stop->error =3D ret;
> -                       else
> -                               mrq->data->error =3D ret;
> -                       dev_warn(mmc_dev(host->mmc), "%s(): %d\n", __func=
__, ret);
> -                       break;
> -               }
> -               usdhi6_resp_cmd12(host);
> -               mrq->stop->error =3D 0;
> -               break;
> -       case USDHI6_WAIT_FOR_DATA_END:
> -               if (host->io_error) {
> -                       mrq->data->error =3D usdhi6_error_code(host);
> -                       dev_warn(mmc_dev(host->mmc), "%s(): %d\n", __func=
__,
> -                                mrq->data->error);
> -               }
> -               break;
> -       default:
> -               cmd->error =3D -EFAULT;
> -               dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->w=
ait);
> -               usdhi6_request_done(host);
> -               return IRQ_HANDLED;
> -       }
> -
> -       if (io_wait) {
> -               schedule_delayed_work(&host->timeout_work, host->timeout)=
;
> -               /* Wait for more data or ACCESS_END */
> -               if (!host->dma_active)
> -                       usdhi6_wait_for_brwe(host, mrq->data->flags & MMC=
_DATA_READ);
> -               return IRQ_HANDLED;
> -       }
> -
> -       if (!cmd->error) {
> -               if (data) {
> -                       if (!data->error) {
> -                               if (host->wait !=3D USDHI6_WAIT_FOR_STOP =
&&
> -                                   host->mrq->stop &&
> -                                   !host->mrq->stop->error &&
> -                                   !usdhi6_stop_cmd(host)) {
> -                                       /* Sending STOP */
> -                                       usdhi6_wait_for_resp(host);
> -
> -                                       schedule_delayed_work(&host->time=
out_work,
> -                                                             host->timeo=
ut);
> -
> -                                       return IRQ_HANDLED;
> -                               }
> -
> -                               data->bytes_xfered =3D data->blocks * dat=
a->blksz;
> -                       } else {
> -                               /* Data error: might need to unmap the la=
st page */
> -                               dev_warn(mmc_dev(host->mmc), "%s(): data =
error %d\n",
> -                                        __func__, data->error);
> -                               usdhi6_sg_unmap(host, true);
> -                       }
> -               } else if (cmd->opcode =3D=3D MMC_APP_CMD) {
> -                       host->app_cmd =3D true;
> -               }
> -       }
> -
> -       usdhi6_request_done(host);
> -
> -       return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t usdhi6_sd(int irq, void *dev_id)
> -{
> -       struct usdhi6_host *host =3D dev_id;
> -       u16 status, status2, error;
> -
> -       status =3D usdhi6_read(host, USDHI6_SD_INFO1) & ~host->status_mas=
k &
> -               ~USDHI6_SD_INFO1_CARD;
> -       status2 =3D usdhi6_read(host, USDHI6_SD_INFO2) & ~host->status2_m=
ask;
> -
> -       usdhi6_only_cd(host);
> -
> -       dev_dbg(mmc_dev(host->mmc),
> -               "IRQ status =3D 0x%08x, status2 =3D 0x%08x\n", status, st=
atus2);
> -
> -       if (!status && !status2)
> -               return IRQ_NONE;
> -
> -       error =3D status2 & USDHI6_SD_INFO2_ERR;
> -
> -       /* Ack / clear interrupts */
> -       if (USDHI6_SD_INFO1_IRQ & status)
> -               usdhi6_write(host, USDHI6_SD_INFO1,
> -                            0xffff & ~(USDHI6_SD_INFO1_IRQ & status));
> -
> -       if (USDHI6_SD_INFO2_IRQ & status2) {
> -               if (error)
> -                       /* In error cases BWE and BRE aren't cleared auto=
matically */
> -                       status2 |=3D USDHI6_SD_INFO2_BWE | USDHI6_SD_INFO=
2_BRE;
> -
> -               usdhi6_write(host, USDHI6_SD_INFO2,
> -                            0xffff & ~(USDHI6_SD_INFO2_IRQ & status2));
> -       }
> -
> -       host->io_error =3D error;
> -       host->irq_status =3D status;
> -
> -       if (error) {
> -               /* Don't pollute the log with unsupported command timeout=
s */
> -               if (host->wait !=3D USDHI6_WAIT_FOR_CMD ||
> -                   error !=3D USDHI6_SD_INFO2_RSP_TOUT)
> -                       dev_warn(mmc_dev(host->mmc),
> -                                "%s(): INFO2 error bits 0x%08x\n",
> -                                __func__, error);
> -               else
> -                       dev_dbg(mmc_dev(host->mmc),
> -                               "%s(): INFO2 error bits 0x%08x\n",
> -                               __func__, error);
> -       }
> -
> -       return IRQ_WAKE_THREAD;
> -}
> -
> -static irqreturn_t usdhi6_sdio(int irq, void *dev_id)
> -{
> -       struct usdhi6_host *host =3D dev_id;
> -       u32 status =3D usdhi6_read(host, USDHI6_SDIO_INFO1) & ~host->sdio=
_mask;
> -
> -       dev_dbg(mmc_dev(host->mmc), "%s(): status 0x%x\n", __func__, stat=
us);
> -
> -       if (!status)
> -               return IRQ_NONE;
> -
> -       usdhi6_write(host, USDHI6_SDIO_INFO1, ~status);
> -
> -       mmc_signal_sdio_irq(host->mmc);
> -
> -       return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t usdhi6_cd(int irq, void *dev_id)
> -{
> -       struct usdhi6_host *host =3D dev_id;
> -       struct mmc_host *mmc =3D host->mmc;
> -       u16 status;
> -
> -       /* We're only interested in hotplug events here */
> -       status =3D usdhi6_read(host, USDHI6_SD_INFO1) & ~host->status_mas=
k &
> -               USDHI6_SD_INFO1_CARD;
> -
> -       if (!status)
> -               return IRQ_NONE;
> -
> -       /* Ack */
> -       usdhi6_write(host, USDHI6_SD_INFO1, ~status);
> -
> -       if (!work_pending(&mmc->detect.work) &&
> -           (((status & USDHI6_SD_INFO1_CARD_INSERT) &&
> -             !mmc->card) ||
> -            ((status & USDHI6_SD_INFO1_CARD_EJECT) &&
> -             mmc->card)))
> -               mmc_detect_change(mmc, msecs_to_jiffies(100));
> -
> -       return IRQ_HANDLED;
> -}
> -
> -/*
> - * Actually this should not be needed, if the built-in timeout works rel=
iably in
> - * the both PIO cases and DMA never fails. But if DMA does fail, a timeo=
ut
> - * handler might be the only way to catch the error.
> - */
> -static void usdhi6_timeout_work(struct work_struct *work)
> -{
> -       struct delayed_work *d =3D to_delayed_work(work);
> -       struct usdhi6_host *host =3D container_of(d, struct usdhi6_host, =
timeout_work);
> -       struct mmc_request *mrq =3D host->mrq;
> -       struct mmc_data *data =3D mrq ? mrq->data : NULL;
> -       struct scatterlist *sg;
> -
> -       dev_warn(mmc_dev(host->mmc),
> -                "%s timeout wait %u CMD%d: IRQ 0x%08x:0x%08x, last IRQ 0=
x%08x\n",
> -                host->dma_active ? "DMA" : "PIO",
> -                host->wait, mrq ? mrq->cmd->opcode : -1,
> -                usdhi6_read(host, USDHI6_SD_INFO1),
> -                usdhi6_read(host, USDHI6_SD_INFO2), host->irq_status);
> -
> -       if (host->dma_active) {
> -               usdhi6_dma_kill(host);
> -               usdhi6_dma_stop_unmap(host);
> -       }
> -
> -       switch (host->wait) {
> -       default:
> -               dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->w=
ait);
> -               fallthrough;    /* mrq can be NULL, but is impossible */
> -       case USDHI6_WAIT_FOR_CMD:
> -               usdhi6_error_code(host);
> -               if (mrq)
> -                       mrq->cmd->error =3D -ETIMEDOUT;
> -               break;
> -       case USDHI6_WAIT_FOR_STOP:
> -               usdhi6_error_code(host);
> -               mrq->stop->error =3D -ETIMEDOUT;
> -               break;
> -       case USDHI6_WAIT_FOR_DMA:
> -       case USDHI6_WAIT_FOR_MREAD:
> -       case USDHI6_WAIT_FOR_MWRITE:
> -       case USDHI6_WAIT_FOR_READ:
> -       case USDHI6_WAIT_FOR_WRITE:
> -               sg =3D host->sg ?: data->sg;
> -               dev_dbg(mmc_dev(host->mmc),
> -                       "%c: page #%u @ +0x%zx %ux%u in SG%u. Current SG =
%u bytes @ %u\n",
> -                       data->flags & MMC_DATA_READ ? 'R' : 'W', host->pa=
ge_idx,
> -                       host->offset, data->blocks, data->blksz, data->sg=
_len,
> -                       sg_dma_len(sg), sg->offset);
> -               usdhi6_sg_unmap(host, true);
> -               fallthrough;    /* page unmapped in USDHI6_WAIT_FOR_DATA_=
END */
> -       case USDHI6_WAIT_FOR_DATA_END:
> -               usdhi6_error_code(host);
> -               data->error =3D -ETIMEDOUT;
> -       }
> -
> -       if (mrq)
> -               usdhi6_request_done(host);
> -}
> -
> -/*                      Probe / release                                *=
/
> -
> -static const struct of_device_id usdhi6_of_match[] =3D {
> -       {.compatible =3D "renesas,usdhi6rol0"},
> -       {}
> -};
> -MODULE_DEVICE_TABLE(of, usdhi6_of_match);
> -
> -static int usdhi6_probe(struct platform_device *pdev)
> -{
> -       struct device *dev =3D &pdev->dev;
> -       struct mmc_host *mmc;
> -       struct usdhi6_host *host;
> -       struct resource *res;
> -       int irq_cd, irq_sd, irq_sdio;
> -       u32 version;
> -       int ret;
> -
> -       if (!dev->of_node)
> -               return -ENODEV;
> -
> -       irq_cd =3D platform_get_irq_byname(pdev, "card detect");
> -       irq_sd =3D platform_get_irq_byname(pdev, "data");
> -       irq_sdio =3D platform_get_irq_byname(pdev, "SDIO");
> -       if (irq_sd < 0)
> -               return irq_sd;
> -       if (irq_sdio < 0)
> -               return irq_sdio;
> -
> -       mmc =3D devm_mmc_alloc_host(dev, sizeof(*host));
> -       if (!mmc)
> -               return -ENOMEM;
> -
> -       ret =3D mmc_regulator_get_supply(mmc);
> -       if (ret)
> -               return ret;
> -
> -       ret =3D mmc_of_parse(mmc);
> -       if (ret < 0)
> -               return ret;
> -
> -       host            =3D mmc_priv(mmc);
> -       host->mmc       =3D mmc;
> -       host->wait      =3D USDHI6_WAIT_FOR_REQUEST;
> -       host->timeout   =3D msecs_to_jiffies(USDHI6_REQ_TIMEOUT_MS);
> -       /*
> -        * We use a fixed timeout of 4s, hence inform the core about it. =
A
> -        * future improvement should instead respect the cmd->busy_timeou=
t.
> -        */
> -       mmc->max_busy_timeout =3D USDHI6_REQ_TIMEOUT_MS;
> -
> -       host->pinctrl =3D devm_pinctrl_get(&pdev->dev);
> -       if (IS_ERR(host->pinctrl))
> -               return PTR_ERR(host->pinctrl);
> -
> -       host->pins_uhs =3D pinctrl_lookup_state(host->pinctrl, "state_uhs=
");
> -
> -       host->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &r=
es);
> -       if (IS_ERR(host->base))
> -               return PTR_ERR(host->base);
> -
> -       host->clk =3D devm_clk_get(dev, NULL);
> -       if (IS_ERR(host->clk))
> -               return PTR_ERR(host->clk);
> -
> -       host->imclk =3D clk_get_rate(host->clk);
> -
> -       ret =3D clk_prepare_enable(host->clk);
> -       if (ret < 0)
> -               return ret;
> -
> -       version =3D usdhi6_read(host, USDHI6_VERSION);
> -       if ((version & 0xfff) !=3D 0xa0d) {
> -               ret =3D -EPERM;
> -               dev_err(dev, "Version not recognized %x\n", version);
> -               goto e_clk_off;
> -       }
> -
> -       dev_info(dev, "A USDHI6ROL0 SD host detected with %d ports\n",
> -                usdhi6_read(host, USDHI6_SD_PORT_SEL) >> USDHI6_SD_PORT_=
SEL_PORTS_SHIFT);
> -
> -       usdhi6_mask_all(host);
> -
> -       if (irq_cd >=3D 0) {
> -               ret =3D devm_request_irq(dev, irq_cd, usdhi6_cd, 0,
> -                                      dev_name(dev), host);
> -               if (ret < 0)
> -                       goto e_clk_off;
> -       } else {
> -               mmc->caps |=3D MMC_CAP_NEEDS_POLL;
> -       }
> -
> -       ret =3D devm_request_threaded_irq(dev, irq_sd, usdhi6_sd, usdhi6_=
sd_bh, 0,
> -                              dev_name(dev), host);
> -       if (ret < 0)
> -               goto e_clk_off;
> -
> -       ret =3D devm_request_irq(dev, irq_sdio, usdhi6_sdio, 0,
> -                              dev_name(dev), host);
> -       if (ret < 0)
> -               goto e_clk_off;
> -
> -       INIT_DELAYED_WORK(&host->timeout_work, usdhi6_timeout_work);
> -
> -       usdhi6_dma_request(host, res->start);
> -
> -       mmc->ops =3D &usdhi6_ops;
> -       mmc->caps |=3D MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
> -                    MMC_CAP_SDIO_IRQ;
> -       /* Set .max_segs to some random number. Feel free to adjust. */
> -       mmc->max_segs =3D 32;
> -       mmc->max_blk_size =3D 512;
> -       mmc->max_req_size =3D PAGE_SIZE * mmc->max_segs;
> -       mmc->max_blk_count =3D mmc->max_req_size / mmc->max_blk_size;
> -       /*
> -        * Setting .max_seg_size to 1 page would simplify our page-mappin=
g code,
> -        * But OTOH, having large segments makes DMA more efficient. We c=
ould
> -        * check, whether we managed to get DMA and fall back to 1 page
> -        * segments, but if we do manage to obtain DMA and then it fails =
at
> -        * run-time and we fall back to PIO, we will continue getting lar=
ge
> -        * segments. So, we wouldn't be able to get rid of the code anywa=
y.
> -        */
> -       mmc->max_seg_size =3D mmc->max_req_size;
> -       if (!mmc->f_max)
> -               mmc->f_max =3D host->imclk;
> -       mmc->f_min =3D host->imclk / 512;
> -
> -       platform_set_drvdata(pdev, host);
> -
> -       ret =3D mmc_add_host(mmc);
> -       if (ret < 0)
> -               goto e_release_dma;
> -
> -       return 0;
> -
> -e_release_dma:
> -       usdhi6_dma_release(host);
> -e_clk_off:
> -       clk_disable_unprepare(host->clk);
> -       return ret;
> -}
> -
> -static void usdhi6_remove(struct platform_device *pdev)
> -{
> -       struct usdhi6_host *host =3D platform_get_drvdata(pdev);
> -
> -       mmc_remove_host(host->mmc);
> -
> -       usdhi6_mask_all(host);
> -       cancel_delayed_work_sync(&host->timeout_work);
> -       usdhi6_dma_release(host);
> -       clk_disable_unprepare(host->clk);
> -}
> -
> -static struct platform_driver usdhi6_driver =3D {
> -       .probe          =3D usdhi6_probe,
> -       .remove         =3D usdhi6_remove,
> -       .driver         =3D {
> -               .name   =3D "usdhi6rol0",
> -               .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> -               .of_match_table =3D usdhi6_of_match,
> -       },
> -};
> -
> -module_platform_driver(usdhi6_driver);
> -
> -MODULE_DESCRIPTION("Renesas usdhi6rol0 SD/SDIO host driver");
> -MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("platform:usdhi6rol0");
> -MODULE_AUTHOR("Guennadi Liakhovetski <g.liakhovetski@gmx.de>");
> --
> 2.53.0
>
