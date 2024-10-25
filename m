Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1E314D6EF
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867919; cv=none; b=CHn+iT8QcK3Gxgne/Yz1SxI0HLLoHI8Fofl+yfEn7GEhDas3660CaNJIZf89yWJ7XUjMpl7b0071tFskxC13UZgy50RYhxg4SB9JZXOQxoKTcA9fy2bTMXEM+xF85ZOHfxFiLBzkLjFdlktM6N+sMJu7zXfrfyMf1zawWOg233Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867919; c=relaxed/simple;
	bh=Vx8Bd9sC0kDg9EtadUja5JmXpyq7Oneb9WEXhTdHlV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWCpvnK0+J2eMdt+RxObQpUXhFT3OyZWiGKSPywF1M6UAwSWkwDq1XeL1uj67MzDkp0ls8j2iVtZLj5cpSSAwvgi9iPlLFdQK0hSSrTw7r2i4DG0HVxiYzCOA/PQG6et/vjnZVw81fI+xsAwlV43Cxay5NVrokHxCUjp4AbA+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DtbbuTAr; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DtbbuTAr"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cb6704ff6bso2781425a12.3
        for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 07:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729867915; x=1730472715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XR/4Fvu0tMyoCCtOc6mB1xqHO3YtOWoM5ClealtuxgM=;
        b=DtbbuTArMtW2T0bqSX1pVoWD20AfmSyMOJ8GbpoFowvd4ffVs/ujY1+qCQFqAFkTge
         FquSFOvIjFqwj4y95Px555IpeFfQYj1/S9GqyZEgM3fVd2N6mvUMzoDge2C7Y11L22To
         DW+BLGcnLneLl06Tn3ZeZIPnlK6fUTLzJCynvEGqzI1FZ/tg7jE5oK/OM7I406PadcfQ
         FWGCDw4zSA/kf2Fpm6o+z09329HNieJCK5jW0aklvKlTF2fiqFXb1pwJ7E0BsooJ3D1K
         74CIdt56kYTJTjmu7uqASx45gL5mArJc9uCEY4p9vF94DsZ8Djrua3h4iIFnK/QRLnw1
         egJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729867915; x=1730472715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XR/4Fvu0tMyoCCtOc6mB1xqHO3YtOWoM5ClealtuxgM=;
        b=i70gycA3kqcpozNquAF4at9CnzrUUCRfUCZvvAIn/8kEB16ofVihAFRhK5WtXKPJyV
         4nW+WUVjkORrWhsc2bJCoAG5QEOhg1Rn3QH0JwIFNtZOe50sBNStmPeFb61rQYmtFQtv
         NSaC3zsToKQO98cp/2D7nz9Seh5rXWil3hyu0lgt5DCG9s5HjfWoPrtwscZ2G3VHjNun
         7lMC20nQ8/DWfyHreoUu77wM5TbdUzmD8fMDbcrBwK1vjWTUUv4VjhSlTPl609dSmO8v
         3bQo7esbXLI+u4jp3+YtW29vbkgFDa8GBoBXlAzsZhzNEOrVCG32rIhptg20l/livvyS
         PlQA==
X-Forwarded-Encrypted: i=1; AJvYcCUmqlLTWNUAeiB66UXBg28qXwRAknSV6jsgn1gm40uopC/fWcMqmeK+IhFiqJTt2VBSRwcK68c5rwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZuTMRkYfdRZeJasaALwAOnRCoFmXTBn+nlI6hH32euFd2hiLn
	vnKJb4nFAYfnljXypMD/8ydgNNLCZCWeepVmNCQVA8QbKGLtVl7rlGIEdq6xHNV2oUktVg0ZAQ/
	TVkmrHwWI+zYoYbxkS0IvAO8aYcFy9y//V2y3oA==
X-Google-Smtp-Source: AGHT+IER6oLuLAmMqy0L4qN7TusuZBghOustjiSV8015jNjOqosSq06NJ/Zu1YsQk+kV8Qw7CqO4h9Ex1wfPvyXxJpM=
X-Received: by 2002:a05:6402:1ed6:b0:5ca:18bc:8358 with SMTP id
 4fb4d7f45d1cf-5cb8b264348mr8002531a12.24.1729867915170; Fri, 25 Oct 2024
 07:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012143826.7690-1-linux@fw-web.de>
In-Reply-To: <20241012143826.7690-1-linux@fw-web.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Oct 2024 16:51:16 +0200
Message-ID: <CAPDyKFp192dy_OXXYk5zqJQPUvrTwkQYPaMoFVsHHQiO74U1eg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add mmc support for mt7988
To: Frank Wunderlich <linux@fw-web.de>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wenbin Mei <wenbin.mei@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, daniel@makrotopia.org, john@phrozen.org, 
	eladwf@gmail.com, ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Oct 2024 at 16:38, Frank Wunderlich <linux@fw-web.de> wrote:
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> Add MMC-Support for MT798 SoC
>
> changes in v4:
> - drop minitems because of dt_binding_check error
> - explain mt7988 compatible with mt7986 platform data in commit description
> changes in v3:
> - use mt7986 platform-data with the mt7988 compatible

Applied for next, thanks!

Kind regards
Uffe


>
> changes in v2:
> - corrected minItems to require all 4 clocks
>
>
> Frank Wunderlich (2):
>   dt-bindings: mmc: mtk-sd: Add mt7988 SoC
>   mmc: mtk-sd: add support for mt7988
>
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 22 +++++++++++++++++++
>  drivers/mmc/host/mtk-sd.c                     |  1 +
>  2 files changed, 23 insertions(+)
>
> --
> 2.43.0
>
