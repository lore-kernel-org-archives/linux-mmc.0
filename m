From: Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [EXT] Re: [PATCH v2] mmc: core: add mmc-card hardware reset
 enable support
Date: Tue, 20 Jun 2017 12:24:14 +0200
Message-ID: <dd844df4-ac50-daab-bc31-a636718227f5@skidata.com>
References: <1491895862-7952-1-git-send-email-richard.leitner@skidata.com>
 <CACRpkdaBrk91hh3JGZ0vcD3aXO+OHD41xwRKn9prPSOX_SXuWg@mail.gmail.com>
 <CAPDyKFoL5dbs_xKxaBGk2bqd2tOXrhG_SVcBoUpMetsKDdNXxQ@mail.gmail.com>
 <0a29de1a-2635-2bb8-808a-7b9a0197921a@skidata.com>
 <6b92d0af00024549a0d22dda039780dd@bowex36d.micron.com>
 <CACRpkdb92scfO=tghucfC3RqQpi9K6YSuavte_b-AxH4hS87rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail2.skidata.com ([91.230.2.91]:23855 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750925AbdFTKeX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 20 Jun 2017 06:34:23 -0400
In-Reply-To: <CACRpkdb92scfO=tghucfC3RqQpi9K6YSuavte_b-AxH4hS87rQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "Luca Porzio (lporzio)" <lporzio@micron.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Bart Van Assche <bart.vanassche@sandisk.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Richard Leitner <dev@g0hl1n.net>


On 06/20/2017 11:45 AM, Linus Walleij wrote:
>> IMHO mmc-util is where the patch really stands: the enabling is OTP,
>> the programmer have to use mmc-util only once and the kernel
>> will behave accordingly.
> 
> So we should not add it to the device tree.
> 
>> Any platform vendor must check that the HW Reset pin is actually
>> Connected BEFORE enabling this feature otherwise the system may be
>> unstable. A DT Binding may be dangerous if this condition is not met
>> as well as the code execution at each MMC init is honestly redundant
>> for an OTP location of the extCSD.
> 
> I agree. So the device should be configured during production, or
> a user who know exactly what they are doing may reconfigure it
> using the mmc-utils.
> 
> Thus the kernel should just read what the device says and stay with
> that, no DT props or anything.

Ok. Thanks for that clarification to everybody involved!

Should we then add a warning/info message to the kernel if we have a
reset gpio configured in the DT, but the eMMC hasn't this OTP bit set?

Or should we just leave it as it is? (Due to the fact the reset-gpio
could be connected to an external reset chip?)

kind regards,
Richard.L
