From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 0/4] mmc: sdhci-s3c: use the sdhci-pltfm.c and move the
 header file
Date: Fri, 09 Mar 2012 10:53:26 +0900
Message-ID: <4F596296.60103@samsung.com>
References: <4F55ABF0.1060801@samsung.com>
 <20120306130054.GA9890@sirena.org.uk> <201203061415.18836.heiko@sntech.de>
 <CAELcNGS6UynrJPRk1KtEJT3Rm6Jb5_scLm4KKca+dJ1ZYDOVbg@mail.gmail.com>
 <20120306163052.GX19635@opensource.wolfsonmicro.com>
 <4F56D003.5070406@samsung.com>
 <20120307184843.GW3107@opensource.wolfsonmicro.com>
 <4F584539.9080007@samsung.com>
 <20120308110105.GD3638@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20120308110105.GD3638@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCb?= =?ISO-8859-1?Q?ner?= <heiko@sntech.de>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, kgene kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 03/08/2012 08:01 PM, Mark Brown wrote:

> On Thu, Mar 08, 2012 at 02:35:53PM +0900, Jaehoon Chung wrote:
> 
>> So i think no problem that removed "#include <plat/regs-sdhci.h>". is it wrong?
>> Just touching the setup-gpio- files is problem?
> 
> It should be fine, like I say I didn't really read the patches in enough
> detail as the diffstat set off alarm bells.


If you have any opinions, let me know.
I believe that these patches can be maintain more efficiently for eMMC

Best Regards,
Jaehoon Chung
 
