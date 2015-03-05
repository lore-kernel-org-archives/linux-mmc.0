From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] tmio: mmc: replace sh_mobile_sdhi_info to tmio_mmc_data
Date: Thu, 5 Mar 2015 09:33:10 +0100
Message-ID: <CAPDyKFqJ7bbfaQgYnhHerFbre9mPzj7i6QGPQZo54ukuHaD32g@mail.gmail.com>
References: <878ufo12qq.wl%kuninori.morimoto.gx@renesas.com>
	<20150224162312.GG5208@intel.com>
	<87wq2vc40g.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:32781 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbbCEIdL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 03:33:11 -0500
Received: by mail-qa0-f52.google.com with SMTP id v10so37757840qac.11
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2015 00:33:10 -0800 (PST)
In-Reply-To: <87wq2vc40g.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Simon <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 5 March 2015 at 08:11, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Ulf
>
>> > Hi Ulf, Vinod, Simon
>> >
>> > DMAEngine cleanup patches are accepted in v4.0-rc1
>> >
>> > As I mentioned in
>> > http://thread.gmane.org/gmane.linux.ports.sh.devel/42669
>> > these are last of sh_mobile_sdhi DMA patches.
>> >
>> > These patches uses tmio_mmc_data on platform,
>> > and remove sh_mobile_sdhi
>> >
>> > These are based on
>> >  - linus's v4.0-rc1
>> >  - Vinod's dma/next (git://git.infradead.org/users/vkoul/slave-dma.git :: next)
>> >
>> > Vinod
>> >
>> > please let us know if it has stable tag or branch
>> Please use topic/sh. I will not rebase that, my next would be rebased
>> frequently...
>
> Please let me know if you want me to re-send these patches

I have no issues with the patches as such. Though, I wonder about the
dependency here.

Does these patches depend on an immutable branch hosted from Vinod's tree?

Do you want me to take the patches through my mmc tree or just request
an ack so Vinod can carry this?

Kind regards
Uffe
