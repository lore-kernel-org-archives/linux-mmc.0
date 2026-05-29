Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4877C423A87
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065933; cv=pass; b=dzff9VVJ61FS4KeTrGegQq8iSFkdwG4wOEQIUj00B+77RRgqD/eEVlowzx+6ml8XtJtzRv6vgoxAe2VftMU9YoR4AYcBi0EdZUzBFCQt48WISpvAIrcN5Th6KTr37Zd9rDLO1HxhRBwxhW3xszVHYGHHyo1gs2C+7m+tnnvcqx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065933; c=relaxed/simple;
	bh=ltU+8vGr8m265DEoH8729VMIv167yBwTAnhDKfwO+Rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVPH5gGhZ2QtiTsbtum+fE4Vp2f8dGj+ABvDwlhz3XdaZAy8ID/aeVHIbbMm2yLUl1ZegtWlPoouWcd817HWIhaT/TMWye+MeCcOwu7TJ/PP0FHsGneCFirCTQBTfTHt8Xuqb8kJKgyDOB8/Diz3zsbYKV1QABNKpwRribytorc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ETInR+js; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H6yFKBq3; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ETInR+js";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H6yFKBq3"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDaOwf1279325
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NYoES5F2iAtnc/X2JHN78tmhMrFrXoTmv9nva7e1GQM=; b=ETInR+jsW4mxSZOc
	cTLJc4HTePfLyn0T2m/zeUvv3kgJXfgO33VB6b452LqaI8l3WG9fwq2jJ7gPuJfh
	LRPDKA1aoY+2Lnt6Da2J2BuFGGRZOJq7OTc0EGYp1khz1rGupEUlOHviqSv7P21G
	Ise8yTH+tNQPvBXhBUP8jcZjBE7vhV9ICETPWDNJnhBiEYzTAm/vuTuf8yblFmuk
	/nIwgwK0ldoQMPk71ymLD81rjMvAANVRAXLbaobVBfgJq+6Vto8yCLVjOkQ9uCEg
	vBkIFcM+bdON5ue3KcSOZ+f17j261yfHKtrmeKaKWbUFmPAAyCCm/50EJ3UyfA3g
	MzHv1A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efbu50a2c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:31 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8cce230de8bso25669936d6.3
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 07:45:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780065931; cv=none;
        d=google.com; s=arc-20240605;
        b=f3UqaLJPveLVc/HLZc7mKcGt8+9ZQAADpHXibgmLOrbtcx6YIImIXZP8zwQt9rYasU
         Y3uhCxyGYSuzs6BxiM/a4LzSPWmMM0zlCjJpONB7nHhx7nen1GaAHjNIqLyqneqFBV4f
         dANZbqk7oOrn6S6MiAl7YZ0mBf/TcfsZf89QPoCB4gaNnHwk6L7wvCWfTMMKFNroN+zs
         VPQuwGgyMn+dAz4j2r+t7eQVnkOum9snO712i9jL4mRK57gfja6qH664LjOGAt7EICYy
         BzzYHPX3Pow5g8x63HNzm9J+DVB940mrtyJOVJTgONH9JhfTtuy2ih4jsNQdHw2yKiSC
         cBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NYoES5F2iAtnc/X2JHN78tmhMrFrXoTmv9nva7e1GQM=;
        fh=w4oQVwe8XKmvgdBS7S5p3ldCjK/cgb5luv8kA/lM9FM=;
        b=F9VByFI3yvb0GYudrZj0ukCKdgMfuSgVn4BSksocuQKt8lNip7GepqyuwIC8TL1/T2
         LFwokvYKF33WgPriNqjrEHX1DFm7WvBkHwjUaY2EgfcoUUeYzn5W0SZf0LpubKqfwDlb
         5WTVL14KDQmI4KymdjVQV6IZYk4aXLVT/RvYv+eJ60G7eTDqMwsZJ8CX+FuMWj3Wi7sW
         e83TZ6KuqVBArbKEvGCK9caUEosN7V2Dg4rM02tnB/fBsuZwZ0x0hI1pPsv1FmuyTLqW
         JXl+PBSV/+ZW4l+7KNpAmeklLo76SGgKGU6HnOrFB0hp2K/lHqAf8xm1ndr74gldSESB
         yp1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065931; x=1780670731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYoES5F2iAtnc/X2JHN78tmhMrFrXoTmv9nva7e1GQM=;
        b=H6yFKBq3rHsHrHh5ODkyj+Le1iRPSQI1a5MhogFkPvzoxw4n6R7bFzyMEE8YFdmKWl
         j88zk4+jZPF/JPOg3uy6c+5bkPQbXflMObzMFUoVrumsWl6/84Lmj+8pnP4RUxOkz1fO
         VXmUHKetejBLYfV5WsfowaUdmi99SEQVDZI5arZCvEeaTxR1CZqpL/9NsD+21KbaAfxZ
         nLrf2xLC7Yd84San0Y2eQsbdKAfJs27NJPP4a22iU+T3hVHKAWvxM3jO6mi3Ep6PLyYd
         Xtcz2Itde4lTbi6SmMQoWOxprYLohCEkMZMq1/aPT+5uuyDb1FJwrQyoVOtj8DQTXY89
         gMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065931; x=1780670731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NYoES5F2iAtnc/X2JHN78tmhMrFrXoTmv9nva7e1GQM=;
        b=shnbdGB4nl2GfKV3e0HqJrpeYLfRKkEQ3DzQAOKJMedTPpuRl3xsidSM65w999QvXv
         0Z16zx7GLpm1yM0Fwt4WrchzYrpvLdKcozqtEP2SkUdCtzNZF+ZbWwQXaN26XplP8PGC
         YxtOS3jrnsjOfb9bXrVqAa3y6hOIVP12jL6mF4wKGkr17eU9Grf+Fh5E0+/X6c6/Qvmi
         tdWI+ekWmbYhmZN57WL+jwXy5XQ/sfI23H17Uq/tvmYQhf4pXHzQuIZKbc015jvcXaKg
         BoH2YOcxbJyTJ+d9Mn/4AFVJXBJWBgDCd6oqYEGps9WF/MuU0algGe0qiTPbzyfGram4
         Wzuw==
X-Forwarded-Encrypted: i=1; AFNElJ9W1Zjs05DWvvCuPaf4ePSUolL7yqkKl8TA7kgx/XpIg2TW8kyddlI8fmMD2g7w66gDoKSGUM8Jkaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZCoj23FW05ZfV5EBDG4J3BqKI29YH/aVib0DlULX+eqX4U9C
	78kuePUcq7hPJmAEb0SsCCkpb9rDt7dHPlVsFmk8nlReHeX3S+p2MpUhVwBO/jvE7jLCYOOsRrw
	APYPbZ5jRbyZeL7yf0YXpepcGbxQhgpl+0WyG/IoAMheE6Z0bBlgTawdevoqscJSQiFV4FrRsjW
	+IGfTiH91bu2upgTlwPczo7KVZ38hduSW7Tu0URA==
X-Gm-Gg: Acq92OEUnAebRJ6NTEaRG8s2mgBMgIxQCbNtOqPLQxnbqsuDO/uOYnaT1k8/uQMQBIp
	qgKTYTdKUKSFEUqnbYnftkuNE3RoaNKoNFe8S/0wpc0l1ChuQtyx3HKLooVwO3q8972sxyU9WYU
	YfpC420IsfmLLnDz9zh9yxfEglhNc0AbOnu87m4pOfZP6d6R2q4QfAg0k7WWNHmh1BDsRUmaoCO
	QSTd0NjQhDSQNVI/A==
X-Received: by 2002:a05:6214:2f0f:b0:8cc:ee2e:8d99 with SMTP id 6a1803df08f44-8ccee2e8e51mr16255066d6.21.1780065930170;
        Fri, 29 May 2026 07:45:30 -0700 (PDT)
X-Received: by 2002:a05:6214:2f0f:b0:8cc:ee2e:8d99 with SMTP id
 6a1803df08f44-8ccee2e8e51mr16254266d6.21.1780065929588; Fri, 29 May 2026
 07:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519135342.623943-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260519135342.623943-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260519135342.623943-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:45:18 +0200
X-Gm-Features: AVHnY4IKn338BxMmC7x2RiD8DMfbYOWOavzi_H6yjKizETojXOwI9mPNIlQESac
Message-ID: <CAPx+jO9etdG+BOs5DwJh=EucPe_v=WLnsA4RO883+5NRNA0=QA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: renesas_sdhi: Add OF entry for RZ/G2H SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulfh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=SMRykuvH c=1 sm=1 tr=0 ts=6a19a68b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8 a=yC-0_ovQAAAA:8 a=VwQbUJbxAAAA:8
 a=U03jwDn8jV92IJQaczoA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: CvH-Fga4Bvk1t1TD_GeH8qn1ogbZlr9h
X-Proofpoint-ORIG-GUID: CvH-Fga4Bvk1t1TD_GeH8qn1ogbZlr9h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NyBTYWx0ZWRfX3ZmfRZwtcfJq
 ZJywjDxKQ3t/OHcx4vDpq8SyGN/EfsgeaelcRWvRkUprQQoTRU5pgVOD6Fue8+DuCC5i3qN9hal
 T52ix/MV+KQ7byYWVYn5HkILE9tLLfoVzHiZ1chVw8xIP6blCzAuHc6IfK95VQ858eo92VkgNtQ
 S/ryPx//CPv2bOz4p0Zcq+YAXio60NqwamlTitfj76px12LrOG3A9SiQDCArei3qNoyJWpFsSBm
 HK/4pndy4O7zm8b9BBcCPJ+DB0iCK2q2Ki6WjxHZizo6RB+xA757JvWDwVvFiQQn2FViW3jbNo3
 YNVNo/rOldLSlIITqletcXQyJZWCGnuwOexNRV6m3BGK5dC6vrtjKdCZAlmq/d++b/kHmdlZZrf
 PWxkzVbwpzg0WXOwrpws9WiRbpc8FA4UfQzqIBkwt+rH1vwey4OP0+HcTU7STzzmEj7vl66H4ef
 84dc6fcbdC/HAei0NfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290147

On Tue, May 19, 2026 at 3:53=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The RZ/G2H (R8A774E1) SoC was previously handled via the generic
> "renesas,rcar-gen3-sdhi" fallback compatible string. However, because
> the SDHI IP on RZ/G2H is identical with the R-Car H3-N (R8A77951), it
> requires the specific quirks and configuration defined in
> `of_r8a7795_compatible` rather than the generic Gen3 data.
>
> Add the explicit "renesas,sdhi-r8a774e1" match entry to map it correctly.
> Note that the DT binding file renesas,sdhi.yaml does not need an update
> as the entry for this SoC is already present.
>
> Fixes: 31941342888d ("arm64: dts: renesas: r8a774e1: Add SDHI nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Applied for fixes, thanks!

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
> index b716a518f265..1d3cd4c3da1f 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -279,6 +279,7 @@ static const struct renesas_sdhi_of_data_with_quirks =
of_rza2_compatible =3D {
>  static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] =
=3D {
>         { .compatible =3D "renesas,sdhi-r7s9210", .data =3D &of_rza2_comp=
atible, },
>         { .compatible =3D "renesas,sdhi-mmc-r8a77470", .data =3D &of_rcar=
_gen3_compatible, },
> +       { .compatible =3D "renesas,sdhi-r8a774e1", .data =3D &of_r8a7795_=
compatible, },
>         { .compatible =3D "renesas,sdhi-r8a7795", .data =3D &of_r8a7795_c=
ompatible, },
>         { .compatible =3D "renesas,sdhi-r8a77961", .data =3D &of_r8a77961=
_compatible, },
>         { .compatible =3D "renesas,sdhi-r8a77965", .data =3D &of_r8a77965=
_compatible, },
> --
> 2.54.0
