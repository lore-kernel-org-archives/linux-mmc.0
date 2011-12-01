From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Fixup error handling for dma
Date: Thu, 1 Dec 2011 14:01:46 +0100
Message-ID: <CACRpkdacJxbFvSuXTsxtjZVbeTaJwNN4xy7-rvpa0U0Z4pDE_g@mail.gmail.com>
References: <1322578286-18727-1-git-send-email-ulf.hansson@stericsson.com>
	<20111130222139.GW9581@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60114 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527Ab1LANBr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2011 08:01:47 -0500
Received: by iage36 with SMTP id e36so2457005iag.19
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2011 05:01:46 -0800 (PST)
In-Reply-To: <20111130222139.GW9581@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Per Forlin <per.forlin@stericsson.com>

On Wed, Nov 30, 2011 at 11:21 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

>> =A0 =A0 =A0 if (!cmd->data || cmd->error) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (host->data)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->data) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Terminate the DMA trans=
fer */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dma_inprogress(host))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmci_dma_d=
ata_error(host);
>
> Doesn't this leave the DMA buffers mapped?

Yep it needs an mmci_dma_unmap() call too AFAICT,
Ulf will you update?

Yours,
Linus Walleij
