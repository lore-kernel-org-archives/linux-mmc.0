From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH RFC 07/31] mmc: sdhci: push card_tasklet into threaded irq handler
Date: Wed, 19 Feb 2014 11:43:19 +0530
Message-ID: <CAKohpoknX=acZHJeydwv6XRKFHTD4DM84xfCJ=56NrRfJnBOOA@mail.gmail.com>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
	<E1WFmIk-0006m0-Ah@rmk-PC.arm.linux.org.uk>
	<20140218175703.GJ21483@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:54647 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbaBSGNT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Feb 2014 01:13:19 -0500
Received: by mail-ob0-f181.google.com with SMTP id va2so19690495obc.40
        for <linux-mmc@vger.kernel.org>; Tue, 18 Feb 2014 22:13:19 -0800 (PST)
In-Reply-To: <20140218175703.GJ21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Pratyush Anand <pratyush.anand@st.com>, spear-devel <spear-devel@list.st.com>, Mohit KUMAR <Mohit.KUMAR@st.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>, Chris Ball <chris@printf.net>

Adding ST people as well who have access to boards and are working on SPEAr.

On 18 February 2014 23:27, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 18, 2014 at 03:09:38PM +0000, Russell King wrote:
>> There's no requirement to have the card tasklet separate now that we
>> have a threaded interrupt handler, so kill this and move the called
>> code into the threaded part of the handler.
>
> This patch breaks sdhci-spear's build due to this:
>
> /* gpio card detection interrupt handler */
> static irqreturn_t sdhci_gpio_irq(int irq, void *dev_id)
> {
>         struct platform_device *pdev = dev_id;
>         struct sdhci_host *host = platform_get_drvdata(pdev);
>         struct spear_sdhci *sdhci = dev_get_platdata(&pdev->dev);
>         unsigned long gpio_irq_type;
>         int val;
>
>         val = gpio_get_value(sdhci->data->card_int_gpio);
>
>         /* val == 1 -> card removed, val == 0 -> card inserted */
>         /* if card removed - set irq for low level, else vice versa */
>         gpio_irq_type = val ? IRQF_TRIGGER_LOW : IRQF_TRIGGER_HIGH;
>         irq_set_irq_type(irq, gpio_irq_type);
>
>         if (sdhci->data->card_power_gpio >= 0) {
>                 if (!sdhci->data->power_always_enb) {
>                         /* if card inserted, give power, otherwise remove it */
>                         val = sdhci->data->power_active_high ? !val : val ;
>                         gpio_set_value(sdhci->data->card_power_gpio, val);
>                 }
>         }
>
>         /* inform sdhci driver about card insertion/removal */
>         tasklet_schedule(&host->card_tasklet);
>
>         return IRQ_HANDLED;
> }
>
> which is really nice code.  WTF is this doing?

:)

> 1) You're controlling the card power GPIO via the insertion/removal
>    interrupt handler?  What's wrong with using a vmmc regulator for
>    that, which will be controlled via the MMC subsystem as required?

Haven't explored that earlier.. Maybe its possible but no idea.
The requirements were like this:
- We may or maynot need a GPIO for controlling power
- If we need it, we may need to disable/enable power with card removal/
insertion Or we may need to keep it enabled for ever..

Don't know if this can be done with existing stuff..

> 2) card detection GPIO is handled natively by sdhci.c, there's really
>    no need for sdhci users to implement this themselves.

Probably it was done to take care of power stuff, so that we know
when card is inserted/removed..

> Viresh, can this custom code be killed?

Not sure. Somebody from inside ST has to work on this, use already
present common stuff from sdhci/regulator/etc..

> Lastly, you do realise that using sdhci-spear with DT results in it
> always claiming GPIO 0 for power control, since you use devm_kzalloc()
> to allocate the private data and never set card_power_gpio to a
> negative number.

Hmm.. No I didn't at that time. Its a bug then.. Actually while leaving ST
I pushed the DT patch upstream and it had power binding there but was
then asked to use regulators etc for it and so dropped it at last time. Never
had bandwidth and hardware after that to do it..

http://www.spinics.net/lists/linux-mmc/msg16685.html

@Pratyush/Mohit: Can you guys help Russell here?

--
viresh
