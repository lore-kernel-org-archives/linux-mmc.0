From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v9] mmc: Export host capabilities to debugfs.
Date: Mon, 12 Mar 2018 16:22:30 +0200
Message-ID: <1520864550.10722.594.camel@linux.intel.com>
References: <1520829090-3567-1-git-send-email-harish_kandiga@mentor.com>
         <1520849262.10722.582.camel@linux.intel.com>
         <DM5PR04MB10854C79897A80023EF37F76FCD30@DM5PR04MB1085.namprd04.prod.outlook.com>
         <540fef96-aa2f-e6c3-467d-bc1d021dd55b@mentor.com>
         <DM5PR04MB10859F389CA2D1F2370C02CFFCD30@DM5PR04MB1085.namprd04.prod.outlook.com>
         <329d521d-1776-43ee-2f0e-e9690c29a693@mentor.com>
         <1520859807.10722.591.camel@linux.intel.com>
         <5e038945-a09c-5c64-2152-5d2783a249ec@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5e038945-a09c-5c64-2152-5d2783a249ec@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harish Jenny K N <harish_kandiga@mentor.com>, Avri Altman <Avri.Altman@wdc.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vladimir_Zapolskiy@mentor.com" <Vladimir_Zapolskiy@mentor.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 2018-03-12 at 19:04 +0530, Harish Jenny K N wrote:
> 
> On Monday 12 March 2018 06:33 PM, Andy Shevchenko wrote:
> > On Mon, 2018-03-12 at 18:00 +0530, Harish Jenny K N wrote:

> > > > > > > > +	for_each_set_bit(bit, (const unsigned long
> > > > > > > > *)&caps,
> > > > > > > > BITS_PER_LONG)
> > > > > > > > +	for_each_set_bit(bit, (const unsigned long
> > > > > > > > *)&caps2,
> > > > > > > > BITS_PER_LONG)
> > > > > > > 
> > > > > > > Explicit casting is not needed anymore in both cases.

> Sorry for I was not clear that the compilation error is for the
> following case
> > u32 caps = host->caps;
> > for_each_set_bit(bit, &caps, ARRAY_SIZE(mmc_host_capabilities))
> 
> 
> example: compilation for arm gives this error for the following lines:
> 
> drivers/mmc/core/debugfs.c: In function 'mmc_caps_show':
> ./include/linux/bitops.h:41:30: error: passing argument 1 of
> '_find_first_bit_le' from incompatible pointer type [-
> Werror=incompatible-pointer-types]
>   for ((bit) = find_first_bit((addr), (size));  \
>                               ^
> ./arch/arm/include/asm/bitops.h:202:50: note: in definition of macro
> 'find_first_bit'
>  #define find_first_bit(p,sz)  _find_first_bit_le(p,sz)
>                                                   ^
> drivers/mmc/core/debugfs.c:318:2: note: in expansion of macro
> 'for_each_set_bit'
>   for_each_set_bit(bit, &caps, ARRAY_SIZE(mmc_host_capabilities))
>   ^
> ./arch/arm/include/asm/bitops.h:165:12: note: expected 'const long
> unsigned int *' but argument is of type 'u32 * {aka unsigned int *}'
>  extern int _find_first_bit_le(const unsigned long *p, unsigned size);
>             ^

Are you sure you have caps defined as unsigned long?

Check your code, the explicit casting should gone. Otherwise you are
doing something wrong.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
