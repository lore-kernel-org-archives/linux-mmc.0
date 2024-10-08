Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFBC1E0086
	for <linux-mmc@vger.kernel.org>; Tue,  8 Oct 2024 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398218; cv=none; b=O44FhAL98TvGhv0+C19h1QL4JwaeYycw7wqWSUQropYc6cTiXhGbbiewcNAYRFbLo8ks4ljvk6nQR3s++E0oQ+L4VVVL6+gc2ClAOwATZQPkycM96KncHChgoFBAtIT3KsAfraPMaBxojRLQ3Y6nlvj/zqRYV8ZYProDRh3zEJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398218; c=relaxed/simple;
	bh=GEH0TORf5ghIciVtZ7HkHhLC7ZUfQAQZ3HuiMQ0/5yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccKJWgX5vPo026gDGeeQG6qBrrPxW3KE+ZdjZljihY0bebk+Rud8vhTrt/AMJePL8DA3NAbSxWmaTGOvuHB0WERcfEEWYD3odoDJTSSAis+pez0gbmXRISJNBRTZgCFcsYO/Tr5TaphJGGCDGsBilvUOlaYcV3DYepHoiJhUI9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rZCtlbn0; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZCtlbn0"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e263920b6bbso4645915276.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Oct 2024 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728398215; x=1729003015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N9oq3jezHlQMT6rg1nSIemrSZ1OTMBtx54B/fq7slMk=;
        b=rZCtlbn0BqM4tNGM8i+tKTZDLI9h5DbaB7OTL5mooQ9LLpNuZUcNtJvRZocbX9lpO5
         Qi1qRwlqwYtADdCvbaA8RjjLzxK6rlSZ9hFJSn70+mjB9r66ETwlW+H7jeRvkICLS4Qt
         BxMO++IBOX782GYRyhY4Bd4z1yJ47XAGYU6iPLQtemVSCesJ+Mx7FS8nSRewLA9zv9XU
         Ax5tqflqrz0Tb1cZ4jFK5wObgXHi2bxQlw9ow4mOG7ky14Ynu03yPn7WDbuTT5nZ+pP3
         nvGxw1X6S/rUwoz+O7Lu7X7yQK86QtxnJjPP3ow4fx10o9YGlPWMqwxmNJ/mhav6xgJG
         hiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398215; x=1729003015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9oq3jezHlQMT6rg1nSIemrSZ1OTMBtx54B/fq7slMk=;
        b=vzCoqn7xQo5d03D5riSFpeWhMcqCejo9i7fXM5g6+RiUbk74B3lqOMlNbTaUl/ATtI
         0InzP+BiMLJpE+uh4MFIfmU2F2+2b68+OSRxQlWm3AKjiy6W1QjISfQSC+OFABFiAfdg
         p15sRcaYootY+diNnK11ApC6Gm9KCR7xSs6ymQnod9QlpSHDIyloqHJUDWSnwVJFp/eW
         0zOBaLxRS9IFB4nwTpso2v9zs6+7PyONiH+9+QCWkeZDxSkjNY3Wx4+2/WRwm1ZX6gxr
         BSa1SJKZicQXRoLlqzxoU+itWXvwaInB2aExLOX3xXd/CcXqweXfjqFwjeZ4awEeHf+p
         qMuw==
X-Gm-Message-State: AOJu0YwEQc4a4SLYoHt4jn+KciExMwouMV1eChZGjmiDvUfpSUNuTxXi
	GDo5jiMG6Wg5Td9a8py+Tj/9W+ytlj+vIhURgtj9Q9l/VnnonuYu3T8/D9hFogTCgq9RNtSJ6Rm
	qEfFr4lDqMcoVGxlR7FsSKASNN8Z8/IIhbhYnm/CvruxTtXev
X-Google-Smtp-Source: AGHT+IEjM292qoxRSTMVZiEHGGPCXwidKp0QKEL9SSYcSrYZB36fSHw7uDxBp6+cKhZ+mA+gwRbbOrFaFvtkEpLB0WY=
X-Received: by 2002:a05:6902:1a4a:b0:e28:6b10:51b4 with SMTP id
 3f1490d57ef6-e2893951ac4mr10369636276.46.1728398215648; Tue, 08 Oct 2024
 07:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930224919.355359-1-rosenp@gmail.com>
In-Reply-To: <20240930224919.355359-1-rosenp@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 16:36:11 +0200
Message-ID: <CAPDyKFo69H+653J=7eDqTSm2gz_AQH-3R+axqiTWqumOPQM9GQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] mmc: mtk-sd: add some devm
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chaotian Jing <chaotian.jing@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Oct 2024 at 00:49, Rosen Penev <rosenp@gmail.com> wrote:
>
> Simplifies the code. Also a bugfix with devm_clk_get_optional.
>
> Rosen Penev (3):
>   mmc: mtk-sd: use devm_mmc_alloc_host
>   mmc: mtd-sd: use devm_platform_ioremap_resource
>   mmc: mtk-sd: fix devm_clk_get_optional usage
>
>  drivers/mmc/host/mtk-sd.c | 70 ++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 45 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
