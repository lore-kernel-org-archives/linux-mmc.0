From: "Andrew Jeffery" <andrew@aj.id.au>
Subject: =?UTF-8?Q?Re:_[PATCH_v3_3/3]_mmc:_sdhci-of-aspeed:_add_inversion_signal_?=
 =?UTF-8?Q?presence?=
Date: Wed, 20 Nov 2019 16:36:55 +1030
Message-ID: <b525ea84-aaa0-45b3-95fd-a1b3518511b3@www.fastmail.com>
References: <20191118104646.3838-1-i.mikhaylov@yadro.com>
 <20191118104646.3838-4-i.mikhaylov@yadro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191118104646.3838-4-i.mikhaylov@yadro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc: Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, openbmc@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 18 Nov 2019, at 21:16, Ivan Mikhaylov wrote:
> Add read_l callback in sdhci_ops with flipping of SDHCI_CARD_PRESENT
> bit in case of inverted card detection signal.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
