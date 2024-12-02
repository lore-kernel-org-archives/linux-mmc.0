Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4046C20A5DE
	for <linux-mmc@vger.kernel.org>; Mon,  2 Dec 2024 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153064; cv=none; b=WAboE1E93k1JH+2JzpWdH2QotjQPiCeJnNQFNPhDXCho/2S/hLMKRMxyD18O/gVVHeL/NIOw208YelY3twn1OxldHkvTHjYynj5lu6e5WVF54uOP8Dd5vfn1IjZhy1KpUF2pcAoTNoa7/rdax04NZYwpUU69i3HhSpfWsDjXNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153064; c=relaxed/simple;
	bh=qZm2KgsEJ38TPHYdjq9Zo2LO4g39cxagPWg9KcYzWCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDHam8zzlVZcqagzOhZXb40JA1dAjcz6c4LkhpZXnXobE1r+FB81i86jQrd9ILTMbP/C+Rk9P25iAbZ8TY894gAurDyfm1IbC0R7sD/mwVFiGH0+GB5XnmrrWcuRJBpjmyHeS6c/P7YWo2GrSiWqGjOk/BzneDY5OQdM1W8HKwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J1TA5ZOI; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J1TA5ZOI"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e39841c8fd6so2949450276.3
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2024 07:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153062; x=1733757862; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FIEJcaSGdJPUD8j5XlztkJ0eGqAbM3m0e+k9lVXSNJw=;
        b=J1TA5ZOI/qGuhfeVahKyOFtM6RhyQkvttXWl78PLj4cceNNsROR24vXz8PB3EWtXyd
         qL1kXr+swzAI4RT9ie++0lpxrXJooGjA6RdmcWjL4krpVTG2Z1P1Tf1ypR2oHkWekkgN
         P8GKfVHh1AgKJfF/gApchb++P4eUSHGtU/5Rrp9VitO1IzBrHmu89wYFmADIYKZdzj/M
         mzuQtGj9bTKB8KYliqJtvOpEEIV98OB3TFbeVA0nwND0yyAFS79qRf5KFoo8AyiASSsJ
         cz1NDblrEQ8vw7emQ9NyCPSHfA/KRaGlvqTPtdQT6p9nj5ehpkmi7z/8ptVKNwvodb5X
         S3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153062; x=1733757862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIEJcaSGdJPUD8j5XlztkJ0eGqAbM3m0e+k9lVXSNJw=;
        b=T3T1pBxGRWKXMrtVuN8OhOp3JPioSY8635NRO6FOOe2sd/FgmvQp1CbWXF9PSEWd7G
         10MtYwMc7Ih11im2kDOgNFwn805plr+VESnx2tK6nJKAAM5V1d2t9O3orXJ2Cieu1+X8
         eb5jM8xV3MVlEmwA55e7li+kgu4OJRcfAMiz6R4g3T+pRSrG7KrMe5qEnK/a3AE+enXC
         DjiJ06dKRATfq+qEWuY5Kh4uqIqDo5HtrqDcj+uzq+BD/U/LST5538O41oe5qafd+16U
         psVIrdprLBZq7D4YPGrdxCDHfpxCFie1znOG+v+JRlWHNhA7c47/+io09rAz0ySjaaen
         FSNg==
X-Forwarded-Encrypted: i=1; AJvYcCWKe7hxmXEhIZa4XNbv/qYxOI5wj55Z2iPdwkMcGU2WgiIvcUCBythvVKvWggTyI4GdfPZ4QHjR/+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlaZ02fdFVLrwqaitqKEg//95tR5CGAZYD34G7IXRW9QPkElKa
	2L9AB3onOTURCDaFI/MiJU1iSpxDgj8mKPefHp8k+cwlbxCmrx97/RaYjLVbE4q4LE3k9alnnqG
	24gwJK6f3QRDz7mqUyasLK0zmQp6NXEDhy484jw==
X-Gm-Gg: ASbGncsFA2jE6QRqp8YTwcWKPldb5swbiNp0bXV1jf7bv5p4m7ZfJdaPw6DE239jcVt
	TVLzVRoFZe5NY52wtYBEqrHfuN91sF74a
X-Google-Smtp-Source: AGHT+IGecYwU3LhrUSWFanjb/IVeaGfWBi0iqpClqfJtpXMYSm61w6LopRzGpgTzgxbggBLwJS3eaTaanLLSHlemPmE=
X-Received: by 2002:a05:6902:18c6:b0:e33:1c36:6a4 with SMTP id
 3f1490d57ef6-e395b887349mr19416613276.3.1733153062390; Mon, 02 Dec 2024
 07:24:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126125041.16071-1-andy-ld.lu@mediatek.com>
In-Reply-To: <20241126125041.16071-1-andy-ld.lu@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:23:46 +0100
Message-ID: <CAPDyKFpSQj295wZf=mOPmSaLZvi769EdgFTcPJ6QRY0sOHA89w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add mtk-sd support for ignoring cmd response CRC
To: Andy-ld Lu <andy-ld.lu@mediatek.com>
Cc: angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
	avri.altman@wdc.com, adrian.hunter@intel.com, wenbin.mei@mediatek.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 13:50, Andy-ld Lu <andy-ld.lu@mediatek.com> wrote:
>
> Add the process flow in the host driver to handle the R1B cmd response
> type with ignoring CRC, which comes from mmc_cqe_recovery() in the mmc
> core. Additionally, the response type 'MMC_RSP_R1B_NO_CRC' is introduced
> to simplify code.
>
> ---
> Changes in v2:
> - Change mmc_cqe_recovery() to use MMC_RSP_R1B_NO_CRC response type.
> - Remove MMC_RSP_R1_NO_CRC in the host driver after it is dropped.
>
> Link to v1:
> https://patchwork.kernel.org/patch/13883787
>
> ---
> Andy-ld Lu (2):
>   mmc: core: Introduce the MMC_RSP_R1B_NO_CRC response
>   mmc: mtk-sd: Add support for ignoring cmd response CRC
>
>  drivers/mmc/core/core.c   | 6 ++----
>  drivers/mmc/host/mtk-sd.c | 6 ++++--
>  include/linux/mmc/core.h  | 2 ++
>  3 files changed, 8 insertions(+), 6 deletions(-)
>
> --
> 2.46.0
>

The series applied for next, thanks!

Kind regards
Uffe
