From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/7] mac80211: Use debugfs_create_xul() helper
Date: Mon, 4 Nov 2019 08:39:35 +0100
Message-ID: <20191104073935.GA1292321@kroah.com>
References: <20191025094130.26033-1-geert+renesas@glider.be>
 <20191025094130.26033-3-geert+renesas@glider.be>
 <69baa44c928ae7f6ca1f4631b7beb6b2c2b1c033.camel@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <69baa44c928ae7f6ca1f4631b7beb6b2c2b1c033.camel@sipsolutions.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>, Ludovic Desroches <ludovic.desroches@microchip.com>, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Jaehoon Chung <jh80.chung@samsung.com>, "David S . Miller" <davem@davemloft.net>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Nov 04, 2019 at 08:28:57AM +0100, Johannes Berg wrote:
> On Fri, 2019-10-25 at 11:41 +0200, Geert Uytterhoeven wrote:
> > Use the new debugfs_create_xul() helper instead of open-coding the same
> > operation.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Sorry Greg, this slipped through on my side.
> 
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> 
> Do you prefer to take this to your tree still, or should I pick it up
> later once debugfs_create_xul() is available (to me)?

I can take it now, thanks!

greg k-h
