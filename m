From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: 4.14-rc2 on thinkpad x220: out of memory when inserting mmc card
Date: Tue, 3 Oct 2017 09:30:18 +0300
Message-ID: <7b423dc8-00aa-9cde-3557-8c72863001fd@intel.com>
References: <20170905194739.GA31241@amd> <20171001093704.GA12626@amd>
 <20171001102647.GA23908@amd>
 <201710011957.ICF15708.OOLOHFSQMFFVJt@I-love.SAKURA.ne.jp>
 <CACRpkdYirC+rh_KALgVqKZMjq2DgbW4oi9MJkmrzwn+1O+94-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <CACRpkdYirC+rh_KALgVqKZMjq2DgbW4oi9MJkmrzwn+1O+94-g@mail.gmail.com>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: Linus Walleij <linus.walleij@linaro.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Pavel Machek <pavel@ucw.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-mm@kvack.org
List-Id: linux-mmc@vger.kernel.org

On 02/10/17 17:09, Linus Walleij wrote:
> On Sun, Oct 1, 2017 at 12:57 PM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> 
>>>> I inserted u-SD card, only to realize that it is not detected as it
>>>> should be. And dmesg indeed reveals:
>>>
>>> Tetsuo asked me to report this to linux-mm.
>>>
>>> But 2^4 is 16 pages, IIRC that can't be expected to work reliably, and
>>> thus this sounds like MMC bug, not mm bug.
> 
> 
> I'm not sure I fully understand this error message:
> "worker/2:1: page allocation failure: order:4"
> 
> What I guess from context is that the mmc_init_request()
> call is failing to allocate 16 pages, meaning for 4K pages
> 64KB which is the typical bounce buffer.
> 
> This is what the code has always allocated as bounce buffer,
> but it used to happen upfront, when probing the MMC block layer,
> rather than when allocating the requests.

That is not exactly right.  As I already wrote, the memory allocation used
to be optional but became mandatory with:

  commit 304419d8a7e9204c5d19b704467b814df8c8f5b1
  Author: Linus Walleij <linus.walleij@linaro.org>
  Date:   Thu May 18 11:29:32 2017 +0200

      mmc: core: Allocate per-request data using the block layer core

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
