From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: 4.13 on thinkpad x220: oops when writing to SD card
Date: Thu, 7 Sep 2017 17:03:41 +0200
Message-ID: <CAPDyKFrcY55yJQZOpJmCrL=qhaQxUQEa7wy9SzmiUJSsAniBCQ@mail.gmail.com>
References: <20170905194739.GA31241@amd> <8f0f7310-ea4d-a200-75fd-23509947fb38@rock-chips.com>
 <6689241f-a4d8-7a3e-9f0b-482b034e5710@intel.com> <CAPDyKFqXaDFrJH1-YSSCx0xPXfMN99AM_Wu_sWQf5A6bw+zjdQ@mail.gmail.com>
 <f36b194b-f74b-20de-3122-0243774b74c2@intel.com> <CAPDyKFp3QdVm3oxkMvozuf+hifJi64Fn8T27Gy7Mq8SVpAYTSQ@mail.gmail.com>
 <20170907125514.GA6587@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170907125514.GA6587@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Seraphime Kirkovski <kirkseraph@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 7 September 2017 at 14:55, Pavel Machek <pavel@ucw.cz> wrote:
> On Thu 2017-09-07 14:06:52, Ulf Hansson wrote:
>> [...]
>>
>> >
>> > From: Adrian Hunter <adrian.hunter@intel.com>
>> > Date: Thu, 7 Sep 2017 10:40:35 +0300
>> > Subject: [PATCH] mmc: block: Fix incorrectly initialized requests
>> >
>> > mmc_init_request() depends on card->bouncesz so it must be calculated
>> > before blk_init_allocated_queue() starts allocating requests.
>> >
>> > Reported-by: Seraphime Kirkovski <kirkseraph@gmail.com>
>> > Fixes: 304419d8a7e92 ("mmc: core: Allocate per-request data using the block layer core")
>> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> Thanks, applied for fixes!
>
> Thanks. I believe this one should get cc: stable markups, so
> eventually 4.13 does get fixed, too....
>                                                                 Pavel

Yeah, correct and added!

Kind regards
Uffe
