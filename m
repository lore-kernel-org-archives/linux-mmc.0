From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [ulf.hansson-mmc:next 58/67] drivers/mmc/core/slot-gpio.c:311:2:
 error: too many arguments to function 'devm_gpiod_get_index'
Date: Mon, 1 Sep 2014 15:13:55 +0200
Message-ID: <CACRpkdbzirqB9P_y11B93Deu+jbpCxr=bLOxckRZ0CP6kPs3=Q@mail.gmail.com>
References: <540468b7.GQof+4S/A1NorfoF%fengguang.wu@intel.com>
	<CAPDyKFpbFEAjWYN=jc0U+Ph5vnyaJWy46Za+56_hyEPDVLbfcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:46057 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702AbaIANN4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Sep 2014 09:13:56 -0400
Received: by mail-ob0-f170.google.com with SMTP id m8so3828332obr.15
        for <linux-mmc@vger.kernel.org>; Mon, 01 Sep 2014 06:13:55 -0700 (PDT)
In-Reply-To: <CAPDyKFpbFEAjWYN=jc0U+Ph5vnyaJWy46Za+56_hyEPDVLbfcQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>, kbuild test robot <fengguang.wu@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>

On Mon, Sep 1, 2014 at 3:05 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 1 September 2014 14:38, kbuild test robot <fengguang.wu@intel.com> wrote:
>> tree:   git://git.linaro.org/people/ulf.hansson/mmc next
>> head:   2969aa939a41fa8e50d3e8aa46137bfc4a35e05c
>> commit: 84e445bbda19b801c60d7414add19c1f3ebc4d26 [58/67] mmc: slot-gpio: switch to use flags when getting GPIO
>> config: x86_64-rhel (attached as .config)
>>
>> All error/warnings:
>>
>>    drivers/mmc/core/slot-gpio.c: In function 'mmc_gpiod_request_cd':
>>>> drivers/mmc/core/slot-gpio.c:311:2: error: too many arguments to function 'devm_gpiod_get_index'
>>      desc = devm_gpiod_get_index(host->parent, con_id, idx, GPIOD_IN);
>>      ^
>>    In file included from drivers/mmc/core/slot-gpio.c:13:0:
>>    include/linux/gpio/consumer.h:166:32: note: declared here
>>     struct gpio_desc *__must_check devm_gpiod_get_index(struct device *dev,
>>                                    ^
>>
>> vim +/devm_gpiod_get_index +311 drivers/mmc/core/slot-gpio.c
>>
>>    305
>>    306          ctx = host->slot.handler_priv;
>>    307
>>    308          if (!con_id)
>>    309                  con_id = ctx->cd_label;
>>    310
>>  > 311          desc = devm_gpiod_get_index(host->parent, con_id, idx, GPIOD_IN);
>>    312          if (IS_ERR(desc))
>>    313                  return PTR_ERR(desc);
>>    314
>>
>> ---
>> 0-DAY kernel build testing backend              Open Source Technology Center
>> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
>
> Linus,
>
> I will drop the GPIO desc patches again from my mmc tree. We need
> another round to sort out the decencies to GPIOLIB.

Yeah this is due to the way the vararg hacks for the new flags-enabled
descriptor API is done only when GPIOLIB is compiled in.
Oh well, I'll funnel another fix.

Yours,
Linus Walleij
