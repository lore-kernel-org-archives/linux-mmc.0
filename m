From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH-v2 4/7] mmc: sdhci-pxav3: Add pinctl setting according to
 bus clock
Date: Tue, 8 Sep 2015 20:37:11 +0530
Message-ID: <55EEF99F.1020904@linaro.org>
References: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441624721-15612-5-git-send-email-vaibhav.hiremath@linaro.org>
 <CACRpkdY59roEBgUd9TR39yNgfhw393+WmHQQAeLkOEZLChOcWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdY59roEBgUd9TR39yNgfhw393+WmHQQAeLkOEZLChOcWQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Liu <kliu5-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org



On Tuesday 08 September 2015 08:12 PM, Linus Walleij wrote:
> On Mon, Sep 7, 2015 at 1:18 PM, Vaibhav Hiremath
> <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
>> Different bus clock may need different pin setting.
>> For example, fast bus clock like 208Mhz need pin drive fast
>> while slow bus clock prefer pin drive slow to guarantee
>> signal quality.
>>
>> So this patch creates two states,
>>    - Default (slow/normal) pin state
>>    - And fast pin state for higher freq bus speed.
>>
>> And selection of pin state is done based on timing mode.
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Kevin Liu <kliu5-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> (...)
>> +       pxa->pinctrl = devm_pinctrl_get(dev);
>> +       if (!IS_ERR(pxa->pinctrl)) {
>> +               pxa->pins_default = pinctrl_lookup_state(pxa->pinctrl, "default");
>> +               if (IS_ERR(pxa->pins_default))
>> +                       dev_err(dev, "could not get default pinstate\n");
>> +               pxa->pins_fast = pinctrl_lookup_state(pxa->pinctrl, "fast");
>> +               if (IS_ERR(pxa->pins_fast))
>> +                       dev_info(dev, "could not get fast pinstate\n");
>> +       }
>
> This is exactly how I think it should be used from a pin control
> point of view.
>
> If you depended on CONFIG_PM you could use
> pinctrl_pm_select_default_state() but for this simple scenario
> this is fine.
>
> Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>  From a pinctrl point of view.
>


Thanks for your review.

Linus,

I agree this is how it should be used.
But I still have one small doubt on expectation from
devm_pinctrl_get() function.


If pinctrl properties are not populated in Devicetree node,
then, shouldn't devm_pinctrl_get() return error ?
I followed the code flow, and it seems even if pinctrl properties are
not populated in DT node, the devm_pinctrl_get() returns valid
pointer to "struct pinctrl", isn't this against the expectation of the
call?


Code flow -

devm_pinctrl_get()
...
--> creat_pinctrl()
--> pinctrl_dt_to_map()
...



pinctrl_dt_to_map() iterates for pinctrl-x (x = 0,1,...) and if it
founds the entry then it parses the node. If it doesn't find any
pinctrl property then also it returns 0. and subsequently rreturns
handle to "struct pinctrl" for the device. Why is so?


Thanks,
Vaibhav
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
