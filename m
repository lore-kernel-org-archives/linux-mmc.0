From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v6 00/14] mmc: Add support to Marvell Xenon SD Host Controller
Date: Fri, 10 Mar 2017 11:15:35 +0100
Message-ID: <87innhjv3s.fsf@free-electrons.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
        <87y3x0ajdv.fsf@free-electrons.com>
        <CAPDyKFqXQmuxWFZwcnTgQcKU_t5MKCtBj6s+tv5gzVWS11x0qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFqXQmuxWFZwcnTgQcKU_t5MKCtBj6s+tv5gzVWS11x0qA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
        (Ulf Hansson's message of "Mon, 20 Feb 2017 20:32:58 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, "linux-mmc@vger.kernel.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "linux-kernel@vger.kernel.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Kostya Porotchkin <kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hanna Hawa <hannah-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree@vger.kernel.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ryan
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,
 
 On lun., févr. 20 2017, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> On 20 February 2017 at 17:59, Gregory CLEMENT
> <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> Hi Ulf,
>>
>>  On mar., févr. 14 2017, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>>
>>> Hello,
>>>
>>> This the sixth version of the series adding support for the SDHCI
>>> Xenon controller. It can be currently found on the Armada 37xx and the
>>> Armada 7K/8K but will be also used in more Marvell SoC (and not only
>>> the mvebu ones actually).
>>>
>>> Most of the following changes had been discussed on the mailing list,
>>> except the new compatible string.
>>>
>>
>> I think that with this version we addressed all the concerns expressed
>> about the previous version. Do you think that you will be able to apply
>> this series for 4.11 or do you still see any issues?
>>
>> Thanks,
>>
>> Gregory
>
> We are in the merge window for v4.11, so new material is out of the
> question. I am preparing the PR to Linus as this very moment.

v4.11-rc1 was released last week, do you want that I rebase the series
ontop of it ?

On our side we made several tests of this version of the driver on
various hardware and everything works as expected. We only notice some
configuration to update for the dts on some board but it didn't impact
the driver itself.

Gregory


>
> Anyway, I will look into the series as soon as I can.
>
> Kind regards
> Uffe
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
