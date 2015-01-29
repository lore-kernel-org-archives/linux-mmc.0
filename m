From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH v2 4/6] mmc: pwrseq_simple: Add optional reference clock
 support
Date: Thu, 29 Jan 2015 14:53:10 +0100
Message-ID: <54CA3B46.20204@collabora.co.uk>
References: <1422468953-7594-1-git-send-email-javier.martinez@collabora.co.uk>	<1422468953-7594-5-git-send-email-javier.martinez@collabora.co.uk> <CAPDyKFommNu7oscgmhwMpT-5KYN9b6d1xvt513_0qWE=HEGbow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFommNu7oscgmhwMpT-5KYN9b6d1xvt513_0qWE=HEGbow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Arend van Spriel <arend@broadcom.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hello Ulf,

Thanks a lot for your feedback.

On 01/29/2015 02:05 PM, Ulf Hansson wrote:
>>
>>  struct mmc_pwrseq_simple {
>>         struct mmc_pwrseq pwrseq;
>> +       struct clk *ext_clk;
> 
> You need to add a bool, maybe call it clk_enabled;  See why below.
>

Ok
 
>>         int nr_gpios;
>>         struct gpio_desc *reset_gpios[0];
>>  };
>> @@ -39,6 +41,9 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
>>         struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
>>                                         struct mmc_pwrseq_simple, pwrseq);
>>
>> +       if (!IS_ERR(pwrseq->ext_clk))
>> +               clk_prepare_enable(pwrseq->ext_clk);
>> +
> 
> There are no guarantee that the ->mmc_pwrseq_simple_pre_power_on()
> will be invoked prior ->mmc_pwrseq_simple_power_off().
>

Got it, I didn't know that mmc_pwrseq_simple_power_off() could be invoked.
without mmc_pwrseq_simple_pre_power_on() not being called before.

> That means you need to keep track of if you have gated/ungated the
> clock. In other words check pwrseq->clk_enabled. That will prevent
> potential clk unbalance issues.

Yes, I'll change to check for the boolean in _simple_power_off() and
_post_power_on() then.

>> @@ -85,6 +104,14 @@ int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
>>         if (!pwrseq)
>>                 return -ENOMEM;
>>
>> +       pwrseq->ext_clk = clk_get(dev, "ext_clock");
>> +       if (IS_ERR(pwrseq->ext_clk) &&
>> +           PTR_ERR(pwrseq->ext_clk) != -ENOENT &&
>> +           PTR_ERR(pwrseq->ext_clk) != -ENOSYS) {
> 
> I don't think you can get -ENOSYS.
> 

You are right, I'll remove that.

Best regards,
Javier
