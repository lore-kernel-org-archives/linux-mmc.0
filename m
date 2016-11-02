From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: Regression after "do not use CMD13 to get status after speed mode
 switch"
Date: Wed, 2 Nov 2016 10:19:36 +0200
Message-ID: <17bdfdf2-5c58-7b09-6d4d-4f5173f6058e@intel.com>
References: <CACRpkdbfNq+R9U9AwsKBM=xyKKTzyVDkiW4jqJ0Nb2LXvq20BA@mail.gmail.com>
 <CACRpkdaUf+YpUEhi-njseR1GQXvM3GuA97Q5GuEpQ3NtFdkoHw@mail.gmail.com>
 <d08ed4e8-84b2-e337-c9ea-a6e36fb6b9e7@intel.com>
 <CAPDyKFp097rBjcJuT1os7W+B5zVUVuprU5_gyE0qU4K=AnA88w@mail.gmail.com>
 <1476930167.11050.4.camel@mhfsdcap03>
 <CAPDyKFqo_LJ_TS158X9RQ2UeGvLcrgCC8r_4to8c7zy0zQggnQ@mail.gmail.com>
 <CAPDyKFpQn+Es6RwiYp319B1KcUduQ_fa2ou6V_2TrQhEsgV4Jw@mail.gmail.com>
 <da9c6695-4dfb-6ba3-99f3-4751880d650d@intel.com>
 <1477964625.4162.3.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1477964625.4162.3.camel@mhfsdcap03>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Andy Gross <andy.gross@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 01/11/16 03:43, Chaotian Jing wrote:
> On Mon, 2016-10-31 at 15:09 +0200, Adrian Hunter wrote:
>> On 27/10/16 13:04, Ulf Hansson wrote:
>>> On 20 October 2016 at 09:06, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> On 20 October 2016 at 04:22, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>>>>> On Wed, 2016-10-19 at 18:41 +0200, Ulf Hansson wrote:
>>>>>> Adrian, Linus,
>>>>>>
>>>>>> Thanks for looking into this and reporting!
>>>>>>
>>>>>> On 18 October 2016 at 15:23, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>> On 18/10/16 11:36, Linus Walleij wrote:
>>>>>>>> On Mon, Oct 17, 2016 at 4:32 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>>>>>
>>>>>>>>> Before this patch the eMMC is detected and all partitions enumerated
>>>>>>>>> immediately, but after the patch it doesn't come up at all, except
>>>>>>>>> sometimes, when it appears minutes (!) after boot, all of a sudden.
>>>>>>>>
>>>>>>>> FYI this is what it looks like when it eventually happens:
>>>>>>>> root@msm8660:/ [  627.710175] mmc0: new high speed MMC card at address 0001
>>>>>>>> [  627.711641] mmcblk0: mmc0:0001 SEM04G 3.69 GiB
>>>>>>>> [  627.715485] mmcblk0boot0: mmc0:0001 SEM04G partition 1 1.00 MiB
>>>>>>>> [  627.736654] mmcblk0boot1: mmc0:0001 SEM04G partition 2 1.00 MiB
>>>>>>>> [  627.747397] mmcblk0rpmb: mmc0:0001 SEM04G partition 3 128 KiB
>>>>>>>> [  627.756326]  mmcblk0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 p11 p12 p13
>>>>>>>> p14 p15 p16 p17 p18 p19 p20 p21 >
>>>>>>>>
>>>>>>>> So after 627 seconds, a bit hard for users to wait this long for their
>>>>>>>> root filesystem.
>>>>>>>
>>>>>>> If the driver does not support busy detection and the eMMC card provides
>>>>>>> zero as the cmd6 generic timeout (which it may especially as cmd6 generic
>>>>>>> timeout wasn't added until eMMCv4.5), then __mmc_switch() defaults to
>>>>>>> waiting 10 minutes i.e.
>>>>>>>
>>>>>>> #define MMC_OPS_TIMEOUT_MS      (10 * 60 * 1000) /* 10 minute timeout */
>>>>>>
>>>>>> Urgh! Yes, I have verified that this is exactly what happens.
>>>>>>
>>>>>>>
>>>>>>> So removal of CMD13 polling for HS mode (as per commit
>>>>>>> 08573eaf1a70104f83fdbee9b84e5be03480e9ed) is going to be a problem for some
>>>>>>> combinations of eMMC cards and host drivers.
>>>>>>
>>>>>> I was looking in the __mmc_switch() function, it's just a pain to walk
>>>>>> trough it :-) So first out I decided to clean it up and factor out the
>>>>>> polling parts. I will post the patches first out tomorrow morning,
>>>>>> running some final test right now.
>>>>>>
>>>>>> Although, that of course doesn't solve our problem. As I see it we
>>>>>> only have a few options here.
>>>>>>
>>>>>> 1) In case when cmd6 generic timeout isn't available, let's assign
>>>>>> another empirically selected value.
>>>>>> 2) Use a specific timeout when switching to HS mode.
>>>>>> 3) Even if we deploy 1 (and 2), perhaps we still should allow polling
>>>>>> with CMD13 for switching to HS mode - unless it causes issues for some
>>>>>> cards/drivers combination?
>>>>>>
>>>>>> BTW, I already tried 2) and it indeed solves the problem, although
>>>>>> depending on the selected timeout, it might delay the card detection
>>>>>> to process.
>>>>>>
>>>>>> Thoughts?
>>>>>
>>>>> I just have a try of switching to HS mode with Hynix EMMC, the first
>>>>> CMD13 gets response of 0x900, but the EMMC is still pull-low DAT0. so
>>>>> that CMD13 cannot indicate current card status in this case.
>>>>
>>>> Thanks for sharing that. Okay, so clearly we have some cards that
>>>> don't supports polling with CMD13 when switching to HS mode.
>>>> One could of course add quirks for these kind of cards and do a fixed
>>>> delay for them, but then to find out which these cards are is going to
>>>> be hard.
>>>>
>>>> It seems like we are left with using a fixed delay. Any ideas of what
>>>> such delay should be? And should we have one specific for switch to
>>>> the various speed modes and a different one that overrides the CMD6
>>>> generic timout, when it doesn't exist?
>>>>
>>>
>>> Replying to my own earlier response, as I believe the problem could
>>> also be related to another old commit, see below.
>>>
>>> commit a27fbf2f067b0cd6f172c8b696b9a44c58bfaa7a
>>> Author: Seungwon Jeon <tgih.jun@samsung.com>
>>> Date:   Wed Sep 4 21:21:05 2013 +0900
>>>
>>>     mmc: add ignorance case for CMD13 CRC error
>>>
>>>     While speed mode is changed, CMD13 cannot be guaranteed.
>>>     According to the spec., it is not recommended to use CMD13
>>>     to check the busy completion of the timing change.
>>>     If CMD13 is used in this case, CRC error must be ignored.
>>>
>>>     Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>>>     Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>     Signed-off-by: Chris Ball <cjb@laptop.org>
>>>
>>>
>>> The intent with this commit was not really correct. We don't want to
>>> ignore CRC errors, but instead we should *re-try* sending CMD13 once
>>> we get a CRC error.
>>>
>>> Unfortunate since this commit, instead we tell the host driver to
>>> *ignore* CRC errors and instead reads the status and returns 0
>>> (indicating success). In the mmc core, in __mmc_switch(), it will thus
>>> parse the status reply, even for a reply that might have been received
>>> with a CRC error. Not good!
>>
>> I agree: ignoring CRC errors and then expecting the status in the response
>> to be correct doesn't make sense.
>>
>> However, it raises the question of what to do if there are always CRC errors
>> e.g. if it only works without CRC errors once the mode and frequency are
>> changed in the host controller.
>>
>>> I am wondering whether this actually is the main problem to why we
>>> think polling isn't working for some cases. And perhaps that was the
>>> original problem Chaotian was trying to solve?
>>>
>>> Thoughts?
>>
>> Does Chaotian have a real problem since his driver has busy detection anyway?
> 
> In fact, I have not encounter CRC errors of CMD13, I have tried several
> eMMC cards, after mode switch, CMD13 will only gets 0x800 response and
> we don't know if card is busy by 0x800 response.

Does it change to 0x900 when it is not busy?

But anyway the question was: do you have busy detection in your driver?
