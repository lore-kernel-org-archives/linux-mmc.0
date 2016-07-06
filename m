From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 00/54] mmc: mmc: Add Software Command Queuing
Date: Wed, 6 Jul 2016 18:20:48 +0200
Message-ID: <CAPDyKFoPk0udwM030fntXn85hkgumw_8eDrgA=SMM3=9ry0x-Q@mail.gmail.com>
References: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38849 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650AbcGFQUu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2016 12:20:50 -0400
Received: by mail-wm0-f43.google.com with SMTP id r201so199488886wme.1
        for <linux-mmc@vger.kernel.org>; Wed, 06 Jul 2016 09:20:49 -0700 (PDT)
In-Reply-To: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On 29 June 2016 at 15:24, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here is an updated version of the Software Command Queuing patches,
> re-based on the SDHCI patches that I have.
>
> Ulf, there are a lot of patches now and I think it would be worth taking
> some of them.  For example, the first 25 affect SDHCI only.  If you accept

Patch 1->25 applied for next, thanks!

> the "Command during Transfer" API introduced in patch 26, then you could
> take patches 26-30 as well.

I have been offline for a while, so unfortunate I need some more time
to review thoroughly. Delaying these for a while.

Kind regards
Uffe
