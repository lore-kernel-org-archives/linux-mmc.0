Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EE83EF0D0
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065961; cv=pass; b=YjArWFS8edUPbp+dcdyq/b5PMtW4hls2ZsJGsccOD7f0dAh71++LD38bxdoZJfW9Us/OCZX/7ETMZzI7tNMWuqaga8CyzFshZ9NXsajuKm1vZLnLGZVqeGW9DlVD5GT6Hdu7nr9Mt5FN+zuuAYrPlIkj/VXBxKn9m6rY433zZVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065961; c=relaxed/simple;
	bh=ZCjavYg2eJB4OU4AVO3054kCUboFVAo39kPcNuUwmNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAhDfERyOAyO3HLWsrqr9HCfI8iBVL2wIyQ2vXmi2H4NHvBpmr48eI5iz/MwvGDCqMIac29xqr3FmGXUXlZ8v/URzBnR1UGph43tQ5ly3/KP+blWEJNSmA05JOTkHK6npmJj0Ixe2l90YRvxw0uqN4mo9lYuJLCd26Onj0cGV0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bu3eS0Io; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Te2fdRPc; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bu3eS0Io";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Te2fdRPc"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDaS731279413
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y0uRdyGufttfYsaSEKi83F70fZI3azu4YBlntZSpPu4=; b=Bu3eS0IocdVwcgU3
	CGTFtvJsHhHnWhPRxdFyHJvNRpwXsNF23f6zIOH4cgaJR8KdAGRdP6uxlcvwADxj
	sdfmufVCxLd7S4lfAP8c/cW4sRRY/lpyXpZDEkiTEDqhadvk3J8s+KZEv5AZyR+s
	BLlH1NDNk2MGWYZT3ibgT6O4GUxvmCf0wOcKB+pp81pulce5ifgnR8A8j8q+N14n
	F1C6J6SSYrSHMySeK0wVDH6gHQ6tYPlqNGIMeZANuO5W6VP2b3D9cmsSeGaJwETy
	KiHxJjnm5MukNBqHY0ERqom4iOSWGsq+o0P/58FN7+fYFzqVW+9Nwps8SooyVzqZ
	b19KUA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efbu50a4g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:59 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8cced2dabc1so8041276d6.0
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 07:45:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780065959; cv=none;
        d=google.com; s=arc-20240605;
        b=N40sMs4OFhq+PnST9t4tkeEgndtlNgTGgVh5dYjzCyLu925lkHsWwx54GaQB+Ff/+y
         zE5yoOppMoFkhzAPaTIWk7gJO65r9aOfEpg1ychi7a0dya4VqxkPgEYG7RtnATxnqS7g
         kEo3JGokkuuUkR5TQmYbFcf713UNbeo8kINtPl7AvCV5p/vXaeL9pbUwMNXPZLr+C25z
         sZh6eest21G+ZU8et2kDxrlCQrehJi4FC8fKjnICbJrgyRuWKCYzsm6J1L4F6DvMjQIQ
         rYrhVXhq51c83t/+YYIC8tUcDDUVp0y8VMUEqpsqoyxJvheGAs1mHAJ7Ta9JgqKm2LFm
         Pnuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y0uRdyGufttfYsaSEKi83F70fZI3azu4YBlntZSpPu4=;
        fh=RpNppo5a4WWXbl5HfZ1cxjwBzy7J81GsPRvP/WjITvc=;
        b=bDNGDEmFDCTF3NPE0LAdbYBz0bquSanD/BhgoQza/xBLd0V5mYz36ZoJhYbE/T1bPn
         n6GJqDlx8AI6Z1gOlwM4JEXpzHjxOhlKgZIlfwt+tK49rvjBV4GgkFkMabKpIWC4ZbRh
         lCfAg52f947HEZlAyKSqQ07rzzlCocgbrzcfEiSXrFvrYsRG1RRACHP8fBtP4wRsM8Jk
         qRKcoVwj6bcNUCgY+mwDyaXmMF0DTxsBy7+jOEwEZJkUP7L9CIXxJ9cjGs29BENpAu57
         1lyhSILa4GU5R5ViIKw6iZLjlj9NTShIft98ACRZtCSTEHWXPDnGv2MHZ3ybNLhNLh2x
         DEMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065959; x=1780670759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0uRdyGufttfYsaSEKi83F70fZI3azu4YBlntZSpPu4=;
        b=Te2fdRPc5dsYlDj1+tfm466bHSuHkYcdfyZQWXCqF5MP+wPLN3749xybiQheqMDFAF
         0pPZt89bYyrcwHVAaynPAqaFf2KaKu3PQMgRHqx403YL37bDDXYm+pDd4NfYs8uRHRmr
         DNqF4i3Q1vILFzHQnOTMQ745Qskvw2b1FfaO4caieZiUqcv/iq/ZSVXvMS4V3my9dYO6
         zo6FAVeRUzGR6tx79BnQqsa97a5cHamSfzCJyf8JUV36lHVMvRsEci3XrqQQB5AYVEfj
         Q8j+gZGO+x5u99513LvWMKWX1+UX5e5zYz4t3G7/t9QJTm9Tk4Ut1STSLjuFUWUE26fc
         i7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065959; x=1780670759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y0uRdyGufttfYsaSEKi83F70fZI3azu4YBlntZSpPu4=;
        b=kfmuunxhH5aoj2i4aWARkPLoB7ND1C8yuhtHI7xfz7uxU1ie6Sw28OSTkQisYwQ1ZI
         aln0wOqrdmseI+0e9Uwx3g7iQlGc6WN6wg2ho4YeShSAS0mcuThqvlE875W/yFHThsWP
         XrvJEmlQqc4jV2V7rp313nbxOE6Km/gtfnu5IB26t88E2SuqbkB8Qfkd1eFqyGhI4flR
         Q6pCm+VzO8MadjPpF9JTrjtQD7bA0TKjKwwV03pXBywDh2BNKQcLa88Gpy8JNiT+SdpO
         Ru2CDB/9NfyvbRi658W4CaEyj/0/m6ly/CjYAPujT+D+hmatna9LSEKyDVhj8O5LTIh9
         KZ7Q==
X-Forwarded-Encrypted: i=1; AFNElJ++cpvmZu2KkOb+LejVloXAZ6q1eAHJrxKYlZiRDLRCHSjwH2mvy8/GLX7IdHGdpKW+gOgQSkroX0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvCsVCT2r3DeRQnHOP2drHkojGVnJrZ9DZ7H916/HymK16NYKt
	nBMKfvW2RBxiT7hH1p1ashUFifWdF1+3kQw0rPDBbAf/5s5Q7U3krZPshIWgno6ixZPP2Z8ooOH
	G/zsDAIV9y82YvUBn87A2jGvUvWbrBWpQp3+ADzO+RdCMSfz1p6avxrUmBVtHrza4dEarvJKRza
	/829uZvqj6N+fAyDKqPWh4GeCsZL8j4dl2wx8UVw==
X-Gm-Gg: Acq92OHfGvyvFYtV/7g8+wOdbKlZg0viXtXdqDOalGo6qlfMCY8pr3t3jyG8KqQ0fUo
	jaujX+rqU4yUdllQsm/tIaauTJ6UHZpdhVhDdBZ5owyAx92sC8EjbJVTNthQJxB4e2e6ohziFwB
	LvCPyY+Mfh6c8zrZFfv3KDNHuG2aenvmJO3LDSdXCAaJQYpZIlUB8VrZJhIhli7cXy9QPRR8Tt/
	cDSZCto0Mxny2rPeg==
X-Received: by 2002:a05:6214:230b:b0:8ca:10c9:845d with SMTP id 6a1803df08f44-8cce801f126mr36090106d6.31.1780065958655;
        Fri, 29 May 2026 07:45:58 -0700 (PDT)
X-Received: by 2002:a05:6214:230b:b0:8ca:10c9:845d with SMTP id
 6a1803df08f44-8cce801f126mr36089856d6.31.1780065958269; Fri, 29 May 2026
 07:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522184307.2979579-1-heiko@sntech.de>
In-Reply-To: <20260522184307.2979579-1-heiko@sntech.de>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:45:47 +0200
X-Gm-Features: AVHnY4J_FLHe1mGcqIVr9GZCUybu2z_sAx_8iofpKeK_xPfv3mpX0W3pewKBvLE
Message-ID: <CAPx+jO9kKCQE+ZtKhJWX9mztEQ2m93irdqt6910wG=9M9zN4KA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: Add missing private data for very
 old controllers
To: Heiko Stuebner <heiko@sntech.de>
Cc: ulfh@kernel.org, shawn.lin@rock-chips.com, jh80.chung@samsung.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=SMRykuvH c=1 sm=1 tr=0 ts=6a19a6a7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8
 a=zCIS9O9Q-TFeY09dWLwA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: cNUOoQwstSQzp0VD5Uvq66lO5Me_40me
X-Proofpoint-ORIG-GUID: cNUOoQwstSQzp0VD5Uvq66lO5Me_40me
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NyBTYWx0ZWRfX78PbGtKQoMFk
 kDBOrp00mbDkVFkSX046qGdnpVhtfLQeFenFuBA23C1aSDD83kYcytNxBhto9L7LjfWbwlEv8bY
 VEjfn9IzFWGG5gRQ5dTxwTYVM+BR+4fkXsOQ7yob1T7ZkXu3ixg7lrP7eJSuq1wsYQRuGvrEeHH
 JZKdtlN5R0UaBskW5Hcj07kwcqI0eToKYnzgbs0f0BdJaI3quwNnJ6t2t1MkAdsz7zvxw49fpDy
 R9GqMvaBx0XxJ9ztaO+3QibNSLd0cqoD38l3R8e1tQUWy7h3H7sOe1xlVp1DVlnTp4/PBTXMA1H
 EwgQ/ZmvZa8w3h1tYLo7nHUSvizwAN3Gpji6L1IOrraMKK5QXL38dkj5EhjYXiLzaz/w/iXC9DS
 VppR5Y5fKjlERjcazhuvbq4zw0NQGYSBRMwtqALF18g5iYGaUwzIY9yM+bLGRAlIFuSayHd4301
 KE9ZUvrAvsA17ovDxsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290147

On Fri, May 22, 2026 at 8:43=E2=80=AFPM Heiko Stuebner <heiko@sntech.de> wr=
ote:
>
> The really old controllers (rk2928, rk3066, rk3188) do not support UHS
> speeds at all, and thus never handled phase data.
>
> For that reason it never had a parse_dt callback and no driver private
> data at all.
>
> Commit ff6f0286c896 ("mmc: dw_mmc-rockchip: Add memory clock auto-gating
> support") makes the private data sort of mandatory, because the init
> function checks whether phases are configured internally or through the
> clock controller.
>
> This results in the old SoCs then experiencing NULL-pointer dereferences
> when they try to access that private-data struct.
>
> While we could have if (priv) conditionals in all places, it's way less
> cluttery to just give the old types their private-data struct.
>
> Fixes: ff6f0286c896 ("mmc: dw_mmc-rockchip: Add memory clock auto-gating =
support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-rockchip.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc=
-rockchip.c
> index c6eece4ec3fd..75c82ff20f17 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -441,6 +441,22 @@ static int dw_mci_common_parse_dt(struct dw_mci *hos=
t)
>         return 0;
>  }
>
> +static int dw_mci_rk2928_parse_dt(struct dw_mci *host)
> +{
> +       struct dw_mci_rockchip_priv_data *priv;
> +       int err;
> +
> +       err =3D dw_mci_common_parse_dt(host);
> +       if (err)
> +               return err;
> +
> +       priv =3D host->priv;
> +
> +       priv->internal_phase =3D false;
> +
> +       return 0;
> +}
> +
>  static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
>  {
>         struct dw_mci_rockchip_priv_data *priv;
> @@ -514,6 +530,7 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
>
>  static const struct dw_mci_drv_data rk2928_drv_data =3D {
>         .init                   =3D dw_mci_rockchip_init,
> +       .parse_dt               =3D dw_mci_rk2928_parse_dt,
>  };
>
>  static const struct dw_mci_drv_data rk3288_drv_data =3D {
> --
> 2.47.3
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
