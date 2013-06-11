From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/7] clk: divider: add flag to limit possible dividers
 to even numbers
Date: Tue, 11 Jun 2013 15:37:27 +0300
Message-ID: <CAHp75VeQOSns1nL7p+rU1TS2stPuWibFtN_K9mFvzuGW+3WqOA@mail.gmail.com>
References: <201306111328.52679.heiko@sntech.de>
	<201306111329.32749.heiko@sntech.de>
	<CAHp75VcaNkPeUQ=OPY5F7Mqb_cM87xh8A8wUxdCgnRtfjoqoHw@mail.gmail.com>
	<201306111406.14850.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:58795 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab3FKMh2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jun 2013 08:37:28 -0400
In-Reply-To: <201306111406.14850.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Linus Walleij <linus.walleij@linaro.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On Tue, Jun 11, 2013 at 3:06 PM, Heiko St=C3=BCbner <heiko@sntech.de> w=
rote:
> Am Dienstag, 11. Juni 2013, 13:51:56 schrieb Andy Shevchenko:
>> On Tue, Jun 11, 2013 at 2:29 PM, Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:

[]

>> > @@ -141,6 +149,8 @@ static bool _is_valid_div(struct clk_divider
>> > *divider, unsigned int div)
>> >
>> >                 return is_power_of_2(div);
>> >
>> >         if (divider->table)
>> >
>> >                 return _is_valid_table_div(divider->table, div);
>> >
>> > +       if (divider->flags & CLK_DIVIDER_EVEN && div !=3D 1 && (di=
v % 2) !=3D
>> > 0) +               return false;
>> >
>> >         return true;
>> >
>> >  }
>>
>> What if rewrite like
>>
>>  if (divider->flags & CLK_DIVIDER_EVEN =3D=3D 0)
>>  return true;
>>
>> return div < 2 || div % 2 =3D=3D 0;
>
> hmm, the current structure is of the form of testing for each feature=
 and
> doing a applicable action if the flag is set. So it also is extensibl=
e for
> future flags and checking for the absence of an attribute while the r=
est of
> the conditionals check for the presence also might make the code hard=
er to
> read.
>
> So for me the current variant somehow looks more intuitive.

This variant I think fits:

if (!(divider->flags & CLK_DIVIDER_EVEN))
  return div < 2 || div % 2 =3D=3D 0;

You check for feature and do accordingly.

--
With Best Regards,
Andy Shevchenko
