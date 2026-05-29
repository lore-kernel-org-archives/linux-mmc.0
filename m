Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F9428474
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065945; cv=pass; b=hsuRyDLeCvN1DwKMRK3ccC91Yrg+9gMXatmoHgPgYW9UqW9U7M6zlEohl+ZsYtZrQT6JUGwh2BTus3W9ZYnjjeQDzy0nqjkbJkqt3JOD+NPws/Q3uu+YDg6g8YMSHxhW0YlfIs9mBlsw2ZLc0hpF+HG3pci2WsJQtwYAGgOTP3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065945; c=relaxed/simple;
	bh=0FD/R2Chz+z68uSQyc5WvBMmasJv65bu8zjMzIs43cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNUPDMm0j+Fas8C25gpilMPHUDPhQvLGNFQjAmEa/qqid/poLcLOmuf3rQe5a4ajoPm0SPK8KI7VVGpJYGiNHNmZQ94Ryh+abVLZJz7DgtYEDYd1HcaWrg6SKXQzRVmrt7b1TOVwVBVo5YjBSOD5bHeA37JtXzfM2f2SlfGT0ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Egg8Llf1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jUst1JFY; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Egg8Llf1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jUst1JFY"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDKpSu1202095
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Akk87kD5Ki32/Cn7Hfo1mVbYq6dfblJ+R9v4BDvDzc=; b=Egg8Llf1y5qRXnRU
	7Omqk9s1kBWOhbsepAzgj6URAoKcFIheKM4fmSoUr/E7ZXJcd4CRD8WKKv77FwVU
	sI+P8565gIWgDtmzGoyJkHpyoYoUJtcma2ZSOJqCdkUnrafOfczr/Ke3YqfszNjq
	oMPabwZH5/LYXV6z4/E1dt1Oi8AsnH8/xt/2Br11tmI7rq8PevFx/AwpVzokDuXN
	T0ExWIlAQu5XlWPps3uo43xGEZNu5SdhCbOe8D6vwWVFne5LuCwYfkDH2F/TlcaF
	se6lc0Xao/IA2/srmBVFKwhnZ3J5KQpcYPv3b6lO8o1+qECLM+4oCPSdC8Bl4/oB
	YA6Mww==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef3te2ej4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:43 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6751db2792dso3130283137.3
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 07:45:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780065942; cv=none;
        d=google.com; s=arc-20240605;
        b=h+ueiWhZrQLPSPg7GAhJsKOS8D/HFFFVXILQ/ANYahUv3YKtFw7kZqbKFn+thIFMMX
         2enuP9oFYYX0CdFHx99laMZsdvG7smZODlOHqz6PVMb5+MLZgLQvEM6/2/V1eIibEJgQ
         Kd7dvT5zex+BrDWf+ppYbQ31LHrXZm0k702QLA/B44kWN8U8Ms1VDyHoaHO3gqSTmKsS
         AANFv/C4yvul+e8JqeOGvzbN/fiVvZeHQP2DWaG2q0kKNs8q77oLf2f7D59f77hB7H45
         Ls2+bOo12xlA2fTogVOzXppvJt5Mo0k459kKpMOom75J3iI378VQqSDUEZQLQTEzQ6Nw
         gBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Akk87kD5Ki32/Cn7Hfo1mVbYq6dfblJ+R9v4BDvDzc=;
        fh=MzxLt6Xy031TaZ8/7bgM6Fga75fyN0L4R6A0S+truWQ=;
        b=UhdwjlgRKGhBqhLpzLTYINvN+fSBf1rjRaphRWHbDmUlvE99/M6ALcjxHDCPnAbUaI
         Y8CMKehMTKpFWSl+tx7AFGOcVCac3JA26AevYk8svhGWKdx1nB7NEqM+ze67nqkH0l/2
         8Tni2KNB35JDBPakGUaNInmv+yU1EZ/X2kqNyITGFrX+XaQNYV42fGMeUbK+FjJN6LBN
         j/+xIU9DV6HFsRTTT9sSJFS8Cyztx0rywzodNtQitT+xEtv/53j25mrf5FZwQSqIWdwe
         d5A4TS7u8WdojqbSjSOXWr7zn+K/pHvTiXhO4NvTp2NmzxiacC1aeucX5CC9+75oFnry
         pcfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065942; x=1780670742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Akk87kD5Ki32/Cn7Hfo1mVbYq6dfblJ+R9v4BDvDzc=;
        b=jUst1JFYSi7qpOk2RIKNVowBz02Z7BS3gJnk2WkZMRIfGffL9v3GvH5GQLl83lewZe
         17d+0wsliGMsj5oFauxtO3uOKxC+j/minYfHXDPsOYFL25XkR3B3U95Acdg/eQE7lR/y
         w5BatFLMMYJpws/TrYVULtTkbAi7xenWKy560JzPTm2rAHDR+YSzOJVs4dG+vYvRoAXg
         IjNuY7hqRMYKnMX20dCd+yMkN1wQ0IEJ3Un1B0VGWhZbubmm7Tl/udmPW7dMNml0mz+R
         YNbSoavL3C7kJ63HF6FO0Bv2U7upfCOuClCHZ+8/XWZQHcbaaMGQwNSP+wdlxpqJSIwD
         /5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065942; x=1780670742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Akk87kD5Ki32/Cn7Hfo1mVbYq6dfblJ+R9v4BDvDzc=;
        b=rY2bNT+K+GXDRlaRwyXVvjmynLVQewO/wl/gcvNZD48mIKc7zrPXnaMgMeOdx3gUmh
         K+wn94hNz/EWmwvj8Pnoa9E7CxEqaWs6qghf5mXaYgf8NDWujs0fx7Vu24w0LkellPkg
         CtTNZBthzHEgyy0Udm44ZWsNhnpW1VdT7QNTRmKLkr3fmdpXnCjP8lK2kb5SZwWjyKZ9
         52klWM3EndVILrSSHmKbV4uzl5fMOW92eUnQxe002Sl4F5dfVY81hjlXgtcWYZ28ICms
         xxLXB7wByf6i/NcUelDeNekMegKPgxiNYvPV0p0I0aqRart2FRGGYzQYnYuQJlsZh4qw
         pgAA==
X-Forwarded-Encrypted: i=1; AFNElJ+P5UHSzQmD3lUEvLuwKw0Y0VHs41/1eh/yI6MEFUo2iix/UIbJUD87QOnaTBFsrz3jXmdQ7qP2Wns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ZKHjlwWn5dMZ7pJSbbHDSTnK6yUmLxw2ayHK9kJfVU96b3V+
	7vhasMpuLcA6ARnxkD4wteMZfQAtLoeSz0VV0QFyXBbBVk8hxAyCToW9myWWXHvxzrgO/ZcCB8/
	pvcoufjLFm79jt4c/XDrNdI51aKzbb2UgIBsQkEzKAxeYmpu263YoGqsF8tjmpGFGIGsQZ3gq38
	rYIgvt7LkhwSgnTt1y8A74OfiMp03zEgVs6HYGmg==
X-Gm-Gg: Acq92OE9ljenL6ZWjhr1x4HSxUuqLnTRWT2rYXLi5UtkqSIiGrlmCuf/moPX0QHxL5f
	MxPAjEF8SMGUoA7P3XAlTaNHWIE7IuXccowzj/NT4UDewynLNJBfVMJY+6TSd6Bkg0pV27WupTH
	R8PDRUG4SHTKIB4NJhtvmf4EJwJ5EpdohUIXxsNg3B+zInYGePed/S9NGFqfxEnijVIFFiYGVyD
	wqii6BVnYF59L7DQQ==
X-Received: by 2002:a05:6102:4b12:b0:611:17bb:934a with SMTP id ada2fe7eead31-6bf40c9724emr1494914137.28.1780065937397;
        Fri, 29 May 2026 07:45:37 -0700 (PDT)
X-Received: by 2002:a05:6102:4b12:b0:611:17bb:934a with SMTP id
 ada2fe7eead31-6bf40c9724emr1494870137.28.1780065936923; Fri, 29 May 2026
 07:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519135342.623943-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260519135342.623943-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260519135342.623943-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:45:25 +0200
X-Gm-Features: AVHnY4IOexYJPhP7I7EbcllbxuZNdWsh4dBC9xk787NW3-6TH27ihnJ6nKWCL8I
Message-ID: <CAPx+jO9H51KZhCkVEeSht3KLNO0La+Zr1Q_+QrDb_zNBxBQUmw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: renesas_sdhi: Add OF entry for RZ/G2E SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulfh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Z5EmVRwZlgYDftsk36UP5ynjBaeEvERe
X-Proofpoint-GUID: Z5EmVRwZlgYDftsk36UP5ynjBaeEvERe
X-Authority-Analysis: v=2.4 cv=daSwG3Xe c=1 sm=1 tr=0 ts=6a19a697 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8 a=yC-0_ovQAAAA:8
 a=IpsbscEN6Rrp8biRM4cA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NyBTYWx0ZWRfX1AFrFPO8++fd
 Nj4HFpQucVbiqVUIsJCXrrwbZ8D2WCgh1+bu5OW1wU2lERNGfnDYPS/ni3pMD2J+tijcLKmYS5u
 IXxXZ52d1GzYLUKVXkqzNPUhDPjmkIpCBY8M12btcaTYjMBHR6juJrBk3FYvKm7Ym86eUiXYUu6
 CBrxN699AHLHmjrntthvZA/ne4WhvoYboW4nHS3q0uXpK194LKafk143ntOuh9PnpXvOSpsg2KK
 zjZ+/5TY+DTRLkJ9IRSu9aXBXGVGFzUGhVhnHoh8354Sag0YiUxjU/okMoaPiIOuOMuWj0gy04G
 lLaxbkDemnGJMKc1lCiwZGVNb4XcCwi/KY7xuPVWUGn+vgXdAHq+OumkC2AA+VarmsaCVPPYVen
 soJZE+RjlUiIYzcb7KMOpELtqqCvpyFHWoVx6wRSAcDefoTTIssCRZwoLhgVLlCqs2atdKD/107
 dUPesSkWJY10RP80ikg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290147

On Tue, May 19, 2026 at 3:53=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The RZ/G2E (R8A774C0) SoC was previously handled via the generic
> "renesas,rcar-gen3-sdhi" fallback compatible string. However, because
> the SDHI IP on RZ/G2E is identical with the R-Car E3 (R8A77990), it
> requires the specific quirks and configuration defined in
> `of_r8a77990_compatible` rather than the generic Gen3 data.
>
> Add the explicit "renesas,sdhi-r8a774c0" match entry to map it correctly.
> Note that the DT binding file renesas,sdhi.yaml does not need an update
> as the entry for this SoC is already present.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v1->v2:
> - Dropped adding entry in the quirk list instead added entry
>   in the OF match table to map the SoCs to the existing quirks.
> - Updated commit messages to reflect the above change.
> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/=
host/renesas_sdhi_internal_dmac.c
> index 93470aea21df..024edc4e5fe6 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -280,6 +280,7 @@ static const struct of_device_id renesas_sdhi_interna=
l_dmac_of_match[] =3D {
>         { .compatible =3D "renesas,sdhi-r7s9210", .data =3D &of_rza2_comp=
atible, },
>         { .compatible =3D "renesas,sdhi-mmc-r8a77470", .data =3D &of_rcar=
_gen3_compatible, },
>         { .compatible =3D "renesas,sdhi-r8a774b1", .data =3D &of_r8a77965=
_compatible, },
> +       { .compatible =3D "renesas,sdhi-r8a774c0", .data =3D &of_r8a77990=
_compatible, },
>         { .compatible =3D "renesas,sdhi-r8a774e1", .data =3D &of_r8a7795_=
compatible, },
>         { .compatible =3D "renesas,sdhi-r8a7795", .data =3D &of_r8a7795_c=
ompatible, },
>         { .compatible =3D "renesas,sdhi-r8a77961", .data =3D &of_r8a77961=
_compatible, },
> --
> 2.54.0
