From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V1 0/2] mmc: sd: Fix signal voltage when there is no power cycle
Date: Mon, 2 Oct 2017 10:30:06 +0200
Message-ID: <CAPDyKFo8MveqAUjSTC8===PbU47iUKwsEvUDwE4Co_Qd2P_cCQ@mail.gmail.com>
References: <1506328144-13666-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:44258 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdJBIaI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Oct 2017 04:30:08 -0400
Received: by mail-io0-f175.google.com with SMTP id v36so4129040ioi.1
        for <linux-mmc@vger.kernel.org>; Mon, 02 Oct 2017 01:30:07 -0700 (PDT)
In-Reply-To: <1506328144-13666-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Zhoujie Wu <zjwu@marvell.com>

On 25 September 2017 at 10:29, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here is V1 of "mmc: sd: Fix signal voltage when there is no power cycle"
>
>
> Changes since RFC:
>       mmc: core: Factor out mmc_host_set_uhs_voltage()
>         New patch
>       mmc: sd: Fix signal voltage when there is no power cycle
>         Now based on "Factor out mmc_host_set_uhs_voltage()" patch
>         Added explanation to commit message
>
>
> Adrian Hunter (2):
>       mmc: core: Factor out mmc_host_set_uhs_voltage()
>       mmc: sd: Fix signal voltage when there is no power cycle
>
>  drivers/mmc/core/core.c | 38 ++++++++++++++++++++++++--------------
>  drivers/mmc/core/core.h |  1 +
>  drivers/mmc/core/sd.c   | 47 +++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 70 insertions(+), 16 deletions(-)
>
>
> Regards
> Adrian

Thanks, applied for next!

Kind regards
Uffe
