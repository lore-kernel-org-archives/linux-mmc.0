From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] mmc: mmci: Allow MMCI to request channels with
 information acquired from DT
Date: Thu, 23 May 2013 21:00:51 +0200
Message-ID: <CACRpkdbr4Lm4NGHzX4TTq4fYwFahwC82fQSBg_V=SGVKkqFdUg@mail.gmail.com>
References: <1366801122-13302-1-git-send-email-lee.jones@linaro.org>
	<20130424155547.GA4623@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130424155547.GA4623@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linus WALLEIJ <linus.walleij@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Apr 24, 2013 at 5:55 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Currently, if DMA information isn't passed from platform data, then DMA
> will not be used. This patch allows DMA information obtained though Device
> Tree to be used as well.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I've now tested this v2 version with device tree on Nomadik and
U300 and it works like a charm.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
