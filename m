From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/3] mmc: sdhci: Use mmc core regulator infrastucture
Date: Fri, 13 Jun 2014 12:39:50 +0200
Message-ID: <CAPDyKFo4pU4i+bvcLFNnQUaGpQDKfnnkYJki+B8mMQw99-HVWg@mail.gmail.com>
References: <1402598935-3701-1-git-send-email-markus.mayer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:34376 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbaFMKjv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jun 2014 06:39:51 -0400
Received: by mail-qc0-f179.google.com with SMTP id x3so2677280qcv.24
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jun 2014 03:39:50 -0700 (PDT)
In-Reply-To: <1402598935-3701-1-git-send-email-markus.mayer@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Markus Mayer <markus.mayer@linaro.org>
Cc: Chris Ball <chris@printf.net>, Tim Kryger <tim.kryger@gmail.com>, Mike Looijmans <mike.looijmans@topic.nl>, Andrew Bresticker <abrestic@chromium.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 12 June 2014 20:48, Markus Mayer <markus.mayer@linaro.org> wrote:
> This series switches the common SDHCI code over to use mmc_host's
> regulator pointers rather than keeping its own set.
>
> In addition, we can now re-use the newly introduced local "mmc" pointer
> in several other function calls in lieu of using host->mmc.
>
> The first patch in the series has been posted before
> (https://lkml.org/lkml/2014/4/24/947). The two follow-on patches have
> not. Patches 2 & 3 could be squashed together if the maintainers were
> so inclined.

Yes, please squash them. Otherwise this looks great!

Kind regards
Uffe
