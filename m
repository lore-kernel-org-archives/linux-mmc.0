From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/10] dt: bindings: Add bindings for Marvell Xenon SD Host Controller
Date: Thu, 24 Nov 2016 10:34:27 +0100
Message-ID: <28082657.RK5ubAe11Q@wuerfel>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com> <4031579.CBE32NHUoW@wuerfel> <877f7tmduw.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:53209 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934194AbcKXJfX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2016 04:35:23 -0500
In-Reply-To: <877f7tmduw.fsf@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Romain Perier <romain.perier@free-electrons.com>, Liuliu Zhao <zhaoliul@marvell.com>, Peng Zhu <zhupeng@marvell.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Xueping Liu <xpliu@marvell.com>, Hilbert Zhang <zzhang@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Yu Cao <yucao@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>d

On Thursday, November 24, 2016 10:22:31 AM CET Gregory CLEMENT wrote:
> 
> I don't have an option for mmc in general, but using child node do not
> fit at all the xenon controller.
> 
> For this controller each slot has its own set of register, so there is
> no common ressource to share so no advantage to use it. Using child node
> in our case will just make the code more complex for no benefit.

If every slot has its own registers, what is it that makes up the
'controller'? It sounds to me that you just have to adjust the terminology
and talk about multiple controllers then, with one slot per controller.

	Arnd

