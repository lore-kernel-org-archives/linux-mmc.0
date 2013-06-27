From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/2] mmc: dw_mmc: Handle late vmmc regulators with EPROBE_DEFER
Date: Thu, 27 Jun 2013 10:10:26 -0700
Message-ID: <CAD=FV=X8qVAeD_F-kQLHcgusY65pw4WCs5mMsO0wTapqBUAiQw@mail.gmail.com>
References: <1370580406-10254-1-git-send-email-dianders@chromium.org>
	<1370626110-1731-1-git-send-email-dianders@chromium.org>
	<87vc4zlczt.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39361 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab3F0RK1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jun 2013 13:10:27 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so546847lbi.19
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jun 2013 10:10:26 -0700 (PDT)
In-Reply-To: <87vc4zlczt.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Olof Johansson <olof@lixom.net>, Andrew Bresticker <abrestic@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Will Newton <will.newton@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-doc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Chris,

On Thu, Jun 27, 2013 at 9:44 AM, Chris Ball <cjb@laptop.org> wrote:
> This hunk breaks the build for me, because err_setup_bus and ret are
> used in the error path of the call to mmc_add_host() in this function.
>
> I'll push a version that leaves those in.  Let me know if you think
> something strange is happening that made this work okay for you, like
> a mismerge.

WTF.  OK, this is clearly my fault.  I went back to the exact patch
and it didn't compile for me, either.  :(  My typical workflow is to
develop something in our local tree and then cherry-pick (and test!)
on ToT linux.  Probably what happened in this case was that there was
a compile error and I didn't notice and somehow ended up testing my
local tree (which doesn't error-check mmc_add_host).

Sorry for the hassle.  Leaving the err_setup_bus in is correct (and
leaving the "ret" variable declared).

I did those fixups and it now compiles and things boot.  I haven't
tested the deferral case in ToT yet, though.  I'll try that now and
post if something weird comes up.

-Doug
