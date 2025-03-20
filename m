Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E661D7E3E
	for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481431; cv=none; b=Oq49Xci+tIfVO/9DMkg4Q3vTlUBkk6Zn88o6YYZ1NZK5rqsM9dUTYILKEAkBjQPa4t9cK74yfqpqnoCRId4rSKYg3lYQnNnE/eKtBjj25rPrhhEbAj6nXqJdelyd05eu/jeA4xOC8QZpixJY7s7DEnKH0vQl0PCQ6nCYHQjECnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481431; c=relaxed/simple;
	bh=/Gfb5GEBXbNXjVOKcSAvbyPEtTsdgPC9h9bjSyHrTxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCQ06dsipLGc7q9gkgMQE2X6BnYn4p2su/ukLLVnRafW3lHfD/zGdIrvnyzWom4H6EQUg5pW74dUzolC6P6DnJE0pVZn6M3ySe3CNxNp2xHQW8HcUdZJHXAOMhTcfdybgaEPyI9InjnmOcTYa6Bt2xUUhzC9o24srdiybBz1c7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yj0a4C4T; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yj0a4C4T"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e5dc299dee9so836488276.3
        for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742481429; x=1743086229; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eLEDllcZE9HeaNUXtT820xySgzGTQcNZXOc5EzIZSWc=;
        b=yj0a4C4ToBGXfECuV2EJL+Cu1oduA24rhyFSVmefN5FmcQ6px8hNqvOY10GjC/OmHt
         VAlWF79m1I/kks3jJ+WJ99Ys4k89FSHSkITCPn3rII96xu+4JKJt+yB527fjnB9cs+Lh
         jwUgVHCMYQbIzkwNHzgN8i2PNJZPCIhhcYN97MAujnOEcq1myJ9XgpxAZy8WZbUH8LD9
         PqIBcAvfz0PMJhsICo9/yXK+b8Cxmc14YKRdl3+D9Yel3G1CzAIPdUrUHao7oa6cgoPZ
         nGVfMbBDk96+JEBV+VqrHIbkf6ODKR/Yu/lNo49fmAZ7dkeHK0OVzI4ah/LG+0RE+Rhy
         ob8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481429; x=1743086229;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLEDllcZE9HeaNUXtT820xySgzGTQcNZXOc5EzIZSWc=;
        b=I82c7J/E1cnsaRpPvWU1BQC7H/b3kTrhUc/uiITM8G1YV6e25T8DVtXzVsSXRXrXo8
         cEM9uGyUTsP2juRrTK+7/2c0x95foes8ezbBvRan87hlcRnShJZKCJT65nVbgh2VY5Z7
         v4dx64AlwfttKMvxmOsfb/mxSkcyAEhAAdb7XpV8MaMMClc2TJnJ/Iv2pmhot29GxLBN
         up2shQ6OhuoDHT8Fp0X1BWwvIP5Uy2dxX4sOGKQhtKiuMXkMEHJGOOSH26/INp8WbEmc
         vdPVCEnIXn2cckxCXQ/LdVyhAo1jltUjwYPYn81a08a1fb8+QlBXQ/XhYc0PQzJ7E/kO
         vsag==
X-Forwarded-Encrypted: i=1; AJvYcCVWmLhxgtoLpfK1RtZoo8HQUN+WKZi/sK55xwrGBie1BgSOb/PWArJJE8x5L8VGXBGBRTToxaWDaxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8GXwnthBNqrT4Mkb3wcp2e915v3I67n4yEmUklf1SWyIr0axi
	F4KLJgWnfDUQCrxlWxzK8eapM7owVn/U+OlzULzLlMxUaFshYppnGgYb2MmxZzvvivOa7P8dyNc
	sC3xAQqXmblIuOm5o5GfHlRjBjuAn7cVqVFXvIQ==
X-Gm-Gg: ASbGncuvQ95HuudQBCCUJ8waI4zjjOR9EEDVC1s92G1KIBrR2/wcZ7+Mvch+X1qSI9X
	EC8HsRINduSj214wBj1WyeIiY0va18GHxTuuLwCbVm+v0xzkbnyt8aKbSswGyztG8zbktsvk01G
	fKnPnX3OBhhWqqfQoTXsWYXdIsbUA=
X-Google-Smtp-Source: AGHT+IGLDwuEvPABNDqvH8Sg++dMtxuwcekvvB+mdlvGgakHsDV81vNGD+1s9/U83hwKUFCHyv+ChNKx4+eFMuKzFbY=
X-Received: by 2002:a05:690c:4a01:b0:6fb:b524:48bc with SMTP id
 00721157ae682-7009c151fa0mr105912607b3.35.1742481428540; Thu, 20 Mar 2025
 07:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310102229.381887-1-o.rempel@pengutronix.de>
In-Reply-To: <20250310102229.381887-1-o.rempel@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Mar 2025 15:36:32 +0100
X-Gm-Features: AQ5f1JqncR6FnHE5M2Ntpmi-B4Cz544fyrHiSkMY_eDdSJ-_u8NqXWoMcjOkT3c
Message-ID: <CAPDyKFrC56BBJk=YAPWCCNYNqFAoY74_yH0ZXfNQEiDhaA2xJg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] mmc: handle undervoltage events and prevent eMMC corruption
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>, 
	Christian Loehle <christian.loehle@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"

Hi Oleksij,

On Mon, 10 Mar 2025 at 11:22, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> changes v4:
> - drop HPI and SDHCI related patches
>
> This patch set introduces a framework for handling undervoltage events
> in the MMC subsystem. The goal is to improve system reliability by
> ensuring graceful handling of power fluctuations that could otherwise
> lead to metadata corruption, potentially rendering the eMMC chip
> unusable or causing significant data loss.

Thanks for posting this! I will spend some time reviewing this next
week and let you know my comments then.

However, I just wanted to let you know that I just posted a series [1]
(forgot to cc you, sorry), which also reworks the way _mmc_suspend()
understands what scenario it should be running. I am guessing that
re-work is simplifying for your $subject series too. Maybe you would
like to have a look?

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20250320140040.162416-1-ulf.hansson@linaro.org/



>
> ## Problem Statement
>
> Power fluctuations and sudden losses can leave eMMC devices in an
> undefined state, leading to severe consequences. The worst case can
> result in metadata corruption, making the entire storage inaccessible.
> While some eMMC devices promise to handle such situations internally,
> experience shows that some chip variants are still affected. This has
> led vendors to take a more protective approach, implementing external
> undervoltage handling as a precautionary measure to avoid costly field
> failures and returns.
>
> The existence of the "Power Off Notification" feature in the eMMC
> standard itself serves as indirect evidence that this is a real-world
> issue.  While some projects have already faced the consequences of
> ignoring this problem (often at significant cost), specific cases cannot
> be disclosed due to NDAs.
>
> ## Challenges and Implementation Approach
>
> 1. **Raising awareness of the problem**: While vendors have used
>    proprietary solutions for years, a unified approach is needed upstream.
>    This patch set is a first step in making that happen.
>
> 2. **Finding an acceptable implementation path**: There are multiple
>    ways to handle undervoltage - either in the kernel or in user space,
>    through a global shutdown mechanism, or using the regulator framework.
>    This patch set takes the kernel-based approach but does not prevent
>    future extensions, such as allowing user-space handoff once available.
>
> 3. **Preparing for vendor adoption and testing**: By providing a
>    structured solution upstream, this patch set lowers the barrier for
>    vendors to standardize their undervoltage handling instead of relying on
>    fragmented, out-of-tree implementations.
>
> ## Current Limitations
>
> This patch set is an initial step and does not yet cover all possible
> design restrictions or edge cases. Future improvements may include
> better coordination with user space and enhancements based on broader
> testing.
>
> ## Testing Details
>
> The implementation was tested on an iMX8MP-based system. The board had
> approximately 100ms of available power hold-up time. The Power Off
> Notification was sent ~4ms after the board was detached from the power
> supply, allowing sufficient time for the eMMC to handle the event
> properly.  Tests were conducted under both idle conditions and active
> read/write operations.
>
> Oleksij Rempel (4):
>   mmc: core: Handle undervoltage events and register regulator notifiers
>   mmc: core: refactor _mmc_suspend() for undervoltage handling
>   mmc: core: add undervoltage handler for MMC/eMMC devices
>   mmc: block: abort requests and suppress errors after undervoltage
>     shutdown
>
>  drivers/mmc/core/block.c     |   2 +-
>  drivers/mmc/core/core.c      |  30 +++++++++
>  drivers/mmc/core/core.h      |   2 +
>  drivers/mmc/core/mmc.c       | 127 +++++++++++++++++++++++++++++------
>  drivers/mmc/core/queue.c     |   2 +-
>  drivers/mmc/core/regulator.c | 124 ++++++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h     |   8 +++
>  7 files changed, 274 insertions(+), 21 deletions(-)
>
> --
> 2.39.5
>
