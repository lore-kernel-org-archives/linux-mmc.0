From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH V3] ARM: dts: Add dwmmc DT nodes for exynos5420 SOC
Date: Thu, 22 Aug 2013 16:53:02 -0700
Message-ID: <CAD=FV=W1LBYSQdLT7N6tTu6rGvUOFuPdFBNP2BRGDCXOH1hT9g@mail.gmail.com>
References: <1377172278-15161-1-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1377172278-15161-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, ks.giri@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

Thanks for adding my Thomasz,

On Thu, Aug 22, 2013 at 4:51 AM, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
> This patch adds the device tree node entries for exynos5420 SOC.
> Exynos5420 has a different version of DWMMC controller,so a new
> compatible string is used to distinguish it from the prior SOC's.
>
> changes since V2:
>         1.dropped num-slots property from node as its not required
>           if number of card slots available is 1.

Just to mention: this is actually not board specific.  No exynos
products support more than one slot.  ...and in fact apparently NOBODY
supports more than one slot.  I have a plan to post up a patch
removing multislot support whenever I have a free moment.

Anyway, what you did is fine.


>         2.Move the below properties
>                 a.fifo-depth

Right, not board-specific.  This is SoC specific.  Interestingly
enough you appear to have it wrong.  I have it on good authority that
5420 has a FIFO depth of 0x40 not 0x80.  Apparently the FIFO is 0x40
deep and 64 wide whereas the old FIFO is 0x80 deep and 32 wide.


>                 b.card-detect-delay
>                 c.samsung,dw-mshc-ciu-div
>                 d.samsung,dw-mshc-sdr-timing
>                 e.samsung,dw-mshc-ddr-timing

These ARE board specific, actually.  ...and Tomasz has pointed out.


> +       dwmmc_2: dwmmc2@12220000 {
> +               compatible = "samsung,exynos5420-dw-mshc";
> +               interrupts = <0 77 0>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x12220000 0x2000>;
> +               clocks = <&clock 353>, <&clock 134>;
> +               clock-names = "biu", "ciu";
> +               fifo-depth = <0x80>;
> +               card-detect-delay = <200>;
> +               samsung,dw-mshc-ciu-div = <3>;
> +               samsung,dw-mshc-sdr-timing = <2 3>;
> +               samsung,dw-mshc-ddr-timing = <1 2>;

Note: I have information that says that these timings are not correct
and that nearly always the "drive" timing should be 0 and the sample
timing 4.  ...but we haven't landed that change ourselves yet, so
maybe keeping the timings you have is right.


-Doug
