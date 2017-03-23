From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V1] mmc: core: fix still flush cache when eMMC cache off
Date: Thu, 23 Mar 2017 14:10:18 +0100
Message-ID: <CAPDyKFqNm3cu0MckrOcT1rdt1s6oSFCE72Lz_GyfHZYaqoqAoA@mail.gmail.com>
References: <4e7d0b4b8df1430698e822b1a36bcc11@SIWEX5A.sing.micron.com>
 <CAPDyKFoy_EDRNkicPAMPReB3GCxZPkO+H9Jh14nxg3YfVzchOw@mail.gmail.com> <3a0f2112746a4f0fbaa73906c606a340@SIWEX5A.sing.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3a0f2112746a4f0fbaa73906c606a340@SIWEX5A.sing.micron.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Bean Huo (beanhuo)" <beanhuo@micron.com>
Cc: "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "axboe@fb.com" <axboe@fb.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zoltan Szubbocsev (zszubbocsev)" <zszubbocsev@micron.com>
List-Id: linux-mmc@vger.kernel.org

On 23 March 2017 at 11:45, Bean Huo (beanhuo) <beanhuo@micron.com> wrote:
> Hi,
>
>>On 19 March 2017 at 01:45, Bean Huo (beanhuo) <beanhuo@micron.com> wrote:
>>> This patch fixes the issue that mmc_blk_issue_rq still flushes cache
>>> when eMMC cache has already been off through user space tool, such as
>>> mmc-utils.
>>> The reason is that card->ext_csd.cache_ctrl isn't reset.
>>
>>First, why do you want to turn of the cache ctrl? Is the eMMC device having
>>issues with it? Then we should invent a card quirk instead.
>
>
> Why I turn off it? because I did power loss testing and validation, I should switch it off and on.
> When I do some performance and power loss case validation on several Linux release versions,
> I need to switch off or on cache through user space tool.
> I can't confirm every user that likes me, But I think at least it is not reasonable to
> flush eMMC cache, when internal eMMC cache is off.

Ah, I see. Your use-case seems reasonable while validating robustness
of the eMMC!

>
>>Second, what errors do you encounter when the mmc core tries to flush the
>>cache when it has been turned off? Can you please elaborate on this?
>
>
> No error found, but firstly, please think about overhead introduced by useless flush cache, Unless you
> Don't care this tiny time. second, under the condition of cache off, additional flush cache request still has impact on
> Internal eMMC logic. I don't know What and how impact, but at least it is really exist.

Got it!

However I still don't like the mmc ioctls API to compensate and deal
with all "crazy-ness" that user-space may cause. Cache-ctrl is only
one case out of many.

I see two viable options to solve your problem.
1) Extend mmc_test with a new test(s) for cache ctrl and perhaps
suspend/resume. Isn't this actually exactly what you want?
2) Extend debugfs to be able to turn cache ctrl on/off.

[...]

Kind regards
Uffe
