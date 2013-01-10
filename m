From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Patch 'usb: convert drivers/usb/* to use
	module_platform_driver_probe()' applied to my tree
Date: Thu, 10 Jan 2013 13:23:48 +0000
Message-ID: <20130110132348.GD19944@n2100.arm.linux.org.uk>
References: <1357820529@ti.com> <CAHkwnC-vaeZ53chLcgLW3H8_MR-yG9uNoPQ+qg4ddjzVT-8qUQ@mail.gmail.com> <20130110130600.GX28920@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43833 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab3AJNYB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jan 2013 08:24:01 -0500
Content-Disposition: inline
In-Reply-To: <20130110130600.GX28920@arwen.pp.htv.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: Fabio Porcedda <fabio.porcedda@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, eric.y.miao@gmail.com, haojian.zhuang@gmail.com

On Thu, Jan 10, 2013 at 03:06:00PM +0200, Felipe Balbi wrote:
> we just need to make sure that Greg merges my pull request after
> driver-core. Another possibility is that I drop this patch from my tree
> and Greg takes the entire series through driver-core.

What would also be good is if someone also reviews the probe cleanup
and remove paths too.  I just grepped for platform_driver_probe() in
drivers/mmc - which hit three drivers.  Of those three drivers, all
_three_ had bugs there.  It took me about two seconds of looking to
find all these, and I wasn't even looking for this.

First off, mvsdio.c.  C _is_ _not_ PYTHON!

        if (r)
                release_resource(r);
        if (mmc)
                if (!IS_ERR_OR_NULL(host->clk)) {
                        clk_disable_unprepare(host->clk);
                        clk_put(host->clk);
                }
                mmc_free_host(mmc);

        return ret;

and yes, this path can be reached with mmc = NULL.

Secondly:
                if (host->gpio_card_detect) {
                        free_irq(gpio_to_irq(host->gpio_card_detect), host);
                        gpio_free(host->gpio_card_detect);
                }
                if (host->gpio_write_protect)
                        gpio_free(host->gpio_write_protect);

GPIO 0 is a valid GPIO.  Luckily, we won't probe GPIO 0 at probe time,
but this is still buggy.

Thirdly:

probe():
        r = request_mem_region(r->start, SZ_1K, DRIVER_NAME);
        if (!r)
                return -EBUSY;
        host->res = r;
...
        if (r)
                release_resource(r);
...
release():
                release_resource(host->res);

This is not how we free resources allocated by request_mem_region().

Next up, atmel-mci.c:

        if (pdata->slot[0].bus_width) {
                ret = atmci_init_slot(host, &pdata->slot[0],
                                0, ATMCI_SDCSEL_SLOT_A, ATMCI_SDIOIRQA);
...
        if (pdata->slot[1].bus_width) {
                ret = atmci_init_slot(host, &pdata->slot[1],
                                1, ATMCI_SDCSEL_SLOT_B, ATMCI_SDIOIRQB);
...
        if (!host->caps.has_rwproof) {
                host->buffer = dma_alloc_coherent(&pdev->dev, host->buf_size,
                                                  &host->buf_phys_addr,
                                                  GFP_KERNEL);
                if (!host->buffer) {
                        ret = -ENOMEM;
                        dev_err(&pdev->dev, "buffer allocation failed\n");
                        goto err_init_slot;
                }
        }
...
err_init_slot:
        if (host->dma.chan)
                dma_release_channel(host->dma.chan);
        free_irq(irq, host);
err_request_irq:
        iounmap(host->regs);
err_ioremap:
        clk_put(host->mck);
err_clk_get:
        kfree(host);
        return ret;

Great, so on DMA buffer failure (allocated _after_ we publish the interfaces
to the rest of the system - which is in itself buggy) we don't remove these
interfaces, but we free all the resources and memory beneath them.

Finally, davinci_mmc.c:

probe():
        mem = request_mem_region(r->start, mem_size, pdev->name);
...
        host->mem_res = mem;
...
        if (mem)
                release_resource(mem);
...
release():
                release_resource(host->mem_res);

Again, this is not how we free resources allocated by request_mem_region()
and leads to memory leaks.
