From: Andreas Fenkart <afenkart@gmail.com>
Subject: Re: [PATCH 0/6] mmc: omap_hsmmc: simplify cover/card detect logic
Date: Wed, 4 Mar 2015 09:06:55 +0100
Message-ID: <CALtMJEBpCLLOcT20P=7G-PmetfYKoyqo9+NSX77W0VF=UVO5_A@mail.gmail.com>
References: <1425385698-6588-1-git-send-email-afenkart@gmail.com>
	<20150304163108.7b0902c8@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20150304163108.7b0902c8@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

2015-03-04 6:31 GMT+01:00 NeilBrown <neilb@suse.de>:
> On Tue,  3 Mar 2015 13:28:12 +0100 Andreas Fenkart <afenkart@gmail.com> wrote:
>> While cover detect is only used by one platform (rx51), it
>> complicates the card detect logic. By separating the code
>> paths they both become easier to understand and maintain
>>
>> Patches have been tested by reverting: 95bebb5696ab
>> 'mmc: omap_hsmmc: use mmc_of_parse to parse common mmc configuration'
>> otherwise gpio detection is handled by mmc_of_parse
>
> Wouldn't it make more sense to put this core  in mmc/core rather than in just
> one host controller?
Yes, I would very welcome that, since it would free the omap_hsmmc of the
'protection' mechanism that makes the driver clumsy. But as an initial step
separating cover from card detect already seems enough for this series.
Another thought was, that since only one platform is using it, the prospect of
getting it merged into the core was minimal.

> That way it would be available to all hosts, and you
> wouldn't need to revert that patch.
Oh sorry, seems I was unclear. I definitely do not want to revert that patch
permanently, the opposite is true, I very much welcome it. Thanks for your work
by the way.
I only reverted it temporarily so I could test that the card detect
logic still works
with legacy board files, non-device-tree platforms. But since mmc_of_parse is
setting the card detect pin, my changes could not be tested with my
device-tree platform (bbone). So I reverted the above patch only for testing,
afterwards I rebased the patches on top of it, before submitting


Andreas
