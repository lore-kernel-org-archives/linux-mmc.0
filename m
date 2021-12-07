Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3952C433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Dec 2021 07:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhLGHWG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Dec 2021 02:22:06 -0500
Received: from marcansoft.com ([212.63.210.85]:60692 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhLGHWD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 7 Dec 2021 02:22:03 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 18025419B4;
        Tue,  7 Dec 2021 07:18:27 +0000 (UTC)
Subject: Re: [PATCH 0/2] mmc: sdhci-pci-gli: GL9755: Quirks for Apple ARM
 platforms
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ben Chuang <benchuanggli@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        linux-mmc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
References: <20211207064019.61444-1-marcan@marcan.st>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <5723f5bc-f721-9976-d63d-2738233f62bd@marcan.st>
Date:   Tue, 7 Dec 2021 16:18:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211207064019.61444-1-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Argh, forgot to Cc Ben...

Ben, please let me know what you think about this series. I can resend 
it CCing you if you want, or you can also find it here:

https://lore.kernel.org/all/20211207064019.61444-1-marcan@marcan.st/

Sorry for missing the Cc...

-Hector

On 07/12/2021 15.40, Hector Martin wrote:
> Hi folks,
> 
> This short series adds a few quirks needed to make the card readers in
> Apple M1 Pro/Max MacBook laptops work properly.
> 
> The first patch should be straightforward; it just allows configuring
> the CD/WP polarity based on device tree settings. There is already a
> standard DT binding for this.
> 
> The second patch bugs me. I don't understand why this problem happens
> on these machines, and not on e.g. x86 laptops (which presumably work
> with this driver). 8/16-bit MMIO reads work fine on other PCIe devices
> on these machines, so it is not a generalized problem with the PCIe
> controller in these SoCs. The problem also happens when running macOS
> (it also uses 32-bit reads). Ben, is there any chance you might know
> of some vendor-specific knob somewhere that can fix this issue without
> requiring the MMIO read workaround? Interestingly, 8/16-bit writes
> work perfectly fine.
> 
> Hector Martin (2):
>    mmc: sdhci-pci-gli: GL9755: Support for CD/WP inversion on OF
>      platforms
>    mmc: sdhci-pci-gli: GL9755: Issue 8/16-bit MMIO reads as 32-bit reads.
> 
>   drivers/mmc/host/sdhci-pci-gli.c | 38 ++++++++++++++++++++++++++++++--
>   1 file changed, 36 insertions(+), 2 deletions(-)
> 

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
