From: Andreas Fenkart <afenkart@gmail.com>
Subject: Re: [PATCH v4 0/3] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Mon, 2 Dec 2013 17:58:23 +0100
Message-ID: <CALtMJEC8t95POfDkafJmZXvDvAftpGfw5_fXuzet2pOrLbae2A@mail.gmail.com>
References: <1386003160-23733-1-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1386003160-23733-1-git-send-email-afenkart@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Daniel Mack <zonque@gmail.com>, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Ignore this set, I busted it.

2013/12/2 Andreas Fenkart <afenkart@gmail.com>:
> v4:
> - switch to interrupts-extended format
> - drop ti,swakeup-missing flag convert to comaptible section
>
> v3:
> - removed gpio_irq from platform_data
>
> v2:
> - incorparated changes as suggested by reviewers
> - simplified workaround for am335x, gpio will now only wake
>   the module from runtime suspend, not handle the sdio irq
>   itself
>
>
> Andreas Fenkart (3):
>   mmc: omap_hsmmc: Enable SDIO IRQ.
>   mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on
>     AM335x.
>   mmc: omap_hsmmc: Extend debugfs for SDIO IRQ, GPIO and pinmux.
>
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   50 ++++
>  drivers/mmc/host/omap_hsmmc.c                      |  298 ++++++++++++++++++--
>  include/linux/platform_data/mmc-omap.h             |    1 +
>  3 files changed, 326 insertions(+), 23 deletions(-)
>
> --
> 1.7.10.4
>
