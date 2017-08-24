From: Andrea Adami <andrea.adami@gmail.com>
Subject: Re: [PATCH v5 0/9] mtd: sharpslpart partition parser
Date: Thu, 24 Aug 2017 11:33:02 +0200
Message-ID: <CAAQYJAv8bNrxJ_ESgC0fOAdry7i5mstzgQ3P74q1D=C-xsJprg@mail.gmail.com>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
 <20170821221339.70cfcfb7@bbrezillon> <87pobmoz8n.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87pobmoz8n.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-mtd@lists.infradead.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Richard Weinberger <richard@nod.at>, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>, linux-arm-kernel@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Lee Jones <lee.jones@linaro.org>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 23, 2017 at 9:33 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Boris Brezillon <boris.brezillon@free-electrons.com> writes:
>
>> Le Mon, 14 Aug 2017 22:48:31 +0200,
>>> Andrea Adami (9):
>>>   mtd: sharpslpart: Add sharpslpart partition parser
>>>   mtd: nand: sharpsl: Add partition parsers platform data
>>>   mfd: tmio: Add partition parsers platform data
>>>   mtd: nand: sharpsl: Register partitions using the parsers
>>>   mtd: nand: tmio: Register partitions using the parsers
>>
>> Applied patches 2, to 5 to nand/next.
>>>   ARM: pxa/corgi: Remove hardcoded partitioning, use sharpslpart parser
>>>   ARM: pxa/tosa: Remove hardcoded partitioning, use sharpslpart parser
>>>   ARM: pxa/spitz: Remove hardcoded partitioning, use sharpslpart parser
>>>   ARM: pxa/poodle: Remove hardcoded partitioning, use sharpslpart parser
>
> I'm quite happy with patches 6 to 9 except for the subject title length.
>

Argh, this time I got it totally wrong with the titles of the patches!
Sorry for the eye-sore.

> Andrea, if you give me an idea of change, I'll modify the titles myself before
> applying, no need to resend a serie.
>
> For example, you could propose :
> ARM: pxa: corgi: use sharpslpart parser instead of hardcoded one
>
>
> Then I'll take them into pxa/for-next if there are no objections.
>
> Cheers.
>
> --
> Robert

Robert,

your suggestion is fine for me.
Please use " ARM: pxa: MACHINE: use sharpslpart parser instead of hardcoded one"

Thanks!
Andrea
