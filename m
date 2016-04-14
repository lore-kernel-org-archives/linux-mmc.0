From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 3/3] mmc: pwrseq: convert to proper platform device
Date: Thu, 14 Apr 2016 13:07:08 +0100
Message-ID: <570F87EC.2070500@linaro.org>
References: <1460570081-1679-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1460570081-1679-4-git-send-email-srinivas.kandagatla@linaro.org>
 <CAPDyKFr4rR3g_+TO2PzggVWAC0tKKYNNrAD+d+ywatX9vKpKzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFr4rR3g_+TO2PzggVWAC0tKKYNNrAD+d+ywatX9vKpKzA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Fuzzey <mfuzzey@parkeon.com>
List-Id: linux-mmc@vger.kernel.org



On 14/04/16 10:33, Ulf Hansson wrote:
> On 13 April 2016 at 19:54, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>> simple-pwrseq and emmc-pwrseq drivers rely on platform_device
>> structure from of_find_device_by_node(), this works mostly. But, as there
>> is no driver associated with this devices, cases like default/init pinctrl
>> setup would never be performed by pwrseq. This becomes problem when the
>> gpios used in pwrseq require pinctrl setup.
>>
>> Currently most of the common pinctrl setup is done in
>> drivers/base/pinctrl.c by pinctrl_bind_pins().
>>
>> There are two ways to solve this issue on either convert pwrseq drivers
>> to a proper platform drivers or copy the exact code from
>> pcintrl_bind_pins(). I prefer converting pwrseq to proper drivers so that
>> other cases like setting up clks/parents from dt would also be possible.
>>
>
> [...]
>
>>
>>   int mmc_pwrseq_alloc(struct mmc_host *host)
>>   {
>> -       struct platform_device *pdev;
>>          struct device_node *np;
>> -       struct mmc_pwrseq_match *match;
>> -       struct mmc_pwrseq *pwrseq;
>> -       int ret = 0;
>> +       struct mmc_pwrseq *p, *pwrseq = NULL;
>>
>>          np = of_parse_phandle(host->parent->of_node, "mmc-pwrseq", 0);
>>          if (!np)
>>                  return 0;
>>
>> -       pdev = of_find_device_by_node(np);
>> -       if (!pdev) {
>> -               ret = -ENODEV;
>> -               goto err;
>> +       mutex_lock(&pwrseq_list_mutex);
>> +       list_for_each_entry(p, &pwrseq_list, pwrseq_node) {
>> +               if (p->dev->of_node == np) {
>> +                       pwrseq = p;
>> +                       try_module_get(pwrseq->owner);
>
> This can fail, so please add error handling.
>
Yes, I will add that and -EPROBE_DEFER in failure cases.

--srini

>> +                       host->pwrseq = pwrseq;
>> +                       break;
>> +               }
>>          }
>>
>> -       match = mmc_pwrseq_find(np);
>> -       if (IS_ERR(match)) {
>> -               ret = PTR_ERR(match);
>> -               goto err;
>> -       }
>> +       of_node_put(np);
>> +       mutex_unlock(&pwrseq_list_mutex);
>>
>> -       pwrseq = match->alloc(host, &pdev->dev);
>> -       if (IS_ERR(pwrseq)) {
>> -               ret = PTR_ERR(pwrseq);
>> -               goto err;
>> -       }
>> +       if (!pwrseq)
>> +               return -EPROBE_DEFER;
>>
>> -       host->pwrseq = pwrseq;
>>          dev_info(host->parent, "allocated mmc-pwrseq\n");
>>
>> -err:
>> -       of_node_put(np);
>> -       return ret;
>> +       return 0;
>>   }
>>
>
> Besides the minor thing above, this looks good to me!
>
> Kind regards
> Uffe
>
