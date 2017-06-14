From: Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH v2] mmc: core: add mmc-card hardware reset enable support
Date: Wed, 14 Jun 2017 09:25:00 +0200
Message-ID: <0a29de1a-2635-2bb8-808a-7b9a0197921a@skidata.com>
References: <1491895862-7952-1-git-send-email-richard.leitner@skidata.com>
 <CACRpkdaBrk91hh3JGZ0vcD3aXO+OHD41xwRKn9prPSOX_SXuWg@mail.gmail.com>
 <CAPDyKFoL5dbs_xKxaBGk2bqd2tOXrhG_SVcBoUpMetsKDdNXxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoL5dbs_xKxaBGk2bqd2tOXrhG_SVcBoUpMetsKDdNXxQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, Luca Porzio <lporzio@micron.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Richard Leitner <dev@g0hl1n.net>
List-Id: linux-mmc@vger.kernel.org

On 04/11/2017 12:43 PM, Ulf Hansson wrote:
> On 11 April 2017 at 10:17, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, Apr 11, 2017 at 9:31 AM, Richard Leitner
>> <richard.leitner@skidata.com> wrote:
>>
>>> Some eMMCs disable their hardware reset line (RST_N) by default. To enable
>>> it the host must set the corresponding bit in ECSD. An example for such
>>> a device is the Micron MTFCxGACAANA-4M.
>>>
>>> This patch adds a new mmc-card devicetree property to let the host enable
>>> this feature during card initialization.
>>>
>>> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
>>
>> Do we know *WHY* these cards disable their hardware reset lines?
> 
> Allow me to make a guess. In case the reset isn't enabled, the
> internal eMMC card firmware don't monitor the pin for the reset. I
> guess that could makes sense if SoC vendors has failed to properly
> connect the pin, avoiding the eMMC card to be reset when it shouldn't.
> 
>> If it is just some random over-cautious panic thing we might consider
>> just force re-enableing it, maybe with a warning in the dmesg, so we can
>> always reset the card. No DT property needed.
> 
> There is actually already a DT property "cap-mmc-hw-reset"
> (MMC_CAP_HW_RESET), which tells whether the eMMC reset is supported by
> the host.
> 
> Perhaps we can consider to force-enabling it for the eMMC card, when
> this property is set for the mmc host!? At least, inventing yet
> another binding doesn't make sense to me.

IMHO setting this (permanent) configuration bit should be done
explicitly and not within another DT property. Otherwise somebody may
accidentally set this configuration by (for example) including a dtsi
which has cap-mmc-hw-reset configured.

Nonetheless if the majority agrees to implicitly set it when
"cap-mmc-hw-reset" is configured I'm fine with that too.

Another possibility is to don't include it in the kernel at all and
therefore require the mmc userspace program to configure it...?

> 
>> Putting some people who work for eMMC vendors in the To: line so they
>> can say if they know about this.
> 
> Yes, let's see what they say about it.

Any news/comments?

kind regards,
Richard.L
