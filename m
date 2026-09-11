Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7AE48E0DB
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141239; cv=pass; b=k7v25IRbceQdT4w6Nc7ePK0Y7Tub9pkKeVE/hPZMvZJRXGz5XHxBczWYfLnYRSSwRRzK/AGSbT0WwX3M/9c/LWYyrKrtrZCkf0xwRoYSQrkRNjkS4GNsb58dJnmPkjDF/3EOMaGAVgyp31mFQCu9EQFR+Ebw+DqQ+CEJlpZaoK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141239; c=relaxed/simple;
	bh=HAP6L74icTVzJ0dCR51FcYzsHJGr69hg5OgHxlwgWdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClaVYhCicwdAC6heFcV8llPHMKNrKZzQLdnB8k/JE+Zf06FVOHVLhWH9KjVXWrnaNX+qLe1LZgKcBptmiGBPj8hNawiC6OR7Fi+ZpiIBsGtZmy2RHwuGP/rJUWYIE6AEHIfn7yifC20nX5SEoDv3Jsn1sEpiPx8nIuvHEZIbHFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dh7vnSPq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fRdwrEMw; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dh7vnSPq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fRdwrEMw"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEm2Eg3748747
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Jan21eA3GyUwCuy2Q7YzdFAzmFXBmSiFZ1DmXstvho=; b=dh7vnSPqtsWxaE4+
	Ps2tqSHD+ZRoYBXWMZfKClD/YHgyL761YpgfqBUNstGdgSJgg1q30+Z4zFOmQ2L7
	tOWhn8ymdGkTiaq1HDwgjvv25nsxmxGVVxELpqgm7WVJYkB+NSpBdwONh05ppIDB
	CpONodGUG/NPr7U6rjNwmor42oS3PFUkGLydSPTbLJk1e5mDw+we/QliP+BRVGxi
	gcDs7XNQkQhjlonuVMczBWnyKW+V1iFp/17BZ9jXmn+M/g9qC4hfXsuFuhwn/PdR
	dQpE3cS4S9VZkMyIZozlI0gboc6Wz4YzoCx/0nbcJmp9d6NcH6/J1upeO6SyfUT1
	/sbabg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm729kfwy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:40:33 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so879459a12.3
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 08:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789141233; cv=none;
        d=google.com; s=arc-20260327;
        b=jWLkilvwP80/3lMrHXB5DEIlmOSs3BhvQXffM8B3F9Y8k38D/CYzFMwLmiugdM17EA
         q1yT0xAH5TYFdgIcygltnaKI73e1u+4PTM/feULMGN4/KFQ6kdHSIKo+I/yIVS5nQM9M
         cK54Xx9S9A+WUeztrU2KPw+g1mae26XAjrrFhqr/Wa0sD+OrGVhA/BZKGeC1PmurSGeb
         te6R+G3VJXlNmcWoL9cLqsVN9TM1hMPUXj+ACGtHznP0iROq5WPaIvI/09MbJUcuCFnC
         COhmDXBvA77xr7eymNzrCRrS5DQAroztyx7k/BNrNAcjrzm3HED2t4wrXCD2qPvyBbiv
         77Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Jan21eA3GyUwCuy2Q7YzdFAzmFXBmSiFZ1DmXstvho=;
        fh=wsuLGeudIYhXEgIea6hGg5bIQv9qlTATMcLcYtBFUMQ=;
        b=dC3r5GrCtTsluBNBTP/1kp8Rr3QP1ypUhpk3uT47B+V+shONPIaBM0Z1P4W6QCBvph
         QjCyilPY98mMFy/SXpcQCckZ79BHaaHqLug+8U1drDg743GcODiLkMUvhXEsPrVflJsc
         k1dIgOQhgak5lzaJeLiDoVCIzBLrugUwuQ8ooHgGFyXe1bc+svWHPQw5rr67KjQmehjj
         cAkvIxsU74WLHZz7VtpQXkKKKpXwKZpJ1kKL5iNAVkMOYWq1ptLBw4JCzHaKovaJK0U2
         KQWplMDXKpmBMdSEs7PJ8Vuqw71rCVf/VWrFTCUhZ+0z3Yy3dhwlB64r5VXGrUg4wOrW
         kWvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789141233; x=1789746033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Jan21eA3GyUwCuy2Q7YzdFAzmFXBmSiFZ1DmXstvho=;
        b=fRdwrEMwGBBHEZ/fQMmKs7g9k08ibdPNGvJyhjKQ/DXl1abud1HzK0ZfpSi1ZITWA1
         5en33W+OuUxC8c5A8rpSV6FLPxMwUOnFicVckbrJiWuis10johrbDCIRwSOA3MMnK0+I
         rstQOtcOwAZtgMfMyuS3dj+GgWxYuNRixtcOw+4ZRuVmbloFje8oNAs3dxVbvHXU7nU4
         zfnSFrKHHEz3Tw5oG3KS+2cSKHs56EEQyyLaZ1P85Fk0EJ3qvmcNeAaw5ARuNdGmI+qQ
         1tsE5duzHCFn684AdlWb/srK+sgl6WDI8P4JWqiN1geEQdO9pOCTwJbpPXiNHhYW+nvn
         8p4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141233; x=1789746033;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Jan21eA3GyUwCuy2Q7YzdFAzmFXBmSiFZ1DmXstvho=;
        b=Co5K2e3eP6U8aVdgDnZfU223MJXAQIOubBW+ySIdEbHg0/4gBaEzaz8xe3KysruQVy
         JY0Pd3ja3LP6jkVECUYtmA2ylTgqiX4zoCuPASXRKwm0mKww6GrG9kzwBRc5CloWEero
         XMv6y4Ao5dE/mATdvYGAYGR1X4PUCx8gokWX8VQj0RmXsNoEh4Wz5Sz63eX5U/LQcNeR
         J0CTA1x4dMtIQ8TaULCsTCoGptSLN3BANgpeY7GvfagwmjGDXfkWDK4gy/OMHPTPcZ6P
         IdCSefQBx6tuHorEN0nk4/6rfzMyeZtU3CPQbtFbyEDNimX4eUkKuIBDaed9j997XrXP
         /0yw==
X-Gm-Message-State: AFuF++nJsjpjg7r2r4n05bicGbnemU95QYkp56zhfqkUMcx0TpFx/NWO
	t8SpE//zpw02d3IaSN8yodIYFjWlk7GYzy6PGtMmf62zsyn3qinbkuYtbt2fW4ELFTca2+ekxNT
	bq3tVy+arQXUgcTZV3+8PpzBXjtJGE/b3Awin5lck/Hg6BoUa8mfdCS4GeS9v8oM9cSdFJSM6EI
	h9JT60qZo3OTncLIjoWKu5njpLWjRnY/9HXTwyRQ==
X-Gm-Gg: AYBFou3k1n7N5ZMhTV2Lb9Dfh3XkNrdv6dJIrryTtVVH+oc+Qb+PFf7GQUMJO8nmYPh
	jznbdXnGa6q0PWfdecRurqG5jL3IW4LaovZ7OsN95vAdmwf6CZYgRB5J1P1prXQzECoRFq4AXAp
	TDipxlPPc8nriCSIfS2C037U59pIVOM5WVvC5Z5DFY+q6CDhJlgrDavfJ/jw==
X-Received: by 2002:a05:6a20:4309:b0:3cc:c7cf:5a44 with SMTP id adf61e73a8af0-3daed46aa80mr8064997637.2.1789141232876;
        Fri, 11 Sep 2026 08:40:32 -0700 (PDT)
X-Received: by 2002:a05:6a20:4309:b0:3cc:c7cf:5a44 with SMTP id
 adf61e73a8af0-3daed46aa80mr8064954637.2.1789141232471; Fri, 11 Sep 2026
 08:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901003816.48460-1-rosenp@gmail.com>
In-Reply-To: <20260901003816.48460-1-rosenp@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 17:40:20 +0200
X-Gm-Features: AcwNN1UVsaCMkJc3XkJnrU1YH17QTt9kMbRXVr6xSw3k82HcyEzVtLhG8fPyhIg
Message-ID: <CAPx+jO_3vbgnGDs=_C3LJy+4H=xMK2GdaHaNvGcgG35uC1ds6Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pxav3: disable clock inversion for SD HS cards
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulfh@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX1h3fRPO2vV+h
 AWEuP5OyS/O0I9F4tJtHSSDVUAzyhP7v+9bV1srQS20XdsfYZWT7y2/YUnZ+/PM7KMsNvZJ0pXI
 EtA1D2tEqq5bqwrgQOKaYkEqvTvJrxI=
X-Proofpoint-GUID: ppHgEcfjomnc6V8Ee_XKpcYgsE7ZJ2eH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfXzGwdlOYkWlg4
 CDqL5gDLA10pW0njSxQyFepnyHLd9cXQf0LLUd7GuwbGhEOZnUtzW2EQtQo0fi1vBcm9iqqbq1V
 /9T93qOkat1fn+Kze75DDtXIuzJlz3CdwkI8lTSvQ/5WjtF7s5GFguwOYSaPDDHVzYI0cEBwtNE
 77C/0NGFNT1fo+rA1+mTZvooK7DuUk/p5+qkzCD5HZZko849m6kQRf8OLvCb8v7xl7bKAUtTdpP
 v4Rhk0Bpyl1Gq6EUxyV7WkrI1WMtVOPUVTTn0vgkWjusSWChc5Hd7dFPlBqSJZ1BWFPyWMO/ShZ
 ycHjn+E6LdRDQwF136RJYjF1LxHHcjI9WTkQYxguRv2JmFRrL5i6pJSSNwUYD71HYXjCFNvLXMc
 /wNJxJsE2rlM+EisbgE8HgFRgZS7fqhLjYORkrPui8PON0jUYZ9Y+VH1563xc/fr1BYpef3yxrA
 J/4ibxGCmeT9NuQJMRQ==
X-Proofpoint-ORIG-GUID: ppHgEcfjomnc6V8Ee_XKpcYgsE7ZJ2eH
X-Authority-Analysis: v=2.4 cv=AfwkjHXG c=1 sm=1 tr=0 ts=6aa420f1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8 a=5KI78zpO6hwaGs1b4KcA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110218

On Tue, Sep 1, 2026 at 2:38=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrote=
:
>
> The SDIO3 Configuration register branch of pxav3_set_uhs_signaling()
> only clears the clock-inversion and feedback-clock bits for
> MMC_TIMING_MMC_HS.  As a result, MMC_TIMING_SD_HS (ordinary SD High
> Speed) falls through to the default case, which sets SDIO3_CONF_CLK_INV
> and leaves the feedback clock cleared.
>
> According to erratum FE-2946959, clock inversion is only needed for
> slow frequencies when the card hold-time requirement is high and is not
> required nor desirable for high-speed modes.  SD High Speed runs at 50
> MHz, so the same timing argument that applies to MMC High Speed holds.
> Treat MMC_TIMING_SD_HS the same as MMC_TIMING_MMC_HS and clear the
> clock-inversion and feedback-clock bits for both.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pxav3.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav=
3.c
> index db9dfa92cb57..9e6703e005e2 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -284,7 +284,8 @@ static void pxav3_set_uhs_signaling(struct sdhci_host=
 *host, unsigned int uhs)
>                     uhs =3D=3D MMC_TIMING_UHS_DDR50) {
>                         reg_val &=3D ~SDIO3_CONF_CLK_INV;
>                         reg_val |=3D SDIO3_CONF_SD_FB_CLK;
> -               } else if (uhs =3D=3D MMC_TIMING_MMC_HS) {
> +               } else if (uhs =3D=3D MMC_TIMING_MMC_HS ||
> +                          uhs =3D=3D MMC_TIMING_SD_HS) {
>                         reg_val &=3D ~SDIO3_CONF_CLK_INV;
>                         reg_val &=3D ~SDIO3_CONF_SD_FB_CLK;
>                 } else {
> --
> 2.55.0
>
