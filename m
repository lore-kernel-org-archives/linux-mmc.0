From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 00/18] Export SPI and OF module aliases in missing drivers
Date: Thu, 20 Aug 2015 14:11:52 -0700
Message-ID: <20150820211152.GI74600@google.com>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
Sender: netdev-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>, linux-fbdev@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, linux-wireless@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-mtd@lists.infradead.org, Lauro Ramos Venancio <lauro.venancio@openbossa.org>, =?iso-8859-1?Q?S=F8ren?= Andersen <san@rosetechnology.dk>, devel@driverdev.osuosl.org, Randy Dunlap <rdunlap@infradead.org>, Masanari Iida <standby24x7@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Devendra Naga <devendra.aaru@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Aloisio Almeida Jr <aloisio.almeida@openbossa.org>, Jonathan Cameron <jic23@kernel>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 20, 2015 at 09:07:13AM +0200, Javier Martinez Canillas wrote:
> Patches #1 and #2 solves a), patches #3 to #8 solves b) and patches

^^^ I'm dying to know how this sentence ends :)

> Patch #18 changes the logic of spi_uevent() to report an OF modalias if
> the device was registered using OF. But this patch is included in the
> series only as an RFC for illustration purposes since changing that
> without first applying all the other patches in this series, will break
> module autoloading for the drivers of devices registered using OF but
> that lacks an of_match_table. I'll repost patch #18 once all the patches
> in this series have landed.

On a more productive note, the patches I've looked at look good to me.
The missing aliases are a problem enough that should be fixed (i.e.,
part (b)). I'll leave the SPI framework changes to others to comment on.

Brian
