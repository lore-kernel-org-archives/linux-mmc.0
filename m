From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 03/15] mmc: core: Add support for re-tuning before
 each request
Date: Wed, 01 Apr 2015 15:08:48 +0300
Message-ID: <551BDFD0.20800@intel.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>	<1427489863-9050-4-git-send-email-adrian.hunter@intel.com> <CAPDyKFpxZ5mvy2Q+s62E0AadoUYvbtYLikxX4PGQf6M_0bBevA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42527 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbbDAMKw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 1 Apr 2015 08:10:52 -0400
In-Reply-To: <CAPDyKFpxZ5mvy2Q+s62E0AadoUYvbtYLikxX4PGQf6M_0bBevA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 01/04/15 13:13, Ulf Hansson wrote:
> On 27 March 2015 at 21:57, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> At the start of each request, re-tune if needed and
>> then hold off re-tuning again until the request is done.
>>
>> Note that though there is one function that starts
>> requests (mmc_start_request) there are two that wait for
>> the request to be done (mmc_wait_for_req_done and
>> mmc_wait_for_data_req_done).  Also note that
>> mmc_wait_for_data_req_done can return even when the
>> request is not done (which allows the block driver
>> to prepare a newly arrived request while still
>> waiting for the previous request).
>>
>> This patch ensures re-tuning is held for the duration
>> of a request.  Subsequent patches will also hold
>> re-tuning at other times when it might cause a
>> conflict.
> 
> How about holding of re-tune from __mmc_claim_host() (after
> pm_runtime_get_sync() ) -> mmc_release_host(). Would that work? If so,
> that would simplify a lot around this.

I don't think it would work. The host is claimed both when we want to do
re-tuning (timer, CRC error, or host requests it) and when we want to
prevent it (in between dependent commands like erase, polling when card is
busy, SDIO card custom wake-up command).

