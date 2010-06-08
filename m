From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 2/2] mmc: fix mmc card disappearence on resume on ricoh
	mmc controllers
Date: Tue, 08 Jun 2010 11:57:46 +0300
Message-ID: <1275987466.30596.13.camel@dell16>
References: <1275859475.3151.4.camel@maxim-laptop>
	 <1275859731-2898-2-git-send-email-maximlevitsky@gmail.com>
	 <648846745cc9a3a023fa12f306caabf6@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53560 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206Ab0FHI54 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2010 04:57:56 -0400
In-Reply-To: <648846745cc9a3a023fa12f306caabf6@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Langdale <philipl@overt.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On Sun, 2010-06-06 at 19:22 -0400, Philip Langdale wrote:
> On Mon,  7 Jun 2010 00:28:51 +0300, Maxim Levitsky
> <maximlevitsky@gmail.com> wrote:
> > The reason was that it takes time for controller to detect the card.
> > So wait a bit for the card to appear.
> > In worst case scenario, when you suspend the system with mmc card,
> > and actually remove it, the resume will be delayed maximum by 2 seconds
> 
> I suspect it's probably sending an SD id command to the card and then that
> has to time out on MMC cards.
> 
> Acked-by: Philip Langdale <philipl@overt.org>

Thanks!

Note that I spoke too soon about it being perfect
While mmc card that stays in slot now works fine, a card that is
inserted while system is asleep, is detected, but then controller
becomes confused, so card doesn't work. A reinsert does help though.
Overall I need to work around some unusual delays imposed by controller
due to unusual card detection.
I'll sort that out eventually (and hope not to bring much ugliness to
sdhci{,-pci}.c

I think I update this patch to address both issues.

Best regards,
	Maxim Levitsky

