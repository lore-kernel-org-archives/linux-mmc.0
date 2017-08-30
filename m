From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] clk: sunxi-ng: Provide a default reset hook
Date: Wed, 30 Aug 2017 15:14:05 +0200
Message-ID: <CAPDyKFqw7PNs_GQXmbJx8doo-tGW6PsKSffJhzVgU3cX3-wvsg@mail.gmail.com>
References: <20170825094953.3247-1-maxime.ripard@free-electrons.com>
 <CAPDyKFonXp4Uqi=DLxKf=1ecOx-2E5mUkEXqnqJPE-J57xXQcw@mail.gmail.com> <20170830123624.vurdnh6bojbtrjal@flea.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:35117 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbdH3NOG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Aug 2017 09:14:06 -0400
Received: by mail-io0-f173.google.com with SMTP id k22so4917584iod.2
        for <linux-mmc@vger.kernel.org>; Wed, 30 Aug 2017 06:14:06 -0700 (PDT)
In-Reply-To: <20170830123624.vurdnh6bojbtrjal@flea.lan>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 30 August 2017 at 14:36, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Ulf,
>
> On Wed, Aug 30, 2017 at 02:29:24PM +0200, Ulf Hansson wrote:
>> On 25 August 2017 at 11:49, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > The reset hook was left implemented. Provide a dumb implementation so that
>> > client drivers can depend on it.
>> >
>> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>
>> Do you want me to pick this up via my mmc tree? If so, is that okay by
>> the clock maintainers?
>
> I also happen to be the maintainer of that part of the kernel
> (reporting to Mike and Stephen of course). We don't have anything
> touching that file in next, so unless they feel like it should go
> through their tree, it would be easier to keep the two changes
> together and merge them through your tree.

Alright, I have picked it up for next!

Kind regards
Uffe
