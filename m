From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH --mmotm v5 0/3] Make fault injection available for MMC IO
Date: Tue, 9 Aug 2011 11:02:53 +0200
Message-ID: <CAJ0pr18Mpv7mFHC3NnfqEqtTFd_qgNhH9rZgCENgH0zKmBfFsQ@mail.gmail.com>
References: <1312834049-29910-1-git-send-email-per.forlin@linaro.org>
	<CAC5umyhWr8t7HyQVEn-W-7HSaeESnTLX8okcQNqPO6mYFuWtUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAC5umyhWr8t7HyQVEn-W-7HSaeESnTLX8okcQNqPO6mYFuWtUg@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: akpm@linux-foundation.org, Linus Walleij <linus.ml.walleij@gmail.com>, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, Chris Ball <cjb@laptop.org>, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linaro-dev@lists.linaro.org, linux-mm@kvack.org
List-Id: linux-mmc@vger.kernel.org

On 9 August 2011 02:51, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> All three patches look good.
> Acked-by: Akinobu Mita <akinobu.mita@gmail.com>
>
> 2011/8/9 Per Forlin <per.forlin@linaro.org>:
>> This patchset is sent to the mm-tree because it depends on Akinobu's patch
>> "fault-injection: add ability to export fault_attr in..."
>
> That patch has already been merged in mainline.
>
Please drop this patchset.
Patch #1 "fault-injection: export fault injection functions" is merged
too. There is no need to merge this through mm-tree anymore. All
fault-injection patches needed by MMC fault injection code are merged.
I'll repost the patchset to mmc-next when mmc-next has moved to 3.1
code base.

Thanks,
Per
