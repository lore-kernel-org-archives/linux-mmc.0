From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Fri, 23 May 2014 15:34:23 +0200
Message-ID: <CAPDyKFrAsMxZrHQhofQ_J1Z8rk1DZ5Jvp7bwQKgNQ3u_ga-6sQ@mail.gmail.com>
References: <537DC832.3020006@redhat.com>
	<CAGb2v64VZac2KvAALrScecN89sRnBQoDrKxKMvkte+3G04NXeA@mail.gmail.com>
	<537DE1AA.5050606@redhat.com>
	<537E31F7.1030505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:64218 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbaEWNeY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 09:34:24 -0400
Received: by mail-qc0-f172.google.com with SMTP id l6so8206382qcy.31
        for <linux-mmc@vger.kernel.org>; Fri, 23 May 2014 06:34:23 -0700 (PDT)
In-Reply-To: <537E31F7.1030505@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

On 22 May 2014 19:20, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi,
>
>
> On 22.05.2014 13:38, Hans de Goede wrote:
>> On 05/22/2014 12:23 PM, Chen-Yu Tsai wrote:
>>> On Thu, May 22, 2014 at 5:49 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>
> snip
>
>>>> I've been thinking a bit about this, and it is a non trivial problem since
>>>> sdio devices are normally instantiated when probed, unlike ie spi devices
>>>> which are instantiated from devicetree.
>>>>
>>>> Adding device tree instantiation of sdio devices seems like a bad idea, as
>>>> then we get 2 vastly different device instantiation paths. Still we need some
>>>> way to get power and clks setup before the mmc host initializes.
>
> What about introducing some extra callbacks to mmc drivers to build
> driver data and control power?
>
> struct mmc_legacy_device {
>         /* ... */
>         struct device_node *of_node;
>         void *driver_data;
> };
>
> struct mmc_driver {
>         /* ... */
>         int (*prepare)(struct mmc_legacy_device *);
>         void (*unprepare)(struct mmc_legacy_device *);
> };
>
> static int my_wlan_prepare(struct mmc_legacy_device *dev)
> {
>         struct my_wlan_data *data;
>
>         data = kzalloc(...);
>         /* ... */
>
>         of_*();
>         clk_*();
>         regulator_*();
>         /* ... */
>
>         ret = my_wlan_power_on(data);
>         /* ... */
>
>         dev->driver_data = data;
> }
>
> static void my_wlan_unprepare(struct mmc_legacy_device *dev)
> {
>         struct my_wlan_data *data;
>
>         data = dev->driver_data;
>
>         my_wlan_power_off(data);
>         /* ... */
>
>         dev->driver_data = NULL;
>         kfree(data);
> }
>
> I don't really like this, especially the fact that this would be highly
> MMC-specific, while there are other interfaces that also need this
> problem solved, e.g. USB/HSIC.
>
> I had proposed another solution that would require almost no changes in
> MMC core and could work for any data interface. You can find it
> somewhere in the thread mentioned by Chen-Yu. Unfortunately, for reasons
> that don't appeal to me, it wasn't positively received by MMC people.

Hi Tomasz,

To be clear, I surely liked your proposal, sorry if you interpreted my
comments differently. I was just eager to see some patches before
continuing the discussion. :-)

If remember correctly, our discussion went on hold, while we tried to
figure out how to handle the probing of the "power controller driver".
I gave some suggestion, which had some pros and cons. Let's follow up
on this.

I start by giving a short re-cap of my view for how to solve this
problem, which is based upon your idea with the "power controller
driver".

1.
The power controller driver handles the needed _external_ PM resources
and maintains SOC specific power on sequence, to be able to initialize
the "non-removable" SDIO card.

To not mix things up, the mmc host will also manages some PM resources
to be able to serve communication with the SDIO card. These resources
are typically the SDIO VCC power, the SDIO bus interface clock,
pinctrl for the interface signals, etc.

2.
To handle reference counting, we rely on runtime PM, using
pm_runtime_get|put() of the power controller's struct device.

3.
By using runtime PM as in 2), we enable the power controller driver to
keep a centralized control of the PM resources. This will also be
useful when the resources are shared. For example, like we have on
ux500 with bluetooth and wlan.


If this above seems like a reasonable approach, we still have a few
things to iron out.

1.
The power controller driver needs to be probed prior the actual SDIO
card detection starts, which is managed through a scheduled work
triggered when the mmc host gets added to the mmc core.

2.
The mmc core or host, need a handle of the power controller's struct
device to  be able to invoke pm_runtime_get|put() on it.

Suggestions/comments? They are welcome! :-)

Kind regards
Ulf Hansson
