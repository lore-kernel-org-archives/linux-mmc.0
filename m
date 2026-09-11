Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3679735E549
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138166; cv=pass; b=i74fDtXIFy2mQ0Z/FfJPlGZKprPF2Rik2+cXzaLqIupMTVn43JG2Sht0ZC1kK76pFLAkS17ybSuDr+MbvS+qN17c5dT3v8CGK+O8aY+bAyh8PinPvFQvLvqsHG//wqYmyXku62kwICR2Djz96Rf/J40FYoJuVJ8oy8UBNXE7KuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138166; c=relaxed/simple;
	bh=m872b0c2+jN1AVrAPPxqpCoSml3+3YNDaRJrpIv899s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G820RUnXw3oVyPp3jyOD5ZBSyJO5jjSa9N4LBIRi0gNsmdMg7mh5gtemP55b/uVaXTQXN7Z23rPSdSxtOuEDKWNg5p+F3mvem6uWfSfBm0OSrXmLNNZJyRY8S6Qfd9nHvsv1KZu/mPki4YM3KaDP1SYXwuH0XM+9Pd/CJTtTXys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KffUmjay; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mz0bmPDK; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KffUmjay";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mz0bmPDK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEmA1g121307
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 14:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wI59Ig6wXv5MiB372ZI6ZUIZhW9q90Tp2bwYroJio+Y=; b=KffUmjayb/CgWQc8
	yw2xlLfuDeDIBenlL1tENnzsxjWsdxpZQzPMA2pYpHohHwmft6KNt6k8Na5L3eiL
	YJPxWuprhKITWGs+rEm0Sii4SLJiw2ncFIRoDzqpkG2OlsOAKT+3BSwLdpceREEo
	6ZFC2lxJFyVHKG+8txgT3COXqvaHi73oDs8xMo4cUgL1cIqNqgqD/znSJ1GbNsx8
	n1FtxGfhqm8EseKLvhrSjYmdTGwYIP3iJMMDP8p8w1D8iVMr/WunmD60k69sy2Zy
	+mr0sF2kBGJiV8q5G1Pdl1d13TJh5cuJMo2hBUfOivZ9WfjffMvIzqYafL/QDa9R
	OGeHKw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm1k2cea8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 14:49:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so838996a12.3
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 07:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789138163; cv=none;
        d=google.com; s=arc-20260327;
        b=pd8Zmh57Z/cqdATJTC6I10UL28Q0JEGwY5rFFohpoMJFheUD49zHaD8qJ2/D6WyjIF
         1z9PEBroBECHiEU/DwwTOMp5KH2JbfUszJafbK0MLIgvMg+Nzvzdsc8FdSRwQWvpERy0
         UcwFTC/97BblcDsklzCPZZpZd6AhE/0aOXVRB7y6UQsXe4s5VmwY8IKNKkIBmPZVW7+1
         ai+8P+q/Xo6zl7TBiJr2CpFDJ3Ww4fjH3X6nwpl3ZRMhC8uZtCjMCP0EVIzYyfoWkYot
         d9nZyiu4DZUMpMu8MsKKh3uvgJnbnKeRR2NPc1HTFBVEpyzefjIGx69ubnNHGBs85gWL
         JSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wI59Ig6wXv5MiB372ZI6ZUIZhW9q90Tp2bwYroJio+Y=;
        fh=PmGHUZ+qpHFeIoQgMHHJkSCcgbHThy/9Y69GKZYIjpA=;
        b=exiXlycxZNR+FnLqGcIqUoG6kMSSj2uJFpf21MGosKzLMcJLdw2C7Z0opaU0F6Sz6V
         zG5ea0w1S8d0DwCqJWsDPFRzDz3/a9NrgkXrIWBCEydrUSMS/Cl/dMADxIobr5Bne0jR
         bkuU7AyRp3QMagdhs0XzPhycxpqBZlT6vpKCKcHK0Yt2x1dsalQvAeBsaPtcl+gMEmlw
         ug4cco3O6MZjLbFBzsMgiBdfvOiHDjOgVgTDvyo7Xnw8txrDYpVFeJ09iom4dPRT/4Sy
         37T22dXpcIp0f41F0h/3RxR19XPOoX/HQQrbC6ffBPIpbRl46KzCm+sg9gPVN5vfInFe
         Aauw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789138163; x=1789742963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wI59Ig6wXv5MiB372ZI6ZUIZhW9q90Tp2bwYroJio+Y=;
        b=Mz0bmPDKNIIb/5up7HkwiIzNBg0xVhScdTbWoeo9fBniTuKFJFj5JpK8mSpp2gEEPx
         2yNccdBIGCVFyiX3H+Yp6loVlVI0P6oNuKQSLBf1pHDUxQqNfBuppjhx/IXFQ6TnEtHm
         ++QUpWrIc0rsApn+T6XWkk90Vj63OZvxQi1X19D9bMCtmILl2dJJcp5lSQYmTnWH0X+L
         LwXMCyMkiFaIc2iLTA2Ns17rG/8d8wHIpOGXgLSxC4fovPCsiwBKCA/u7K2uOrxBtIL4
         ygauNdN1o3NV7WvwRM1c5BuEL6tzBwj4kxV7BZrs0XXOUgio8Q27r5RfE9W1/VJdI6pr
         60cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138163; x=1789742963;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wI59Ig6wXv5MiB372ZI6ZUIZhW9q90Tp2bwYroJio+Y=;
        b=rJEsc1sPo2ZcOqu88HCG29Z4kqF2LOSKxULM7Y7vDDaCOqYWg+xG4QH75gch/n9zzX
         JsGROy28j4GHVytgHYBjc1zwE8fP7OLyqiTiDsFijd8+tPYpm1N5g+LT2R+TkLBeM7aZ
         4RvbPhHRRQVXBU2+iGh6MKgt0D/pYId/H5hFlZn164jxFsvdJXUPYSvwzTOymVGA7QK8
         SG60Is2JBAjtAhy+Zo42LogsMrsmcnIkk7IWkWdEQWUnSpcKmMhZo4+IKDTpuyRMWFlp
         NP1XAl+UqyspEUU1zzaNeh7m1ciR8KYWqTGCFZI/OSLLKWfRcWOYjNUOW2bVCP8/riat
         Fx/w==
X-Forwarded-Encrypted: i=1; AKwUvBzEw/xmgQ/OwVOc3LZPaJXTRYDJcBZMI/0DBqhEP8Ssxudb6VSKIpE+MjOMiamvlmg7HCBWZe5MnpE=@vger.kernel.org
X-Gm-Message-State: AFuF++lPxav9ESR0Qv5g00tGxr8aJuGtSKtSiEQ5TrI2j3lxUlv9izJj
	LetfZErR9nQY269TnOgpELlEAQWR8xh/j1r6JNcIjGPI8tg33KzuCWCN0aSrh51MiHX0eRB8OJg
	GibXFQEpdyFHZFz0mN6RVPyjaS8+JPL4Ck5fm9ONWwKlZmLL5f7yI6b8dMXLXAWG5+nsMTQPoqV
	SQfMNcbdJoX+GRmeJeBA3B3P5XLkZ8yDEo4OK+5MfOVXcRow==
X-Gm-Gg: AYBFou0xXmRbFJcsCAtES4fpY0SKo23YEPf65mi2Ie+q4lWR5sdNmByIjyqY/gr7bi2
	QSOTuC4pdAcHpr5VTMpJ686UQrbMCMxXQ6bvn/oTvyLqSJ/RfJZMoxrVgUthOxSOybxGYXjRVoy
	YvuepAKdAmErh7bGLY3DzymaQeie7Sxdp0q3T9uOjPDEyfRs79TZv1T1L0+g==
X-Received: by 2002:a17:90b:570b:b0:398:9be9:ab92 with SMTP id 98e67ed59e1d1-39d9c3521ecmr7776820a91.23.1789138162575;
        Fri, 11 Sep 2026 07:49:22 -0700 (PDT)
X-Received: by 2002:a17:90b:570b:b0:398:9be9:ab92 with SMTP id
 98e67ed59e1d1-39d9c3521ecmr7776761a91.23.1789138162081; Fri, 11 Sep 2026
 07:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901044054.346524-1-hrushirajg23@gmail.com>
In-Reply-To: <20260901044054.346524-1-hrushirajg23@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 16:49:09 +0200
X-Gm-Features: AcwNN1VmOyw7Dk484tfmp9gq84sBGFP7-EPIrqoVc-KnAJ_XfthdFn7XfcHICBE
Message-ID: <CAPx+jO95bxEi-V463L7sZS-uxVaET2FPd3Q4AXNty=VhGxewzA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio_cis: use strscpy() instead of strcpy() in cistpl_vers_1()
To: Hrushiraj Gandhi <hrushirajg23@gmail.com>
Cc: ulfh@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=cM11IVeN c=1 sm=1 tr=0 ts=6aa414f3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8 a=JhKy0a8qOCa0yG0nV0kA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: y6AyrZaGRcc3PyZikb1pGOnUJDA5rQ58
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIwNiBTYWx0ZWRfX1Zxt3TwNElpA
 CLPk9geiuhgh1Qx6X4re8W6FVkIDgc4hPdjZTGCZgB5vEHFsX8YecHBCowxNYHeq30y79M9wHlw
 6JsIHTDyZ2TeG5efstbsxCBKNIeZ3zo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIwNiBTYWx0ZWRfX/4Q4+oROpZdl
 06UIEAyJU9EEYInB0lkgSp7k8Wu0bxXdoS98j8RPyfbRzrpCWckv3wRfg1EvGhEtNPFdD+W91wg
 swdy3yRfUF4J3l8OL4D5836MNqOkxf249BsMGiMYYVm3rlN3HaSV4XzC7Uz+96+MKabPW1NG01q
 p7tHD7n+DgQ12b47UUbxzYstv2o9nQzb63G+6pDJxUIPS0cCbUlRCFnqRA0yFa7YNdRwibjZjcB
 VHvaqrC+k6OSOm1i9JcjHbh6PtWolow60DN4OoThXL2pmb67oSFSHo8oA0Br875grJXDT/oUP0u
 LBih/+3oZ15XrzigcbaLkTVi1Z6kqMm3lwLPBRabc8Tgusjn8hlolZ+pt/mjBEiz3ZWJiVeJg/D
 feaXQ0LNhfO6tde+Njh62R5z7+TnviuKB/hMdzcPcHfd0DwkdzdXrBWftML69+90Uzzz93RpzzG
 Dzt3HehGGPddsIzD6mQ==
X-Proofpoint-ORIG-GUID: y6AyrZaGRcc3PyZikb1pGOnUJDA5rQ58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110206

On Tue, Sep 1, 2026 at 6:41=E2=80=AFAM Hrushiraj Gandhi <hrushirajg23@gmail=
.com> wrote:
>
> cistpl_vers_1() copies each NUL-terminated string out of the raw CIS
> TPLLV1_INFO data into a single kzalloc()'d blob shared by all of the
> strings, using strcpy() with no bound. The strings are already known
> to be well-formed within `size` bytes by the counting loop above, so
> this isn't currently exploitable, but strcpy()'s lack of any bound is
> still worth removing on general principle.
>
> Track the end of the allocated string storage and use strscpy() with
> the remaining space as an explicit, always-safe bound instead.
>
> No functional change.
>
> Signed-off-by: Hrushiraj Gandhi <hrushirajg23@gmail.com>

This doesn't apply on my next branch, please rebase and submit a new versio=
n.

Kind regards
Uffe

> ---
>  drivers/mmc/core/sdio_cis.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
> index afaa6cab1adc..24f670a798e2 100644
> --- a/drivers/mmc/core/sdio_cis.c
> +++ b/drivers/mmc/core/sdio_cis.c
> @@ -27,7 +27,7 @@ static int cistpl_vers_1(struct mmc_card *card, struct =
sdio_func *func,
>  {
>         u8 major_rev, minor_rev;
>         unsigned i, nr_strings;
> -       char **buffer, *string;
> +       char **buffer, *string, *string_end;
>
>         if (size < 2)
>                 return 0;
> @@ -57,10 +57,11 @@ static int cistpl_vers_1(struct mmc_card *card, struc=
t sdio_func *func,
>                 return -ENOMEM;
>
>         string =3D (char*)(buffer + nr_strings);
> +       string_end =3D string + size;
>
>         for (i =3D 0; i < nr_strings; i++) {
>                 buffer[i] =3D string;
> -               strcpy(string, buf);
> +               strscpy(string, buf, string_end - string);
>                 string +=3D strlen(string) + 1;
>                 buf +=3D strlen(buf) + 1;
>         }
