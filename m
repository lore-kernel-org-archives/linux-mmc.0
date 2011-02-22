From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH V2 0/5] sdhci-esdhc-imx: use gpio for write protection and
	card detection
Date: Tue, 22 Feb 2011 15:52:07 +0100
Message-ID: <87wrks5dgo.fsf@lebrac.rtp-net.org>
References: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
	(Wolfram Sang's message of "Tue, 22 Feb 2011 13:58:15 +0100")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>
List-Id: linux-mmc@vger.kernel.org

Wolfram Sang <w.sang@pengutronix.de> writes:

> Hi,

Hi,

>
> Second version of my series, no major changes:
>
> * rephrased warnings
> * collected some tags
> * rebased to mmc/mmc-next as of today
>
> Eric wanted to tested these patches soonish. Thanks to Marc for testing the
> first three already.

Has this been tested on imx51 ? By default (even after applying your
patches), the sdhci has quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION set, so
we're polling.
I've been wondering if it was a good idea to configure for everyone sdhc
host card detect pin as gpio 1 1 or gpio 1 8 on imx51, which would mean
no more polling. What do you think ? Would it be working or it's just a
stupid idea ?

Arnaud
