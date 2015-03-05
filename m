From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] tmio: mmc: replace sh_mobile_sdhi_info to tmio_mmc_data
Date: Thu, 5 Mar 2015 11:03:52 +0100
Message-ID: <CAPDyKFrww8=HKYwyD4EQSS-=J=c=5HRA=g9YCiSC=L0+_uCMOQ@mail.gmail.com>
References: <878ufo12qq.wl%kuninori.morimoto.gx@renesas.com>
	<20150224162312.GG5208@intel.com>
	<87wq2vc40g.wl%kuninori.morimoto.gx@renesas.com>
	<CAPDyKFqJ7bbfaQgYnhHerFbre9mPzj7i6QGPQZo54ukuHaD32g@mail.gmail.com>
	<20150305083630.GZ2613@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:61256 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129AbbCEKDw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 05:03:52 -0500
Received: by mail-qa0-f44.google.com with SMTP id n8so38111942qaq.3
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2015 02:03:52 -0800 (PST)
In-Reply-To: <20150305083630.GZ2613@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 5 March 2015 at 09:36, Vinod Koul <vinod.koul@intel.com> wrote:
> On Thu, Mar 05, 2015 at 09:33:10AM +0100, Ulf Hansson wrote:
>> On 5 March 2015 at 08:11, Kuninori Morimoto
>> <kuninori.morimoto.gx@renesas.com> wrote:
>> >
>> > Hi Ulf
>> >
>> >> > Hi Ulf, Vinod, Simon
>> >> >
>> >> > DMAEngine cleanup patches are accepted in v4.0-rc1
>> >> >
>> >> > As I mentioned in
>> >> > http://thread.gmane.org/gmane.linux.ports.sh.devel/42669
>> >> > these are last of sh_mobile_sdhi DMA patches.
>> >> >
>> >> > These patches uses tmio_mmc_data on platform,
>> >> > and remove sh_mobile_sdhi
>> >> >
>> >> > These are based on
>> >> >  - linus's v4.0-rc1
>> >> >  - Vinod's dma/next (git://git.infradead.org/users/vkoul/slave-dma.git :: next)
>> >> >
>> >> > Vinod
>> >> >
>> >> > please let us know if it has stable tag or branch
> No my next is not stable, I will rebase that.
> I think you want to pick topic/sh, that is an immutable branch
> Can you check that has all the patches you need for this?
>
>> >> Please use topic/sh. I will not rebase that, my next would be rebased
>> >> frequently...
>> >
>> > Please let me know if you want me to re-send these patches
>>
>> I have no issues with the patches as such. Though, I wonder about the
>> dependency here.
>>
>> Does these patches depend on an immutable branch hosted from Vinod's tree?
>>
>>
>> Do you want me to take the patches through my mmc tree or just request
>> an ack so Vinod can carry this?
> Either ways is okay with me..

I just provided my ack for both patches, so please go ahead and take
them through your tree.

Kind regards
Uffe
