From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] mmc: add support for sdhci 4.0
Date: Wed, 4 Apr 2018 12:17:54 +0200
Message-ID: <CAPDyKFp_MYRTQmLcfkrZe+Ux9ZBZQgsAaZSzzLteVYS7sW0VCw@mail.gmail.com>
References: <1521534986-21907-1-git-send-email-zhang.chunyan@linaro.org> <CAG2=9p8y9bMsZ8u0gaumW9B7t3GEAhJ6ChQcE8qg_to_T7wwXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAG2=9p8y9bMsZ8u0gaumW9B7t3GEAhJ6ChQcE8qg_to_T7wwXg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Billows Wu <billows.wu@spreadtrum.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 4 April 2018 at 11:05, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
> Hi Ulf,
>
> Do you have some comments on this patch-set?

No objections from my side of the series, however I am relying on
Adrian's ack before I pick any of the patches.

Kind regards
Uffe

>
> Thanks,
> Chunyan
>
> On 20 March 2018 at 16:36, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
>> From the SD host controller version 4.0 on, SDHCI implementation either
>> is version 3 compatible or version 4 mode. This patch-set covers those
>> changes which are common for SDHCI 4.0 version, regardless of whether
>> they are used with SD or eMMC storage devices.
>>
>> Chunyan Zhang (3):
>>   mmc: sdhci: add sd host v4 mode
>>   mmc: sdhci: made changes for System Address register of SDMA
>>   mmc: sdhci: add ADMA2 64-bit addressing support for V4 mode
>>
>>  drivers/mmc/host/sdhci.c | 66 +++++++++++++++++++++++++++++++++++++-----------
>>  drivers/mmc/host/sdhci.h | 29 +++++++++++++++++----
>>  2 files changed, 75 insertions(+), 20 deletions(-)
>>
>> --
>> 2.7.4
>>
