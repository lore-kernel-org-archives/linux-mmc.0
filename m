From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [EXT] Re: [PATCH v2] mmc: core: add mmc-card hardware reset
 enable support
Date: Tue, 20 Jun 2017 18:10:53 +0200
Message-ID: <CACRpkdak6ffeN0D4eTJV3cUeJ+T92rg9Pt6AnFMW=VzQ=59XVw@mail.gmail.com>
References: <1491895862-7952-1-git-send-email-richard.leitner@skidata.com>
 <CACRpkdaBrk91hh3JGZ0vcD3aXO+OHD41xwRKn9prPSOX_SXuWg@mail.gmail.com>
 <CAPDyKFoL5dbs_xKxaBGk2bqd2tOXrhG_SVcBoUpMetsKDdNXxQ@mail.gmail.com>
 <0a29de1a-2635-2bb8-808a-7b9a0197921a@skidata.com> <6b92d0af00024549a0d22dda039780dd@bowex36d.micron.com>
 <CACRpkdb92scfO=tghucfC3RqQpi9K6YSuavte_b-AxH4hS87rQ@mail.gmail.com> <dd844df4-ac50-daab-bc31-a636718227f5@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:34210 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdFTQKz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2017 12:10:55 -0400
Received: by mail-io0-f171.google.com with SMTP id i7so87755017ioe.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2017 09:10:55 -0700 (PDT)
In-Reply-To: <dd844df4-ac50-daab-bc31-a636718227f5@skidata.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Leitner <richard.leitner@skidata.com>
Cc: "Luca Porzio (lporzio)" <lporzio@micron.com>, Ulf Hansson <ulf.hansson@linaro.org>, Bart Van Assche <bart.vanassche@sandisk.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Richard Leitner <dev@g0hl1n.net>

On Tue, Jun 20, 2017 at 12:24 PM, Richard Leitner
<richard.leitner@skidata.com> wrote:

> Should we then add a warning/info message to the kernel if we have a
> reset gpio configured in the DT, but the eMMC hasn't this OTP bit set?

That makes a lot of sense. Because the situation is ambigous.
We provide the hardware to reset the card, but the card says it
does not accept a reset.

Yours,
Linus Walleij
