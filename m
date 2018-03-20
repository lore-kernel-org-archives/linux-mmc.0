From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/3] mmc: add support for sdhci 4.0
Date: Tue, 20 Mar 2018 11:18:28 +0200
Message-ID: <2291348c-7338-f335-88b8-10dc308e7f22@intel.com>
References: <1521534986-21907-1-git-send-email-zhang.chunyan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521534986-21907-1-git-send-email-zhang.chunyan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Billows Wu <billows.wu@spreadtrum.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 20/03/18 10:36, Chunyan Zhang wrote:
>>From the SD host controller version 4.0 on, SDHCI implementation either
> is version 3 compatible or version 4 mode. This patch-set covers those
> changes which are common for SDHCI 4.0 version, regardless of whether
> they are used with SD or eMMC storage devices.

Why use v4 mode?

What driver is using v4 mode?  Can you also post those changes?

Are you planning on adding UHS-II support also?

> 
> Chunyan Zhang (3):
>   mmc: sdhci: add sd host v4 mode
>   mmc: sdhci: made changes for System Address register of SDMA
>   mmc: sdhci: add ADMA2 64-bit addressing support for V4 mode
> 
>  drivers/mmc/host/sdhci.c | 66 +++++++++++++++++++++++++++++++++++++-----------
>  drivers/mmc/host/sdhci.h | 29 +++++++++++++++++----
>  2 files changed, 75 insertions(+), 20 deletions(-)
> 
