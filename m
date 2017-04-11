From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: core: add mmc-card hardware reset enable support
Date: Tue, 11 Apr 2017 12:43:39 +0200
Message-ID: <CAPDyKFoL5dbs_xKxaBGk2bqd2tOXrhG_SVcBoUpMetsKDdNXxQ@mail.gmail.com>
References: <1491895862-7952-1-git-send-email-richard.leitner@skidata.com> <CACRpkdaBrk91hh3JGZ0vcD3aXO+OHD41xwRKn9prPSOX_SXuWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdaBrk91hh3JGZ0vcD3aXO+OHD41xwRKn9prPSOX_SXuWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Richard Leitner <richard.leitner@skidata.com>, Bart Van Assche <bart.vanassche@sandisk.com>, Luca Porzio <lporzio@micron.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Richard Leitner <dev@g0hl1n.net>
List-Id: linux-mmc@vger.kernel.org

On 11 April 2017 at 10:17, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Apr 11, 2017 at 9:31 AM, Richard Leitner
> <richard.leitner@skidata.com> wrote:
>
>> Some eMMCs disable their hardware reset line (RST_N) by default. To enable
>> it the host must set the corresponding bit in ECSD. An example for such
>> a device is the Micron MTFCxGACAANA-4M.
>>
>> This patch adds a new mmc-card devicetree property to let the host enable
>> this feature during card initialization.
>>
>> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
>
> Do we know *WHY* these cards disable their hardware reset lines?

Allow me to make a guess. In case the reset isn't enabled, the
internal eMMC card firmware don't monitor the pin for the reset. I
guess that could makes sense if SoC vendors has failed to properly
connect the pin, avoiding the eMMC card to be reset when it shouldn't.

>
> If it is just some random over-cautious panic thing we might consider
> just force re-enableing it, maybe with a warning in the dmesg, so we can
> always reset the card. No DT property needed.

There is actually already a DT property "cap-mmc-hw-reset"
(MMC_CAP_HW_RESET), which tells whether the eMMC reset is supported by
the host.

Perhaps we can consider to force-enabling it for the eMMC card, when
this property is set for the mmc host!? At least, inventing yet
another binding doesn't make sense to me.

>
> Putting some people who work for eMMC vendors in the To: line so they
> can say if they know about this.

Yes, let's see what they say about it.

>
> Yours,
> Linus Walleij

Kind regards
Uffe
