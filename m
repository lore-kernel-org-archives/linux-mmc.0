From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/5] MMC: mmci: Add generic Device Tree bindings to mmci
 core code
Date: Thu, 15 Mar 2012 15:25:05 +0000
Message-ID: <4F6209D1.9070805@linaro.org>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org> <1331734803-17954-4-git-send-email-lee.jones@linaro.org> <CAFEEs1mQr4hDC6RuvchfWe7HNq67Eh2bPtwyWN-tukw32-V0rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59277 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965263Ab2COPZI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 11:25:08 -0400
Received: by bkcik5 with SMTP id ik5so2206829bkc.19
        for <linux-mmc@vger.kernel.org>; Thu, 15 Mar 2012 08:25:07 -0700 (PDT)
In-Reply-To: <CAFEEs1mQr4hDC6RuvchfWe7HNq67Eh2bPtwyWN-tukw32-V0rg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, arnd@arndb.de, niklas.hernaeus@linaro.org, linux-mmc@vger.kernel.org

On 15/03/12 15:12, Per Forlin wrote:
> On Wed, Mar 14, 2012 at 3:20 PM, Lee Jones <lee.jones@linaro.org> wro=
te:
>> This adds the necessary bindings for collection of shared
>> attributes used in the mmci driver.
>>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>  drivers/mmc/host/mmci.c |   43 ++++++++++++++++++++++++++++++++++++=
+++++++
>>  1 files changed, 43 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 23b41a5..9132ca8 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -30,6 +30,7 @@
>>  #include <linux/dma-mapping.h>
>>  #include <linux/amba/mmci.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/of_gpio.h>
>>
>>  #include <asm/div64.h>
>>  #include <asm/io.h>
>> @@ -1056,11 +1057,47 @@ static const struct mmc_host_ops mmci_ops =3D=
 {
>>        .get_cd         =3D mmci_get_cd,
>>  };
>>
>> +#ifdef CONFIG_OF
>> +static void mmci_dt_populate_generic_pdata(struct device_node *np,
>> +                                       struct mmci_platform_data *p=
data)
>> +{
>> +       const void *prop;
>> +       int len;
>> +
>> +       of_property_read_u32(np, "wp-gpios", &pdata->gpio_wp);
>> +       if (!pdata->gpio_wp)
>> +               pdata->gpio_wp =3D -1;
>> +
>> +       of_property_read_u32(np, "cd-gpios", &pdata->gpio_cd);
>> +       if (!pdata->gpio_cd)
>> +               pdata->gpio_cd =3D -1;
>> +
>> +       if (of_get_property(np, "cd-invert", NULL))
>> +               pdata->cd_invert =3D true;
>> +       else
>> +               pdata->cd_invert =3D false;
>> +
>> +       of_property_read_u32(np, "clock_frequency", &pdata->f_max);
>> +       if (!pdata->f_max)
>> +               pr_warning("%s has no 'clock_frequency' property\n",=
 np->full_name);
>> +
>> +       if (of_get_property(np, "mmc_cap_4_bit_data", NULL))
> I have no previous experience with DT. Could you please bring some
> light on this.
> Is it really necessary to represent each bit in the CAP with a string=
?

No, you can use a straight integer in the DT blob, but this makes it
much easier to read.

> To add CAP_ERASE for instance I need to change the code here and
> update the DT, right?

That's right, but no MMCI user makes use of it, so it would just be
unnecessary/unused code clogging up the core driver.

Kind regards,
Lee

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
