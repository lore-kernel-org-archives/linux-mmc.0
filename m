From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: atmel-mci: fix mismatched section on atmci_cleanup_slot
Date: Sat, 27 Sep 2014 13:59:55 +0200
Message-ID: <2004885.JTcy2BUf8D@wuerfel>
References: <1411467606-13041-1-git-send-email-pramod.gurav@smartplayin.com> <201409262134.58457.arnd@arndb.de> <CAMf-jSkc7pCeqd6MfZJXKGWB6M=qA+c+yUCPaQ=UQ7r9E7R_xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:53284 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbaI0MAQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 27 Sep 2014 08:00:16 -0400
In-Reply-To: <CAMf-jSkc7pCeqd6MfZJXKGWB6M=qA+c+yUCPaQ=UQ7r9E7R_xw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pramod Gurav <pramod.gurav.etc@gmail.com>
Cc: Pramod Gurav <pramod.gurav@smartplayin.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On Saturday 27 September 2014 08:45:33 Pramod Gurav wrote:
> Hi Arnd,
> 
> On Sat, Sep 27, 2014 at 1:04 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > As of 528bc7808f4e ("mmc: atmel-mci: Release mmc resources on failure in probe"),
> > the atmci_probe() function calls atmci_cleanup_slot in the failure path.
> >
> > This causes a new warning whenever the driver is built:
> >
> > WARNING: drivers/mmc/host/built-in.o(.init.text+0xa04): Section mismatch in reference from the function atmci_probe() to the function .exit.text:atmci_cleanup_slot()
> > The function __init atmci_probe() references
> > a function __exit atmci_cleanup_slot().
> Thanks for this though I am not owner of the driver but the last
> commit was mine.
> but how come I did not see this warning? Any flag with compiler that
> warned about this?

The warning above is only enabled if CONFIG_DEBUG_SECTION_MISMATCH is set, otherwise
you get this one:

WARNING: modpost: Found 1 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'

	Arnd
