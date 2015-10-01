From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [GIT PULL] Update dw-mmc controller
Date: Thu, 01 Oct 2015 18:17:15 +0900
Message-ID: <560CFA1B.9050008@samsung.com>
References: <55C8D73D.10709@gmail.com>
 <CAPDyKFqN9FxQNbwoiCj1A+BUUWHm_H8RXNhKVzUkV0xOUUdCFA@mail.gmail.com>
 <1439806320.3667.39.camel@synopsys.com>
 <CAPDyKFowfusQa+geBxjZZ1KCffVu5BnGM4jD52k3Ztf3wSt7og@mail.gmail.com>
 <1442402874.31048.8.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <1442402874.31048.8.camel@synopsys.com>
Sender: stable-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "jh80.chung@gmail.com" <jh80.chung@gmail.com>, "heiko@sntech.de" <heiko@sntech.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, "addy.ke@rock-chips.com" <addy.ke@rock-chips.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, CPGS <cpgs@samsung.com>
List-Id: linux-mmc@vger.kernel.org

CC'd Greg.

On 09/16/2015 08:27 PM, Alexey Brodkin wrote:
> Hello,
> 
> On Mon, 2015-08-17 at 12:32 +0200, Ulf Hansson wrote:
>> On 17 August 2015 at 12:12, Alexey Brodkin <Alexey.Brodkin@synopsys.com> wrote:
>>> Hi Ulf,
>>>
>>> On Mon, 2015-08-17 at 11:47 +0200, Ulf Hansson wrote:
>>>> On 10 August 2015 at 18:54, Jaehoon Chung <jh80.chung@gmail.com> wrote:
>>>>> Dear, Ulf.
>>>>>
>>>>> Could you pull these patches into your repository?
>>>>>
>>>>> Best Regards,
>>>>> Jaehoon Chung
>>>>
>>>> Thanks! Pulled into my next branch.
>>>>
>>>> Kind regards
>>>> Uffe
>>>
>>> I'm wondering if mentioned fixes only hit 4.3 (you mentioned your
>>> "next" branch) or there's a chance for them to be pulled in the next 4.2-rcX?
>>>
>>> The thing is we need at least "mmc: dw_mmc: handle data blocks > than 4kB if IDMAC is used"
>>> to get our AXS board upstreamed in full in that 4.2, see:
>>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=0890a264794f33df540fbaf274699146903b4e6b)
>>> functional with SD/MMC.
>>
>> Is the above mentioned patch a fix for a regression? If not, it's too
>> late for 4.2.
> 
> Please consider following patch to be picked-up for stable branches because
> it fixes real problem on systems with 4Kb MMU page.
> 
> That commit is already in Linux 4.3-rc1 here:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=5959b32e3636f9bfe3f869d1e440bc4a4d660965
> 
> -Alexey
> 
