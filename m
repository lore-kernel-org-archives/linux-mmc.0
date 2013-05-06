From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/3] mmc: sdhci: support runtime PM for BYT SD cards
Date: Mon, 6 May 2013 21:27:39 +0200
Message-ID: <CACRpkdYsMwAZSw9McHQE4VSsS7wUWLm+mtR1yLzdPCaQzDUo3A@mail.gmail.com>
References: <1367831854-31952-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:47214 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab3EFT1k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 15:27:40 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so4600186iea.18
        for <linux-mmc@vger.kernel.org>; Mon, 06 May 2013 12:27:39 -0700 (PDT)
In-Reply-To: <1367831854-31952-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Grant Likely <grant.likely@secretlab.ca>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, May 6, 2013 at 11:17 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Here are 3 patches to support runtime PM for BYT SD cards
>
> Please note that these patches are dependent upon 2 gpio patches
> that are in linux-next and linux-gpio but not the mmc tree.
> Those patches are:
>
>         author  Mika Westerberg <mika.westerberg@linux.intel.com>       2013-04-03 10:56:54 (GMT)
>         committer       Linus Walleij <linus.walleij@linaro.org>        2013-04-11 22:31:18 (GMT)
>         commit  12028d2d216220618f76284af5f8ed510b11da55 (patch)
>         gpiolib-acpi: introduce acpi_get_gpio_by_index() helper
>
>         author  Rafael J. Wysocki <rafael.j.wysocki@intel.com>  2013-04-09 13:57:25 (GMT)
>         committer       Linus Walleij <linus.walleij@linaro.org>        2013-04-10 21:41:17 (GMT)
>         commit  7fc7acb9a0b0ff3ffdf21818fe0735ebaf4fecb8 (patch)
>         gpio / ACPI: Handle ACPI events in accordance with the spec
>
> I think those patches are queued for 3.10.
>
> cc: Linus Walleij <linus.walleij@linaro.org>

No they are currently not, and will as it looks right now *not* be in v3.10 due
to a screwup from my side, and that screwup walking the ladder to
Torvalds where it exploded. So he's not pulling the GPIO tree this merge
window.

So just sit back and synchronize this for v3.11 (surely they can be taken
through the GPIO tree if Chris gives his ACK on them).

Yours,
Linus Walleij
