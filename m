Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA0559C86
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881931; cv=pass; b=qetWypQJyM3PUT1I+sSoSi4DXJHH9DH1zs3vmFl8hXPifNWykbSB/TUS4DStMzk9CLFLWhhxwenbDNa5ppGINu1nuldEeCjoia6FoSGH/wqB9EnfemaSfjmrvraVht8qkUu362Rj3GGlAQL7Opba3dUIXM18M3W/SjJ8PG+fFok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881931; c=relaxed/simple;
	bh=084iyVme93/rgLtWav6thyrsk8n1qYyzwYxDkXemLRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQ+9az6t4uvrm1q4FShdDI9VCfFZWXTiZrv08e2RwNwy1vOA9W/4+mHqULaZqi3DAiJQ1o4Cg9EEfAgPwzFyWLHxg5Xe56EPy6XH7KshYg0y133iFbFc4F6yVXYFiF5m3opx76dLkvKQKWeslHYiFxEvAtSYcRQP5uMly6fCZmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m1ufeTdB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CzW2Kah8; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m1ufeTdB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CzW2Kah8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688FV2JQ2881444
	for <linux-mmc@vger.kernel.org>; Tue, 8 Sep 2026 15:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+KGQyqKGDq7lYkaWfASJtwYpmqRqLFpbqouq27FAq8o=; b=m1ufeTdBkHLzyWeW
	vF0dNuodUX6ZWyAAFTZSk83655Uy2Rn6DC34J4aX0n29Z52gFLjhIEo9oQ9myswW
	3Mry3/wtBAvOyJe3ALAbO+Jn0qHhvY78BVL+Upyh8s0pjg8I6khshebUId2lBpyX
	oe9LU3aiMT/5Eiz1g3tDTu65oXAW5DVhytqW/dSjnbeepk0qHSFoIoaaSg2OsVME
	7YWgx7qRTUW3Gh5DoihoK6zHa4Z0CiR8VSaOEep6oi00xOq2icgY3dXP9WoyiCAG
	j91V5t9XpU5NKIz/LbK+GIFubadm9g31B0PAfhKO9/d/BDtlrpnENqDn3UhSvbFb
	4Fv5Sw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcvujcrt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2026 15:38:42 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b8088202so4252204a12.3
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2026 08:38:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788881922; cv=none;
        d=google.com; s=arc-20260327;
        b=e7ed44Upv0+THN/zXgAkuS3wp0prn2LnOIvZQo27Oeyt9L57Umo9bv46NmK/fHeJZz
         Fh4MkMcI3AzZvKQjXQk3cfqbsVq5Cfn/D12u1tyJZR4Y1rs9n3rooo/5GtqV3BRpuKyW
         wa9FzOPWmzLuDUERmpCsgQYFmjAwgKd2J47rjzyJVn4y/wy6fqJywjswT7RhG1xBPM0o
         6682QKZVn2WugaFvT4SMtFaoIJ2F7/wOJ8ZBxtI0bJ1ywLdvRAsnbkX0UQZ0A3IzY4hl
         wRTUqkwY+2fLHW7jfy0fOzLCBH3w/jq07acp6puSBOruIkge8Pvoz1ZHg/GFosgkojXr
         Dulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+KGQyqKGDq7lYkaWfASJtwYpmqRqLFpbqouq27FAq8o=;
        fh=n1V9FsJ11MKVm6DX86oD0VE2+r5wI8icDzRnhrFgwbI=;
        b=ku/I3U8QkkeObvfzYCyWwKuNQPL/1xFGPm47gK1YXYwGXPltEqry2NaPIGNgLkr7q+
         A8AhQUFOmvGjPIl90lu6DXTj0GkQcwMZTn5Rpy5Mgau7DIIsZF0TCCKPRgm65m19yG0j
         MJjpkWfbNY9ezvzVSuVlGsRyoh/6yLMgHRx59C9iXXaEQnInqK3lvUYcyT35i1mJJgLT
         7zVfq3VPKxtq4a4lWKbuPF7n0OHQ45NxNReKNu5MID3MVMA5ozMV8gvwP9hcJ/p1PbSa
         uCxRa+W3P3/I4oOFs7LwL00475ZX8242SI84yHv2QTnVCe8OOdJF/IhIRF1wdGMX3Ybj
         Bx8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788881922; x=1789486722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+KGQyqKGDq7lYkaWfASJtwYpmqRqLFpbqouq27FAq8o=;
        b=CzW2Kah8dmge+gpExIpTbfxq/PeR1UVOCsrsXADLDDtyXtWJxX2IBfVmqsxI+M3w/3
         zs6bXZOyhxS96bY+dnjJVU//WrMaJcdMTr1Q8jrJjWwIHaHhrgcW7op5e6k+sgZpcTOh
         cVMmlC/milWefRH/xRDWt/nMXTiB+qwiL8uNDRA89p+xnKb3lQcJ2s8nJC/0vBrnupp6
         lNqY1jdbp00dx3AItQKvuxQk0ymtv4BsGIQIH8bTrhUZDobuZR16jljkyq+UCssTXnIq
         iHy5hvXxdZ5D1HpNFwp9YHWSGDACVc97uNvwJywYlApFRz94gP1sOfyPeiq/coXjMIlK
         ibeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788881922; x=1789486722;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+KGQyqKGDq7lYkaWfASJtwYpmqRqLFpbqouq27FAq8o=;
        b=K05owzqW+ou0pjgk92GNXLlDjlZcsBVSn7DF26sH5lA7LovaDzAu7I9Is8N+vy3DQH
         iboS1a8L8GJfoIxDjheomq/e0fp2pla2Nlz0N9DawHq4fWC8ItYh5X2wQuvuBEA3qGh/
         uquB8EgKHlpvVcn021vpNEXARJcrchcrqhcXptFR+2R9sOvuac1oV35czjBviBQmX3kl
         pUQ1OgvpQhH3sejo7vhvjZabzTAz2teNisFeJ1YeAb2LdPrnUnqCD2RwDVOrDUr2AClS
         br+Tb2Ac0MHN+3f8sBooTgxwIRHJC1DKu1tlBn8uhqDLfTzwjokonZX0ity3YBOj7N+M
         ptfQ==
X-Forwarded-Encrypted: i=1; AKwUvByCu8yyEZzXR0Eu/FzSUgeW6nf7Zm8/NN6zEIeYhVgQJq5dsE4Vn2m16LouyqD6SSnd4oMXhxLJU78=@vger.kernel.org
X-Gm-Message-State: AFuF++no7i1lj1FsL+fKkt72UEP5quXC3KUKBzGc4QKZSTnt9343Rp51
	8zK7G2P/rgqQq88CeXrhY9GwoAorN8hwRFrBWKfcGibkjj0dkdVHd+uUrGfB04pre1/eso8QzyR
	39lrcQNHzBGB1xm+hqDVUWwbzm6Mk4dDjL/Z0rMmVHKlL2YwJ70UgeR6C9+385u2/dkJAq5QSDJ
	8mI/7s3gHZFucUnQLHXNmu2laO1HJkNrpHYsOWr4jFEs3mlA==
X-Gm-Gg: AYBFou0AdAY0rw+1xXFlei+/S9I39+SBeESGfck4zAkzQMJF/sJTSfu+gmP+9pxV6ZP
	dfkn3hhTA+7PsaKDmI6ro6r/DnrTIY0RseJpUg8C6Gb/+PLGIXhWT00fmr2HJ5Y2BNXfHtR0rgB
	WGngH4bjJdud07RLYQrWZzut2bwtRrab48yYROGGm89r8GLewnJn+xA9ccoA==
X-Received: by 2002:a17:90b:35cb:b0:398:a486:81ec with SMTP id 98e67ed59e1d1-39b261ae617mr51676411a91.11.1788881921707;
        Tue, 08 Sep 2026 08:38:41 -0700 (PDT)
X-Received: by 2002:a17:90b:35cb:b0:398:a486:81ec with SMTP id
 98e67ed59e1d1-39b261ae617mr51676320a91.11.1788881921058; Tue, 08 Sep 2026
 08:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f20e08ef831f0bad278adcec44046742b54ab648.1786781008.git.lukas@wunner.de>
In-Reply-To: <f20e08ef831f0bad278adcec44046742b54ab648.1786781008.git.lukas@wunner.de>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 17:38:29 +0200
X-Gm-Features: AcwNN1Vq1PMq7E3wv9fUWHHP3igaw4g_WTuu4EAvIthleiRBL98udk8rubo1RK4
Message-ID: <CAPx+jO9zmCd5qnPooexeRbNfOo7g4-BKBvsW6ZVpxvR22bw8xQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx_pci: Cope with hot-removal of MMC host
To: lukas@wunner.de
Cc: Ulf Hansson <ulfh@kernel.org>, Ricky Wu <ricky_wu@realtek.com>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Matthew Schwartz <matthew.schwartz@linux.dev>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        linux-mmc@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=ePkjSnp1 c=1 sm=1 tr=0 ts=6aa02c02 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8
 a=MCuU1HL6lNEnI_cKlLoA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: Pt2QbZiEVYkPT51x6QtW_Kpo8ujxn47_
X-Proofpoint-ORIG-GUID: Pt2QbZiEVYkPT51x6QtW_Kpo8ujxn47_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2NyBTYWx0ZWRfX15DgsmSHqKb7
 rFlLSCbtdrsMt/wW/EKfuo29wlCnxgeXP6lQ3AoVHGgO2sYDbt5fU54PJy/Tw7qg3uSEoRMx+uA
 2xwcQBXrjLfJml2UVoNbKq8TsMXYKVxOvU+cDoEp0bB8sLVo0dm9ZhjoBZvSp9Qvzcebtgfom24
 fcP78aZcP8t7HB++O93kC8JcRqa0XUf0MzqqtXYQWJOlGKEHp2SnEWC7DNjXXAi8FF7bPu8lwCH
 TecZgUBMXRi6XbbHciCSC38os0yx0v5QSKkFN8Jvi+XaF1MEcgQuZ3ag2me6YKB2+TtMrz//3vD
 Nasbpv8MQ4CXfwtnkjlcnDU3PwJGfx1wcazo+Y+cjDVlw3t0y/570b5P64VxofSwzEpvsLLgVco
 BM1NXRKsAbpzQYhbXJkE8pZ3LIAsabBgIAd/flFte37CDB3HwMwEaoyD/MITrvYq8cLfGp7V87x
 PDe9qggnuJBuTD58SUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2NyBTYWx0ZWRfXycbKLV+OIAZB
 F57wJ7oI/tdhHc0/TIoFY64vs6OrXVwJEKc+1uQY6XBhu7qZLwowNc0aE3SRQyk9Q1v6M/dtTiV
 Pg2Ba6Z2kW7YDdkYbwlEa+XFmLeLl64=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080167

On Sat, Aug 15, 2026 at 10:10=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wro=
te:
>
> Derek reports a lockup on hot-removal of a PCI-attached Realtek RTS525A
> MMC host if a card is inserted.  He has root-caused it to the block
> layer being unaware of the hot-removal and waiting indefinitely in
> sync_filesystem().

Is this specific for a PCI based mmc host?

Can this be triggered by just removing a removable SD card?

>
> For comparison, the NVMe subsystem copes with hot-removal by setting the
> controller state to NVME_CTRL_DEAD in nvme_remove(), which in turn leads
> to blk_mark_disk_dead() being called from nvme_mark_namespaces_dead().
> That avoids the indefinite wait in sync_filesystem().
>
> Adopt this approach:  Detect hot-removal in rtsx_pci_sdmmc_drv_remove()
> and invoke a new mmc_host_set_removed() helper which in turn invokes
> mmc_card_set_removed().  Before flushing outstanding requests to the
> card in mmc_blk_remove_req(), check for its removal and call
> blk_mark_disk_dead().

I need more information to understand the problem and whether the NVMe
approach is really suitable here.

What do other block subsystems do?

>
> Note that mmc_card_set_removed() cannot be called from the MMC host
> driver because it is private to the MMC core, hence the indirection
> through the newly introduced mmc_host_set_removed() helper.
>
> Other removable MMC hosts, in particular if attached via PCI or USB,
> may need to be amended with a similar check for hot-removal.  The
> present commit seeks to get that process going.

So it's specific for USB and PCI, why?

>
> Reported-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Closes: https://lore.kernel.org/r/20260806214808.1202819-1-derekjohn.clar=
k@gmail.com/
> Link: https://github.com/ValveSoftware/SteamOS/issues/2473
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
>  drivers/mmc/core/block.c          | 11 +++++++----
>  drivers/mmc/core/host.c           | 15 +++++++++++++++
>  drivers/mmc/host/rtsx_pci_sdmmc.c |  3 +++
>  include/linux/mmc/host.h          |  1 +
>  4 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 0274e8d..1a82233 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2978,8 +2978,11 @@ static int mmc_blk_alloc_parts(struct mmc_card *ca=
rd, struct mmc_blk_data *md)
>         return 0;
>  }
>
> -static void mmc_blk_remove_req(struct mmc_blk_data *md)
> +static void mmc_blk_remove_req(struct mmc_card *card, struct mmc_blk_dat=
a *md)
>  {
> +       if (mmc_card_removed(card))
> +               blk_mark_disk_dead(md->disk);
> +
>         /*
>          * Flush remaining requests and free queues. It is freeing the qu=
eue
>          * that stops new requests from being accepted.
> @@ -3006,7 +3009,7 @@ static void mmc_blk_remove_parts(struct mmc_card *c=
ard,
>         list_for_each_safe(pos, q, &md->part) {
>                 part_md =3D list_entry(pos, struct mmc_blk_data, part);
>                 list_del(pos);
> -               mmc_blk_remove_req(part_md);
> +               mmc_blk_remove_req(card, part_md);
>         }
>  }
>
> @@ -3252,7 +3255,7 @@ static int mmc_blk_probe(struct mmc_card *card)
>
>  out:
>         mmc_blk_remove_parts(card, md);
> -       mmc_blk_remove_req(md);
> +       mmc_blk_remove_req(card, md);
>  out_free:
>         destroy_workqueue(card->complete_wq);
>         return ret;
> @@ -3273,7 +3276,7 @@ static void mmc_blk_remove(struct mmc_card *card)
>         if (!mmc_card_sd_combo(card))
>                 pm_runtime_disable(&card->dev);
>         pm_runtime_put_noidle(&card->dev);
> -       mmc_blk_remove_req(md);
> +       mmc_blk_remove_req(card, md);
>         destroy_workqueue(card->complete_wq);
>  }
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index b7ce313..2625d91 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -22,6 +22,7 @@
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/slot-gpio.h>
>
> +#include "card.h"
>  #include "core.h"
>  #include "crypto.h"
>  #include "host.h"
> @@ -703,3 +704,17 @@ void mmc_free_host(struct mmc_host *host)
>  }
>
>  EXPORT_SYMBOL(mmc_free_host);
> +
> +/**
> + *     mmc_host_set_removed - declare host removed
> + *     @host: mmc host
> + *
> + *     Declare the host (and any inserted card) removed and inaccessible=
.
> + */
> +void mmc_host_set_removed(struct mmc_host *host)
> +{
> +       if (host->card)
> +               mmc_card_set_removed(host->card);
> +}
> +
> +EXPORT_SYMBOL(mmc_host_set_removed);
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pc=
i_sdmmc.c
> index 8dfbc62..3f97659f 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -1511,6 +1511,9 @@ static void rtsx_pci_sdmmc_drv_remove(struct platfo=
rm_device *pdev)
>         pcr->slots[RTSX_SD_CARD].card_event =3D NULL;
>         mmc =3D host->mmc;
>
> +       if (pci_dev_is_disconnected(pcr->pci))
> +               mmc_host_set_removed(mmc);
> +
>         cancel_work_sync(&host->work);
>
>         mutex_lock(&host->host_mutex);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ba84f02..a240306 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -588,6 +588,7 @@ struct mmc_host {
>  int mmc_add_host(struct mmc_host *);
>  void mmc_remove_host(struct mmc_host *);
>  void mmc_free_host(struct mmc_host *);
> +void mmc_host_set_removed(struct mmc_host *host);
>  void mmc_of_parse_clk_phase(struct device *dev,
>                             struct mmc_clk_phase_map *map);
>  int mmc_of_parse(struct mmc_host *host);
> --
> 2.53.0
>
