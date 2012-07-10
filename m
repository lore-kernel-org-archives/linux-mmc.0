From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: omap: add clk_prepare and clk_unprepare
Date: Tue, 10 Jul 2012 00:36:17 -0400
Message-ID: <877gucs05a.fsf@octavius.laptop.org>
References: <1340786994-29565-1-git-send-email-rnayak@ti.com>
	<CANfBPZ9=-CZ=-bKN80tAZmWDZAvWNLxDcCR6hjQQzZ4qhQvbEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55950 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198Ab2GJEgW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Jul 2012 00:36:22 -0400
In-Reply-To: <CANfBPZ9=-CZ=-bKN80tAZmWDZAvWNLxDcCR6hjQQzZ4qhQvbEA@mail.gmail.com>
	(Venkatraman S.'s message of "Tue, 10 Jul 2012 09:57:27 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>

Hi,

On Tue, Jul 10 2012, S, Venkatraman wrote:
> On Wed, Jun 27, 2012 at 2:19 PM, Rajendra Nayak <rnayak@ti.com> wrote:
>> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
>> and clk_unprepare() for the hsmmc clocks.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Cc: Chris Ball <cjb@laptop.org>
>> Cc: Balaji T K <balajitk@ti.com>
>> Cc: <linux-mmc@vger.kernel.org>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Mike Turquette <mturquette@linaro.org>
>
> Thanks Rajendra.
> Acked-by: Venkatraman S <svenkatr@ti.com>

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
