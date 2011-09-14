From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 1/2] omap: hsmmc: Normalize dma cleanup operations
Date: Wed, 14 Sep 2011 19:10:42 +0530
Message-ID: <CANfBPZ9sVvcVhwxgu0SqbjY1gT8GdeXXsThf48__ax=bQ4zHEA@mail.gmail.com>
References: <1314903957-24408-2-git-send-email-svenkatr@ti.com> <CAJ0pr18PtGWga7n8nm1xs-=wtRjMu=X_wZONAOAgeaLamtEJjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:45784 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753786Ab1INNlE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Sep 2011 09:41:04 -0400
In-Reply-To: <CAJ0pr18PtGWga7n8nm1xs-=wtRjMu=X_wZONAOAgeaLamtEJjg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: Kishore Kadiyala <kishorek.kadiyala@gmail.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org

On Tue, Sep 13, 2011 at 1:26 AM, Per Forlin <per.forlin@linaro.org> wrote:
> On 1 September 2011 21:05, Venkatraman S <svenkatr@ti.com> wrote:
>> Reuse omap_hsmmc_dma_cleanup even for normal dma teardown in
>> omap_hsmmc_dma_cb. Consolidate multiple points of dma unmap into a
>> single location in post_req function, to prevent double unmapping.
> It's optional to use pre_req() and post_req(). The SDIO framework
> doesn't utilise these hooks. For instance this wont work together with
> SDIO-wlan on the pandaboard.
> If pre_req() has been issued it's fine to defer dma_unmap() until
> post_req(). If pre_req() is not called the driver should call
> dma_unmap() directly.
>

In that case, can the actual 'request' function just call pre_req and post_req
(at the beginning and at the end), if host_cookie is not set ?
