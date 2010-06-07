From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: fix mmc card disappearence on resume on ricoh mmc controllers
Date: Mon, 07 Jun 2010 01:47:00 -0400
Message-ID: <m3bpbn1jjf.fsf@pullcord.laptop.org>
References: <1275859475.3151.4.camel@maxim-laptop>
	<1275859731-2898-2-git-send-email-maximlevitsky@gmail.com>
	<20100606232313.GA5444@void.printf.net>
	<1275870795.24091.4.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1275870795.24091.4.camel@maxim-laptop> (Maxim Levitsky's message
	of "Mon, 07 Jun 2010 03:33:15 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Philip Langdale <philipl@overt.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Maxim,

   >> It looks like your editor is set to four-space instead of
   >> eight-space tab characters, else you wouldn't be using so
   >> many tabs here.

   > Nope, I think indention is right here.
   >
   > the break is inside 'if' condition.

Please look again, I think you're mistaken.  For example, why do you
use seven tab characters for the "& SDHCI_CARD_PRESENT" after the if
line?  With eight-space tabs, it looks like this (converted to
spaces):

+                       if (sdhci_readl(host, SDHCI_PRESENT_STATE)
+                                                       & SDHCI_CARD_PRESENT) {

See http://lkml.org/lkml/2010/6/6/171 for an eight-space tabs
rendering of the patch.

-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
