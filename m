From: "Andrew Jeffery" <andrew@aj.id.au>
Subject: =?UTF-8?Q?Re:_[PATCH_v3_2/3]_mmc:_sdhci-of-aspeed:_enable_CONFIG=5FMMC=5F?=
 =?UTF-8?Q?SDHCI=5FIO=5FACCESSORS?=
Date: Wed, 20 Nov 2019 16:38:32 +1030
Message-ID: <794a7661-b4c1-46eb-bc78-79e7358ff999@www.fastmail.com>
References: <20191118104646.3838-1-i.mikhaylov@yadro.com>
 <20191118104646.3838-3-i.mikhaylov@yadro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191118104646.3838-3-i.mikhaylov@yadro.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org



On Mon, 18 Nov 2019, at 21:16, Ivan Mikhaylov wrote:
> Enable CONFIG_MMC_SDHCI_IO_ACCESSORS on the aspeed board. 

s/on the aspeed board/for the ASPEED MMC driver/

but otherwise:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
