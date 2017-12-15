From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 00/22] mmc: tmio: various fixes and cleanups
Date: Fri, 15 Dec 2017 14:34:26 +0100
Message-ID: <CAPDyKFopKm2psU19vGQfGL6WizXQA0vvzQubqsypvytbpRtyAA@mail.gmail.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFqE7Pg8fJFyOtihdRnma+dFQd3+YPWGn6pXbpzhpERK9Q@mail.gmail.com>
 <CAK7LNASQfsnQY6henk5RvAysQUh3=cPXV1GPNeWeXgBxZvadAw@mail.gmail.com> <20171215111225.ekrau5e27xknb3jf@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171215111225.ekrau5e27xknb3jf@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 15 December 2017 at 12:12, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> After 2, COMPILE_TEST will work correctly.
>>
>> Then, Wolfram mentioned we would need to include <linux/io.h> from tmio_mmc.h
>>
>> https://patchwork.kernel.org/patch/10074333/
>>
>>
>> I was waiting for a patch from him.
>
> Yes, I am sorry. I am currently swamped with I2C work, not so much time
> for SDHI. However, I did this patch now and pushed the branch out to see
> if buildbot is happy.

Great!

>
> Ulf, this patch then in deed should ideally be applied before 1-8 here.

Okay, once you post it to linux-mmc I will pick it up, and put it in front.

Kind regards
Uffe
