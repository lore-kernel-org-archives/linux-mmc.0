From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/4] mmc: pwrseq-simple: add disable-post-power-on option
Date: Fri, 2 Dec 2016 08:13:42 +0100
Message-ID: <CAPDyKFpCY+LHFkJVJGHaSDODVR7_Xr2ohpdOAn9Hd3qZbDTQ6w@mail.gmail.com>
References: <1480659462-29536-1-git-send-email-matt@ranostay.consulting> <1480659462-29536-5-git-send-email-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f174.google.com ([209.85.210.174]:34475 "EHLO
        mail-wj0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751936AbcLBHNp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2016 02:13:45 -0500
Received: by mail-wj0-f174.google.com with SMTP id mp19so224679030wjc.1
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2016 23:13:44 -0800 (PST)
In-Reply-To: <1480659462-29536-5-git-send-email-matt@ranostay.consulting>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Ranostay <matt@ranostay.consulting>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On 2 December 2016 at 07:17, Matt Ranostay <matt@ranostay.consulting> wrote:
> Add optional device-post-power-on parameters to disable post_power_on
> function from being called since this breaks some device.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 2 ++
>  drivers/mmc/core/pwrseq_simple.c                            | 7 +++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> index bea306d772d1..09fa153f743e 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> @@ -24,6 +24,8 @@ Optional properties:
>         de-asserting the reset-gpios (if any)
>  - invert-off-state: Invert the power down state for the reset-gpios (if any)
>         and pwrdn-gpios (if any)
> +- disable-post-power-on : Avoid post_power_on function from being called since
> +       this breaks some devices

This is a bit weird. I would like to avoid this, if possible.

Perhaps if you simply describe the sequence in detail for your device
we can figure out the best option together.

[...]

Kind regards
Uffe
