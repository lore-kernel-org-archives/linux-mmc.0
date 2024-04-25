Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3AF14D458
	for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062148; cv=none; b=tfP+9+ch/okYkBhERyvpvMnRT+MSOmGYkyG6dxS0CB6fseYcOycZW08rF71a26cVz4X3vz8Xs9D+3FrgRRjrhDwM5zXy2ABnd/H6vxxLVsIBRLCgtmnaQmR08fHuZvaDppPuj2tvf4zRJ4C2imB/Bfq/konwTpwrTqQITTS0g4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062148; c=relaxed/simple;
	bh=TQGz810qVorjzT2SCJvB5PZWMZGKqnSar9VuHWSYnZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joJ/MfRPSPtao/+/+uHsFljCE+Bbb3U7RP7/OE1nP5iomjM78AiKRX1logGaJCUuW9hjWP47cUfytJb0q4WxrbkwNTk6ul7T0d5+b0G8a9NvicxnJM2n6m5Roftpr55m1o7xFVDL33tp2kdqekoJDiJiaqgPm4RXXz1/ZBhJnnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cUJar7cJ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUJar7cJ"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de54c2a4145so1459255276.0
        for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714062146; x=1714666946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uckQ7GUGnyuHf/CUMEuk6+EhQ8OV5XYvc1G4DuM47Yc=;
        b=cUJar7cJigCQSVNAWfiPMA8za4HMXNMJMJtwFuae2U+tmw2mNHL58f0n5OtBRVt5F8
         5es+ROXw4xatdcb8h9MbpLZQYNOI1QiGZo3pGGeCwkb3ivKeuhnGEOSqNtt5t5M3VIkO
         vXQtrV9DxM3eUB/M61GVnW77VPG1DmoEDwn1w7apPwa6Feb0OokZlSmCQeVOjCHxPKah
         smF7vIhFpFJhEd7NE1JFq8PrhT4AeFJGeNbKdDDWERq7HtPKlnohdHeuFcTsgXGZL+lj
         H9d2oUbyNM4mSHHchlMIq/FHHZm8Z7ZbPnAf4mfFc4QOdy7muOxaWRz472TMAK/yUEtj
         CbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062146; x=1714666946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uckQ7GUGnyuHf/CUMEuk6+EhQ8OV5XYvc1G4DuM47Yc=;
        b=qKQ7ZwDoVGVZla3sBnq7l0WymmP5CHfN9fiOSrKNsVWz9ukIRytLwBeFNsOnIv4Qs/
         mtiEOEre0XLV0C9BMQ8j5xnQMB7iYKyK7FkXScNXXApLmCmeYECi/MVJJ8/UL32YtzvX
         6YkufOn0bzBCRng5cKcQZrklZQVGayx0Diq1+IsUtjlXB1XUynFR1zjkAsQqdCh2Fxtb
         rm7eoYFW+fbaL52FCQp/6SEiKwZUadV+TpKMRMIKQM4watIpJBbmc6KmOUmPzsCF+pKx
         0WnM3CUZBxrbGOuP4EZY4xKPCp/V4yc4nxDrWoCbdKDiBVzcev+NckCu/2dneGs3XGHW
         OxFA==
X-Forwarded-Encrypted: i=1; AJvYcCUsHDHcYGh3ibkY0+QLLdLbhFyQiNAxLA72eIaCeDU3vmr2pbBmdglSCkQEWzAI88MuCInlmD4ZUTw9vM229KAi5/3U5AhlKnkf
X-Gm-Message-State: AOJu0YxpwIIgM/Ygzb/MiIevF7zA+WJpqzIztxme/BHFUGNIH3eiNAUR
	1QpzRqkQL+E05WLd44t6wBOlhueFSKFHb3mDtKiLeam8m+PZ8oqERXkz64Lu2B7muBVyYcfyiQR
	O28QFnr86SsG1XUcNcPLamuuOP61jEXizii937iqhcgUJ/8DX
X-Google-Smtp-Source: AGHT+IHXUgZOyo29WHXFr42fE9Qj3JEWVngCnGnRl4KRg/weGkZhblZN42llkVAf7aBmi5INSm6u4Nme1G83G3oQmR0=
X-Received: by 2002:a05:6902:230e:b0:de4:7831:919 with SMTP id
 do14-20020a056902230e00b00de478310919mr132403ybb.38.1714062146511; Thu, 25
 Apr 2024 09:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414164357.2841-1-jszhang@kernel.org>
In-Reply-To: <20240414164357.2841-1-jszhang@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Apr 2024 18:21:50 +0200
Message-ID: <CAPDyKFrzCgwXcwopK8=wP_d5NgBJDMwLLoAM_LqjhsB3g_T=7w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Remove useless "&" of th1520_execute_tuning
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Apr 2024 at 18:57, Jisheng Zhang <jszhang@kernel.org> wrote:
>
> The preceding "&" before th1520_execute_tuning is useless, remove it.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 7b55acd9830c..6206ff7615e8 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -822,7 +822,7 @@ static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
>         .reset                  = th1520_sdhci_reset,
>         .adma_write_desc        = dwcmshc_adma_write_desc,
>         .voltage_switch         = dwcmshc_phy_1_8v_init,
> -       .platform_execute_tuning = &th1520_execute_tuning,
> +       .platform_execute_tuning = th1520_execute_tuning,
>  };
>
>  static const struct sdhci_ops sdhci_dwcmshc_cv18xx_ops = {
> --
> 2.43.0
>
