From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: eMMC tuning fail issue
Date: Tue, 1 Dec 2015 13:44:34 +0100
Message-ID: <CAPDyKFqWzc_HYU2Hd4=W-sfyj3D6j30s6-iC=PaosMzoagCkag@mail.gmail.com>
References: <BY1PR03MB138867E7C24E60866C690C129A0F0@BY1PR03MB1388.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36853 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbbLAMof (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2015 07:44:35 -0500
Received: by ykdr82 with SMTP id r82so5026204ykd.3
        for <linux-mmc@vger.kernel.org>; Tue, 01 Dec 2015 04:44:34 -0800 (PST)
In-Reply-To: <BY1PR03MB138867E7C24E60866C690C129A0F0@BY1PR03MB1388.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen Bough <Haibo.Chen@freescale.com>
Cc: "nsanders@chromium.org" <nsanders@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 1 December 2015 at 09:41, Chen Bough <Haibo.Chen@freescale.com> wrote:
> Hi,
>
> After
> commit 197160d52e859575ff0ad1afd674ab2a825b9f83
> Author: Nick Sanders <nsanders@chromium.org>
> Date:   Tue May 6 18:52:38 2014 -0700
>
>     mmc: sdhci: remove mdelay in eMMC tuning
>
>
> I find Micron eMMC HS200 and HS400 can't pass tuning on i.MX7D platform, here is the log:
>
> [    2.835581] sdhci: Tuning procedure failed, falling back to fixed sampling clock
> [    2.843071] mmc1: tuning execution failed
> [    2.847104] mmc1: error -5 whilst initialising MMC card
>
> When I revert this commit, issue gone.

Thanks for reporting the problem!

There's been a lot of changes regarding tuning since then, both to
sdhci and the mmc core. So before I consider a revert for that patch,
can you share on what baseline you are on!?

[...]

Kind regards
Uffe
