From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 02/18] mmc: meson-gx: remove code for unsupported CMD23
Date: Thu, 16 Feb 2017 18:49:17 +0100
Message-ID: <887e63e9-43cf-13eb-4190-4a8ee0b68032@gmail.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
 <642a46aa-416c-32a3-f9ef-3feafca72636@gmail.com>
 <m2wpcrbdjr.fsf@baylibre.com>
 <468688a8-8a25-ae07-8027-00779d7ceb07@gmail.com>
 <CAPDyKFrKJpXR7vF=h44FooeDHDofG-+t_CgAHskEW5PeX58e8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33021 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932348AbdBPRth (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2017 12:49:37 -0500
Received: by mail-wr0-f194.google.com with SMTP id i10so2946051wrb.0
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2017 09:49:36 -0800 (PST)
In-Reply-To: <CAPDyKFrKJpXR7vF=h44FooeDHDofG-+t_CgAHskEW5PeX58e8w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Am 16.02.2017 um 09:14 schrieb Ulf Hansson:
> On 16 February 2017 at 08:03, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>> Am 15.02.2017 um 17:54 schrieb Kevin Hilman:
>>> Heiner Kallweit <hkallweit1@gmail.com> writes:
>>>
>>>> CMD23 isn't supported on meson-gx and therefore the "set block count"
>>>> command isn't used. So remove this dead code.
>>>
>>> I'm admittedly a bit unfamiliar with the MMC spec and wrote this driver
>>> mostly by looking at the vendor driver, so forgive the silly
>>> questions...
>>>
>>> Why isn't CMD23 supported, and should we support instead of deleting
>>> this support?
>>>
>> As far as I understand this needs to be supported by the host controller.
>> And setting the respective host flag to enable CMD23 mode lead to a
>> non-working driver when testing on my system.
> 
> CMD23 can be supported by the host *driver*, you don't need HW-support
> to implement this.
> 
Thanks for the explanation. I think I got confused by this comment in
core/block.c: "If CMD23 is supported by card and host, [..]"
I interpreted this as "host controller needs to support this feature".

> You may for example be inspired by the mmci.c driver to understand how
> to implement this. Looks for "mrq->sbc".
> 
> [...]
> 
> Kind regards
> Uffe
> 

