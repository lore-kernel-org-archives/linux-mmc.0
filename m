From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v6 02/11] omap_hsmmc: add support for pre_req and post_req
Date: Tue, 21 Jun 2011 22:18:23 +0200
Message-ID: <BANLkTi=AgOmwkJkVAON5AFTr+ytqkAGP4w@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<1308518257-9783-3-git-send-email-per.forlin@linaro.org>
	<BANLkTi=+o496k8Uz_k33AH=Zr8+MaFOEig@mail.gmail.com>
	<BANLkTinNG2h747MggWfoJfMp4wOSTaTKSg@mail.gmail.com>
	<alpine.LFD.2.00.1106211515270.2142@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57263 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756043Ab1FUUSZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 16:18:25 -0400
Received: by qwk3 with SMTP id 3so66358qwk.19
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2011 13:18:23 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1106211515270.2142@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Kishore Kadiyala <kishorek.kadiyala@gmail.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>

On 21 June 2011 21:18, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 21 Jun 2011, Per Forlin wrote:
>
>> On 21 June 2011 07:41, Kishore Kadiyala <kishorek.kadiyala@gmail.com=
> wrote:
>> > <snip>
>> >
>> >> +
>> >> +static void omap_hsmmc_pre_req(struct mmc_host *mmc, struct mmc_=
request *mrq,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bool=
 is_first_req)
>> >
>> > I don't see the usage of "is_first_req" below.
>> > Is it required?
>> >
>> It is not required. It is only an indication that this request is th=
e
>> first in a series of request. The host driver may do various
>> optimisations based on this information. The first request in a seri=
es
>> of jobs can't be prepared in parallel to the previous job. The host
>> driver can do the following to minimise latency for the first job.
>> =A0* Preparing the cache while the MMC read/write cmd is being
>> processed. In this case the pre_req could do nothing and the job is
>> instead run in parallel to the read/write cmd being sent. If the
>> is_first_req is false pre_req will run in parallel to an active
>> transfer, in this case it is more efficient to prepare the request i=
n
>> pre_req.
>> =A0* Run PIO mode instead of DMA
>
> That is never going to be a good tradeoff. =A0If the CPU is busy doin=
g
> PIO, it won't have a chance to prepare a subsequent request in parall=
el
> to the first transfer.
>
If you have two CPUs and the MMC interrupts are scheduled on the CPU
1, CPU 0 can prepare the next one. I'm still in favor of the preparing
cache in parallel to cmd. I have run tests and for small req like 4k
there is a good performance gain. Another option, if the mmc
controller support it, would be to start with PIO and switch to DMA on
the fly when cache is ready. Bottom line, it is up to the host driver
to do something clever based on is_first_req.

/Per
