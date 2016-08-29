From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-msm: Add pm_runtime and system PM support
Date: Mon, 29 Aug 2016 14:29:38 +0530
Message-ID: <CANYu_0s3WE7AvEr4sVW_XqRzre7HmHC+VJfeh6DVqaEkNN_w6Q@mail.gmail.com>
References: <1466080509-24015-1-git-send-email-pramod.gurav@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yb0-f182.google.com ([209.85.213.182]:36106 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756744AbcH2I7j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2016 04:59:39 -0400
Received: by mail-yb0-f182.google.com with SMTP id e31so45802257ybi.3
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2016 01:59:39 -0700 (PDT)
In-Reply-To: <1466080509-24015-1-git-send-email-pramod.gurav@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, Pramod Gurav <pramod.gurav@linaro.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>

Hi Ulf,


On 16 June 2016 at 18:05, Pramod Gurav <pramod.gurav@linaro.org> wrote:
> Provides runtime PM callbacks to enable and disable clock resources
> when idle. Also support system PM callbacks to be called during system
> suspend and resume.
>
> Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>

Any comments on this patch?

> ---
>  drivers/mmc/host/sdhci-msm.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
