From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH 1/2] omap: hsmmc: Normalize dma cleanup operations
Date: Wed, 14 Sep 2011 22:55:18 +0200
Message-ID: <CAJ0pr19gtXSMXPD4AcAJ3Nw60AtkuZ8xNsNQX_ae07t212GBGg@mail.gmail.com>
References: <1314903957-24408-2-git-send-email-svenkatr@ti.com>
	<CAJ0pr18PtGWga7n8nm1xs-=wtRjMu=X_wZONAOAgeaLamtEJjg@mail.gmail.com>
	<CANfBPZ9sVvcVhwxgu0SqbjY1gT8GdeXXsThf48__ax=bQ4zHEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54805 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933235Ab1INUzU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Sep 2011 16:55:20 -0400
In-Reply-To: <CANfBPZ9sVvcVhwxgu0SqbjY1gT8GdeXXsThf48__ax=bQ4zHEA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Kishore Kadiyala <kishorek.kadiyala@gmail.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org

On 14 September 2011 15:40, S, Venkatraman <svenkatr@ti.com> wrote:
> On Tue, Sep 13, 2011 at 1:26 AM, Per Forlin <per.forlin@linaro.org> wrote:
>> On 1 September 2011 21:05, Venkatraman S <svenkatr@ti.com> wrote:
>>> Reuse omap_hsmmc_dma_cleanup even for normal dma teardown in
>>> omap_hsmmc_dma_cb. Consolidate multiple points of dma unmap into a
>>> single location in post_req function, to prevent double unmapping.
>> It's optional to use pre_req() and post_req(). The SDIO framework
>> doesn't utilise these hooks. For instance this wont work together with
>> SDIO-wlan on the pandaboard.
>> If pre_req() has been issued it's fine to defer dma_unmap() until
>> post_req(). If pre_req() is not called the driver should call
>> dma_unmap() directly.
>>
>
> In that case, can the actual 'request' function just call pre_req and post_req
> (at the beginning and at the end), if host_cookie is not set ?
>
Which request() function do your refer to? The mmc_host_ops.request()
returns before the transfer is finished.
Apart from that, I would say yes. It's nice to have the same code path
for valid cookie and invalid cookie scenario.

Note that the host_cookie could be set but with an invalid value.
host driver:
1. validate cookie
2. if invalid cookie call pre_req()
3. run request
4. done -> if (has called pre_req() #2) -> call post_req().

A general fix would be to put this logic in mmc_wait_for_req() in
core.c, but at this level it's not possible to validate the cookie. In
the current implementation the host driver controls the cookie value.

/Per
