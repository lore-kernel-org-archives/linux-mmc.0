From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 12/13] mmc: mmci: add explicit clk control
Date: Wed, 28 May 2014 09:28:55 +0100
Message-ID: <53859E47.2040701@linaro.org>
References: <1400849362-7007-1-git-send-email-srinivas.kandagatla@linaro.org>	<1400849578-7585-1-git-send-email-srinivas.kandagatla@linaro.org>	<CAPDyKFqz-O9-Douk96LBuFRD_P1146c_Ld14TgiduBgfBqRi_A@mail.gmail.com>	<5383C28D.1060808@linaro.org> <CACRpkdYjQzwVF8ikqqt=7pCvdKM59JcM4HS-UNJ8Ueqdw9az4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYjQzwVF8ikqqt=7pCvdKM59JcM4HS-UNJ8Ueqdw9az4A@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Russell King <linux@arm.linux.org.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



On 28/05/14 09:02, Linus Walleij wrote:
> On Tue, May 27, 2014 at 12:39 AM, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>> On 26/05/14 15:21, Ulf Hansson wrote:
>>> On 23 May 2014 14:52,  <srinivas.kandagatla@linaro.org> wrote:
>
>>>>
>>>> +       bool                    explicit_mclk_control;
>>>> +       bool                    cclk_is_mclk;
>>>
>>> I can't see why you need to have both these new configurations. Aren't
>>> "cclk_is_mclk" just a fact when you use "explicit_mclk_control".
>>
>>> I also believe I would prefer something like "qcom_clkdiv" instead.
>>
>> There is a subtle difference between both the flags.  Am happy to change it
>> to qcom_clkdiv.
>
> I think this was due to me wanting the variant variables to be more about
> the actual technical difference they indicate rather than pointing to
> a certain vendor or variant where that difference occurs.
>
Yes, that's correct, I think having these two variables seems to be more 
generic than qcom_clkdiv.

I will keep it as it is and fix other comments from Ulf in next version.

> It's a very minor thing though, if you prefer it this way, go for it.
>

Thanks,
sirni
> Yours,
> Linus Walleij
>
