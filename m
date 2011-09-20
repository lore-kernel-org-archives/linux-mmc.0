From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: Fix hangs related to insert/remove of cards
Date: Tue, 20 Sep 2011 22:49:07 +0200
Message-ID: <CACRpkdaUtY1S08gXNzfyRNnozE=LzKAFq19vvmK75yVLD5M5qw@mail.gmail.com>
References: <1315918957-11491-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:38878 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab1ITUtI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2011 16:49:08 -0400
Received: by pzk1 with SMTP id 1so256842pzk.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Sep 2011 13:49:07 -0700 (PDT)
In-Reply-To: <1315918957-11491-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On Tue, Sep 13, 2011 at 3:02 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> During a rescan operation mmc_attach(sd|mmc|sdio) functions are
> called. The error handling in these function can trigger a detach
> of the bus, which also meant a power off. This is not notified by
> the rescan operation which then continues to the next attach function.
>
> If a power off has been done, the framework must never send any
> new commands to the host driver, without first doing a new power up.
> This will most likely trigger any host driver to hang.
>
> Moving power off out of detach and instead handle power off
> separately when it is actually needed, solves the issue.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
