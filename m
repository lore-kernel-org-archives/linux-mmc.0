From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci-xenon: Add Xenon SDHCI specific
 system-level PM support
Date: Thu, 13 Jul 2017 11:18:32 +0200
Message-ID: <CAPDyKFpOcDOi8+nPsw0dk_rhcvzP94C9Mmp+RX=hfLvNqEs6sg@mail.gmail.com>
References: <1499897779-12338-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:35170 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbdGMJSd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2017 05:18:33 -0400
Received: by mail-qt0-f180.google.com with SMTP id b40so32888582qtb.2
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2017 02:18:33 -0700 (PDT)
In-Reply-To: <1499897779-12338-1-git-send-email-zjwu@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Wilson Ding <dingwei@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, hongd@marvell.com, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On 13 July 2017 at 00:16, Zhoujie Wu <zjwu@marvell.com> wrote:
> From: Hu Ziji <huziji@marvell.com>
>
> Add Xenon specific system-level suspend and resume support.
> Especially during resume, re-configure Xenon specific registers
> since registers setting will be lost in suspend if Xenon is power off.

I recommend to start with deploying runtime PM support instead of
system PM support. Then on top of such change, you should make use of
the runtime PM centric path to get system sleep support for "free"
(and thus all the nice benefits).

Please have a look at sdhci-of-at91 for a good reference.
Regarding sdhci-of-at91, there is currently a patch [1], which adds
dealing with restoring context of registers after a system resume.
Similar to what you need.

Kind regards
Uffe

[1]
https://patchwork.kernel.org/patch/9837951/

[...]

Kind regards
Uffe
