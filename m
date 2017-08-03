From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] Revert "mmc: sdhi: use maximum width for the sdbuf register"
Date: Thu, 3 Aug 2017 12:52:23 +0200
Message-ID: <CAPDyKFrpiXz0PM9uZZS8mC3ULBs2VNqfhpqwFM2QH+MZp6uG+A@mail.gmail.com>
References: <20170803094947.1490-1-wsa+renesas@sang-engineering.com> <20170803095355.GA3251@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170803095355.GA3251@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Biju Das <biju.das@bp.renesas.com>
List-Id: linux-mmc@vger.kernel.org

On 3 August 2017 at 11:53, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Aug 03, 2017 at 11:49:47AM +0200, Wolfram Sang wrote:
>> This reverts commit 785b215250310c690142abb1bdbb0767b8487c49. There is a
>> secondary SDHI instance on Gen2 with has a 32-bit wide SDBUF register
>> while all other registers are 16 bit apart. So, the logic used here does
>> not apply and we need to rethink this and start cleanly from scratch.
>>
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Extra info for Ulf: I can't work on that in the next days, so I thought
> it would be good to ASAP fix the regression in mmc/next at least.
>

Instead of applying this revert, I decided to just drop the original
commit from my next branch.

While working on new version of how to deal with the 32/16 bit
register correctly, please try to include Biju Das in the changelog as
to give him cred from his help with testing.

Kind regards
Uffe
