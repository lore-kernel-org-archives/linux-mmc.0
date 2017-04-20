From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: sdio: Add API to manage SDIO IRQs from a workqueue
Date: Thu, 20 Apr 2017 14:14:18 +0200
Message-ID: <CAPDyKFo2_qM9cxSu6Q=f1C1SdnQ4WPe_pR4Y4ypSotwc4Jc8gA@mail.gmail.com>
References: <1492518724-30511-1-git-send-email-ulf.hansson@linaro.org>
 <1492518724-30511-2-git-send-email-ulf.hansson@linaro.org>
 <CAD=FV=XMk4+86WaCWjuf3NVwRoEubjcY+zQhH-hsb=H3sRpw0A@mail.gmail.com>
 <CAPDyKFqruAXXnp_=6u4i5DnXpjvO_YkCiv-PjooaSQXqjn9z-A@mail.gmail.com> <CAD=FV=XX-LRdNQytWDQ5N5qEtNQyQH1kmU9KUaT1EnKWG1EvtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:34912 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030854AbdDTMOT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Apr 2017 08:14:19 -0400
Received: by mail-ua0-f179.google.com with SMTP id f10so47724665uaa.2
        for <linux-mmc@vger.kernel.org>; Thu, 20 Apr 2017 05:14:19 -0700 (PDT)
In-Reply-To: <CAD=FV=XX-LRdNQytWDQ5N5qEtNQyQH1kmU9KUaT1EnKWG1EvtA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@google.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>

[...]

>
> With "cap-sdio-irq" commented out but without your 3 patches:
> => Boot up, "ifconfig eth0 down; ping -c 20 8.8.8.8".  Seems OK.
>
> With "cap-sdio-irq" commented out but _with_ your 3 patches:
> => Boot up, "ifconfig eth0 down; ping -c 20 8.8.8.8".  Seems OK.
>
> So I guess the conclusion is that I missed the part about your patch
> only enabling the new features if MMC_CAP_SDIO_IRQ.  Sorry.  :(
> ...and then I must have hit some other unrelated failure that I can't
> reproduce now and assumed it was your patch's fault.
>
> So basically I would say that I've lightly tested your code.  It's not
> code I've stressed a ton, but it survived some basic tests anyway...
> :)  The code also looks pretty sane to me.

Thanks a lot for your feedback a for running a new round of tests.
This seems promising then!

When you have the time, it we awesome if you could run yet another new
round of test with the new version of the series. I posted it
yesterday evening my local time.

I would also be very interested to know if converting to the work
queue approach has any impact on throughput. Maybe you have some
simple test suite to also verify that?

[...]

Kind regards
Uffe
