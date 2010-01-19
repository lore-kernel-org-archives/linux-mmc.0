From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 03/03] mmc: Balance tmio-mmc cell enable()/disable() calls
Date: Tue, 19 Jan 2010 23:25:18 +0900
Message-ID: <aec7e5c31001190625x2b0629f7xdef38dc6edc43586@mail.gmail.com>
References: <20091127045956.15251.84958.sendpatchset@rxone.opensource.se>
	 <20091127050022.15251.43017.sendpatchset@rxone.opensource.se>
	 <20100115160602.f1523a68.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:38452 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220Ab0ASOZT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2010 09:25:19 -0500
In-Reply-To: <20100115160602.f1523a68.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, ian@mnementh.co.uk, lethal@linux-sh.org, philipp.zabel@gmail.com, pierre@ossman.eu

On Sat, Jan 16, 2010 at 9:06 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri, 27 Nov 2009 14:00:22 +0900
> Magnus Damm <magnus.damm@gmail.com> wrote:
>
>> From: Magnus Damm <damm@opensource.se>
>>
>> This patch adds cell->disable() calls to the tmio-mmc
>> probe() error handling and the remove() function.
>>
>
> This patch still doesn't apply due to linux-next changes which never
> got merged into 2.6.33-rcX.

Good news is that the linux-next issue seems solved now thanks to help
from Samuel Ortiz.

> If you think it should go into 2.6.33 then please redo a patch against
> mainline and we'll cheerily trash the problematic stuff in linux-next.

Nah, this patch is not urgent. It may also break other platforms, so I
prefer to resend it later.

Thanks,

/ magnus
