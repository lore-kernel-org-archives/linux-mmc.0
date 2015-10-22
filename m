From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH] mmc: pwrseq: Use highest priority for eMMC restart
 handler
Date: Thu, 22 Oct 2015 19:53:01 +0200
Message-ID: <5629227D.6060806@osg.samsung.com>
References: <1445440540-21525-1-git-send-email-javier@osg.samsung.com>
 <56282F71.2070408@samsung.com> <562839F7.3040005@osg.samsung.com>
 <56283F27.9060804@samsung.com>
 <CAD=FV=VZJ9Tc4G-Xiw60DmfC4izU_6dVwwa0N0ePM0eaJfcqkg@mail.gmail.com>
 <562909DE.1000202@osg.samsung.com>
 <CAD=FV=UBY1wB0wCV_v2H2thT6015Lr0=r4+uDZ5GxFZRqGoVWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:46786 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752982AbbJVRxM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 Oct 2015 13:53:12 -0400
In-Reply-To: <CAD=FV=UBY1wB0wCV_v2H2thT6015Lr0=r4+uDZ5GxFZRqGoVWw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Markus Reichl <m.reichl@fivetechno.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>

Hello Doug,

On 10/22/2015 07:33 PM, Doug Anderson wrote:
> On Thu, Oct 22, 2015 at 9:07 AM, Javier Martinez Canillas

[snip]

>>
>> Do you know why the priority 200 was chosen for veyron gpi-restart ooi?
> 
> In David Riley's original patch the example had 200:
>     https://patchwork.kernel.org/patch/4784611/
> 
> In the ChromeOS 3.14 kernel tree I believe we're still using the old
> patch (we still have /bits/ 8).  ...it looks like I'm the one who
> originally added it to the veyron dts file and I set it to 200, so I'd
> presume that I just copied the example and called it "good enough".
>

I see, thanks for the explanation. I asked because I noticed that the
gpio-restart handler default priority was 129 and I didn't find other
restart handler used for this board with a prio > 129 so at least in
mainline, the priority 200 should not be necessary.

But now I see that it was indeed 128 but was bumped to 129 in commit:

bcd56fe1aa97 ("power: reset: gpio-restart: increase priority slightly")

which explains why the priority 200 was in the veyron DTS even when is
not needed anymore after that commit.
 
> I'm sure the upstream dts just used the number from the ChromeOS 3.14 tree...
> 
> Note that the GPIO-restart definitely need to be higher priorities
> than others in the system.  The two I know of off the top of my head
> are the "dw watchdog" and the one in the CRU.  The "dw watchdog" has a
> priority of 128 and so does the one in "rockchip/clk.c".  Hrm,
> actually, the Rockchip-specific one should probably have its priority
> bumped up since it seems better not to just randomly pick between
> these two...

Agreed about bumping the prio for the rockchip specific restart handler.

> 
> 
> -Doug
> --

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
