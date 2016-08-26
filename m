From: Mike Christie <mchristi@redhat.com>
Subject: Re: 4.8-rc1 REGRESSION mmc-blk triggers WARN_ON(!host->claimed),
 related to: "drivers: use req op accessor" ?
Date: Fri, 26 Aug 2016 03:25:16 -0500
Message-ID: <57BFFCEC.6020909@redhat.com>
References: <6e68ae5a-4b79-a636-2c46-5726cf2cc44b@redhat.com>
 <57BB23D0.3050606@redhat.com>
 <2a2ee1e8-8682-0647-a66d-04ceb54f58ec@redhat.com>
 <6bfb134a-43bf-addd-3ff0-cc1d677a1606@intel.com>
 <7210392e-2c1c-5676-bb53-274ea6a5ca74@redhat.com>
 <41ab9b3e-cb39-fb9e-defd-f38ea6d5b791@fb.com>
 <CAPDyKFrZCNv9VWu1pVg02wE3Pth3z3J0uh5dCdeYU8LYd_wXJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751556AbcHZIZT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 26 Aug 2016 04:25:19 -0400
In-Reply-To: <CAPDyKFrZCNv9VWu1pVg02wE3Pth3z3J0uh5dCdeYU8LYd_wXJQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@fb.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, regressions@leemhuis.info, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 08/26/2016 02:13 AM, Ulf Hansson wrote:
> BTW, for some reason I (and linux-mmc) was not cc:ed on the commit
> that caused the regression:
> 
> c2df40dfb8c015211ec55f4b1dd0587f875c7b34
> Author: Mike Christie <mchristi@redhat.com>
> Date:   Sun Jun 5 14:32:17 2016 -0500
>     drivers: use req op accessor
> 
> Even if I probably wouldn't noticed that the patch was incorrect, it
> would have helped to know that we changed some parts in the mmc block
> layer when trying to find the regression. Could you please keep on eye
> on this future wise so it doesn't happen again.

Sorry about that and the bug. Both were my fault. Will be more careful
in the future.
