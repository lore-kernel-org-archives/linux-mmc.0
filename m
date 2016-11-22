From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFCv2 01/10] mmc: core: Add support to read command queue parameters
Date: Tue, 22 Nov 2016 13:30:53 +0100
Message-ID: <CACRpkdZkYVJmZ_M3oYhY3i4JrqEA_Xxc3ZALKaMdQq2ybxfvZA@mail.gmail.com>
References: <1467033757-32498-1-git-send-email-riteshh@codeaurora.org>
 <1467033757-32498-2-git-send-email-riteshh@codeaurora.org>
 <CACRpkdYDfdCoZUOryjVX4byu2BFx9KZx7YKoFG9wESDpaKtirg@mail.gmail.com>
 <e18147ff-ac6b-a48f-4487-18ebd51bbc99@intel.com> <CACRpkdaHgN7XGdXjeE1dwQ2gn0z=VXfjVdVGYcT0gRfASNUKbQ@mail.gmail.com>
 <0cf555d9-4e79-73fb-954d-8f022c90d4dc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <0cf555d9-4e79-73fb-954d-8f022c90d4dc@intel.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ritesh Harjani <riteshh@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Asutosh Das <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, kdorfman@codeaurora.org, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, venkatg@codeaurora.org, Shawn Lin <shawn.lin@rock-chips.com>, Subhash Jadavani <subhashj@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Nov 22, 2016 at 11:31 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 22/11/16 12:20, Linus Walleij wrote:
>> On Tue, Nov 22, 2016 at 8:58 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 21/11/16 17:34, Linus Walleij wrote:
>>>> On Mon, Jun 27, 2016 at 3:22 PM, Ritesh Harjani <riteshh@codeaurora.org> wrote:
>>>>
>>>>> From: Asutosh Das <asutoshd@codeaurora.org>
>>>>>
>>>>> eMMC cards with EXT_CSD version >= 8, optionally support command
>>>>> queuing feature as defined by JEDEC eMMC5.1. Add support for probing
>>>>> command queue feature for such type of cards.
>>>>>
>>>>> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
>>>>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>>>>> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>>>>> [subhashj@codeaurora.org: fixed trivial merge conflicts]
>>>>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>>>>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>>>>
>>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>>
>>>> Even if we don't merge the specific mechanism provided by the
>>>> rest of the patches, this patch just make us know more about
>>>> the capabilities of the hardware we're running on, which is good.
>>>
>>> I think SW CMDQ is a better starting point:
>>
>> When I supplied the Reviewe-by, as stated below it I am not talking
>> about the patch set as a whole. I am talking about *this* patch.
>
> I should have been more explicit.  SW CMDQ covers some of the same ground
> and has basically the same patch:
>
>         https://marc.info/?l=linux-mmc&m=147729859922297&w=2

OK it seems to define more of the constants, I'll go and review it.

Yours,
Linus Walleij
