From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 11/15] wireless: wl1271: introduce platform device support
Date: Tue, 6 Jul 2010 15:53:03 +0300
Message-ID: <AANLkTin5W52fPzWToRrAzm56SLZI-taSuI16rCEhLWqH@mail.gmail.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-12-git-send-email-ohad@wizery.com> <4C32EF19.1000604@nokia.com>
	<AANLkTintIz-N7MwwtqhVq2LR3Ln5JTNYSbJUBSSClcA-@mail.gmail.com>
	<4C3306F4.8060907@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4C3306F4.8060907@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Roger Quadros <roger.quadros@nokia.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Chikkature Rajashekar Madhusudhan <madhu.cr@ti.com>, "Coelho Luciano (Nokia-MS/Helsinki)" <Luciano.Coelho@nokia.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, San Mehat <san@google.com>
List-Id: linux-mmc@vger.kernel.org

Hi Roger,

On Tue, Jul 6, 2010 at 1:35 PM, Roger Quadros <roger.quadros@nokia.com> wrote:
> My point is that shouldn't this be handled by SDIO core?

Care to explain what you mean / give a code example ?

> If there are no users for the SDIO function and the card, doesn't the SDIO
> core power down the slot and take care of re-initialization when it is
> powered up?

You need card detect events in order to trigger card & sdio function
initialization and removals.

Please share any alternative approach you may be thinking on.

Thanks,
Ohad.


>
