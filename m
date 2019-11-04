From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2 2/7] mac80211: Use debugfs_create_xul() helper
Date: Mon, 04 Nov 2019 08:28:57 +0100
Message-ID: <69baa44c928ae7f6ca1f4631b7beb6b2c2b1c033.camel@sipsolutions.net>
References: <20191025094130.26033-1-geert+renesas@glider.be>
         <20191025094130.26033-3-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191025094130.26033-3-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Jaehoon Chung <jh80.chung@samsung.com>, "David S . Miller" <davem@davemloft.net>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, 2019-10-25 at 11:41 +0200, Geert Uytterhoeven wrote:
> Use the new debugfs_create_xul() helper instead of open-coding the same
> operation.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Sorry Greg, this slipped through on my side.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

Do you prefer to take this to your tree still, or should I pick it up
later once debugfs_create_xul() is available (to me)?

johannes
