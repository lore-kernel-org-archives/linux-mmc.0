From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: 1217:8520 [Dell Latitude E7450] O2 Micro, SD/MMC Card Reader
 doesn't work
Date: Fri, 18 Dec 2015 09:51:57 +0100
Message-ID: <CAPDyKFotgz3czCs8XaXwC4kT53Lp0h=n03OUMtO6BUTwTnDYzQ@mail.gmail.com>
References: <CAONpWdsteBnqTcFbKpcOQFueyeJJWEmn9DJitD43f59xV8sDyg@mail.gmail.com>
	<BY2PR04MB184372CAAC1FA0C5373D73238FEF0@BY2PR04MB1843.namprd04.prod.outlook.com>
	<CAONpWduF6iH4Rr5Y610KP1RE342nWAajR27KFbu1N2iet4R0ZA@mail.gmail.com>
	<BY2PR04MB18438CFFD181C72EFEF408908FE10@BY2PR04MB1843.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33475 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934010AbbLRIv6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Dec 2015 03:51:58 -0500
Received: by mail-yk0-f178.google.com with SMTP id 140so50379272ykp.0
        for <linux-mmc@vger.kernel.org>; Fri, 18 Dec 2015 00:51:57 -0800 (PST)
In-Reply-To: <BY2PR04MB18438CFFD181C72EFEF408908FE10@BY2PR04MB1843.namprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Guo <peter.guo@bayhubtech.com>
Cc: Alex Ballas <alex@ballas.org>, "adam8157@gmail.com" <adam8157@gmail.com>, "linux-mmc@VGER.KERNEL.ORG" <linux-mmc@vger.kernel.org>

On 18 December 2015 at 04:14, Peter Guo <peter.guo@bayhubtech.com> wrote:
> Hi Alex & Adam,
>
> I have send the patch. Please check it.
> Attachment is the patch file.

Thanks Peter for helping out!

Although I would appreciate if you don't send patches as attachments.

Moreover, even if the patch can be used to check whether it solves the
problem - I won't accept it as is.
The reason is simply that I don't allow any more quirks/callbacks to
be added for SDHCI.

Kind regards
Uffe
