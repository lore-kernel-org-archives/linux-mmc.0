From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: RE: [PATCH V2 1/1] mmc: start removing enable / disable API
Date: Wed, 29 Feb 2012 12:01:23 +0000
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3176DB55@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Chris Ball <cjb@laptop.org>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Feb 29, 2012 at 12:47:21, Adrian Hunter wrote:
> Most parts of the enable / disable API are no longer used and
> can be removed.
> 
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Venkatraman S <svenkatr@ti.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Tested this on OMAP-L138 EVM using SD card
1) Card gets detected and able mount partitions.
2) Able to read/write to mounted partitions.
3) Able to perform above steps after suspend/resume cycle.

Tested-by: Manjunathappa, Prakash <prakash.pm@ti.com>

Thanks,
Prakash


