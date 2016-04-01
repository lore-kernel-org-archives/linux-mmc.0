From: Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH] Revert "mmc: core: Remove redundant ->power_restore() callback"
Date: Fri, 1 Apr 2016 09:43:16 -0700
Message-ID: <CAMHSBOXPuQYB06hDtpBawABJhsuygbP8KPnZmFnPzRzON58TpA@mail.gmail.com>
References: <1459455931-19538-1-git-send-email-gwendal@chromium.org> <CAPDyKFqc_w1Cr+3DWgV=rWxOU4homsJfGoeRHKWfk4bQyEBZ7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36825 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbcDAQnh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2016 12:43:37 -0400
Received: by mail-wm0-f50.google.com with SMTP id 127so25860180wmu.1
        for <linux-mmc@vger.kernel.org>; Fri, 01 Apr 2016 09:43:36 -0700 (PDT)
In-Reply-To: <CAPDyKFqc_w1Cr+3DWgV=rWxOU4homsJfGoeRHKWfk4bQyEBZ7g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Fri, Apr 1, 2016 at 3:06 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>
> I don't want to restore the callbacks.
>
> Instead, let's be a bit more clever and try to extend mmc_reset() to
> cover the MMC case as well. I haven't thought about that in detail,
> but I think it should work.

I am posting a different path soon.
Also, given power_restore is gone, mmc_host_power_restore is going to
crash when called for a MMC or SD device.
Shall we remove the interface  mmc_power_save_host/mmc_power_restore_host?
It is only supported for sdio devices, and used only by the wl1271 to
power cycle the controller via sysfs. I am wondering if we could use
the suspend/resume entry point instead.

Gwendal.
>
>
> [...]
>
> Kind regards
> Uffe
