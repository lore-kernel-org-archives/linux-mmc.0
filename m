From: "Andrew Jeffery" <andrew@aj.id.au>
Subject: Re: [PATCH v3 1/3] aspeed: dts: add sd card for vesnin
Date: Wed, 20 Nov 2019 16:39:25 +1030
Message-ID: <ebe4c175-a1a0-47d3-9c01-1dfeeffc97e5@www.fastmail.com>
References: <20191118104646.3838-1-i.mikhaylov@yadro.com>
 <20191118104646.3838-2-i.mikhaylov@yadro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191118104646.3838-2-i.mikhaylov@yadro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc: Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, openbmc@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org



On Mon, 18 Nov 2019, at 21:16, Ivan Mikhaylov wrote:
> Presence signal is inverted for vesnin boards, 'cd-inverted' added
> for invertion signal enablement. Vesnin BMC uses microSD, there is
> no WP switch, 'disable-wp' is used for this purpose.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
