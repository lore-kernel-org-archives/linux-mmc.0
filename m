From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/9] r8a7790: add UHS-I (SDR50) support to Lager
Date: Mon, 4 Apr 2016 17:08:34 +0200
Message-ID: <CAPDyKFocCsLmPbFAuN989w4MCH_QKZzS8_YxqKvTZU5+yApZVw@mail.gmail.com>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

On 1 April 2016 at 17:44, Wolfram Sang <wsa@the-dreams.de> wrote:
> So, here is v2 of the series adding SDR50 support to the Renesas Lager board.
> Change since v1:
>
> * rebased to renesas-drivers based on v4.6-rc1
> * dropped pinctrl patch which was already picked up
> * directly populate start_signal_voltage_switch() in mmc_ops
>   instead of using a wrapper function
> * use generic DT pinctrl bindings instead of vendor specific ones
>   (e.g. "groups" instead of "renesas,groups")
>
> The RFC series worked fine with my Transcend card, but failed to switch
> voltages on a SanDisk and Samsung card. This bug hunting resulted in patches
> 4-6 newly added: The clock really has to be disabled on ios->clock == 0,
> setting frequency to 0Hz doesn't work. I wonder if this isn't true for some
> more controllers? Is this known already?

The documentation of mmc is quite poor. There are both code and
specification that needs to be understand, so some more help from
kernel doc could clearly help.

Anyway, I noticed that patch 6 helps to improve some documentation,
that's great - thanks!

>
> My "copy-large-files-around"-setup showed now 30MB/s while it had 19MB/s
> without SDR50. Frankly, I hoped for a little more, but let's start with this
> initial support and do the tuning incrementally I'd say.
>
> Patches 1-7 should go via Ulf. After those patches went in, Simon can take 8+9
> to tie it all together.
>
> Please comment, test, apply...

I only had one minor comment on patch 7, the rest looks good to me!

[...]

Kind regards
Uffe
