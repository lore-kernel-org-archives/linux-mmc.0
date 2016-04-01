From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] Revert "mmc: core: Remove redundant ->power_restore() callback"
Date: Fri, 1 Apr 2016 12:06:12 +0200
Message-ID: <CAPDyKFqc_w1Cr+3DWgV=rWxOU4homsJfGoeRHKWfk4bQyEBZ7g@mail.gmail.com>
References: <1459455931-19538-1-git-send-email-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34607 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbcDAKGN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2016 06:06:13 -0400
Received: by mail-wm0-f43.google.com with SMTP id p65so19167772wmp.1
        for <linux-mmc@vger.kernel.org>; Fri, 01 Apr 2016 03:06:12 -0700 (PDT)
In-Reply-To: <1459455931-19538-1-git-send-email-gwendal@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 31 March 2016 at 22:25, Gwendal Grignou <gwendal@chromium.org> wrote:
> This reverts commit 364549ddc29d ("mmc: core: Remove redundant
> ->power_restore() callback for MMC")
> and commit 3056c49c35c1 ("mmc: core: Remove redundant
>  ->power_restore() callback for SD")
>
> ->power_restore() is called by mmc_host_power_restore(). For MMC, We can
> not use mmc_reset() instead, because the device may not have
> RST_n_FUNCTION set up.

I don't want to restore the callbacks.

Instead, let's be a bit more clever and try to extend mmc_reset() to
cover the MMC case as well. I haven't thought about that in detail,
but I think it should work.

[...]

Kind regards
Uffe
