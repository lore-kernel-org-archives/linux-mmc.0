From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP Platform
 Tap Delays Setup
Date: Thu, 20 Jun 2019 15:33:34 +0200
Message-ID: <CAPDyKFqwe7ss6r99Dxg_OFjKUmCYK_k3pyfYAe62BM7H=a4A7w@mail.gmail.com>
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
 <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFrJwpwUUX_q2kcR9QY_fv9Lgos+ixPmU6JMeJVqJAiFpg@mail.gmail.com>
 <5feac3fb-bef3-b7d1-57d6-81e115e1f555@xilinx.com> <CAPDyKFp_ZvSjFp2FGonzGsnc9xPyZ7qOCaRnX1SimBxLpfz9-Q@mail.gmail.com>
 <MN2PR02MB6029DB87CEE32655B0F1E794C1E50@MN2PR02MB6029.namprd02.prod.outlook.com>
 <CAPDyKFqb3uRU1XbrioSw6UZ5atZ8WwZNhQ_yq2+3JfxXZCxr7g@mail.gmail.com> <MN2PR02MB602935234A2A779B5A05CD63C1E40@MN2PR02MB6029.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <MN2PR02MB602935234A2A779B5A05CD63C1E40@MN2PR02MB6029.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Manish Narani <MNARANI@xilinx.com>
Cc: Michal Simek <michals@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>, Nava kishore Manne <navam@xilinx.com>, Olof Johansson <olof@lixom.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 20 Jun 2019 at 10:14, Manish Narani <MNARANI@xilinx.com> wrote:
>
> Hi Uffe,
>
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Wednesday, June 19, 2019 7:09 PM
> > To: Manish Narani <MNARANI@xilinx.com>
> > Cc: Michal Simek <michals@xilinx.com>; Rob Herring <robh+dt@kernel.org>;
> > Mark Rutland <mark.rutland@arm.com>; Adrian Hunter
> > <adrian.hunter@intel.com>; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> > <JOLLYS@xilinx.com>; Nava kishore Manne <navam@xilinx.com>; Olof
> > Johansson <olof@lixom.net>; linux-mmc@vger.kernel.org; DTML
> > <devicetree@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Linux ARM <linux-arm-kernel@lists.infradead.org>
> > Subject: Re: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP
> > Platform Tap Delays Setup
> >
> > On Wed, 19 Jun 2019 at 10:40, Manish Narani <MNARANI@xilinx.com> wrote:
> > >
> > > Hi Uffe,
> > >
> > >
> > > > -----Original Message-----
> > > > From: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Sent: Monday, June 17, 2019 5:51 PM
> > > [...]
> > > >
> > > > The "const struct zynqmp_eemi_ops *eemi_ops; should then be moved into
> > > > a clock provider specific struct, which is assigned when calling
> > > > sdhci_arasan_register_sdclk. I understand that all the clock data is
> > > > folded into struct sdhci_arasan_data today, but I think that should be
> > > > moved into a "sub-struct" for the clock specifics.
> > > >
> > > > Moreover, when registering the clock, we should convert from using
> > > > devm_clk_register() into devm_clk_hw_register() as the first one is
> > > > now deprecated.
> > >
> > > Just a query here:
> > > When we switch to using devm_clk_hw_register() here, it will register the
> > clk_hw and return int.
> > > Is there a way we can get the clk (related to the clk_hw registered) from the
> > > clock framework?
> > > I am asking this because we will need that clk pointer while calling
> > clk_set_phase() function.
> >
> > I assume devm_clk_get() should work fine?
>
> This clock does not come through ZynqMP Clock framework. We are initializing it in this 'sdhci-of-arasan' driver and getting only the clock name from "clock_output_names" property. So I think devm_clk_get() will not work here for our case.

Well, I guess you need to register an OF clock provider to allow the
clock lookup to work. Apologize, but I don't have the time, currently
to point you in the exact direction.

However, in principle, my point is, there should be no difference
whether the clock is registered via the "ZynqMP Clock framework" or
via the mmc driver. The *clk_get() thing need to work, otherwise I
consider the clock registration in the mmc driver to be a hack. If you
see what I mean.

> I have gone through the clock framework and I found one function which may be used to create clock from clock hw, that is ' clk_hw_create_clk()' which can be used from our driver, however this needs change in the clock framework as below :
>
> ---
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index aa51756..4dc69ff 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3420,6 +3420,7 @@ struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
>
>         return clk;
>  }
> +EXPORT_SYMBOL_GPL(clk_hw_create_clk);
>
>  static int clk_cpy_name(const char **dst_p, const char *src, bool must_exist)
>  {
> diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
> index d8400d6..2319899 100644
> --- a/drivers/clk/clk.h
> +++ b/drivers/clk/clk.h
> @@ -22,17 +22,9 @@ static inline struct clk_hw *of_clk_get_hw(struct device_node *np,
>  struct clk_hw *clk_find_hw(const char *dev_id, const char *con_id);
>
>  #ifdef CONFIG_COMMON_CLK
> -struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
> -                             const char *dev_id, const char *con_id);
>  void __clk_put(struct clk *clk);
>  #else
>  /* All these casts to avoid ifdefs in clkdev... */
> -static inline struct clk *
> -clk_hw_create_clk(struct device *dev, struct clk_hw *hw, const char *dev_id,
> -                 const char *con_id)
> -{
> -       return (struct clk *)hw;
> -}
>  static struct clk_hw *__clk_get_hw(struct clk *clk)
>  {
>         return (struct clk_hw *)clk;
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index f689fc5..d3f60fe 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -18,6 +18,7 @@
>
>  struct device;
>  struct clk;
> +struct clk_hw;
>  struct device_node;
>  struct of_phandle_args;
>
> @@ -934,4 +935,15 @@ static inline struct clk *of_clk_get_from_provider(struct of_phandle_args *clksp
>  }
>  #endif
>
> +#ifdef CONFIG_COMMON_CLK
> +struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
> +                             const char *dev_id, const char *con_id);
> +#else
> +static inline struct clk *
> +clk_hw_create_clk(struct device *dev, struct clk_hw *hw, const char *dev_id,
> +                 const char *con_id)
> +{
> +       return (struct clk *)hw;
> +}
> +#endif
>  #endif
> ---
>
> This change should help other drivers (outside 'drivers/clk/') as well for getting the clock created from clk_hw.
> Is this fine to do?

I think this is the wrong approach, see why further above.

Kind regards
Uffe
