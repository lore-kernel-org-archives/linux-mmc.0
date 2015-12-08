From: Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH v4] mmc: meson: Add driver for the SD/MMC host found on
 Amlogic MesonX SoCs
Date: Tue, 8 Dec 2015 17:22:55 +0100
Message-ID: <CAOQ7t2aJAPWd3Xmvu7n0EWL-KC8ZriM3KryfsYEh556uXhuR+g@mail.gmail.com>
References: <1448988109-32630-1-git-send-email-carlo@caione.org>
 <CAPDyKFp=buvJ8Li3XC8XSUAUO7BsE+U6vEQH2xTrgcHAkdG8bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFp=buvJ8Li3XC8XSUAUO7BsE+U6vEQH2xTrgcHAkdG8bQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Victor Wan <victor.wan@amlogic.com>, linux-meson@googlegroups.com, linux-mmc <linux-mmc@vger.kernel.org>, Daniel Drake <drake@endlessm.com>, Carlo Caione <carlo@endlessm.com>, Carlo Caione <carlo@caione.org>, Jerry Cao <jerry.cao@amlogic.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Dec 8, 2015 at 4:06 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 1 December 2015 at 17:41, Carlo Caione <carlo@caione.org> wrote:

>> +Required properties:
>> + - compatible : "amlogic,meson-mmc"
>> + - reg : mmc controller base registers
>> + - interrupts : mmc controller interrupt
>> + - clocks : phandle to clock provider
>> + - pinctrl-names : should contain "sdio_a" or "sdio_b"
>
> This is weird. I don't think you need this specific states.
> You should be able to cope with common used "default" state.
>
> Later in the driver code I realize that you have some register bits
> that is related to either using port a or port b. But I don't think
> that is the same thing as having different pinctrls states.

Unfortunately documentation is not really clear about this. A
multi-slot capable device maybe?

> If you can't detect whether port a or b is used in runtime by the
> driver, I suggest you add a separate meson mmc DT binding telling what
> port is being used.

That was my initial idea. In v3 I had the "meson,sdio-port" property
for that. I'll put it back in the next revision.

>> + - pinctrl-0: Should specify pin control groups used for this controller
>> +
>> +Optional properties:
>> + - for cd, bus-width and additional generic mmc parameters
>> +   please refer to mmc.txt within this directory
>> +
>> +Examples:
>> +       mmc0: mmc@c1108c20 {
>> +               pinctrl-names = "sdio_b";
>> +               pinctrl-0 = <&mmc0_sd_b_pins>;
>> +               compatible = "amlogic,meson-mmc";
>> +               reg = <0xc1108c20 0x20>;
>> +               interrupts = <0 28 1>;
>> +               clocks = <&clkc CLKID_CLK81>;
>> +       };
>
> Overall the DT documentation looks okay (beside the comments above).
> Although, please separate it to become a patch 1/2. The rest below
> shoud go into a patch 2/2.
>
> For the DT patch please include the DT maintainers when posting the new version.

I'll do.

[...]

>> +       clk_rate >>= 1;
>> +       clk_div = clk_rate / clk_ios - !(clk_rate % clk_ios);
>> +
>> +       conf_reg = readl(host->base + SDIO_CONF);
>> +       conf_reg &= ~REG_CONF_CLK_DIV_M;
>> +       conf_reg |= clk_div;
>> +       writel(conf_reg, host->base + SDIO_CONF);
>> +
>> +       dev_dbg(mmc_dev(mmc), "clk_ios: %d, clk_div: %d, clk_rate: %ld\n",
>> +               clk_ios, clk_div, clk_rate);
>
> It's good practice to update mmc->actual_clock, as it's being used
> from mmc core's debugfs support.

Ok

[...]

>> +
>> +       host = mmc_priv(mmc);
>> +       host->mmc = mmc;
>> +       host->timeout = msecs_to_jiffies(2000);
>
> I don't think this timeout will cover all cases, although I can't
> really tell what a proper value should be as it's dynamically
> changning between requests.
>
> Perhaps try to pick a value that's already being used by other hosts
> is good enough!?

Other drivers use 10s, so I'll try to pick the same value.

I have actually a problem and a question related to this value. On the
boards I'm currently using to test this driver I have no CD GPIO. In
this case do I have to specify the MMC as "non-removable"? Also if I
try to change an SD card at runtime I have to wait 3 times the timeout
before being able to do it successfully.

[...]

>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       host->base = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(host->base)) {
>> +               ret = PTR_ERR(host->base);
>> +               goto error_free_host;
>> +       }
>> +
>> +       irq = platform_get_irq(pdev, 0);
>> +       ret = devm_request_threaded_irq(&pdev->dev, irq, meson_mmc_irq,
>> +                                       meson_mmc_irq_thread, 0, "meson_mmc",
>> +                                       host);
>> +       if (ret)
>> +               goto error_free_host;
>> +
>> +       host->clk = devm_clk_get(&pdev->dev, NULL);
>> +       if (IS_ERR(host->clk)) {
>> +               ret = PTR_ERR(host->clk);
>> +               goto error_free_host;
>> +       }
>
> A clk_prepare_enable() is missing somwhere around here and of course
> then the clock needs to be gated as well. Both in the error handling
> of ->probe() but also in meson_mmc_remove().

No clock gatings yet on this platform but I'll fix it.

>> +
>> +       /* we do not support scatter lists in hardware */
>> +       mmc->max_segs = 1;
>> +       mmc->max_req_size = SDIO_BOUNCE_REQ_SIZE;
>> +       mmc->max_seg_size = mmc->max_req_size;
>> +       mmc->max_blk_count = 256;
>> +       mmc->max_blk_size = mmc->max_req_size / mmc->max_blk_count;
>> +       mmc->f_min = 300000;
>> +       mmc->f_max = 50000000;
>> +       mmc->caps |= MMC_CAP_4_BIT_DATA;
>> +       mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
>> +       mmc->caps2 |= MMC_CAP2_NO_SDIO;
>> +       mmc->ocr_avail = MMC_VDD_33_34;
>> +       mmc->ops = &meson_mmc_ops;
>> +
>> +       spin_lock_init(&host->lock);
>> +
>> +       INIT_DELAYED_WORK(&host->timeout_work, meson_mmc_timeout);
>> +
>> +       pinctrl = devm_pinctrl_get(&pdev->dev);
>> +       if (IS_ERR(pinctrl)) {
>> +               ret = PTR_ERR(pinctrl);
>> +               goto error_free_host;
>> +       }
>> +
>> +       /* We need to know at runtime which port we are using */
>> +       pins = pinctrl_lookup_state(pinctrl, "sdio_b");
>> +       if (!IS_ERR(pins))
>> +               host->port = 1; /* PORT_B */
>> +       else
>> +               host->port = 0; /* PORT_A */
>> +
>
> I think the pinctrl code can be removed, according to my eariler
> comments for the DT documentation.

Agree

> Instead you need a way to find out the currently used port...

I really do not think this is feasible from the driver at runtime. So
I'll go with the new DT property.

[...]

Thanks,

-- 
Carlo Caione
