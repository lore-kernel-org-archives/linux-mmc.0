From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: sdhci: sdio wakeup and free_irq
Date: Mon, 24 Sep 2012 12:21:36 +0800
Message-ID: <CADz5_gJm8P=azzTsLUOJUeWo_d=vry2WFKWH93yYExVUpXYFPQ@mail.gmail.com>
References: <CADz5_gLLTY6ibBSZCHfYFfJ9Uz15zVu41hm19pQ_FCgBqhsmEw@mail.gmail.com>
	<m3d31cdrvk.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:62637 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab2IXEVi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Sep 2012 00:21:38 -0400
Received: by wibhr14 with SMTP id hr14so4314131wib.1
        for <linux-mmc@vger.kernel.org>; Sun, 23 Sep 2012 21:21:37 -0700 (PDT)
In-Reply-To: <m3d31cdrvk.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi, Chris

2012/9/24 Chris Ball <cjb@laptop.org>:
> Hi,
>
> On Fri, Sep 21 2012, Kevin Liu wrote:
>> Can latest code support sdio wakeup?
>
> Yes, it should work.  OLPC has been using it in production with
> libertas_sdio for several years.
>
>> I see at last of sdhci_suspend_host, irq will be freed. But if the irq
>> is used for wakeup system like sdio wakeup irq? Then system can't be
>> woken up.
>
> free_irq() is just removing the handler while the stack is suspended, it
> isn't stopping your hardware from waking up the system.  Your hardware
> needs to be programmed to wake the system if the SDIO IRQ fires; many
> SoCs will do this as long as the SDIO is in 1-bit data width mode (which
> doesn't require the card clock to be powered).  We turn on 1-bit mode if
> MMC_PM_KEEP_POWER is set in host->pm_flags.
>

free_irq will also disable the interrupt line. Below is the comments and code:

The handler is removed and if the interrupt line is no longer in use
by any driver it is disabled.
        /* If this was the last handler, shut down the IRQ line: */
        if (!desc->action)
                irq_shutdown(desc);

So if the irq is disabled, then system can't be woken up.

Thanks
Kevin
