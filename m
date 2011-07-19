From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 0/4] Add device tree probe for sdhci-esdhc-imx
Date: Mon, 18 Jul 2011 21:51:28 -0400
Message-ID: <m262mzavhb.fsf@bob.laptop.org>
References: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org>
	<m2pqljje3w.fsf@bob.laptop.org>
	<20110710013708.GA14492@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110710013708.GA14492@S2100-06.ap.freescale.net> (Shawn Guo's
	message of "Sun, 10 Jul 2011 09:37:09 +0800")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Shawn, Sascha,

On Sat, Jul 09 2011, Shawn Guo wrote:
>> > Shawn Guo (4):
>> >       mmc: sdhci-esdhc-imx: do not reference platform data after probe
>> >       mmc: sdhci-esdhc-imx: get rid of the uses of cpu_is_mx()
>> >       mmc: sdhci-pltfm: dt device does not pass parent to sdhci_alloc_host
>> >       mmc: sdhci-esdhc-imx: add device tree probe support
>> 
>> These don't apply against mmc-next -- what is your tree based on?
>> 
> It's based on linux-next with following patch applied.
>
> [PATCH v4 4/4] mmc: sdhci-esdhc-imx: extend card_detect and
> write_protect support for mx5
> http://permalink.gmane.org/gmane.linux.kernel.mmc/8748
>
> You applied the 3 of 4 patches in that series, and expect Sascha to
> send this one through his tree after you send those 3.

I see.  In that case, either Sascha can send this new series with my:

Acked-by: Chris Ball <cjb@laptop.org>

or I'll send it as a second pull request after Sascha sends [4/4].

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
