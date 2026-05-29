Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B4F3F4DDE
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066597; cv=pass; b=OY2v0e5cIMJEWCWdP5GKHFbUwXdQMHE3frpKrDMlcV1JqOlCrcKxER3Oq4iihWmmYNuyVM4z5L6wCZlLk/XtQYt3Px1AZsk+ytlROJdOFEIvFN3DqJbiokA3qskMmW0hZvJi+6RsPY32mcDg9HrSaC/AV6+NcZVlEcWV6XQeeZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066597; c=relaxed/simple;
	bh=t0sbuoCRscRsNgBNxc9x5TWkTU0fefbRXG4QqzAlBkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/TN8A3TjrUKtL57+aMnICkyrax72rgdvR0JD20jTXAo31OBQaNWGTnRhF9gjdydXOxPicaKAKTIDUv7wqy8OeOyk3WD3fCg6OQsSVfnoblCKFIbI1Aen6JrWZQLMfUFjWWT9+1pZDM0cA/naDdQ+/yl4P546/cyf5PW3URktfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pe7FSy6e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fPJrKnE1; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pe7FSy6e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fPJrKnE1"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDKZ354119195
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t0sbuoCRscRsNgBNxc9x5TWkTU0fefbRXG4QqzAlBkU=; b=pe7FSy6erHB/iGtj
	O4JsVkvN6Ej8+SrfAoRMm56O0pqWM8hfYrzevYidONDiGuh+wgGQNKg5T1CNmvuk
	H8XpOIu2y6R6pWqP3gB/3bWYiuztUfJ1C081lGdiw/iRhtrJmnvHvn0iEMjh4K5j
	+EMpOSBNSH0K4ZIZas82TIV2jFGrTVkTi4/kAicHvlkzxLi82eRno1Yj6eTgPLoC
	qdCtIUFnN1rQQsUf0pU5M41StI77xxrKtj1RLBw7NntoaNo0rXKrKSPAzk5DoviJ
	Dudnrjlfw22SRcGnrjqmkpDGF3yOVUfkqiiSe6gj01YMUmhrLfmSrV/xYqb3Hr3i
	aCiT/Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef8rch42h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:56:35 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ca1e4eeadaso55135456d6.0
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 07:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780066595; cv=none;
        d=google.com; s=arc-20240605;
        b=TtkTKFsD/bVD5s9tiFjN2FfbOuqOYHMMmt2VTGhsUf/fQsOGPVNhK6nuok1SdU2k5F
         w96tWey/3yGJ7GAtRjhaKmr5m3lJAyLr4uCWS+TK3SOV9FQrZ9BaTRGpRBrS7uD7XPm1
         7m05qrjGOHpvd0Ie3TZQLgRdxafOSs0nATHIzxfLPDE5O8RxgP8TdW8odLBgJzCMIeWw
         6EoJui3GlFZqt5lH92t29kFpV1zKK2NJ5uuloQ/5cy3rRdj87BDGwsVDIJozQZayYGtI
         AanFc3PYsOKoAkNqBlru6QxekoeUTPsBSy9fp86J94JH+624cNgZFylsyK+kRZv8r9Ma
         iVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t0sbuoCRscRsNgBNxc9x5TWkTU0fefbRXG4QqzAlBkU=;
        fh=a7yR9CmqbFr1kMaKbYHj+JAIaOZ5+ARjQNQXXuiFl3A=;
        b=aPK92hGubFwFz6NtBPqvURI2EhMWdVBZIKtF3PerHPBipQLCRVgKAn6+T4XAPJzLfZ
         fu/4GioqZjWn4MbSIIjRHEn6bRJTzAlkItLE8huAq5ByGwZpdI5O1jtj31fG1U3U6Mpq
         F7NEPvtlmuN3RB+KAbEq6oGH34s6uQSMAPGQe1Q73vk30dSWcHO4YreWd2z4M+68dvcG
         b2Vp68rufGnWIQvTZBdr7R7WzSavi3isjK4wZq2B8zA+1AK4QnJM+30LWSyR+2c01/fc
         elsC9SwMv8qd5t1iRBoim2qRndODprXcIBqtGYsYyrCQr6xBh4RMAD1yYUK+UpDH0b73
         g0wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780066595; x=1780671395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0sbuoCRscRsNgBNxc9x5TWkTU0fefbRXG4QqzAlBkU=;
        b=fPJrKnE18O2ELrG+1EYVhAL3JW8yWtx+LTnh6bS4lkJTjmKe6se3bjOeAK4SPk9jD/
         nB9yFZDbb/5MwmpSU+p8pvLOMeTIVcRq4OJqv1onJDcnowLcJXvFcM8WAF+o3vVDzio9
         XCF8i5S9eKoV4bP3g7ijEzJu1fxdCI9i7ySkseEiMeGsO3j4Kjwtz+/+VzyX0IoXbHJv
         Iygt1XyZk0PlDljWS+w1f98KKpRxas26rT+usd1Xkw8N8g6wve1E8hnn3RnrVVfiCirH
         a94c5gOcnD96dKC678TwWrOZg+k61lJ3XJMZ7E8Ns/xKbSRDzy8q30k/Pz3li1pUUmZV
         G7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066595; x=1780671395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t0sbuoCRscRsNgBNxc9x5TWkTU0fefbRXG4QqzAlBkU=;
        b=FzLmgoiBWI2VNtwOKeGArBwBeQ5Tbdo0Ub8z0kdxQQ7zFiWgh3BW6/UAF4VMg5Pa1m
         OYsv+RWHdLnnuOCUGcTspw6EqmYi7xPoEGOySLv46L0YgIiG9G2q7WRRnal7m2QL4SPA
         MO3Z9TWxR9Jeta7B+g37jJ9gpS4kVkrRDgrw9WeUQ4otUJaZE6nJFaNwW8CBr/FDRvQV
         fGOItXOivM9HyNGToP0Z2/RZLHcEha6qBePXyCC7V03fdNGAdADuYLNx0SmHU2kGNo/N
         VI7ZGqa2p26csmSyhAvqjQMkVx/KLUxyaEF/M+HOkhDX27ADqyBe4efgTAzkC0XLeGeG
         JfXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+nGTvjbXQaqNzTNF8JkvDQqaGLqFNv2CIL+w0cs2G52OGwbDIwmhCF139PnwwCKOlqCaLdUtdvJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4FH+LwVAkHpgj7C7t7HUY+EoCJSJwmLRs2l7FXYBay4QkRTAH
	DqwF4RX58ENXfHFbZfjc+aXym9T55jq5V6t+aJtqj8yplUdEVX+a6O3CzMfrDQWwf1y2Icl+9Yw
	POLHC2lFAYhWhC4J6jYDVYT8yir1CtuZVdYzrGlQM8cgPD6wbtfOxqYRphlNkN2aPOvWws35/ua
	BVNHPnR8THE6Dui1FBp40KOhzigHJrsEXN6ZOxMA==
X-Gm-Gg: Acq92OEChNZAResYXmxEoHCk9velji7/en+Q9rLsfyiqZG+SFOO2OM7Aq6avr7We94v
	BNl66zsseeQ1Hkm79jOszuw+Z76J/tcdYWrCq6xnfyGKhUK4/OUNqmTSoDQ/1hwM5oaTXLN9P6W
	oJafQsWAtDyFJ5aPw/1kuBhEW44s2Rsc3g7mpCD3LXvjWj4Lf28ciAwHjsblHm+c1LuyIpr96/v
	Fv0mLsQDDOd2udJig==
X-Received: by 2002:a05:6214:3018:b0:8be:3201:ed03 with SMTP id 6a1803df08f44-8ccefdac039mr123316d6.28.1780066594959;
        Fri, 29 May 2026 07:56:34 -0700 (PDT)
X-Received: by 2002:a05:6214:3018:b0:8be:3201:ed03 with SMTP id
 6a1803df08f44-8ccefdac039mr122786d6.28.1780066594551; Fri, 29 May 2026
 07:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310113557.348502-1-neeraj.soni@oss.qualcomm.com> <07a7d2f8-4a6c-d9f9-71b5-49a1dae693fd@oss.qualcomm.com>
In-Reply-To: <07a7d2f8-4a6c-d9f9-71b5-49a1dae693fd@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:56:23 +0200
X-Gm-Features: AVHnY4Jm7GKGq_habBfPiaPG5j1Bztziq1HOpWPaB7d3DTUiS4TBgGnY-iRv1tI
Message-ID: <CAPx+jO9kc7-QCV+ZgeeQQGdTaLAcvedLgvOpdSxqt4ezz-Lxhg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Enable Inline crypto engine for kodiak and monaco
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        ulfh@kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 2z9RsuWCHA0FlATDsjO04epF3exyAD-i
X-Proofpoint-ORIG-GUID: 2z9RsuWCHA0FlATDsjO04epF3exyAD-i
X-Authority-Analysis: v=2.4 cv=DuNmPm/+ c=1 sm=1 tr=0 ts=6a19a923 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=1P0UMqgBtEyZMnONbk4A:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0OSBTYWx0ZWRfX+EH5ZjVhWi7A
 B/EqVoPmKVPRxc73SOR7z61M47fmVKOCjZXLH3sPAaMHNInIi3UX1C0NKO3ZjXCt/IZonkMtkW1
 g1FgbDVR7VT77LODn21Zi9CWEjcm8d70izRODVid6QCozYe9/YmHUlBsUvWMdqMgmgKj+U8jEcm
 wdiaAKwH0fZtf8naflviju3YSb05VI3EiYtjTyQ1+4NSn6PBDCAGLmPTpqX16x6+POqVPBOBd4G
 lyE8nwTjeBgAablZn+L6URK9cLLd4dq+qNxlAPn3lUQKUb994Vvi9TgjpZWz841Vb+ZDxnr5BIq
 cJYWlbKdTycTL91NQ9WcJ9I26TmA4ucF8TZ2vDd9Mm2LrJ6uYpODnE6xTNHwOoqMHiX09K5Z8pl
 I5MBeyATYa2jdAHvLY9mLVTXqb3/GfwyVe5um9tISoHiUlDeWyNhgRyIg1at12rRbwOftpg3wsA
 YPcrVWhwz2xgrQFKP/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290149

On Fri, May 22, 2026 at 11:34=E2=80=AFAM Neeraj Soni
<neeraj.soni@oss.qualcomm.com> wrote:
>
> On 3/10/2026 5:05 PM, Neeraj Soni wrote:
> > Document Inline Crypto Engine (ICE) handle for SDHC and add its device-=
tree
> > node to enable it for kodiak and monaco.
> >
> > How this patch was tested:
> > - export ARCH=3Darm64
> > - export CROSS_COMPILE=3Daarch64-linux-gnu-
> > - make menuconfig
> > - make defconifg
> > - make DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/mmc/sdhci-ms=
m.yaml dt_binding_check
> > - make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- CHECK_DTBS=3Dy d=
tbs
> >
> > ---
>
> Hi Ulf/Bjorn,
>
> We are looking to target this patch series to be part of 7.2 merge window
> if there are no further review comments.
> If if is fine, Ulf can you please ack the dt-binding patch (1/3) so that
> this entire series be picked via Bjorn tree.
>
> Bjorn i hope this is fine with you.
>
> The v5 of this patch series was "Reviewed-by" Krzysztof for dt-binding ch=
anges:
> https://lore.kernel.org/all/20260307-llama-of-massive-downpour-2e512a@quo=
ll/
> but i missed to add it in v6. Requesting to please apply the tag while pi=
cking
> the patch series.

It's been a little messy to keep my backlog up to date while changing
employment, please re-submit a new version of the series.

Also note, I don't pick up arm64 dts patches (unless very specific
reasons), so that parts need to go with the soc/platform maintainer.

Kind regards
Uffe
