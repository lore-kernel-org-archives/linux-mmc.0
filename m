From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update dw-mmc controller
Date: Mon, 17 Aug 2015 12:32:41 +0200
Message-ID: <CAPDyKFowfusQa+geBxjZZ1KCffVu5BnGM4jD52k3Ztf3wSt7og@mail.gmail.com>
References: <55C8D73D.10709@gmail.com>
	<CAPDyKFqN9FxQNbwoiCj1A+BUUWHm_H8RXNhKVzUkV0xOUUdCFA@mail.gmail.com>
	<1439806320.3667.39.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:34300 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbbHQKcm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Aug 2015 06:32:42 -0400
Received: by iodb91 with SMTP id b91so145468659iod.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Aug 2015 03:32:41 -0700 (PDT)
In-Reply-To: <1439806320.3667.39.camel@synopsys.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "jh80.chung@gmail.com" <jh80.chung@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "heiko@sntech.de" <heiko@sntech.de>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, "addy.ke@rock-chips.com" <addy.ke@rock-chips.com>

On 17 August 2015 at 12:12, Alexey Brodkin <Alexey.Brodkin@synopsys.com> wrote:
> Hi Ulf,
>
> On Mon, 2015-08-17 at 11:47 +0200, Ulf Hansson wrote:
>> On 10 August 2015 at 18:54, Jaehoon Chung <jh80.chung@gmail.com> wrote:
>> > Dear, Ulf.
>> >
>> > Could you pull these patches into your repository?
>> >
>> > Best Regards,
>> > Jaehoon Chung
>>
>> Thanks! Pulled into my next branch.
>>
>> Kind regards
>> Uffe
>
> I'm wondering if mentioned fixes only hit 4.3 (you mentioned your
> "next" branch) or there's a chance for them to be pulled in the next 4.2-rcX?
>
> The thing is we need at least "mmc: dw_mmc: handle data blocks > than 4kB if IDMAC is used"
> to get our AXS board upstreamed in full in that 4.2, see:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=0890a264794f33df540fbaf274699146903b4e6b)
> functional with SD/MMC.

Is the above mentioned patch a fix for a regression? If not, it's too
late for 4.2.

Kind regards
Uffe
