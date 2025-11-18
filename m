Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A800B328B5D
	for <linux-mmc@vger.kernel.org>; Tue, 18 Nov 2025 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479938; cv=none; b=IKm/Ul/fvOwiTf2vcggPNcP42Id5DsnWQdMvCR6j8ab3cAAuntiQ9MbjMi1U9KUAmLhbtGrtxhIHgbAzDfDuwEQZ63n1fAjcWs/j3OvBOIJ6Iokhfj38g8pft0PCM+enKy6f0PqUIsfVUR5EQfM3tyg9uQVuxAvp1FAlyfd9jSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479938; c=relaxed/simple;
	bh=m/PzBecmFoSB0WgB6AP0+aomsbeHKXLtWMavxIFy2Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDNjIlwyk07VelrrfM5OMuOUGY32YS4nzGOkKsgQmzxHU1+k5TEwNSOKYAsRC6MBpLa0KmVNeGs9QLxGz+iQUrRzMeWmFBx0WT+YhOCPZc/iLnkLh6qOdvSMtECvAsBgqlUTkGwGmR3hhYNvR9D5xefqBEFMdhjz8gMnYJEw9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oh/5kBxQ; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oh/5kBxQ"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63fbed0f71aso4697457d50.0
        for <linux-mmc@vger.kernel.org>; Tue, 18 Nov 2025 07:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763479935; x=1764084735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1HqjvHot2zaXCz+6WohQjpFioHBD8Y4L+8neqBCkVvM=;
        b=oh/5kBxQM6BVH2XtujqeC2WTrYVithiK0eqEEvMlRP4m7z0evZ5T8Zp/r7bKx9n+as
         qwTbPT3wyE4+f03oEQwrRCiB4HkuOJdTyOK0vvqc9hbqFIA+MTtWhIFk67qGMRec9RjB
         2aImZRQdcFdiLr/kCQDlL6fuXDyHxNq2E4DnIXNWW5U+or5ysmuWIa+SW9e6yqPLBIqw
         yEvjjtBjW4/XfQVTr8wL5MrIZcVe+GwP+pBCqHO77Sk2A5sHCqM5oEohg7wJs4WVQdjb
         T2ObgcH01CI6STpMGM8tesw4IBHdwsI41Dqb8TyQtVUAICcfQDpFavSvOetMqXLklras
         HHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763479935; x=1764084735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HqjvHot2zaXCz+6WohQjpFioHBD8Y4L+8neqBCkVvM=;
        b=TDUncjIjnhp7fLCsqsgRXpCMOe64ZiFSOP4irB6++9YCtHN2WZMDVbq4r2KBwx0yFG
         bq19pHp1hDBltSEcGqvGSLKAORHrH/CJQr+s/Yuh+bgVfVujJZV6uWA31YGoAjvTRGP9
         DEJYJnPIHry9OZItsMhGoF+aNure/tkTokS5tz5j3d9qrLl5L4EDNoS2m1XmtORgx1J7
         IBL2pWmHWvtvfocXQAjB/fnHXFnPQ8B+dLrSmMlUouia9NyKMellss1Ph1OifaOzgAVD
         ESD+42nWAzQsOZGqOmiqXUGOWp4MoZ6G2/5NJHROdi1ey7BSK7a2uI+W9MDaCQfl/B5e
         XQkA==
X-Forwarded-Encrypted: i=1; AJvYcCVuU+GHj3ZgF1XYUpeQb34/cryP7rvhZ8wKfikkXPcqU2SKg50HnkfGcbXOBPINmWpWEnRlSGdiS8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3431TnFElzLhLn4Op4zSUAJwPVV+2CwGLKzUaS8qc+5s86571
	BMQT9WF+dQCYaxrchlX0bfEyVmCmMt+pH/eUUDjw9jrgRG2CoppxO5WHDDauV92iTVphFBT0Phd
	bvz9uo9NEHb9u/hElZPu0tEv2VmOiP9+00a82fcCYog==
X-Gm-Gg: ASbGnctjJeb/Yz4hvIIX7a2KR7rUwdX/ydV0hzJFyR6ZPYuHEuKQxNXWCVHXfss9gj0
	FeStuFmfBn3BRocTymVj/Hiy+4TgcrcrbyrMfQnC2vXGIS9+8HdpWoH93aj2dxrIk4XqrFz8RSL
	em/EHzdV1PVUfeJuAioTXn7OSlInfGXMIcNKEfp11FUdGeY55xkA7LHEkYdbX+4/gwhSkTrijKr
	aDzj+IsxWZgTWWMrl7HoljfEmTKG6jw8Zh9WU8d53OgSenatuIQqlVK6fz9tm/lFmeRfqfpODgS
	nXcBSe0=
X-Google-Smtp-Source: AGHT+IEPW0w7kRpHWU8HC+IJ0wheQZbZJvzoml3Vpr6Ev05Se8Sg/tgilmB7FWyYAPRCFhb7oGxKDgM3CdT9NhooaW0=
X-Received: by 2002:a05:690e:248c:b0:63f:b434:a08e with SMTP id
 956f58d0204a3-641e7650a85mr10677589d50.45.1763479935441; Tue, 18 Nov 2025
 07:32:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117101242.4018208-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251117101242.4018208-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Nov 2025 16:31:39 +0100
X-Gm-Features: AWmQ_blohfnlmMvUuRM6S6OaffAT860CwMwae3tO0RRJnX7dRQTNPcTcl56LX90
Message-ID: <CAPDyKFrKzvmkXb9rbjJHKaFA0ffWoH7p2_Z4_+AY26w+9Nin3A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mmc: renesas_sdhi: Handle resets
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wsa+renesas@sang-engineering.com, p.zabel@pengutronix.de, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, geert@linux-m68k.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Nov 2025 at 11:12, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Hi,
>
> Series adds suspend/resume hooks for the Renesas SDHI driver. These
> are necessary on RZ/G3{E, S}, that supports a power saving mode where
> power to most of the SoC components (including SDHI) is turned off.
> Resume from this suspend mode is done with the help of bootloader
> and it may choose to disable the SDHI clocks, resets after it is
> done with the SDHIs.
>
> Reset signal was deasserted/asserted on probe/remove as well to
> avoid relying on previous bootloaders. This is also useful for
> unbind/bind operations.
>
> Along with it, driver was converted to use
> SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() helpers.
>
> Thank you,
> Claudiu
>
> Changes in v2:
> - in patch 2/3 drop unnecessary code changes in tmio_mmc_core.c
> - adjusted the patch description for patch 2/3
> - collected tags
>
> Claudiu Beznea (3):
>   mmc: renesas_sdhi: Deassert the reset signal on probe
>   mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS()
>     and pm_ptr()
>   mmc: renesas_sdhi: Add suspend/resume hooks
>
>  drivers/mmc/host/renesas_sdhi.h               |  3 ++
>  drivers/mmc/host/renesas_sdhi_core.c          | 39 ++++++++++++++++++-
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 12 +++---
>  drivers/mmc/host/tmio_mmc.h                   |  2 -
>  4 files changed, 46 insertions(+), 10 deletions(-)
>
> --
> 2.43.0
>

The series applied for next, thanks!

Kind regards
Uffe
