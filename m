From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 2/2] mmc: host: s3cmci: allow probing from device tree
Date: Fri, 31 Mar 2017 13:11:59 +0200
Message-ID: <CAPDyKFquGSgK7tkYDpkJM7C7JChZMqvmHoJyiLE9_ZG4CGBOSw@mail.gmail.com>
References: <1489799633-29278-1-git-send-email-sergio.prado@e-labworks.com>
 <1489799633-29278-3-git-send-email-sergio.prado@e-labworks.com> <CAK8P3a2emCf=KtpCJMOaJnr89Gi+rCi0eun_vjb1wiYB=JR6jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK8P3a2emCf=KtpCJMOaJnr89Gi+rCi0eun_vjb1wiYB=JR6jg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sergio Prado <sergio.prado-1e4yhPs3/ABSwrhanM7KvQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 31 March 2017 at 09:25, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Sat, Mar 18, 2017 at 2:13 AM, Sergio Prado
> <sergio.prado-1e4yhPs3/ABSwrhanM7KvQ@public.gmane.org> wrote:
>
>>
>> +static const struct of_device_id s3cmci_dt_match[] = {
>> +       {
>> +               .compatible = "samsung,s3c2410-sdi",
>> +               .data = (void *)0,
>> +       },
>> +       {
>> +               .compatible = "samsung,s3c2412-sdi",
>> +               .data = (void *)1,
>> +       },
>> +       {
>> +               .compatible = "samsung,s3c2440-sdi",
>> +               .data = (void *)1,
>> +       },
>> +       { /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
>> +
>
> The names don't match:
>
> In file included from /git/arm-soc/drivers/mmc/host/s3cmci.c:14:0:
> /git/arm-soc/drivers/mmc/host/s3cmci.c:1844:25: error:
> 'sdhci_s3c_dt_match' undeclared here (not in a function); did you mean
> 's3cmci_dt_match'?
>  MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
>                          ^
> /git/arm-soc/include/linux/module.h:212:21: note: in definition of
> macro 'MODULE_DEVICE_TABLE'
>  extern const typeof(name) __mod_##type##__##name##_device_table  \
>                      ^~~~
> /git/arm-soc/include/linux/module.h:212:27: error:
> '__mod_of__sdhci_s3c_dt_match_device_table' aliased to undefined
> symbol 'sdhci_s3c_dt_match'
>  extern const typeof(name) __mod_##type##__##name##_device_table  \
>                            ^
> /git/arm-soc/drivers/mmc/host/s3cmci.c:1844:1: note: in expansion of
> macro 'MODULE_DEVICE_TABLE'
>  MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
>  ^~~~~~~~~~~~~~~~~~~
> /git/arm-soc/scripts/Makefile.build:314: recipe for target
> 'drivers/mmc/host/s3cmci.o' failed
>
> Can you send a fix?

Never mind, I am dropping the patches from my next branch as those
clearly haven't been built/tested by Sergio properly. It's better that
he re-spins them.

Arnd, thanks for reporting and even fixing some of the problems!

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
