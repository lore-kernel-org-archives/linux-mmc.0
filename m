From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [v2,9/9] ARM: shmobile: r8a7790: lager: Enable UHS-I SDR-50
Date: Wed, 6 Apr 2016 08:38:02 +0200
Message-ID: <CAMuHMdX8CYgdOPodapDppNq5LPdorgmf9sJvaZ9GkNJGxKxZwQ@mail.gmail.com>
References: <1459525479-20842-10-git-send-email-wsa@the-dreams.de>
	<20160406005616.GA7135@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160406005616.GA7135@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux MMC List <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

Hi Simon,

On Wed, Apr 6, 2016 at 2:56 AM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Apr 01, 2016 at 05:44:39PM +0200, Wolfram Sang wrote:
>> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>
>> Add the "1v8" pinctrl state and sd-uhs-sdr50 property to SDHI{0,2}.
>
> For some reason which I am entirely unsure of git didn't apply this cleanly
> so I did so manually. Please double check that the following is correct.
>
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Subject: [PATCH] ARM: shmobile: r8a7790: lager: Enable UHS-I SDR-50
>
> Add the "1v8" pinctrl state and sd-uhs-sdr50 property to SDHI{0,2}.
>
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7790-lager.dts | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index aa6ca92a9485..75fc8d1cb7e3 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -346,11 +346,25 @@
>         sdhi0_pins: sd0 {
>                 renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
>                 renesas,function = "sdhi0";

How come you still have "renesas,*" pinctrl properties?
Applied to wrong branch?

> +               power-source = <3300>;
> +       };
> +
> +       sdhi0_pins_uhs: sd0_uhs {
> +               groups = "sdhi0_data4", "sdhi0_ctrl";
> +               function = "sdhi0";

Pinctrl properties with and without prefixes must not be combined in a single
preprocessed DTS (and in the overlays).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
