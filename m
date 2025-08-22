Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD20323A564
	for <linux-mmc@vger.kernel.org>; Fri, 22 Aug 2025 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857882; cv=none; b=KHSP2Vp4L9BWJFs9JKNwNcdcWfhMZ9q9MSYJhJHjDYKPEOEVVe3N6e1OLUP13POQjkJ1KZy23y736XShsoL9YSjFLQWgUp9JECSBqpRrnCh8Ov2SJLgstaa8BIvrYWVX5A2rfZMm4xdM59g/YGn9Kwq82gkqtF3luGwvWsFCyms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857882; c=relaxed/simple;
	bh=rMOg2gvZ18O8ML3ZWRnRUP0AXccfSxiSrtww5bto3CY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdhqjVfSJjPvnWtauhWVJLOuAfe5L3NmXq7h+PsDi7+1Mq2sIvGjQSRCm5Qzy2YY4JwPo5k457LsRJeUTBp+Ejk8DvgSTbRImkem10ZxWnvnTy4Oou11cpdt+4wQ7hixvO0L+SUIEmEJ/NthfdTl4uClO8q1mSfysC694i/kNt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nWwkuL0F; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nWwkuL0F"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d60150590so16022277b3.0
        for <linux-mmc@vger.kernel.org>; Fri, 22 Aug 2025 03:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755857880; x=1756462680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VMaJzA26Jp/KHypl7yi6sQJZmbGhp8+CxAAR+uR0Jss=;
        b=nWwkuL0Fe2Z7bWlrR9ttK3R0K9ScyVtrzn+1/mDedH7f0XZXnY3ivxvGVdhpvPfSXN
         Fodmwy4YTWefSVjeSLhCNnn4dRukL5GAq7t0PL7YKSVF4Vk8+gaQ20dqlbNWrspYXLvh
         jTxAhTYKTmb2iV06IgBPFcsrXUgQkNV/cL99guoLen2TZubBkUeajql1+313LYpLDrI9
         c8JyNqY7L4oOaGcHdCvDmuxwLAAF77gTqlfZAUEwPW54ef0OZUp4uvk+uo9NppPPVleJ
         DmEmiqlEuBwfHDok9tF8xPuWXuK/Up6pRYyvVSQnolZZzGIGYCleEtI0Oq20tg/eJQUj
         Ggfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755857880; x=1756462680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMaJzA26Jp/KHypl7yi6sQJZmbGhp8+CxAAR+uR0Jss=;
        b=KS4skcyxe29MUDU/PulDlK+mmraNQW6edunFvPfge8AXL7/xi5zE6yIPUhUnFF+4XZ
         eziLKTDGTjgToHgGNqX6p7qczkdrc8PhSGmhxa3FXTbFZMXjEEckVJIw2l32cHF9byhi
         zeu3pOmBR1+bmP41pxLTJqfmIoJ4tyIFZ7L6JaOHuEaOy4dQtY/t5CsRl74vRWpru3iY
         k/6CpAhbFXp5cqhpoVs3vdGRB/EU4YBozZJTimu1LCHWVSHAbZckG1WiGUW3nlR02kkS
         7VJmHuw3A7MmwEMRdjq3tdAIm5MKYZfXWwTFirC1SRiYYLX9ApSqMT1zYW3WHbaxlMsJ
         nXRw==
X-Forwarded-Encrypted: i=1; AJvYcCXaDRoB7HREL02bRdRFZfluOB4dexiVwrtN4tShZ2fZSAXJovNT5WsB6cEUV8YbFQh355Kxmx4QWoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlbrcrwC8qokn9qfcNGWrf3yntki/v/eY30zAcnh/HK7HaILl0
	5v66Xz1dbTrxkj+fmZn2V4w0m0svAytvIC4uMOAYYYfi/7HhX6tFMW9PxZyDxEwS5fD9+3Vt/Jd
	SB/A52Ma3jwoQI7mqWfFa5tJDpp7qK3hjIkMf4CsIsOxgw+XLJ41S
X-Gm-Gg: ASbGncvVqvqDbcS/gwopkXKsKKV2I7s1/FWIR2N9RbLgFrvCFecYMT3ShHUaRyCOusa
	GkvTTSh8SBALpwmK4UIP7lETKJFIoPw5s9PQR4EMMYvGHL9iSdpfyXC+cPcEIZ1zxvFoW5VWMZf
	arNpcewild/1GQTZxw5/aK5VVIMOwI/RkMJrHf27RJOorQmuu361MZs0xoJBZYM/4zg6B0D5Cr+
	MVWFZvE
X-Google-Smtp-Source: AGHT+IGE3siUxQjopG9rHtwkuRpjA9/N+RV6hg5NCeOK0qVB5EPCNDlzWHD9g5dDC2y+88YaLX7Q6Ekh9mh+SfmJpxQ=
X-Received: by 2002:a05:690c:6892:b0:71f:b944:1050 with SMTP id
 00721157ae682-71fdc5669d4mr24856077b3.51.1755857879487; Fri, 22 Aug 2025
 03:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821130751.2089587-1-o.rempel@pengutronix.de>
In-Reply-To: <20250821130751.2089587-1-o.rempel@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 22 Aug 2025 12:17:23 +0200
X-Gm-Features: Ac12FXzATkOB53kBFLymCe1Lpp3t7gUcUKPJOqU-WWPxNMENT_1oR3lo3uUI80U
Message-ID: <CAPDyKFo5tJHEb8o892vg9DoMsLTq+715gotqnP26hMWenvjg8A@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] mmc: handle undervoltage events and prevent eMMC corruption
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>, 
	Christian Loehle <christian.loehle@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 15:07, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> changes v9:
> - Drop stray whitespace after mmc_claim_host() in mmc_attach_mmc()
> - Remove unnecessary #include <linux/workqueue.h> from host.h,
>   add forward declarations instead
> - Move internal prototypes for undervoltage helpers
>   (mmc_regulator_register/unregister_undervoltage_notifier(),
>    mmc_undervoltage_workfn()) from host.h to core.h
> - remove host->card check
> changes v8:
> - fix compile warning
> changes v7:
> - Remove all usage of the redundant undervoltage_notify_registered flag
> - Register undervoltage notifier in mmc_add_card() after setting card as
>   present, for all supported cards.
> - Unregister undervoltage notifier in mmc_remove_card() based on card presence
> - Remove all unnecessary EXPORT_SYMBOL_GPL for functions only used within MMC
>   core.
> - Move all host claiming and releasing responsibility for undervoltage events
>   into the bus_ops callback;
> - add comment for host->undervoltage
> - Squash undervoltage suspend preparation and handler into one patch.
> - Use mmc_card_removed() in shutdown path instead of host->undervoltage.
> - Remove redundant card presence check in undervoltage handler.
> changes v6:
> - Rewrite commit message to be more technical per reviewer feedback.
> - Address race conditions by using __mmc_stop_host() instead of only
>   claiming the host in the undervoltage handler.
> - Move notifier registration from mmc_regulator_get_supply() to the end of
>   a successful card initialization in mmc_attach_mmc(), ensuring it only
>   runs for capable cards.
> - Centralize notifier unregistration in mmc_remove_card() to correctly
>   handle all card removal and error paths.
> - Add 'undervoltage_notify_registered' flag to struct mmc_host to
>   reliably track the notifier state.
> - Consolidate multiple notifier callbacks into a single, generic handler.
> - Remove premature notifier support for vqmmc and vqmmc2 regulators.
> - Move INIT_WORK() for the undervoltage workqueue to mmc_alloc_host().
> changes v5:
> - Rebased on top of mmc/next after introduction of enum mmc_poweroff_type
> - Replaced boolean undervoltage parameter with MMC_POWEROFF_UNDERVOLTAGE
> - Dropped unused __mmc_resume() helper
> - Updated commit messages accordingly
> changes v4:
> - drop HPI and SDHCI related patches
>
> This patch set introduces a framework for handling undervoltage events
> in the MMC subsystem. The goal is to improve system reliability by
> ensuring graceful handling of power fluctuations that could otherwise
> lead to metadata corruption, potentially rendering the eMMC chip
> unusable or causing significant data loss.
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
> Oleksij Rempel (2):
>   mmc: core: Add infrastructure for undervoltage handling
>   mmc: core: add undervoltage handler for MMC/eMMC devices
>
>  drivers/mmc/core/bus.c       | 12 ++++++
>  drivers/mmc/core/core.c      | 23 +++++++++++
>  drivers/mmc/core/core.h      |  5 +++
>  drivers/mmc/core/host.c      |  2 +
>  drivers/mmc/core/mmc.c       | 70 ++++++++++++++++++++++++++++++--
>  drivers/mmc/core/regulator.c | 77 ++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h     | 11 ++++++
>  7 files changed, 197 insertions(+), 3 deletions(-)
>
> --
> 2.39.5
>

This is nice work - and I appreciated all your efforts you have put in
to get this done!

The series applied for next, thanks!

Kind regards
Uffe
