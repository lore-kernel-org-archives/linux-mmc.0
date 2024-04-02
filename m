Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E257379B8E
	for <linux-mmc@vger.kernel.org>; Tue,  2 Apr 2024 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055468; cv=none; b=BysQBnMQ2obhc8H3a1urHuYo6VmnXYVKazr7wIRvJ6mqNYRNmw37BjAMHZLXHjTV5Jj54DzV/K4rTzQLnvXADucI8v9Cz3J9gYNjJGro0FYOIknhTEEOU9cQGpba9mmj22cThfVmgqSOFHVtiN44/jZ/AgeaqH551tzQmuQwt3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055468; c=relaxed/simple;
	bh=Hr7Xp50rW+8exIfPBdNB+2gt14zjJGKAfeBvyG31h3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNyKZfuuwN7SLLesEGSy2idfTKCrnjBw3JeQS1KBkXUTfJcrgDOq5vCCmz/UHK4fc7sRrGgnw+Lnv5CB/RiLede4QAA/0snM0FTqqPycn21eX+ABLfL0AyuNZNBZnTU7ZGgC2Y6a14IfBtn0YG0ep9L9qQwfT5OTawhMBD2Lqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hyggrUQg; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hyggrUQg"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6152ad16cd6so4411717b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 02 Apr 2024 03:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712055466; x=1712660266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=heR2AZ16RGjephYYk3nVkJQSU4kssIE/CVztHg4PbLw=;
        b=hyggrUQgPnmeMneJ2liKSXdae8XB3vszf+yzwwLoMQbrbQ1dP1eS48Y+tyYwbmBrc/
         ytyVyVA0dBnb9mLjmfVG+gUnkYPGMis+KyO02sGIoVbpd83ivPNUATWHBbvrto3XlA9F
         821l34KnzZKYkUahoCGLnK0HYEtCqZ/jiqtkF01hfcqRVzNEgCN5/wSX7CYqg0teMdwn
         BnMPqSPFuT+9LwQED1xHAVFj8Ktw59J3mhouSp3Ei2RcCyBjA1BSBXEWfeDJy39xl3Jk
         RouzQAqKFJ2fmZ61DJ6tNXohSnKkTbj9owNvyJF0ep6UyTdy+BygpGJtJjgLo+TFKfD5
         nh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055466; x=1712660266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=heR2AZ16RGjephYYk3nVkJQSU4kssIE/CVztHg4PbLw=;
        b=uVq0OOzQJmteB6NsizQZQdTZnXXgmSuC09aHeFVNTS+HpClZuNZn03Lpz54NPx+hLe
         EnJxGRtZnwFUNjqVW8bLTj31Kyx5Lv3gEUiug34dXOb20ljhR98erVC+klRxtIf6cFoe
         6eHk1nBCIHkB63HaYMLGEbkUfLprZK6RO0zzV5HNZ93MjVUZCNKMqL9h06UseS4QmXw2
         gacQ01iycNVKP9AI4O9GW+DvS2CChZrvMuIDD9vMdusgUwNK4jVQPDS1vOk4y9yQ1mFL
         dU5hpoQyL+PeQMGHwVkCJr19YWSfa087i1vWljPzbc8nIEtMNF7J5sZmtz/tCsT+Sy3w
         VHzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4tEfs1owosBf+SPpjI9eaDR1rD6WYRojs3nRE33IAOApIvB2VrfWSxJT1L1dGxDJBK+jpbbjFSy11MeBfff72W1bGKHnOm5Tf
X-Gm-Message-State: AOJu0YxcTr4cNuXVcMjjzr7vESfaHCkxhFDz/vCDZ1OiSBodcKBIDW7T
	5/77tffrVvRYogeO4FwQUU7QsTpXvne8w+589HUdQW82lI+OhKsIbBRd9Ea23Ocaq6Effxyhj47
	qtycmxf5yYEt9r1mWDnqOR+RKgvynGKun+pKJTA==
X-Google-Smtp-Source: AGHT+IG0hl043sikYSStWfJMtXPIZPLFFTefeWAq9LsJotUVsTuh5FFEl/udwTnzeyfi+7Th8cC2dNNikPb4b1WN2ok=
X-Received: by 2002:a81:5d45:0:b0:608:e133:7ece with SMTP id
 r66-20020a815d45000000b00608e1337ecemr11694233ywb.36.1712055465511; Tue, 02
 Apr 2024 03:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
In-Reply-To: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Apr 2024 12:57:09 +0200
Message-ID: <CAPDyKFqct4ZV3UbTzWKO08MzDTm_BX6K02kefV26mEain0SXqA@mail.gmail.com>
Subject: Re: [PATCH 0/7] mmc/wifi/bluetooth: store owner from modules with sdio_register_driver()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Kalle Valo <kvalo@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	Brian Norris <briannorris@chromium.org>, =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Mar 2024 at 18:24, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Merging
> =======
> All further patches depend on the first patch.  Everything could go via
> one tree, e.g. MMC, or the cleanup patches removing owner would wait a
> cycle.

Patch 1 applied for next, thanks!

I can certainly pick the remaining in the series through my mmc tree,
but waiting a bit to queue them up to allow some more acks to be
received.

Kind regards
Uffe


>
> Description
> ===========
> Modules registering driver with sdio_register_driver() might
> forget to set .owner field.
>
> Solve the problem by moving this task away from the drivers to the core
> code, just like we did for platform_driver in commit 9447057eaff8
> ("platform_device: use a macro instead of platform_driver_register").
>
> Best regards,
> Krzysztof
>
> ---
> Krzysztof Kozlowski (7):
>       mmc: sdio: store owner from modules with sdio_register_driver()
>       bluetooth: btmrvl_sdio: drop driver owner initialization
>       bluetooth: btmtksdio: drop driver owner initialization
>       wifi: ath10k: sdio: drop driver owner initialization
>       wifi: brcm80211: drop driver owner initialization
>       wifi: marvell: mwifiex: drop driver owner initialization
>       wifi: silabs: wfx: drop driver owner initialization
>
>  drivers/bluetooth/btmrvl_sdio.c                           | 1 -
>  drivers/bluetooth/btmtksdio.c                             | 1 -
>  drivers/mmc/core/sdio_bus.c                               | 9 ++++++---
>  drivers/net/wireless/ath/ath10k/sdio.c                    | 1 -
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 1 -
>  drivers/net/wireless/marvell/mwifiex/sdio.c               | 1 -
>  drivers/net/wireless/silabs/wfx/bus_sdio.c                | 1 -
>  include/linux/mmc/sdio_func.h                             | 5 ++++-
>  8 files changed, 10 insertions(+), 10 deletions(-)
> ---
> base-commit: 087c142b2b04898c897aa77938d05a93907150e5
> change-id: 20240329-module-owner-sdio-abd5de3f1d74
>
> Best regards,
> --
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
