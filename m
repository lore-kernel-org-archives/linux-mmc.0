From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 00/12] treewide: Fix GENMASK misuses
Date: Thu, 11 Jul 2019 14:30:52 -0700 (PDT)
Message-ID: <20190711.143052.1773408891723438773.davem@davemloft.net>
References: <cover.1562734889.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1562734889.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joe@perches.com
Cc: akpm@linux-foundation.org, venture@google.com, yuenn@google.com, benjaminfair@google.com, andrew@aj.id.au, openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, netdev@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-wireless@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org, devel@driverdev.osuosl.org, alsa-devel@alsa-project.org
List-Id: linux-mmc@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Tue,  9 Jul 2019 22:04:13 -0700

> These GENMASK uses are inverted argument order and the
> actual masks produced are incorrect.  Fix them.
> 
> Add checkpatch tests to help avoid more misuses too.

Patches #7 and #8 applied to 'net', with appropriate Fixes tags
added to #8.
