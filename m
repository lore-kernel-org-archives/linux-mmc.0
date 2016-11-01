From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 0/2] mmc: dw_mmc: fix the wrong operation for reset controller
Date: Tue, 1 Nov 2016 14:56:00 -0700
Message-ID: <CALAqxLXs704Y-TGAQsggSnDohyFDYvQw=zYuiHRu9UKgHEfbFw@mail.gmail.com>
References: <20161031024942.4415-1-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34246 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbcKAV4C (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Nov 2016 17:56:02 -0400
Received: by mail-oi0-f43.google.com with SMTP id 62so17491202oif.1
        for <linux-mmc@vger.kernel.org>; Tue, 01 Nov 2016 14:56:01 -0700 (PDT)
In-Reply-To: <20161031024942.4415-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, lkml <linux-kernel@vger.kernel.org>, Guodong Xu <guodong.xu@linaro.org>, Leo Yan <leo.yan@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>

On Sun, Oct 30, 2016 at 7:49 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> This patch adds the "reset-names" as reset controller for dwmmc controller.
> Linaro guys had reported the issue about booting stuck.
>
> Some SoCs are enabled the CONFIG_RESET_CONTROLLER.
> then dwmmc controller are waiting for getting reset controller.
> But if doesn't define "resets" property in device-tree, it should be stuck.
>
> If use the reset-names as reset controller for dwmmc controller,
> it's more stable than now.
> This commit is related with the below commit.
>
> Fixes: d6786fefe816 ("mmc: dw_mmc: add reset support to dwmmc host controller")

So I wasn't hit by the issue, as I don't tend to boot from SD on my
hikey, but I did run these patches and I'm not seeing any issues with
my Android environment.

So for what its worth:
Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
