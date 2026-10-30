Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793368846;
	b=utV9Fzk/sB42+wRTjdDik93gPLyu1mjbKpI6H6K2Clpz0JHXs1rwQXlD2RQ+7LYwdecP
	 +YHsUMaWH4LuKAS0rml5AKM7nqQZqNI6OMQnMgMiNSsvF+N+rb2ZUy6ldKsMsYWLr/DUh
	 fxrgjJUCnMeGBkFXrnrav3jCp6n/3hmKs0EVZ5puqu8YS3uDACLs62upHqvy71NjgedVy
	 i0K8uFwbRDdq8hSI3cYb74e/RcCN2TMV2JGrUO05+1/bEUyOsOsuYPFNQECWNMA6Lz6yB
	 1aa2nUqltRruykK0e3cxHWiLT4lZt1tPv4ssQte2lT+SfxvpAG/VlBIrA76lTTIg7+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368846;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=uAfz1CBg89gTTrNRgxCYtcGq77WiqvE+shO/P+3SRQk=;
	b=escPue0IZUh69FL9FDTaym4ASfG3Ih6aOS824vwwezCf1oVe/PU4OMp2mwTm6dz7qw/T
	 nF3Rsde9Nw2TaEGBWuYdksYCr8XrFEslbLmkPgU0DaCzLNVArdXK34ooP95yGr78cdKfV
	 Sxttznuw/6HvsZB5p2zdwloLaRXiXJQfD+bHaMsal6BEDTIWbjISn+R/xR8GbBDmKCeXY
	 1zsTN3OSGNjlxTyTU/Ztz/s1OxyKWtX7e3Zh6cZp5qpara1PlK4mYosOiJRl6VZnVoQyo
	 jK4K3S8Cbvz15ooPF9dqU0I+EbVkVZDItVc+iGDFz2fSZ6LgDqikgaE2w9Fvx5GzOVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yp5wOBuY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KdF0T0Iq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2111606A325
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 14:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2111606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yp5wOBuY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KdF0T0Iq
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UDnEIN4019651
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 14:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uAfz1CBg89gTTrNRgxCYtcGq77WiqvE+shO/P+3SRQk=; b=Yp5wOBuYUvaZ9G8H
	Y1Ge9H+4Uez+7kLRVDPNkz4UIdvmsydhiWxon7uANhBzMmnRD4gl4ktaeTi7mg1s
	e0O0BgJCK0RC5wjWI0qIafUgGDuhxHpYBQDi5Wq+ocDWDCGq6cVCNarTRp9nmrhL
	w/1K3hutLf4UKu83ZkdzgXoKWv1CPqy0/LBn2Dpm7ff5xpkl19H13Fn8+HXVwJQJ
	jonaNFWMxz/1aG0P98FMwkS8WWWzGZF5MkDntYotkgojATsIDlO08MftH9z5v6Ce
	l+D8tzVXSZfHpPU4HJ1K/LUz7NvfuyaefcFPpGSPbPHr6vXgV43GG/GFuf6ct9bZ
	GpjimA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkbwv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 14:00:44 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e869e00005so13123825ad.2
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 07:00:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793368844; cv=none;
        d=google.com; s=arc-20260327;
        b=lkWdtlR07rNNexqa8nzfeERCPhX4PvQ2ouW6WrDV3nx/TtP++n/5/+fj8/DiNOfy3f
         yjVKbi9JzziV+1aqWe7X4YCoioyYiDHrPMOB55//djoxc+pLGNKOHRV49xWqEsFFBL9E
         IZULBEJSXaH602rK0rdJXisNIXC2Y92fbLdZgapIxv0R5qqSeKDqG0QdGoy92Q4t9uhZ
         +asif+hd6H8cbePq8uj2orHxNyVF6DQ5nL+T4Xh1DLH98xw+6zcfH1uxf0Iz6zNhdR9D
         Erfrt1LwpDWogh2+OqrPyNm6xfA4Z/u5Pl/A621FnXvyhmQqnjTooIgC4L7Xqx0LTmQ7
         KUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uAfz1CBg89gTTrNRgxCYtcGq77WiqvE+shO/P+3SRQk=;
        fh=59EKiSBm5o8tiF1Xzc9rOLU8Ev86Qg4ENcocJjvfdPo=;
        b=sja6ZoM8YotNgOpZw0FOdGoJK74rRViKh9es1MFv1dRV4risVvuCrG75tRvxnisREf
         6xjZ5B82TtUJpODSzC0MLHzHr8777z6bs0X+jyClPOfIuOJZSR1Vq5x2wbIur+vQ9Ghp
         nLuG+zbp+sIK+qunlBVxpmiLGFlADlPbHIXgLYL0n5232FD+t0WnlCrGNbsBJx4PpMRZ
         GXZDjnO5O+jUyRwv/54BzKAfZeL+8GhZRJUR2NLdFz5JBBTRVSmV5f9pLTfDFZSpYwtq
         Bgqq0ZUn72zLZZcDdblFxjJgZ6Yey6/650llC5QPxvI7l5rBLcbExCfn2KA0vguFNtko
         fyGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793368844; x=1793973644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uAfz1CBg89gTTrNRgxCYtcGq77WiqvE+shO/P+3SRQk=;
        b=KdF0T0IqR/9u+is73hbl4kFHKP1fyNZK4lGWMSIf9mV15FJOdvxLhao1WqkAQC2D4r
         Fip0tn//jq40e8dEZ/0qfqbMEXM5J6+2hR5uKZXS+T1iy/tD4ky873EDCXyDcVT3x6ZE
         jFWlUJCa28Q8spZsHdNZy0IjkRXwoQ4qXRHcXaZ9x6R1GLHMZWU0wXplIfrZgNjYFCTW
         2fG86BkFOY2baLKHrJLEpHRDmH7SAD2TF8gHe/cF14+aqt31WSiBzHfUd2kybgb8PvLl
         vWmL+riRzG6fVPJ+j2kTTOFQ05jxNR78gcsGiwV2Zbd1ENhvQl5UTk7oNFpPJEKVFerb
         3Gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368844; x=1793973644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uAfz1CBg89gTTrNRgxCYtcGq77WiqvE+shO/P+3SRQk=;
        b=wmdRSjSViWuSJHOGPynEqPlL6Ttw3XAjerwSLZJn9d258uhfqIC7ai3RIrFW3MivSm
         9a1tSmvcxfyuvHMlHdnUiAvTkNnYlbHcPle8jV2azBaSsb35vyGYxN6P68xnr+zz2RMZ
         dJ1llxOjIgNH+QCM5Cp7RasF72wTbt3br3xnq0QXmswdHYvvsjL7/EA8SFwT6IWl0Nrn
         5Srwh/RtfQTePQdoG3Uua4kf0VujeUSvvr66uxQeEcBQykmhIrQQjP/RsMUeElBPm2VY
         bO0xuKxpEG0tDPeGMHmCdP3wJAUGoUM/dk0G2Ru2KGinIcHyT3Mm9M4J3X/LreRmEIpD
         FM5w==
X-Forwarded-Encrypted: i=1; AKwUvBxCwt5e7kw7iwZe80Jn7XStNHMjf3mBDEqVeSVOn1vxAkfmoFS0cy8fTtVw4erqz7ATMN0XNeOTX+4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJc8o8pXF4mImEDiE0UecGsxIKwP/ezUuFHkzENzhwXIX9R6FeZ
	36jjA4KMlLHEALzUYfrY9rJm8Rr9DBVPbAfQ7O9Sp2dXML/B7j+T55ju9ZiYtKKJ30VWkw9AXvq
	Utr/uvxpzz42tL/1aS7KJkz1mXvHaEZhcp+sKYL4Rr2tb6MH3jrqtK2BLIpC+qpMBi2+rAEB0U5
	oV/fHQynN70GgI9EZY/l17Krd+sAixvNviZEz7Jw==
X-Gm-Gg: AYBFou2CQstLC9G3HnrZr17uqdUDeWORTHbbS72DoKaLp/r5Z/I5pVoyiLv4fHRbubi
	mPohswVLdaKpxWQfu5Kwmi9loZOc0h4faQ1kUqvsigk/a0TB8bE0qJ+fBlBe8/LU5fxRKkx9l6F
	maWOVyWhRiIGmUOF2LSlDnrus6aXGWvIZRyWYlJ5bxT7p0z10B642pnD+Pvw==
X-Received: by 2002:a17:902:fd8d:b0:2e8:7686:4d46 with SMTP id d9443c01a7336-2eb364552bemr27295795ad.34.1793368843566;
        Fri, 30 Oct 2026 07:00:43 -0700 (PDT)
X-Received: by 2002:a17:902:fd8d:b0:2e8:7686:4d46 with SMTP id
 d9443c01a7336-2eb364552bemr27295385ad.34.1793368843102; Fri, 30 Oct 2026
 07:00:43 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027144002.10606-1-ansuelsmth@gmail.com> <20261027144002.10606-2-ansuelsmth@gmail.com>
In-Reply-To: <20261027144002.10606-2-ansuelsmth@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 15:00:30 +0100
X-Gm-Features: AclHuK85D2yzjqjadIBbGwA5No_thmVDaWhvxFw1u5vv5w3KPYrH4xdvCoOE_dE
Message-ID: <CAPx+jO844b4kY9vbJPJj+N5H9cRJ4TzT52=1yU-Pi_oxqysd8A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: mtk-sd: Add Airoha AN7581 MMC compatible
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX/BGJNvsN90Wt
 KecnYHKmDCxRzpCSA2LSsFSV+XTQT7r+hR2U5QkfBIXEfpgVxRL5nRfutVbHe8K5rUkUaUSEq/t
 8NA9zDCHUgfOtf2MOgELXtUL8Q1tCirhV8A9+dw3CC+w9yPZBOscuupcaQ5qhG+mLAgU+GCBeSr
 aPrdmy73wLhscI8UgeHNLxsyFBOmgByO0QRypD+vkCR3Y87hLmvYIa50CgGtB//ebCGFEHt16ki
 Z4UWZZN/jDJXyXCmyraejAwhG3CJNPoFAMcGqlA//AOV0r4vA6us98iXWgwoiLvFSn1KjnEyETC
 gq/CbD26JvqUGE3aI8nfh4uVB12WaIPHIo2ClYTJ0mdd+wjzgZhNLWU9kPLoCGxqagPkEudyMbL
 5LVzaEhZ4sPZBDSJiCzFEdz/izOq8PllbqgOaTHR5+HxLlhF6sUPVubq18GlG09TEAVC0pYoYt0
 cupD5woJaiYHlgC/+2g==
X-Proofpoint-ORIG-GUID: 4zQ-vBrmo68qCeE-2dMmPROXCBxiAEkU
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae4a30c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8 a=5vCY4yJ5Sko5zDJxFQEA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfXwQ86Aofa2OXP
 XM70oIu6Z6sMnwxD8hItoPLS7bF+owCV8bTQi3uKD2p8QmT0WRipgFdzVlhZTMBSeJFMv8DYlao
 aimDUzQLSq4V+DUFqKT2jC/znInHLWA=
X-Proofpoint-GUID: 4zQ-vBrmo68qCeE-2dMmPROXCBxiAEkU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300054

On Tue, Oct 27, 2026 at 3:40=E2=80=AFPM Christian Marangi <ansuelsmth@gmail=
.com> wrote:
>
> Add dedicated compatible for Airoha AN7581 SoC that implement a dedicated
> MMC controller based on MT7988 with the difference of having a single clo=
ck
> controlling it.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 5b160fdad3f0..736cff2783e2 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -713,6 +713,7 @@ static const struct mtk_mmc_compatible mt8196_compat =
=3D {
>  };
>
>  static const struct of_device_id msdc_of_ids[] =3D {
> +       { .compatible =3D "airoha,an7581-mmc", .data =3D &mt7986_compat},
>         { .compatible =3D "mediatek,mt2701-mmc", .data =3D &mt2701_compat=
},
>         { .compatible =3D "mediatek,mt2712-mmc", .data =3D &mt2712_compat=
},
>         { .compatible =3D "mediatek,mt6779-mmc", .data =3D &mt6779_compat=
},
> --
> 2.55.0
>
