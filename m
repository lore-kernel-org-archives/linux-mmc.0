From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: Check the return value from clk_prepare_enable()
Date: Wed, 11 Dec 2013 20:24:51 -0500
Message-ID: <87eh5i7tek.fsf@octavius.laptop.org>
References: <1381351059-30650-1-git-send-email-festevam@gmail.com>
	<20131012073857.GD21305@S2101-09.ap.freescale.net>
	<CAOMZO5ADVoqiumJFCKWkX=VoS_Uj_VUO0H9V7AK-m2Z1iGJd=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39216 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300Ab3LLBY4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Dec 2013 20:24:56 -0500
In-Reply-To: <CAOMZO5ADVoqiumJFCKWkX=VoS_Uj_VUO0H9V7AK-m2Z1iGJd=w@mail.gmail.com> (Fabio
	Estevam's message of "Sat, 26 Oct 2013 16:11:45 -0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Hi Fabio,

On Sat, Oct 26 2013, Fabio Estevam wrote:
> Chris,
>
> On Sat, Oct 12, 2013 at 4:38 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> On Wed, Oct 09, 2013 at 05:37:39PM -0300, Fabio Estevam wrote:
>>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>>
>>> clk_prepare_enable() may fail, so let's check its return value and
>>> propagate it
>>> in the case of error.
>>>
>>> Also, fix the sequence for disabling the clock in the probe error path and
>>> also in the remove funct
>>>
>>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>
> Any comments on this one?

Looks like this one doesn't apply cleanly anymore, sorry for leaving
it so long -- please could you submit a new version?  Thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
