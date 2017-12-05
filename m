From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: mmc_test: Ensure command queue is disabled for testing
Date: Tue, 5 Dec 2017 17:24:44 +0100
Message-ID: <CAPDyKFq18gPR7=_G4DyGzO9iM-TBkAXM4eepLy45aGr9z9m-_A@mail.gmail.com>
References: <1512132931-12380-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:37840 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbdLEQYp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Dec 2017 11:24:45 -0500
Received: by mail-it0-f67.google.com with SMTP id d137so2854635itc.2
        for <linux-mmc@vger.kernel.org>; Tue, 05 Dec 2017 08:24:45 -0800 (PST)
In-Reply-To: <1512132931-12380-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 1 December 2017 at 13:55, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here are a couple of fixes related to mmc_test.
>
>
> Adrian Hunter (2):
>       mmc: core: Ensure cmd_completion is initialized
>       mmc: mmc_test: Ensure command queue is disabled for testing
>
>  drivers/mmc/core/core.c     |  6 ++----
>  drivers/mmc/core/mmc_test.c | 11 +++++++++--
>  2 files changed, 11 insertions(+), 6 deletions(-)
>
>

Thanks, applied for next!

Kind regards
Uffe
