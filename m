Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793130210;
	b=kGkVkGQJoC/jfs1guzyPNy47voxKEQ7VwZ2qilZjek7wvKZ+VW2jAnHRYbJ3Cv3MX8Q+
	 lGQcZjFtxJIds92NX3E8Np/V8vpiJrTsb2VkHrRLNrGT2xXUo5OWL6AyWb//KjdWxy026
	 EzSOrcCxMB1RPAglbyH4rkbaOh8HLOiroakwrMz9sNbkuUZV80RXmr3t7WD4T/EDvtlst
	 q/DrHAmhDqFMmrznbSmmmuzLUSJXRw+9y0GemHThx3bISHQkpE8FtdUtCya2ReOcAzlRW
	 A7gzbMQIxFcP2fcuOcRqbdTCXnd4iNQ9iAVQRwseeaHzN5qosVmTlha8wKsyIpYMK5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130210;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tvXXxCxPW97KVCYAIPhnCT9o4Z8at5Y2UFltu84JE/g=;
	b=sJkkeJ5fxuOVXbeLZ64yO1DEBjko3hUQRzkTm4cr89IkN9b/tKUs2IxdJr+WLQnVhaZf
	 yZ0fmtrZu4WjorF7fBnv9adLn/X7tdq4b+pv+ZhpJq0qzHVi/ComrQAZLGL0Txw76ufO1
	 4KucD++BhLLceB6NnjJN5OAtxYQn3tMTLj7E0OKSKIyKN/PEJ2B7C6SgCa0KhwdEjNMb7
	 ueIdxJpvJ0oCXLo/OT8wLRJMgvnEu5t/AfqdKLjZWTkcRrf7B/SA6rjetud+p1rmIhVlO
	 RrpFXeJN+0LYaYhhSi8yJCjXE1LqcqcuVfnlZONOFfoMp1ca/mA5bGx3ydVoOqIjahA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qc5o1Yyu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DBbnbCnF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33459606A320
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 19:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33459606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qc5o1Yyu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DBbnbCnF
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RIHRoP3554018
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 19:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tvXXxCxPW97KVCYAIPhnCT9o4Z8at5Y2UFltu84JE/g=; b=Qc5o1Yyul3hrWQH3
	c6zo6pY8Obyy4qzhyCNpozZ5S1sWqcdup0KfJjSM17/0Gs31Eiy9HyJTT+Thosz1
	EyiIExAnSNoCmJa9FaWXp9W2DtWG4jECSDQdgc0HStVZbROKG84JpwcN5DeqdY8N
	TjSnx9BYc6jHVoO/Q0mEhoVzuY0Y2oVDsgr5H4sZLwShenoak4WK6KfvSG7xmd37
	xt7J+awHPTQh1QZ1sDsJfms4KsR64IY62TGtX2DMy2I1INOtCQzbZtX4nXIeXRU5
	IQ47VVqwhHz/CFDK5Ad3t0N9SIQKyLgsfnEoGiTSI/xVYGi3AI+dtYYlekPpvsel
	8G1Y4g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw22ydu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 19:43:23 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso166793a12.0
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 12:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793130203; cv=none;
        d=google.com; s=arc-20260327;
        b=FSFiagsxCV9r1+UUeMFJVvTiZbos1NeNg4rWCfjqtC/1wClvWe1tFSS6AXHf1K/fBw
         cOEeGHHowzBO3zx+hQGctigjhod8/nl7smqgaz2eiqA/ks3oQnGIMKBd6tLtmagCQ6dc
         dYQMwiFp7fzCLYjUY/pXz9Q4c2Wv/eO3/dW72QZKMOy3zWRAVMWvXF8gCEzV/GUEo/+b
         N00Xee/hH5+ZJv3Gs/uo4ikwO6rU0ruGe91RqFKS1teFLvogp0JpGdiEppZx5CLqrZm5
         vXg1qpuqz3VutNfeJyUcG5vDYSKow1JSCwKfxd6n19/WMZ4n0P2it9O2su2stb0Fw3LS
         rEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tvXXxCxPW97KVCYAIPhnCT9o4Z8at5Y2UFltu84JE/g=;
        fh=F4NWry5LSZZH3uWdKnnOaRv/evQCjcfqVyKW8lEPmps=;
        b=ZqbkSmFtDUFUbpICNnQIsDFBD7YaNFl4CE5WOx1LfBmmqPQyl0eZotbvD5chsxEjF4
         z2DPEIHcYRDHMOJHKp1LK30dD/1TweYoGHExbfVy65z5lgPq8nAbTVA1Ng8pm4wj9TT3
         l6Rn+1ahAAYyrkZ6BC4BIpfLIZJoLINjoGqqbpz7pTWt1Efbbo2+ine5swd7Z+UQwIt5
         sW9IcmLDB26BRt3o3JcpPzLGqQr6FCAcTrRGt5FUw2Q60/t2LA/dmq3U5wooBZ3PJ+iL
         9SbBvSgA2xF/WVtIF8Su8xG5C79l0WMPJk4J0PlrRwb+wUqqSX6al0M66BuhMioOKQEc
         0TLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793130203; x=1793735003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tvXXxCxPW97KVCYAIPhnCT9o4Z8at5Y2UFltu84JE/g=;
        b=DBbnbCnFBJyGfTO7VnFs8RbwvztWUCMm5415AJ8yIpuwxNIDmnOCMrkXrsnE98C5VL
         pjV13vVKCAxaKP/NUGgvoTtZ19PmqORtgb64mKY+ZqelRdvCoW9Fj78hFWyaxStx81os
         ouPwNExLyr66EvfzG3Nz7GmEwRr0r4rF+QFR/lpjFPmP1xGmZzkAjAaHHPRb3mayUGhJ
         8ku/2kAg7Z0PQ0FvYcqWvsASWGRU6vOTlULqRD9XWTGAMpR/Td6rxuSKDfo4I/QkqdSQ
         EUSH7ecvg5hvMn+en9Yd9w5FD5DZlE0qx/ZkrdV4lSp0VPS+8krs9j22yMLFaUTj5Qmq
         REfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793130203; x=1793735003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tvXXxCxPW97KVCYAIPhnCT9o4Z8at5Y2UFltu84JE/g=;
        b=htrKROVYZO56He80xqpGT6UGghea18GG4KrO69xIqLZ5iCoshJpZzOOsKwFzxtjDlk
         nHEeVhdcEkQXIGrnL6aw0nPqNL+fDHrIe/uiBXMm6GOjMZMGLoOxfEl4jHngdZHKozdd
         0RgwZNzyDU8LcIlh6Zco+uiRhLFIkjL3QipyESC3UXSDEhpV9Darz6L05z3GztADRakB
         YudidbmZhAOW7AyOVZhSPsGu15M0SKTZ/2VTE5uFzBjqqds5/+/g/sMBpgaAw0vkDalK
         6EwD0eJGth0TCXJDkj77XfOAly2cO3Z9L6QVk+pl+9Er7PLtu5qxqxuEmVXYnV+Xgc+F
         vsfw==
X-Gm-Message-State: AFq9FYK4mTtVF0z2yLOqtcnM1vej96ocbpfevAIAG0K8NeP6KIo0Dt6i
	VXr0GPe2SzmCocxG07F2fVMnSNp5YMLYGBfIJ1aQ0gpf7vbZXDE3lZGIUE4Au0CdRPDr0MOd8J+
	gAllt+4IzjLeQ422N2vqwjjhguMoTizjJZAwqC2U4gjQNCe7zcfB6Voy5Jkvm/4wuGZr+1u7udE
	pDQABlEuYHGX8fK1D9kYS+tZLkP3MSuOy0/QneFdD3onJwvppH
X-Gm-Gg: AYBFou0bYxLmjvj52TJtICjLwEExRmXWTdFuF3Ez3BxDvr69vbRGhsc9tKSRMmxn+Hi
	PxH9KPQP6uCOc4i58zgOOSwRxA3eoidp5C9R13y0hFbUSUiWdOhVwPIbVhIziRQqt/LcAyEi020
	At1h2Bmjcys2IFMZv+GtV9SegPR9FDElZo8rJXktFcy8xYhovI51UZsB7EjQ==
X-Received: by 2002:a05:6a21:4847:b0:3e1:78c5:dfde with SMTP id adf61e73a8af0-3e9025cbf89mr142885637.87.1793130202969;
        Tue, 27 Oct 2026 12:43:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:4847:b0:3e1:78c5:dfde with SMTP id
 adf61e73a8af0-3e9025cbf89mr142873637.87.1793130202500; Tue, 27 Oct 2026
 12:43:22 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
 <20261027144051.249211-5-ulf.hansson@oss.qualcomm.com> <a005dddd-a495-45f4-ac43-7d708eea009c@linux.dev>
In-Reply-To: <a005dddd-a495-45f4-ac43-7d708eea009c@linux.dev>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 20:43:11 +0100
X-Gm-Features: AclHuK9NHHxASxINNQJmFblOIaIeW8hwaZcMMDCwec1w6nqIWEDYH1aTry3AfCY
Message-ID: <CAPx+jO_2mjobdfAwnwRR-NB+ZD8Ohq2H-qWywaX4QHoQXJh24g@mail.gmail.com>
Subject: Re: [PATCH v10 4/6] mmc: core: Split sdio_set_host_pm_flags()
To: Shawn Lin <shawn.lin@linux.dev>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OSBTYWx0ZWRfX6bAVc2M6Lx4g
 osRUy5l2/TlWnv+ftaaZWc0uLpWzhUZVpM9TmBc0Epvfond+EDV6z3F3n3l1bHQ1iM7qTBvE/e7
 e+e+4KR01U/TlILzmGBP5MwAYhikHpRAeCJa/KgOo8HFLuphSTJKZDa6MmE+MXsUUJA9n//fvD2
 cgjZGJm+x1ngzqRLHTxJv6CMuafFqBrM16urk6GcQluXa/AjGRPNyBi0SBqpGd0Ba+jZWn/xU17
 D3t+Ecf+ogVACc2Z+l4Z0uLyfcT/2YYLdnuCXVKE3L0M+JeA/dU1c7aChHSG8kjxEeAZp9uxbWv
 C9RDlXPUc/uk4WjkZQwCJ5dp5NnS20djknIKZV3QZAsDNh5rpCJkF3le/55vA6dcmqRKfNZyx9M
 AQr285PWBdpUsZnb/aTAQtNHSi+EuXXyzwgEsb8CBe2IO9fK5q5t/BcYOUGcU/3ysPYL43lFoPd
 2q8FHPjDCNnmdwUKjig==
X-Proofpoint-GUID: Nc0o0SnPVRM2ORcaZcJpd2jaz5P_XIu4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OSBTYWx0ZWRfX9vNnlDzLPHIX
 WgaWouxuuo1fNTEaOlmtvCmCSK4fSNH6y6gt6SJzpI/izBYOhoV7QcMJPzAmk5GZUifKpjAy5kA
 tLKbZMLJB9mHtD3m5uu5A2Wj1WZTzjM=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0fedb cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=0--HgKMnnlG_k7HjjQQA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: Nc0o0SnPVRM2ORcaZcJpd2jaz5P_XIu4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270079

On Tue, Oct 27, 2026 at 4:13=E2=80=AFPM Shawn Lin <shawn.lin@linux.dev> wro=
te:
>
> Hi Ulf,
>
> =E5=9C=A8 2026/10/27 =E6=98=9F=E6=9C=9F=E4=BA=8C 22:40, Ulf Hansson =E5=
=86=99=E9=81=93:
> > To prepare for a subsequent change, let's split up sdio_set_host_pm_fla=
gs()
> > allowing the second part of it to be used as an internal function for t=
he
> > core.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> > ---
> >   drivers/mmc/core/core.c    | 9 +++++++++
> >   drivers/mmc/core/core.h    | 1 +
> >   drivers/mmc/core/sdio_io.c | 7 +------
> >   3 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 677e445dc48c..49c0494932cc 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -1422,6 +1422,15 @@ int mmc_handle_undervoltage(struct mmc_host *hos=
t)
> >       return host->bus_ops->handle_undervoltage(host);
> >   }
> >
> > +int mmc_set_host_pm_flags(struct mmc_host *host, mmc_pm_flag_t flags)
> > +{
> > +     if (flags & ~host->pm_caps)
> > +             return -EINVAL;
> > +
> > +     host->pm_flags |=3D flags;
> > +     return 0;
> > +}
> > +
> >   /*
> >    * Assign a mmc bus handler to a host. Only one bus handler may contr=
ol a
> >    * host at any given time.
> > diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> > index 9be2875608ce..d3a2ff00b18f 100644
> > --- a/drivers/mmc/core/core.h
> > +++ b/drivers/mmc/core/core.h
> > @@ -64,6 +64,7 @@ int mmc_handle_undervoltage(struct mmc_host *host);
> >   void mmc_regulator_register_undervoltage_notifier(struct mmc_host *ho=
st);
> >   void mmc_regulator_unregister_undervoltage_notifier(struct mmc_host *=
host);
> >   void mmc_undervoltage_workfn(struct work_struct *work);
> > +int mmc_set_host_pm_flags(struct mmc_host *host, mmc_pm_flag_t flags);
> >
> >   static inline void mmc_delay(unsigned int ms)
> >   {
> > diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
> > index 12716ec0e35d..99f857514b63 100644
> > --- a/drivers/mmc/core/sdio_io.c
> > +++ b/drivers/mmc/core/sdio_io.c
> > @@ -726,12 +726,7 @@ int sdio_set_host_pm_flags(struct sdio_func *func,=
 mmc_pm_flag_t flags)
> >
> >       host =3D func->card->host;
> >
> > -     if (flags & ~host->pm_caps)
> > -             return -EINVAL;
> > -
> > -     /* function suspend methods are serialized, hence no lock needed =
*/
>
> This is an API for sdio function driver, should we preserve this commet
> here?

Sure! But rather than preserve, we can move it to the new
mmc_set_host_pm_flags() function as it applies there too.

>
> > -     host->pm_flags |=3D flags;
> > -     return 0;
> > +     return mmc_set_host_pm_flags(host, flags);
> >   }
> >   EXPORT_SYMBOL_GPL(sdio_set_host_pm_flags);
> >
>

Kind regards
Uffe
