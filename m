From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 00/12] treewide: Fix GENMASK misuses
Date: Wed, 10 Jul 2019 11:17:31 +0200
Message-ID: <5fa1fa6998332642c49e2d5209193ffe2713f333.camel@sipsolutions.net>
References: <cover.1562734889.git.joe@perches.com>
         (sfid-20190710_070546_627944_047EEDD0)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1562734889.git.joe@perches.com> (sfid-20190710_070546_627944_047EEDD0)
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, netdev@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-wireless@vger.kernel.org, linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org, devel@driverdev.osuosl.org, alsa-devel@alsa-project.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 2019-07-09 at 22:04 -0700, Joe Perches wrote:
> These GENMASK uses are inverted argument order and the
> actual masks produced are incorrect.  Fix them.
> 
> Add checkpatch tests to help avoid more misuses too.
> 
> Joe Perches (12):
>   checkpatch: Add GENMASK tests

IMHO this doesn't make a lot of sense as a checkpatch test - just throw
in a BUILD_BUG_ON()?

johannes
