Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="txRT9eUa"
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F40FD54
	for <linux-mmc@vger.kernel.org>; Thu, 30 Nov 2023 01:57:43 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a00cbb83c80so101813266b.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 Nov 2023 01:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701338262; x=1701943062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0GKUjDUfFZBuJDqMk9wIf5InzkGujvf/hhx2Me3pUVQ=;
        b=txRT9eUazb/LNZD1dzq52jBzCMPdwKERBADBkpNSpWV2E7KuZwU6EduBTDZzCuWgPM
         sEPE9qYxG/3KHQELtTCdw5f69wNSJ6ujfG4qOYx6a2qTZTjwDGAu/kLkitvZjbrYW6hL
         8cw7avpJ0Dc9K3a715tgdgsN0OTnKmJzHxolyCrpByti3Bgci1WPZ2SJOjcx5GTjLP6K
         XMs42w3/RQHnbTW79kxeromhoSERuLh3QfyGIViNvALL/73TGIcpQz6zb9hiPXEA0rDb
         soSb1oitnBblVgsjjKZMtVssXziSKNeGABBGSs7yagF+neVtIJvLZgrDe70tMeZv6Iqv
         HaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701338262; x=1701943062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GKUjDUfFZBuJDqMk9wIf5InzkGujvf/hhx2Me3pUVQ=;
        b=qUphCTEoxPbNlS8j5ub7U6rVu24jc1P17sYdJmG3LfX0M+IMRDnLjDdBFDxN6HCl6s
         L0AP5uCaEiNxM9ghJdfbqTTOdXAJpejmjFL1JMaqxrFXAO1jlEY1cUZ3lvK4ExnN4GS8
         CwvqVQ82N8hOmLvN1eAy2/gnw0oUtFJm4OwPKkpI/1Lba2UtFbcC0YAI6XNNwkTfvwOg
         t2j9O/gOLSFrnAsK6g0ctqWWSwT/fV3VrY8sizpvIQ21IXbdc76spqRY/5AiAPHFxs5P
         G5hyxbWH0aDDpljmEq6B6IoE63UiWd58sH1Q370MU0mtUitz0arBpJdrv+1yZGNlZvcP
         aZig==
X-Gm-Message-State: AOJu0YxmfniQCobPEs910ZrBaF9tiyxiItJF77bJA+p0JhH7D/XRjXss
	vGiXt8QC0fmU6U4ARWVz8iGmM1qcEGiwaNMQ5UWFJA==
X-Google-Smtp-Source: AGHT+IG4qEkSIJ504Yo38Pz2GRrAyEzoAa5jrCRG3buDq6H5FZQpoQPj3v49XCh89IDRO0xCqMqzXtfhveSHawkPSOE=
X-Received: by 2002:a17:906:680a:b0:a19:1a0b:edb8 with SMTP id
 k10-20020a170906680a00b00a191a0bedb8mr134151ejr.67.1701338260873; Thu, 30 Nov
 2023 01:57:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
In-Reply-To: <20231124145338.3112416-1-o.rempel@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 Nov 2023 10:57:03 +0100
Message-ID: <CAPDyKFowioLLUi+4wvxz-9d3YGnMN=_sXBkFtUvMLb+tfQCEgg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, 
	=?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Nov 2023 at 15:53, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Hi,
>
> This patch series introduces support for prioritized device shutdown.
> The main goal is to enable prioritization for shutting down specific
> devices, particularly crucial in scenarios like power loss where
> hardware damage can occur if not handled properly.
>
> Oleksij Rempel (3):
>   driver core: move core part of device_shutdown() to a separate
>     function
>   driver core: introduce prioritized device shutdown sequence
>   mmc: core: increase shutdown priority for MMC devices
>
>  drivers/base/core.c    | 157 +++++++++++++++++++++++++++--------------
>  drivers/mmc/core/bus.c |   2 +
>  include/linux/device.h |  51 ++++++++++++-
>  kernel/reboot.c        |   4 +-
>  4 files changed, 157 insertions(+), 57 deletions(-)
>

Sorry for joining the discussions a bit late! Besides the valuable
feedback that you already received from others (which indicates that
we have quite some work to do in the commit messages to better explain
and justify these changes), I wanted to share my overall thoughts
around this.

So, I fully understand the reason behind the $subject series, as we
unfortunately can't rely on flash-based (NAND/NOR) storage devices
being 100% tolerant to sudden-power failures. Besides for the reasons
already discussed in the thread, the robustness simply depends on the
"quality" of the FTL (flash translation layer) and the NAND/NOR/etc
device it runs.

For example, back in the days when Android showed up, we were testing
YAFFS and UBIFS on rawNAND, which failed miserably after just a few
thousands of power-cycles. It was even worse with ext3/4 on the early
variants of eMMC devices, as those survived only a few hundreds of
power-cycles. Now, I assume this has improved a lot over the years,
but I haven't really verified this myself.

That said, for eMMC and other flash-based storage devices, industrial
or not, I think it would make sense to try to notify the device about
the power-failure, if possible. This would add another level of
mitigation, I think.

From an implementation point of view, it looks to me that the approach
in the $subject series has some potential. Although, rather than
diving into the details, I will defer to review the next version.

Kind regards
Uffe
