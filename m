From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 0/3] mmc: sh_mobile_sdhi: fix missing r7s72100 clocks
Date: Thu, 26 Jan 2017 09:07:45 +0100
Message-ID: <CAPDyKFq=K4ZwyMnM2twVHW6K43U+rADBX3KFyc5o0UzR2kb10w@mail.gmail.com>
References: <20170125202810.16876-1-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170125202810.16876-1-chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 25 January 2017 at 21:28, Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
> At first this started out as a simple typo fix, until I realized
> that the SDHI in the RZ/A1 has 2 clocks per channel and both need
> to be turned on/off.
>
> This patch series adds the ability to specify 2 clocks instead of
> just 1, and does so for the RZ/A1 r7s72100.
>
> This patch has been tested on an RZ/A1 RSK board. Card detect works
> fine as well as bind/unbind.
>
> v6:
> * more detailed descritpion in tmio_mmc.txt
>
> v5:
> * Take implementation details out of DT documentation and put into
>   the driver code.
>
> v4:
> * No code changes, only text udpates to explain why there are 2 clocks
>   and why we need to treat them as 1 clock.
>
> Chris Brandt (3):
>   mmc: sh_mobile_sdhi: add support for 2 clocks
>   mmc: sh_mobile_sdhi: explain clock bindings
>   ARM: dts: r7s72100: update sdhi clock bindings
>
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 13 ++++++++++++
>  arch/arm/boot/dts/r7s72100.dtsi                    | 17 +++++++++++-----
>  drivers/mmc/host/sh_mobile_sdhi.c                  | 23 ++++++++++++++++++++++
>  include/dt-bindings/clock/r7s72100-clock.h         |  6 ++++--
>  4 files changed, 52 insertions(+), 7 deletions(-)
>
> --
> 2.10.1
>
>

Thanks, applied patch1 and patch2 for next. Patch3 is for Simon, I
guess!? (And I can add Rob's ack afterwards).

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
