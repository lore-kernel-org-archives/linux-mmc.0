Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D81209F53
	for <linux-mmc@vger.kernel.org>; Mon,  2 Dec 2024 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153062; cv=none; b=lRVnJmicFWm1q/ITxxeOZhhBnNB92Ey98WiNTm7Wxihd4eBZZsDPcC+qyZFweBzp6N9mDdI5zuQijoklXsNSwaXSXM+pWCHoxa+CVrZRBz8QMSEsyz3+VJ1cudQdc/z+UEcZcjdl7vcMtalNOKyk/9bCpEvoRfIPPYZrH887RwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153062; c=relaxed/simple;
	bh=s+q08AhHsFGE1EfP39d6m5AmxX15U2YOkkHYuDiep54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1LHZkvI+LcR9vMfbVKo/FvLnlvLj2i2HQxNUL3F/XHpY6ztz7wlnD/3OklLPt5Bav1r4RnYSiUFf+ljkRqdmwmrdYvCLiPjKqW5MfeabBMtZRL2upBMDFKUvXM2+n5onH3640OJKVHGohJyK3bRLM73gAj7TlgJhLRO6Ce354Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GaUvdVgJ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GaUvdVgJ"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e396c98af22so3587062276.1
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2024 07:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153058; x=1733757858; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vZdmxpNfvpO1w4hAAEKWGZSvaKeExVY5BF0241uhp8o=;
        b=GaUvdVgJpVtPmh9fidIX87aQxQIlNacs8Dg4iPNAj8wv7lOdhvlkuqeW37fU60tbsp
         0BFYezw7NiTSWu42tbhjtoL1ENyLJCGa42iGDPUd3bFVeSMv7fYGC5iboAOPtz6/ZthX
         AwJqE8XlxaZ/uRxjAtM/IT3wEgtHy/dUGwPENge/ueb6AAagvCv7o8nN8fkuslHb7E2K
         xUpF5XPsuimcIyPgwPShSnMJPoh2M9tzSqI+NdchUCmIXAkF3xLJR4Qs3cKIRJWxdM0S
         69Wmkkl1sC4gJXc9CpU/ZNk0qbkRh8JLH1QBgqt7MF7nHP3apCmaEv3KAmpk8OvelwKm
         9K3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153058; x=1733757858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZdmxpNfvpO1w4hAAEKWGZSvaKeExVY5BF0241uhp8o=;
        b=paCMjfxOEgZ1iTJz0MhNp8vsW+OQ63fqO5T8F1ULCOEQOdiCBrOBvJGcgdU6WmQV9R
         cq9REvDGzaylPcVqQQESwENS40KYyesjLIU0icj+HA0bo9iaMfR7/OMMPGHQUunvI+cE
         PR4Cgr2mjpkXCcWpzyPJ0ymFyF8QlDL+FTGz2JSXr0rnX7p3AdQBUD3dJwUN/jNDAmFi
         iRUAdLCpbnON3e+O5jr20rSxtJvkIasFtYbW5Vl5zzEOZxmKigDJlwF4WUB7NQCmPCRZ
         nmwonmijqzV/N86Q0/0lj4EHxvShBdnH+q/76f+Hl9ypw2k3ddXngpwbwWhM3vCtRegT
         hs6g==
X-Forwarded-Encrypted: i=1; AJvYcCVhIFhvKPfW1/S9lsc1furd/4HHYoup07/ObBXMbgvcpLqohHpLTsVPUKf0sl9Hd+hPvgLw1ocjQXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3IDhW60Ld7dNcuuIDuwUhykKu+j7h6Y5MxMTWphB8ZTdQD2rM
	AIj4haV2aFUfgWYOSWrpMgs7xydwGpEEr4CRHuJMlfwNdyIoEi1Kd3CuhFPaUYJd5oQZbYJHTAG
	hEkPaD3UXUWNOT5e4CTlI1JmNaM/rm845hkyVqgpZyzcXfwxi
X-Gm-Gg: ASbGncuSrcqm1H1wnQn6Fhr+ibJ/Wb7lIdd6YgFqcM1wxWuht4DvcDKjFq+pEApbfUN
	WNFgpccLJn6ucax5Nkcl3k7zKpO4V0rbb
X-Google-Smtp-Source: AGHT+IFOFC5zPUF0itgIKsAUHr0BlLtuJZtIXZEze3rfpOri9Ohtmk1VeC2LzJL5dOFw7QQghHYnT6Ig09tgFYZXMYk=
X-Received: by 2002:a05:6902:18c1:b0:e39:8482:5d5f with SMTP id
 3f1490d57ef6-e3984825e68mr13245250276.46.1733153058435; Mon, 02 Dec 2024
 07:24:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125083357.1041949-1-ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241125083357.1041949-1-ciprianmarian.costea@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:23:42 +0100
Message-ID: <CAPDyKFpkSRmGhZ68m7TyQNSqYKa7gnHigKpu4nKOpb-HWfCdeA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: enable 'SDHCI_QUIRK_NO_LED' quirk
 for S32G
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, imx@lists.linux.dev, 
	linux-mmc@vger.kernel.org, s32@nxp.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Christophe Lizzi <clizzi@redhat.com>, 
	Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 09:34, Ciprian Costea
<ciprianmarian.costea@oss.nxp.com> wrote:
>
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>
> Enable 'SDHCI_QUIRK_NO_LED' quirk for S32G2/S32G3 SoCs.
> S32G SDHCI controller does not have a LED signal line.
>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index d55d045ef236..e23177ea9d91 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -304,6 +304,7 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>                         | ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
>                         | ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE,
> +       .quirks = SDHCI_QUIRK_NO_LED,
>  };
>
>  static struct esdhc_soc_data usdhc_imx7ulp_data = {
> --
> 2.45.2
>
