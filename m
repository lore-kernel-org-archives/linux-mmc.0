From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH v9 00/16] mmc: sdhci-msm: Add clk-rates, DDR, HS400
 support
Date: Wed, 23 Nov 2016 05:35:25 +0530
Message-ID: <6dd874b4-8f60-471b-d1e7-089b4b035ad2@codeaurora.org>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
 <CAPDyKFrRbf0+G5K=-jsaevAGbTqhTAss2zJv3QdiyCrv0BG-zA@mail.gmail.com>
 <d4d05fb9-8a9e-6cf2-dc63-0edbd27a9e55@codeaurora.org>
 <20161121231138.GY25626@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20161121231138.GY25626@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Andy Gross <andy.gross@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, David Brown <david.brown@linaro.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Asutosh Das <asutoshd@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Rajendra Nayak <rnayak@codeaurora.org>, Pramod Gurav <pramod.gurav@linaro.org>, jeremymc@redhat.com
List-Id: linux-mmc@vger.kernel.org



On 11/22/2016 4:41 AM, Stephen Boyd wrote:
> On 11/21, Ritesh Harjani wrote:
>>
>>
>> On 11/21/2016 3:36 PM, Ulf Hansson wrote:
>>> On 21 November 2016 at 07:37, Ritesh Harjani <riteshh@codeaurora.org> wrote:
>>>> Hi,
>>>>
>>>> This is v9 version of the patch series which adds support for MSM8996.
>>>> Adds HS400 driver support as well.
>>>> These are tested on internal msm8996 & db410c HW.
>>>>
>>>> The patch series is ready. Do we think we can apply these
>>>> patches for next now?
>>>
>>> I guess the DTS changes can be picked up by Andy, so they can go via arm-soc?
>> Yes.
>>
>>>
>>> Then, does the mmc changes depend on the clock changes? If so, I can
>>> pick them as well, but then I need an ack from Stephen....
>> Ideal and preferable, would be that clk & mmc changes go in
>> together. But either ways should be fine.
>>
>
> There's only a runtime dependency where the clk rates will be
> wrong if clk tree isn't merged. I'd rather just apply the clk
> ones directly to clk tree and let all three trees come together
> in linux-next and work.

Ok great! So can we queue this patch series to next?
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
