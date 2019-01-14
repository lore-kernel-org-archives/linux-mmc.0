From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-iproc: handle mmc_of_parse() errors during
 probe
Date: Mon, 14 Jan 2019 13:01:51 +0100
Message-ID: <675cab05-164f-fd72-9d87-1506dc5a6b7a@i2se.com>
References: <1545598758-4502-1-git-send-email-stefan.wahren@i2se.com>
 <CAPDyKFpTW07CsemS1=0kTEc88-ZXb6+HUVaviGb+8eWBOyRjvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpTW07CsemS1=0kTEc88-ZXb6+HUVaviGb+8eWBOyRjvA@mail.gmail.com>
Content-Language: de-DE
Sender: stable-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Al Cooper <alcooperx@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

Am 14.01.2019 um 12:44 schrieb Ulf Hansson:
> On Sun, 23 Dec 2018 at 22:00, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> We need to handle mmc_of_parse() errors during probe.
>>
>> This finally fixes the wifi regression on Raspberry Pi 3 series.
>> In error case the wifi chip was permanently in reset because of
>> the power sequence depending on the deferred probe of the GPIO expander.
>>
>> Fixes: b580c52d58d9 ("mmc: sdhci-iproc: add IPROC SDHCI driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Applied for next, thanks!

since this fixes a regression can this applied to fixes, please?

Stefan


>
> Kind regards
> Uffe
>
