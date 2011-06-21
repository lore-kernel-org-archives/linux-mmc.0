From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v6 02/11] omap_hsmmc: add support for pre_req and post_req
Date: Tue, 21 Jun 2011 19:26:36 +0530
Message-ID: <BANLkTi=UzZtKQU+-7iicEH2Jk7XED9yRRQ@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
 <1308518257-9783-3-git-send-email-per.forlin@linaro.org> <BANLkTi=+o496k8Uz_k33AH=Zr8+MaFOEig@mail.gmail.com>
 <BANLkTinNG2h747MggWfoJfMp4wOSTaTKSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58089 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab1FUN44 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 09:56:56 -0400
Received: by gxk21 with SMTP id 21so735315gxk.19
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2011 06:56:56 -0700 (PDT)
In-Reply-To: <BANLkTinNG2h747MggWfoJfMp4wOSTaTKSg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>

Hi Per,

On Tue, Jun 21, 2011 at 12:21 PM, Per Forlin <per.forlin@linaro.org> wr=
ote:
> On 21 June 2011 07:41, Kishore Kadiyala <kishorek.kadiyala@gmail.com>=
 wrote:
>> <snip>
>>
>>> +
>>> +static void omap_hsmmc_pre_req(struct mmc_host *mmc, struct mmc_re=
quest *mrq,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bool i=
s_first_req)
>>
>> I don't see the usage of "is_first_req" below.
>> Is it required?
>>
> It is not required. It is only an indication that this request is the
> first in a series of request. The host driver may do various
> optimisations based on this information. The first request in a serie=
s
> of jobs can't be prepared in parallel to the previous job. The host
> driver can do the following to minimise latency for the first job.
> =A0* Preparing the cache while the MMC read/write cmd is being
> processed. In this case the pre_req could do nothing and the job is
> instead run in parallel to the read/write cmd being sent. If the
> is_first_req is false pre_req will run in parallel to an active
> transfer, in this case it is more efficient to prepare the request in
> pre_req.
> =A0* Run PIO mode instead of DMA
> =A0* Maybe there can be power related optimisations based on if it is
> one single transfer or multiple ones.

Ok, thanks for making things clear.

<snip>

Regards,
Kishore
