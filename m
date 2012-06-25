From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 02/11] mmc: omap: add clk_prepare and clk_unprepare
Date: Mon, 25 Jun 2012 10:55:10 +0530
Message-ID: <4FE7F636.7040803@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com> <1340372890-10091-3-git-send-email-rnayak@ti.com> <CANfBPZ-YpupgvzPcJsqZpG4QOErw6kqBNWjP2GL5teDwU+wbBA@mail.gmail.com> <alpine.DEB.2.00.1206221233490.10198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1206221233490.10198@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "S, Venkatraman" <svenkatr@ti.com>, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Saturday 23 June 2012 12:04 AM, Paul Walmsley wrote:
> On Fri, 22 Jun 2012, S, Venkatraman wrote:
>
>> On Fri, Jun 22, 2012 at 7:18 PM, Rajendra Nayak<rnayak@ti.com>  wrote:
>>> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
>>> and clk_unprepare() for the mmc and hsmmc clocks as part of the drivers
>>> probe() and remove() routines.
>>>
>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>> Cc: Chris Ball<cjb@laptop.org>
>>> Cc: Balaji T K<balajitk@ti.com>
>>> Cc:<linux-mmc@vger.kernel.org>
>>
>> Rajendra,
>>    Can this be applied independently, or does this patch have a
>> dependency on other patches in the series ?
>
> A better way to handle this one would be to convert the driver to runtime
> PM.  That needs to be done anyway.

Well, mmc driver is already using runtime PM. But it still using clock
apis' to deal with some optional debounce clock needed only on 2430.

>
>
> - Paul

