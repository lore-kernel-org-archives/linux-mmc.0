From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc-exynos: Common bindings for dw-mshc timing
Date: Mon, 12 Aug 2013 19:36:13 +0900
Message-ID: <000301ce9747$c47e3240$4d7a96c0$%jun@samsung.com>
References: <1376002520-7461-1-git-send-email-dinguyen@altera.com>
 <520459C9.8020305@samsung.com>
 <001301ce94fd$09c78330$1d568990$%jun@samsung.com>
 <1376060060.11201.5.camel@linux-builds1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51458 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab3HLKgP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Aug 2013 06:36:15 -0400
In-reply-to: <1376060060.11201.5.camel@linux-builds1>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Dinh Nguyen' <dinguyen@altera.com>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, dinh.linux@gmail.com, 'Arnd Bergmann' <arnd@arndb.de>, 'Olof Johansson' <olof@lixom.net>, 'Rob Herring' <rob.herring@calxeda.com>, 'Pawel Moll' <pawel.moll@arm.com>, 'Mark Rutland' <mark.rutland@arm.com>, 'Stephen Warren' <swarren@wwwdotorg.org>, 'Ian Campbell' <ian.campbell@citrix.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, August 09, 2013, Dinh Nguyen wrote:
> Hi Seungwon Jeon,
> 
> On Fri, 2013-08-09 at 21:36 +0900, Seungwon Jeon wrote:
> > On Fri, August 09, 2013, Jaehoon Chung wrote:
> > > Hi Dinh
> > >
> > > On 08/09/2013 07:55 AM, dinguyen@altera.com wrote:
> > > > From: Dinh Nguyen <dinguyen@altera.com>
> > > >
> > > > Remove the "samsung" in "samsung,dw-mshc-ciu-div", "samsung,dw-mshc-sdr-timing",
> > > > and "samsung,dw-mshc-ddr-timing". These characteristics are not applicable to
> > > > just Samsung platforms, but to any platform that uses the Synopsis SD/MMC IP.
> > > >
> > Though host controller based on Synopsys is required to implement clock phase shift,
> > actual implementation could be different. I'm not sure that this above parameters are common just
> now.
> > But if some more host controllers are introduced, we may define clearly.
> 
> But the bindings can be common between socfpga and exynos right? The
> values in the bindings represent the same thing, just the implementation
> for the clock phase shift can be different.

Hmm. I also feel like similar though I didn't see the socfpga.
As I take a glance, div of socfpga currently seems fixed in host side.
Do you need it from dts?

How about rockchip's mshc platform?
I guess we could wait and see more.

Thanks,
Seungwon Jeon

