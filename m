From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH V2 3/3] mmc: dw_mmc: Dont cut off vqmmc and vmmc
Date: Wed, 27 Aug 2014 13:47:02 +0900
Message-ID: <53FD62C6.8010100@samsung.com>
References: <1408715272-13833-1-git-send-email-yuvaraj.cd@samsung.com>
 <1408715272-13833-4-git-send-email-yuvaraj.cd@samsung.com>
 <CAPDyKFqz8sGj2td=ihZXN4zvAqmu9FHZjWdCn-ZRcdHugNHe2g@mail.gmail.com>
 <CAPz6YkXH1mMOTwcLkKdffdUHN+TaCAhpa8oG0h+rFn9i+GMoCw@mail.gmail.com>
 <CAPDyKFqp7oEt9ASmdxrgUwbQ8aTZzAuJ7uD1oGN50iuzPzBfVg@mail.gmail.com>
 <53FAF8C7.8040007@samsung.com>
 <CAD=FV=XbV7R+FqRRucA5Cv2A+=3g8zccASwxcTtJD6YyO-ioCg@mail.gmail.com>
 <53FD5501.1010007@samsung.com>
 <CAD=FV=VCw1mLpArSY1uj+1zorWROjqGeT3dcTJYzr_1J6jdsBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAD=FV=VCw1mLpArSY1uj+1zorWROjqGeT3dcTJYzr_1J6jdsBQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Doug Anderson <dianders@google.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Sonny Rao <sonnyrao@chromium.org>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <cjb@laptop.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Prashanth G <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, ABHILASH KESAVAN <a.kesavan@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, "cpgs ." <cpgs@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Doug,

On 08/27/2014 01:14 PM, Doug Anderson wrote:
> Jaehoon,
> 
> On Tue, Aug 26, 2014 at 8:48 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi, Doug,
>>
>> On 08/26/2014 12:25 AM, Doug Anderson wrote:
>>> Jaehoon,
>>>
>>> On Mon, Aug 25, 2014 at 1:50 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>> On 08/25/2014 05:13 PM, Ulf Hansson wrote:
>>>>> On 22 August 2014 20:27, Sonny Rao <sonnyrao@chromium.org> wrote:
>>>>>> On Fri, Aug 22, 2014 at 8:31 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>>>> On 22 August 2014 15:47, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
>>>>>>>> Exynos 5250 and 5420 based boards uses built-in CD# line for card
>>>>>>>> detection.But unfortunately CD# line is on the same voltage rails
>>>>>>>> as of I/O voltage rails. When we cut off vqmmc,the consequent card
>>>>>>>> detection will break in these boards.
>>>>
>>>> I didn't know that use CD# line for card detect.
>>>> And if CD# voltage rails and I/O voltage rail are same voltage, it doesn't make sense.
>>>> Which card is used with same voltages? (eMMC? SD? SDIO?)
>>>>
>>>> Well, I have checked Exynos5250 and 5420, but it looks like not same rails.
>>>
>>> I'm not sure I totally understood what you said.  In my manual I have
>>> a table titled "Table 2-1 Exynos 5420 Pin List".  Look in this table
>>> for XMMC2CDN and XMMC2DATA_0.  Look to the right of the table and
>>> you'll see the power domain.  For both it shows VDDQ_MMC2.  If that
>>> doesn't mean that the two are in the same voltage domain then I don't
>>> know what does.  Can you point to any examples where they have
>>> different voltage domains?
>> I think you're mis-understanding for it.
>> Right, It's described at exynos5420, but it's not connected.
> 
> "It's not connected".  What do you mean?  If I were to guess I'd say
> that on some particular board you're looking at they don't happen to
> use the "CD" pin for card detect.  If this is what you mean, it
> doesn't help me.  exynos5420-peach-pit does use the CD pin for card
> detect.  You can look at the DTS file and confirm it.

I didn't know how exynos5420-peach-pit's circuit is configured.
But i guess that almost all exynos5 boards are configured with the similar circuit.

At Almost all Exynos5 board, CD-pin is used, but not included in Same power domain.
(CD-pin is external card-detect pin. - like XEINT_# pin)
You mentioned CD# and DATA# lines is used the same power domain, right?
In Circuit (not exynos5420-peach-pit), DATA# line and CMD/CLK(vqmmc) is same power supply, and vdd is used other power supply.
Not use the CD# pin, used the XEINT_# pin.
So i think we don't need to consider the CD#.
If exynos5420-peach-pit board is used the CD#-pin, then our discussion can be changed.
Your commit message looks like all exynos5250/5420 board are used CD# line.

> 
> ...or are you saying that the CD pin somehow changes voltage domains
> when configured as a GPIO?  I find that very hard to believe.  What
> voltage domain does it go to?  If it goes to a 1.8V voltage domain
> then that would be bad when vqmmc was 3.3V.  If it goes to a 3.3V
> voltage domain then that would be bad when vqmmc was 1.8V.  Remember
> that externally we've got a pull up to vqmmc.

It is used with XEINT_# pin instead of CD# pin.
As i mentioned above, if exynos5420-peach-pit is used CD# line and not used XEINT_# pin,
my point is meaningless. :)

Is exynos5420-peach-pit board used with CD#pin, not XEINT_# pin?

Best Regards,
Jaehoon Chung
> 
> Even if somehow magically we can read the card detect pin with vqmmc
> off, we have an external pullup on this line that goes directly to the
> "vqmmc" power rail.  If the vqmmc power rail is off then this external
> pull up would not work and would actually act as an external pull down
> if you could somehow configure the internal line to be a pullup.
> 
> 
>> Exynos4 series are also described, but we used the broken card detection scheme and power used one of "always-on" powers.
>> Because Card-detection rail need to enable as "always-on".
>>
>> We don't need to consider this. I checked the circuit, this patch didn't need.
>>
>> exynos5 also used the gpio-pin for card-detection. And we can use the slot-gpio API.
> 
> When you say "exynos5", what do you mean here?  Do you mean the smdk
> for 5250, or something else?
> 
