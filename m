From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 0/5] mmc: sdhci: Tidy tuning
Date: Thu, 1 Dec 2016 15:57:07 +0100
Message-ID: <CAPDyKFqbpGQuzirU98MTX4TXjn6inDY8K8NozrSwBZVJGMDyLg@mail.gmail.com>
References: <1480601071-8881-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f169.google.com ([209.85.210.169]:34982 "EHLO
        mail-wj0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbcLAO5K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2016 09:57:10 -0500
Received: by mail-wj0-f169.google.com with SMTP id v7so206727986wjy.2
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2016 06:57:09 -0800 (PST)
In-Reply-To: <1480601071-8881-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 1 December 2016 at 15:04, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here are some tidy-ups wrt SDHCI tuning.  Un-tested so far.

Nice. Thanks!

>
> Any other suggestions?  Otherwise I will test and submit the whole series.

As an additional step, could you try to make use of mmc_send_tuning(),
instead of sending the command internally from sdhci_send_tuning()?

Kind regards
Uffe
