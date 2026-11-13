Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794570413;
	b=vx5vyXAe8ctpi8NIZvtTE5RMMKl3QOS6wgOy+Ivxa7ec5VENTlGPFBDzxkQUFWGoSNji
	 zIDBhkmIgw2gWXyWjiH8Nma3ycdFsUE+a8YZJPR7ErQ4jh7plnAVhyda4XwAL0Swac3ld
	 yCUnJmSGe28g3knPTtFBZxs6s19S3gOLx/LIN8UmYgMSPxjVFMVcCq1s9StznwVjYTlQn
	 lV3Pwcnz/7Ij6KHhV8SqGjCK7P6TczugCx4By3Xky8aoRjq8YvDm1ckMU1/SCoRQlKnCj
	 D9d5c4eLGI/NJ6U9kAsEdfI1OsjuOeXVh0LBCQ1K1HMD1iPOWra/vaz94V4jnJBx+/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570413;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SvrKIGgMsKekaZ4OYmJWDRmxhlP6pZF+z/6bpyikrIw=;
	b=iiqwFAANAMw4Bv2bucTToS2ehrRacDAGF3E8qpLXcSCkrlMQydT8mKZzFB6vT+sNE31Z
	 G/KYJgc/KSCBgGfaetLRuUUPCmtFUCt8fKPqpNsdtLyIhzPVDAyauUXGpCJo7DNbAUEsz
	 4a4v9N9Yk/YnHnaKDdgqJdX0MKbnm6kE8HpnQpVu/JCFd8MSfNOahsdX7fmW+sjjBNtPN
	 GjSTesu6/GTmTNNOoe0lRFwvFRT6go1tqh5svNAERMY3lWBc8MU3Fto4mq75hCmIItdAG
	 C8P/G2ZaTCLwP6/eOD/BtFMrMoeoI61Om1CRkTCJnO5R8IzplPGNWoW8brBopqKYp9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TLFD0Xox;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Oz3DrF9r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A92606A32D
	for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 11:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16A92606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TLFD0Xox;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Oz3DrF9r
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8V6kD3620236
	for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 11:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SvrKIGgMsKekaZ4OYmJWDRmxhlP6pZF+z/6bpyikrIw=; b=TLFD0XoxjBWwGNSh
	40KMNOgMybCIzGVhmLjmJEqCgTsYKSL87b9ScPTKF/1zuGxpo7YLfwNOw0QMwkQd
	JPRVAg4qv6GNtqUluc8F5Y3hQqV0SH7ROcNcG5wxunqqqPQwumWNtdsxPqVC45Fu
	hWmQC/5ZdcFXfnmRu3yoxBR4v8t6+e97A2lbm/VUrlpBwQoEHr/S99qKLjsYOplL
	vU2t+yvJkLpMVAGziPWUHFB0zLsS45bubJQ6ThuYYBkwv6dpiIo3R5PRb2NtltFW
	vlXZlBoNDguUuSc5mMGLsBlntCBTpXrvoC1oEL7qzma+8zwCpHNZ/aNqoK9QLog5
	4YFbTQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvja963j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 11:46:52 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cddc4bde4adso350630a12.2
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 03:46:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794570411; cv=none;
        d=google.com; s=arc-20260327;
        b=fByg7alBtd3Bvj8TZLD+a48WHfRAV+0a84pcKwkhVbdHNT+ozZBhuJKs126UGXUwW1
         O9RBgtUDWv0TKoXllUqJPPtGfA8c2Q/9gdftT16UsX4bd/Oakgml66ISGU+XS2ULCeo3
         CVWkePVYAhCxJHGhCO9vuSdl5rfEOWxQtizH2uZUHlwaqhvVpIV9o5bSqo/fUJ4Jx/0l
         tX7fvPpjJFsEY8Q5MXkJtalgyALPwI5ETK1GeNV9cEaYWQRC4YUI3Tdu+pxIX9Ndt6cd
         bQ25kHMWLb7bBL86JQs/dHfevIj+CF7BSOe3l1sbvlhtbE8D0UGjxoHhjxam4ckTfG9A
         2DWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SvrKIGgMsKekaZ4OYmJWDRmxhlP6pZF+z/6bpyikrIw=;
        fh=3WbTKLwQSK/lMP5U8XRxJ7QBpKeeHA4X4sNYEaub8GA=;
        b=R5K3QyFYSzW2OUNHRePfnikylfBExuqaAXQSMUWk+jIXQWOOjKbbvgxhC3xtCDUAcG
         55isUaoahb5A4IBMHE68PZFTHUHz9Ahy9JGkCROs3t2NqakEMXgGOue1pMF+n898CfLD
         f1JtRLmu6WPKasy1acY7jrGizVwbgb00vgq0vEaSz08udkYGX5snkUHF2fHoAn1a4ZJK
         FUyW7GG4AQqfoWWVO+zhSBtAZwo7peuRXEuOR0VCqmgeXTD24Jw7lmczDCp4m7stOMt9
         Q5etxOUoCabFMH1JQxJQK3E8PhFrNyosvY9eruPaOo0pAFR6xKKoDP58px69H0H2LCuW
         nMTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794570411; x=1795175211; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SvrKIGgMsKekaZ4OYmJWDRmxhlP6pZF+z/6bpyikrIw=;
        b=Oz3DrF9rf4moBcb43mofmzUzUsds/sZuuwqrSr1ABDWNNuNBvFuOENuRApVFM/WJtc
         eJ+0UgijCv6l5os9rOto2SDYRcmxloShDYwtrTN1VmtwIuBAATObcTeGARUTDiOt9Q/d
         MimF+TMGPiqFgcvvTXV2HYW0BX0DI0veWuOUVtKXe74gGVodWm/qcnd2C5+LD/oO3Iga
         puySdiSXuQDlct9FhBH74agAKJxhh2xjfmVan0rqzkxMtx8nZx2M7/QMC7XYZ9/fXDy8
         WsgT/bWxf7Z/Dvm4dA/GoiGM4Go8zLcgBKHOK2yv9zsXV6Kq0rpT2/O1YYfPBL+s4mke
         zY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794570411; x=1795175211;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SvrKIGgMsKekaZ4OYmJWDRmxhlP6pZF+z/6bpyikrIw=;
        b=mCmiaQggwDuC7Xcn1ndAf+ciP7vACCwaRimotrtmVXLLN5sf0GIvK7nyZtyoMxgPvA
         L7vIEOKRteUUqNHwqEhSGw9O7q8xie3GBNtbOyTqO2KnrTDnjMdyxXg8Kk+gH7s7ZCXR
         yPlKVFHuZ0f7xG/VR+FcfDljGwqRTNIJFA52XaWaxoSTnbTwEKt7FcDUFDCYAOxMzn8M
         nmsbZsL1lA31X4V0PFNuFTvmDIwWxUsjcSujralJTi1JxaNP1ibxZuUdh2luoaBfjaPz
         bAkp3zRLQDRkdOsG+NECyltxcwqgW349zHjzdfUBjBa6GJmW8R7y/M/TIDSzD+No5JfA
         onMg==
X-Gm-Message-State: APuU4Z+Z/3g/+TmSo+BQ+GOpTZBpzpTgr9iaSjw4XgebThNmAFvUy4wm
	SLjldE8XiDVq+pslUg8+sbDbXUv/e2A9DMUxTEnpbxqIKF9jGy+CWIeueGkrQnU1MeQdAbKvBJU
	k8UolC8bl0yyXWU8ZlhTUjEU72OyRDV9RgQXj7fIt2r8/AAztAnwjb0ucv5zyR2e8qsxWyI6/BQ
	BLXa4oFcVq0ULxc5zRfi0nXeGORPrkKpHJqDw+rpUvi1sUaoNz
X-Gm-Gg: AYBFou2FS6ml5vhfQIo5GdhComKfuWxcuu2a6FIkQWfXOan4akzsTPVvyw57hemmUWe
	m9y5x+KomR6ZcqRuay6KGoA+/SWDdstW3NNTW/dLRa80npEJpWz4mBtC2En0z44rgyZh4NkNqTu
	7Z7wClwG27SZNpO5/HdQAX28b5mMvIbeScue5zMg7RuVBilauNkkg8M1y8+Q==
X-Received: by 2002:a17:90b:1807:b0:3aa:fdad:7d6c with SMTP id 98e67ed59e1d1-3b1b0ca59a4mr2048297a91.58.1794570411523;
        Fri, 13 Nov 2026 03:46:51 -0800 (PST)
X-Received: by 2002:a17:90b:1807:b0:3aa:fdad:7d6c with SMTP id
 98e67ed59e1d1-3b1b0ca59a4mr2048283a91.58.1794570411076; Fri, 13 Nov 2026
 03:46:51 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030215427.488298-1-marex@nabladev.com> <CAPx+jO8sc8gbxNQTjK2tx+1UPLqwwEof3E9vknHNc4kmbeB7oA@mail.gmail.com>
 <51207e63-ec60-4805-bf6a-b10647ee3866@nabladev.com> <CAPx+jO89Z0Z241L1jyB_3sUygdEwGicqT-WfHc6ppG8egHUO2w@mail.gmail.com>
 <c3cbd7ab-e689-4a9b-b311-af43980738d2@nabladev.com>
In-Reply-To: <c3cbd7ab-e689-4a9b-b311-af43980738d2@nabladev.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 12:46:38 +0100
X-Gm-Features: AclHuK-rL4pW5II5yik8DeEMNv996e0C2bZMPptbleGKQZzyv7whzH6lt4_bHnk
Message-ID: <CAPx+jO8=nVBUuOQ==Q66nOnH+VeXur88DetmETe8qmOiS_NCWQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: handle mmc power up
To: Marek Vasut <marex@nabladev.com>
Cc: linux-mmc@vger.kernel.org,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ulf Hansson <ulfh@kernel.org>, kernel@dh-electronics.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: DMlhLse8spR6YnqCNfp0olX6GXv4bdCm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0NiBTYWx0ZWRfX08jdCjZoY7ax
 gTqPtuNG288Mkh2VuLhdU9eD92yrTw34qi48DLlaX8fdCwFRuK77kWA7KBI596HER5nsNUjeZBY
 jPkOdWb86rAid/OH5054EMz69vQ6pNo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0NiBTYWx0ZWRfX84QbwEmEtPbD
 3+038RdpolS86DKphedsrp5SfSgC0U7t5Uakr9ITDcBnepD8RdR/YI9hUNF3QI1sRpAXkWmPxFn
 5LijLHulxgHM1s22bUS4xdmRDtXMhUcewf2y6zguddNNa41gxYJvFo9jE6mkyMeKhAFuqgt/N5q
 LWIrzfKzMLPb6ijqk6/pwgzXoJiKSonKr6/Z12aSb+0TxNjDodfrftmWNw++mGmTMCfdKMsYyRx
 CInLR6CvoHwdcku/r7Iu5GrQqsdBKtLmHjnRR3ZDROwFlf6OcxVMkAGsi64u0DaVbSOGyErqd+l
 hsdZ7cW3PdJWBoAU0HEZNNAABAHM3e5qHsnF23UbpNmoY2NUOw5DUxzTMqe6x+6L3GXSigAWrsB
 Wn5LWDTeJTIbNxJJnTaTJJchrsiSKadPht8/ZN+qT/mBHDmWdASrHdsAj5ux9IJe+b/d7wxvRJd
 gV3S19EUrj1hc41rzsA==
X-Proofpoint-ORIG-GUID: DMlhLse8spR6YnqCNfp0olX6GXv4bdCm
X-Authority-Analysis: v=2.4 cv=AoN7T+9P c=1 sm=1 tr=0 ts=6af6f8ac cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=p-LfKV-GAAAA:8 a=sA2VMIrPSRRtzz563tQA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=97BuGM4RKn6GwmfqMd6i:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130046

On Thu, Nov 12, 2026 at 7:26=E2=80=AFAM Marek Vasut <marex@nabladev.com> wr=
ote:
>
> On 11/11/26 12:45 PM, Ulf Hansson wrote:
>
> Hello Ulf,
>
> >>>> -       if (ios.power_mode =3D=3D MMC_POWER_OFF) {
> >>>> +       if (ios.power_mode =3D=3D MMC_POWER_OFF ||
> >>>> +           ios.power_mode =3D=3D MMC_POWER_UP) {
> >>>>                   /* Only a reset could power-off sdmmc */
> >>>>                   reset_control_assert(host->rst);
> >>>>                   udelay(2);
> >>>
> >>> What exactly will this reset?
> >> The controller.
> >
> > Okay, I see.
> >
> > In that case, this reset also makes us reset preceding updates to any
> > other registers, for example the clock register. I would not recommend
> > doing that here, but perhaps there is no better option.
>
> Does that pose a problem in the MMC_POWER_OFF/UP state ? I agree this
> would pose a problem in the MMC_POWER_ON state, but here the card is not =
ON.

I think it is a problem, yes. If you have a closer look at what
happens in mmci_set_ios(), I think you will agree.

>
> > If I may I suggest an alternative solution, perhaps we can manage this
> > in the ->runtime_resume() callback instead. If the power_mode =3D=3D
> > MMC_POWER_OFF, perhaps do this reset there instead? Would that work?

Can you try this?

> >
> > Anothing thing that caught my eyes was the MCI_STM32_PWR_CYC bit that
> > gets written at MMC_POWER_OFF. This bit becomes cached in
> > host->pwr_reg, hence it's also rewritten at MMC_POWER_ON. Is that
> > intentional?
> I _think_ so, this seems to be used to power cycle the card.

Well, we are not power-cycling the card at MMC_POWER_ON, we are turning it =
on.

Seems like we could use some support from the ST guys to understand this be=
tter.

Kind regards
Uffe
