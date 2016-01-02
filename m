From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 1217:8520 [Dell Latitude E7450] O2 Micro, SD/MMC Card Reader
 doesn't work
Date: Sat, 2 Jan 2016 12:50:19 +0000
Message-ID: <20160102125019.GZ8644@n2100.arm.linux.org.uk>
References: <CAONpWduF6iH4Rr5Y610KP1RE342nWAajR27KFbu1N2iet4R0ZA@mail.gmail.com>
 <BY2PR04MB18438CFFD181C72EFEF408908FE10@BY2PR04MB1843.namprd04.prod.outlook.com>
 <CAPDyKFotgz3czCs8XaXwC4kT53Lp0h=n03OUMtO6BUTwTnDYzQ@mail.gmail.com>
 <BY2PR04MB18432C804C263313D2349C848FE10@BY2PR04MB1843.namprd04.prod.outlook.com>
 <CAONpWdvo+b=Y26zsCYsHFHjJ+8yAnYfoJOsirdS-he2s1unDgg@mail.gmail.com>
 <CAONpWdsHJEHjedfQrjXru0fETRL3NfXG6cyoQAYtLYAKb5i-2Q@mail.gmail.com>
 <CY1PR04MB184843666E915C564A1858CB8FE50@CY1PR04MB1848.namprd04.prod.outlook.com>
 <CAPDyKFqMPfrTdF4JNU-QUBN-va+Xk0EAqHysQ_HpKkmMfQzQNg@mail.gmail.com>
 <20151223111352.GR8644@n2100.arm.linux.org.uk>
 <CAPDyKFr6WE4PpJ8mwsVGEQ0EijySxSVXf5+TG1ZxF2bkh7eNjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:35815 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbcABMud (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 2 Jan 2016 07:50:33 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFr6WE4PpJ8mwsVGEQ0EijySxSVXf5+TG1ZxF2bkh7eNjQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Guo <peter.guo@bayhubtech.com>, Alex Ballas <alex@ballas.org>, "adam8157@gmail.com" <adam8157@gmail.com>, "linux-mmc@VGER.KERNEL.ORG" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On Mon, Dec 28, 2015 at 12:47:26PM +0100, Ulf Hansson wrote:
> On 23 December 2015 at 12:13, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Dec 22, 2015 at 09:30:00AM +0100, Ulf Hansson wrote:
> >> This quirk seems a bit strange. It looks like a generic problem being
> >> solved by the wrong approach. Although, my knowledge of sdhci HW is
> >> limited so I might be wrong.
> >>
> >> Why doesn't sdhci *always* reset the related registers when the
> >> command or data transfer gets *completed*? Instead as currently,
> >> delaying that until the *next* request is started and via using
> >> SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD?
> >
> > That would be additional overhead.  The real problem is that the tuning
> 
> Well, yes but I wonder if it isn't negligible.
> 
> Of course, if it's more suitable to deal with clearing the register
> *before* starting a new request, that should work fine as well.
> 
> Anyway, my point is that I find it odd to have a quirk for something
> that should be common.

It's not "common".  While it can be viewed as just another MMC command
and data transaction, the way hosts handle it vary.  In the case of
SDHCI, the host needs to be placed into a special mode, and DMA must
not be used:

        ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
        ctrl |= SDHCI_CTRL_EXEC_TUNING;
        if (host->quirks2 & SDHCI_QUIRK2_TUNING_WORK_AROUND)
                ctrl |= SDHCI_CTRL_TUNED_CLK;
        sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);

        /*
         * As per the Host Controller spec v3.00, tuning command
         * generates Buffer Read Ready interrupt, so enable that.
         * Note: The spec clearly says that when tuning sequence
         * is being performed, the controller does not generate
         * interrupts other than Buffer Read Ready interrupt. But
         * to make sure we don't hit a controller bug, we _only_
         * enable Buffer Read Ready interrupt here.
         */
        sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
        sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_SIGNAL_ENABLE);

These are different from the normal request path.

        /*
         * Issue CMD19 repeatedly till Execute Tuning is set to 0 or the number
         * of loops reaches 40 times or a timeout of 150ms occurs.
         */
	...

                /*
                 * In response to CMD19, the card sends 64 bytes of tuning
                 * block to the Host Controller. So we set the block size
                 * to 64 here.
                 */
                if (cmd.opcode == MMC_SEND_TUNING_BLOCK_HS200) {
                        if (mmc->ios.bus_width == MMC_BUS_WIDTH_8)
                                sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 128),
                                             SDHCI_BLOCK_SIZE);
                        else if (mmc->ios.bus_width == MMC_BUS_WIDTH_4)
                                sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
                                             SDHCI_BLOCK_SIZE);
                } else {
                        sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
                                     SDHCI_BLOCK_SIZE);
                }

This seems to set a block size of 128 for width-8.

                /*
                 * The tuning block is sent by the card to the host controller.
                 * So we set the TRNS_READ bit in the Transfer Mode register.
                 * This also takes care of setting DMA Enable and Multi Block
                 * Select in the same register to 0.
                 */
                sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);

This is again at odds with the normal request path.

> >> Sdhci's sdhci_execute_tuning() function must be converted to use
> >> mmc_send_tuning().
> >
> > That will make the request path more complex, because we then need to
> > detect the tuning commands and have special handling for them.  With
> > SDHCI, they are not a standard data transfer command, which is what
> > mmc_send_tuning() wants.
> 
> If the regular request path isn't used, the core isn't in control of
> the request.
> 
> I don't like that, as it becomes an exception of how requests are
> managed. It also means the host driver will not benefit from the
> common error handling paths in the core.

See what SDHCI has to do above which is exceptional to the normal
request path processing.

> > This means we end up with more complexity in what is supposed to be a
> > fast path, which means more room for bugs to creep in.
> 
> I assume you refer to that the sdhci's host_ops->request() callback
> would need to check for the tuning commands and thus treat these as
> special cases.
> 
> I agree, we should avoid these kind of checks in host drivers.
> Typically we can address this by adding a new MMC_CAP* and/or a new
> host_ops callback.
> 
> In this case I think a new optional host_ops callback, which
> mmc_send_tuning() would invoke, should to the trick for sdhci.

Please read through sdhci_execute_tuning().  I think this will add
complexity, because we'd need to detect these tuning requests, and
change the host configuration to perform the tuning.

We'd also need some way to distinguish between the "standard" SDHCI
tuning (which needs special handing), and the "embedded" SDHCI tuning
implemented by MSM, SiRF and iMX which do use mmc_send_tuning().

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
