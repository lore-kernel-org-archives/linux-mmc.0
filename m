From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH 1/4] mmc: sdhci: add a driver for Berlin SoCs
Date: Fri, 18 Apr 2014 09:20:56 +0200
Message-ID: <20140418072056.GB26909@kwain>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397652011-21284-2-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59708 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750959AbaDRHU7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Apr 2014 03:20:59 -0400
Content-Disposition: inline
In-Reply-To: <1397652011-21284-2-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, chris@printf.net, anton@enomsg.org
Cc: alexandre.belloni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all,

On Wed, Apr 16, 2014 at 02:40:08PM +0200, Antoine T=E9nart wrote:
> Add a Driver to support the SDHCI controller of the Marvell Berlin So=
Cs.
> This controller supports 3 sockets.

After talking a bit with Sebastian and Jisheng I decided to have a look=
 on the
pxav3 driver. I gave it a try, it seemed to be compatible with the Berl=
in SDHCI
controller so I'll use this one instead of adding a Berlin specific one=
=2E

You all can forget this one, I'll send a v2 using the pxav3 driver.

Thanks!

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
