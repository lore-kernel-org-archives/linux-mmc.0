From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/1] mmc: omap_hsmmc: devm_pinctrl_get returns ERR_PTR upon error
Date: Thu, 21 Apr 2016 00:28:05 +0200
Message-ID: <4155990.SfY6i69ddf@wuerfel>
References: <1461099853-15011-1-git-send-email-afenkart@gmail.com> <CALtMJEA0XaekLgZnOVU4XMPmc61VendSCCV2uKjesxzQRcwR8w@mail.gmail.com> <20160420151337.GK5973@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:61870 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbcDTW2R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2016 18:28:17 -0400
In-Reply-To: <20160420151337.GK5973@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap@vger.kernel.org

On Wednesday 20 April 2016 08:13:37 Tony Lindgren wrote:
> * Andreas Fenkart <afenkart@gmail.com> [160420 04:39]:
> > 2016-04-20 10:11 GMT+02:00 Dan Carpenter <dan.carpenter@oracle.com>:
> > > On Tue, Apr 19, 2016 at 03:12:27PM -0700, Arnd Bergmann wrote:
> > >> On Tuesday 19 April 2016 23:04:13 Andreas Fenkart wrote:
> > >> > Only the dummy implementation of devm_pinctrl_get returns NULL.
> > >> > The real implementation returns ERR_PTR. By enforcing pinselect
> > >> > in Kconfig we can simplify the test to check only for ERR_PTR.
> > >> > detected/triggered by static code checker.
> > >>
> > >> This is not how the interface is meant to work:
> > >>
> > >> The dummy devm_pinctrl_get() intentionally returns NULL because IS_ERR()
> > >> treats that as valid. All other pinctrl functions subsequently ignore
> > >> that NULL pointer, so the second half of the patch is ok without the
> > >> first half.
> > >>
> > >
> > > We had that discussion.  The static checker warning triggered the
> > > discussion but the real reason for this patch is that the
> > > hardware will not work without PINCTRL.  So instead of compiling an
> > > unusable kernel we added the select.

Ok, but if that is the case, that the changelog text above should be
rewritten to explain it (but as Tony explains it was probably a
misinterpretation).

> > beaglebone needs the workaround, most chips don't. The code discussed,
> > only gives some feedback to users about an incorrect configuration.
> > I can drop that part or replace it with a dev_info line, pointing to
> > "Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt"
> 
> Yes pinctrl is optional for sure. And leaving pinctrl out does not
> produce an unusable kernel for some boards that do all the pin muxing
> in the bootloader. Like Andreas says, only some boards need dynamic
> pin muxing for the wake-up events.
> 
> The dev_info change sounds like papering over the issue.. I'm fine
> with that, but isn't the real problem devm_pinctrl_get prototype?
> 
> 

I don't see anything wrong with the devm_pinctrl_get prototype other
than how it frequently confuses driver writers.

	Arnd
