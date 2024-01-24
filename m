Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E1277F25
	for <linux-mmc@vger.kernel.org>; Wed, 24 Jan 2024 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104207; cv=none; b=QZNzVVAI38XOsJ/4GuIy62DCRZXCTeJja6HZsIWExCcV9w72wIhuhQEPrnq1ZaVV/RFW+63YHegPE/xY6xB775znAlRK3etIMGJN3Z3vmZCL0Y5F8lTLViH5QjhslEjcxnnWr0MaKwwd0q8La9ZA1KSqcZhZ8Dr7x6ECl50C37Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104207; c=relaxed/simple;
	bh=jXPBYAagK8EA3ievWmjEOHXCT9Shr1O9TiIbD9b38Nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HktVVCTRqJrsTK8DEIXzjeecLdZt2xUJTo1ePjRIMWddcZNetqelXlp9MAFx+8rMwWqWg/meVJvFpronZ8cJEkI75gTKD6DMkyfNCeFveh5YL8GY10fP0j6OMLSQmCANcwQI+SQOH7dE4onrw33jX8QAKzeHVIkX2IYShPcLnPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wMobbZeM; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMobbZeM"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-600094c5703so29346937b3.3
        for <linux-mmc@vger.kernel.org>; Wed, 24 Jan 2024 05:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706104204; x=1706709004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qD8eCabc6xT88U9vgGaNrK+4ZzkdWd3ln2/qkeseZmA=;
        b=wMobbZeMyAhHceDnWU6EXZOwGYHaMQyvNjkChUgKDGWl/JYox0a40Wa1KzwmAO3g0P
         lEIUwCUHfZ2MHkEqZbQxJI7GuNrYOA0JsOvikvadmYlFkVBuB4OwBBzIG/3TANOYldEH
         lZCqYe7L/AL4LYYe2bfxQCJYIjCcoGSZrKzbFJgIpcQ0wbUbtC4nhr6XlhIccmcqJMZP
         Vgr6+agSiC8AqZ7Snoxv/D06+w5bYsdLcISEoTCIQXQUwoghfG0jCF2zNuocsptWZ++P
         lmhS4HSqiiDZ4zrnfBxC5JDEhQvVxp2K6v8fzPxCpCIotDsy1FVstrZPyEmcNtBK8lc3
         xytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706104204; x=1706709004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qD8eCabc6xT88U9vgGaNrK+4ZzkdWd3ln2/qkeseZmA=;
        b=QoVBhX39nTX9bRzrmOp5Y5vPbWZcY5/iFCJVsXFix6YaXp6OPKHDale+Wy9rf/0eDk
         5iDX8gKFbeDibNx4xyzSZoXtbqCwPkzE1NbRrmOUKz8uBm7wsmhjtKb3xx37EG5hyPaR
         p5GT39KwkI2RoC092u3ty4MUdH6Q9VunGWagZkDSFWbg1zq6hDF1TToqD0RxfyR9Tf6i
         89Pwpx7CdflKH8svrfN4aHldpoATCFWrmwQArPP5kVWfmqz9gDq+HY1SyHLDxjKOQK04
         hBoqW67hf6rmTHLXCNWeZ2/fypVt7S6r5XJFqwOwO8XBSXAripI86veW/Ff0U3lSTMJ4
         RGlA==
X-Gm-Message-State: AOJu0Yw3ouXEThxMj5ww80RP1MdeBT/Qw5EOKVXlnb2t9taRBlbyAalJ
	6UTUOspliEw6HmWcbjRhEQc/g9v8ElQz2m64f4CK33tNoKdqU72IeB/DPmZl/Jh1zN4j+wDbpLN
	smiMnp3DZisPZiL7Gflc3a/39g2SGD56IBBLoIQ==
X-Google-Smtp-Source: AGHT+IFRcJmq0QGWOM6XI4oBVDRq6qnC1eHWqlrNfABvq+kFzeOGOGf3xTagOrvKzY6Fbgk+0l6SOH5mWajFr4psDtc=
X-Received: by 2002:a0d:ead4:0:b0:5ff:529c:504d with SMTP id
 t203-20020a0dead4000000b005ff529c504dmr770995ywe.79.1706104204464; Wed, 24
 Jan 2024 05:50:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112054449.GA6829@lst.de> <9eb0f18e-f3ce-497c-931d-339efee2190d@kernel.dk>
 <CAPDyKFpmEB9FGAmGAQNdEH+DtRtcCNnFszfv_ewihzUU9du+Xg@mail.gmail.com>
 <20240122073423.GA25859@lst.de> <14ea6933-763f-4ba7-9109-1eea580e1c29@app.fastmail.com>
In-Reply-To: <14ea6933-763f-4ba7-9109-1eea580e1c29@app.fastmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 24 Jan 2024 14:49:53 +0100
Message-ID: <CACRpkdZKwHdPsR8KoyrhDjihLKiP5GdEgtYi_p-7L8b4_Ty_gg@mail.gmail.com>
Subject: Re: mmc vs highmem, was: Re: [PATCH 2/2] blk-mq: ensure a
 q_usage_counter reference is held when splitting bios
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>, 
	Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 10:26=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:

> I found five drivers that have a legacy platform device
> definition without a DMA mask:
>
> arch/m68k/coldfire/device.c: "sdhci-esdhc-mcf"
> arch/arm/mach-omap1/devices.c: "mmci-omap" (slave DMA)
> arch/sh/boards/board-sh7757lcr.c: "sh_mmcif" (slave DMA)
> arch/sh/boards/mach-ecovec24/setup.c: sh_mmcif" (slave DMA)
> arch/sh/boards/mach-*/setup.c: "sh_mobile_sdhi" (slave DMA)
> drivers/misc/cb710/core.c: "cb710-mmc" (pio-only)
>
> None of these embedded platforms actually have highmem,
> though the omap1 machine may run a kernel that has highmem
> support enabled.
>
> Most of the others only support DT based probing after we
> removed a lot of old board files a year ago, so they will
> always have a 32-bit mask set at probe time.

For sh_mmcif I just added dma_mask and coherent_dma_mask
as DMA_BIT_MASK(32) in the boardfile and I consider doing it
for pretty much all of them: If they
- Run without HIGHMEM enabled and
- With highmem are bouncing buffers around to PKMAP (right?) when
  BLK_BOUNCE_HIGH is set

That kind of indicates that they are
probably 32bit DMA capable, pretty much as the device trees
assumes in most cases.

This avoids doing Kconfig trickery, make it runtime handled
and we can delete BLK_BOUNCE_HIGH as that branch is
never taken and just refuse to probe if dma_mask =3D=3D 0.

Yours,
Linus Walleij
