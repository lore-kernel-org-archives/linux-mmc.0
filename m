From: Ben Nizette <bn@niasdigital.com>
Subject: Re: [PATCH] mmc: Reduce fOD to 200 kHz if possible
Date: Wed, 15 Sep 2010 19:50:08 +1000
Message-ID: <9348108E-1108-46FE-8437-6F1271025C61@niasdigital.com>
References: <1284541140-7328-1-git-send-email-haavard.skinnemoen@atmel.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1284541140-7328-1-git-send-email-haavard.skinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org


On 15/09/2010, at 6:59 PM, Haavard Skinnemoen wrote:

> Since the identification frequency was increased to 400 kHz, my
> ATSTK1000 board has not been able to initialize any MMC or SD cards.
> Reducing the identification mode frequency to 200 kHz fixes the problem.
> 
> This is definitely a board-specific issue, probably due to weak pull-up
> resistor values, but this is the simplest fix I could come up with.

I wonder whether there's an Atmel reference schematic around with an incorrect resistor value on it, the only three people I know affected by this are myself, Hein Tibosch and you, all on AVR32.  We've now submitted one fix each, mine was similar to yours [1] but there's been movement on Hein's more comprehensive patch recently [2].  I don't know who's supposed to be merging MMC patches atm, Chris Ball added on CC on a hunch.

	--Ben.

[1] http://lkml.org/lkml/2010/1/1/85
[2] http://lkml.org/lkml/2010/9/2/494