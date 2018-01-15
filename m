From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 14/14] gpio: stmpe: i2c transfer are forbiden in atomic context
Date: Mon, 15 Jan 2018 10:57:24 +0100
Message-ID: <CACRpkdZUqzL0W_sLGSxiz1cOF3DDRjE_9iRrgHb2mnD9uP9fPA@mail.gmail.com>
References: <1515759368-16946-1-git-send-email-patrice.chotard@st.com> <1515759368-16946-15-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515759368-16946-15-git-send-email-patrice.chotard-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Patrice CHOTARD <patrice.chotard-qxv4g6HH51o@public.gmane.org>
Cc: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 12, 2018 at 1:16 PM,  <patrice.chotard-qxv4g6HH51o@public.gmane.org> wrote:

> From: Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>
>
> Move the workaround from stmpe_gpio_irq_unmask() which is executed
> in atomic context to stmpe_gpio_irq_sync_unlock() which is not.
>
> It fixes the following issue:
>
> [    1.500000] BUG: scheduling while atomic: swapper/1/0x00000002
> [    1.500000] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc2-00020-gbd4301f-dirty #28
> [    1.520000] Hardware name: STM32 (Device Tree Support)
> [    1.520000] [<0000bfc9>] (unwind_backtrace) from [<0000b347>] (show_stack+0xb/0xc)
> [    1.530000] [<0000b347>] (show_stack) from [<0001fc49>] (__schedule_bug+0x39/0x58)
> [    1.530000] [<0001fc49>] (__schedule_bug) from [<00168211>] (__schedule+0x23/0x2b2)
> [    1.550000] [<00168211>] (__schedule) from [<001684f7>] (schedule+0x57/0x64)
> [    1.550000] [<001684f7>] (schedule) from [<0016a513>] (schedule_timeout+0x137/0x164)
> [    1.550000] [<0016a513>] (schedule_timeout) from [<00168b91>] (wait_for_common+0x8d/0xfc)
> [    1.570000] [<00168b91>] (wait_for_common) from [<00139753>] (stm32f4_i2c_xfer+0xe9/0xfe)
> [    1.580000] [<00139753>] (stm32f4_i2c_xfer) from [<00138545>] (__i2c_transfer+0x111/0x148)
> [    1.590000] [<00138545>] (__i2c_transfer) from [<001385cf>] (i2c_transfer+0x53/0x70)
> [    1.590000] [<001385cf>] (i2c_transfer) from [<001388a5>] (i2c_smbus_xfer+0x12f/0x36e)
> [    1.600000] [<001388a5>] (i2c_smbus_xfer) from [<00138b49>] (i2c_smbus_read_byte_data+0x1f/0x2a)
> [    1.610000] [<00138b49>] (i2c_smbus_read_byte_data) from [<00124fdd>] (__stmpe_reg_read+0xd/0x24)
> [    1.620000] [<00124fdd>] (__stmpe_reg_read) from [<001252b3>] (stmpe_reg_read+0x19/0x24)
> [    1.630000] [<001252b3>] (stmpe_reg_read) from [<0002c4d1>] (unmask_irq+0x17/0x22)
> [    1.640000] [<0002c4d1>] (unmask_irq) from [<0002c57f>] (irq_startup+0x6f/0x78)
> [    1.650000] [<0002c57f>] (irq_startup) from [<0002b7a1>] (__setup_irq+0x319/0x47c)
> [    1.650000] [<0002b7a1>] (__setup_irq) from [<0002bad3>] (request_threaded_irq+0x6b/0xe8)
> [    1.660000] [<0002bad3>] (request_threaded_irq) from [<0002d0b9>] (devm_request_threaded_irq+0x3b/0x6a)
> [    1.670000] [<0002d0b9>] (devm_request_threaded_irq) from [<001446e7>] (mmc_gpiod_request_cd_irq+0x49/0x8a)
> [    1.680000] [<001446e7>] (mmc_gpiod_request_cd_irq) from [<0013d45d>] (mmc_start_host+0x49/0x60)
> [    1.690000] [<0013d45d>] (mmc_start_host) from [<0013e40b>] (mmc_add_host+0x3b/0x54)
> [    1.700000] [<0013e40b>] (mmc_add_host) from [<00148119>] (mmci_probe+0x4d1/0x60c)
> [    1.710000] [<00148119>] (mmci_probe) from [<000f903b>] (amba_probe+0x7b/0xbe)
> [    1.720000] [<000f903b>] (amba_probe) from [<001170e5>] (driver_probe_device+0x169/0x1f8)
> [    1.730000] [<001170e5>] (driver_probe_device) from [<001171b7>] (__driver_attach+0x43/0x5c)
> [    1.740000] [<001171b7>] (__driver_attach) from [<0011618d>] (bus_for_each_dev+0x3d/0x46)
> [    1.740000] [<0011618d>] (bus_for_each_dev) from [<001165cd>] (bus_add_driver+0xcd/0x124)
> [    1.740000] [<001165cd>] (bus_add_driver) from [<00117713>] (driver_register+0x4d/0x7a)
> [    1.760000] [<00117713>] (driver_register) from [<001fc765>] (do_one_initcall+0xbd/0xe8)
> [    1.770000] [<001fc765>] (do_one_initcall) from [<001fc88b>] (kernel_init_freeable+0xfb/0x134)
> [    1.780000] [<001fc88b>] (kernel_init_freeable) from [<00167ee3>] (kernel_init+0x7/0x9c)
> [    1.790000] [<00167ee3>] (kernel_init) from [<00009b65>] (ret_from_fork+0x11/0x2c)
>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>

Patch applied.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
