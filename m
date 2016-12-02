From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/4] mmc: pwrseq-simple: add support for power down GPIO pins
Date: Fri, 2 Dec 2016 07:47:27 +0100
Message-ID: <CAPDyKFrLm0KPL=zi5ge80h5H0pv5xwZkr1cz+JVA-WXqCRZ7OA@mail.gmail.com>
References: <1480659462-29536-1-git-send-email-matt@ranostay.consulting> <1480659462-29536-3-git-send-email-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34468 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755548AbcLBGr3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2016 01:47:29 -0500
Received: by mail-wm0-f50.google.com with SMTP id u144so1796057wmu.1
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2016 22:47:29 -0800 (PST)
In-Reply-To: <1480659462-29536-3-git-send-email-matt@ranostay.consulting>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Ranostay <matt@ranostay.consulting>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On 2 December 2016 at 07:17, Matt Ranostay <matt@ranostay.consulting> wrote:
> Some devices have additional pins that control power but need to
> asserted separately from reset-gpios using a defined time delay.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> ---
>  .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt  |  2 ++
>  drivers/mmc/core/pwrseq_simple.c                   | 26 +++++++++++++---------
>  2 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> index 88826f7d1d38..703a714201d8 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> @@ -12,6 +12,8 @@ Optional properties:
>         at initialization and prior we start the power up procedure of the card.
>         They will be de-asserted right after the power has been provided to the
>         card.
> +- pwrdn-gpios : contains a list of GPIO specifiers. The pwrdn GPIOs are asserted
> +       at initialization and prior we start the power up procedure of the card.

I think "powerdown-gpios" would be better, as Rob earlier also suggested.

Moreover I think the DT doc change be a separate change. This comment
applies to the other changes in this series as well.

[...]

Kind regards
Uffe
