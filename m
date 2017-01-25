From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 3/3] mmc: Checking BKOPS status prior to Suspend
Date: Wed, 25 Jan 2017 12:30:11 +0200
Message-ID: <1d00199b-aaee-0363-0b85-b57b48f3ea40@intel.com>
References: <1484655337-32562-1-git-send-email-uri.yanai@sandisk.com>
 <1484655337-32562-4-git-send-email-uri.yanai@sandisk.com>
 <7a21bfe1-9eef-0f6f-56ce-4fc34d628ac0@intel.com>
 <037111DC0C584A4DB9F38021EA3CBDA506103F51@ULS-OP-MBXIP04.sdcorp.global.sandisk.com>
 <5DA5AA2A-DC61-4CC6-9548-AB648657C732@sandisk.com>
 <650522d8-dd54-6856-d50c-798d97a82001@intel.com>
 <939E5C6D-D96B-4EF6-81F2-0DE61499E4B6@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33666 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751925AbdAYKf1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 25 Jan 2017 05:35:27 -0500
In-Reply-To: <939E5C6D-D96B-4EF6-81F2-0DE61499E4B6@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>, Uri Yanai <Uri.Yanai@sandisk.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 25/01/17 11:48, Alex Lemberg wrote:
> 
> 
> On 1/24/17, 4:36 PM, "Adrian Hunter" <adrian.hunter@intel.com> wrote:
> 
>     On 23/01/17 19:07, Alex Lemberg wrote:
>     > Hi Adrian,
>     > 
>     > I would like to add several notes on top of Uri’s answer...
>     > I agree with you, by the spec, PON Sleep_Notification should be
>     > set before calling Sleep command.
>     > As you probably remember, we have tried to implement it
>     > in the past and even submitted a patch – “[PATCH] mmc: sleep notification”
>     > https://www.mail-archive.com/linux-mmc@vger.kernel.org/msg30906.html
>     > As you can see from the thread, one of the main issues in Sleep_Notification
>     > is a SLEEP_NOTIFICATION_TIME (defined in EXT_CSD [216]), which need to be
>     > considered in implementation…
>     
>     Does it?  I would tend to assume SLEEP_NOTIFICATION_TIME will be acceptable
>     during _suspend until proven otherwise.
> 
> Potentially, by the spec, the Max value of SLEEP_NOTIFICATION_TIME can be 83.88 seconds.
> Can we assume that this time is acceptable during _suspend?

Do you know of any cards that take that long?

As I wrote, I would assume it is acceptable until we know otherwise.

>     
>     > Thus, I think postponing Sleep during suspend requires a different from current
>     > AUTO_BKOPS implementation, and I suggest to handle it in separate
>     > patchset, if possible.
>     
>     Not at all sure what you mean by "postponing Sleep"?
> 
> I mean letting Sleep_Notification to be completed before Sleep.

ook.

