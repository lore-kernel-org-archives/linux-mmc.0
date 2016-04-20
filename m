From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/1] mmc: omap_hsmmc: devm_pinctrl_get returns ERR_PTR
 upon error
Date: Wed, 20 Apr 2016 08:13:37 -0700
Message-ID: <20160420151337.GK5973@atomide.com>
References: <1461099853-15011-1-git-send-email-afenkart@gmail.com>
 <1461099853-15011-2-git-send-email-afenkart@gmail.com>
 <5784587.0IP58U3KN7@wuerfel>
 <20160420081145.GR4247@mwanda>
 <CALtMJEA0XaekLgZnOVU4XMPmc61VendSCCV2uKjesxzQRcwR8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:51561 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbcDTPNl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Apr 2016 11:13:41 -0400
Content-Disposition: inline
In-Reply-To: <CALtMJEA0XaekLgZnOVU4XMPmc61VendSCCV2uKjesxzQRcwR8w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap@vger.kernel.org

* Andreas Fenkart <afenkart@gmail.com> [160420 04:39]:
> 2016-04-20 10:11 GMT+02:00 Dan Carpenter <dan.carpenter@oracle.com>:
> > On Tue, Apr 19, 2016 at 03:12:27PM -0700, Arnd Bergmann wrote:
> >> On Tuesday 19 April 2016 23:04:13 Andreas Fenkart wrote:
> >> > Only the dummy implementation of devm_pinctrl_get returns NULL.
> >> > The real implementation returns ERR_PTR. By enforcing pinselect
> >> > in Kconfig we can simplify the test to check only for ERR_PTR.
> >> > detected/triggered by static code checker.
> >>
> >> This is not how the interface is meant to work:
> >>
> >> The dummy devm_pinctrl_get() intentionally returns NULL because IS_ERR()
> >> treats that as valid. All other pinctrl functions subsequently ignore
> >> that NULL pointer, so the second half of the patch is ok without the
> >> first half.
> >>
> >
> > We had that discussion.  The static checker warning triggered the
> > discussion but the real reason for this patch is that the
> > hardware will not work without PINCTRL.  So instead of compiling an
> > unusable kernel we added the select.
> 
> beaglebone needs the workaround, most chips don't. The code discussed,
> only gives some feedback to users about an incorrect configuration.
> I can drop that part or replace it with a dev_info line, pointing to
> "Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt"

Yes pinctrl is optional for sure. And leaving pinctrl out does not
produce an unusable kernel for some boards that do all the pin muxing
in the bootloader. Like Andreas says, only some boards need dynamic
pin muxing for the wake-up events.

The dev_info change sounds like papering over the issue.. I'm fine
with that, but isn't the real problem devm_pinctrl_get prototype?

> > I forget, but I think one of ARCH_OMAP2PLUS or ARCH_KEYSTONE selects
> > PINCTRL already and the other doesn't.  That was part of the discussion
> > as well.
> 
> ARCH_KEYSTONE doesn't have pinctrl, ARCH_OMAP2PLUS does

Yes.

Regards,

Tony
