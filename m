From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v6 02/11] omap_hsmmc: add support for pre_req and
 post_req
Date: Tue, 21 Jun 2011 15:18:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1106211515270.2142@xanadu.home>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org> <1308518257-9783-3-git-send-email-per.forlin@linaro.org> <BANLkTi=+o496k8Uz_k33AH=Zr8+MaFOEig@mail.gmail.com> <BANLkTinNG2h747MggWfoJfMp4wOSTaTKSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1445764316-1308683914=:2142"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54841 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756933Ab1FUTSg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 15:18:36 -0400
Received: by qyk9 with SMTP id 9so50731qyk.19
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2011 12:18:35 -0700 (PDT)
In-Reply-To: <BANLkTinNG2h747MggWfoJfMp4wOSTaTKSg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: Kishore Kadiyala <kishorek.kadiyala@gmail.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1445764316-1308683914=:2142
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 21 Jun 2011, Per Forlin wrote:

> On 21 June 2011 07:41, Kishore Kadiyala <kishorek.kadiyala@gmail.com> wrote:
> > <snip>
> >
> >> +
> >> +static void omap_hsmmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
> >> +                              bool is_first_req)
> >
> > I don't see the usage of "is_first_req" below.
> > Is it required?
> >
> It is not required. It is only an indication that this request is the
> first in a series of request. The host driver may do various
> optimisations based on this information. The first request in a series
> of jobs can't be prepared in parallel to the previous job. The host
> driver can do the following to minimise latency for the first job.
>  * Preparing the cache while the MMC read/write cmd is being
> processed. In this case the pre_req could do nothing and the job is
> instead run in parallel to the read/write cmd being sent. If the
> is_first_req is false pre_req will run in parallel to an active
> transfer, in this case it is more efficient to prepare the request in
> pre_req.
>  * Run PIO mode instead of DMA

That is never going to be a good tradeoff.  If the CPU is busy doing 
PIO, it won't have a chance to prepare a subsequent request in parallel 
to the first transfer.


Nicolas
--8323328-1445764316-1308683914=:2142--
