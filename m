From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v2 06/10] mmc: omap_hsmmc: add support for pbias configuration
 in dt
Date: Thu, 13 Jun 2013 20:22:42 +0530
Message-ID: <51B9DCBA.4050509@ti.com>
References: <20130523184045.GD13507@atomide.com> <CACRpkdZAzAJW0UxGCSj-PWXTSi2Q6T8fqL9SQ+Y-91sELQ3SRQ@mail.gmail.com> <20130613095353.GX8164@atomide.com> <10084205.q81YqXBJ5H@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44845 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346Ab3FMOxB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 Jun 2013 10:53:01 -0400
In-Reply-To: <10084205.q81YqXBJ5H@avalon>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Thursday 13 June 2013 03:32 PM, Laurent Pinchart wrote:
> On Thursday 13 June 2013 02:53:54 Tony Lindgren wrote:
>> * Linus Walleij <linus.walleij@linaro.org> [130613 02:42]:
>>> On Thu, Jun 6, 2013 at 9:14 PM, Balaji T K <balajitk@ti.com> wrote:
>>>> PBIAS register configuration is based on the regulator voltage
>>>> which supplies these pbias cells, sd i/o pads.
>>>> With PBIAS register address and bit definitions different across
>>>> omap[3,4,5], Simplify PBIAS configuration under three different
>>>> regulator voltage levels - O V, 1.8 V, 3 V. Corresponding pinctrl states
>>>> are defined as pbias_off, pbias_1v8, pbias_3v.
>>>>
>>>> pinctrl state mmc_init is used for configuring speed mode, loopback
>>>> clock (in devconf0/devconf1/prog_io1 register for omap3) and pull
>>>> strength configuration (in control_mmc1 for omap4)
>>>>
>>>> Signed-off-by: Balaji T K <balajitk@ti.com>
>>>
>>> You *need* Lee Jones and Mark Brown to review this.
>>> Maybe Laurent has something to add too.
>>>
>>> Ux500 had the very same thing, and there this was solved using
>>> a GPIO regulator for "vqmmc" a level-shifter. I vaguely remember
>>> Laurent doing something similar with the SH stuff.
>
> The SH pinctrl driver registers an MMC regulator. The code is available at
> git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git. Look at
> drivers/pinctrl/sh-pfc/pfc-sh73a0.c in tags/renesas-next-20130611v2.
>

Hi,

Thanks for the link, I think I need some time to understand
where pfc->window[1].virt is coming from.
