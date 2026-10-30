Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793366333;
	b=dlwD/sHBl78psBztmHL9l4TkSUUwapiI29BcsBVsxjUnd1Wi4tu1VPb8hjS6yUW2c9HA
	 urq/qXsQQxV4Jq4wU9KGWBW5CJYFuQ04NFBk0FDQeVakHQwoTJ8ZjppqGcbUoT9OItba8
	 j+a6BBn3x8Pb5ApxTsR/dzizi7im4+v9UmM3YOpjtkRfU4ex1yVWcJVe6v694sQ2eBxEt
	 bMR51CxiaPEiPSOW+/n4p7hsv42O+C26s01zGdcwJsZkamgk9JuHNpkQ+sZZcijNmz/DW
	 zp93ptIS6VazbhghqvT+CxVYNtCXFWc1+sAW35KvjBhD+2TiATCtqyGN8AQ4DzWdGNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793366333;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=I9F4PgUiWvCLXxBWaz2QhvThbcivC5DZGj5f2Lhfiqs=;
	b=jR/FltCz44Oyu79NdSWz8S7ggavNYYo/SSFuAU5UfP4SNXfIZDCdk5wwV1Ya2lOeZfQ4
	 rOXDH7DD1Oignu2uMzN+6USBBg4VS3M2DKDwWXUs3+4UuWrlXLEn7BqmSsi3YS+56lKmj
	 STVH2fV6Xg2nnvSxcLF2BQHj1Hiw2oX7vMz1XA6HVCQY2FtWsJWJbJSq51O4pTVFPpJno
	 8dOItARk/op7vyoe3W4l1pR5eFO3HCE6up/umgaHJ41+0fqe8thv8+efefzqri2s/KBci
	 8z5mI8aYDecoJIy5E6niwyZ9TrdE9Z/daWQD9WoijfFrxZG7/HHHM5ZxcJumG4Oulqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Fsov0qdt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=icmZr5TL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC63606A31A
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 13:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAC63606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Fsov0qdt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=icmZr5TL
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBG1BH2071543
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 13:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I9F4PgUiWvCLXxBWaz2QhvThbcivC5DZGj5f2Lhfiqs=; b=Fsov0qdtrSbyOPTD
	tpWGXP5VIT1bofJ2qk0j9PjVA8jdUe16N1U9H2z4OC4e6mNaNeV4vOz6YzlbzGm6
	zav1mFXL1/ADn6bb4+H5x8PHU9jNI/2O5KxgyIdQt6sC3Ni7nBcvH5usGNJwYQRz
	mdjAg02OYD/stqKRTzrQNk7KlTlGTwzDMxj8v3GUE2Wtn5EmzaU4aHWqjj9MB8cj
	oI6NKu6L2g4GslhVzfhsC+i3H4SKmseo+95JHV7/Pooe3CDYjWB5NOgyeZBg/Pyk
	eH8jyrbN+Nk4EjoMMHkuyFoSIR1XDf2SCcCY5cBSgh34KKBP//LhwEESpsLh7yWE
	COnrpA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p37r9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 13:18:51 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd6532dbd7bso488794a12.2
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 06:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793366330; cv=none;
        d=google.com; s=arc-20260327;
        b=jw4UJZ0h0R3mCW0uCLIxB9WRdtjuVsUuKJRbazPaxAOCu6NvXWX6R55kkUYYaboW3l
         gNLqSEUGtv27G4WzALq8ftBLBcOGVEfou3Mvf3WxmENFQ8m9U83/wBIn2Vxg2kfzCVCY
         lZggGGhwOE5X7q+RpCBrpH/6rjP5CrBeMGBOYRf6lIzUc6nKwyGNkbPakMxL3cUcKdiX
         Aum+PDV2SNooTtxsHtbj66Z6lefprmQXtscytEXgzv/BS3CDtAlTLSj2z20NcG8Vf9+s
         QyBPEN73x9BFVGDiKc4a2Bvq2xN1qTdqY92Tt+rf5dpGBPQjV5r17v5o/Fw1UkX8GSkU
         XCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I9F4PgUiWvCLXxBWaz2QhvThbcivC5DZGj5f2Lhfiqs=;
        fh=akB3+B1QnD8HE1rHFCDWcGJxmrKW8UZaaIh1zM8E+q8=;
        b=FUQwCn0Hd1Lo4856LA3hjI7TrkhiVjHcmY23VpVMB+hAyR90MLFNBQN5iyhtLbewu2
         5UkmLyhhc9Vk66aje8jVBICHCTKV26TtQ14RFGDE1aBIu3F9GJrihpUiOvnVpVECQZ1h
         zeZtB5hWOqcCBcnED/4ULzfWbke26bGjY7ohL0epyqAFKrJqgpO5aWbjQoYgwo9mv8yu
         WNJjK4GN1BN0TqO2pN1HRV83b6zejU1on80Gu2MemCnYWANFnHo+uwL4NFEqLOIzrz1g
         nbPsSNlmRpQSibxTJHcce1H3YLwXoPuZacv+EmqK0rcDurd50MDnVJVY4TnREcZWwaFY
         d+ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793366330; x=1793971130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I9F4PgUiWvCLXxBWaz2QhvThbcivC5DZGj5f2Lhfiqs=;
        b=icmZr5TLIvPRirhc9OwDuWWXpH4YWnyBp7bSUqWq3DQcOgsvwleExBfT8Ah1afBwgH
         qClqeeBpXjz7tJTG61zxtWAz+7HeNgwcQ1j7VNuxVlyjcb5Zm02KhpBt8+uzsULKkggk
         dg4sahz6yU+N9aMsGXg52tvISL9oLgQOmM7JxqJTfWGbv+NcrxNYq8VnGLpTTWPPKsra
         mxjvM9Gwya/xoVgQ8dS4CbVDq657d5SpE4OjxrT5TPJDIlZOi0i6Jz51aKjVJzSbKzap
         C6Y96xfeDzIA8lB7OSFiVvLpehVStrtTDR4KCs4TBHZwrhmY+hh7S+K1uuishA5M6pPi
         2lFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793366330; x=1793971130;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I9F4PgUiWvCLXxBWaz2QhvThbcivC5DZGj5f2Lhfiqs=;
        b=G2c4Ifn+c9dwBC/mxUDeod/c/VN+y6sxcOejbmXbrClR2OVm/xF60/969ma8qT8lch
         +urJgx2Swr/cvabhYMPU3GaZCK8+fG1hyCb+3nA0f19bPspwZAWNyXD4FDwfm8Xry0hr
         FUjCaYqipukSbBhasJoTIBHYXN1pAPkmMVoHWua73lhzUB/uDytw1vqrbl/rhE4vwQXO
         /iKznTge9uzSeMQuO+U6zgKcgzNFLc79nvcHoRX/FCHKAN6aQDlxFXUYw4qqX34qareJ
         dQ2rzL1vRsbyp6hY6yjlttSSmDwTqIWzcC3hPZO6YxWEp18XPobJqHXi2tWkWuD09/N/
         va+A==
X-Forwarded-Encrypted: i=1; AKwUvBzRRGedHeQDq8mjzvSYoukpCJ9Qqyc0tTFFaZjSCqotu3DDj1VW028w4LJG6LezBIGUQwirosKHAZk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZfR/BiwN7T5uqBll+aSOF2T4qbp6rCB5yaGd6BcEYDvU24NWp
	nQDozIvueYfNlKgPbmA20+T4+zP+n5wAbNJmBZmnQs1WPC3R+js5BMscCPXSzFfrW5EOPRc36LX
	V0LOYl2/cAEwjhtm8hWy+4OCwRlGyZ5pmiQjvOc6G2Znd1XbbGb7aUaGIE2uzeNNAUApG0KQZh4
	Gm/QAco8DkJu7UEu/TboonXCipBBBUGhl+0gpRCg==
X-Gm-Gg: AYBFou1cKo5AhaIMEgdCusP9LbM+0+2mgEerFSSKgpaKEv9jdcL+jQfVLKEWcymJJ83
	X2CQCBgq93i81RVshMg/vOqXQnJj/f4AMVlhYvphltyTtcuDRqKgpenJUwtR4Mx8cHwWE+SVSg1
	UBcW0Zgmk8xKjmXO3hPHEs95TfOa77fQdZaYlzRsx9qOb0I6p2K8pmSdov3Q==
X-Received: by 2002:a17:903:17c7:b0:2e5:54c6:e5c9 with SMTP id d9443c01a7336-2eb36402557mr24870335ad.2.1793366330249;
        Fri, 30 Oct 2026 06:18:50 -0700 (PDT)
X-Received: by 2002:a17:903:17c7:b0:2e5:54c6:e5c9 with SMTP id
 d9443c01a7336-2eb36402557mr24869445ad.2.1793366328408; Fri, 30 Oct 2026
 06:18:48 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027122417.954133-1-rojer@rojer.me> <20261027122417.954133-3-rojer@rojer.me>
In-Reply-To: <20261027122417.954133-3-rojer@rojer.me>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 14:18:36 +0100
X-Gm-Features: AclHuK8RBgkCr7jl4JBb6oTf6EbYW4CCDNkhsUxb25Kl-Zu1Zto_wQZjQNBeLLA
Message-ID: <CAPx+jO-EpqidMPXsC9RnEtBkSg26r7p+amyE_TC6kLmW3j7Ssg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: core: sdio: skip CMD11 if signalling is
 already 1.8V
To: Deomid rojer Ryabkov <rojer@rojer.me>
Cc: ulfh@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, llj@rock-chips.com,
        Jensen Huang <jensenhuang@friendlyarm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MiBTYWx0ZWRfX8s1UiULtxBEh
 QID0APCN9+4zQ+zdAv40cUcNoZ4kK3ijwllcbI4DMbMToc+4LCbXRcXMiqS3GhR2Px1ewjkGkwJ
 ljPaJ58JD9h8DfIfnePxYqAFTYZVPM4C0MVeeOQx0DdVNdYmPjmioXORwViXE6wJzOTbqdqB4b4
 qh+QF2RnwqxkunqajGByh9y2MtR6U49u5EtP7FJPD+6rLyGGQ1zSmSwgSYc1tdPJ4LN6K1C9jUs
 oiFXnhqnnTU+rVW/fBJTEvCrMtxH/CzqaXokM0HQpn4UQhs64sRfPrvySs7QU3u+VyObhg158Y1
 TgsWgIAIgEwsrkeZuRze8qGjGL/oWAd579gSkgt+vW0kHH0KfaYtRVqxSnjAebukVx8CJnbaNZj
 GophZu3xOGAFn7Md4yz+2Ms7v37FK+QDQS4Hmt5Blmqsx7kCaq+o1xzDI3M6uFyyYXqvgRbQzT3
 Flsg+nYGFjRn35uBF1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MiBTYWx0ZWRfX5eTudXbjhSUC
 ffRwr/ZwYj1cmnQYi/5spbptp4FTT5CuJDKAkl2Aug9QWWcmdok3WmGCZHaFVEPN12sNuUXI4gX
 RuISYc+E2uFk1Zo594fG9Wl1qkYUZlU=
X-Proofpoint-ORIG-GUID: y1Caf6jM7j8e1qvRK6qGHjWl0Yp4i1_e
X-Proofpoint-GUID: y1Caf6jM7j8e1qvRK6qGHjWl0Yp4i1_e
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4993b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=NEAV23lmAAAA:8 a=puenUtlPAAAA:8 a=s8YR1HE3AAAA:8
 a=5Nzor_QV3Lqk5mHo--IA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=Es8Hv8gd3kOWKGUR-0Xs:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300052

On Tue, Oct 27, 2026 at 1:24=E2=80=AFPM Deomid rojer Ryabkov <rojer@rojer.m=
e> wrote:
>
> Per the SDIO Simplified Specification Version 3.00, section 3.1.2, a card
> whose signalling is already at 1.8V must report S18A =3D 0 in the R4
> response, and the core relies on that: it only sends CMD11
> (SD_SWITCH_VOLTAGE) when S18A is set.
>
> Some cards don't follow this. The Realtek RTL8822CS (as fitted on the
> FriendlyElec NanoPi R2S Plus, where the M.2 SDIO bus is wired to a fixed
> 1.8V vqmmc) answers CMD5 with S18A =3D 1 even though the bus is already a=
t
> 1.8V. CMD11 then times out:
>
>   dwmmc_rockchip ff5f0000.mmc: Unexpected CMD11 timeout
>   mmc_host mmc2: Timeout sending command (cmd 0x10202000 arg 0x0 status 0=
x90202000)
>   mmc2: new high speed SDIO card at address 0001
>
> and the card ends up in 50 MHz high-speed mode instead of SDR104.
>
> The SWT6621S misreports S18A the same way; there, the failed switch
> leaves the card unable to initialise at all (error -110) instead of
> falling back to high speed.
>
> When vqmmc can't do 3.3V, mmc_set_initial_signal_voltage() has already
> fallen back to 1.8V by the time CMD5 is sent, so the host knows there is
> nothing to switch. Skip CMD11 in that case. ocr keeps R4_18V_PRESENT, so
> mmc_sdio_init_uhs_card() still runs and the card is tuned to SDR104:
>
>   dwmmc_rockchip ff5f0000.mmc: Successfully tuned phase to 64
>   mmc2: new ultra high speed SDR104 SDIO card at address 0001
>
> Hosts that start at 3.3V are not affected, nor are compliant cards that
> report S18A =3D 0 at 1.8V. A non-compliant card that does need CMD11
> before entering UHS at 1.8V would now fail UHS init; with the previous
> patch it falls back to high-speed mode and keeps working.
>
> This relies on the fixed 1.8V supply being described as vqmmc-supply.
> vqmmc is optional: without it, the host can't tell that the bus is
> hardwired to 1.8V. Setting 3.3V then "succeeds", the core believes the
> bus is at 3.3V and CMD11 is still sent, so the patch doesn't help. Such
> boards need to describe the supply (e.g. a fixed 1.8V regulator as
> vqmmc-supply) to benefit from it.
>
> FriendlyElec's BSP for this board works around this with a card
> quirk, MMC_QUIRK_BROKEN_ROCR_S18A[1], matched on the "realtek,rtl8822cs"
> compatible, which drops the switch request whenever this chip is
> present. The misreported S18A is the card's fault, but ignoring it is
> only correct when the bus is already at 1.8V: on a board with a
> switchable vqmmc the same chip would then be run in UHS at 3.3V. A card
> quirk would need knowledge of the board's supply that it doesn't have.
> The core does know the current signal voltage, so handle it there, which
> also takes care of any other card that turns out to behave the same way.
>
> [1] https://github.com/friendlyarm/kernel-rockchip/commit/aee62cf7ae16b5e=
de6c6d92a8ee20e796482754e
> Cc: Jensen Huang <jensenhuang@friendlyarm.com>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Tested-by: Longjian Lin <llj@rock-chips.com>
> Signed-off-by: Deomid rojer Ryabkov <rojer@rojer.me>

This looks good to me, but deferring to apply until we sorted out the
potential issue in patch1.

Kind regards
Uffe

> ---
>  drivers/mmc/core/sdio.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 6787fdf1c53..a986ee04ba2 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -737,9 +737,11 @@ static int mmc_sdio_init_card(struct mmc_host *host,=
 u32 ocr,
>          * 1.8v, the card sets S18A to 0 in the R4 response. So it will
>          * fails to check rocr & R4_18V_PRESENT,  but we still need to
>          * try to init uhs card. sdio_read_cccr will take over this task
> -        * to make sure which speed mode should work.
> +        * to make sure which speed mode should work. Some cards (RTL8822=
CS)
> +        * set S18A regardless, so don't send CMD11 if we are already at =
1.8V.
>          */
> -       if (rocr & ocr & R4_18V_PRESENT) {
> +       if ((rocr & ocr & R4_18V_PRESENT) &&
> +           host->ios.signal_voltage !=3D MMC_SIGNAL_VOLTAGE_180) {
>                 err =3D mmc_set_uhs_voltage(host, ocr_card);
>                 if (err =3D=3D -EAGAIN) {
>                         mmc_sdio_pre_init(host, ocr_card, card);
> --
> 2.53.0
>
