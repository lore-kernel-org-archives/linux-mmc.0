From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 02/11] mmc: omap: add clk_prepare and clk_unprepare
Date: Mon, 25 Jun 2012 11:02:56 +0530
Message-ID: <4FE7F808.6050202@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com> <1340372890-10091-3-git-send-email-rnayak@ti.com> <CANfBPZ-YpupgvzPcJsqZpG4QOErw6kqBNWjP2GL5teDwU+wbBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:40480 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752176Ab2FYFdI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jun 2012 01:33:08 -0400
Received: by pbbrr4 with SMTP id rr4so6896150pbb.23
        for <linux-mmc@vger.kernel.org>; Sun, 24 Jun 2012 22:33:06 -0700 (PDT)
In-Reply-To: <CANfBPZ-YpupgvzPcJsqZpG4QOErw6kqBNWjP2GL5teDwU+wbBA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: paul@pwsan.com, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org

On Friday 22 June 2012 11:53 PM, S, Venkatraman wrote:
> On Fri, Jun 22, 2012 at 7:18 PM, Rajendra Nayak<rnayak@ti.com>  wrote:
>> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
>> and clk_unprepare() for the mmc and hsmmc clocks as part of the drivers
>> probe() and remove() routines.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> Cc: Chris Ball<cjb@laptop.org>
>> Cc: Balaji T K<balajitk@ti.com>
>> Cc:<linux-mmc@vger.kernel.org>
>
> Rajendra,
>    Can this be applied independently, or does this patch have a
> dependency on other patches in the series ?

Yes, this can be applied independently. There is no other
dependency.
