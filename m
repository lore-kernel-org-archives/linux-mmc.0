From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 1/2] SOCFPGA updates for 3.18
Date: Tue, 09 Sep 2014 17:02:34 +0200
Message-ID: <4134101.OOENTRabu1@wuerfel>
References: <1409847105-27241-1-git-send-email-dinguyen@opensource.altera.com> <20140909141756.GA30100@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:52224 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbaIIPCs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Sep 2014 11:02:48 -0400
In-Reply-To: <20140909141756.GA30100@amd>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavel Machek <pavel@denx.de>
Cc: dinguyen@opensource.altera.com, khilman@linaro.org, olof@lixom.net, arm@kernel.org, dinh.linux@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

On Tuesday 09 September 2014 16:17:56 Pavel Machek wrote:
> > Jaehoon Chung (1):
> >       ARM: dts: socfpga: unuse the slot-node and deprecate the supports-highspeed for dw-mmc
> > 
> 
> This patch is a bad idea. It removes support for two mmc cards on a
> single controller -- configuration hardware supports and configuration
> that allows using u-SD card on mcvevk board.
> 

Your objection comes too late, and to the wrong patch, since the
driver and all other users have already been changed. We had a long
discussion about this when the issue first came up, and we could
not find any example of dw-mmc actually being used in a scenario
with one controller that has multiple devices attached.

Apparently every user out there instead uses multiple controller
instances instead. Are you sure that the socfpga implementation
is an exception from this?

	Arnd
