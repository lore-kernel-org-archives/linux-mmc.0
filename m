Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC7274437
	for <linux-mmc@vger.kernel.org>; Thu,  4 Apr 2024 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223094; cv=none; b=hdu6u8SPABg5kEmqU7OQ7buOSQ6hcHuZhuEQZOoim6Ph3bQVFUAisBw0biP+5RQrlzkjrMQ7pcCGvmgMmAB+QNdYQd+uQuhLf4jM6GFoL1HjWu6EyDVfHXwRhNY3WWp0r29MxuY4CVQn0hRuJMQsUN/NniBbVvePvfRTEH5VV7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223094; c=relaxed/simple;
	bh=eal+hbwuJR0GkxwgPiJg2NCYAvGM7tKiSJzcHq0j6dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGDu39kOOYYBTrgxVuEEeYsSH9NqfXMNATNNl/MffW/sO7CBxulMij+aD6K64wo2qV6NL802O00WeB8dPfbXtmV4kc1xHSOSq9gjJ/rGarkeG1cg6OjQcE2qn0QMciCWyAuylcxB9N0ZNT50RA3/WWEcUYctE+5T2CpuLf4ntt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IDIQIVuS; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDIQIVuS"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so883058276.1
        for <linux-mmc@vger.kernel.org>; Thu, 04 Apr 2024 02:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712223091; x=1712827891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QJzdwgYqSiXBG2wAbt+70V3f0hLZ0hXphRY5qJD39hQ=;
        b=IDIQIVuSWzz/kI90Xib4W+1zCVY4pIjQCEiWSvoH9xAYiIDaC3HmgZPB70q3bF5Zqw
         J3hlygutFS16HiA6/H5LLfPmfDTCBbjjPvquHBCVt6NyvlAanqlqHijX2yXkcRe3AIla
         IqkOX86dse2kSa0XxKO16AsIJlq1Nr2gNhAb/1B8szRxoaYtoN5h+HzVlszju4xMaqGH
         sbsO+JX9Czpr9v77XztS15C4DFvS6264r57pKsESNJeR4wm0QUtUz7x3aG+KgmpY70d1
         SN7d2gEhfeHJW1sikNgHU/8J+An0bRPLQjOZS+9r+vRbn5mm1Zs4XCvjE4dAnkr+pwwJ
         5wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712223091; x=1712827891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJzdwgYqSiXBG2wAbt+70V3f0hLZ0hXphRY5qJD39hQ=;
        b=Fuf9mz/wlLriuEvMuLi+cMGFPwJE0+Mr+Pgs3E8t1ApHnK9OWUjnQ1bvQKMMgM9ryB
         kj9mQx7pToyWS+A7cD/W0pqwiK+JMC/DzQsC7fZsE8ifdSwbwC/Ah4UxIV9qoxXwLa3j
         m/AAEC6B3Gkop/3qf486N1qAk+UOBJg9H/pYSAdo/TD3ZabvYpv6y4k4BoyW2kveiuRm
         g2Q+bcaeS6c6YwPsqID2Ty2pY1fPLIWBNAuOe0SHQVAZKsBUzi1vxZiQP5kR38ZQ7Ndk
         oQYJGpC9qmuuZ1ZCHeCgr/nzNFsBBVHIokuKlpT134yn3qj6AIkfJX8V0FxKQT77UOXu
         pBbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV094RCnWggRwIoLmdouGFpBHP3DJU0gF/O5mzJYzcm2Dg6oXqLlLpEAo3mlfmrrms4DxL7Ig6j8edwtADs4Opm5btLeeWJp4Ga
X-Gm-Message-State: AOJu0YylNYZMYma5kzZoHhYG0uYMvy1p5htMkGq2Z/D5AjgJFAUqBuCm
	A947aP6kSf7jRFVFSDZ8qBnTOFlx4aIG1V+ec2eFkkJvOTF+Ns+fN20cE5uvaKxI8kWAwcFlMuP
	4gX0uAtzJUC+LeURX28ClIyowRywJSm9kywD7oA==
X-Google-Smtp-Source: AGHT+IHTXtbKZV4PRrgxvlL/R1tUqcSFTjPcwK6//feDtYUO9NjrShijYYET6/+oeV22B9HIEQVjv5iZuw/cw+hBGTs=
X-Received: by 2002:a25:ac04:0:b0:dc7:423c:b8aa with SMTP id
 w4-20020a25ac04000000b00dc7423cb8aamr1828891ybi.12.1712223091503; Thu, 04 Apr
 2024 02:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-module-owner-sdio-v2-0-ae46d6b955eb@linaro.org>
In-Reply-To: <20240403-module-owner-sdio-v2-0-ae46d6b955eb@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Apr 2024 11:30:54 +0200
Message-ID: <CAPDyKFodTh-KN+=b1B3V+7aNEoR0SPo5-xjFaWu=gYEtsDy1pQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mmc/wifi/bluetooth: store owner from modules with sdio_register_driver()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Kalle Valo <kvalo@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	=?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>, 
	linux-mmc@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 16:17, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Changes in v2:
> 1. Add "wifi: ath10k: sdio: simplify module initialization" patch, from
>    my other patchset to avoid conflicts.
> 2. Add Acks/Rb tags.
> 3. Drop applied SDIO patch, which was the dependency for the rest
>    cleanups.
> 4. Update subjects according to feedback.
> - Link to v1: https://lore.kernel.org/r/20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org
>
> Merging
> =======
> With Acks from Kalle, please take entire set via mmc/sdio.

The series applied for next, thanks!

[...]

Kind regards
Uffe
