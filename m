From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH V2 00/15] a few sdhci/imx clean up and fix patches
Date: Wed, 13 Jul 2016 15:40:53 +0200
Message-ID: <20160713134053.GB6667@lunn.ch>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
 <20160712135422.GE8540@lunn.ch> <20160713085438.GA27041@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160713085438.GA27041@shlinux2>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, chris@printf.net, haibo.chen@nxp.com, adrian.hunter@intel.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

> Thanks for the suggestion.
> I think except patch 2 (mmc: sdhci-esdhc-imx: remove SDHCI_QUIRK_BROKEN_TIMEOUT_VAL)
> which is only a one line change, all others are good to be cherry-picked
> into stable.

You need to be very explicit about what you want going into
stable. Otherwise none of them will end up in stable.

Documentation/SubmittingPatches says you should include a Fixes: tag
in each patch indicating when the bug you are fixing was added to the
kernel. You should also be including Cc: stable@vger.kernel.org.

	Andrew
