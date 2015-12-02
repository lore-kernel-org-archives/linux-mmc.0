From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: eMMC tuning fail issue
Date: Wed, 2 Dec 2015 12:07:39 +0100
Message-ID: <CAPDyKFpZn0--5L-CSnML7sUX5+dR_8OMG-eZ2REmpc+iK-v2+A@mail.gmail.com>
References: <BY1PR03MB138867E7C24E60866C690C129A0F0@BY1PR03MB1388.namprd03.prod.outlook.com>
	<CAPDyKFqWzc_HYU2Hd4=W-sfyj3D6j30s6-iC=PaosMzoagCkag@mail.gmail.com>
	<BY1PR03MB1388B8651A016856752C99AA9A0E0@BY1PR03MB1388.namprd03.prod.outlook.com>
	<CANvYXzi2CcOF5GW+a32y2PFDazXK219f_YNCcr0gKsTwBvQ4JQ@mail.gmail.com>
	<BY1PR03MB13889BB7FA0AC169AAE22FA89A0E0@BY1PR03MB1388.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33530 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482AbbLBLHk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2015 06:07:40 -0500
Received: by ykdv3 with SMTP id v3so42070339ykd.0
        for <linux-mmc@vger.kernel.org>; Wed, 02 Dec 2015 03:07:40 -0800 (PST)
In-Reply-To: <BY1PR03MB13889BB7FA0AC169AAE22FA89A0E0@BY1PR03MB1388.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen Bough <Haibo.Chen@freescale.com>, Nick Sanders <nsanders@chromium.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

[...]

>
> Do you receive any similar issue report on other eMMC vendor?
>

No. Although, that may be to that people don't report them.

[...]

>
>
> This code is active on all Chromebooks with eMMC without an issue, and the
> eMMC spec doesn't require a delay here. So I don't think it can be a common
> problem. What eMMC model are you using specifically?
>
>
>
> Also, this change fixes a problem with audio glitching on systems with
> runtime pm or active retuning due to very long read latency caused by 40ms
> of mdelay in the kernel read path. Runtime pm sets the eMMC to sleep if it
> has not been used in a short time, so intermittent reads always go though
> the retuning path.

40 ms is just a terrible latency.

I guess I have asked this question before while the tuning was
implemented for sdhci; is there no way you can restore earlier tuned
values in runtime resume, instead of always doing a new re-tuning?

Another option is to use and increased runtime PM autosuspend timeout
while tuning is enabled. It won't remove the 40 ms latency, but would
make it happen less frequently.

Yet another option would be to temporary forbid runtime suspend, which
is what device PM QOS is for. The generic PM domain provides this
infrastructure via the domain governor.

Finally, of course we shouldn't do the delay - unless in those case
where it's actually needed.
I am wondering if you are using the exact same SDHCI variant/driver?
Perhaps it's not a eMMC issue, but a SDHCI controller/driver issue?

Kind regards
Uffe
