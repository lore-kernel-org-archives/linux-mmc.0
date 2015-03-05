From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH RESEND 0/4] Add support for IPROC SDHCI controller
Date: Thu, 05 Mar 2015 11:57:52 -0800
Message-ID: <54F8B540.6000301@gmail.com>
References: <sbranden@broadcom.com>	<1425571148-5876-1-git-send-email-sbranden@broadcom.com> <CAPDyKFpH=dYzku9KNVFPtqc73+TptLFGZHNkFZ3Q4=suLOwFfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpH=dYzku9KNVFPtqc73+TptLFGZHNkFZ3Q4=suLOwFfQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, Chris Ball <chris@printf.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Ray Jui <rjui@broadcom.com>, Jonathan Richardson <jonathar@broadcom.com>, Corneliu Doban <cdoban@broadcom.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazao <anatol@google.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 05/03/15 08:16, Ulf Hansson wrote:
> On 5 March 2015 at 16:59, Scott Branden <sbranden@broadcom.com> wrote:
>> This series of patchsets contains the IPROC SDHCI driver used
>> in a series of Broadcom SoCs
>> Quirks are also added to support this controller.
>>
>> Corneliu Doban (1):
>>   mmc: sdhci: do not set AUTO_CMD12 for multi-block CMD53
>>
>> Scott Branden (3):
>>   mmc: sdhci: add quirk for ACMD23 broken
>>   mmc: sdhci-iproc: add IPROC SDHCI driver
>>   mmc: sdhci-iproc: add device tree bindings
>>
>>  .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |  23 ++
>>  drivers/mmc/host/Kconfig                           |  14 ++
>>  drivers/mmc/host/Makefile                          |   1 +
>>  drivers/mmc/host/sdhci-iproc.c                     | 241 +++++++++++++++++++++
>>  drivers/mmc/host/sdhci.c                           |   7 +-
>>  include/linux/mmc/sdhci.h                          |   2 +
>>  6 files changed, 286 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
>>  create mode 100644 drivers/mmc/host/sdhci-iproc.c
>>
>> --
>> 2.2.2
>>
> 
> Applied, thanks!
> 
> Actually, I needed to re-solve some conflicts and I switched to order
> of patch3 and patch4, to avoid checkpatch warnings. Just so you know.

Thanks, patch 4 dropped from devicetree/next.
-- 
Florian
