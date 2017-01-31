From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 RESEND] sdhci: Ignore unexpected CARD_INT interrupts
Date: Tue, 31 Jan 2017 11:35:13 +0100
Message-ID: <CAPDyKFrN7=suCnnDHg43KchRf6wKhzijsBXW7TSP7ufh6DPwiQ@mail.gmail.com>
References: <20170116142342.21283-1-krisman@collabora.co.uk>
 <CAPDyKFpowPmbwvHL9NL60zAABfW53sDKkp0Ag5aXs4jZZLC=Dg@mail.gmail.com>
 <87wpdg9uob.fsf@dilma.collabora.co.uk> <CAPDyKFq2aUkk4qzcLNoityHbOYTHCq_OiO9HVLuWjcGSJX0aWw@mail.gmail.com>
 <87poj4loa5.fsf@dilma.collabora.co.uk> <2b37a0fa-46e3-ec4e-3f9c-9e1bb7dcda1e@intel.com>
 <874m0gll7v.fsf@dilma.collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36639 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdAaKfP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2017 05:35:15 -0500
Received: by mail-wm0-f50.google.com with SMTP id c85so254500841wmi.1
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2017 02:35:15 -0800 (PST)
In-Reply-To: <874m0gll7v.fsf@dilma.collabora.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Gustavo Padovan <gustavo.padovan@collabora.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>

On 30 January 2017 at 14:40, Gabriel Krisman Bertazi
<krisman@collabora.co.uk> wrote:
> Adrian Hunter <adrian.hunter@intel.com> writes:
>> Did you test normal SDIO operation was unaffected?  Please do that before
>> sending it to stable.
>
> I don't have any SDIO card in hand to confirm it right now.  would you
> or Ulf be able to give it a try?  I'll keep looking for one.

Sorry, I don't have any SDIO cards at hand that is using sdhci.

Still, as this has been tested for a while already in next, I decided
to move this to my fixes branch. I also added a stable-tag #4.4+.

If we see some issues, please report asap then I will drop the change.
I plan to send it to Linus on Friday this week.

Kind regards
Uffe
