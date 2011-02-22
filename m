From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 5/5] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Tue, 22 Feb 2011 07:35:11 -0800
Message-ID: <AANLkTimbx6=YvRHFuVkmPVYvYtwME31PxXWNHNfFsVRQ@mail.gmail.com>
References: <1298369606-29972-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1298369606-29972-5-git-send-email-Hong-Xing.Zhu@freescale.com>
	<20110222113222.GE2755@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58831 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919Ab1BVPgM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 10:36:12 -0500
Received: by fxm17 with SMTP id 17so2866632fxm.19
        for <linux-mmc@vger.kernel.org>; Tue, 22 Feb 2011 07:36:11 -0800 (PST)
In-Reply-To: <20110222113222.GE2755@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Richard Zhu <Hong-Xing.Zhu@freescale.com>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, linuxzsc@gmail.com, richard.zhao@freescale.com

Hi,

On Tue, Feb 22, 2011 at 3:32 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Tue, Feb 22, 2011 at 06:13:26PM +0800, Richard Zhu wrote:
>> Fix the NO INT in the Multi-BLK IO in SD/MMC, and
>> Multi-BLK read in SDIO
>>
>> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
>
> Thanks for respinning \o/ This approach looks better to me, but CCing
> Olof to comment on abstraction issues if he has them. Will do a deeper
> review later this week.


I like it! Definitely the right approach. Pushing quirks down into the
I/O accessors is definitely the only scalable way to handle all the
various buggy controllers out there.

Acked-by: Olof Johansson <olof@lixom.net>
