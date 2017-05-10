From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC 0/2] Add support for Meson MX "SDIO" MMC driver
Date: Wed, 10 May 2017 10:44:34 +0200
Message-ID: <CAPDyKFoYPjB1bjRfFCFT3vuzKgzm6-7L2qgNjxGL392cLDe7uA@mail.gmail.com>
References: <20170506171857.16492-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:36099 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbdEJIog (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 May 2017 04:44:36 -0400
Received: by mail-qt0-f174.google.com with SMTP id m91so20730759qte.3
        for <linux-mmc@vger.kernel.org>; Wed, 10 May 2017 01:44:35 -0700 (PDT)
In-Reply-To: <20170506171857.16492-1-martin.blumenstingl@googlemail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-amlogic@lists.infradead.org

On 6 May 2017 at 19:18, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> This is the successor to Carlo Caione's "Add support for Amlogic Meson
> MMC driver" series (v5) from [0].
>
> I would like you to specifically review:
> - whether I've (ab)used the MMC framework properly (as this is my first
>   "larger" contribution to an MMC driver)

I take a look soonish.

> - I think I have improved the locking compared to Carlo's version,
>   however I'd still like feedback on whether this looks sane now or if I
>   can improve that even further
>
> (notable) changes since Carlo's latest version are:
> - renamed the driver to meson-mx-sdio (Amlogic's reference kernel calls
>   the driver "aml_sdio" as there is a second MMC controller in these SoCs
>   which they call the "SDHC controller"). do the same with our driver to

I don't like to renaming drivers, just because there are a reference
kernel using a different name.

What's is really the difference between controllers? Why do they have
two variants?

Can they be managed by the same driver?

>   avoid confusion once we add support for the second controller (which uses
>   a completely different register layout)

Besides that, do they behave differently in some other way?

> - add support for the internal "mux" in this MMC controller (which allows
>   connecting up to three devices to the the controller - at the cost of
>   performance though since the controller can only process one request at
>   a time). The driver registers a new device for each sub-node, which is
>   then fed into the MMC framework to allow per-slot configuration using
>   devicetree (see the example in the documentation)

Unless there really is deployment for more than one slot on some
boards/SoCs, I would strongly suggest to *not* implement this.

Simply because of overhead and introduced complexity to the driver.

> - use the common clock framework internally for managing the MMC clock
>   (there is a fixed-factor clock in the controller which takes clk81 as
>    input and divides it's clock by two and a divider clock which takes
>    the result from the fixed-factor clock as input)
> - support the regulators provided by the MMC framework
> - support for GPIO-based card-detection and read-only-detection through
>   the MMC framework
> - use of the <linux/bitfield.h> FIELD_PREP and FIELD_GET macros where it
>   make sense (and thus the code easier to read)
> - re-worked locking (based on the locking in dw_mmc as that also provides
>   multiple "MMC slots")

Lots of changes!

Before even start to review (or someone else), you really need to make
this review-able.

So, please, one change per patch - and make sure to write good
changelogs. Then I can start to review.

>
> tests done so far:
> - reading an OLD 256MiB SD card (which uses only a 1-bit bus) works fine
>   (sha1sum of the whole device matches with what I get on my PC's
>   card-reader)
> - reading a somewhat more modern class 10 SD card and putting Arch Linux
>   ARM on it (and using that as root file system)
> - it successfully detects the RTL8723BS SDIO wifi chip in my device (even
>   if the SD card is also enabled)
> - reading a 128MiB file from the SD card while scanning wifi networks on
>   the RTL8723BS card does not seem to result in any corruption (sha1sum
>   of the read file seems to match)
> - read speed of my class 10 SD card: ~15MiB/s
> - (unfortunately I could NOT test downloading a file over wifi to the SD
>   card because the RTL8723BS driver refuses to see any wifi networks, but
>   that might be a problem on the RTL8723BS driver side since I don't get
>   any error and the driver has just landed a few weeks ago in staging)
>
>
> [0] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/412136.html
>

[...]

Kind regards
Uffe
