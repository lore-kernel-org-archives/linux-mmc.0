From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: 4.13 on thinkpad x220: oops when writing to SD card
Date: Thu, 7 Sep 2017 22:02:20 +0200
Message-ID: <CACRpkdb263SS-7H1wcp0THAwzKO7A-kE0DVUdTiuxTnuXtWVVw@mail.gmail.com>
References: <20170905194739.GA31241@amd> <8f0f7310-ea4d-a200-75fd-23509947fb38@rock-chips.com>
 <6689241f-a4d8-7a3e-9f0b-482b034e5710@intel.com> <CAPDyKFqXaDFrJH1-YSSCx0xPXfMN99AM_Wu_sWQf5A6bw+zjdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqXaDFrJH1-YSSCx0xPXfMN99AM_Wu_sWQf5A6bw+zjdQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Pavel Machek <pavel@ucw.cz>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Seraphime Kirkovski <kirkseraph@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 7, 2017 at 9:18 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Even if this fixes the problem it seems like we are papering over the
> real issue, which earlier fixes also did during the release cycle for
> v4.13.

I think this is the real solution to the issue.

>> Another unrelated issue with mmc_init_request() is that mmc_exit_request()
>> is not called if mmc_init_request() fails, which means mmc_init_request()
>> must free anything it allocates when it fails.
>
> Yes, the situations it's just too fragile. We need to fix the behavior
> properly, although I haven't myself been able to investigate exactly
> how yet.
>
> Adding, Linus, perhaps he has some ideas.

Maybe we should simply bite the bullet and do what was suggested
by another contributor when I refactored the bounce buffer handling:
simply delete the bounce buffer code and let any remaining (few?)
legacy devices suffer a bit (performancewise) at the gain of way
simpler code?

I am a bit hesitant about that because Pierre Ossman said it was
actually a big win on the SDHC hosts that made use of it at one
point.

Yours,
Linus Walleij
