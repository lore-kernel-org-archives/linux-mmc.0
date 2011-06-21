From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v6 02/11] omap_hsmmc: add support for pre_req and post_req
Date: Tue, 21 Jun 2011 08:51:08 +0200
Message-ID: <BANLkTinNG2h747MggWfoJfMp4wOSTaTKSg@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<1308518257-9783-3-git-send-email-per.forlin@linaro.org>
	<BANLkTi=+o496k8Uz_k33AH=Zr8+MaFOEig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59826 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab1FUGvJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 02:51:09 -0400
Received: by qwk3 with SMTP id 3so1130408qwk.19
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2011 23:51:08 -0700 (PDT)
In-Reply-To: <BANLkTi=+o496k8Uz_k33AH=Zr8+MaFOEig@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>

On 21 June 2011 07:41, Kishore Kadiyala <kishorek.kadiyala@gmail.com> w=
rote:
> <snip>
>
>> +
>> +static void omap_hsmmc_pre_req(struct mmc_host *mmc, struct mmc_req=
uest *mrq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bool is=
_first_req)
>
> I don't see the usage of "is_first_req" below.
> Is it required?
>
It is not required. It is only an indication that this request is the
first in a series of request. The host driver may do various
optimisations based on this information. The first request in a series
of jobs can't be prepared in parallel to the previous job. The host
driver can do the following to minimise latency for the first job.
 * Preparing the cache while the MMC read/write cmd is being
processed. In this case the pre_req could do nothing and the job is
instead run in parallel to the read/write cmd being sent. If the
is_first_req is false pre_req will run in parallel to an active
transfer, in this case it is more efficient to prepare the request in
pre_req.
 * Run PIO mode instead of DMA
 * Maybe there can be power related optimisations based on if it is
one single transfer or multiple ones.

>> +{
>> + =A0 =A0 =A0 struct omap_hsmmc_host *host =3D mmc_priv(mmc);
>> +
>> + =A0 =A0 =A0 if (mrq->data->host_cookie) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mrq->data->host_cookie =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (host->use_dma)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_hsmmc_pre_dma_transfer(host, =
mrq->data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 &host->next_data))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mrq->data->host_cookie=
 =3D 0;
>> +}
>> +
>> =A0/*
>

Thanks for your comments,
Per
