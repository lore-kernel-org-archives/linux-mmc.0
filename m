Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A28043499F
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688856; cv=pass; b=oii5KZ36KqFjo/FwlGARLsRS0eGpDefSYmULpGiOsH8mt8rA9/Px1o5lYbD9Pm671QJQ+Xh3o7HPQgfnLmqVVYhvwAtvIdjbmOLpZ2iITz9T5Ii0mPHSXy9EbinzHYH3fosZobDM86dgMwr/vEv2JdjCz+7gMtSs9vPyhuv06I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688856; c=relaxed/simple;
	bh=YoGSaRaJTMcQ+m3/DeyAZMTO2MQHhdeZBfTnsQKrOxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVhdlC8WonlsSDh+I3xzvbmxe+VOvJFuxi3gxLJ1KQBCEDJYM4IeFRBOSiC6buczPSJm5VdPEF2xXASvLDvE6FXVA0+HEaQlzTD0lJjAsniZBX5wGHgeDhBRaUa6ZH5FGKsGgFXdXlyW8Gd0Bb0G62zgSl+Gtl/4nxzwv0VjG6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OgmStnqc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S3/o/zmH; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OgmStnqc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S3/o/zmH"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqhXD1477045
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PbimJkO6iOoejrUdihI8epYoUEux4ko+Bcbb9LWQp8Y=; b=OgmStnqc4h3SdKeb
	MfTOJ4Rw7tSA9M7C6oAs96swDBny1ayH1ECRE8wqdeCLUMHB7CJyAzVEGcss+XUN
	0uQW08oYq5MtsWcfGysDJBCAlnm1Al+Vw65es8dykz8lE5G+LRlwdzHIghaA93zc
	kPlIXURVMJEK8LzNVEvLWSgEOxFZRK/COEzy9ZIyW6+aBG/EzpUkbix1ZSOns77T
	6wyGlvMquhnf15BPFOeT208rQgfh6cPqhc/LtL7enO1tOrK0lLqBN9ny9VPwALT+
	25n2v/Q52hMJc6yVu7l4P9arxoK+oHzne+GLCaT4dRtWOzurklN2ECWqPM3oCdYJ
	9SdQNA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyw03ma1k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:13 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-86a2639398cso6014467b3a.3
        for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 06:34:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790688853; cv=none;
        d=google.com; s=arc-20260327;
        b=SEq3auGpM7VMdPeVNmNBp8eBow2YzoDdahw5+2ERAIMPh/HtW8X1J4eM9jLUs8dhfq
         WEnUPslouqsbKTUxRKN1qEN80igwwCmEXdO7y8L3Lq4H/qRfeaj+GqVjUpzbLc6OvFdb
         JlvmuYe5MIV8jM7F5QGdp2vAzer9ix0ue3fHliYf4hIH0Rl27UxEmpLQxkTmOzS4Z2Ik
         HfKmCLrSwF4mnFCgYfK5oKW48tGWwVX2wOAdnUWslpGYltW8WPBbB0gB7RbjMPGbCNnx
         e0vfNkbUJAQC/hGOpGZcNLGYrDs0ZLPKeVbZPZzVyGxtl1YHm8xvqxyTjJkwC3wge46N
         J9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PbimJkO6iOoejrUdihI8epYoUEux4ko+Bcbb9LWQp8Y=;
        fh=KY8+eQep3rNFQKydS+N/4uj8BxIBlI2zHyUJRhpQHYw=;
        b=LukT6IqW2lxZQw6GwtXWcT6IgFVMCNS4lSUJbguFZqMU1ejdlHHegKVHyUbuG3Vlr/
         tKl/IsBwMjOY+aTA3iwijdqxdfey8K5ur3C/d60yb2X4RwPfHRl6aitipljuSPp0krcZ
         joU3HwOtHC24Br9Vhq9eupwpaEgIPPsqc615yFm3yXZrREBYLJOMNj6xfIIrFa5Q8wLu
         wZUXotASQJLs6o6yCd/tjWsz2f0SU1YDSQEdxspTGKUJvCfWAKUICfRimq9WTA7XvmW4
         Mxd/J+ZX1+Hvb5HSWsxb5MZVMMMNwvmgvc3E82iviUrdroErGQMNC8YaKKniP9lAYQsa
         WpMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790688853; x=1791293653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PbimJkO6iOoejrUdihI8epYoUEux4ko+Bcbb9LWQp8Y=;
        b=S3/o/zmHvEQ3g9yO3OqQ0cDXQe88eqePoZqMS4UgqZcQorgn1A4gog7uXPkW1y6Qht
         KZMm8dWf2Esg6/LqC8OKJ37+xGd7cy1QGxYylv9Psl/twjZAGh0nBSJ1eZJ2NscgU/Iy
         3Z5clQJq5FMJI71eorVS0wHjXEqdWIJPc9+ieZuFsy+UAYqRhp7gC5lZGY/STOauEW9/
         zO0M0KjbqaZZX0W145mAVAftra8cQgCH6u/mVhLK+3z0hTRCjdSlx0D81LRHmLhvJI7d
         NUNnsVur+K7g5Q+OY6SbrZcQeICAAMlosBcGqU3Q5H+WW+pvcWFAV3O3+FgZqBDlr4m0
         OJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688853; x=1791293653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PbimJkO6iOoejrUdihI8epYoUEux4ko+Bcbb9LWQp8Y=;
        b=gST3xMPAvvVRW4O7+4oe8d69jhMRzJSoyZUjFf/rEjf1oAd/WpBmw9yp1Iui238VcW
         HpNHaVD4lu3iEistibXKyyOXu+xlp2asC+T9uf5KsW9GpdQx7TWPkDZ9OwqbnTDYcw1k
         K9xRo4qBVdBjLJPjVZSDim7y6tInGJ8QMaGKrOs1lgeegvMhTPdDIoNDIXci4MPP2sD3
         mLHCg7oHIa2OafpyGRAzjhqR7bm+I+i23hON5DjLVh7pGFfodHfMN8ib1YW6byb5G1Ro
         FxL1rSbHf0ho2SGuV91Oo4gSGRSWrYAhZwVh2BtovkP8mntYV3UnmgDL+FtTeD1msyVK
         /ywg==
X-Gm-Message-State: AFuF++kMBISX/QIJE157WZS1sIUlT+R202mVTlVErEhQskLNQVqRV/cN
	fShRB1Ecr480W/UUrZm7bFdYo1Nlu9U+sUnguWpcvyxeVacjsodp7uzQMkcJY83+3/xtv7QR9zt
	vuq4ek0c7tOnQyMu1xPgHKpgru5woBTOtsb+p8kiFJFBVUx76KGqj1eQNOSWMzIpvImn+b9IO/N
	oI4sasn9V5tgLhM2LrxP/ZMvckB5FYDk2AA9V9s5FWMqDaXQ==
X-Gm-Gg: AYBFou0HC8EkhqLfanXTnMT3QXVZDcz9IR8PxQ7Ni7n4oca3dJADnP9FNCdiFmLFZOV
	tvUFAe9RNthVpJo3NCkCY9MLv0V7SprUWVi+GYfb1ePsWlQC+6GIbpxlS5/2WJbkdcS8JPYaBlQ
	j5RbMLq9dJ+y/8xOBekjlDsB1dSlEHLl7wXKMNpFRz0QBbIorIO2EM48wp2g==
X-Received: by 2002:a05:6a00:a83:b0:878:34d7:697b with SMTP id d2e1a72fcca58-8802c46d6f6mr10122257b3a.41.1790688852684;
        Tue, 29 Sep 2026 06:34:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:a83:b0:878:34d7:697b with SMTP id
 d2e1a72fcca58-8802c46d6f6mr10122234b3a.41.1790688852178; Tue, 29 Sep 2026
 06:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917104959.662433-1-ag@ffroot.co.za>
In-Reply-To: <20260917104959.662433-1-ag@ffroot.co.za>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 15:34:00 +0200
X-Gm-Features: AclHuK953rFaHLBDPLbS5eTN48EJNCBOQ393Rp1dm1u3loV7lLXW7Ib6OX9wUpY
Message-ID: <CAPx+jO-pyXAPSvmZWEHiaWPnc3N=91qebdh636fD7g8rNBgaEA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunplus: initialise rd_crc_dly=1 for DDR modes
To: ag@ffroot.co.za
Cc: linux-mmc@vger.kernel.org, ulfh@kernel.org, tonyhuang.sunplus@gmail.com,
        lhjeff911@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX3Up7N/3C/bEq
 3HiZaA3gA7LAbqydDgfxKsQ6K/ZtUj2g/aX+zlOXlCx+zBfJd6DMSezU2vPzG27Dh9cQbSsqnCV
 EQUHwGgK+EMkxuVtB334vrpwWVf8TY8=
X-Authority-Analysis: v=2.4 cv=SIbXx+vH c=1 sm=1 tr=0 ts=6abbbe55 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=3pH3b8UoZ_SLFIxPbvIA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX03MdGEZNsce9
 72OHicxTbkCmKW41jufPlgBIyOliaqwkAwVP1G4KBUmm6x1pNu7ut+rI4tQUAnQXvMTLv/CqLq1
 +pMQUM0FcbmUkHDTMnRj9r2gxWI9JEXe6NwHgI3yoS963ITcPb0vl5x6SOivfTKmRtsTQG92xtR
 TV7TAqeIRyDGn40f9XNUk+hcWboAdpNLPJeXV3s5jBs94SDC9qcttxG7s5ygikAGn+pBOq3wKCw
 MnT+X1+kjF9dPYCrgnMxVR2aGnxPXxaYOBcnGp38kAqnPGlS24TyBrvfnqKrMK2IONIcnkpCAb/
 vqgUiQOOMwUrQ9nGpSIDTVn7l/kfnYh34gjPSrSb2Qz9l4Ta+BZyOF/nZO1//xFfkcBVPjIfJ+T
 K585ixMWSW+W51joqlrIwfdLmnJMIIR1irTzwZsWCOB40KOCvFnoqfXBT3cLctnHPqVm9pyQSrD
 fO4dsrjucPHtjcRMzHw==
X-Proofpoint-GUID: 0czyJMAOwUStV5aiM2CKIaJeWk98GmtH
X-Proofpoint-ORIG-GUID: 0czyJMAOwUStV5aiM2CKIaJeWk98GmtH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290054

On Thu, Sep 17, 2026 at 12:50=E2=80=AFPM Andrew Gaylard <ag@ffroot.co.za> w=
rote:
>
> After spmmc_controller_init() resets the controller, all timing
> fields are zero.  The hs_en path initialises the write timing
> delays (wr_cmd_dly, wr_dat_dly) but leaves the read side at zero.
>
> In DDR52 mode, rd_crc_dly=3D0 causes the first write to fail with
> CRC_TOKEN_CHECK_ERROR, triggering the auto-tuning retry loop and
> causing a multi-second delay on the first cold-boot write.
>
> Set rd_crc_dly=3D1 when enabling DDR mode to avoid this.
>
> Tested on a LTPP3G2, booting via eMMC in DDR52 mode,
> on linux-next-20260915.
>
> Signed-off-by: Andrew Gaylard <ag@ffroot.co.za>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sunplus-mmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mm=
c.c
> index 63279760239c..e947c84eef94 100644
> --- a/drivers/mmc/host/sunplus-mmc.c
> +++ b/drivers/mmc/host/sunplus-mmc.c
> @@ -294,6 +294,11 @@ static void spmmc_set_bus_timing(struct spmmc_host *=
host, unsigned int timing)
>                 value =3D readl(host->base + SPMMC_SD_CONFIG0_REG);
>                 value |=3D SPMMC_SD_DDR_MODE;
>                 writel(value, host->base + SPMMC_SD_CONFIG0_REG);
> +               /* DDR mode needs rd_crc_dly=3D1 */
> +               value =3D readl(host->base + SPMMC_SD_TIMING_CONFIG0_REG)=
;
> +               value &=3D ~SPMMC_SD_READ_CRC_DELAY;
> +               value |=3D FIELD_PREP(SPMMC_SD_READ_CRC_DELAY, 1);
> +               writel(value, host->base + SPMMC_SD_TIMING_CONFIG0_REG);
>         } else {
>                 value =3D readl(host->base + SPMMC_SD_CONFIG0_REG);
>                 value &=3D ~SPMMC_SD_DDR_MODE;
> --
> 2.53.0
>
