From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: Warnings for invalid VDD (sdhci-s3c)
Date: Thu, 24 Mar 2016 16:24:49 +0800
Message-ID: <20160324162449.29c9cf78@xhacker>
References: <CAJKOXPcGDnPm-Ykh6wHqV1YxfTaov5E8iVqBoBn4OJc7BnhgEQ@mail.gmail.com>
	<20160324155840.50474b98@xhacker>	<56F3A0B7.4050509@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <56F3A0B7.4050509@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, ludovic.desroches@atmel.com, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, 24 Mar 2016 17:09:27 +0900 Jaehoon Chung wrote:

> Hi,
> 
> On 03/24/2016 04:58 PM, Jisheng Zhang wrote:
> > Hi,
> > 
> > On Thu, 24 Mar 2016 16:28:56 +0900 Krzysztof Kozlowski wrote:
> >   
> >> Hi,
> >>
> >> After 918f4cbd4340 ("mmc: sdhci: restore behavior when setting VDD via
> >> external regulator") On Trats2 board I see warnings for invalid VDD
> >> value (2.8V):
> >>
> >> [    3.119656] ------------[ cut here ]------------
> >> [    3.119666] WARNING: CPU: 3 PID: 90 at
> >> ../drivers/mmc/host/sdhci.c:1234 sdhci_do_set_ios+0x4cc/0x5e0
> >> [    3.119669] mmc0: Invalid vdd 0x10  
> > 
> > Per my understanding, the wrong vdd indicates a wrong ocr, what's the voltage of
> > this host's vmmc regulator?  
> 
> As i know, it's fixed-voltage with gpio on trats2. It's 2.8V.
> I didn't check this entirely..need to check ocr value.
> 

I may know the reason. the vmmc is 2.8v, then mmc_regulator_get_supply() convert
the value to a ocr as 0x10. The key here is that the 2.8v is invalid in SDHCI
case and isn't accepted by current sdhci driver.

I dunno the elegant solution to handle this case, let's wait for sdhci maintainers
idea.

Thanks,
Jisheng
