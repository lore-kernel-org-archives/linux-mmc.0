From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC]Do we still need CONFIG_MMC_DEBUG
Date: Tue, 11 Jul 2017 16:53:20 +0200
Message-ID: <CAPDyKFpeOoHcd9o6uWBm1MNvx0-jcw4=yQ1v1VBBACj4X9s7uA@mail.gmail.com>
References: <ca8f1189-9c85-5cb0-b7e9-24b6154b27f6@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35424 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932779AbdGKOxV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jul 2017 10:53:21 -0400
Received: by mail-yw0-f180.google.com with SMTP id v193so1731869ywg.2
        for <linux-mmc@vger.kernel.org>; Tue, 11 Jul 2017 07:53:21 -0700 (PDT)
In-Reply-To: <ca8f1189-9c85-5cb0-b7e9-24b6154b27f6@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>

On 27 June 2017 at 11:32, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Hi,
>
>    CONFIG_MMC_DEBUG enables mmc core and driver debugging, and most
> people should N. I didn't find any point to keep this for core.c as
> it's just for some WARN or BUG detect. And the debug log around it could
> be replaced with pr_debug which is easily controlled by system log
> level, otherwise we should re-compile the kernel and flash zImage agian
> just for debug.
>
> And for some host drivers, it was used to dump registers as well.
> For the error cases, I think they could directly output the regs, just
> like what sdhci did. Right?
>
> For other cases, for instace, sdhci_add_host uses this macro to dump
> registers when adding host. I think we just have changed sdhci_dumpregs
> to use pr_debug and check the log depending on the dynamic log level, so
> there is no need to still keep it under the context of CONFIG_MMC_DEBUG?
>
> I just really don't like compile-time debug option and I didn't ever try
> to enable it frankly. Is it possible for us to get rid of it? :)

Yeah, please remove it!

I had quick look at core.c and there seems to be some odd use of it.
Please have a look and remove all what is needed.

Kind regards
Uffe


>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
