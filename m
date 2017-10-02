From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: 4.14-rc2 on thinkpad x220: out of memory when inserting mmc card
Date: Mon, 2 Oct 2017 14:06:03 +0200
Message-ID: <CACRpkdbatrt0Uxf8653iiV-OKkgcc0Ziog_L4oDVTJVNqtNN0Q@mail.gmail.com>
References: <20170905194739.GA31241@amd> <20171001093704.GA12626@amd>
 <20171001102647.GA23908@amd> <201710011957.ICF15708.OOLOHFSQMFFVJt@I-love.SAKURA.ne.jp>
 <72c93a69-610f-027e-c028-379b97b6f388@intel.com> <20171002084131.GA24414@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171002084131.GA24414@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-mm@kvack.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Oct 2, 2017 at 10:41 AM, Pavel Machek <pavel@ucw.cz> wrote:

>> Bounce buffers are being removed from v4.15

As Adrian states, this would make any last bugs go away. I would
even consider putting this patch this into fixes if it solves the problem.

> although you may experience
>> performance regression with that:
>>
>>       https://marc.info/?l=linux-mmc&m=150589778700551
>
> Hmm. The performance of this is already pretty bad, I really hope it
> does not get any worse.

Did you use bounce buffers? Those were improving performance on
some laptops with TI or Ricoh host controllers and nothing else was
ever really using it (as can be seen from the commit).

Yours,
Linus Walleij
