Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D98219AD7F
	for <linux-mmc@vger.kernel.org>; Mon, 24 Jun 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240981; cv=none; b=CR1J+T/ul5Y2EpP6+4oqWbN841SKnbDGaVRkwSiAs4YwtlQUwYKWiUODI764D5OmgXt8vPnHamedElBCRpBQh3ibFBST9NovU60lUPW3PxsL43G1l8zubvng+8y7TIy3UyJtcPndUurKlh/Sul0CZpUeU7u3gl4yYvZe++CShOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240981; c=relaxed/simple;
	bh=ZBQar48FYlhHIVt6aU4MGvLcuwBzjjSKj8HeP0rbQkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mo2y1PYEU1eUvFkY2EYsjCnlMUxEaEiAJBiM11GhYO2kVYB6hCFRoU0QwsL6vECUm+AdGhF3VlMRvNISiHDoA0GayrsUjEuemQSP+aNT5axsqRgfAqAUywHGIk/cvwq3my8adoFV6AXIioOFbme9JxipoDfs8/89iTCMMlTbNVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pz94EVUx; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pz94EVUx"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-646645f1387so1195207b3.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Jun 2024 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719240977; x=1719845777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DVtwamYooPBNNQk9uWsNEvfA2DRpVaUFH92khkxMBaM=;
        b=Pz94EVUxwYNXIDWoZBemK9mzb9QpD8eGTieTsBWA0Br6tli+OYom9vX1MRVIjrnCY4
         IxrDl91/6tQdWTuYyqXlMWQfm0+atonkn4W99tyIH8+pF3fJGODfR482YiIX5H0a+niy
         nss/6ctn9pFJBT+0CooBasOb6dENknGMuJ4qLmuKarq8rajRQGbEDn84MA8pWzbn3HFH
         NZsuFdjqaCcYheAvA/SzP7WsrOBDX+NZ/PxKOpVYB8Xmhatoktzzqt/KkPuXYM3hb5bJ
         M4HlCb3f2SIvWX8bBqawYIKPsUrOT5cxin1egz6XD5JM/910omtR30oA63uVtvTvm6Er
         w2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719240977; x=1719845777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVtwamYooPBNNQk9uWsNEvfA2DRpVaUFH92khkxMBaM=;
        b=wf5+KG/xUtIt9IyvdVP9prDbIoXZFJE7EohN+pdsqfzK45h5if2TysZwWFRCwhrIvw
         UeXbuDNyhiWiPBkQ3WPio0iUSeD1prICT/91VlK+ZiN2p1G5fukGECMkJ3Bo4/wcSrgI
         2fvwBjwkZs5/BtQ3RO/c3rEfYT2Y3y6LtNGBi+3RxwLw8pPTG77Ut0yRI98Lw3sxm4qp
         YvAglWJuNpkeFDWyLFc6a/nq8QW730hYcuffCECDpNSWrbm03rxLfU7qO2SQJ+kDj8Yd
         SdNzG0nNKrueQPIdO2nFjFt6TMc/Z22b2apZAS7aCcweA0Qm6Dv0h1EYGv0DQWoGXidI
         rzEA==
X-Forwarded-Encrypted: i=1; AJvYcCWObICi4oQQaqKuzNYpLq2g42A6TjligoFPonDxaqPX4I0kraKgDUWkM4GBYg48sbSwpLNAEcdm+WFNwnqKIAPyHd85syLwiIvH
X-Gm-Message-State: AOJu0YzscGzXKKHgH1G+GY0IxwQOvoA2Z9OmIhiKrISwAtzGD97hAiwd
	uqX0JZjr97sQxEvblwmO9C51RDHpcZEOI78T5RzNuYf8NqTE1cLF+ASS6fIQaRIRy4fOrTkOI76
	b0OAh7Qipjg46cQFsrtOlaVF5VQ0KdCAjz9bNjQ==
X-Google-Smtp-Source: AGHT+IEbc5hc3/yxmZ3c7nr0SAMAXIEOiWKqkNHDXYZk/t2/ZjYEJo4kq6fQVQv1uhCgQ0NrpNYbn1L23nDXChNfGqQ=
X-Received: by 2002:a25:86c3:0:b0:e02:b594:51cf with SMTP id
 3f1490d57ef6-e0303f2b043mr4275615276.18.1719240977135; Mon, 24 Jun 2024
 07:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718897545.git.geert+renesas@glider.be>
In-Reply-To: <cover.1718897545.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 24 Jun 2024 16:55:41 +0200
Message-ID: <CAPDyKFoJiXLaXGg8_ykgFsda-sNkGC8gTL67yyDb+Lnpb0n7sg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: tmio: Remove obsolete callbacks
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Lee Jones <lee@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 17:39, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>         Hi all,
>
> This patch series removes two unused callbacks from the tmio_mmc_data
> structure, and related infrastructure code.
>   - The first patch touches only the MFD subsystem.
>   - The second patch touches both the MMC and MFD subsystems, and has a
>     contextual dependency on the first patch.  If really needed, it can
>     be split in an MMC and MFD part, but the MFD part depends on the MMC
>     part anyway.
>
> Thanks for your comments!
>
> Geert Uytterhoeven (2):
>   mfd: tmio: Remove obsolete .set_clk_div() callback
>   mmc: tmio: Remove obsolete .set_pwr() callback()
>
>  drivers/mmc/host/tmio_mmc.h      | 3 ---
>  drivers/mmc/host/tmio_mmc_core.c | 8 --------
>  include/linux/mfd/tmio.h         | 2 --
>  3 files changed, 13 deletions(-)
>
> --

Applied for next, thanks!

Kind regards
Uffe
