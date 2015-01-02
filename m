From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 1/4] mmc: dw_mmc: exynos: incorporate ciu_div into
 timing property
Date: Fri, 2 Jan 2015 08:58:08 -0800
Message-ID: <CAD=FV=WXzPt=VKxB=KHK+hC=RN6WbmdnQcLUT4zFQ0Ud7BFanQ@mail.gmail.com>
References: <1420008185-24758-1-git-send-email-alim.akhtar@samsung.com>
	<1420008185-24758-2-git-send-email-alim.akhtar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:32997 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbbABQ6J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Jan 2015 11:58:09 -0500
Received: by mail-vc0-f174.google.com with SMTP id id10so6910320vcb.5
        for <linux-mmc@vger.kernel.org>; Fri, 02 Jan 2015 08:58:08 -0800 (PST)
In-Reply-To: <1420008185-24758-2-git-send-email-alim.akhtar@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Alim Akhtar <alim.akhtar@gmail.com>, kgene@kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Abhilash Kesavan <a.kesavan@samsung.com>, Alexandru Stan <amstan@google.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Alim,

On Tue, Dec 30, 2014 at 10:43 PM, Alim Akhtar <alim.akhtar@samsung.com> wrote:
> From: Seungwon Jeon <tgih.jun@samsung.com>
>
> ciu_div may not be common value for all speed mode.
> So, it needs to be attached to CLKSEL timing.

The more time I've spent looking at all of this stuff the less I like
the exynos bindings.  Personally I'd prefer to see the exynos bindings
fixed rather than go further down the path of these bindings.

Specifically:

1. The "drive" really should be specified quite differently.
According to the DesignWare docs, the "drive" phase is there to meet
hold time requirements.  Hold time requirements are different for
different SD/MMC modes and are specified in nanoseconds (SDR104 is
.8ns, ID mode is 5.0ns).  There is a per-SoC parameter needed that
indicates some built-in delay (in nanoseconds) and that shouldn't
change based on clock speed or card mode.

2. The ciu_div really ought to be automatic.  Start out at a divide by
4.  If you end up with both drive and sample at phases of 0, 90, 180,
270 then you can change to divide by 2.

I still haven't looked at every last detail of these delays though, so
please correct me if I'm wrong.  I've added Alex who may have looked
at this more than I have.


With all of the above, there's also the fact that (I think) we should
be moving towards working with the clock phase API since all of your
values are effectively specifying clock phases, just in a very arcane
way.


> This also introduce a new compatibale 'dw-mshc-hs200-timing'
> for selecting hs200 timing value

As per above, I don't think this is needed.


> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   15 ++--
>  drivers/mmc/host/dw_mmc-exynos.c                   |   81 ++++++++++++++------
>  drivers/mmc/host/dw_mmc-exynos.h                   |    1 +
>  3 files changed, 67 insertions(+), 30 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> index ee4fc05..06455de 100644
> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> @@ -23,10 +23,6 @@ Required Properties:
>         - "samsung,exynos7-dw-mshc-smu": for controllers with Samsung Exynos7
>           specific extensions having an SMU.
>
> -* samsung,dw-mshc-ciu-div: Specifies the divider value for the card interface
> -  unit (ciu) clock. This property is applicable only for Exynos5 SoC's and
> -  ignored for Exynos4 SoC's. The valid range of divider value is 0 to 7.
> -
>  * samsung,dw-mshc-sdr-timing: Specifies the value of CIU clock phase shift value
>    in transmit mode and CIU clock phase shift value in receive mode for single
>    data rate mode operation. Refer notes below for the order of the cells and the
> @@ -37,11 +33,16 @@ Required Properties:
>    data rate mode operation. Refer notes below for the order of the cells and the
>    valid values.
>
> +* samsung,dw-mshc-hs200-timing: Similar with dw-mshc-sdr-timing.
> +
>    Notes for the sdr-timing and ddr-timing values:
>
>      The order of the cells should be
>        - First Cell: CIU clock phase shift value for tx mode.
>        - Second Cell: CIU clock phase shift value for rx mode.
> +      - Thrid Cell: Specifies the divider value for the card interface
> +        unit (ciu) clock. This property is applicable only for Exynos5 SoC's and
> +        ignored for Exynos4 SoC's. The valid range of divider value is 0 to 7.
>
>      Valid values for SDR and DDR CIU clock timing for Exynos5250:
>        - valid value for tx phase shift and rx phase shift is 0 to 7.
> @@ -79,8 +80,8 @@ Example:
>                 broken-cd;
>                 fifo-depth = <0x80>;
>                 card-detect-delay = <200>;
> -               samsung,dw-mshc-ciu-div = <3>;
> -               samsung,dw-mshc-sdr-timing = <2 3>;
> -               samsung,dw-mshc-ddr-timing = <1 2>;
> +               samsung,dw-mshc-sdr-timing = <2 3 3>;
> +               samsung,dw-mshc-ddr-timing = <1 2 3>;
> +               samsung,dw-mshc-hs200-timing = <0 2 3>;

You are breaking backward compatibility here.  If your change is
merged then all old boards will instantly break.  Since the "dts" and
code changes will likely be merged through different trees you'll end
up with a bunch of broken trees until everything is merged together.
Even if you don't subscribe to the stable bindings theory this is not
acceptable.

-Doug
