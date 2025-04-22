Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF37C8DC
	for <linux-mmc@vger.kernel.org>; Tue, 22 Apr 2025 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336674; cv=none; b=qjGVqKWZbDsku57kQ43d+pidDG8uphUua87W6tsXbJFzmqsOCCDfz74saxfiFqoD2IAoXiF72EQQHB5Q0qjdUp9LoT4d+ImZRgB4uAzzTRMEfASxtUAJKVRH6KCxoMXbww0uj8VvTH8Vytdf2CqfrYe6UDEXrBTVaXe+F/BheH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336674; c=relaxed/simple;
	bh=gKQoJFotInQWyy0bBDn0U3U7riuTcTFLuqGN0TXPFQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxjG6xmMHi169CrS2SO7xmzToEF/NmeLZcxpHIdbAggQ9Q/axBADoBo7Hg3M6L2cipsCq5hmWUHmZJvGR+JVmi2BT+Rrtf6LAXM00ECDSQhO7eADjKfKmfN0KOv60EHpagEw9X1xKgMBIfvJXU0+aFHMjTOQVyCHZxgoUV9XaYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eT0k5JUE; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eT0k5JUE"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ff4faf858cso37362387b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 22 Apr 2025 08:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745336671; x=1745941471; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GSyZz4bXdxEI1g3oFa+KF8sUj/15eMIzBlns+hYq338=;
        b=eT0k5JUEO3rl0xEX6uXCG9Ila8dFX1vq+BO8Vermk0BUFSfGfcfn0tEqIQ9LOZpMnN
         cN2d+Sfa1DE8mIcpAfSKCc52kD8xI/D8bUtW7W4y5XVFUZPjKFpix/2PNlZ6/QHBdDiq
         A/ejyqMs+YuJsPvgAO0PPiqweJMxWfoQQGtgg29SWDsYkzb6ppitQD6uwD/wemUSOqFz
         gv9ZR/ShDrjT6CbN+zsUN/mf8APlijH/R4WKVqDgg2Od5VgLEeoYz0TORHC8CKscgX+e
         cRnFxJt/sCGZLQ5cRK9nDhj1vSgmlX/VJaQBJnW/JYIjzn2Dz4E7YgALngFNs0A4Fv4Y
         tkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745336671; x=1745941471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSyZz4bXdxEI1g3oFa+KF8sUj/15eMIzBlns+hYq338=;
        b=DzyiVvJIt+wKzMBLZhOSTMBTM3UUg1AvvuuKpmJsAiTWcY85CeHHEYJcM328TgDEpa
         hIv0xCHLp1bDM8zZdzHLJtz+ejrbrz9g2RSqJLdjX0de8Alf6J5hfxyNaroIhlDW9eUX
         sPsf7kaWAHqPq2OMc6tgk7sNMZUonNKlFvpwxmg6tlTd7peKdkqLMNfMFkO33Mgw13f3
         tgIrlplvUtVbqZUTRVKsagoPwkrIJUjB7JjLoG/Yvni4CH2U7iE7kGco1h/xFyCTHYxH
         j7SkLD/qYY+e5RENVdcsZ7wJhRNqlGZ1JoPD4IjnRJG6UywbzcV9l6LCyZpLwQNCmexH
         cM4Q==
X-Gm-Message-State: AOJu0YzLzuJd9zQmZzUREAFO9BMONRCL+fxb+7M4VJLJb8dPIpLWK5Si
	UtjrcomuN8uOqdxX4fUPVCn3RKkEah3g2RqCWcT6crl4x5469/WkM/WB5mKvyC6H0DWHbW/+5pX
	9HSYGLJ20zixRBmADsNixb1qwyUYHLOlcCFnfZKfDYS+OW//w
X-Gm-Gg: ASbGncul8gU0g2dYqL7AbPLswZ2slLnb+1NLt2VcPTptZZ8R75Svly3PmUAGrxTVxan
	qJQkfvW4tdeLyCuij2C80krae66wE5x4j9tWrHdNNcdQ/YG7G2zJYD//0tO+VRQjLVyHFVuqpJ/
	BgHuLynoVRlfxTV57Dc7gCMII=
X-Google-Smtp-Source: AGHT+IFKvU6UcojAVl9vKrX3GkMk/emBHHhmch/isXYSWLpG5MOR+dUOh9RejTMMlveta8q6aERlHXyHeugKu5aIGfo=
X-Received: by 2002:a05:690c:7013:b0:703:aea2:6bbb with SMTP id
 00721157ae682-706cce10362mr247547217b3.31.1745336670939; Tue, 22 Apr 2025
 08:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401095847.29271-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20250401095847.29271-1-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 22 Apr 2025 17:43:55 +0200
X-Gm-Features: ATxdqUEUB9ikX5N5ZOoCO65P2-8q5pTapWzCdDvH9kZOMZi5KBMIbwid_VbC89I
Message-ID: <CAPDyKFpsJpLre2bO9T7gsSthsta9f3JXoXTGZbjTjWVXH47gCw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] mmc: rename mmc_can_* functions
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Apr 2025 at 11:58, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> As mentioned in [1], here is a series which rename mmc_can_* functions
> to names which include 'card' or 'host' in the name. I am only an
> occasional MMC core hacker, and these namings would have made my life
> quite easier in past times. So, here is my proposed change. Have a look
> and let me know if you like it. Plain RFC for now. Notes:
>
> * This series is based on [1] which needs changes. My idea would be to
>   respin the series on rc1 right after it is out.
> * I intentionally left mmc_can_retune() out because it seems more
>   consistent with all the other mmc_*_retune() functions
> * Builds fine locally, tested on a Renesas Salvator-X with R-Car M3-W.
>   buildbots still need to check it, branch is here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/mmc/unbind-power-off
>
> What do you think?
>
>
> [1] https://lore.kernel.org/r/20250320140040.162416-1-ulf.hansson@linaro.org
>
> Wolfram Sang (11):
>   mmc: rename mmc_can_discard() to mmc_card_can_discard()
>   mmc: rename mmc_can_erase() to mmc_card_can_erase()
>   mmc: rename mmc_can_ext_csd() to mmc_card_can_ext_csd()
>   mmc: rename mmc_can_poweroff_notify() to
>     mmc_card_can_poweroff_notify()
>   mmc: rename mmc_can_reset() to mmc_card_can_reset()
>   mmc: rename mmc_can_sanitize() to mmc_card_can_sanitize()
>   mmc: rename mmc_can_secure_erase_trim() to
>     mmc_card_can_secure_erase_trim()
>   mmc: rename mmc_can_sleep() to mmc_card_can_sleep()
>   mmc: rename mmc_can_trim() to mmc_card_can_trim()
>   mmc: rename mmc_can_gpio_cd() to mmc_host_can_gpio_cd()
>   mmc: rename mmc_can_gpio_ro() to mmc_host_can_gpio_ro()
>
>  drivers/mmc/core/block.c             |  6 ++--
>  drivers/mmc/core/core.c              | 48 ++++++++++++----------------
>  drivers/mmc/core/core.h              | 10 +++---
>  drivers/mmc/core/mmc.c               | 30 ++++++++---------
>  drivers/mmc/core/mmc_ops.c           |  6 ++--
>  drivers/mmc/core/mmc_ops.h           |  2 +-
>  drivers/mmc/core/mmc_test.c          | 12 +++----
>  drivers/mmc/core/queue.c             |  6 ++--
>  drivers/mmc/core/slot-gpio.c         |  8 ++---
>  drivers/mmc/host/dw_mmc.c            |  6 ++--
>  drivers/mmc/host/mtk-sd.c            |  2 +-
>  drivers/mmc/host/renesas_sdhi_core.c |  2 +-
>  drivers/mmc/host/sdhci-omap.c        |  2 +-
>  drivers/mmc/host/sdhci.c             |  6 ++--
>  drivers/mmc/host/sunplus-mmc.c       |  2 +-
>  drivers/mmc/host/tmio_mmc_core.c     |  6 ++--
>  include/linux/mmc/slot-gpio.h        |  4 +--
>  17 files changed, 74 insertions(+), 84 deletions(-)
>

Note that there are still some inconsistent naming of the functions
that correspond to the host's capabilities, beyond this series. For
example those we have in drivers/mmc/core/host.h. Would you mind
sending another series to rename those too?

That said, $subject series applied for next, thanks!

Kind regards
Uffe
