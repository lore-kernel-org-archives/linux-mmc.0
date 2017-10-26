From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 1/3] mmc: core: activate pre-erased multiple write
 support for sd card
Date: Thu, 26 Oct 2017 13:03:16 +0200
Message-ID: <20171026110316.GD12640@hc>
References: <1506483638-115756-1-git-send-email-shawn.lin@rock-chips.com>
 <699af9d0-c69b-e02b-54c1-7b0dd3f5369c@rock-chips.com>
 <CAPDyKFrdXPp4+Gu_2uE_Kdw0vLFC3uQ7ZBc9kYa+HKCgYc06Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2nam02on0053.outbound.protection.outlook.com ([104.47.38.53]:50117
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932194AbdJZLDd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Oct 2017 07:03:33 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFrdXPp4+Gu_2uE_Kdw0vLFC3uQ7ZBc9kYa+HKCgYc06Vg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, Oct 26, 2017 at 12:46:02PM +0200, Ulf Hansson wrote:
> On 26 October 2017 at 03:19, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> > Hi, Ulf
> >
> > On 2017/9/27 11:40, Shawn Lin wrote:
> >>
> >> Per SD specification version 4.10, section 4.3.4, it says "pre-erased
> >> (ACMD23) will make a following Multiple Block Write operation faster
> >> compared to the same operation without preceding ACMD23". ACMD23 is
> >> mandatory for all sd cards and the spec also says "Command STOP_TRAN
> >> (CMD12) shall be used to stop the transmission in Write Multiple Block
> >> whether or not the preerase (ACMD23) feature is used."
> >
> >
> > Ping... :)
> 
> Hi Shawn,
> 
> Actually I was waiting for confirmation from Jan about his tests.

The patches worked for me but I'm not sure I've actually tested ACMD23.
Do I need to trigger ACMD23 somehow?

--Jan

> However, overall the series looks reasonable to me.
> 
> Kind regards
> Uffe
