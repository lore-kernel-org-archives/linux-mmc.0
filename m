From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 02/18] mmc: meson-gx: remove code for unsupported CMD23
Date: Thu, 16 Feb 2017 09:14:26 +0100
Message-ID: <CAPDyKFrKJpXR7vF=h44FooeDHDofG-+t_CgAHskEW5PeX58e8w@mail.gmail.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
 <642a46aa-416c-32a3-f9ef-3feafca72636@gmail.com> <m2wpcrbdjr.fsf@baylibre.com>
 <468688a8-8a25-ae07-8027-00779d7ceb07@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34761 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbdBPIO1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2017 03:14:27 -0500
Received: by mail-qk0-f172.google.com with SMTP id s186so8843649qkb.1
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2017 00:14:27 -0800 (PST)
In-Reply-To: <468688a8-8a25-ae07-8027-00779d7ceb07@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

On 16 February 2017 at 08:03, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> Am 15.02.2017 um 17:54 schrieb Kevin Hilman:
>> Heiner Kallweit <hkallweit1@gmail.com> writes:
>>
>>> CMD23 isn't supported on meson-gx and therefore the "set block count"
>>> command isn't used. So remove this dead code.
>>
>> I'm admittedly a bit unfamiliar with the MMC spec and wrote this driver
>> mostly by looking at the vendor driver, so forgive the silly
>> questions...
>>
>> Why isn't CMD23 supported, and should we support instead of deleting
>> this support?
>>
> As far as I understand this needs to be supported by the host controller.
> And setting the respective host flag to enable CMD23 mode lead to a
> non-working driver when testing on my system.

CMD23 can be supported by the host *driver*, you don't need HW-support
to implement this.

You may for example be inspired by the mmci.c driver to understand how
to implement this. Looks for "mrq->sbc".

[...]

Kind regards
Uffe
