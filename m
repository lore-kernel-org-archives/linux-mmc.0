From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v9] mmc: Export host capabilities to debugfs.
Date: Mon, 12 Mar 2018 16:27:17 +0200
Message-ID: <1520864837.10722.596.camel@linux.intel.com>
References: <1520829090-3567-1-git-send-email-harish_kandiga@mentor.com>
         <1520849262.10722.582.camel@linux.intel.com>
         <DM5PR04MB10854C79897A80023EF37F76FCD30@DM5PR04MB1085.namprd04.prod.outlook.com>
         <540fef96-aa2f-e6c3-467d-bc1d021dd55b@mentor.com>
         <DM5PR04MB10859F389CA2D1F2370C02CFFCD30@DM5PR04MB1085.namprd04.prod.outlook.com>
         <329d521d-1776-43ee-2f0e-e9690c29a693@mentor.com>
         <1520859807.10722.591.camel@linux.intel.com>
         <5e038945-a09c-5c64-2152-5d2783a249ec@mentor.com>
         <1520864550.10722.594.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520864550.10722.594.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harish Jenny K N <harish_kandiga@mentor.com>, Avri Altman <Avri.Altman@wdc.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vladimir_Zapolskiy@mentor.com" <Vladimir_Zapolskiy@mentor.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 2018-03-12 at 16:22 +0200, Andy Shevchenko wrote:
> On Mon, 2018-03-12 at 19:04 +0530, Harish Jenny K N wrote:
> > 
> > On Monday 12 March 2018 06:33 PM, Andy Shevchenko wrote:
> > > On Mon, 2018-03-12 at 18:00 +0530, Harish Jenny K N wrote:
> > > > > > > > > +	for_each_set_bit(bit, (const unsigned long
> > > > > > > > > *)&caps,
> > > > > > > > > BITS_PER_LONG)
> > > > > > > > > +	for_each_set_bit(bit, (const unsigned long
> > > > > > > > > *)&caps2,
> > > > > > > > > BITS_PER_LONG)
> > > > > > > > 
> > > > > > > > Explicit casting is not needed anymore in both cases.
> > Sorry for I was not clear that the compilation error is for the
> > following case

> > > u32 caps = host->caps;

This is wrong! I told you that and you seems changed at least in v9.
What are you doing locally?

> > > for_each_set_bit(bit, &caps, ARRAY_SIZE(mmc_host_capabilities))
> > 

> Are you sure you have caps defined as unsigned long?
> 
> Check your code, the explicit casting should gone. Otherwise you are
> doing something wrong.

See above.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
