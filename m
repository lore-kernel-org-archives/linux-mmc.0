From: Harish Jenny K N <harish_kandiga@mentor.com>
Subject: Re: [PATCH v10] mmc: Export host capabilities to debugfs.
Date: Thu, 22 Mar 2018 10:49:37 +0530
Message-ID: <3fcd7a2a-19a3-859c-0b24-8ac07bfaa1e2@mentor.com>
References: <1520917812-20047-1-git-send-email-harish_kandiga@mentor.com>
 <CAPDyKFo8jFwDO1E=tNSd4yTn3qtefzvHK0V70fcEqzB=SibrJA@mail.gmail.com>
 <1521109575.10722.654.camel@linux.intel.com>
 <CAPDyKFrZaDx2NdvaFdgOxWBuwtjMnJE41p=x5b2x2moFEO3kXQ@mail.gmail.com>
 <b93613a1-f35d-d246-5e1d-dc7821eb5976@mentor.com>
 <CAPDyKFoP02ZGkUxmtWbF6kEWTzdM2dyKmyWcsGZ1_Mt3WUyg-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoP02ZGkUxmtWbF6kEWTzdM2dyKmyWcsGZ1_Mt3WUyg-Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, avri.altman@wdc.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vladimir Zapolskiy <Vladimir_Zapolskiy@mentor.com>
List-Id: linux-mmc@vger.kernel.org



On Friday 16 March 2018 01:27 PM, Ulf Hansson wrote:
> On 16 March 2018 at 05:20, Harish Jenny K N <harish_kandiga@mentor.com> wrote:
>>
>> On Thursday 15 March 2018 05:59 PM, Ulf Hansson wrote:
>>> On 15 March 2018 at 11:26, Andy Shevchenko
>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>> On Thu, 2018-03-15 at 11:12 +0100, Ulf Hansson wrote:
>>>>> On 13 March 2018 at 06:10, Harish Jenny K N <harish_kandiga@mentor.com
>>>>>> wrote:
>>>>>>
>>>>> Honestly, I don't like this, but maybe other people do, then I am fine
>>>>> with this approach.
>>>>>
>>>>> If were to decide, I would just rather print the caps field in a
>>>>> hexadecimal bit form and leave the translation to the user.
>>>> A compromise would be to print both:
>>>>
>>>> 0xHHHHHHHH\n
>>>> Description of each enabled field, one per line
>>>>
>>>>
>>>> Another format would be:
>>>>
>>>> Bit XX: Description of a field
>>> If we were to print the description, there is no point in printing the
>>> bits in hex. Or is it?
>> Yes. I also do not see the use of printing hex value if we are printing the description.
>>
>>> As I said, if you and other folkz thinks this is valuable, then I am
>>> fine as well. Just saying, it's not my preferred option.
>>>
>>>
>>
>> I just want to inform that the idea of printing the description came after discussion in https://www.spinics.net/lists/linux-mmc/msg48246.html, where it was decided adding utility in mmc-utils was not going to work ( reason:  We may very well be changing the bit offsets for the caps and caps2 in the mmc kernel header, keeping a copy of them is not a good idea. It's just a matter of *when* it will break).
> I recall. However, I didn't realize all these strings were going to be
> needed. :-)
>
>> On Thu, 2018-03-15 at 11:12 +0100, Ulf Hansson wrote:
>>> If were to decide, I would just rather print the caps field in a hexadecimal bit form and leave the translation to the user.
>> I think translation becomes difficult for the above reason and hence I would prefer printing the description.
> Okay.
>
>> Note: Printing values in Hex was the original idea and it is also available in https://www.spinics.net/lists/linux-mmc/msg48213.html just in case if it is required.
> Yeah, so maybe I should apply that one, then we can take it from there!?



Fine with both the approach. Please consider this.


Thanks,
Harish Jenny K N
