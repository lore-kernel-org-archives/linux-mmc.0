From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: Re: [RFC PATCH 5/7] mmc: sdhci: host: add new f_sdh30
Date: Fri, 20 Jun 2014 18:29:51 +0800
Message-ID: <CAOEd-H3Q+Men=MKoLrBK_faAXw3b6M5eJ+FxSSPq3idyAK=eGw@mail.gmail.com>
References: <1403256928-11359-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<1403256928-11359-6-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<5136245.WRbqGRMMHn@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f49.google.com ([209.85.213.49]:42649 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965068AbaFTK3v (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jun 2014 06:29:51 -0400
Received: by mail-yh0-f49.google.com with SMTP id f73so2646103yha.8
        for <linux-mmc@vger.kernel.org>; Fri, 20 Jun 2014 03:29:51 -0700 (PDT)
In-Reply-To: <5136245.WRbqGRMMHn@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: chris@printf.net, linux-mmc@vger.kernel.org, anton@enomsg.org, linuxppc-dev@lists.ozlabs.org, patches@linaro.org, Andy Green <andy.green@linaro.org>, Vincent Yang <Vincent.Yang@tw.fujitsu.com>

Hi Arnd,
Thanks a lot for your review.
I will update it in next version.


Best regards,
Vincent Yang

2014-06-20 18:00 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Friday 20 June 2014 17:35:26 Vincent Yang wrote:
>> +Required properties:
>> +- compatible: "fujitsu,f_sdh30"
>> +
>> +Optional properties:
>> +- gpios: Specify gpios for controlling signal level
>> +- clocks: Specify clocks used by SDHCI controller
>> +- clock-names: Specify the clock-names to be used
>
> If you want to use "clock-names", you have to specify the exact names
> of the clock input signals used by your device, and the order in which
> they are listed.
>
> For both the clocks and the gpios, you have to specify how many signals
> there are, and ideally describe what they are used for. In case of a
> gpio controlling the signal level, it may be better to model this
> as a gpio-regulator device, depending on how exactly it is used.
>
> When posting a DT binding document, please always add
> devicetree@vger.kernel.org to Cc.
>
>         Arnd
