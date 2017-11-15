From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 00/12 v5] Multiqueue for MMC/SD
Date: Wed, 15 Nov 2017 15:50:12 +0200
Message-ID: <6545b733-e28d-6a57-ae5b-293c1938b7c2@intel.com>
References: <20171110100143.12256-1-linus.walleij@linaro.org>
 <CAPDyKFpaeRpqea6dy+3nxEtYwBTLUTYoRsYrRHrvfmNX_afxwg@mail.gmail.com>
 <CACRpkdZ-_1vFLLUcRTXWPYdDomP8Pen9wBwEMUGgr2cd_y3eBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZ-_1vFLLUcRTXWPYdDomP8Pen9wBwEMUGgr2cd_y3eBQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>, Avri Altman <Avri.Altman@sandisk.com>
List-Id: linux-mmc@vger.kernel.org

On 14/11/17 23:17, Linus Walleij wrote:
> We have the following risk factors:
> 
> - Observed performance degradation of 1% (on x86 SDHI I guess)
> - The kernel crashes if SD card is removed (both patch sets)

I haven't been able to reproduce that.  Do you have more information?
