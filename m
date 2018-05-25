From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH] mmc: Allow non-sleeping GPIO cd
Date: Fri, 25 May 2018 12:21:44 -0700
Message-ID: <CAE=gft52Yvtqy_i4eXoQs6XV=mrzahoSPxRO=3jiLNKL=pNP1A@mail.gmail.com>
References: <20180521223503.152131-1-evgreen@chromium.org> <CAPDyKFq3+rfSgUMv1R3AEEw-v7e-J2wvbye8ztXsoaJSwxDLbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFq3+rfSgUMv1R3AEEw-v7e-J2wvbye8ztXsoaJSwxDLbQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, May 22, 2018 at 5:08 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> First, I thought I preferred this option, as it becomes clear of what
> goes on. However I then realize, that it may not be worth it, because
> in the end I guess the caller (sdhci), will not be able to deal with
> error codes. For example, what would it do if it receives  a -ENOTSUPP
> from mmc_gpio_get_cd_nosleep()?


Uffe,
Yeah, that would end up looking more like my original RFC patch, where we
just kind of assume the card is there (and therefore ignore the quirk) if
we're not in a preemptible state. Sounds like I should make another spin
this way, at least for consideration.

Andy,
Thanks for the review. I will incorporate your feedback into the next spin.
-Evan
