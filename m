Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54D64AE8B7
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056340; cv=pass; b=JTuCTmaDoHgdN7pEW4a2pKqAvKkXnBqlRjSQMrXjDpJLM2kXkTCR/1z6TZ3sZ5xzbqImJWcwBe8aySxlj/mUZKfT6gq+3XZ7iavKBapScxXMxLwhpPgBwesbVY/PpjVIYu0Ukj3THNRl14zD7yChnuuy5DCFt82s0oLCHnsE5VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056340; c=relaxed/simple;
	bh=g7nac0T0X9UeGOZxw4guHvrAN2WDr1u+ybbYZk0AUJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlMl2NESz1Ry1LCGyl+TyraAbkzBRrFTWreGaSnX3mW1S7JuM0gZ3GbrF0bElIEJ9/B/NyJBPRnbgtUXjTMytG1UZnMd8UQHvP/ikXo+RTsByyxjnB+XyrExnqUL9J/UpJzHZikMqJdmHIBoG65NLG26TJjX8fs9wJY7XwQOesc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZlNZ24py; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R2L3aBHP; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZlNZ24py";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R2L3aBHP"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF4LIL1275346
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yoxqy27byI+/wR2v7osUw7bvc0LF57CRxz5b6DL1pSQ=; b=ZlNZ24py8MkFeZO3
	YnE+ujzXoEKddHVM4q2uTunajtH6GljGHbALN4EhxX6SEwcSLpIEwOgCPyBTTEMo
	hLSBDq4OsUKVm4rfHzEfBMtFuph3vHr1fY6evCs4srZkqJ0qvrknt6/y+cwSPhEA
	RSNPP/oVF/+1eXQaO+NtfCCgMvPG3M9K61R7owLRouuaBQIcKENa+P+bDeMGKCWl
	mRKyDoIoRwnUzIqKFT3vl7wkDT2Tj5gO452TmvmWWC6HeU/iytlQmtmxwphpjWhP
	m/BPm7ldMXy3fXQejhb05P+ZXEb1DyrtB3lq9VHizDeXz7tEsTkbAZ7vQxaD/MU4
	NUj0pA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwkw8v90-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:36 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-853d0d87123so3608428b3a.1
        for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 09:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789056336; cv=none;
        d=google.com; s=arc-20260327;
        b=ru+nbZ584CdM818N26BHh8/Cj5a08mwV6lNO6FLmHOBY9mK31UlWYpB/R8y3ydF3l6
         y/AOxEZIJNFI1auLZUmy0MbzIj0FZ9D4Y3iGPvcUH1riG7U8ofZGd0gJ8yECqP6OWxWE
         ik6uZbcCQU1BC5q+Tw+y68F6l8bDwGkcIpBPPdXKNylzFhkYP8tJbYasIhKDbasXNZqX
         5tEvkO9zgdooPRGDkvxBQfnkmxD26TKkXb6fken1gAYxp5nfGC76YQ35tAIx4P50hWa6
         DbVxemWan5AP5xA2kMOC1GUmxIehUaAVz3Tj3WWYcWmXO2L5I1pkx4qs6oMNCfOLlrgY
         XXqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yoxqy27byI+/wR2v7osUw7bvc0LF57CRxz5b6DL1pSQ=;
        fh=UuVgBU1usf3s90Vde19caSD/wLzz1bEUbgDHtPYVXmY=;
        b=Dc0Riuedxj9VRu3rHHE+d2GJFdVHcv25EwAEGMT3chW4YgWKeSRqtnXfPXmLwnRgcJ
         8WzcIqTtxykFmaxULmrVzhz3D2IDyjV3e7VrQf2QF0L2gNbyY1EmhD7FQ1h1POHxvfdE
         u79Vl0Cxkq/M4Zk8knXZx9oH0A7z+tDhCN0zWjGPLVwg0aU8Lo3lUpDEXlE600/URLG6
         DXcA5xyDR3bdbBwEgvFLBb3jWT/29R+OvDru4aTvjkGQIbMDQ/DFenYPAP49AOY1GYfn
         hpKXBi7evpz9tTKu6hGvm5/+jfGqCB5nxMI9cuwz4NnmJBsTyB+kFQbsG1ie/hmLjiUG
         EuEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789056336; x=1789661136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yoxqy27byI+/wR2v7osUw7bvc0LF57CRxz5b6DL1pSQ=;
        b=R2L3aBHPFSGQKu5srRfviqbzKoTy6lPf1OYFwEiZ6k0joYW8i1iGOxZFGY9m12KP4j
         cKB9UIBR2AnUhlyiW9x686zL5dr2lysXeFtMTPN0xPJIqFRUWBX+I17fcM/6p2pfD+Kl
         SLFLE+tUpoOj92JFzTjw3qHrtguk0ubfHORsQtgSgw9lSWTLc7kDavHXi/3L6RUExSf4
         qzxx73UImgUw/zLSfH5Ao+oCpSC2n8cMC8yZWuCPtWoWPJNHoilfKQgXfY+bSC/xYqcv
         TmxGvor8X2Q48gZMjouoDqsVnJXU2bsRGvg1HMNgSz4GlP/O2zVm+KEY6C/kh5phEZdf
         /Kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789056336; x=1789661136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yoxqy27byI+/wR2v7osUw7bvc0LF57CRxz5b6DL1pSQ=;
        b=Srb57fNTG1RlBGqlg5Ww3abB7uDjdkS4FxdHrh3AjiU/NI6nA76EWvcMB7MUsN6YTb
         7hOIjkUau6zk7+/Ub5mBxPXhkLIkfnK5uevKyDgUkqvOu5/p5DeWL4lJkccY0tCUuarY
         1aaCrFYx4ImtmXRGC/bSUVVqwuLMbbr+TanvlNVfLTVNG5pF5bEpm9uFt1iMdmFkVLK2
         DKZ5WIJ57fOo+WSuzkf9X5eBPFZN18IanLN06JrO4H3/YgSKYlmDKb5iPQbJPs7EQx2+
         P7hmnHPEKYSPhSZGtB/QSwYJHvOK2vqhPkR35WjksKk9ufZ11fY843D14R8OLj7Qk5ZY
         CCjA==
X-Forwarded-Encrypted: i=1; AKwUvBz2LyfO1Hrx4QYTAvnHSxX8BK6xNN/rQydKdyg91OMCZsxQM+Wc4tvTDGehAwD2XZloQ/9LBHH2FE0=@vger.kernel.org
X-Gm-Message-State: AFuF++mr6XrI/1MsHiAyFqRfgH4NuWugJrDjirwPAfrZAwlRZGPUXfJQ
	hhEcVZy7o17RWoM23PGkV33mBqF/7HJ7P1ancXEmFcd8HcErpEniT5L6LUF6w9u2Ts46KZx0MCY
	Uo5YIB1lavs059vs6oTM2UwRTw1WBCg4dEmCiiSNydB/WaTiUh2R41w78HC2OnqXm8iQX4qFpAy
	NqkdDfuymTqOqVNxPDB2fmrLT9/hzmckMa2gaULiqySQGZCQ==
X-Gm-Gg: AYBFou1TRh0rljFFTlvM6/1bnkqwDWi4+/L5sQWJDFO2vqMNCY7F/Kd4FsVWzLLbEhU
	197qH8Q5Z/Vg/9i4NmXO9wVpIFcPDh2xdX082EIArOeMGjJ7Oeasper1crTNB/9HAv+EB7+VWg/
	plflTO9saPzPSofIYPyigezB2HlIQ12foShNEYwxvDes6N1hoB7PPo4iOVOw==
X-Received: by 2002:a05:6a00:aa85:b0:857:7384:b5fa with SMTP id d2e1a72fcca58-86948928444mr10182756b3a.22.1789056335738;
        Thu, 10 Sep 2026 09:05:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:aa85:b0:857:7384:b5fa with SMTP id
 d2e1a72fcca58-86948928444mr10182588b3a.22.1789056334935; Thu, 10 Sep 2026
 09:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824065755.35451-1-florian.maillard@mailoo.org>
In-Reply-To: <20260824065755.35451-1-florian.maillard@mailoo.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 18:05:23 +0200
X-Gm-Features: AcwNN1XQeUn5yu0y7ja5J9fxlitv1JADg08KH-qf2e76LfTwNbg3W-ZRo2dn4tY
Message-ID: <CAPx+jO9HV_L=Dn5nmWTPXUoA4Hy91uj5S1m2y5fvVaXh+zPbqw@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx_pci_sdmmc: ignore broken write-protect on
 ThinkPad X260
To: Florian Maillard <florian.maillard@mailoo.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=EZNd0/mC c=1 sm=1 tr=0 ts=6aa2d551 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=TqukyxIwAAAA:8 a=XevV5cechEosMP0pQycA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=e_wvXvRcY2B3oMitRgDS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX1KysPPkgRYCW
 znbJD4RVg8go0QVucFQsLbFKEw6AE1tpVbhGxHGM0SyeYeddFGNqxgN02JCyqZnfFex45QEY47s
 hriP2iz1qNdxxBtYulggrYxgg1LW+kQ=
X-Proofpoint-ORIG-GUID: nTMQPejlgo9S_A5DdiMWyPowqtyW7fQn
X-Proofpoint-GUID: nTMQPejlgo9S_A5DdiMWyPowqtyW7fQn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX4GKiGj+p9Ixp
 cWOQ/+EzVDKbcmCRjxUpzvJFpWX8GHImFunQNzWqsYVDppw4p72Xaf6RJXTgu5YxU9r2AALe4zF
 eLva5gBUtxLgVVoFXtyyXDnzGa5EEn9xWsrJaxA7imNrUgBpZ0uKQitKD0qhJhnczDSkdeLTOpo
 eVFdq8Jm2S1S0bsI80bwPuSEZSWXrr5yh2DFtwzJGl4q31LlclWJZle/N8lguE5UzY5v5UqoS1U
 o2fphoAo46Ua2TsSc2Uo3Wn+yX5qYY3RP4mbG8y/t4iOMfqGGTDGwAkpa6ges3KdsErlIZC4Rw8
 Dat7nOfA46JX0CLJk6/u24vvJL3zg0QV+LDKeJYu1HmWHx92AYm208FX/sxN5DqWF9FDIymfevH
 mwYH+9vmWuOSvRBKH4QOrtCobH/2QJSme1VO8DYqiyv2pHdAtuamMqgSXKi2Fs9ZpM8G5c1ZTjB
 TXDdhzr4nIkr1+vAFpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100195

On Mon, Aug 24, 2026 at 8:58=E2=80=AFAM Florian Maillard
<florian.maillard@mailoo.org> wrote:
>
> The Realtek RTS522A card reader in the Lenovo ThinkPad X260
> (subsystem 17aa:504a) incorrectly reports inserted SD cards as
> write-protected.
>
> This causes the MMC core to expose the card as read-only:
>
>   mmcblk0: mmc0:aaaa SN256 238 GiB (ro)
>
> and /sys/block/mmcblk0/ro reports 1.
>
> Setting MMC_CAP2_NO_WRITE_PROTECT makes the card writable again.
> Limit the quirk to the affected Lenovo subsystem.
>
> Assisted-by: ChatGPT:GPT-5.6 Sol
> Signed-off-by: Florian Maillard <florian.maillard@mailoo.org>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pc=
i_sdmmc.c
> index 8dfbc62f16..d25d4cb59b 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -1425,6 +1425,11 @@ static void realtek_init_host(struct realtek_pci_s=
dmmc *host)
>                 mmc->caps =3D mmc->caps | MMC_CAP_AGGRESSIVE_PM;
>         mmc->caps2 =3D MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CY=
CLE |
>                 MMC_CAP2_NO_SDIO;
> +
> +       if (pcr->pci->device =3D=3D 0x522a &&
> +           pcr->pci->subsystem_vendor =3D=3D PCI_VENDOR_ID_LENOVO &&
> +           pcr->pci->subsystem_device =3D=3D 0x504a)
> +               mmc->caps2 |=3D MMC_CAP2_NO_WRITE_PROTECT;
>         mmc->max_current_330 =3D 400;
>         mmc->max_current_180 =3D 800;
>         mmc->ops =3D &realtek_pci_sdmmc_ops;
>
> base-commit: 388b607d107c07aaade04c7f22f344cab6bdccd3
> --
> 2.47.3
>
>
>
