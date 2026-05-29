Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB743F4120
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065969; cv=pass; b=KKH6Qv6USGmCoob2FtpXLmRff+RYf7SQCqKVoZMIj1Aix6a0SqREvWNga+Yp3IBWzHwnwmIfjYq5QQp/tGuWHAFAVAtD9qJQjdWpYMCuhxxFPEV2CdF/rCnce5DQmD41O7vfW3R2/jb2AcLUqWDGYvnDeLE6pnkZLovUzyOsw9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065969; c=relaxed/simple;
	bh=+46Wo2GZoRAyM/eIxxUbnARezy4WGv6uK3SLBRtWpus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REaZcfxHjbbmkWRlhccpIwc6jgXCSmyeu1K4//Q/kclVPsrOxDbJdnhgFovyNjDmoHVyyeZgC82yQ7kiZtvYJwvSPMSiGH7mqFGsHKBn+RE0dzYhirR8d2I2aRCKoyXczyLbOJ9UTdfLKt/NQrUooZZoro+aQ9p+HARysKns9jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bmrAqMwm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JSd8h6Dr; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bmrAqMwm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JSd8h6Dr"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDLFGS154532
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NVnvVqedpHFzjCR1x3IYX7338S9xLCWFevBxN0/ByEM=; b=bmrAqMwmXnJ5442x
	LdQYiYvV0Mu3UAKaDm/s9FPnahAC+6gGxAFjKK5lSdIRusgxnXO8RDyWvt6PSDWB
	wocIhYtquOuNAoGXMH6vj56K6m4j0H3+d+HRJWA1JKiAu7BVpmQb8GqaHCrEH/B9
	Fw0kIu+QrZxIucvYa5SZ2+SLbkf2HHyNJH3HJb9li0iZOkF6q9ymsneL1eFaEWU9
	VOpXeOPyoy7wFgFewCZn8C5CggT95eezzW+kwEtsWGN0FHMEXNgGwHFw9s4VQ3aV
	m0y7SD0fBfKKFk+ieGF20wXkZxDma7DkCSLZ4smmDIXXcmS3Sjr0CsNFeJfJSK7B
	gsxzNQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eeuy5c8t1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:46:07 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ccc2cd49cfso56172696d6.2
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 07:46:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780065967; cv=none;
        d=google.com; s=arc-20240605;
        b=HQB0JHEUIUzkCWn1Mgi6/Q6dgSvPzFnAv4WgdZhSdQh9rKMlH/N3W+xhbkwbSaf+6+
         VIUINa1vodVe5kVrJnLUQ4VbLJrNUVkgGs+ZyV/kCrJTXHf5ywnHhiSbc5IsXmT5bk+h
         tBqi4passLHW3JkQaLyZ8MRcLlnuTjjF5r2hy24oo++dyxW/NIzkPQOWgJ0Vlb2xIDp0
         KWqHk/7ahLTUkuvWy+NqdVkq85fdocsZAuluDrI2s0pcL2yuSKQZ0Lgy2DRazwKWjif9
         zrIqhnZrhvLOMrRpkuUb2KwllsnOh7luHs1a/htCIF+MJxSmVKkFaU3g3YJLznP6PSHK
         L5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NVnvVqedpHFzjCR1x3IYX7338S9xLCWFevBxN0/ByEM=;
        fh=4k1T1AeBNuKHwVwB/sGnw/e99B9ENJqSiFqIrjJySVM=;
        b=imo2BZR1Y/0CsQ8BkpIzrxt8pip9Duqsilazv0BYjuR13qX5LiyTPXFQ1vHeX7MAbZ
         VmyP32PaJ3MVqPRJ7NMY0YnUQkyzv0+BaUjV1JO5BWFyTCGTkd5OiGjzxK1LJ+lTueDC
         3YNKXg/qq2dgfunPHr9AO3v14UUHxQe0j5yS0gToUQ/gofwEvvqz89PB9sjLF1w8/dLH
         FxVXqfrBeX6Y+dDoMIHfQX/lrGZ0dtuG27wPZ+0DiWhqxOgeBQWd9L3wIG8weNeytf45
         XM8ma7bsBV38uqWCY5Of23kv2WkEJ4h7BAmRsJ1qBhu/udmr/lkdvs7wVUQeBtyM4+1N
         lS7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065967; x=1780670767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVnvVqedpHFzjCR1x3IYX7338S9xLCWFevBxN0/ByEM=;
        b=JSd8h6Dr5ttoeNa1VTL37zCq4J0hnxYiQg7mPU9TvqctNhWpukYPAbSny/b8Xtr07F
         giLgIE0d8L26GR6i6fNo+2+LuvfF+TFH5juRzUQceoQtJ3xDyzvDVGjZP9cHc0UMHM8z
         TBpaagXtyxGJz3oB9HA7YQEzoQ1SG9n7XsEUQwUoPr3NQ225Scvz3F3sYnsBIX/HFtFi
         YpHtD/3LCnxZoC/acsOBudcW3YEHAGKM+Uum1DiviSxDqgtpQNV1RdkOXcPenuilPvP4
         /cuY6nI/Tc58NhjWso0nuXVMjWoCgNC545YL82abjb/bDTJEspGJm5mYdRo3plCbdY+S
         dVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065967; x=1780670767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NVnvVqedpHFzjCR1x3IYX7338S9xLCWFevBxN0/ByEM=;
        b=o5IrWnrqnpa1qdLKWGPeXHJQcQ2yQeSFmAMDgtVyRrUi/Mlq/DIP10OFxBSqLxOUbz
         S7qcgXw2wmuk5INvjkVpcKh5oJ5K88XM4s9T2d3rPk2q7HMt7LJ7m3dq1FB+qGl+QSX1
         Y1eXFJg+7xmW7ujci2DvJFn6E0xCml2N0yplTjM3LfSh16bt8pzm+WOeF/qx7WXXvEmK
         QxXmH4OAHMWYAWRZUzjy6uXBvw8E4XWA5UgHCUI2eoRqap+5X+3ulAHwRPiM0X7jFwQW
         EmFJQ85JS1WmlCVYAjFe/0YUyYIOjZIRHsr62ZWXupMf+VCoSDIo1VM6yhmlX6lVWpRc
         a56A==
X-Forwarded-Encrypted: i=1; AFNElJ9jiuk4KN7Eal494pD/SMnWGl7oNkbi72n2+0SWylwXGm//bAzViI3Zpwg8fzeScg6/wqHGZ/jRL1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP8U3/U3Gt+ZHbgYFfGJZ18/1rYRJgnURJC1BWUuyYm3hl7Ynz
	M6a1wOnxDD6uauJWaeB/yBYfnfyCDGKyUtFDx8VX0mjrTZdAPpJpqBRv48vcyLw3CFkTO+mJ3AS
	V5HgKKa23S3IAsUuopmXxUgjtAQyAOfjuYu5+cegFce5r4Crf8mX4mhkXdXAihLM3cC1HtXeUX/
	N9toz8u5IOHCHQY/n8GTQDC5A0yiNu6fG7Pw1v1g==
X-Gm-Gg: Acq92OEqTGMpIEJ34ATwFWMTXpb8GaZD/TR36WpgRvtezHlG1euLbMah2U4LZJufKEm
	aOvgfpKhJQOKaxRHaDw+J74Ba2FkNaoXaWyaRUj4sFoeAHIhab8wj4boc2xiqDlllE7WeiNEiiz
	ZDHtzy6wZ99k7uBS6x/JGYh9aE46kGbAj7iQehbbIH+wRxXogQXQpEluw728Q0VkpzDeO+kDiYj
	7YNaFD5p86eVkxFiA==
X-Received: by 2002:a05:6214:518b:b0:8ac:b48f:9fa4 with SMTP id 6a1803df08f44-8cce82411e5mr40909766d6.35.1780065966454;
        Fri, 29 May 2026 07:46:06 -0700 (PDT)
X-Received: by 2002:a05:6214:518b:b0:8ac:b48f:9fa4 with SMTP id
 6a1803df08f44-8cce82411e5mr40907666d6.35.1780065962073; Fri, 29 May 2026
 07:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524023455.17677-1-jszhang@kernel.org>
In-Reply-To: <20260524023455.17677-1-jszhang@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:45:51 +0200
X-Gm-Features: AVHnY4I-okvIYoX9Qg8GS0DREy3vZ3BBL7stxSQOWgQyhVLZwVi8zR_EQ_m7oyg
Message-ID: <CAPx+jO-BN_b433pu4UTaw=EAQHQ4urCvPPkCBr8GGi33naLePQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci: add signal voltage switch in sdhci_resume_host
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=SPtykuvH c=1 sm=1 tr=0 ts=6a19a6af cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=2LIcmEK_DWZZZ7vkfIwA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: Jx_Y8UPmUOFpgd5SYhNymMlg5pok8QWK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NyBTYWx0ZWRfX3WOaOo0De+i/
 G0+Oiek8LILH9UKfSa8GZoTEYxXReeDkL+CHxtL5DqTWVdMSBI0kOnfn/9Uy5dFckaCRtwJyn+2
 vjS9vBF7W8+TeXpOsdereXqDaoBnKb+WTvnX295SSkaNPA2Z7PA7zHZbC1JHObrFj1dFvk6xMD7
 tvkxW5gfRyjtyhPSTItmV8ezU0fuPeQPDwNTtdVs/UtU3rMmqi2B6ZD1ST1hPbH7/Pjw0NECIf9
 jY+HCB5++IghOQ2wGgXBxnTOrXoiLMxx9TmN/7ltXBi4SJ/nPKiFkrPcT0lPuEuE+iC5YM6Jr3m
 17rf40fW1ul6Adp9A9CoLkitO1/3cq9HndnyK/4pFn6np7QudvTFFvRarPf6VifRJ8QFZgcGU8g
 K/bhbWXEuxQwiQWV3cyc8kEGuWMQRHrGGHO5fW11MaQqJAdGvAZAeUWraT8xLvsJ0QkOBAsY6Gl
 TyveJFT28jsco91ts4Q==
X-Proofpoint-ORIG-GUID: Jx_Y8UPmUOFpgd5SYhNymMlg5pok8QWK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290147

On Sun, May 24, 2026 at 4:34=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> I met one suspend/resume issue with sdr104 capable sdio wifi card (with
> "keep-power-in-suspend" set in DT property):
> After resuming from suspend to ram, the sdio wifi card stops working.
> Further debug shows that although ios shows the sdio card is at sdr104
> mode, the voltage is still at 3V3. This is due to missing the calling
> of ->start_signal_voltage_switch() in sdhci_resume_host().
>
> Fix this issue by adding ->start_signal_voltage_switch() in
> sdhci_resume_host(). This also matches what we do for
> sdhci_runtime_resume_host().
>
> Then the question is: why this issue hasn't reported and fixed for so
> long time. IMHO, several reasons: Some host controllers just kick off
> the runtime resume for system resume, so they benefit from the well
> supported runtime pm code; Some platforms just use the old sdio wifi
> card which doesn't need signal voltage switch at all, the default
> voltage is 3v3 after resuming.
>
> Fixes: 6308d2905bd3 ("mmc: sdhci: add quirk for keeping card power during=
 suspend")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>
> since v1:
>  - add Adrian's Acked-by
>  - add Fixes tag
>
>  drivers/mmc/host/sdhci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 605be55f8d2d..e3bf901b10aa 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3836,6 +3836,7 @@ int sdhci_resume_host(struct sdhci_host *host)
>                 host->pwr =3D 0;
>                 host->clock =3D 0;
>                 host->reinit_uhs =3D true;
> +               mmc->ops->start_signal_voltage_switch(mmc, &mmc->ios);
>                 mmc->ops->set_ios(mmc, &mmc->ios);
>         } else {
>                 sdhci_init(host, (mmc->pm_flags & MMC_PM_KEEP_POWER));
> --
> 2.53.0
