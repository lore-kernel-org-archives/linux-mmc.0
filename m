From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: core: Remove redundant rescan_disable flag
Date: Tue, 10 May 2016 11:44:28 +0200
Message-ID: <CAPDyKFq4GUN33jQ2nc4FPHtSG26UgkcaCnAXemx0nKLp6P7acg@mail.gmail.com>
References: <1461868156-5734-1-git-send-email-ulf.hansson@linaro.org>
	<5723AAAB.60109@intel.com>
	<CAPDyKFqXEmrAtADNLrEUmF=6oc4-guNTGA=r0UFye3Ox8qO-2w@mail.gmail.com>
	<5731A4E8.5080608@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37217 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbcEJJoa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2016 05:44:30 -0400
Received: by mail-wm0-f42.google.com with SMTP id a17so17087690wme.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 May 2016 02:44:29 -0700 (PDT)
In-Reply-To: <5731A4E8.5080608@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

On 10 May 2016 at 11:07, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 10/05/16 12:01, Ulf Hansson wrote:
>> On 29 April 2016 at 20:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 28/04/2016 9:29 p.m., Ulf Hansson wrote:
>>>>
>>>> For the reasons explained below, it's safe to remove the rescan_disable
>>>> flag.
>>>>
>>>> 1)
>>>> cancel_delayed_work_sync() prevents an executing work from re-scheduling
>>>> itself.
>>>>
>>>> 2)
>>>> We are using the system_freezable_wq for the rescan works. As that queue
>>>> becomes frozen when userspace becomes frozen during system PM, we don't
>>>> need to disable the rescan works in the PM_SUSPEND_PREPARE phase.
>>>
>>>
>>> What about the case when a SDIO card has to be removed?  Seems like a rescan
>>> could theoretically get scheduled and run before the workqueue is frozen.
>>
>> When the queue gets frozen, it means currently running works will be
>> synced. Works that are scheduled (or becomes scheduled) will be put on
>> hold and not allowed to run before the workqueue becomes un-frozen.
>
> In the pm_notifier the workqueue is not frozen, so new work could be queued
> and run, which would potentially race with the "host->bus_ops->remove(host)"
> a few lines further on.

You are right, I will put this patch on hold! Thanks!

I need to change the validation for this special SDIO case first. We
shouldn't need to detach the bus and thus also remove the card in
these cases, but instead only remove the SDIO func devices.

Kind regards
Uffe
