Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BF55335B7
	for <linux-mmc@vger.kernel.org>; Wed,  9 Sep 2026 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956837; cv=pass; b=URuKo1K8ohrBk6Pho9jTe7zTRpJur6mCohCPYi0HWP3HRsoypNxeAI5dHiS1PraGnFc6A3oWB9v2jDu/Xv98OoJ7NpsHZAFrw+ux0ao3OiduRaomwjL2XXHyk8HXXMyHf2bM5s9wdmVaYYzaj7/BKV3BtB8PcT2x1EtvQo9wuRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956837; c=relaxed/simple;
	bh=BR5LtnGdokv96N++opizZQCJinG0uSfFlTai0D8W51g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myw367SPnZ0Nhlde8ew9MdnsYk5aDm87nk4SWILNhyc7asprIMKlFxrobszcVtfnxtvccBRjjAZKa4nmwvnMgL+gjXQdujUpkIDX7Nll/3iwzwumxLMyKJZtiUhldSP+TE+1mFsX3/gI3SdTbjlvJL+eXXYT+5qr3yQtsKru3a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lcJab6co; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ITBRZG7h; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lcJab6co";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ITBRZG7h"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BU1iA1809814
	for <linux-mmc@vger.kernel.org>; Wed, 9 Sep 2026 12:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w6POWvgl6bcpUotGMBVj2eKP541dNH6aQD7LuDR78bU=; b=lcJab6coVAMK7c5L
	o6qQ9KLWXuJv7EFl988FHcoPw2ICpn1Y+3wOdy668RrsIQcN+wWu4QhnbJ/fsgbg
	nZU5HPNpQ3HzrEgzPOA0zOOjqa4p3Cxne5y23uj5en8qQAtLNk6NTRJTzTdW+LfY
	HWrlAlWQUfZb8CCWN+6+XjK7nPVbKcI+Y1Lhl6xawjNZan164FstDoOmCa8zQi5I
	Sng8kUydP/hl4j3jJcIwxj9b8u23RGFo+8bNdhxuWcagDQiws0EFKSpHEmtjeA1J
	A8KrDfPP4xPT75qg+2QrQcNkdhocUgn2nTbJg0DzwUxG3GYxporvh4kjCBjoSoQt
	wIPLDw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk4xj0m7m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 09 Sep 2026 12:27:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d6fb956002so84132415ad.1
        for <linux-mmc@vger.kernel.org>; Wed, 09 Sep 2026 05:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788956834; cv=none;
        d=google.com; s=arc-20260327;
        b=WiC11DhEf+rT73718oNlzhy52u9wcpGvZ1sdDqkA/YfeYiPdbI6kP+EI030Jsznmwt
         CFW7gb+erEe+IHw55jXyAKbBwE3RV/RRZzUgGBcpo9vOcPelCApkzjZx0vpT5oyKaCKD
         oDa5/CMy6GgHQryHzttH14CBaVCLmTdBDNh1G+rMixVJl13Z3w9sXSDGSYmiiCFfD+BC
         LOGLPlsm8foMuYibKv6PYIaU8XE4vdAhZ/6NFTD+4vFRNRCce7jLGJ2QNsfXAWt17sZ4
         nLSkFzZv0xSVP+F6+bmIznZxJb0nOgdd9OpZ9B83zo/uKctlYmnx7A5J4U0w5kuBdMPl
         gjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w6POWvgl6bcpUotGMBVj2eKP541dNH6aQD7LuDR78bU=;
        fh=9EHI10ttMfqY/VtHPshhCC/9lo8el7H1WALmSrMmN7A=;
        b=ROiNYFS5FIbQiwr9pyGP/OFa/VKY1jE+h2O+hXoRoMXqnFWblAJURQsMTszSRXbc2F
         SNOd332aDjuyTJ9wDKThSYKyvHgVJ7mAMJIJU48MkvoPb9kcnvRDCPEv9ShA8nJgy1mB
         7lfgvj7Ji28tAJNQj20UL4pTxXU4037pcK4cwxT5S9P8vc55wDTglDK+WgVZCvgtrw/f
         0qfpfsqz+TgysJUasbT1H20fBNamJ1S+nsGy6Dkuxk0149z/pDVlzaGGx4yVkRh/BL7J
         ff9Walz1MEEjd8kgZ21WyhwThhkVHiHSg1EChpqGvBPUYkfuy7RSF+GLXmE18/Kwgn57
         7o/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788956834; x=1789561634; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w6POWvgl6bcpUotGMBVj2eKP541dNH6aQD7LuDR78bU=;
        b=ITBRZG7hnnhbqOeXFjh9NEW2IKAfrshKRRwIFmBo8nM8de0WUBOLeP+i3KKaHLYTyt
         FpQROQ6DUVj5hD2cqpZUUYATV9gPSdTuEMbzSJuoqZEGwYtCqSFgKKHRV7mIQmpGsV57
         DYLEEXMTa1dC6o2n8qFThZGh2OtRJc1kPuZCSc4WfdzPZcfmWKq3kRcIYImHbObRpHcy
         K/mrIfBRWlRIN2fTdtUawKnnHpblJmczfUV+qVkV+7FYnW+8JaSdrmxs6dFR7QSvnQaF
         b1EeFtSq/GorT5e+qfiveh2mvQe6XdXA4zCpUxNw0ytdakRzfBIcJjuDqqpXlHbQ7gi3
         c1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788956834; x=1789561634;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w6POWvgl6bcpUotGMBVj2eKP541dNH6aQD7LuDR78bU=;
        b=LkTjHks3P8Wup+qZomCzwVuPJTykYwHt/ypIu67xVVA45ArVeRPX07vxTlzS1w7Og/
         fxK95XcPORrVQVv9KCRf53E0YzSGcSiUgUEnKEqFz6sq4wxkvosvsfVwuSaLxwWWPHS/
         6TqTK4fHR01l+KJqaDGjrMQhjogXJ5t+MHnVokBuuzWny4AaiOO0ZU9NEiOVERAjLPXi
         eIjFIgJF2A8sn2W0XYJs7uoaG73PrPFLyrZMee+CTYaoDUNVzI4pTYUN3IyTNs5R0rvr
         PcT4YoGif4GZtaoH1mv35InoqTFrGUNMk3Ko4F07a9vTP+oxCVtQg2uJf/jVwOZwhIl/
         B2ig==
X-Gm-Message-State: AFuF++n9jxOruIYOAOZspZngRzKDBUcJupccwzoNbH6m1Lqneu9npRhx
	qFc+qjOnTpYZeSA8p560pB4yDVKrYnepIX2M/KLWt7kaTCQ025MeCfRAyuik7Nk/z33eQvHB5No
	758EsCWtDchAYIAMDLNYVggXUS8F/oDLkgT3MhdcUHyI4feg4dyjdvCZ3F0TtYACKB9kCspFJbt
	ioYa4bGy2zwhVFmzwHgelTzrcm+Vn6QWMIWDHH4MUzSE8Hdw==
X-Gm-Gg: AYBFou1o/Tsm8zM5+7e3ia+R8MPyzQKqQonGGNeO2WvDJ3d/jdl6KqiLf/EiYydWye5
	5yvD4AytMRj3IgGo+a4t7LPR0TbmXJdDhCF3E7y4/7oHayoNOGUAAhp+wbe2Kau4ovpMQ5K0rkq
	mcXTWfXtkSbOSLLH1SD2rRg5vAyZoGig087tAQ5qsxcKjU611LRadzbu4I4Q==
X-Received: by 2002:a17:903:ac6:b0:2da:e634:370e with SMTP id d9443c01a7336-2db125ca3e8mr496798605ad.14.1788956831949;
        Wed, 09 Sep 2026 05:27:11 -0700 (PDT)
X-Received: by 2002:a17:903:ac6:b0:2da:e634:370e with SMTP id
 d9443c01a7336-2db125ca3e8mr496797985ad.14.1788956831402; Wed, 09 Sep 2026
 05:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <90559C11-0553-488B-B3EE-DE769D61847E@stasiak.at>
In-Reply-To: <90559C11-0553-488B-B3EE-DE769D61847E@stasiak.at>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 14:27:00 +0200
X-Gm-Features: AcwNN1XXIeyHzosNeIdvMKUaR-ibE5S1SqUytt2CkbtmSqypwu3GXPxXdP9yIww
Message-ID: <CAPx+jO938WKsjQcjhvY_9pyKQLAL0f-oNFUiudt+pxDHHaoRPA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Sanitize CID product names
To: Jakub Stasiak <jakub@stasiak.at>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEzOCBTYWx0ZWRfX2TyotlH1Lb/6
 hr6qUe1hhyLtl/ELRvQHeqx5KtsolsODKLFCVpSp9bC1tmstl6pYpmzuRH3lWg08JD2+CN/2Jhh
 e1NKvZLy914oN4x2aapXQj+8WHcTvks=
X-Authority-Analysis: v=2.4 cv=J52aKgnS c=1 sm=1 tr=0 ts=6aa150a2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=NEAV23lmAAAA:8 a=gCbLCUlJNUJLTi60VrAA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: D0IyZuHPDWLTB34w68Uj34898z8NydcE
X-Proofpoint-GUID: D0IyZuHPDWLTB34w68Uj34898z8NydcE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEzOCBTYWx0ZWRfXxPOzjt9jUqqD
 6x3iIVbb2kwSDLkZ5QeHU8kq5q9xv4L7J2mgN2Ve5br4Td6wis7hzqhtQgboQbSCAsJZGg1kNU+
 eUe0itowiaouIVXT4pKD6UsNVJdJaKCSMqPrysjsfFYJmHwTdeBsV5ABRqKjuEPjmkgm+b4EUPo
 tBLoXYYfUmHQY0oltUA6LmGp56kz9qe6OFkPEX4I+Y087enDpEOqZUKt3mdzUnF2qkYWUvmnAND
 nFprOutoT4mPVRID/5jwq8JD1jf8np8cuWRbHKiCLiJA8NMqR6Zi8GJYhuSwFWUWqY5BlCzHyIj
 v9qsX0IZY0thIP1MyW2iHP8uMX8YIGEjI9o0xrdgu4xA1E58UTSrYMAP4SHDDEWsquzYyN435GT
 pJ4WI74BuluSmiD3l+3b0g92o6Ntq024wUPsyYLMAvtOkDHRT7wxKVx+ZcHAfRmAK1JTASzgNbu
 F9UzXJ7fWLQw6R8/70Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090138

On Sun, Aug 23, 2026 at 3:22=E2=80=AFAM Jakub Stasiak <jakub@stasiak.at> wr=
ote:
>
> Some devices return nonprintable or non-ASCII bytes in CID product
> names. One example device reports H8G4a followed by 0x92.
>
> This led to downstream problems like in pyparted[1] or systemd[2] where
> the consumers assumed the names were effectively ASCII-like.
>
> Commit 3b791214c8bc ("mmc: core: Trim trailing whitespace from card
> product names") established parse time normalization for CID names.
> Extend that normalization by replacing bytes outside printable ASCII
> with a question mark after the existing whitespace trimming.
>
> The raw CID remains untouched. This patch doesn't change the lengths of
> the sanitized names.
>
> [1] https://github.com/dcantrell/pyparted/issues/76 (already fixed)
> [2] https://github.com/systemd/systemd/issues/42930
>
> Assisted-by: Codex:GPT-5
> Signed-off-by: Jakub Stasiak <jakub@stasiak.at>
> ---
>  drivers/mmc/core/core.c | 21 +++++++++++++++++++++
>  drivers/mmc/core/core.h |  1 +

I would rather see that the new helper function gets declared in
mmc_ops.h and implemented in mmc_ops.c.

>  drivers/mmc/core/mmc.c  |  3 +--
>  drivers/mmc/core/sd.c   |  3 +--
>  4 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 29e80e5f928e..0de2a0133f13 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -8,6 +8,7 @@
>   *  MMCv4 support Copyright (C) 2006 Philip Langdale, All Rights Reserve=
d.
>   */
>  #include <linux/module.h>
> +#include <linux/ctype.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/completion.h>
> @@ -23,6 +24,7 @@
>  #include <linux/fault-inject.h>
>  #include <linux/random.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
>  #include <linux/of.h>
>
>  #include <linux/mmc/card.h>
> @@ -52,6 +54,25 @@
>
>  static const unsigned freqs[] =3D { 400000, 300000, 200000, 100000 };
>
> +/**
> + * mmc_sanitize_cid_name() - sanitize a CID product name in place
> + * @name: NUL-terminated CID product name to sanitize
> + *
> + * Trim trailing whitespace and replace bytes outside printable ASCII wi=
th '?'.
> + */
> +void mmc_sanitize_cid_name(char *name)

Nitpick.

We have an eMMC command called "sanitize", which makes me think we
should find another name for this function, to avoid confusion.

Perhaps just mmc_cleanup_string() or if you can find something even better.

> +{
> +       char *p;
> +
> +       /* some product names may include trailing whitespace */
> +       strim(name);
> +
> +       /* Keep product names safe for sysfs and uevent consumers. */
> +       for (p =3D name; *p; p++)
> +               if (!isascii(*p) || !isprint(*p))
> +                       *p =3D '?';
> +}
> +
>  /*
>   * Enabling software CRCs on the data blocks can be a significant (30%)
>   * performance cost, and for other reasons may not always be desired.
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index a028b48be164..0ec5ad66fb7c 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -41,6 +41,7 @@ struct device_node *mmc_of_find_child_device(struct mmc=
_host *host,
>                 unsigned func_num);
>
>  void mmc_init_erase(struct mmc_card *card);
> +void mmc_sanitize_cid_name(char *name);
>
>  void mmc_set_chip_select(struct mmc_host *host, int mode);
>  void mmc_set_clock(struct mmc_host *host, unsigned int hz);
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 05444ecf3909..dca76be9f0dd 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -117,8 +117,7 @@ static int mmc_decode_cid(struct mmc_card *card)
>                 return -EINVAL;
>         }
>
> -       /* some product names include trailing whitespace */
> -       strim(card->cid.prod_name);
> +       mmc_sanitize_cid_name(card->cid.prod_name);
>
>         return 0;
>  }
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index c763efb10f64..7dc2b791f44c 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -97,8 +97,7 @@ void mmc_decode_cid(struct mmc_card *card)
>
>         card->cid.year +=3D 2000; /* SD cards year offset */
>
> -       /* some product names may include trailing whitespace */
> -       strim(card->cid.prod_name);
> +       mmc_sanitize_cid_name(card->cid.prod_name);
>  }
>
>  /*
> --
> 2.55.0
>

Kind regards
Uffe
