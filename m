From: Fabio Estevam <festevam@gmail.com>
Subject: Re: mmc: imx: 8-bit bus timeout (4.10-rc1)
Date: Tue, 3 Jan 2017 09:27:23 -0200
Message-ID: <CAOMZO5CG=Z-PrRG8DqfMMxxuU+LH5Ljfdt83Yu=AaF8KjcXA0w@mail.gmail.com>
References: <20170102191508.ty7wr42pzxhhchaa@t450s.lan> <CAOMZO5AgFM1T5XSZH3U5O6n+=_bi3eq7jS1XX9xTBS9Z+GwD9w@mail.gmail.com>
 <20170103095729.hxlke5ewajcrtkzz@t450s.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36127 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdACL1Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jan 2017 06:27:24 -0500
Received: by mail-oi0-f65.google.com with SMTP id u15so69810133oie.3
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jan 2017 03:27:23 -0800 (PST)
In-Reply-To: <20170103095729.hxlke5ewajcrtkzz@t450s.lan>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gary Bisson <gary.bisson@boundarydevices.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Lukasz Majewski <lukma@denx.de>

Hi Gary,

On Tue, Jan 3, 2017 at 7:57 AM, Gary Bisson
<gary.bisson@boundarydevices.com> wrote:

> Doing a 'git bisect' shows that the culprit is [1]:
> e173f891 mmc: core: Update CMD13 polling policy when switch to HS DDR
> mode
>
> Unfortunately I don't know the JEDEC specification enough to know what's
> wrong but the patch broke 8-bit eMMC (HS DDR) on i.MX platforms. Which
> platform has it beend tested on?
>
> Ulf and Linus have been added to the loop since they know the details.
>
> Also, I confirm that reverting that patch on v4.10-rc1 fixes the issue.

Thanks for doing the bisect.

I can also confirm that reverting e173f891 ("mmc: core: Update CMD13
polling policy when switch to HS DDR mode") makes the MMC card on
mx6qsabresd to be correctly detected:

mmc2: new DDR MMC card at address 0001

Thanks
