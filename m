From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc:sdio:retry CMD52/53 when error happens
Date: Tue, 15 May 2012 09:15:42 +0200
Message-ID: <4FB2029E.3060107@stericsson.com>
References: <1336984792-13956-1-git-send-email-yongd@marvell.com> <4FB10156.2080900@stericsson.com> <89813612683626448B837EE5A0B6A7CB1A2B9F19B7@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <89813612683626448B837EE5A0B6A7CB1A2B9F19B7@SC-VEXCH4.marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Ding <yongd@marvell.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "stefan.xk.nilsson@stericsson.com" <stefan.xk.nilsson@stericsson.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "svenkatr@ti.com" <svenkatr@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Yong Ding,

On 05/15/2012 05:14 AM, Yong Ding wrote:
> Hi Ulf Hansson, Thanks for your comments.
>
> Such retry mechanism is a simple CMD-level or sdio-core-level retry
> which takes advantage of the mmc core internal retry. There is not
> any side effect, but with it, even those SDIO function driver's
> without its own retrying mechanism can benefit in some conditions.

I am not sure about that. It all depends on what kind of protocol the 
SDIO func driver is handling and as well what SDIO hw that is connected.

For a WLAN interface you might end up in reading/writing the next 
buffer, maybe messing up even more data. Have you considered this?

>
> Besides, for CMD52, it can be used during SDIO card
> initialization/detection phase. At that time, SDIO function driver
> hasn't started to work. Of course we can probably encounter CMD52
> error due to some reasons(eg, board-level schematic bad behavior),
> and such retry can be a potential workaround. Actually, we've
> encountered exactly such case in our development.

I realize that there is a need for this, but I am not sure we always 
would like to have "retries" for every CMD52/53 request.

During SDIO initialization before SDIO func driver is started, retries 
should be safe since there is no upper protocol to consider yet. Maybe 
we should try to create a patch which only enables retries during SDIO 
init sequence instead!?

Kind regards
Ulf Hansson
