Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793358059;
	b=d08MwKHXBhGQTro+ByY38SpIvhAXngdqhLyuVdwnUHZfhwbzaGW0yso0zfflJ9YRpAv9
	 6ye0l72QX7pUXdoJCTeF8ckoQkhCAQAeKUD6EDxtjvdWrVOg9F4XZyzm6nCT9FpzXnht9
	 xo4ehZ0vNkzyaqgmMf7xHbQCFLlyfsrryhy3/ZTkiyHFvtOV0lvb470Kb1Z1njxT6A9gd
	 3PYOb7V34GazHbsaRbtv48HcrNMcMVzB8nZ/VaWDfbkYI66ZKB58BMwrhc4Ii0+ohdFrl
	 bu+u2HJQKDrAh/uL9cBQtE7rU3+/BQVzDQKqVNbRt1MFe7Pv/qhZYr4ETtcpYVXJ+EQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358059;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=dAJ/hdUbWhcFTxamLR0wIqhORt4vEbGpFTQmQv3h7+g=;
	b=lxuwADjNhWSF/8nT9cfAoG5Y/XGXz58MABQjn1QFKnymtv5xP5UHTkKOnP9Q3WT+m/gP
	 U3bai1JojF9bmFbHbQbY8VsdVuiZ8brkI77QcK83+3cM8LY+qaCRttGT55+W1/QXzUsT9
	 B51wwrD1rQ2DoRx4SCs8tfSc9fInaljNEpSIfS9ULl79Aea9reAewvgZLKxXSZ/BKiVdN
	 pOxDnE/8qqvk9EiEGH6jcwzBO9Bz22dW11Tu1u2OMjkaOpph79jZx9NAtZ+7/6Y7SwQZd
	 eh8GOtUaIZ6vjUdeWcpP8mDMSkhIzSo6jPx0T+OAAo1dLf1VDl9cqaj6NPZSWn9XFsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SRSz+U2n;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P5pnofUO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF4C606A33F
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FF4C606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SRSz+U2n;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P5pnofUO
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8FJp02733230
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dAJ/hdUbWhcFTxamLR0wIqhORt4vEbGpFTQmQv3h7+g=; b=SRSz+U2nRlJjrKpd
	Q6yg7Bis+ATQdENbDuC3boFhFxQXruNNjF5GKAiOHMK1ZUkeGa4oqcl2AyzInRiF
	VNCXoz5L6+6oBpNwKard8J79jfQNHTRU0sI01CQtej2l9OgXwHgJxOvUTU1BXQ8Z
	SG8jfDxeMq76H/ituJS90fLE0lzYD6AxWMxJFOjUAJyQ/H+TmlVEn+vZoJM2WAXa
	dPtZQK2eftP1JhV9QYnMD19qhDhvEUj+vV1N8WchYs8SwxmO3qW5ea3Hh5CVY+Cz
	p9hfWCQGVPPtA+HY5cEqo1yoQlSZ3fHYxWA87/oUD521A8wMEs5tiBK0HVTsG6Ym
	hN9rTg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qjk2c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:58 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-99076c676cbso134569241.3
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 04:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793358057; cv=none;
        d=google.com; s=arc-20260327;
        b=fKiZcPOCvHtJ5dzPpcABLdQLvzP0N0Jieefx+CG0hdnifwPZFJ2/bOyBWP8yW1Rog+
         3Oqbt9RT07+4l5qgJLeEkKV5JvOdzrN4KxVl6qk/kXzypa7Fcqe8doIHDXr0mVzqCMHJ
         sW9yHN8y+32zo+afWmXXHrBZOksXEgSwYmmwqjW5EEAu1g+JHKh1tgmh4fvn4f/BAYuU
         DU+HFJk4N3cFyLvV9Fl+BbP+B9uF4IHc9u0TglKztvHDRmJABC10KTDZNkQa49GkV1TV
         z5MF2w5EawhS4rj/HmaMuPi91V3rdoIbVTdN2y3dqc1+mxDSAYnYP5u9rNf/RaLjJugA
         2SXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dAJ/hdUbWhcFTxamLR0wIqhORt4vEbGpFTQmQv3h7+g=;
        fh=aeKeDVaIK1NuiozMdbYlxrWgViT0NRVdNL+mAgRFsBg=;
        b=IdpXSK36ezQXq0GQqkpxHcBxpO+XD0OwemdQZZpwR8vtF6admoqAQL1zD0Mrito1ZQ
         TdrdXCzmogLan69PhC8eG6GtKoHjvAPpcOXgBfQVs9Yq9bSU5UnrS9pvPg97k/xmsxo2
         azu4Hn4qy6TT28OHhj/J2oy7vl4TNPDdxm5jilFA1vbPho7QgxMqtTEDFU+05e2Z3Z2t
         RfnvJMMpqrCQsAdbFFL1aYGw/nAuHpi6GPDYnA1bSG/g93YEvDDkjLUcUGo3KPgmdENS
         KT26Pc4QLOZ1f4OX4cD9CaTENjmEUtpPTY2QyuZ+UIESEn54ZSP/6+GIPkQea7FU5sAp
         UGyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793358057; x=1793962857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dAJ/hdUbWhcFTxamLR0wIqhORt4vEbGpFTQmQv3h7+g=;
        b=P5pnofUO2//tTlR9GgLza56sM0BOdz1yk/mxyTq/ku0ZwJjkBAMBC5VqyrzNunCz6O
         XzSgG6Qm3YALEEM65i1UDqnsHIUQql096FvBbrPAClB3HO3cjWj6UNLt9+dVoqB5Q7zQ
         e/FkB6/6L6ZQ0laoXn+gkg0HxmYzXVX+0zyNyCEPbnMpFluXBgTRA0cW3LRKVctkEMeb
         8shQgSXlTTDzOCeOAc8xhyyrSCwklgLpHHnLAjeu3oXXNo8PFWIEk+Or1h/R3rs9H65C
         HVHIDIHWTCOgNmQGWb6M1/SnG0GYg3yn3Esuppyd1mO/U/VVIQR6XJ/MkI/xUXAFapnD
         LNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793358057; x=1793962857;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dAJ/hdUbWhcFTxamLR0wIqhORt4vEbGpFTQmQv3h7+g=;
        b=v/UQ4jNvXpiRl7PNWMbP8vquJUxjx+M9vdIZ0ln65xnsVZFWJWVB326kViQaMyLOdj
         ng50MJX8yWa835j6vo52knygO/4caIGEu7kHt6HzbtTjr6JJNWPEETrb4z4LtL4+bw5W
         rUjwmYR3w4X8QZZL+8XiFzWOBC2aA7c4/vwUNSmSAq4yUhxUIOKlQ7EfVIPMcfsaprOR
         dUBnmzRIWjNU2iN6mPyRiYRkNY4sefUidnmtLsaVsL3cHxn3lOnYT5ESQbvoait5o1ZO
         R5JqNNblv4xkqgq6oft+BWzwLdkQwjYo4f2TCz5V7RSljt2+YRm2/HzmfUrzzy4S6vLL
         LH8A==
X-Forwarded-Encrypted: i=1; AKwUvBw7qJeTyDAq2ey4tFl/Wyfk3jJaBUlmM3bzXbXUtF642Xjd0W+LQYolr46sqwmlfOyBB/XF3J/6tDI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLejWcCm5rGSNCiOs0ga+IqZjqNmam139PwrzgVgiyyThIfYXe4
	aD4tqnXYmmGN+2ERakRfrM34BzXCEYjiY6w2MA2AyfikWK7vyutFriMfEbOqMrayafyS8Vd6J6P
	s2PNk19MGSUYCVYMSe49g4Z0Gu485fA62G1aUCAvwJdTq2TnAilS1YoHQnw7IBHgytolt8IYB/b
	kJbCU4eqZTButK3SDfTgeApHxKFbGWtzyHDHUmHNxd6eHttA==
X-Gm-Gg: AYBFou10XTVSo5oO3r+m9RpX5UcjIwvlwgO8sI+o7cErl55fm6pDtdg/MhGX0thgLUC
	/h8vTWy3qqKakBpst/qJWaBurnC6vQdN+oCv84NZY7ax+sJfLbI/u5Kma0XYyXTo26wlddJVhQS
	ZLSBQ27l1aYqP+yCLNKkOTTNbCBG5eOiK3ur7eMZLOmCNkE8vingL5vDhhYw==
X-Received: by 2002:a05:6102:f86:b0:7c1:8aa5:36d6 with SMTP id ada2fe7eead31-7d072baa420mr807235137.11.1793358057276;
        Fri, 30 Oct 2026 04:00:57 -0700 (PDT)
X-Received: by 2002:a05:6102:f86:b0:7c1:8aa5:36d6 with SMTP id
 ada2fe7eead31-7d072baa420mr807207137.11.1793358056590; Fri, 30 Oct 2026
 04:00:56 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026083323.12301-1-olivier@mgcrea.io>
In-Reply-To: <20261026083323.12301-1-olivier@mgcrea.io>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 12:00:43 +0100
X-Gm-Features: AclHuK-AAb62Ju0lDchg6Zmy0m7PPdxFmDlZjEld1Ivf9CvuOqz-27SR1i_D8JE
Message-ID: <CAPx+jO_ZxVn3kRiWpQEZ+RcbMG-wKznXo+F-2v2Yc4WpHQzqFw@mail.gmail.com>
Subject: Re: [PATCH] mmc: jz4740: Remove the host before resetting the controller
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Ulf Hansson <ulfh@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: sh3GZ0pNxxwBfkfL0jov_j-wH0z7-VEs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfX48AZEzfq+Cul
 G4F/4PlhwFZdoaSlIFxUXCrEDTjHaVEMQIQoqXriyPHPtpl6DJhVdHj24BSUl75J7d6JLXMQHGp
 hvfr605qHEgAsT4kXESO4lLJvGbF9/8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfXwW0mIZGxB2ca
 fgBKukq+R8TVYLb28vgLRjGExHYKODjWcppuM1iw/lge1F+90eY+Lptm7e19OwVHhw4CE/kn/Ie
 O1yLaeNRBdZIuDMc+8AwiD2KoMIlz/JmzG3llCzj4sF1Y+IsZUkdw3Pz815kg+E8beuZoiOQNXS
 IqxeJq7IOulsdCy9iMuU0w9oIO1pmi+Y5UMW4J74oT5aTW/nAQL6D9TnjuM9yvr0Fk5HVsq988H
 OmGS5TLRxCbnP89GGOw0DI/CGtITbv2X4iUmAvCrCNfXtucz4+W+ZdrHz1YSk8KC35p4D1jO09b
 fuoe3DS40ZkqkH0LvZlL+mTLQANFJi2wYaU7O1MuBPbPaoMb9SlDjH2lzZ1mHSwjHMcSti7nvm+
 BqAhRL150MKNSfEmYh9ypGzhbmUad1id2DUGQp3JOUfeSM+G/Y0JuoYeg1YE13CJnz7mmVHJc+r
 QFPD7pD27CwgXR0k2Ew==
X-Proofpoint-ORIG-GUID: sh3GZ0pNxxwBfkfL0jov_j-wH0z7-VEs
X-Authority-Analysis: v=2.4 cv=TpVzFzXh c=1 sm=1 tr=0 ts=6ae478ea cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=2DRyhdssraMOevLgf_oA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300043

On Mon, Oct 26, 2026 at 9:34=E2=80=AFAM Olivier Louvignes <olivier@mgcrea.i=
o> wrote:
>
> jz4740_mmc_remove() masks every interrupt and resets the controller
> before mmc_remove_host(), which removes the card and lets the card's
> driver send its last commands. Those commands then run on a controller
> that was just reset, and can wait out the driver's 5 s request timeout.
>
> With an SDIO card that cost 5 s on every unbind: on a HiBy R1 (Ingenic
> X1600, a BCM43430A1 driven by brcmfmac), the CMD52 that
> sdio_release_irq() sends from brcmfmac's remove waited 5.1 s. The
> command had finished (END_CMD_RES set in MSC_STAT), but MSC_IMASK read
> 0xffffffff although the request had unmasked END_CMD_RES. MSC_STAT can
> still show IS_RESETTING after jz4740_mmc_reset() returns, so the reset
> most likely completed after that write and undid it.
>
> Remove the host first, then quiesce the controller, as other host
> drivers do. On the R1, unbinding the Wi-Fi's MSC now takes 0.65 s.
>
> Fixes: 61bfbdb85687 ("MMC: Add support for the controller on JZ4740 SoCs.=
")
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/jz4740_mmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.=
c
> index 6a3c26b7c82d..923cf1450de5 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -1151,12 +1151,13 @@ static void jz4740_mmc_remove(struct platform_dev=
ice *pdev)
>  {
>         struct jz4740_mmc_host *host =3D platform_get_drvdata(pdev);
>
> +       /* The card's driver may still send commands as it goes */
> +       mmc_remove_host(host->mmc);
> +
>         timer_delete_sync(&host->timeout_timer);
>         jz4740_mmc_set_irq_enabled(host, 0xff, false);
>         jz4740_mmc_reset(host);
>
> -       mmc_remove_host(host->mmc);
> -
>         free_irq(host->irq, host);
>
>         if (host->use_dma)
>
> base-commit: fd9af27f6c2319713bb23832066585f8a59a1771
> --
> 2.39.5
>
