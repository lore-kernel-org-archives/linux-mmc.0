From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [ulf.hansson-mmc:next 17/29] drivers/input/touchscreen/cyttsp4_core.c:1218:1:
 warning: 'cyttsp4_irq' uses dynamic stack allocation
Date: Mon, 25 Aug 2014 10:58:20 +0200
Message-ID: <CACRpkda3qBG=fe3r60r_srjj-k9s=Y17M9A3OuA2i7SM21mvDw@mail.gmail.com>
References: <53f22c36.qbCHWEfTMJdv7qIU%fengguang.wu@intel.com>
	<CACRpkdbJ=qLr5-jiJrtOKA-qaV1XrXs0uYQ+9NdgO42vAo0GMA@mail.gmail.com>
	<CAPDyKFrqQuTrrg2im=hMtSjRrJb0Lq4M1u7C6C-13cZLXdwZ1w@mail.gmail.com>
	<CACRpkda1=2EZLe-eOw2n-sPWEDi_S31rjRxKFWxu47NeatZRpQ@mail.gmail.com>
	<CAPDyKFpLHZuxTRnF81+aHQS-=giK3vbsdfD8NGoktwiw-L-eFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:62614 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbaHYI6V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Aug 2014 04:58:21 -0400
Received: by mail-oi0-f42.google.com with SMTP id a3so9436175oib.15
        for <linux-mmc@vger.kernel.org>; Mon, 25 Aug 2014 01:58:20 -0700 (PDT)
In-Reply-To: <CAPDyKFpLHZuxTRnF81+aHQS-=giK3vbsdfD8NGoktwiw-L-eFA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "kbuild-all@01.org" <kbuild-all@01.org>, kbuild test robot <fengguang.wu@intel.com>

On Wed, Aug 20, 2014 at 10:17 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Implementation wise, I would prefer to not have stubs unless it's
> explicitly needed. Still one may argue that a built kernel binary
> should have the smallest possible footprint, which means stubs should
> be added.
>
> Do you know if there are common understanding among maintainers of how
> this should be done?

During the kernel summit kernel tinyfication discussion I think the
point was made that Josh (who initiated the discussion) did not
worry so much about the size of subsystems, as these can always
be hacked if need be. He was more worried about core kernel code
growing wild.

Yours,
Linus Walleij
