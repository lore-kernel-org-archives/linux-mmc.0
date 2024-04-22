Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF70152197
	for <linux-mmc@vger.kernel.org>; Mon, 22 Apr 2024 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808520; cv=none; b=D9m/uUH5BwcjlWaG8ffy3SquLZKZer707prtEjCktXUTHWu7aBG2XRrGdhl9c03hJw+o2ijwjXt3Vd0Vh84qwAjqFEat0EPZS+0oQS6NJ4KVSwta9r0dz7SA+qT4FwQxhV9iMfKFtSeX6YRNry8wuRNaVWBMjxzHBC7UahFBhRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808520; c=relaxed/simple;
	bh=hjKW7hsZeNfJRemlR4ksLOUN9OEuYwS4GD+90Su0UaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqT2e7YDyXCkBZMTu1kxgQi186kAPHxzUcs0/3wDlR0RiSAV7OIvSf7Ijv0ovjivRsMrcqiDH9XzqvjxcuXVQoBKWCgEGYb+ghig+0W2301keh53+gmfhwsnWEmVLEoDOPFwAf/Zc43Ft+dQZ2AOuwXbW3iq02MovkxA6XLr0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pSqhiVXE; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pSqhiVXE"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbed179f0faso3839493276.1
        for <linux-mmc@vger.kernel.org>; Mon, 22 Apr 2024 10:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713808517; x=1714413317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sG1euiBgkSQ6vmDcD3uZzC0eUKnQF/L2DokvD/9cqRE=;
        b=pSqhiVXECEkgu9WrjOYePCrs2YOTHRioSiMFnq81mohez/HQNsYf2XOR8UlQBVbg0c
         /9+9uIDpAfoAU5EMyJrpUig/T2FvI4b/2KsdaL8v3rLJrVWJqKmrzHZIJTbUwi5JEjKE
         VnY6GhxD/Qs+e4idy4fCsTlqpKNNXwATahs9NAs9TvcWtWYwiQ2QjxYHktBROLaUf09I
         JKyl3Sg2eI9cVTu5BeQk6reZvFR7x3oKMBi2+zrKPQHPowR/3XGmzz9icC2tSaIy1pLI
         D8bYD1kg3TCL88nqEGHEB0oPNDV+/sNwwFWKG/y4FbcKpGDyM0n63b+WrBOkKnhq1oJW
         7Vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713808517; x=1714413317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sG1euiBgkSQ6vmDcD3uZzC0eUKnQF/L2DokvD/9cqRE=;
        b=qNGhTSkLsHwx4sK7BlQ657MyYwTD6g17uVmXvd43c157iI/K6lMHQY5/qoisqp9G1x
         zPMHmyjrD8humnFwBaJ+t9g2Isva5vGc4ZiWQNUPoaz3znzO54v4iWMvvts6Pe3XPg9q
         iYfrkx4Oj4pWXJmJB0IZltFvdc42u23jvXgwTfu1qbP+jHuxjcG+5x2AbfuGL0mPQ5V7
         z21KlhZyZC7l2Xkf07dizM4NvVOA/Z6x4UiEP6gxXyGvDlxNtnUWCRaC4rSVCu8M7LLu
         1F3NYIhjmO3DGlq18tYbkA+BzkKMYcvsHIDV/4MVgJB/ThRNvkqwXeBlnD4g2DYO81Pr
         HU3w==
X-Gm-Message-State: AOJu0Ywp5xQN11uiAc9n+jRDAaXHH8lj1yhSlPuqC0VnoRBLf1D00k6j
	W10pcIUQ2LTM8sMSVvv/45SiavTxalpJCq3Gypbm9O0SxSgXCfHgCLxYWi1C7+QJmN/N+tagQw4
	mdRi6kEyRRYaJTY0tzxo9tuFtatswn+AcD1+xq8gl0tm4EsueiQo=
X-Google-Smtp-Source: AGHT+IFf/94iRiGsAC3zweGZBSqLjF0nRZkRXu3Gtf9OJwNSxd203kMM9RtjPIv3ussDa+jIfONNR2HiLb1qqaNvL9g=
X-Received: by 2002:a25:8251:0:b0:dcf:eb30:c580 with SMTP id
 d17-20020a258251000000b00dcfeb30c580mr405490ybn.3.1713808517638; Mon, 22 Apr
 2024 10:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABikg9z9NqFwJ5VGtHhtZY9_gNAAoSbAfmAnTHcbp2=b0M3LcA@mail.gmail.com>
In-Reply-To: <CABikg9z9NqFwJ5VGtHhtZY9_gNAAoSbAfmAnTHcbp2=b0M3LcA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 22 Apr 2024 19:55:05 +0200
Message-ID: <CACRpkdbGQkVcUC920soft_CLSNiAjHd1QUfv5T=9Wvd3noAuLw@mail.gmail.com>
Subject: Re: breaking commit: mmc: moxart-mmc: Use sg_miter for PIO
To: Sergei Antonov <saproj@gmail.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 10:38=E2=80=AFPM Sergei Antonov <saproj@gmail.com> =
wrote:

> [    7.018270] BUG: scheduling while atomic: kworker/0:1/9/0x00000002
(...)
> [    7.057443] CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.8.0-rc4+ #22=
5
> [    7.064527] Hardware name: Generic DT based system
> [    7.069677] Workqueue: events_freezable mmc_rescan
> [    7.075121]  unwind_backtrace from show_stack+0x10/0x14
> [    7.080930]  show_stack from dump_stack_lvl+0x34/0x44
> [    7.086576]  dump_stack_lvl from __schedule_bug+0x64/0x84
> [    7.092608]  __schedule_bug from __schedule+0x58/0x594
> [    7.098320]  __schedule from schedule+0x74/0xa8
> [    7.103368]  schedule from schedule_timeout+0xd4/0x108
> [    7.109070]  schedule_timeout from __wait_for_common+0x94/0x120
> [    7.115547]  __wait_for_common from moxart_request+0x278/0x468
> [    7.121980]  moxart_request from mmc_start_request+0x94/0xa8

moxart_transfer_pio() is called from the interrupt handler and
should be properly atomic right, so the flags to sg_miter should
be fine.

The way I read it is that the completion does not arrive and that triggers
a timeout, am I right?

I assume increasing the timeout doesn't help.

Could it be something like
commit 4d4a2c71b862b9e696006fd264dbf5dbd6484d77
?

Yours,
Linus Walleij
