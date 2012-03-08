From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 0/4] mmc: sdhci-s3c: use the sdhci-pltfm.c and move the
 header file
Date: Thu, 08 Mar 2012 14:35:53 +0900
Message-ID: <4F584539.9080007@samsung.com>
References: <4F55ABF0.1060801@samsung.com>
 <20120306130054.GA9890@sirena.org.uk> <201203061415.18836.heiko@sntech.de>
 <CAELcNGS6UynrJPRk1KtEJT3Rm6Jb5_scLm4KKca+dJ1ZYDOVbg@mail.gmail.com>
 <20120306163052.GX19635@opensource.wolfsonmicro.com>
 <4F56D003.5070406@samsung.com>
 <20120307184843.GW3107@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20120307184843.GW3107@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCb?= =?ISO-8859-1?Q?ner?= <heiko@sntech.de>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, kgene kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Mark.

On 03/08/2012 03:48 AM, Mark Brown wrote:

> On Wed, Mar 07, 2012 at 12:03:31PM +0900, Jaehoon Chung wrote:
>> On 03/07/2012 01:30 AM, Mark Brown wrote:
> 
>>> The same IP is present and used with the same driver on other Samsung
>>> SoCs.
> 
>> I know that used with the same driver on other Samsung-SoCs(S3C64XX/S3C24XX..etc)
>> I just only used the interface in sdhci-pltfm.c. Nothing difference..
>> Why do you think that will break the other SoC?
> 
>> Header file(/plat/regs-sdhci.h) also is only used in sdhci-s3c.c.
>> And the least portion is moved into /linux/mmc/. 
>> Then included "linux/mmc/sdhci-s3c.h" in plat/sdhci.h.
> 
>> What's difference? 
>> If you can explain the more detail, i can understand.
>> But sorry, now i didn't accept your opinion.
> 
> To be honest I didn't read the series, the diffstat looks so obviously
> problematic as you're touching the setup-gpio- files for only a subset
> of Samsung architectures - there's been quite regular issues with
> updates for newer SoCs breaking support for s3c64xx.

Is there problem that move the s3c_sdhci_platdata struct into linux/mmc/?
In setup-gpio- files, you can see that included regs-sdhci.h.
But defined macro in regs-sdhci.h only used in sdhci-s3c.c.
So i think no problem that removed "#include <plat/regs-sdhci.h>". is it wrong?
Just touching the setup-gpio- files is problem?
If i have moved the defined as "extern", it's problem.
But i didn't move them.

For example, When i want to add the second capability for sdhci-s3c,
need to change code in samsung-soc and mmc stack.
if one of both didn't be merged, it's conflict or should not be work fine.
(Now, in mmc-next tree, mmc for Samsung-SoC didn't work fine during long time.)
There are reason that move the s3c_sdhci_platdata into linux/mmc/.
Then we can work at only mmc-next repository for sdhci-s3c.c.

> 
> I also notice that this will conflict with the series I've previously
> posted for runtime PM support which would push us even further back from
> being able to use the lower power WFI modes in mainline :(  Though
> hopefully that'll be easier to fix.

Right, it should be conflicted with your patch. but it will be fixed.
It's not big problem.

Thanks for your opinion.

Best Regards,
Jaehoon Chung
