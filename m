Return-Path: <SRS0=inFY=2O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3BBC2D0CF
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Dec 2019 11:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3C320706
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Dec 2019 11:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iHAXl+Bp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfLXLzx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:55:53 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33609 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLXLzx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Dec 2019 06:55:53 -0500
Received: by mail-ed1-f66.google.com with SMTP id r21so17769712edq.0;
        Tue, 24 Dec 2019 03:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJ2izil5/Ji9uczN7PODLAoPu0cmIlffxlCHfxBk4YU=;
        b=iHAXl+BpQqaZEBMzZbdUXlosjCxL5jAno6VWLklvHWuCe8aMA53uYU4F0sbvgp5dUv
         Ior28A0rajF2amfreqMuC+0gfo2ydWFe6Jw8dg8f2mM+gA6XeZyL51lCkwAebklwRfte
         b3Qd592BfHsz5CZQbbKbptQuEVq/Yb4qVRIYNu3cg8FqGo1EQD3HyAerf7lmWf0w9z8D
         wqq6/XWIGmUn3Pll2GcvKUD6Tkx4qJxer4otmdZy2NTJ/vB7hZAYUIDMZ2JfxQbxB3sS
         xx6ZOjX8UPif9qv3b5gwSj0kuhmDPh6vWGaVqpyGJXU1qASh0gS8oas7j/EX68Znk0y0
         w8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJ2izil5/Ji9uczN7PODLAoPu0cmIlffxlCHfxBk4YU=;
        b=Dc+c9eQ1FygxZYBODJqejn2+I/66EoJzUnxj6z11yGYsD6vIdHQPvUfzJUfNDZe6by
         6LPmCCXTXu9Wpr65InL38BpJb57tlAMSJSzsGLrlgUeWFRkPsDQc7BHlnKfKI+zugwuu
         ZmRO5O6vKreD+/QxQXTfN+zw4trTs0D3ObYcRwI216jvDssoSmovArkTSZffRfqaGzpI
         aK+aNGwVO0/f57rwQL8DmGtRv1hhO+iiANWUpp1+KbYXooDSm5Pi4uMHFqBuWhRx/fMy
         mqS9gqz3qAJh18Cmtt+wYLd0FX/+PM7ZJzPl/bKf7uJjGVG1Vh76RZctreQQqn4Vi3Sb
         zvew==
X-Gm-Message-State: APjAAAWNW6+YFpInSVS0oA3nkJnUbjOgjIEL2PDfN4g25pZ/q2U4kRr3
        kCQv7Gi3p+YTWqPGZjJT04zfXL8M3HrHWPQzayk=
X-Google-Smtp-Source: APXvYqwF4VXjATyreWWoETi25OCKXR2YIWyiTrLgLo7qBh2ghWgNKAvKKtzuuDTuNWSV9ZMXyNcwqnOPXDKi9FhbuyM=
X-Received: by 2002:aa7:d6d1:: with SMTP id x17mr1918096edr.57.1577188549568;
 Tue, 24 Dec 2019 03:55:49 -0800 (PST)
MIME-Version: 1.0
References: <20191210200022.29696-1-martin.blumenstingl@googlemail.com>
 <20191210200022.29696-3-martin.blumenstingl@googlemail.com> <CAPDyKFoMEjSJt2n3-XGbHwq_3zQ6MhPifUyOELLeTqFKPkAqYg@mail.gmail.com>
In-Reply-To: <CAPDyKFoMEjSJt2n3-XGbHwq_3zQ6MhPifUyOELLeTqFKPkAqYg@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 24 Dec 2019 12:55:38 +0100
Message-ID: <CAFBinCC84_fVsa5dS-04tQHjSEq2n-Hh=pmJXKh-aHj9SkTVzw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mmc: host: meson-mx-sdhc: new driver for the
 Amlogic Meson SDHC host
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lnykww@gmail.com, yinxin_1989@aliyun.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Thu, Dec 19, 2019 at 3:02 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
[...]
> > +struct meson_mx_sdhc_host {
> > +       struct mmc_host                 *mmc;
> > +
> > +       struct mmc_request              *mrq;
> > +       struct mmc_command              *cmd;
> > +       int                             error;
> > +
> > +       void __iomem                    *base;
> > +
> > +       struct clk_divider              clkc_clk_div;
> > +       struct clk_gate                 clkc_tx_clk_on;
> > +       struct clk_gate                 clkc_rx_clk_on;
> > +       struct clk_gate                 clkc_sd_clk_on;
> > +       struct clk_gate                 clkc_mod_clk_on;
> > +       struct clk_mux                  clkc_clk_src_sel;
> > +
> > +       struct clk                      *pclk;
> > +
> > +       struct clk                      *tx_clk;
> > +       struct clk                      *rx_clk;
> > +       struct clk                      *sd_clk;
> > +       struct clk                      *mod_clk;
>
> This is crazy. It's looks like the driver is a driver for a clock
> provider rather than an mmc host driver. :-)
that's the signature of many Amlogic IP blocks:
they build a clock mux/divider/gate into the actual consumer IP block

> Can you please elaborate a bit on what all these different clocks are
> needed for? Are really all of them needed?
actually I don't know - the public S805 datasheet doesn't list these bits
the vendor driver just calls the first three TX_CLK, RX_CLK, SD_CLK
(that's bits[14:12])
the last one (mod_clk) is documented as:
  Clock Module Enable, Should set before bit[14:12] switch on,
  and after bit[14:12] switch off

so all I know is that the order is important

[...]
> > +static void meson_mx_sdhc_wait_cmd_ready(struct mmc_host *mmc)
> > +{
> > +       struct meson_mx_sdhc_host *host = mmc_priv(mmc);
> > +       u32 stat, esta;
> > +       int ret;
> > +
> > +       ret = readl_poll_timeout(host->base + MESON_SDHC_STAT, stat,
> > +                                !(stat & MESON_SDHC_STAT_CMD_BUSY), 1,
> > +                                100000);
>
> This looks quite inefficient. Isn't there a corresponding IRQ that you
> can look for instead, no?
not that I am aware of :-(

> Can you perhaps also elaborate a bit on what kind of busy check you
> are doing here? Maybe also add some comment about that in the code.
the vendor driver documents this: [2]
  wait sdhc controller cmd send
and the public S805 datasheet states:
  (0:Ready for command,1:busy)

> > +       if (ret) {
> > +               dev_warn(mmc_dev(mmc),
> > +                        "Failed to poll for CMD_BUSY while processing CMD%d\n",
> > +                        host->cmd->opcode);
> > +               meson_mx_sdhc_hw_reset(mmc);
> > +       }
> > +
> > +       ret = readl_poll_timeout(host->base + MESON_SDHC_ESTA, esta,
> > +                                !(esta & MESON_SDHC_ESTA_11_13), 1, 100000);
>
> Another polling. Not possible to wait for an IRQ instead?
unfortunately this is another "not that I'm aware of"

> What are the polling about?
and I don't know yet again :-(

> > +       if (ret) {
> > +               dev_warn(mmc_dev(mmc),
> > +                        "Failed to poll for ESTA[13:11] while processing CMD%d\n",
> > +                        host->cmd->opcode);
>
> What is ESTA[13:11]? If you are going to log a message, please make it
> more understandable.
the only other explanation I found in the vendor driver (which I used
as reference) is this error print:
  sdhc_err("Warning: DMA state is wrong! SDHC_ESTA=0x%x\n", esta);

[...]
> > +static void meson_mx_sdhc_disable_clks(struct mmc_host *mmc)
> > +{
> > +       struct meson_mx_sdhc_host *host = mmc_priv(mmc);
> > +
> > +       if (!host->clocks_enabled)
> > +               return;
> > +
> > +       clk_disable_unprepare(host->tx_clk);
> > +       clk_disable_unprepare(host->rx_clk);
> > +       clk_disable_unprepare(host->sd_clk);
> > +
> > +       clk_disable_unprepare(host->mod_clk);
>
> clk_bulk_disable_unprepare() seems like a better option to use here.
good point, thank you
I'll update that while keeping the order of "mod_clk" right (see [0] and [1])

[...]
> > +static int meson_mx_sdhc_enable_clks(struct mmc_host *mmc)
> > +{
> > +       struct meson_mx_sdhc_host *host = mmc_priv(mmc);
> > +       struct clk *clocks[] = {
> > +               host->mod_clk,
> > +               host->sd_clk,
> > +               host->tx_clk,
> > +               host->rx_clk,
> > +       };
> > +       int i, ret;
> > +
> > +       if (host->clocks_enabled)
> > +               return 0;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(clocks); i++) {
> > +               ret = clk_prepare_enable(clocks[i]);
> > +               if (ret) {
> > +                       dev_err(mmc_dev(mmc), "Failed to enable clock %s\n",
> > +                               __clk_get_name(clocks[i]));
> > +                       goto err;
> > +               }
> > +       }
>
> clk_bulk_prepare_enable() seems like a better option to use here.
ACK, same as above

[...]
> > +static int meson_mx_sdhc_set_clk(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +       struct meson_mx_sdhc_host *host = mmc_priv(mmc);
> > +       u32 rx_clk_phase, val;
> > +       int ret;
> > +
> > +       meson_mx_sdhc_disable_clks(mmc);
> > +
> > +       if (ios->clock) {
> > +               ret = clk_set_rate(host->sd_clk, ios->clock);
> > +               if (ret) {
> > +                       dev_warn(mmc_dev(mmc),
> > +                                "Failed to set MMC clock to %uHz: %d\n",
> > +                                ios->clock, host->error);
> > +                       return ret;
> > +               }
> > +
> > +               ret = meson_mx_sdhc_enable_clks(mmc);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               mmc->actual_clock = clk_get_rate(host->sd_clk);
> > +
> > +               /*
> > +                * according to Amlogic the following latching points are
> > +                * selected with empirical values, there is no (known) formula
> > +                * to calculate these.
> > +                */
> > +               if (mmc->actual_clock > 100000000) {
> > +                       rx_clk_phase = 1;
> > +               } else if (mmc->actual_clock > 45000000) {
> > +                       if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
> > +                               rx_clk_phase = 15;
> > +                       else
> > +                               rx_clk_phase = 11;
> > +               } else if (mmc->actual_clock >= 25000000) {
> > +                       rx_clk_phase = 15;
> > +               } else if (mmc->actual_clock > 5000000) {
> > +                       rx_clk_phase = 23;
> > +               } else if (mmc->actual_clock > 1000000) {
> > +                       rx_clk_phase = 55;
> > +               } else {
> > +                       rx_clk_phase = 1061;
> > +               }
>
> The latching points (in frequency) looks closely related to the bus
> speed timing frequency.
>
> Perhaps that doesn't matter, but I am wondering whether you may want
> to check "ios.timing" in conjunction with the clock rate?
the Amlogic internal datasheet extract I got has them in a table with
the clock settings (mux, divider). I rephrased this table into my own
words - you can find it in the patch description
what's implemented here is basically a translation of the datasheet into C
if it's more consistent with the Linux MMC framework to check for
"ios.timing" (either only checking the timing, or checking it in
addition to the bus speed) then please let me know.

[...]
> > +static struct clk *meson_mx_sdhc_register_clk(struct device *dev,
> > +                                             struct clk_hw *hw,
> > +                                             const char *name,
> > +                                             int num_parents,
> > +                                             const struct clk_parent_data *pd,
> > +                                             unsigned long flags,
> > +                                             const struct clk_ops *ops)
> > +{
> > +       struct clk_init_data init;
> > +
> > +       init.name = devm_kasprintf(dev, GFP_KERNEL, "%s#%s", dev_name(dev),
> > +                                  name);
> > +       if (!init.name)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       init.num_parents = num_parents;
> > +       init.parent_data = pd;
> > +       init.flags = flags;
> > +       init.ops = ops;
> > +
> > +       hw->init = &init;
> > +
> > +       return devm_clk_register(dev, hw);
>
> devm_clk_register() is deprecated. Please convert to
> devm_clk_hw_register() instead.
>
> Note that, this may also lead to that you need to update the
> corresponding DT bindings for the clocks.
>
> Additionally, in regards to the deployment of the clock support, this
> leads to quite some more changes. In principle, the code managing the
> clock provider parts should be quite independent of the clock consumer
> part. I didn't look more closely, maybe this is already the case, then
> the conversion is simple.
just to confirm I understand you correctly:
the dt-bindings should look similar to what others have been working
on for the arasan SDHCI controller: [3]
based on that I'll then go forward and implement the driver part(s)

[...]
> Besides the above comments, I think overall the code looks quite okay to me.
great, thank you for taking the time to review this driver!


Martin


[0] https://github.com/endlessm/linux-meson/blob/d6e13c220931110fe676ede6da69fc61a7cb04b6/drivers/amlogic/mmc/aml_sdhc_m8.c#L1911
[1] https://github.com/endlessm/linux-meson/blob/d6e13c220931110fe676ede6da69fc61a7cb04b6/drivers/amlogic/mmc/aml_sdhc_m8.c#L1933
[2] https://github.com/endlessm/linux-meson/blob/d6e13c220931110fe676ede6da69fc61a7cb04b6/drivers/amlogic/mmc/aml_sdhc_m8.c#L577
[3] https://lkml.org/lkml/2019/7/1/27
