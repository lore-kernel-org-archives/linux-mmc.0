From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/6] mmc: sdhci: add platform set_timeout hook
Date: Wed, 11 Dec 2013 11:48:26 +0800
Message-ID: <20131211034824.GH18380@S2101-09.ap.freescale.net>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
 <1386680168-5227-4-git-send-email-b29396@freescale.com>
 <20131211021646.GC18380@S2101-09.ap.freescale.net>
 <CAA+hA=T6WN93=RgNUKkjJjMj6WpGbk0pnTpZvYLEUtOgMGv7Kg@mail.gmail.com>
 <20131211031853.GG18380@S2101-09.ap.freescale.net>
 <CAA+hA=STB-M5H9VsFjx4bqgbdPAAzgbChVY4JrsGdBKqYnmGkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAA+hA=STB-M5H9VsFjx4bqgbdPAAzgbChVY4JrsGdBKqYnmGkA@mail.gmail.com>
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ed Sutter <ed.sutter@alcatel-lucent.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, adrian.hunter@intel.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <cjb@laptop.org>, Dong Aisheng <b29396@freescale.com>, vladimir_zapolskiy@mentor.com
List-Id: linux-mmc@vger.kernel.org

On Wed, Dec 11, 2013 at 11:35:17AM +0800, Dong Aisheng wrote:
> This actually is the register value, not the max timeout counter value.
> Then you may want define the API as:
> unsigned int    (*get_max_timeout_val)(struct sdhci_host *host);

Yes, something like that.

> But i don't think it's necessary to do the max timeout setting in two steps.
> First, deinfe a API to get the max timeout counter val,
> Second, write this val into register.
> Why not simply implement .set_timeout and handle the details in
> platform specific
> host driver respectively?

Well, that's how sdhci host driver is structured.  Doing so leaves the
least details to platform driver, and calling sdhci_writeb() to access
SDHCI_TIMEOUT_CONTROL in sdhci-esdhc-imx seems a layer violation to me.

> 
> Furthermore, this API does not  help for the patch#1 issue.

Oh, they two different issues, and should be addressed by different
hooks.

Shawn
