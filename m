From: Ben Nizette <bn@niasdigital.com>
Subject: Re: [PATCH 3/3 v2] at91/atmel-mci: inclusion of sd/mmc driver in
 at91sam9g45 chip and board
Date: Tue, 03 Nov 2009 13:55:43 +1100
Message-ID: <1257216943.4358.66.camel@ben-desktop>
References: <acfa557032a93e2d3186981b16f7048a5a31028a.1256314995.git.nicolas.ferre@atmel.com>
	 <20090930155557.7dae503b@hskinnemoen-d830>
	 <a3b1332815576dc4d496937b8a5ab69d36818d00.1256314995.git.nicolas.ferre@atmel.com>
	 <cd73a99e0910271243x744c956bl598fef9fd4144840@mail.gmail.com>
	 <20091028083548.38f1d80c@hskinnemoen-d830>
	 <d6cda7730910271753o54acfa04t1225de460083325f@mail.gmail.com>
	 <cd73a99e0910281253x1bb72b74p47cb5110efb0871f@mail.gmail.com>
	 <1256763057.4362.36.camel@ben-desktop> <4AEF12B7.3040704@atmel.com>
	 <4AEF95E0.7040602@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from outbound.icp-qv1-irony-out5.iinet.net.au ([203.59.1.105]:57306
	"EHLO outbound.icp-qv1-irony-out5.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756308AbZKCCza (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Nov 2009 21:55:30 -0500
In-Reply-To: <4AEF95E0.7040602@bluewatersys.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Andrew Victor <avictor.za@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, "\"\\\"Thiago A.\\\" =?ISO-8859-1?Q?Corr=EAa=22?=" <thiago.correa@gmail.com>, kernel@avr32linux.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, David Brownell <david-b@pacbell.net>, David Brownell <dbrownell@users.sourceforge.net>

On Tue, 2009-11-03 at 15:30 +1300, Ryan Mallon wrote:
> > 
> IIRC, we can't mark static inline functions as weak, and we don't want
> to turn gpio_is_valid into an actual function call. We could do some
> preprocessor magic, but that gets a bit messy.

Messy but generally accepted.

Have a grep for, eg, __HAVE_ARCH_<string functions> and
HAVE_ARCH_BUG{_ON}

	--Ben.

