From: Fabio Estevam <festevam@gmail.com>
Subject: Re: SDIO - High Speed - iMX6
Date: Sat, 14 Feb 2015 16:48:51 -0200
Message-ID: <CAOMZO5DR2nnoChgC2PbXkrDCAfF0WG_Vf+iXR3UsfFGxQxagmA@mail.gmail.com>
References: <CACUGKYNPE1zAHt4Hx4c5ufuHNchVXnUOC1znCa7dT9povD_CWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:46467 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264AbbBNSsx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 14 Feb 2015 13:48:53 -0500
Received: by lams18 with SMTP id s18so22023172lam.13
        for <linux-mmc@vger.kernel.org>; Sat, 14 Feb 2015 10:48:51 -0800 (PST)
In-Reply-To: <CACUGKYNPE1zAHt4Hx4c5ufuHNchVXnUOC1znCa7dT9povD_CWQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi John,

On Wed, Feb 11, 2015 at 10:24 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hello All,
>
> We interface the WiLink8 (http://www.ti.com/lit/gpn/wl1807mod) in iMX6
> custom board. The VIO is 1.8v and the kernel detect the chip in high
> speed mode with a signal voltage of 3.3v.
>
> Is there a way to force the kernel to use a 1.8v signal voltage?.

In drivers/mmc/core/sdio.c, function mmc_sdio_init_card() has:

    /*
     * If the host and card support UHS-I mode request the card
     * to switch to 1.8V signaling level.  No 1.8v signalling if
     * UHS mode is not enabled to maintain compatibility and some
     * systems that claim 1.8v signalling in fact do not support
     * it.
     */
    if (!powered_resume && (rocr & ocr & R4_18V_PRESENT)) {
        err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
                    ocr);

Can you add a printk to check if mmc_set_signal_voltage() is getting called?
