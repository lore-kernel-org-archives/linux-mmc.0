Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C832527584
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687225; cv=pass; b=ANnRiBEVrktPWuFP41K3CCd4shMfF70KtRtrloBuP09uAS9ohEy79CU5h4pFnJPAUSd9ibpBggkfJd0B3Rnb/kHJjnztt882L7S+yhn9EesZALETfEBGtZ3BANnNn3vCDGV81//QvTuSIomVgd3SvoDeuGeMRRzxZ+ChvuWb40o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687225; c=relaxed/simple;
	bh=V1DsO2Pz3F72ju4dQ/Ux5BmxpF0TO0iwXoQe07SqAEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRds67qwdkLHmN8HKY/ySOepwmtzXKfy9J0WWpdV0XJ4J5i8VDDV41S379RCmRuKWES9Clpz2km7ap+MfvUMfQPOsBzzKCEE+yv1SlpMoZ8TuKUct8iwbSblLE3X7cgK0uUGYdEah8mBMdApHmuJCrUc1xBC9iZsIVt2cib2CYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=onXVlIRs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e8r5+W/C; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="onXVlIRs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e8r5+W/C"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqg99350050
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	21a3Cev2ydeQp5RXTCpHt49B9WnKsUDXOpDi31j2ekE=; b=onXVlIRsP+NRcjVq
	+6r37hTQkQdyY0A6qkTNSYocZjGSU5TsTuhOi5F1/9TFr+VNpE0pc7qe+ACPYGdb
	M6Hcwh5IElWBjkPN3T3dOZ3HFqEXlhAk2LL1NwUFxFmqFq9tlF1rEdjwhIxxM6e7
	y7DJo2szT9xbp7viJveBkMhX4dJ9A94z6PWskIGcbdbjgm5A1/msCLX3jldVmYT6
	FPDlQ5fRW/FDdqRI1tO9VXo8xt0hc7A3wIXfS4Ze6KFMEl4i+7TQC1j/wRLkqzNe
	PitcJ2KlV571B0SGtJOlogpIEkl3ryP8swKWGVbHOfNAL9cNXK6OXgHE0PM0FJQu
	o+XiWQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h01vkjx7q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:07:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39b6416441eso7339582a91.1
        for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 06:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790687221; cv=none;
        d=google.com; s=arc-20260327;
        b=soTFIsVzUgUNWb+YiZtKH8dmquzeF0tclWJ8RYaGPGpFEqXDHXFBLe95LvHJmF+jMC
         DCQvut4b2nVPKAezRHQypMiROMdh3SZAYHWn/54AiDw5N/dsDIcXnRBCO19rttv+Ojmm
         NOpoUIr7eZelqCCxuNnvhwXNm7OL5/lr1g24Uj/RjXRTJL9kIZHaTRVDuAtF+L/WELor
         zq9gHMZ3UcoYuzbjIJdUdhhIEpMJIib1G66IDaXvmuonA9JavODJeEyIbge1lUOv2xxp
         rWW3HXHxKY3e9n9/Ls4eoes1h9lubqg90P24dbZGmY2HNDLCu9g5x/iZDeLM3Ou1Nv5a
         prRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=21a3Cev2ydeQp5RXTCpHt49B9WnKsUDXOpDi31j2ekE=;
        fh=Mbpi8NUhIcUG5R2AhipW0KG59IxNmOL+YivPCUaSUOw=;
        b=mMnuEVA0ZZda/iwnXcjcEnGGict2u12bGrsQzje5ErrpwyHn5lIx5GG7a+aotcZVnq
         AIDn7QunzK+h8dquMmwozNPF4e5nsR4Ikh0fL/kHHKmkIBkaN+ZdUJC7vVRgzKqz+EVt
         R5yc+WzM+Vc/dveO6eEKV8vqeAvBULhHvDelTyGIfb0QEVwCTPWnzDziRnjkYBsy9y5f
         SiPgS206CDWJIuXQDJVsXgIQKWSobIaX2+yR+CkT/duuvM8y8Iwsxts4XQt6XDv6Ayst
         ufmZBLscUUElTVMWU1Su28u9HZP5VppsCWUdtn5RIInxbh+Axk5/qZW8I0GUmp+k6Oh6
         UMyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790687221; x=1791292021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=21a3Cev2ydeQp5RXTCpHt49B9WnKsUDXOpDi31j2ekE=;
        b=e8r5+W/CcebgGf848IVTIFhQsstQPFdh/rNRcw+qpd3EtT6YoTMLNUOlIIO0c/mLEt
         6rlVIVRRyVfPqrFaFpCSY9e2Fy0DlRIFcKUAK+xkA4ofXAlr5cB6DgbHRoU0HgWnNwYz
         q8Y0NDQHKIPHGy/H6jJ3RZ0rzm608Q3v5NP0ecdmsvzmag4NdbLRCrv49fQqudCuuVXQ
         h/1fQ6nRQJP4MqyRWux7jyO7bGZEt7z3qzYrwqCSne0pZSS2M3oKUHWcG+GM3egeyJdj
         30/N1lHDh0hGbxzgrrd6eivSS5v7uqLSFrd8ifzIQ1+mq796ZMk3x9dgYGl5G8D7mlOE
         zGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790687221; x=1791292021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=21a3Cev2ydeQp5RXTCpHt49B9WnKsUDXOpDi31j2ekE=;
        b=Do+NXYiboAMJtonLCjSG/aOflQ9ix3Ep9tO7ZjQ5zhP3OyUgXOs2TRa0Uu6fvU/T+P
         eqigBhqsfBH+M6stdmZGWfTY05Gh17E5Y6swSsW5NFYylWwosj+uuSPH3jW6OsJpfXEP
         K53g+vq08TWUrID64CJf4MzdGl9BFtAXWJDTcYvvWDv4Mz01WCWK4Y9IdWWlFDBrHvFv
         wE1DN0DBpZVH17sr0xMhQab4QHa7KEkGkwBlz5SatejT2E3xmLrr6Di8mTqe+BJFcDTI
         KGGcs2wBCJm5bs3cfBmKXaWY716/IL29H05Ii93RroarpdELXkXvpmgOyty7VbmbzvTE
         CtAQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1xBJcFTbkKTbHnIIbKE8KERgu50w+mupZn7rw/jpoujtDfu/+fKeDjzYckZtV1dA0ZBi+8TFOmOo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6E2OJgLtqWCKzsb7zNwKOBycVjudVhfmt3gutCfD1HlYsAIzq
	XzZT2lGQfut6fmJJ0Gd7j2yrSUUey4+hMoTp//crIgHpORFpgtLpSL2Wt5AT4wkjp2LS3bik/In
	CsNLN/isRI5u9otuV08rz7l28E/WxFG6jN7H0MlpmJ2lLgks5caTbVA+wv1kHikiG0hyumIFmLQ
	CTUh6L/SzBllkJiz8JyEb7hLcGzRw+YdNxwNkVtQ==
X-Gm-Gg: AYBFou07rWJxThz71eWUbjH1hivjMkxIeJzyvX7m6edgKrpyRWIAg7D4RbIc7ri3APE
	xoiOhKaxOj0TIWIVKl4QvQembb2ba3ew6rqgvkdQQM8BUC9QMjiETG1BLOlrLw9WVfjtwVumYvq
	PpUUvJHkJ5bcF7ovBqHG0Vpe/mS7ec5YYiWzLvV12W5txrpvVAjjtF9iwNgQ==
X-Received: by 2002:a17:90b:1dc8:b0:3a0:a781:2c39 with SMTP id 98e67ed59e1d1-3a0a781310emr12666123a91.7.1790687220857;
        Tue, 29 Sep 2026 06:07:00 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc8:b0:3a0:a781:2c39 with SMTP id
 98e67ed59e1d1-3a0a781310emr12666092a91.7.1790687220319; Tue, 29 Sep 2026
 06:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926122908.866-1-ian.ray@gehealthcare.com>
In-Reply-To: <20260926122908.866-1-ian.ray@gehealthcare.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 15:06:48 +0200
X-Gm-Features: AclHuK8ohi6TIyO3G8ZsjJJvVIubQzRERp_6C1DA8_Wo8f5Uw_B-NFxG6PGshS4
Message-ID: <CAPx+jO-59V8bg+DB4pOqEmdPZrfLi098YsyzkBRnf2Krb7ufVA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Don't program invalid host driver type for
 fixed eMMC type
To: Ian Ray <ian.ray@gehealthcare.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>, stable@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MiBTYWx0ZWRfX1g/qZp7e4RbZ
 bu+G0Mug7Fd9AhDtVuTVr0wUiDvcLJaiY0twLQcT3hMb9FEjAJkHLNNNz6xXO/ATQJpp9QFceV3
 PVC+Ym7XdAabml+oSbkow1tx8NhEVTH9PpkZuInQkNFGKcT+5pcvE/nDuIYbWiGhGU5E9VNaFJs
 hIRjS1YbIa7cgGWpgu0h1d43uUg7tYWuDafHgnt0iEbNq+izpe4tu/ouVJShoZClW/X0QLG8LGA
 4q3jWl3QlUgg0XpFbMzBzcuDU5ykRBzky0875ul/4wEuCnIXVCmG825Y4J+Ry7RnIpkXlIf/ezu
 lrU8h0L3eNSVWSDnbabAuXmGpQVkNjpWvAaVJWjwqrqL8ql/awW+E/W5SzJNMqh9aYsDYgiIEap
 2zSIClO0uMLDSOWEsYyLZC8FtY3KoXDshOJ0TVV7P2Q8b4p/9HiUH8qRI5/xcXpSx7NRKQGiOry
 t2v9hi3agcEdJXKWIPg==
X-Proofpoint-GUID: 1kQdtbyEpLOCrW7de3CypKTvYnxKX671
X-Authority-Analysis: v=2.4 cv=VcVir1p9 c=1 sm=1 tr=0 ts=6abbb7f6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=lb8OlhKpAAAA:8 a=VwQbUJbxAAAA:8
 a=ChPqmsTiKTP6iP7Wuk0A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=7GnFejQYy5TgUzHuXd-m:22
X-Proofpoint-ORIG-GUID: 1kQdtbyEpLOCrW7de3CypKTvYnxKX671
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MiBTYWx0ZWRfXzuyTXg5G13W4
 dX93hugdD3OVeO7Tl10OrdnqS6GoBTZyWPxo+pGAXV3MMookQubzE7J9gK2AjxHXdomcuGHCmmr
 gt4zU/hMfvqyRJs6kOGrVT8k1ebTaYY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290052

+ Adrian

On Sat, Sep 26, 2026 at 2:29=E2=80=AFPM Ian Ray <ian.ray@gehealthcare.com> =
wrote:
>
> The host controller driver type value used by the MMC core [1] _mostly_
> overlaps with the eMMC device I/O driver strength value [2] as shown in
> the table below; however, there is _no_ host mapping for eMMC value 4.

I think the mapping exists only because that is what the SD spec
provided when this was introduced.

We can certainly add something that corresponds to value 4 from the
eMMC spec as well, to make this complete.

>
>   host value/type   | eMMC value | nominal impedance | strength
>   ------------------+------------+-------------------+---------
>   0 / Type B        | 0          | 50 Ohm            | x1
>   1 / Type A        | 1          | 33 Ohm            | x1.5
>   2 / Type C        | 2          | 66 Ohm            | x0.75
>   3 / Type D        | 3          | 100 Ohm           | x0.5
>   (none)            | 4          | 40 Ohm            | x1.2
>
> [1] MMC_SET_DRIVER_TYPE_* in include/linux/mmc/host.h
>
> [2] 'fixed-emmc-driver-type', see JESD84-B51 Table 206 and
>
>
> Since commit 5a52c5701a67 ("mmc: core: Fix host controller programming
> for fixed driver type"), the selected eMMC driver strength is passed
> directly to mmc_set_driver_type().  For a fixed eMMC driver type of 4
> this reaches sdhci_set_ios(), which only knows types 0..3 and therefore
> complains on every ios update:
>
>   mmc2: invalid driver type, default to driver type B

Perhaps the print above from sdhci_set_ios() is simply a bit
misleading. For example, it looks like arasan_select_phy_clock()
actually uses the value in ios.drv_type as is.

To me, it looks like the problem is that mmc_select_drive_strength()
doesn't really do its job correctly, as it should help us to figure
out what is supported by the card *and* by the host, so we can request
a proper driver type when calling the ->set_ios() callback.

>
> The mmc card itself is still programmed correctly (the HS_TIMING driver
> strength field is set from card->drive_strength independently), so this
> is a spurious, repeated warning for a valid, documented configuration.
>
> Change to only program the host when the eMMC driver type value maps to
> a valid host driver type.
>
> Tested on i.MX8MP (usdhc3, eMMC in HS400) with
> `fixed-emmc-driver-type =3D <4>`: the warning is no longer logged and the
> HS_TIMING register contains 0x43 as expected.
>
> Fixes: 5a52c5701a67 ("mmc: core: Fix host controller programming for fixe=
d driver type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>

I have looped in Adrian, to get his opinion on this.

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 05444ecf3909..ff5d4b805998 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1371,9 +1371,11 @@ static void mmc_select_driver_type(struct mmc_card=
 *card)
>
>         card->drive_strength =3D drive_strength;
>
> -       if (fixed_drv_type >=3D 0 && drive_strength)
> -               mmc_set_driver_type(card->host, drive_strength);
> -       else if (drv_type)
> +       if (fixed_drv_type >=3D 0 && drive_strength) {
> +               /* eMMC driver types >=3D 4 have no host controller equiv=
alent. */
> +               if (drive_strength <=3D MMC_SET_DRIVER_TYPE_D)
> +                       mmc_set_driver_type(card->host, drive_strength);
> +       } else if (drv_type)
>                 mmc_set_driver_type(card->host, drv_type);
>  }
>
> --
> 2.49.0
>
