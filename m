From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v10] mmc: Export host capabilities to debugfs.
Date: Thu, 15 Mar 2018 12:26:15 +0200
Message-ID: <1521109575.10722.654.camel@linux.intel.com>
References: <1520917812-20047-1-git-send-email-harish_kandiga@mentor.com>
         <CAPDyKFo8jFwDO1E=tNSd4yTn3qtefzvHK0V70fcEqzB=SibrJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFo8jFwDO1E=tNSd4yTn3qtefzvHK0V70fcEqzB=SibrJA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Harish Jenny K N <harish_kandiga@mentor.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, avri.altman@wdc.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vladimir Zapolskiy <Vladimir_Zapolskiy@mentor.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, 2018-03-15 at 11:12 +0100, Ulf Hansson wrote:
> On 13 March 2018 at 06:10, Harish Jenny K N <harish_kandiga@mentor.com
> > wrote:
> > 

> Honestly, I don't like this, but maybe other people do, then I am fine
> with this approach.
> 
> If were to decide, I would just rather print the caps field in a
> hexadecimal bit form and leave the translation to the user.

A compromise would be to print both:

0xHHHHHHHH\n
Description of each enabled field, one per line


Another format would be:

Bit XX: Description of a field

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
