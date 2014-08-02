From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: BKOPS Support
Date: Sat, 2 Aug 2014 17:00:19 +0200
Message-ID: <CAPDyKFr0iQ3ttFPcYGTPXno+jZnkqm43cmAqZfBt_v-iPaeTbw@mail.gmail.com>
References: <0B57664BEFBB104C94244254B90DDDD23E3187B7@FMSMSX119.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:46410 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814AbaHBPAV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 2 Aug 2014 11:00:21 -0400
Received: by mail-la0-f51.google.com with SMTP id pn19so4135768lab.10
        for <linux-mmc@vger.kernel.org>; Sat, 02 Aug 2014 08:00:20 -0700 (PDT)
In-Reply-To: <0B57664BEFBB104C94244254B90DDDD23E3187B7@FMSMSX119.amr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Schollmeyer, David A" <david.a.schollmeyer@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 2 August 2014 02:06, Schollmeyer, David A
<david.a.schollmeyer@intel.com> wrote:
>
> I have a card with BKOPS_SUPPORT set in its ext_csd and I see the
> following Message during boot:
>
>     mmc0: BKOPS_EN bit is not set.
>
> From the eMMC spec, it looks to me that the host should set this bit
> if the card reports BKOPS_SUPPORT:
>
>     7.4.60  BKOPS_EN [163]
>     This field allows the host to indicate to the device if it is
>     expected to periodically manually start background operations by
>     writing to the BKOPS_START field.
>
> Am I reading this correctly? Shouldn't the mmc driver write the
> register after reading the ext_csd if it wishes to perform background
> operations and the card supports it?
>

Historically we have maintained a policy of not allowing the mmc
driver automatically to write register bits that is one time
programmable. Instead those have to be "manually" written, typically
using the the mmc ioctl cmd or some other tool in the production phase
of a platform.

If I remember correctly the BKOPS_EN bit is a one time programmable bit, right!?

Kind regards
Uffe
