From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v6 0/3]mmc: implement eMMC4.4 standard HW reset feature
Date: Tue, 11 Jan 2011 14:24:30 +0800
Message-ID: <5D8008F58939784290FAB48F549751983519F49499@shsmsx502.ccr.corp.intel.com>
References: <20101227101305.GA20143@intel.com>
 <20110110232020.GA7920@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58786 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072Ab1AKGZk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jan 2011 01:25:40 -0500
In-Reply-To: <20110110232020.GA7920@void.printf.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

Hi Chris, Thanks for your review! Below is my answer about your concerns.

> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Tuesday, January 11, 2011 7:20 AM
> To: Dong, Chuanxiao
> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> akpm@linux-foundation.org
> Subject: Re: [PATCH v6 0/3]mmc: implement eMMC4.4 standard HW reset feature
> 
> Hi Chuanxiao,
> 
> On Mon, Dec 27, 2010 at 06:13:05PM +0800, Chuanxiao Dong wrote:
> > Hi all,
> >    This is the version 6 of hardware reset feature implementation. When eMMC
> >    card cannot response any command, signal RST_n can help to reset eMMC
> >    card.
> >
> >    patch1: enable HW reset capability if card supports.
> >    patch2: do hardware reset if card occurs read/write/erase timeout
> >    patch3: implement hwreset_emmc and reinit_emmc callbacks. In this patch,
> >    hwreset_emmc callback will pull up/down the corresponded GPIO line
> number
> >    to trigger RST_n signal.
> 
> Sorry for the very late reply.  I'm simply not sure what to do about
> this patchset -- I'm extremely reluctant to touch the once-only
> programmable bits on the eMMC, and especially to do so silently by
> default.
Some eMMC4.4 or later new features need to touch the once-only programmable bits...If we support such features, we cannot avoid doing this. So do you think it is better for driver only read such once-only programmable bits? Writing such bits can leave to the manufactory line?
Or using a Kconfig option to notice user is better?

> 
> Also, where exactly do you assign host->rst_gpio?  It isn't assigned
> to in this patch, so where will it be set?  It looks like you could
Yes. host->rst_gpio was planned to put in host controller driver. But there is a dependence for getting the reset gpio number since different platform may use different gpios. I will send it out with my host controller support in the next submission for your review.

> end up strobing GPIO0 if a gpio isn't passed in at all.
Yes. If the rst_gpio was initialized by -ENODEV during host probing by default, this problem will be gone.

> 
> I haven't seen any other reports of -ETIMEDOUT from eMMC controllers
> not responding to CMD0; I wonder if only your controller has this
> problem, and if that should change how we handle it.
My host controller can also responding to CMD0. I am not sure if there will happen such scenario: eMMC card is in some error state and cannot respond any command in case during read/write/erase, host controller can still have another way to reset card and make it back to a normal working state. If such scenario occurs, HW reset feature can be used.

> 
> Does anyone else on the list have feedback on how best to proceed?
> 
> Thanks,
> 
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
