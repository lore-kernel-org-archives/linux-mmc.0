From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2 1/3] mmc: pwrseq: add driver for emmc hardware reset
Date: Mon, 02 Feb 2015 11:00:42 +0100
Message-ID: <54CF4ACA.6060001@samsung.com>
References: <1422866028-27891-1-git-send-email-m.szyprowski@samsung.com>
 <1422866028-27891-2-git-send-email-m.szyprowski@samsung.com>
 <CABxcv=nF3SJK7p1j=F08_9kHU2n+v=hmgr7-ikfZ7Xraz3J0_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CABxcv=nF3SJK7p1j=F08_9kHU2n+v=hmgr7-ikfZ7Xraz3J0_g@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Tobias Jakobi <liquid.acid@gmx.net>, Daniel Drake <drake@endlessm.com>, Sebastian Reichel <sre@kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hello,

On 2015-02-02 09:59, Javier Martinez Canillas wrote:
> On Mon, Feb 2, 2015 at 9:33 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> +
>> +Required properties:
>> +- compatible : contains "mmc-pwrseq-emmc".
>> +- reset-gpios : contains a GPIO specifier. The reset GPIO is pulled
> The DT binding says that the "reset-gpios" is a required property...
>
>> +int mmc_pwrseq_emmc_alloc(struct mmc_host *host, struct device *dev)
>> +{
>> +       struct mmc_pwrseq_emmc *pwrseq;
>> +       int ret = 0;
>> +
>> +       pwrseq = kzalloc(sizeof(struct mmc_pwrseq_emmc), GFP_KERNEL);
>> +       if (!pwrseq)
>> +               return -ENOMEM;
>> +
>> +       pwrseq->reset_gpio = gpiod_get_index(dev, "reset", 0, GPIOD_OUT_LOW);
>> +       if (IS_ERR(pwrseq->reset_gpio) &&
>> +               PTR_ERR(pwrseq->reset_gpio) != -ENOENT &&
>> +               PTR_ERR(pwrseq->reset_gpio) != -ENOSYS) {
>> +               ret = PTR_ERR(pwrseq->reset_gpio);
>> +               goto free;
>> +       }
> ...but here the GPIO is made optional since this will return and
> propagate the error only for -EPROBE_DEFER error but won't do it for
> -ENOENT and -ENOSYS.

Thanks for spotting this. reset-gpios is required, this driver really 
makes no
sense without a gpio pin. I copied code from mmc-pwrseq-simple, which 
handled
optional gpio pins. I will fix this is a few minutes.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
