From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH RFC 5/5] mmc: mmci: move ST specific sdio setup under
 a condition
Date: Wed, 13 Aug 2014 10:45:02 +0100
Message-ID: <53EB339E.4030604@linaro.org>
References: <1407844950-8072-1-git-send-email-srinivas.kandadgatla@linaro.org>	<1407845127-8448-1-git-send-email-srinivas.kandadgatla@linaro.org> <CACRpkdY-rhuqMgY7ZRB8YEi+AiNMV_SLbSGJy7Nw+ytyjQXMnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CACRpkdY-rhuqMgY7ZRB8YEi+AiNMV_SLbSGJy7Nw+ytyjQXMnA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Thankyou Linus for the feedback.

On 13/08/14 09:58, Linus Walleij wrote:
> On Tue, Aug 12, 2014 at 2:05 PM, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch moves ST specific sdio setup under a vendor id condition,
>> this will ensure that the ST specfic setup is not done on other vendor
>> like Qualcomm.
>>
>> Originally the issue was detected while testing WLAN ath6kl on IFC6410
>> board with APQ8064 SOC.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> So instead of again checking hw_designer (I think that's a bit
> messy) and instead of having the flag bool sdio from patch
> 1, why not introduce 2 flags in vendor_data:
>
> bool st_sdio;
> bool qcom_sdio;

Thats good idea,

If we rename the existing sdio flag to st_sdio, then we can get rid of 
the first patch too. As there is no specific sdio logic required for qcom.

I will send the change in next version.

thanks
srini
>
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -828,7 +828,8 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
>>                           * otherwise the transfer will not start. The threshold
>>                           * depends on the rate of MCLK.
>>                           */
>> -                       if (data->flags & MMC_DATA_WRITE &&
>> +                       if (host->hw_designer == AMBA_VENDOR_ST &&
>> +                           data->flags & MMC_DATA_WRITE &&
>
> And this becomes just
>
> if (variant->st_sdio)...
>
>>                              (host->size < 8 ||
>>                               (host->size <= 8 && host->mclk > 50000000)))
>>                                  clk = host->clk_reg & ~variant->clkreg_enable;
>
> Yours,
> Linus Walleij
>
