From: Saeed Bishara <saeed@marvell.com>
Subject: RE: [patch 2/2] mmc: add support of sdhci-pxa driver
Date: Sun, 3 Oct 2010 10:15:15 +0200
Message-ID: <FCBE654890C0334289D0AD3AF4EF009FD18EF7E13B@IL-MB01.marvell.com>
References: <AANLkTi=XBbW=R4HQYp5fLVE5eUXHNtzGh1Qf+XyBUSCH@mail.gmail.com>
 <AANLkTim4aJok6=HcopkObi3WrUatiZgK-KZTfhoHwgF7@mail.gmail.com>
 <AANLkTimk2_KcmSAV-UZ3JY1JFD657SnfyPFgP_zE5bbP@mail.gmail.com>
 <20100926155905.GB19772@void.printf.net>
 <AANLkTimwsk5SXQRt45vUhzhHabrG4wvw5JcBZAZ1Aq4j@mail.gmail.com>
 <20100926174837.GA21788@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from galiil.marvell.com ([199.203.130.254]:28959 "EHLO
	galiil.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab0JCIPM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Oct 2010 04:15:12 -0400
In-Reply-To: <20100926174837.GA21788@void.printf.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, zhangfei gao <zhangfei.gao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>

>
>On Mon, Sep 27, 2010 at 12:09:17AM +0800, Haojian Zhuang wrote:
>> If the name is sdhci-mmp2, it's a big confusion that people 
>will think
>> mmp(ttc/aspen) is using another IP.
>> 
>> sdhci-pxa is the best name.
>
>Okay.  What should Saeed's driver be called?
Chris,
	I've re-looked at the sdhci-pltfm.c driver, and I think it can serve the Dove device even without modifications. So please don't merge the shdci-mv driver.

saeed