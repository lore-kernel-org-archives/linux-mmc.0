Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A83E51F4
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352811; cv=pass; b=Rkh7u/0Bon2e32QNciODTL8WLz7X+K7KN2NVBcazkRVE72HRFPELT6ag52MKJ1Y5CT9/isIXRG4FtaESapiYlPHIi3T97AU7hgALFZGQuqmlwVqXlN74dgU/gMy69UVvNwG1A6hQzuHOsa+G3a8kTk09swXK4PGCz48snUiZ2O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352811; c=relaxed/simple;
	bh=C8IdFc/4X3DqO7HLndy1L98z1LYEAYsYOr58QolE7+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COgyIFM6wFTzGEPzaecAn7xl0B59w4hiuuWkD/rN76lpHdfmQdslfoaJljaTjdRL1Yg3ZVCO9BA9ovj06flGAPYQDib1NGLHw8m2z8RVOsw6hnuCU+RSUlT6GgGDVnNEEdu9fc/3hT/H01/c/5HJ55nY/f6FzQe6Zi04ibih0j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AUfT1Q9D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RNSIW9tP; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AUfT1Q9D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RNSIW9tP"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF0G0825594
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1nurRSv1i/fYBqpNFPZgEICUS6n2YfHXSs/xkskZjgY=; b=AUfT1Q9D6h0FU61e
	qApfZRcP1afGbNRZY+3nhMV1tJFfeEucg8o4NrDL/r6nV3rmIA3Sq2ZvKZmxzxBo
	M+0FsYyzui5Oy2iZfEfUyuRluXEb7a8dZSkttbjhsmHR++n0+GbDkJUYw1blnCTy
	CKfT1FiZqRt3UwTMxApV0+IoHrZWgL6RJxTi8lTyQe9vTV2vqPKXCF3ONWxcu5RJ
	0H+jGwP/Gg3bWDwzC51OU2p4X9uNQNSRMcORUtqUs2THDe040J0ae50Hvd3rOnfn
	bQfsxUaXYEbBbI9Jqj1DPCACB28qzCM7zVMagv5+GmhfrzMrDKei37N6MbEtPtVR
	VfUidA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t89y04-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:46:47 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ee40bceb55so43565056d6.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:46:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352807; cv=none;
        d=google.com; s=arc-20260327;
        b=JE5OewVrfuGzUc7KFOEUviVDow9/2LCXcRGLMSejieQ7ZXZhzCipasRFhvxuzNkQrP
         H/PgS93zLPK7Ge21YdvOQXxlrB7YAiK8ADhBZzq5QSanf0GLPC3dlgt60g18bjTEnTy3
         ucphKE24Yh+hWYiEBDke0qY49rgs5OVHgvJNA9PtuRxcR2viKVC185ZWR0jGQGgfgse3
         P2aJXxZg0JeiYOCW+AAOhC/7lLZZa++JjLF45IetTjX5yCdEfpc6vJzrSImA9fhLweEd
         fyT2CDrGCRDBhy1C7QxSOS4Z/ac4/AVEt+5XKE+Be0o90bQs/XuZjQg9PiYoJj20Fig4
         ekQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1nurRSv1i/fYBqpNFPZgEICUS6n2YfHXSs/xkskZjgY=;
        fh=PhBmwWLhHOUJVQpoMw+iLnwRuzo3gOoOOz/5GndfGlA=;
        b=aaUjZ2sUzjvVsHKVnITkg1JNPXQn9fxkEkmB+De669dwHZekar/qZbUpNXly9IOUkz
         z/NqK1S+1QwyS937yWlvSRGWyHmzCDnGOfA4RSdDvoR2qCWAu73nYV0q0kSUrXJK6qaz
         FBTzlNBrBlujyoBpwUi3DNYK/cbZxwhNZlPKEmm3UnM5It6/u6/iZJ1ouYX9+MaYjDdo
         rRQ2AnpNkOyPsSaWFlRIK3RBoharXpNDQQEAU5Fbemsa4zPPQTzTVIoMSdIp1gE49SnP
         rznj2gg0uzorTYflgsI7nbqAFH/9Rf99ydPdze3wqYB/KQ80B641CdGX3lFptk20POWj
         ZiYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352807; x=1783957607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nurRSv1i/fYBqpNFPZgEICUS6n2YfHXSs/xkskZjgY=;
        b=RNSIW9tPRCJbiVam+c1jzVr6Ter4Qo+hAl13mzkEgUoqU6OeTeTXSTCWaEyIBMPpox
         jURCdnZtDi/VZIQ3/cDbsnA1OcihygxmkK1MkLx4yNGQ2DYI3w75wvKWZvb1kXESujMD
         zGT/+Gg2Yp52LDbGvduYVtl0lWI1dLBvY65ctAPMkp7JEPz6Bd57hoZ0xVuhb5w5iH8d
         9ol9T/MuOg+dl/XpmR4+GJkoQK85XHlbX5jEocM5UjBLj+d5X3w+Ed6QE/Cgw99HBJlQ
         jDsRZtyXdqVPwjb9CG/+1QilMGEOf+KlqBAlCup5oGVw237ewHFjTa3EhyV3n5zkNWrB
         yX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352807; x=1783957607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1nurRSv1i/fYBqpNFPZgEICUS6n2YfHXSs/xkskZjgY=;
        b=BNP/3+tO/aIeqHpgH+07XAngDvrJCwPZUQq22wayDJqf12zryLjLO33N8chOJq3Me9
         wn1sTe+fMVC8pzWSrws3ZY+JePLlHYCzda/Fq2UKZlZ4YJKkZSgI3K3i5sogNgTjugeG
         SBsli6TVK+ONZ4rKZnAr6rrtIlwgGacDcUg87l9/Z9zQhhtsu0VIueUF1z3wCvGkJPh4
         qnud9FEwoazVzEG6cTF4S+CL2KZJi/ZZ5+hudaCsdCzFyyS7ktr19SPTJ/iUdGcjh0ay
         yRZKK5R2yAByMKjxQ0Z8VDzrFfiUVQzam0UwQ/SgjUnMe1n/Dif0krT+Z9YFcf0vVTmN
         N+ww==
X-Forwarded-Encrypted: i=1; AHgh+Rq26JOz0cRz2bOm/OLayfpGxEhcej+nM6x1/IiUjjpwaWQ5yo2lTTefgEh+bOPsf7uD2pOvUXc3hlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9am1rt4xzHTNZiBYC7DmXYJ3AhmDR579xeVEU2nu/cw4EAG3p
	TKSr0yjoiWKxIrrs14YzCwcM3pPY+8R9ulsfU639CLL0K7svuTq/jebZttWWfMazJtsPo+yDq7+
	ozu7wBGGArA7+U+FDA+9THnsZuWt7kH93fQP1r7MDVRxIzf1jypv8ZRJ5AZ86AR93gskeU5XsCk
	OyjUTnyOMzU6DFwD9rgwXQ/EbSWG9ibaqQnOat5rkoDI10kA==
X-Gm-Gg: AfdE7cnfCEggKpuyZUsNCcyJ7lWWfbaBD0nvGvfPS1lqBcOF0vvGOKmiVxpdx/4a0/c
	wy0wPCEl/juSDjC7X1CaVtgean1SCoSPJPOgVPErPqCi5k5WYE4J4gRANxUSu111imjaOEZ5o7x
	qwfOCEIrWujceGJfSH7gXPR0+A1zE8LVFo7fGoy2ikYuzhSK/5Sci2jxccMAx1mPOs6BwU
X-Received: by 2002:ad4:5942:0:b0:8e9:f5de:d605 with SMTP id 6a1803df08f44-8fcb5ea671fmr12863286d6.50.1783352806588;
        Mon, 06 Jul 2026 08:46:46 -0700 (PDT)
X-Received: by 2002:ad4:5942:0:b0:8e9:f5de:d605 with SMTP id
 6a1803df08f44-8fcb5ea671fmr12862806d6.50.1783352806018; Mon, 06 Jul 2026
 08:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0a4749ab9ac7ae0db0a0e651267358e947a1826f.1781080709.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <0a4749ab9ac7ae0db0a0e651267358e947a1826f.1781080709.git.u.kleine-koenig@baylibre.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:46:34 +0200
X-Gm-Features: AVVi8Cen57KHpf9whc4sxiKoOSpN8RNbmLrU6TaiB_yAFxAAU8Wmd3OlRN1oKjA
Message-ID: <CAPx+jO8hJ7hYExqPzR3we5mewUZipEG0mSeV9qCafw8Q0VC+_A@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: wbsd: Drop unused assignment of pnp_device_id
 driver data
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Pierre Ossman <pierre@ossman.eu>, Ulf Hansson <ulfh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfXwZrdIpM/nO3F
 64RSiPZscOvFRgtZWmk8a60Q4Zj3EdRkml1cZKOj+bAFzvJVVrECXVvtkv7rb9BL5/vR8gKZFGq
 hVdhrpF/FvQL6cDVUIudMd9u2Fh7hds=
X-Proofpoint-GUID: ns3iMWmapf5efTgi4Km8WWi44Yf6guD1
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4bcde7 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=uU4xFXAYia2alNEYA-EA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: ns3iMWmapf5efTgi4Km8WWi44Yf6guD1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX6Bik5HN3TlX8
 rf5UZBuyAEjTjxXzu03QB8noJGr189vpYDnDwRePusyEZIrfgIk++B+kBFtYiUdxi4H6wOhirYX
 zHi4SM1MTWR2AhUTa3IFy5Pl06IN7IUlpVlGTUmnLklbfD9c5j+IWiLH32cZ9TtwMS2Sjk17jwh
 bjZ+OZ9QSvkpfP7tPWhv5U6qhbKRhckrgftYyy1JFLrceIxY/Q0n5AIKtOr8TM1o+SJZp9HsWTw
 6yj4i2dxw4wt6tZgszG+VT5jbjcShEmgGlgZrD2eu1skDKRPPSmBUqvGEAg+oi8IU+tAHciI2rw
 JDQEGs5Yc5++QmnUZ2ssPyWnLfFIhV8+rlI/P/N80I+3wW//uGuBIiXaL67DZhnBRKPKy2vkFI9
 UC50bVKC27Ys+e9SYPcUbxRVNhUx7F7ZKwGjplbsluzMwIlrHqvz0ID4pi/6anHvao1fDENeQAo
 Gf5RqtrjLVrO724YX9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060160

On Wed, Jun 10, 2026 at 10:41=E2=80=AFAM Uwe Kleine-K=C3=B6nig (The Capable=
 Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> The driver explicitly sets the .driver_data member of struct
> pnp_device_id to zero without relying on that value. Drop these unused
> assignments.
>
> While touching this array use a named initializer for .id and simplify
> the list terminator.
>
> This patch doesn't modify the compiled array, only its representation in
> source form benefits. The former was confirmed with an x86 build.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Hello,
>
> I intend to change struct pnp_device_id and for that it's required that
> .driver_data is not assigned using a list initializer. Instead of
> converting it to a named initializer, drop the assignment as the value
> is unused. So this is both a cleanup and a preparation for a later patch
> series.
>
> See
> https://lore.kernel.org/all/cover.1779878004.git.u.kleine-koenig@baylibre=
.com/
> for a more verbose description on the mentioned change to struct
> pnp_device_id (though this is about platform_device_id, but the idea
> here is the same).
>
> Best regards
> Uwe
>
>  drivers/mmc/host/wbsd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
> index c33a0223ce7f..51706898239e 100644
> --- a/drivers/mmc/host/wbsd.c
> +++ b/drivers/mmc/host/wbsd.c
> @@ -52,9 +52,9 @@
>  #ifdef CONFIG_PNP
>
>  static const struct pnp_device_id pnp_dev_table[] =3D {
> -       { "WEC0517", 0 },
> -       { "WEC0518", 0 },
> -       { "", 0 },
> +       { .id =3D "WEC0517" },
> +       { .id =3D "WEC0518" },
> +       { }
>  };
>
>  MODULE_DEVICE_TABLE(pnp, pnp_dev_table);
>
> base-commit: 49e02880ec0a8c378e811bc9d85da188d7c6204c
> --
> 2.47.3
>
