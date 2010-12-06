From: Daniel Drake <dsd@laptop.org>
Subject: Re: reference implementation of runtime PM
Date: Mon, 6 Dec 2010 20:03:46 +0000
Message-ID: <AANLkTimbc3Hwq+JckQLW5=AMAzhDTQGaPsaS-r5M0XKt@mail.gmail.com>
References: <AANLkTikK-SvvDHfeNHXP4tw_e3p3gZ4XaT8Ta5YpuDar@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:53603 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab0LFUDs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Dec 2010 15:03:48 -0500
Received: by gwb20 with SMTP id 20so6851670gwb.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Dec 2010 12:03:47 -0800 (PST)
In-Reply-To: <AANLkTikK-SvvDHfeNHXP4tw_e3p3gZ4XaT8Ta5YpuDar@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

On 6 December 2010 17:57, Daniel Drake <dsd@laptop.org> wrote:
> I've dug down and I think that runtime PM is doing basically nothing.
> i.e. when the system decides to runtime-suspend my SD card, nothing
> actually happens to the SD card. It remains fully powered and
> untouched. I'm basing this assumption on mmc_power_save_host() which
> relies entirely on host->bus_ops->power_save() doing the actual
> power-down work. On sdhci this method does not exist.

Sorry, I now realise there are a number of confusions in my earlier mail.
power_save is done by the bus, not the host, and the host does get its
opportunity to power down via the set_ios callback that comes in
telling it to turn the card off.

Still can't get our card to reset properly though. Tried sprinking
some sdhci_reset and sdhci_reinit calls around, no luck.

We do know that it can be powered down and up just fine at runtime via
mmc_stop_host then mmc_start_host. So there's something that happens
in that path which does not occur with runtime pm...

Daniel
