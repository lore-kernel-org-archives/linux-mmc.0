From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: tmio: fix compiler warning
Date: Tue, 23 Jul 2013 20:08:12 +0100
Message-ID: <867ggh6qn7.fsf@void.printf.net>
References: <Pine.LNX.4.64.1307081135170.19819@axis700.grange>
	<CAOesGMgMZR=yjDDWWDb21iuZaVocXqYZUg8C=hyGk4oHrRxDig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33869 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933129Ab3GWTIP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Jul 2013 15:08:15 -0400
In-Reply-To: <CAOesGMgMZR=yjDDWWDb21iuZaVocXqYZUg8C=hyGk4oHrRxDig@mail.gmail.com>
	(Olof Johansson's message of "Tue, 23 Jul 2013 12:01:43 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On Tue, Jul 23 2013, Olof Johansson wrote:
> On Mon, Jul 8, 2013 at 2:38 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
>> This patch fixes a compiler warning:
>>
>> drivers/mmc/host/tmio_mmc_pio.c: In function 'tmio_mmc_power_on':
>> drivers/mmc/host/tmio_mmc_pio.c:798:19: warning: ignoring return value of
>> 'regulator_enable', declared with attribute warn_unused_result
>> [-Wunused-result]
>>
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
>
> Acked-by: Olof Johansson <olof@lixom.net>
>
> Chris, this warniong is staring at me from my inbox every morning.
> Would you mind picking it up for 3.11?

Sure -- pushed to mmc-next for 3.11.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
