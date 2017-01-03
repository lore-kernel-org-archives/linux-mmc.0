From: Gary Bisson <gary.bisson@boundarydevices.com>
Subject: Re: mmc: imx: 8-bit bus timeout (4.10-rc1)
Date: Tue, 3 Jan 2017 10:57:30 +0100
Message-ID: <20170103095729.hxlke5ewajcrtkzz@t450s.lan>
References: <20170102191508.ty7wr42pzxhhchaa@t450s.lan>
 <CAOMZO5AgFM1T5XSZH3U5O6n+=_bi3eq7jS1XX9xTBS9Z+GwD9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35084 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757951AbdACJ5g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jan 2017 04:57:36 -0500
Received: by mail-wm0-f42.google.com with SMTP id a197so380801447wmd.0
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jan 2017 01:57:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5AgFM1T5XSZH3U5O6n+=_bi3eq7jS1XX9xTBS9Z+GwD9w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, ulf.hansson@linaro.org, linus.walleij@linaro.org
Cc: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Fabio,

On Mon, Jan 02, 2017 at 07:40:43PM -0200, Fabio Estevam wrote:
> Hi Gary,
> 
> On Mon, Jan 2, 2017 at 5:15 PM, Gary Bisson
> <gary.bisson@boundarydevices.com> wrote:
> 
> > Have you seen such behavior? Is the eMMC on the SABRE platform working
> > fine?
> 
> Yes, just noticed the same on a mx6qsabresd.
> 
> I haven't had a chance to debug this yet.
> 
> If you could run a 'git bisect' that would be great. Thanks

Doing a 'git bisect' shows that the culprit is [1]:
e173f891 mmc: core: Update CMD13 polling policy when switch to HS DDR
mode

Unfortunately I don't know the JEDEC specification enough to know what's
wrong but the patch broke 8-bit eMMC (HS DDR) on i.MX platforms. Which
platform has it beend tested on?

Ulf and Linus have been added to the loop since they know the details.

Also, I confirm that reverting that patch on v4.10-rc1 fixes the issue.

Regards,
Gary

[1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/core/mmc.c?id=e173f891
