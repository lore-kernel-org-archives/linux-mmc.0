From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 2/2] mmc: fix mmc card disappearence on resume on ricoh
	mmc controllers
Date: Tue, 08 Jun 2010 11:52:36 +0300
Message-ID: <1275987156.30596.6.camel@dell16>
References: <1275859475.3151.4.camel@maxim-laptop>
	 <1275859731-2898-2-git-send-email-maximlevitsky@gmail.com>
	 <20100606232313.GA5444@void.printf.net>
	 <1275870795.24091.4.camel@maxim-laptop>
	 <m3bpbn1jjf.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65090 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045Ab0FHIwk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2010 04:52:40 -0400
In-Reply-To: <m3bpbn1jjf.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Philip Langdale <philipl@overt.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Mon, 2010-06-07 at 01:47 -0400, Chris Ball wrote:
> Hi Maxim,
> 
>    >> It looks like your editor is set to four-space instead of
>    >> eight-space tab characters, else you wouldn't be using so
>    >> many tabs here.
> 
>    > Nope, I think indention is right here.
>    >
>    > the break is inside 'if' condition.
> 
> Please look again, I think you're mistaken.  For example, why do you
> use seven tab characters for the "& SDHCI_CARD_PRESENT" after the if
> line?  With eight-space tabs, it looks like this (converted to
> spaces):
> 
> +                       if (sdhci_readl(host, SDHCI_PRESENT_STATE)
> +                                                       & SDHCI_CARD_PRESENT) {
Ah, this.

I just break the line to avoid hitting the 80 char limit...

You probably meant I need to write:

+                       if (sdhci_readl(host, SDHCI_PRESENT_STATE)
+                                & SDHCI_CARD_PRESENT) {

Nothing against it,

Best regards,
	Maxim Levitsky

