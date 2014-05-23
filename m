From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 12/14] mmc: mmci: add support for fbclk to latch data
 and cmd.
Date: Fri, 23 May 2014 10:20:38 +0100
Message-ID: <537F12E6.6070809@linaro.org>
References: <1400146447-29803-1-git-send-email-srinivas.kandagatla@linaro.org>	<1400146669-30302-1-git-send-email-srinivas.kandagatla@linaro.org> <CACRpkdZtHPZpmFA+JfgMn83+SgZZX4CS+MhAcf_sk2cQKqW1Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZtHPZpmFA+JfgMn83+SgZZX4CS+MhAcf_sk2cQKqW1Pw@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



On 23/05/14 10:12, Linus Walleij wrote:
> On Thu, May 15, 2014 at 11:37 AM,  <srinivas.kandagatla@linaro.org> wrote:
>
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds support to fbclk that is used to latch data and
>> cmd on some controllers like SD Card controller in Qcom SOC.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> (...)
>
> Isn't this overkill?

I totally agree.

Initially I did do it the way you suggested, but wanted to be more 
explicit in what its actually doing and I was also not sure if its Ok to 
add more than one flag in clkreg_enable.

>
> @@ -189,6 +192,7 @@ static struct variant_data variant_qcom = {
>           .clkreg                 = MCI_CLK_ENABLE,
> -        .clkreg_enable          = MCI_QCOM_CLK_FLOWENA,
> +       .clkreg_enable          = MCI_QCOM_CLK_FLOWENA |
> MCI_QCOM_CLK_FEEDBACK_CLK,
>           .clkreg_8bit_bus_enable = MCI_QCOM_CLK_WIDEBUS_8,
>

> Isn't this achieveing exactly the same thing without the extra fields?
> You unconditionally do it at every enable anyway, don't you?
I will fix it and send a new version.

Thanks,
srini
>
> Yours,
> Linus Walleij
>
