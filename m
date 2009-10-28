From: Andrew Victor <avictor.za@gmail.com>
Subject: Re: [PATCH 3/3 v2] at91/atmel-mci: inclusion of sd/mmc driver in
	at91sam9g45 chip and board
Date: Wed, 28 Oct 2009 21:53:03 +0200
Message-ID: <cd73a99e0910281253x1bb72b74p47cb5110efb0871f@mail.gmail.com>
References: <acfa557032a93e2d3186981b16f7048a5a31028a.1256314995.git.nicolas.ferre@atmel.com>
	 <20090930155557.7dae503b@hskinnemoen-d830>
	 <a3b1332815576dc4d496937b8a5ab69d36818d00.1256314995.git.nicolas.ferre@atmel.com>
	 <cd73a99e0910271243x744c956bl598fef9fd4144840@mail.gmail.com>
	 <20091028083548.38f1d80c@hskinnemoen-d830>
	 <d6cda7730910271753o54acfa04t1225de460083325f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:23902 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102AbZJ1TxP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Oct 2009 15:53:15 -0400
In-Reply-To: <d6cda7730910271753o54acfa04t1225de460083325f@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Thiago_A=2E_Corr=EAa?= <thiago.correa@gmail.com>
Cc: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-mmc@vger.kernel.org, kernel@avr32linux.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org

hi,

> Then I think it would be best to use GPIO_PIN_NONE. Makes it clear
> what is expected and avoids confusion on what should be the proper
> value.
> I hope I'm not saying non-sense, but even if I am, I guess you can see
> that I'm advocating against the magic numbers :)

What magic numbers ?

If you have a "wp_pin" on the board, you declare the struct as:
    static struct mci_platform_data __initdata mci0_data = {
          .slot[0] = {
                 .bus_width      = 4,
                 .detect_pin     = AT91_PIN_PD10,
        }
    }

and if you do have a "wp_pin" on your board, you declare the struct as:
    static struct mci_platform_data __initdata mci0_data = {
          .slot[0] = {
                 .bus_width      = 4,
                 .detect_pin     = AT91_PIN_PD10,
                 .wp_pin          = AT91_PIN_PD11,
        }
    }

And it's more future-proof.  If the next version of the
driver/peripheral has a "toggle_pin" GPIO option, you don't need to go
update all board files with a ".toggle_pin  = GPIO_PIN_NONE"   or
".toggle_pin = -ENODEV".


Regards,
  Andrew Victor
