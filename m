From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 01/11] ARM: amba: Add Qualcomm vendor ID.
Date: Wed, 14 May 2014 07:45:33 +0100
Message-ID: <5373110D.2070403@linaro.org>
References: <1398759492-12970-1-git-send-email-srinivas.kandagatla@linaro.org> <1398759542-13017-1-git-send-email-srinivas.kandagatla@linaro.org> <CACRpkdZyEAkJUGC5x6CY65-g97jfyg-TMDoe8JxDMexVx5usSA@mail.gmail.com> <5371E8B7.8000103@linaro.org> <20140513221313.GI20486@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20140513221313.GI20486@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, agross@quicinc.com, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



On 13/05/14 23:13, Stephen Boyd wrote:
> On 05/13, Srinivas Kandagatla wrote:
>> Thanks Linus W,
>>
>> On 13/05/14 08:16, Linus Walleij wrote:
>>> On Tue, Apr 29, 2014 at 10:19 AM,  <srinivas.kandagatla@linaro.org> wrote:
>>>
>>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>
>>>> This patch adds Qualcomm amba vendor Id to the list. This ID is used in mmci
>>>> driver.
>>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> (...)
>>>> +       AMBA_VENDOR_QCOM = 0x51,
>>>
>>> Yeah it's a "Q", like 0x41 is "A" for ARM. You could as well mention
>>> this in the commit message.
>>>
>> Sounds good, I will fix it in next version and send it to Russell's
>> patch tracker.
>>
>
> Please add a note that this id is fake in the commit text or in
> the code as well.
Sure, I will add it in commit text.


>
