From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 06/11] mmc: mmci: Qcomm: Add 3 clock cycle delay after
 register write
Date: Tue, 13 May 2014 10:14:13 +0100
Message-ID: <5371E265.4020603@linaro.org>
References: <1398759492-12970-1-git-send-email-srinivas.kandagatla@linaro.org>	<1398759614-13217-1-git-send-email-srinivas.kandagatla@linaro.org> <CACRpkdab4OT_Yzoijgdc7RFBapN8rrN56LYGLeO1vMjb=bu4Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdab4OT_Yzoijgdc7RFBapN8rrN56LYGLeO1vMjb=bu4Mg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, agross@quicinc.com, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Thanks Linus W for reviewing the patches.

On 13/05/14 08:29, Linus Walleij wrote:
> On Tue, Apr 29, 2014 at 10:20 AM,  <srinivas.kandagatla@linaro.org> wrote:
>
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> Most of the Qcomm SD card controller registers must be updated to the MCLK
>> domain so subsequent writes to registers will be ignored until 3 clock cycles
>> have passed.
>>
>> This patch adds a 3 clock cycle delay required after writing to controller
>> registers on Qualcomm SOCs. Without this delay all the register writes are not
>> successfull, resulting in not detecting cards.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> Sounds like someone decided to clock the internal state machine
> in the MMCI using MCLK instead of PCLK :-(
>
> A bit nasty if this ends up in the fastpath (irq) though. Which it
> invariably does, right?
yes, Its going to for Qcom SOC.
>
>> +       /*
>> +        * On QCom SD card controller, registers must be updated to the
>> +        * MCLK domain so subsequent writes to this register will be ignored
>> +        * for 3 clk cycles.
>> +        */
>> +       if (host->hw_designer == AMBA_VENDOR_QCOM)
>> +               udelay(1 + ((3 * USEC_PER_SEC)/host->mclk));
>
> Add a new field in vendor data instead, and use DIV_ROUND_UP():
>
yes, that makes sense..

> static struct variant_data variant_qcom = {
>           .mclk_delayed_writes  = true,
> (...)
>
> if (host->vendor->mclk_delayed_writes)
>      udelay(DIV_ROUND_UP((3 * USEC_PER_SEC), host->mclk));
>
> You get the idea.
>
Got it.

> Yours,
> Linus Walleij
>
