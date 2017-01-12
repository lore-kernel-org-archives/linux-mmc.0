From: Gary Bisson <gary.bisson@boundarydevices.com>
Subject: Re: mmc: imx: 8-bit bus timeout (4.10-rc1)
Date: Thu, 12 Jan 2017 11:39:44 +0100
Message-ID: <20170112103944.3a4i6rvpf4r376nx@t450s.lan>
References: <20170102191508.ty7wr42pzxhhchaa@t450s.lan>
 <CAOMZO5AgFM1T5XSZH3U5O6n+=_bi3eq7jS1XX9xTBS9Z+GwD9w@mail.gmail.com>
 <20170103095729.hxlke5ewajcrtkzz@t450s.lan>
 <CAOMZO5CG=Z-PrRG8DqfMMxxuU+LH5Ljfdt83Yu=AaF8KjcXA0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38082 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbdALKjx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2017 05:39:53 -0500
Received: by mail-wm0-f53.google.com with SMTP id r144so14225156wme.1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Jan 2017 02:39:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5CG=Z-PrRG8DqfMMxxuU+LH5Ljfdt83Yu=AaF8KjcXA0w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Lukasz Majewski <lukma@denx.de>

Hi all,

On Tue, Jan 03, 2017 at 09:27:23AM -0200, Fabio Estevam wrote:
> Hi Gary,
> 
> On Tue, Jan 3, 2017 at 7:57 AM, Gary Bisson
> <gary.bisson@boundarydevices.com> wrote:
> 
> > Doing a 'git bisect' shows that the culprit is [1]:
> > e173f891 mmc: core: Update CMD13 polling policy when switch to HS DDR
> > mode
> >
> > Unfortunately I don't know the JEDEC specification enough to know what's
> > wrong but the patch broke 8-bit eMMC (HS DDR) on i.MX platforms. Which
> > platform has it beend tested on?
> >
> > Ulf and Linus have been added to the loop since they know the details.
> >
> > Also, I confirm that reverting that patch on v4.10-rc1 fixes the issue.
> 
> Thanks for doing the bisect.
> 
> I can also confirm that reverting e173f891 ("mmc: core: Update CMD13
> polling policy when switch to HS DDR mode") makes the MMC card on
> mx6qsabresd to be correctly detected:
> 
> mmc2: new DDR MMC card at address 0001

Gentle ping. Should we send a revert patch for next rc cycle?

Regards,
Gary
