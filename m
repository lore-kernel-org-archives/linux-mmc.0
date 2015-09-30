From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: fix dead loop of mmc_retune
Date: Wed, 30 Sep 2015 14:47:39 +0200
Message-ID: <CAPDyKFrVWGP2nXZR63v0r7eRKmHuKdX1=FMjGRhOaNtDaKTg8Q@mail.gmail.com>
References: <1443605838-5948-1-git-send-email-chaotian.jing@mediatek.com>
	<560BCF1B.7050302@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35652 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326AbbI3Mrk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Sep 2015 08:47:40 -0400
Received: by wicge5 with SMTP id ge5so195189725wic.0
        for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2015 05:47:39 -0700 (PDT)
In-Reply-To: <560BCF1B.7050302@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Johan Rudholm <johan.rudholm@axis.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Shawn Lin <shawn.lin@rock-chips.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>, David Jander <david@protonic.nl>, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>

On 30 September 2015 at 14:01, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 30/09/15 12:37, Chaotian Jing wrote:
>> When get a CRC error, start the mmc_retune, it will issue CMD19/CMD21
>> to do tune, assume there were 10 clock phase need to try, phase 0 to
>> phase 6 is ok, phase 7 to phase 9 is NG, we try it from 0 to 9, so
>> the last CMD19/CMD21 will get CRC error, host->need_retune was set and
>> cause mmc_retune was called, then dead loop of mmc_retune
>>
>> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
>
> Wasn't my idea to have this CRC checking in the core ;-) and sdhci
> doesn't put it's tuning commands through a mmc request so it doesn't
> see this issue.

That's not true for all sdhci variants. For those that uses sdhci's
->platform_execute_tuning() callback, all uses mmc_send_tuning().

I think for sdhci's default tuning path, we should change to use
mmc_send_tuning() and thus we would potentially hit this problem as
well.

>
> But definitely the CRC logic is not meant for the tuning commands, so
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks for reviewing Adrian and for keeping an eye on "tuning" related patches.

Kind regards
Uffe
