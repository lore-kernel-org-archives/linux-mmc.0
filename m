From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 0/8] Cavium MMC driver
Date: Tue, 20 Dec 2016 13:10:56 +0100
Message-ID: <CAPDyKFqXDt9zBphrSPqMpbzBJsj1zECGBb5DugOEj1eLs9-xPQ@mail.gmail.com>
References: <20161219121552.18316-1-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f175.google.com ([209.85.210.175]:33783 "EHLO
        mail-wj0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757552AbcLTMK7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2016 07:10:59 -0500
Received: by mail-wj0-f175.google.com with SMTP id xy5so174090375wjc.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Dec 2016 04:10:58 -0800 (PST)
In-Reply-To: <20161219121552.18316-1-jglauber@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>

Hi Jan,

On 19 December 2016 at 13:15, Jan Glauber <jglauber@cavium.com> wrote:
> While this patch series seems to be somehow overdue, in the meantime the
> same MMC unit was re-used on Cavium's ThunderX SOC so our interest in making
> progress upstreaming this driver has doubled now...
>
> Glancing over the history of the series I think most of the high-level
> comments should be adressed by now (like DTS representation of the
> multiple slots). I've added some new features for the ARM64 port
> and in the process re-wrote parts of the driver and split it into smaller,
> hopefully easier to review parts.

I only had a quick review, but the overall impression is that it's
getting far better. Here follows my summary.

1) I intend to especially look at DTS representation for the slot
nodes, to make sure we have a good solution. Allow me to get back on
this.

2) I don't like how you have named files, as it doesn't express the
obvious relationship between the core library and the drivers. I would
rather see something similar to dw_mmc or sdhci.

3) Related to 2), I would also like to have a prefix of the commit
messages which express the relationships. Again follow dw_mmc/sdhci.

4) GPIO powers should be modelled as GPIO regulators. I believe we
have discussed this earlier as well (I don't really recall in detail
about the last things). It gives us the opportunity to via the
regulator framework to find out the supported voltage levels. This is
the generic method which is used by mmc drivers, you need to adopt to
this as well.

5) Please reorder the series so the DT bindings doc change comes
first. I need an ack from the DT maintainer for it.

6) The most important feedback:
This driver has been posted in many versions by now. Perhaps I could
have been more responsive throughout the attempts, I apologize for
that. On the other hand, you seems to have a round robin schedule for
whom that sends a new version. :-) That makes me wonder about your
support in the maintenance phase. I hope my concern is wrong, but how
about that you point out a responsible maintainer? Especially since
this seems to become a family of Cavium variants, it would help me if
I could rely on someone providing acks for future changes. Would you
be able to accept that role?

>
> In porting the driver to arm64 I run into some issues.
>
> 1. mmc_parse_of is not capable of supporting multiple slots behind one
>    controller. On arm64 the host controller is presented as one PCI device.
>    There are no devices per slot as with the platform variant, so I
>    needed to create dummy devices to make mmc_parse_of work.
>    IMHO it would be cleaner if mmc_parse_of could be extended to cover
>    the multiple slots case.

Yes. I agree that this make sense!
Seems like we could try to make use of the struct device_node instead
of the struct device.

I will try to come up with an idea, I keep you posted.

>
> 2. Without setting MMC_CAP_1_8V_DDR DDR mode is not usable for eMMC.
>    I would prefer to introduce a new cap flag, MMC_CAP_3_3V_DDR,
>    if possible. Currently I need to add "mmc-ddr-1_8v" to DTS,
>    which seems odd for a 3.3v only host controller.

This keep coming back. Both DT bindings and changing to the mmc core
has been posted.

Allow me to help out and re-post a new series. You can build on top of
them - I will keep you on cc.

>
> 3. Because the slots share the host controller using the
>    "full-pwr-cycle" attribute turned out to not work well.
>    I'm not 100% sure just ignoring the attribute is correct.

The full-pwr-cycle shall be set whether you are able to power cycle
the *card*. So this binding should be a part of each slot/child node -
if the host supports it.

>
> For the driver to work GPIO support is required, the GPIO driver is
> not yet available upstream. Therefore, for the time being I removed
> the GPIO dependency from Kconfig.

Is this is about the GPIO powers or also GPIO card detect?

Anyway, I am fine with not depending on GPIO Kconfig.

[...]

Kind regards
Uffe
