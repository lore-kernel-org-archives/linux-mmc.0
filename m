From: Seraphime Kirkovski <kirkseraph@gmail.com>
Subject: 4.13 on thinkpad x220: oops when writing to SD card
Date: Thu, 7 Sep 2017 12:47:49 +0200
Message-ID: <20170907104749.p2bk6lejj7tvupor@macchiaveli>
References: <20170905194739.GA31241@amd>
 <8f0f7310-ea4d-a200-75fd-23509947fb38@rock-chips.com>
 <6689241f-a4d8-7a3e-9f0b-482b034e5710@intel.com>
 <CAPDyKFqXaDFrJH1-YSSCx0xPXfMN99AM_Wu_sWQf5A6bw+zjdQ@mail.gmail.com>
 <f36b194b-f74b-20de-3122-0243774b74c2@intel.com>
Reply-To: f36b194b-f74b-20de-3122-0243774b74c2@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f36b194b-f74b-20de-3122-0243774b74c2@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Pavel Machek <pavel@ucw.cz>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

> blk_init_allocated_queue() allocates 1 request for flush and 
> 4 requests
> for a memory pool.  The memory pool requests only get used under memory
> pressure.  That is why the error doesn't come up straight away.
This seems correct, I can "trivially" trigger the bug with
a while-malloc loop + firefox.

> Reported-by: Seraphime Kirkovski <kirkseraph@gmail.com>
> Fixes: 304419d8a7e92 ("mmc: core: Allocate per-request data using the block layer core")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

As I said, this fixes it for me, you can add

Tested-By: Seraphime Kirkovski <kirkseraph@gmail.com>

Although I'm not sure this covers the same bug Pavel encountered.
My kernel doesn't panic, it makes KASAN scream + #GP eventually followed 
by a lockup.

Anyway, thanks for the fix,
Seraphime
