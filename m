Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554F8C4320A
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Aug 2021 08:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A6E761038
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Aug 2021 08:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhH3Irv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Aug 2021 04:47:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232482AbhH3Iru (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 30 Aug 2021 04:47:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B33F60FF2;
        Mon, 30 Aug 2021 08:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630313217;
        bh=86uCRhIjOeIQZbbPEzaBNC7C489OiOyddNrCFh7l5n8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=h213Ih22ABWJjEnvfz4mg+cza2J/eEiQbC/75LHeVTz9rGO9gdmmCdqTo/Ld0tXNM
         ne3hTxi6YhQgtdDZ8TrGvaAmWI/ge2dVT5LSPttT0KNJy8lvzhnDoWk050L8g5P5aK
         S5ujN8Re/Zy2AZ6L3RqK9meM7Xqj0cogIKxeyGyrWo4qpHxCIgmSZzVC8Y5AHTd5wE
         pSatA99MNvKSJKSs1IzasYhOipw2JdVCdAaDvO3R8SczKhe7WOZGaZ+eHXMebkLm4X
         d1tZuc0iv098N/qjixPdyCdCxVLlctTbzZPSDtlh/PcwMAxZ7VtPnQk09jPT6nvS0E
         XZ4CLJMtXX28g==
Message-ID: <04fa9c4bc7fc87377c9f392dea0761591bb85616.camel@kernel.org>
Subject: Re: [PATCH V2 00/10] ARM: dts: Add Raspberry Pi CM4 & CM4 IO Board
 support
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, iivanov@suse.de,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Mon, 30 Aug 2021 10:46:53 +0200
In-Reply-To: <fb80f7a5-8fd4-73e3-4c64-77f120546cc4@gmail.com>
References: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
         <fb80f7a5-8fd4-73e3-4c64-77f120546cc4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Florian,

On Sun, 2021-08-22 at 12:31 +0200, Florian Fainelli wrote:
> 
> On 8/7/2021 1:06 PM, Stefan Wahren wrote:
> > This series add support for the Raspberry Pi Compute Module 4 and its
> > IO board.
> > 
> > Changes in V2:
> > - drop emmc2bus patch as it affects userspace (thanks to Marc Zyngier)
> > - tested with CM4 and integrate sdhci patches from Nicolas (just include kHz fixups)
> > - add Rob's Acked-by
> > - add HS200 property to emmc2 node for a slight performance gain
> > - move antenna comment to the proper position
> 
> Nicolas, I am assuming you will be picking up these patches and submit a 
> BCM283x pull request with them. Thanks!

Yes, sorry for the late replies. I'm just back from vacation.

Regards,
Nicolas

