From: Andrea Adami <andrea.adami@gmail.com>
Subject: Re: [PATCH v3 3/9] mfd: tmio.h: support partition parser types
Date: Sat, 3 Jun 2017 23:40:39 +0200
Message-ID: <CAAQYJAs_EMHUUBObbhOQ6gk4rh=MsO4d2qi9KpDdhMiHMrsyTA@mail.gmail.com>
References: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
 <1496270458-6479-4-git-send-email-andrea.adami@gmail.com> <20170601143535.s6ovk5ts3cbehw3f@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33657 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751162AbdFCVkl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 3 Jun 2017 17:40:41 -0400
In-Reply-To: <20170601143535.s6ovk5ts3cbehw3f@dell>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jun 1, 2017 at 4:35 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 01 Jun 2017, Andrea Adami wrote:
>
>> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
>> ---
>>  include/linux/mfd/tmio.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
>> index a1520d8..23bb069 100644
>> --- a/include/linux/mfd/tmio.h
>> +++ b/include/linux/mfd/tmio.h
>> @@ -139,6 +139,7 @@ struct tmio_nand_data {
>>       struct nand_bbt_descr   *badblock_pattern;
>>       struct mtd_partition    *partition;
>>       unsigned int            num_partitions;
>> +     const char *const       *types; /* names of parsers to use if any =
*/
>
> Please use kerneldoc instead.
>
Thanks for the review.

tmio.h is not consistent and uses inline comments so I did not change the s=
tyle.
Another round of patches will be necessary to sanitize the comments,
out of the scope of this little patchset.

Cheers
Andrea

>>  };
>>
>>  #define FBIO_TMIO_ACC_WRITE  0x7C639300
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
