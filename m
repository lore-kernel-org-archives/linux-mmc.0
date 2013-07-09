From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/5] mmc: dw_mmc: Add suspend/resume callbacks; disable
 irq during suspend
Date: Tue, 9 Jul 2013 14:31:43 -0700
Message-ID: <CAD=FV=X5vFqMWn+TP5wnAT02x88zhQqEAO0t5Y005+ZiBLmT4Q@mail.gmail.com>
References: <1373391071-6312-1-git-send-email-dianders@chromium.org>
	<1373391071-6312-3-git-send-email-dianders@chromium.org>
	<CAAG0J9_FbJYRrR=8GgHCvMDSbwfwXic81TJfchnv5UM798RB_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:50527 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204Ab3GIVbp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jul 2013 17:31:45 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so5196904lab.1
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jul 2013 14:31:43 -0700 (PDT)
In-Reply-To: <CAAG0J9_FbJYRrR=8GgHCvMDSbwfwXic81TJfchnv5UM798RB_g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Chris Ball <cjb@laptop.org>, Olof Johansson <olof@lixom.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Grant Grundler <grundler@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

James,

On Tue, Jul 9, 2013 at 2:17 PM, James Hogan <james.hogan@imgtec.com> wrote:
> Hi Doug,
>
> On 9 July 2013 18:31, Doug Anderson <dianders@chromium.org> wrote:
>> On some platforms (like exynos5420) the dw_mmc controller may be in a
>> strange state after we wake up from sleep.  Add callbacks to allow for
>> dealing with these quirks.  Prevent interrupts from firing when we're
>> suspended since this strange state may cause interrupts to fire.
>>
>> In my case I saw the WAKEUP_INT interrupt firing upon resume and
>> needed to add some code to handle this.
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>
> Would it make sense to take advantage of the {suspend,resume}_noirq
> power management callbacks to clear that WAKEUP_INT before interrupts
> are re-enabled, rather than explicitly disabling and enabling the
> interrupt at the suspend/resume stage?

That's a good suggestion.  Let me give it a shot and get back to you
after I validate that it works.

-Doug
