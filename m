Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CAE2749FF
	for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657925; cv=none; b=YEZtC9qaQC3cQpHGjJr9CPsHo8wwVI4PV8F2OIBe99mnhb4CIpKb/uaNQ3sxcZbfdmUqi7XouMNb4ZglUAJzmNcX0Iey647nh56MXJMT1xk5h8bSO3ClgwqqK63QBI8DL/UXq6wvh0JUzUrOP7HKFP+xPRbFrqPKU9M8eTL7WJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657925; c=relaxed/simple;
	bh=B2WwfTipKxQlOq1cUFi36X0EAQ9HHlrCBz+sQudDUhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttIkEksjKMMnSS8JI0uThI+kd++QbKzMQthEdN2U2bKd5Ah8jt4BEpqdWcjN/RvF1lTEbrSLLCGo227NAp6lVp2wEI8RWIyooJbFnPrUvt68g9uNT7pVLoRlhRDnL7Eom/ZtFadXekVv3QgGjIXzVd+iO5gjbdlE4W7rI2xb8Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o1X5UN+G; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o1X5UN+G"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e7b7dd0ec01so1822476276.0
        for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 05:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747657923; x=1748262723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PkcVd6knpz+a6Rljr/fOUGceD20+E1IMKnbjVroZ24g=;
        b=o1X5UN+GjQVSRjqOVoGde+OswSxBmx+7705uTqFWDFGQv68O0lPEfUpryVjWtQB81g
         U1OxKNKSS6xj9b0M9atAhV2X1dF2qPSc5Fm9mV8rqI1rtwjD7rAblIIUPp3rmKQi6FqW
         Oa4mRVpGRORDGWtQZNoNN9MfZQo1cFyKE9hi2ykyAFO+RAoxo006npKRUASyUv+/WCio
         yZXc0gqo5RUk8FvxSPtlKitTMNpjCWQBipnMRQOkWhgLv1ct4iWoBjvYklqRMXi2K3sU
         ly3OjQyBLRfDnuRd+Rh9QtwSHn0MuISngYm8n3RhEFL44/bqNF/GHrHRwIfFLRH9PKgT
         t6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747657923; x=1748262723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkcVd6knpz+a6Rljr/fOUGceD20+E1IMKnbjVroZ24g=;
        b=k5TJ1kyNDjOuRbjfUsV5nKDNBgO4dSdNv+v1ZHVCvf48W5DuLnya0MU+r0uPLmmNkx
         HeJbFvhzBJkXxQWv1N89OhH/JLi54cIsPUTUlNgI4shDSG4+V8mXo/+zX41J4moV1ARO
         QykoMEBbQ/KBIrK9QmLj1xS6NYZSTVsNiIqT1E5ob2+TjENTyeC1JwJH5WKaxqGOwdHd
         UjsHD4wKNkArB24JQqU8gVp9HoNMpueHiz0h72cwQGKZKq3+z0uKyvFCqgjhndNbnne1
         gaLw4dkOSz5AbZvaTx6nL2HdMoaMhYax329cu8c2qvj0eOM/0ru8wZaU8EiWmP4Wutg9
         /O2w==
X-Gm-Message-State: AOJu0Yxt+wy8P+An26P1g0rHMSC4/NAcwssOS9X3Vqhdwv7rl+dbjQia
	qhFlj7nlOtj1CnPtjCUc62r5VonNhQnxLPFT64eHRdSUJWRb3HRDcgIgbVbfhvZVHl4tNMSDlqJ
	o9o5So5GnjO6L2xDA9Zy3iREIEWXV7k33y4KqV7Xi34u6bmyojEY8mBE=
X-Gm-Gg: ASbGncv0hNaibmm16b5AnAcKWh+kVbvQ+bj++Xci89gFQuoizXDNg/kcvWy7MRUM30R
	sxU89bo2qgWnjh3mfwcJ7wA7b6J68OZ4LCxXg9HSxHcnwnXG6N1KBWD7meJQncSpz1Ifi4KremF
	Nwa4J6G6HySxhieCFiJNiOXLp4MtKhMkZIzQ==
X-Google-Smtp-Source: AGHT+IG5+u1vfSprxSClFpc07ybw2Y7N+irmyC6DINg5usZxmZdAscI+5uolLwI6zepa0rmcaLpbdVYh3pFSV3nVSlg=
X-Received: by 2002:a05:6902:1401:b0:e7b:607b:54b7 with SMTP id
 3f1490d57ef6-e7b6a08f05emr16017090276.24.1747657923028; Mon, 19 May 2025
 05:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507134538.575912-1-loic.poulain@oss.qualcomm.com>
In-Reply-To: <20250507134538.575912-1-loic.poulain@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 May 2025 14:31:27 +0200
X-Gm-Features: AX0GCFs5w7tHoN0l-MDsPIk7pholQ-ka81NrZPt58hkMq1CkW-9Raoq5h4tCZXk
Message-ID: <CAPDyKFp_dPcxScHbLkuxXK-scMEQoNGR_iqEPAxG_b1OyAF26A@mail.gmail.com>
Subject: Re: [PATCH] mmc: card: Scan the eMMC boot areas for partition table
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 May 2025 at 15:45, Loic Poulain <loic.poulain@oss.qualcomm.com> wrote:
>
> It appears that some vendors provision the boot areas with valid part
> tables (GPT) in order to have identifiable partitions for device and
> firmware specific data, such has the qualcomm CDT (Qualcomm Config
> Data Table). Additionally, these boot areas can be utilized to host
> device-specific IDs, calibration data, and other critical information.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 4830628510e6..c81925194509 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2655,7 +2655,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>         md->disk->private_data = md;
>         md->parent = parent;
>         set_disk_ro(md->disk, md->read_only || default_ro);
> -       if (area_type & (MMC_BLK_DATA_AREA_RPMB | MMC_BLK_DATA_AREA_BOOT))
> +       if (area_type & MMC_BLK_DATA_AREA_RPMB)
>                 md->disk->flags |= GENHD_FL_NO_PART;
>
>         /*
> --
> 2.34.1
>
