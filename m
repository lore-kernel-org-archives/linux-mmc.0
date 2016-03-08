From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH RESEND V3 2/2] mmc: sdhci-brcmstb: Add driver for Broadcom
 BRCMSTB SoCs
Date: Mon, 7 Mar 2016 18:54:53 -0800
Message-ID: <CAJiQ=7ATvz8nVFtckrKW5n64WOpAt8eMA_S5tQDwDAw+LZ8gZg@mail.gmail.com>
References: <1457114844-18841-1-git-send-email-alcooperx@gmail.com>
 <CAJiQ=7D2A=6-e-2K8xePR5SeQENsUUVVLyPDSvVK=x_m5nfrAw@mail.gmail.com> <CAOGqxeVz3L9nFTX_0BArDu1q_EAKAb3nMXRDQ3tsdPg-wmuZAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:35427 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbcCHCzN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2016 21:55:13 -0500
Received: by mail-io0-f196.google.com with SMTP id n190so916900iof.2
        for <linux-mmc@vger.kernel.org>; Mon, 07 Mar 2016 18:55:13 -0800 (PST)
In-Reply-To: <CAOGqxeVz3L9nFTX_0BArDu1q_EAKAb3nMXRDQ3tsdPg-wmuZAw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cooper <alcooperx@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, adrian.hunter@intel.com, linux-mmc <linux-mmc@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com

On Mon, Mar 7, 2016 at 1:32 PM, Alan Cooper <alcooperx@gmail.com> wrote:
>> When the hardware block changes frequently, we've gone as far as
>> creating a different compatible string for each variant.  For
>> Documentation/devicetree/bindings/net/brcm,bcmgenet.txt we encoded the
>> hardware generation number in the compatible string.
>
> Something like "brcm,bcm7425-sdhci"?

That sounds like a reasonable approximation.  Several major design
issues like IRQs and endianness got cleaned up in the 40nm generation
(although IIRC there were still a lot of fresh bugs in every new
chip).
