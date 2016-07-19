From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V8 2/2] mmc: OCTEON: Add host driver for OCTEON MMC controller.
Date: Tue, 19 Jul 2016 23:19:43 +0200
Message-ID: <CAPDyKFqb-7LLM0XPtVWj1qHib991E2dHt+6W0UPgbXnukGkmXA@mail.gmail.com>
References: <57853474.9050108@cavium.com> <578E71E6.2020700@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38815 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbcGSVTq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jul 2016 17:19:46 -0400
Received: by mail-wm0-f49.google.com with SMTP id o80so42044380wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jul 2016 14:19:45 -0700 (PDT)
In-Reply-To: <578E71E6.2020700@caviumnetworks.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Steven J. Hill" <Steven.Hill@caviumnetworks.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>

On 19 July 2016 at 20:31, Steven J. Hill <Steven.Hill@caviumnetworks.com> wrote:
> On 07/12/2016 01:18 PM, Steven J. Hill wrote:
>>
>> The OCTEON MMC controller is currently found on cn61XX and cn71XX
>> devices. Device parameters are configured from device tree data.
>> eMMC, MMC and SD devices are supported. Tested on Rhino labs UTM8
>> and Cavium CN7130 board.
>>
>> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
>> Acked-by: David Daney <david.daney@cavium.com>
>>
> Has anyone reviewed the driver or have any comments? Thanks.

Sorry I need more time, been partly out of office lately.
I intend to review this prior rc1 is out, but no promises.

Kind regards
Uffe
