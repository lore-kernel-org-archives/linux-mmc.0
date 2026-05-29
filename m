Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE87D426D03
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065941; cv=pass; b=T35/AK1MUjbYj3dbXyHJ6jeQcXdd6QmDY3DhoLeuBP8N2+N6TpJ9JEmd2hkKgBv4PZRkjo+lH+cEIxJPYFSJ4LmN6rs9JvjE0kdWfRLVL0FrdHXlKP5upr3NTeES6Dj7xcmURi2o1iQP5VBpaqX9JHwlpWnTZ3A1Q5GSH7FwDqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065941; c=relaxed/simple;
	bh=YFt/RcByWSmAq3g3/sPtfFzIwvnddj9xL4D5BHnuIus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7KJBUsqRvs39GU0W1rvLSQPZjIeSFoyuuOoYKZSDf/jJ/Q8JPW/zhAkJqGWfvvk/8Sr5GlllZSkH4eejbo3Kac3MjtTU+gE8TNKe7MxZ86xV20OUmDIydpBcKB/Ed587J1HhywchuQ4ScwUlE+eb4YZBefg6l6pvxqSxTl8ZaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VV+jnHXK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AMhjPe69; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VV+jnHXK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AMhjPe69"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDKrOj3845242
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nk3TulTpFB5hzCGAN+0Y9okoxS+sLFrZZs6NaYSTC9s=; b=VV+jnHXKUoyzhcjQ
	3byvgF/WxTaLG475C859yAeu2ESZCM9UUtfSN4EPtf1yaei0FNczHXt+Sujl/XH7
	gxkDqLEOjJKIsVIRDMtvmhE3nenbIER1tZ3FRvsQyJ1n3jAg94HFBl8afV2Aso9/
	HPzaoJZBlQt2EzxjnosFul9g87JUGCO3liZ/VlVK8KnN42bpUYa+pwBJmR+yeP3b
	zmJk7EunjM+xSKenc1edXjlXCRq3UzV5FAkQi1W39MTTDIaeDlm7sThRsVFmIMg5
	M7Mksyl6/aDmktRdZsCUeFfovGuuUSZltM1TIfCZEBrjkVHWfiSSBwNme6p+/wKq
	Oi8olQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eex6m3sn6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-514cbe73d00so357812651cf.1
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 07:45:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780065938; cv=none;
        d=google.com; s=arc-20240605;
        b=hFnGzlcGQUmxUcnsD3ZBXVPjTb6EE7oznq4FQ9nTQ7qKHdB6xZ+pJf/8HjFrvfmaVw
         xVpspJY6XUonMSYE6lsFW07ayanW0Mz97IgqWpYj8mge3iWc81vzolnq0uBZ+DYsZiHD
         CdXOjjnA4sonlACB1nQMKbbwY4wW1tfwZik3qqIohCBYlobyEL1IvhaS2nGkyYTaEhrK
         uFVc1htd4P1qqPV8sQjCk9J4TRPVo3HRS+IVVoGs/OH8KdjI6xE/JXzntgcFMBKvZJBT
         hvpJBgik/cC+TuLh58PZ3TP8+hVJ/12Kq/scNHOIy9AW/8g/RFwA1uXgjEyvqAOs8Y+R
         ykSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nk3TulTpFB5hzCGAN+0Y9okoxS+sLFrZZs6NaYSTC9s=;
        fh=00SYqgWgK8Z954GmaH9oLhsRaNKYhYExcDHlpjj7r3s=;
        b=LjeKwshW0g2QAeQ6R+D3jl2jt+w05POyZ6htb51AjKslYAnl56m3XdN3s+tLnslG7Q
         FpV/+FjUZ6hBl1WRkRz/xFTDkje0DCT0gQs4ViMJnMyDd9af2RVSlB+w8mzAxqKgDr0W
         lf7PLG1+Ji5aco2qv/uE85pdMMT2c85K2Ez8+CKPmb3ngv9in3Ao69DS5qMHSiIOttho
         9N+GAYWp2IZREWD2U2q6duN69/eT74ksoUJVnE+oH7f1lkLY5p6P4OaSdU9F5ueELRK6
         zo+/4xV4z7glOgT+wS5Bpp8mXh0SMTcmtLXRlx0LWP0sDybE60gV3gSH6ssh1SNPjPYA
         zHLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065938; x=1780670738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk3TulTpFB5hzCGAN+0Y9okoxS+sLFrZZs6NaYSTC9s=;
        b=AMhjPe694d9vogIsRLHGORIl6LjwVkRYBTzrJVzZwMr1b3Xxbf9bMVUMgLjhR3pU7Y
         /V8M5PP+P6SrIIufSr9Agqnqm/o5V82Ci6S9a+kG7Jp9cx+rKf0/CNY/28XyluAk046a
         3aWxH2FwnXq4XGw2eW8FPu/H5rIJgHMlshr7STjdRmiyrbNybboVr7Zd8l8W58hNwdhd
         B8xqQJY6g0fttyfk1qMoisYhDm4oPAEorTrR5FnXPVQbpzu8FZ0U7keF/BsSTh9Y0V+C
         p+d3BGU8Kt58lTyWgjNRMXgy0L4oINXqzsB2GRGf8bNVMR09Kci0/jOyRfg+rEQXM2qr
         U6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065938; x=1780670738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nk3TulTpFB5hzCGAN+0Y9okoxS+sLFrZZs6NaYSTC9s=;
        b=NWemMdNOKDVP0zqTuV3L/NXDWFpyam9OGJtcbJhXAPOS9icqgmVdiHxV3hqhiRZsGe
         y5Lujr16asva3MLSiwzf+NTUEnOhdNt7Bb6rkrbKBC+KVU+9EAsrYHJmBw/gYwAEnITo
         9gGXgFewu7YtXuuugVO2z3neeCQpZ7Tx/8uUt6EuF/GCz0uFHgnOd7tG5MPyqYeTNO0G
         KZ6jjlRrqRRWFzO3RfWLyWGMnwOCdYeQ3ulWYz1btWliR5x6PXv54BK/McREbTmP2C/i
         6rilRd5y4Cj8i/z8IqGwruzDbg/SN2yT8ZWiTdAPtTKlMJj/lsqiKp9S1y9RUFUEA14c
         zDpA==
X-Forwarded-Encrypted: i=1; AFNElJ+DWYfsumn0TcekwudP86PfCldM4fWt1JdOIN9DrRvlxxiuzHY9mffU1vsf6WvCr3HYu+K63uwaaiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKW2U5JJHRI+R1Ug4f8fIxD2vQzQ+BPcNJ6rUayHZ+StQ/hEnX
	CqJL8WJ9XD5PLrFofrmnLmNikSmSXPtcvixikrCFouZ+cRgc+wfQZ+nkAeJSuX2saJ1dwwzIsuT
	SnOc7Tl666nt8/cUzm0HfYA+AAz+uHb5wT/cVKRctvQ2Z9elPz8mxJDvtSYpi5tTdh9W99xBCxp
	/DVraFcD8Fz4zNo0IAia1KtgQMvQd0I3cDUbhhNQ==
X-Gm-Gg: Acq92OHzrIwSTdGfHdSYN5Ko61GAaiYwOrk2mgCNkOHQcczh6ClanrkpEH0pLniWC8F
	p3DlkPXt0iVR4Eto2PjOXlpKMiQjT8iEIHlm5H7sZmYrXfjEeehpPXbgLUftSik2NgVi/Za4fmx
	JgL8Pn4turiN4ZKvYjlw+P6hZaR8fijWmswBdsCL2s0IHNXYSP5vILoSNrsi88nuMfm3DJSg84i
	Jsz/cxX2i/c6sL3vA==
X-Received: by 2002:ac8:5743:0:b0:516:ed02:c85f with SMTP id d75a77b69052e-5172dc1e4bamr40816661cf.9.1780065938004;
        Fri, 29 May 2026 07:45:38 -0700 (PDT)
X-Received: by 2002:ac8:5743:0:b0:516:ed02:c85f with SMTP id
 d75a77b69052e-5172dc1e4bamr40812101cf.9.1780065932772; Fri, 29 May 2026
 07:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519135342.623943-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260519135342.623943-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260519135342.623943-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:45:21 +0200
X-Gm-Features: AVHnY4I5YCSpQfAfiixfYNCiy1oosv1T6PF-Eysuc0TfIAMztbMrhGcG7erBAZQ
Message-ID: <CAPx+jO96EN3hS2fYT_uu=eNwJaUZC-yPPyftsMCHSr7GapM8Lw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: renesas_sdhi: Add OF entry for RZ/G2N SoC
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NyBTYWx0ZWRfXwbFLjOZjauO+
 VNAAJrzK8Ae8EqSC8oXYvM17lcOQTkOw7JHnfbbv4+Ih7bbRMm+KJAPPAMwfWkppXE5KMOk/WKA
 ePc3j46d+Mr07sYf2VM7mU5EcrVKrfakss6xX+EJ/0s6IRB8R7S4NZfCp/sJaNUjxfZoImhAAq7
 Fh44+Evt/ObPcovy8I1GdS9vDUHeQIUv8jFK8EFXK0WCqSq3x3cZ8k9Cc9RSXJ2EoG60PDeF3Q9
 qb9HaaVM2fGFV6Hf1gER9nzOmnqRM8Ky4L8rwpLkCZpTCb10yidldMJB2ZNqb27oiY26YZa8MQp
 oR11mMYeJdRSejIIYpapQbcKGLUE/fkdWQwJhYdya6n5TRdPYw9VFzW4boUdwt+4JUL4Mo3ZHq9
 y6f00kmFF7/D9EbTUrwJ6aESWmFXB30sSZ9BNDVbYZjZJjY83hyB9Xh8mB/Jw0V7bKEjMZoHSgw
 uGlf1mqD/kkJro39QyA==
X-Authority-Analysis: v=2.4 cv=frnsol4f c=1 sm=1 tr=0 ts=6a19a692 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8 a=yC-0_ovQAAAA:8
 a=IpsbscEN6Rrp8biRM4cA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 2dNbI6vvL2g2mslsLyrQaFs6DeXHKeD5
X-Proofpoint-ORIG-GUID: 2dNbI6vvL2g2mslsLyrQaFs6DeXHKeD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290147

On Tue, May 19, 2026 at 3:53=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The RZ/G2N (R8A774B1) SoC was previously handled via the generic
> "renesas,rcar-gen3-sdhi" fallback compatible string. However, because
> the SDHI IP on RZ/G2N is identical with the R-Car M3-N (R8A77965), it
> requires the specific quirks and configuration defined in
> `of_r8a77965_compatible` rather than the generic Gen3 data.
>
> Add the explicit "renesas,sdhi-r8a774b1" match entry to map it correctly.
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
> index 1d3cd4c3da1f..93470aea21df 100644
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
> +       { .compatible =3D "renesas,sdhi-r8a774b1", .data =3D &of_r8a77965=
_compatible, },
>         { .compatible =3D "renesas,sdhi-r8a774e1", .data =3D &of_r8a7795_=
compatible, },
>         { .compatible =3D "renesas,sdhi-r8a7795", .data =3D &of_r8a7795_c=
ompatible, },
>         { .compatible =3D "renesas,sdhi-r8a77961", .data =3D &of_r8a77961=
_compatible, },
> --
> 2.54.0
