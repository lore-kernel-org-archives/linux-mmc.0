From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 01/14] Documentation: dt/bindings: Document pinctrl-ingenic
Date: Thu, 23 Feb 2017 10:59:14 +0100
Message-ID: <CACRpkdYiA157afJW2hnJzRgWOT02pCuU5rPCdHC-G5qb-FrxQA@mail.gmail.com>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net> <20170125185207.23902-2-paul@crapouillou.net>
 <20170130203617.hpljtcmzava3rq2n@rob-hp-laptop> <12dc62a7255bd453ff4e5e89f93ebc58@mail.crapouillou.net>
 <CACRpkdbAgy4sh6NT5DdQD6EQtOZEwevohEA6OGRcVz98yqS52Q@mail.gmail.com>
 <fd3c507484a9ee34a08c9f92e60624db@mail.crapouillou.net> <CACRpkdbAA33FFrMgx-eZPmpBBfQ_hF+=dSu0hANVthdbadicDg@mail.gmail.com>
 <f19fea79c2616455f5f08070923428cc@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:35311 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdBWJ7Q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Feb 2017 04:59:16 -0500
Received: by mail-it0-f41.google.com with SMTP id 203so169135396ith.0
        for <linux-mmc@vger.kernel.org>; Thu, 23 Feb 2017 01:59:16 -0800 (PST)
In-Reply-To: <f19fea79c2616455f5f08070923428cc@crapouillou.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, linux-pwm@vger.ker

On Tue, Feb 21, 2017 at 12:20 PM, Paul Cercueil <paul@crapouillou.net> wrot=
e:
> Le 2017-02-20 14:56, Linus Walleij a =C3=A9crit :
>>
>> On Thu, Feb 9, 2017 at 6:28 PM, Paul Cercueil <paul@crapouillou.net>
>> wrote:
>>
>>> I was thinking that instead of having one pinctrl-ingenic instance
>>> covering
>>> 0x600 of register space, and 6 instances of gpio-ingenic having 0x100
>>> each,
>>> I could just have 6 instances of pinctrl-ingenic, each one with an
>>> instance
>>> of gpio-ingenic declared as a sub-node, each handling just 0x100 of
>>> memory
>>> space.
>>
>>
>> My head is spinning,  but I think I get it. What is wrong with the
>> solution
>> I proposed with one pin control instance covering the whole 0x600 and wi=
th
>> 6
>> subnodes of GPIO?
>>
>> The GPIO nodes do not even have to have an address range associated with
>> them you know, that can be distributed out with regmap code accessing
>> the parent regmap.
>
>
> OK, but then each GPIO chip 'X' still need to know its offset in the
> register
> area, which is (pinctrl_base + X * 0x100).
> What's the best way to pass that info to the driver? (I assume it's not w=
ith
> a custom DT binding...).

I do not really understand what driver you are referring to.

If the pin controller node is overarching and spawning children for
the gpiochips, you use the design pattern from MFD to pass data
from parents to children, e.g.:

#include <linux/regmap.h>

pinctrl driver:
     struct regmap_config mapconf =3D {
                .reg_bits =3D 32,
                .val_bits =3D 32,
                .reg_stride =3D 4,
     };
    struct regmap *map;

    map =3D regmap_init_mmio(dev, base, &mapconf);
    if (IS_ERR(map))
          ....
    dev_set_drvdata(dev, map);
    of_populate_children(dev,)..
    (can also use platform_device_add_data() or "simple-bus" etc)

gpio subdrivers:
     struct regmap *map;

     map =3D dev_get_drvdata(dev->parent);

There are examples of drivers passing more complex things to
their children than a regmap, just put some struct in a <linux/*/*.h>
file and pass it with drvdata as per above.

PS i2c_set_drvdata(), platform_set_drvdata() are just aliases
for dev_set_drvdata().

Yours,
Linus Walleij
