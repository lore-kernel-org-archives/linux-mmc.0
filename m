From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 03/13] mmc: mmci: Add Qualcomm Id to amba id table
Date: Mon, 26 May 2014 18:00:07 +0100
Message-ID: <53837317.9000203@linaro.org>
References: <1400849362-7007-1-git-send-email-srinivas.kandagatla@linaro.org>	<1400849474-7177-1-git-send-email-srinivas.kandagatla@linaro.org> <CAPDyKFqfqhnCKA-dMqAfkhQ+cLLhN0vMtwTxB6t+MUju_04O-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqfqhnCKA-dMqAfkhQ+cLLhN0vMtwTxB6t+MUju_04O-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On 26/05/14 10:10, Ulf Hansson wrote:
> Hi Srinivas,
>
>>
>> +static struct variant_data variant_qcom = {
>> +       .fifosize               = 16 * 4,
>> +       .fifohalfsize           = 8 * 4,
>> +       .clkreg                 = MCI_CLK_ENABLE,
>> +       .datalength_bits        = 24,
>> +       .blksz_datactrl4        = true,
>
> You get compile error here.
yes, You are right, I will reorder this patch after the "mmc: mmci: Add 
Qcom datactrl register variant"


Thanks,
srini
>
> Kind regards
> Ulf Hansson
>
