From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: Re: [PATCH 0/3] mmc: add support for sdhci 4.0
Date: Wed, 21 Mar 2018 17:58:50 +0800
Message-ID: <CAG2=9p94+qUfw_8Rj+1cfc9oatvpWm+kt98VHJro96ZdUyrnPg@mail.gmail.com>
References: <1521534986-21907-1-git-send-email-zhang.chunyan@linaro.org> <2291348c-7338-f335-88b8-10dc308e7f22@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2291348c-7338-f335-88b8-10dc308e7f22@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Billows Wu <billows.wu@spreadtrum.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

On 20 March 2018 at 17:18, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 20/03/18 10:36, Chunyan Zhang wrote:
>>>From the SD host controller version 4.0 on, SDHCI implementation either
>> is version 3 compatible or version 4 mode. This patch-set covers those
>> changes which are common for SDHCI 4.0 version, regardless of whether
>> they are used with SD or eMMC storage devices.
>
> Why use v4 mode?
>
> What driver is using v4 mode?  Can you also post those changes?

I believe there must be some out-of-tree driver using v4 mode, at
least Spreadtrum's sd host controller is, as I know, and they're
planning on upstreaming that driver.

Those changes which this patch-set covers are just in the subject of
each patch in this series :)

>
> Are you planning on adding UHS-II support also?

Yes, that's my preliminary plan.

BTW, this patchset should have prefix "RFC", I just forgot to add that.

Thanks for your comments,
Chunyan

>
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
>
