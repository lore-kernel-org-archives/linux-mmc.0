From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] mmc: mediatek: Add tune support
Date: Thu, 15 Oct 2015 11:17:58 +0200
Message-ID: <CAPDyKFq5fMDY3e1daCs380nPvNiZRDw9bWg8-x6C4fphBKm+Hw@mail.gmail.com>
References: <1444729078-26585-1-git-send-email-chaotian.jing@mediatek.com>
 <1444729078-26585-4-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFqUFRZF2M4ichgqM2SeRQbh52e5U1oFG9AExsq0SkFj9w@mail.gmail.com>
 <1444877180.8751.15.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1444877180.8751.15.camel@mhfsdcap03>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kristina Martsenko <kristina.martsenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Howard Chen <ibanezchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter@intel.>
List-Id: linux-mmc@vger.kernel.org

[...]

>> >
>> >         struct clk *src_clk;    /* msdc source clock */
>> > +       struct clk *src_clk_parent; /* src_clk's parent */
>> > +       struct clk *hs400_src;  /* 400Mhz source clock */
>>
>> Hmm, so you need to control the upper level clocks. Can you elaborate
>> on why this is needed?
>>
> hs400 is DDR200, in our host design, if the mode is DDR(HS400), if want
> to get 200Mhz mmc bus clock frequency, the minimum source clock is
> double of the mmc bus clock, So, we need it for HS400 mode with 200Mhz
> bus clock.

Thanks for clarifying.

[...]

 >         flags = readl(host->base + MSDC_INTEN);
>> >         sdr_clr_bits(host->base + MSDC_INTEN, flags);
>> > -       if (ddr) { /* may need to modify later */
>> > -               mode = 0x2; /* ddr mode and use divisor */
>> > +       sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_HS400_CK_MODE);
>> > +       if (timing == MMC_TIMING_UHS_DDR50 ||
>> > +           timing == MMC_TIMING_MMC_DDR52 ||
>>
>> So, no support for HS200?
>>
> HS200 is the same with other SDR modes, so it will be handled at else..

Okay, nice!

So, your the driver currently supports HS200, but without need for tuning!?

[...]

>> > +static struct msdc_delay_phase get_best_delay(u32 delay)
>> > +{
>> > +       int start = 0, len = 0;
>> > +       int start_final = 0, len_final = 0;
>> > +       u8 final_phase = 0xff;
>> > +       struct msdc_delay_phase delay_phase;
>> > +
>> > +       if (delay == 0) {
>> > +               pr_err("phase error: [map:%x]\n", delay);
>>
>> Please use dev_err|warn|dbg|info instead.
>>
> As you know, this function is just only parse the argument "u32 delay",
> it do not bind with any device.

You may just add a msdc_host * as a parameter to the function, that
would solve this.

[...]

>> > +static int msdc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error)
>>
>> I think you can remove this function and use mmc_send_tuning() instead.
> Hmm, I also noticed that there was a mmc_send_tuning, but, I need to get
> the cmd_error when tune cmd response, in this case, do not care the data
> error.

Well, if you need to extend the mmc_send_tuning() API to suite your
needs, let's do that instead of duplicating code.

>>
>> > +{
>> > +       struct mmc_request mrq = {NULL};
>> > +       struct mmc_command cmd = {0};
>> > +       struct mmc_data data = {0};
>> > +       struct scatterlist sg;
>> > +       struct mmc_ios *ios = &host->ios;
>> > +       int size, err = 0;
>> > +       u8 *data_buf;
>> > +
>> > +       if (ios->bus_width == MMC_BUS_WIDTH_8)
>> > +               size = 128;
>> > +       else if (ios->bus_width == MMC_BUS_WIDTH_4)
>> > +               size = 64;
>> > +       else
>> > +               return -EINVAL;
>> > +
>> > +       data_buf = kzalloc(size, GFP_KERNEL);
>> > +       if (!data_buf)
>> > +               return -ENOMEM;
>> > +
>> > +       mrq.cmd = &cmd;
>> > +       mrq.data = &data;
>> > +
>> > +       cmd.opcode = opcode;
>> > +       cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
>> > +
>> > +       data.blksz = size;
>> > +       data.blocks = 1;
>> > +       data.flags = MMC_DATA_READ;
>> > +
>> > +       /*
>> > +        * According to the tuning specs, Tuning process
>> > +        * is normally shorter 40 executions of CMD19,
>> > +        * and timeout value should be shorter than 150 ms
>> > +        */
>> > +       data.timeout_ns = 150 * NSEC_PER_MSEC;
>> > +
>> > +       data.sg = &sg;
>> > +       data.sg_len = 1;
>> > +       sg_init_one(&sg, data_buf, size);
>> > +
>> > +       mmc_wait_for_req(host, &mrq);
>> > +
>> > +       if (cmd_error)
>> > +               *cmd_error = cmd.error;
>> > +
>> > +       if (cmd.error) {
>> > +               err = cmd.error;
>> > +               goto out;
>> > +       }
>> > +
>> > +       if (data.error) {
>> > +               err = data.error;
>> > +               goto out;
>> > +       }
>> > +
>> > +out:
>> > +       kfree(data_buf);
>> > +       return err;
>> > +}
>> > +

[...]

>> > +       host->src_clk_parent = clk_get_parent(host->src_clk);
>>
>> Don't you need to check the return value here?
>>
> will check it.
>> > +       host->hs400_src = devm_clk_get(&pdev->dev, "400mhz");
>>
>> That's a really weird conid for a clock. If it's not too late to
>> change, please do that!
>>
>> > +       if (IS_ERR(host->hs400_src)) {
>> > +               dev_dbg(&pdev->dev, "Cannot find 400mhz at dts!\n");
>> > +       } else if (clk_set_parent(host->src_clk_parent, host->hs400_src) < 0) {
>> > +               dev_err(host->dev, "Failed to set 400mhz source clock!\n");
>> > +               ret = -EINVAL;
>>
>> I think it seems more apropriate to use the return value from
>> clk_set_parent() instead of inventing your own return value.
>>
> OK.
>> > +               goto host_free;
>> > +       }
>>
>> It seems like you don't need to store the src_clk_parent and the
>> hs400_src in the host struct, as you are only using it during
>> ->probe().
> OK,will remove the member src_clk.

According to your earlier clarification about the clock source and
clock rate. I think a more proper solution would be to use the
clk_set_min_rate() or clk_set_rate_range() API, instead of dealing
with re-parenting of the clock as above.

FYI, a clock provider may implement the ->determine_rate() ops to deal
with re-parenting to find the requested clock rate.

[...]

Kind regards
Uffe
