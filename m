From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V6 03/15] mmc: core: Add support for re-tuning before each request
Date: Wed, 6 May 2015 11:45:25 +0200
Message-ID: <CAPDyKFpmj1PJ4s_K8KpD17W-za-Yq2BS7HEm-vVnyFgj1+gcGQ@mail.gmail.com>
References: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>
	<1429531796-21987-4-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFqUowi29oqcRTSLEaSjXNv=RyzmxRGks-pHDri2FW-wYw@mail.gmail.com>
	<5549CA93.5010803@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33909 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbbEFJp0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2015 05:45:26 -0400
Received: by qgfi89 with SMTP id i89so1672912qgf.1
        for <linux-mmc@vger.kernel.org>; Wed, 06 May 2015 02:45:25 -0700 (PDT)
In-Reply-To: <5549CA93.5010803@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 6 May 2015 at 10:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 04/05/15 16:28, Ulf Hansson wrote:
>> On 20 April 2015 at 14:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> At the start of each request, re-tune if needed and
>>> then hold off re-tuning again until the request is done.
>>>
>>> Note that though there is one function that starts
>>> requests (mmc_start_request) there are two that wait for
>>> the request to be done (mmc_wait_for_req_done and
>>> mmc_wait_for_data_req_done).  Also note that
>>> mmc_wait_for_data_req_done can return even when the
>>> request is not done (which allows the block driver
>>> to prepare a newly arrived request while still
>>> waiting for the previous request).
>>>
>>> This patch ensures re-tuning is held for the duration
>>> of a request.  Subsequent patches will also hold
>>> re-tuning at other times when it might cause a
>>> conflict.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> Patch2 is calling mmc_retune_needed() and thus actually triggers a
>> re-tune to potentially happen.
>
> That won't happen because host->retune_period is not set, so
> mmc_retune_needed() won't be called.

mmc_retune_needed() is indeed called in patch2 (v7). From
mmc_sdio_suspend() and when mmc_card_keep_power().

I guess that wont be an issue!?

But I just felt that it seemed more appropriate to manage hold/release
of re-tune before actually enabling the feature.

Kind regards
Uffe
