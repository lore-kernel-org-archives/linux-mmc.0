From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: add fixed divider for ciu_clk on SoCFPGA
Date: Fri, 10 Apr 2015 08:15:25 -0700
Message-ID: <CAD=FV=V9biPquZN+oejF0s4poqRi+-CT99AiXDfJa5R4LQPOZA@mail.gmail.com>
References: <1428674162-11200-1-git-send-email-dinguyen@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34620 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932552AbbDJPPc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Apr 2015 11:15:32 -0400
Received: by obbry2 with SMTP id ry2so19105916obb.1
        for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2015 08:15:31 -0700 (PDT)
In-Reply-To: <1428674162-11200-1-git-send-email-dinguyen@opensource.altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dinh Nguyen <dinguyen@opensource.altera.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Dinh Nguyen <dinh.linux@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, setka@vsis.cz, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Alexandru Stan <amstan@chromium.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>

Dinh,

On Fri, Apr 10, 2015 at 6:56 AM,  <dinguyen@opensource.altera.com> wrote:
> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>
> The ciu_clk(Card Interface Unit Clock) on the SoCFPGA platform has a fixed
> divider of 4. Add the fixed clock divide code in the platform's clock
> setup code.

It might actually be better to do this a different way for SoCFPGA.  I
sorta wish we had done it differently for Rockchip as well, but at
this point you end up with the complexity of changing device tree
bindings in conjunction with code and it gets ugly.

Specifically, you've probably got the following clocks:

SD_prediv = 400MHz
-> SD postdiv = 100MHz
-> SD sample = 100MHz, shifted
-> SD drive = 100MHz, shifted

Right now you're specifying "SD_prediv" as the SD card clock.  If you
instead expose "SD postdiv" as a new clock (from your clock driver)
that is "SD prediv" divided by 4 then you'll magically get all the
behavior that you want with no modifications to dw_mmc.  Just make
sure that "SD postdiv" passes on rate changes to its parent (that's
just a flag in the common clock framework).


At some point in time you'll also want to expose the sample and drive
clocks once you get UHS modes working.  Alexandru posted some patches
for this a while ago to support tuning in dw_mmc using just drive and
sample clocks, but the patch still needed some more work.  Either he
or I will probably pick it up again soon.

-Doug
