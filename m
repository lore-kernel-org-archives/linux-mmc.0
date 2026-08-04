Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1106C46A60A
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851002; cv=pass; b=SmPfQuTWLp/4amgmvtpr7PGVSNBOgaN8yQ56ScIZNSpcIVxa0aHcx5xtn+v7T4ENtVtDvROF5rsU7jZxA5/pFFPbQqtDp3VZKUJs9+w71n2IEO3If0mxsnR5ofLr+F5DDUjApK+BGlyl55vrRKBqxDL++CnKXfXnqk8DHmNYfEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851002; c=relaxed/simple;
	bh=TjY3JwvN0KkY4QTihEcPkyfz4jaDpiXty+YBU5vi8WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdausaH8b+79qTQcYVhBhAMVX7kunyTXzRY+gHFhR/EoS3KmALftvOJheby4gEzbSuqpiDS5Ia3g9cLi3L3dPnCUWM/SW4nBgcCgPYae6ika6N9OK0ytMglGUavlnHRP720QWUgpCjlM5RwdvAKjF7pgRhK+oIUANW/rd6jdsNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H4jUvbaO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LWTELEjP; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H4jUvbaO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LWTELEjP"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CWl2F818402
	for <linux-mmc@vger.kernel.org>; Tue, 4 Aug 2026 13:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WdLP9oHVnpRBg6AvyyfpL7x9ueh+h0T3QrgvvbYu0zY=; b=H4jUvbaOV1LrAUlY
	3vwxDgGhDrsObzJKOQmJNSyj3CAEpXUskFeT1UeP8PeJd3TVpV+t98BtVgJ6VSvK
	L2ReD3uvsLlWnO7lAMVRWAnBX3Te2G0ftyx9jxp7V2VIQ4d5zFNURDckw6xo854p
	KPJjef8fqQJEcgV0udrbnVj/NqRHwDL4p3FDZumpxpdRi1t1Gnufz4752luSAb0O
	KowheWDi9xDI0bq8u3qr+SXPMJIICh5xAhrTHyuJ5woHN/omiqzgbg7o3VVQ9ysW
	ciuqHO+aUXKd+XHo4uUJ/BXYoygE+Mg6wd415MB/eC4h+xuY5O3npy0JXQmQG3L0
	3FLq5w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fud1dh3me-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 13:43:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e9a2b95b5so832504985a.2
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 06:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785850999; cv=none;
        d=google.com; s=arc-20260327;
        b=r8cYrTRChxodfV/nbC0DApOCp0sKaOI2Lg9ZqtnTquiDSE3NojLypFOe9xzGcyZYxX
         xPwY2EfA8+h/G1ITr6bkv7++h9d62i8p0UNLbfTtuFc5RfB0zl6R8WjCJ8bro0NKmgcC
         39gn8bkIq1Gox6+OytBNjJFYNDf7GBWSDgSx63CGIDcYxupWnuZzS/S42kDaan88ihC1
         kq7VarunqoLgj605CtqC/gwZr9hs0HCV3Nl6nb10k907yRR2cYhGBtMcMo1yugHiR2mB
         zd74DUnGa2gtpS8wtj0iG+6rvM/Nm8Nm2zRyfdqbNj27w5Q2oS1gb33kD1ilnDdFCHLG
         FMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WdLP9oHVnpRBg6AvyyfpL7x9ueh+h0T3QrgvvbYu0zY=;
        fh=/XzhGIDGEhhdYll4mL07L67Iw1ID35X1qpr1D6ve4HE=;
        b=sRTp2zf/Oyj/coL2K44Xwv2FOwlH9COOS1NVh3Rij5nEWA1JXJKmjhoTQFtIwSEVVM
         Ih98U+kl3ZziS9+rXZYtG+NfGLty/PZwA7cGNlGEpiGHkuZcn6eZMXuYWOAVM6rf81V3
         XrrK2Vr6tFBM9h1XGvLUXhI0wQ85UrygpKbgQSnKv02TXnxSKRzzcTGQ7VfVCm6w7hbq
         xQmy3RyQ2ELXSJIQHvAY84QivfJLKRNiTxWuGb+BJW1bQzuz+H9I56lp5W6O573MqUZ6
         8qyGd5Yy1X2jkVXGlBb1zcItsyH2nE4fVkR13AgoYfIodeQTpUvc8m1gg1Wpk97E5CAI
         +j3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785850999; x=1786455799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WdLP9oHVnpRBg6AvyyfpL7x9ueh+h0T3QrgvvbYu0zY=;
        b=LWTELEjPj5bx+0sxeV3csThFcUc8P/zk92IMiNytIDYWzLkS6X7a0DWrZ6CBVS3oro
         H3+Ok3pYp+LGhCRdYc7ley8CkaDFvc8bPPtlO3IDL9fRJSrcrLt4Xxrg7JhgGSjqL/E8
         6JCnoZ37TP0tAgdLCcgoRrm9pHWTN0XGqHuqXNC8wkEIsKO58A7vN8fsF9bUYP9UIUEH
         4lQqfL0AKDF5PdDPxIqD3JLb1MPVuUu6e5YYOUTp+VBhDIeyICC8eiypw9LCCu6/aW1W
         E755mlYYexod5dT2FdCtSJEm+S7WbSXvUKP0k0YUKroQubywms66tKj3PlZnwEIbViiQ
         d6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785850999; x=1786455799;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WdLP9oHVnpRBg6AvyyfpL7x9ueh+h0T3QrgvvbYu0zY=;
        b=eIxWf1aKegXgWLV8LHJM8UWXrsqQsnGim9XyrnqmPmyn7cAGzdI/ww//G6Z+bUDjgA
         8Qf5uRltVzezVxn71cZF29XL+2TZEufk3gcXK++DpaMCowOW+Oi2d1vCY6cWpPfhyxJN
         5LH9sVV8zT230HG+j97BvnDuZT3V2hIlMCnH9T+upEEqHICUPt1/SQaF973KU6Zc6rnn
         jn8vIs9ZrJMvQrEXSHRkYV61mJ8t47rYHVwNsKIC5K+kDifhFzw3/SHmbcU0t8XxWdEp
         2UefgyglLptzY2HjQnKrHj71jnSKa2Fm2uUR6NIkYZyoyrNCjhaCuAjD30jDQc5DqtHC
         VS2Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro8FzGRNaV0h1lVqGTxGWjgaHmDE9YuGdoD4D0DaiiKXIXEh093TZagwbRDZNYbSS4p9h3+im5JTiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPxlb+3mkq/TJMseZB+LiXHYGtMz/2ThHyzVswpKrmxRnf5MRG
	6AZVSz+2mPl/j2GVe9CTFp81/v87tUlhvPytdOoRLXiOFAuJZ1nEtkxLVgbrOcv2L/JqJnYjRJH
	9X3bC12Kb1Hh5eZNukqcFaRpf9Wyf/MEfZe+rqNzVXu1y3MQYGNaUy587O0pQFIKT4qd+Tt9FQz
	lY1ceebkNfRKkXJXE8v4QhtE19cWSQ8rV5Uzu2Kg==
X-Gm-Gg: AR+sD101zkR7sUXBaP2KarSDOhxDIUAK/8Q2jOIAz1dZAGxbisFJNE1st/1wZ2DiqaS
	Dbnyc87w65q3IxfJ7CS5NhvJOPXBFgLwjqnfGQgszhne0URuGsEPJ83gBIbvI0HAX5Xy9mHA1oB
	rlNH469T2OxczpywqCG3Epoq4JCBCQRZo3tDLQQHhteGnFBO+o7LPg8UjNTw==
X-Received: by 2002:a05:620a:4e7:b0:92a:3679:7978 with SMTP id af79cd13be357-934a078e708mr2148996185a.18.1785850999377;
        Tue, 04 Aug 2026 06:43:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4e7:b0:92a:3679:7978 with SMTP id
 af79cd13be357-934a078e708mr2148992385a.18.1785850999028; Tue, 04 Aug 2026
 06:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804022500.3768116-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260804022500.3768116-1-zhanxusheng@xiaomi.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:43:08 +0200
X-Gm-Features: AUfX_mzfzUVmf-wXZLSEXAVMnWXEdM45wmk6fU0mb5Urir6FFQzHUYENgrkAI0A
Message-ID: <CAPx+jO-P-ytiN4XHwiDQKftUUgK1-eOw3ristbL+r-WV=KSfcA@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix busy_timeout overflow in ns
 conversion on 32-bit
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Ravikumar Kattekola <rk@ti.com>,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: UbQp-OAM-_UR0cZ5tXVEm2d6G9yTnNES
X-Authority-Analysis: v=2.4 cv=SJRykuvH c=1 sm=1 tr=0 ts=6a71ec78 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=IeNN-m2dAAAA:8
 a=k1ldLzYygzB-qbcyhXgA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: UbQp-OAM-_UR0cZ5tXVEm2d6G9yTnNES
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX4is+alkhgO4O
 5GF7a9WW1D1vAwP2cZgyKKMHS6TTUabO4FBE1I0og2cVNYQ+TPuMGXeKBu5dartvZHUcFz2rNSC
 bM/ErVvkeENXW6+ocUL191FW1NaoSpM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX6J8uB80UlAkl
 ACmYVk8qkARXWIUuPOdqKivw+o1S5umkUrM3FMIoWUH1Lmzhz0ldUBysd2R63Sr8/EbNIvd98PV
 XZRbcxJICSIpwPzcTtLgYayeYVF0xnl6qJ4f2AdGF+Ltcw4PfeHh7viH4dX2Fww9eWHuLEBeTJN
 RC1mwyszryOnRVbgw9g8eVkwt9Jx7tNqx/paHlHFL9D9qOV8JkR8/33Os9ZN/IGJ2m8J/H163tA
 qmDimnGH7zsyUVuEcIdH4gajOtriDE2JW6EpYghTzoN/yaVUFqEVqsAoMDNb8X+Dq11HLU88eJj
 NU96nXX4BwS86KmgoFqIVR//4JdEfCKWc5NgbcV+qDfp7CXGWRu2pz8r2/rsmmLHgYjHdMNg9Bl
 EYQViVM7p2lHHW3/gCZuLolO1kPTm3/lplLKpcBtD9gohbnB9Co0HCClt/Jgy/lYuLbluIcje/d
 HO2xObw227EvmfT4zwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040110

On Tue, Aug 4, 2026 at 4:25=E2=80=AFAM Zhan Xusheng <zhanxusheng1024@gmail.=
com> wrote:
>
> omap_hsmmc_prepare_data() converts the command busy timeout to nanosecond=
s
> with:
>
>         timeout =3D req->cmd->busy_timeout * NSEC_PER_MSEC;
>
> busy_timeout is an unsigned int (milliseconds) and timeout is a u64, but
> NSEC_PER_MSEC is 1000000L.  On 32-bit builds the multiplication is
> performed in 32-bit arithmetic and wraps for busy_timeout values above
> ~4294 ms, before the result is assigned to the u64.
>
> The driver does not set mmc->max_busy_timeout, so the core does not cap t=
he
> busy timeout, and commands such as erase or SANITIZE (MMC_SANITIZE_TIMEOU=
T_MS
> is 240000 ms) can pass a busy_timeout far larger than 4294 ms.  The wrapp=
ed,
> much smaller ns value is then programmed via set_data_timeout(), so the d=
ata
> timeout is set too short and the operation can time out prematurely.
>
> Cast busy_timeout to u64 before the multiplication so the conversion is d=
one
> in 64-bit arithmetic.
>
> Fixes: 8cc9a3e73de1 ("mmc: host: omap_hsmmc: use generic_cmd6_time to pro=
gram timeout value for CMD6")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap_hsmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.=
c
> index 58c881f2725b..3356ac5a1fa0 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1357,7 +1357,7 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *hos=
t, struct mmc_request *req)
>         if (req->data =3D=3D NULL) {
>                 OMAP_HSMMC_WRITE(host->base, BLK, 0);
>                 if (req->cmd->flags & MMC_RSP_BUSY) {
> -                       timeout =3D req->cmd->busy_timeout * NSEC_PER_MSE=
C;
> +                       timeout =3D (u64)req->cmd->busy_timeout * NSEC_PE=
R_MSEC;
>
>                         /*
>                          * Set an arbitrary 100ms data timeout for comman=
ds with
> --
> 2.43.0
>
