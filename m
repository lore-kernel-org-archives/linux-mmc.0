From: Ziji Hu <huziji@marvell.com>
Subject: Re: [PATCH 5/10] dt: bindings: Add bindings for Marvell Xenon SD Host
 Controller
Date: Thu, 24 Nov 2016 18:38:19 +0800
Message-ID: <f7d2ff41-5f64-e8c1-b028-dfc7aea294ae@marvell.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <4031579.CBE32NHUoW@wuerfel> <877f7tmduw.fsf@free-electrons.com>
 <28082657.RK5ubAe11Q@wuerfel> <8737ihmctr.fsf@free-electrons.com>
 <CAPv3WKddPHgpRU2_tVoDF=5Z-nqfFPxjgJ-+z9o-1tR2=fFvAA@mail.gmail.com>
 <20161124111029.035553ce@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:47804 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933774AbcKXKjV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2016 05:39:21 -0500
In-Reply-To: <20161124111029.035553ce@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Romain Perier <romain.perier@free-electrons.com>, Liuliu Zhao <zhaoliul@marvell.com>, Peng Zhu <zhupeng@marvell.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Xueping Liu <xpliu@marvell.com>, Hilbert Zhang <zzhang@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Yu Cao <yucao@marvell.com>, Sebastian

Hi all,

On 2016/11/24 18:10, Thomas Petazzoni wrote:
> Hello,
> 
> On Thu, 24 Nov 2016 10:49:23 +0100, Marcin Wojtas wrote:
> 
>> How about to avoid confusion, by simply renaming this number to
>> port-id/xenon-id or anything else but slot? I guess this may allow to
>> avoid some misunderstandings.
> 
	We borrow the term "slot" from PCIe interface from SD spec.
	According to Appendix C in SD spec 3.0, slot means an independent set of register from the view of SW.

	I can avoid using "slot" and replace "slot index" with "sdhc-id".
	Thanks for the suggestions.

	Thank you.

Best regards,
Hu Ziji

> Agreed.
> 
> Thomas
> 
